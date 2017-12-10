import com.phidget22.*;

VoltageInput inV;
int inVMapped;

void setupInterface() {
 try {
   println( Phidget.getLibraryVersion() );
   VoltageInput inV = new VoltageInput();

   inV.addAttachListener(new AttachListener() {
      public void onAttach(AttachEvent ae) {
        VoltageInput phid = (VoltageInput) ae.getSource();
        try {
          if(phid.getDeviceClass() != DeviceClass.VINT){
            System.out.println("channel " + phid.getChannel() + " on device " + phid.getDeviceSerialNumber() + " attached");
          }
          else{
            System.out.println("channel " + phid.getChannel() + " on device " + phid.getDeviceSerialNumber() + " hub port " + phid.getHubPort() + " attached");
          }
        } catch (PhidgetException ex) {
          System.out.println(ex.getDescription());
        }
      }
    });

    inV.addDetachListener(new DetachListener() {
      public void onDetach(DetachEvent de) {
        VoltageInput phid = (VoltageInput) de.getSource();
        try {
          if (phid.getDeviceClass() != DeviceClass.VINT) {
            System.out.println("channel " + phid.getChannel() + " on device " + phid.getDeviceSerialNumber() + " detached");
          } else {
            System.out.println("channel " + phid.getChannel() + " on device " + phid.getDeviceSerialNumber() + " hub port " + phid.getHubPort() + " detached");
          }
        } catch (PhidgetException ex) {
          System.out.println(ex.getDescription());
        }
      }
    });

    inV.addErrorListener(new ErrorListener() {
      public void onError(ErrorEvent ee) {
        System.out.println("Error: " + ee.getDescription());
      }
        });

    inV.addVoltageChangeListener(new VoltageInputVoltageChangeListener() {
      public void onVoltageChange(VoltageInputVoltageChangeEvent e) {
        System.out.printf("Voltage Changed: %.4f\n", e.getVoltage());
        inVMapped = (int)map((float)e.getVoltage(),0,5,0,255);
        System.out.printf("Voltage Mapped: %d\n",inVMapped);
      }
    });

    inV.setDeviceSerialNumber(157390);
    inV.setChannel(7);
    
    
    System.out.println("Opening and waiting 5 seconds for attachment...");
    inV.open(5000);
    inV.setVoltageChangeTrigger(0.001);
    
    
 } catch (PhidgetException ex) {
   println(ex);
 }
}



void setup() {
 size(200,200);
 background(255);
 colorMode(HSB);
 setupInterface();
}


void draw() {
  background(color(inVMapped,255,255,255));

} 

void stop() {
  println("ByeBye!");
  exit(); 
}