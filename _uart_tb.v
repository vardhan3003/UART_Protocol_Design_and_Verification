`timescale 1ns / 1ps
 
module pwm(
input clk, rst, 
output reg dout
);
 
parameter period = 100;
integer count = 0;
integer ton   = 0;
reg ncyc      = 1'b0;
 
always@(posedge clk)
begin
     if(rst == 1'b1)
        begin
         count <= 0;
         ton   <= 0;
         ncyc  <= 1'b0;
        end   
     else 
       begin
            if(count <= ton) 
              begin
              count <= count + 1;
              dout  <= 1'b1;
              ncyc  <= 1'b0;
              end
            else if (count < period)
              begin
              count <= count + 1;
              dout <= 1'b0;
              ncyc <= 1'b0;
              end
            else
               begin
               ncyc  <= 1'b1;
               count <= 0;
               end
       end
end
 
 
always@(posedge clk)
begin
     if(rst == 1'b0) 
     begin 
             if(ncyc == 1'b1)
                begin
                    if(ton < period)
                       ton <= ton + 5;
                     else
                       ton <= 0;
                end
     end   
end
 
 
 
 
endmodule
