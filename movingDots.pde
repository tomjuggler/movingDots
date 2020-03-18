int nDots = 200;
float speed = 2;
int[] dotColor = new int[nDots];
PVector[] allLocs = new PVector[nDots];
PVector[] allVelocs = new PVector[nDots];
int[] sickDur = new int[nDots];
float sz = 5.0;
float socialDistance = 0.5;
int recoverTime = 1000;
int sickColor = 10;
int healthColor = 100;
int recoverColor = 200;
int myColor = 100;
int mySickDur = 0;

void setup() {
  size(1280, 720);
  background(0);
  strokeWeight(sz);
  colorMode(HSB, 255, 255, 255);
  stroke(10, 255, 255);

  for (int i=0; i<nDots; i++) {
    allLocs[i]  = new PVector(random(width),random(height));
    if (random(1) < socialDistance){
      allVelocs[i] = new PVector(0, 0);
    }
    else{
      allVelocs[i] = new PVector(random(-speed, speed), random(-speed, speed));
    }
    if (i == 0){
      dotColor[i] = sickColor;
    }
    else{
    dotColor[i] = healthColor;
    }
  }
}

void draw() {
  
  background(0);
  
  if(myColor == sickColor){
    mySickDur++;
    if(mySickDur > recoverTime){
      myColor = recoverColor;
    }
  }
  stroke(myColor, 255, 255);
  fill(myColor, 255, 255);
  rect(mouseX, mouseY, 10, 10);
  
  for (int i=0; i<nDots; i++) {
    PVector location = allLocs[i];
    PVector velocity = allVelocs[i];
    
    location.add(velocity);
    
    if (dotColor[i]==sickColor){
      sickDur[i] += 1;
    }
    if (sickDur[i] > recoverTime){
      dotColor[i] = recoverColor;
    }
    stroke(dotColor[i],255,255);
    point(location.x, location.y);
  }
  
  for (int i=0; i<nDots; i++) {
    
    PVector location = allLocs[i];
    PVector velocity = allVelocs[i];

    if ((location.x > width) || (location.x < 0)) {
      velocity.x = velocity.x * -1;
    }
    if ((location.y > height) || (location.y < 0)) {
      velocity.y = velocity.y * -1;
    }
    
    for (int j=0; j<nDots; j++) {
      //dots infecting each other:
      if (location.dist(allLocs[j]) < sz && i!=j && dotColor[i]==sickColor){
        dotColor[j] = sickColor;
      }
///////////////////////////////////check mouse location now: /////////////////////////////////////////// 
      //dots infecting me:
      PVector myLoc = new PVector(mouseX, mouseY);
      if (location.dist(myLoc) < sz && i!=j && dotColor[i]==sickColor){
        myColor = sickColor;
      }
      //me infecting dots:
      if(myColor == sickColor){
        if (myLoc.dist(allLocs[j]) < sz && i!=j){
        dotColor[j] = sickColor;
      }
      }
////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
  }
}
