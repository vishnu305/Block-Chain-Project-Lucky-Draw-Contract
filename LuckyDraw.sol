pragma solidity >=0.5.0;

contract LuckyDraw{
    
    address payable public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    struct Players{
        address payable player_address;
    }
    
    Players[] public  allplayers;
    
   
    modifier onlyOwner(){
        require(msg.sender == owner,"Your are not Owner!");
        _;
    }
    modifier notOwner(){
        require(msg.sender != owner,"Owner can't participate!");
        _;
    }
    
    function joinLottery() payable public notOwner{
        require(msg.value == 2 ether,"Insufficient Fees!");
        require(allplayers.length < 4,"No new Vacancies!");
        allplayers.push(Players(msg.sender));
        
    }
    function pickWinner(uint a) external onlyOwner{
        require(allplayers.length > 1,"There are no enought players to pick the winner");
        require(a <= allplayers.length,"There are less no. of players so please select a lesser value than 4");
        require(a != 0,"Select between 1 and 4 only");
        // allplayers[_a-1].transfer(address(this).balance);
        allplayers[a-1].player_address.transfer(address(this).balance);
    }
    
}