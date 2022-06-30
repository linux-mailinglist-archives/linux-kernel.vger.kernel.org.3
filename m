Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD0560DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiF3AK4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jun 2022 20:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiF3AKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:10:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3395396B5;
        Wed, 29 Jun 2022 17:10:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD2261480;
        Wed, 29 Jun 2022 17:10:52 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A7F73F5A1;
        Wed, 29 Jun 2022 17:10:50 -0700 (PDT)
Date:   Thu, 30 Jun 2022 01:04:10 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20220630010410.38fc117f@slackpad.lan>
In-Reply-To: <3165164.aeNJFYEL58@kista>
References: <20220428230933.15262-1-andre.przywara@arm.com>
 <20220428230933.15262-4-andre.przywara@arm.com>
 <3165164.aeNJFYEL58@kista>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2022 21:05:11 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

many thanks for taking the time to wade through this file!

> Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara napisal(a):
> > This (relatively) new SoC is similar to the H6, but drops the (broken)
> > PCIe support and the USB 3.0 controller. It also gets the management
> > controller removed, which in turn removes *some*, but not all of the
> > devices formerly dedicated to the ARISC (CPUS).
> > And while there is still the extra sunxi interrupt controller, the
> > package lacks the corresponding NMI pin, so no interrupts for the PMIC.
> > 
> > The reserved memory node is actually handled by Trusted Firmware now,
> > but U-Boot fails to propagate this to a separately loaded DTB, so we
> > keep it in here for now, until U-Boot learns to do this properly.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574 ++++++++++++++++++
> >  1 file changed, 574 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/  
> boot/dts/allwinner/sun50i-h616.dtsi
> > new file mode 100644
> > index 000000000000..cc06cdd15ba5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > @@ -0,0 +1,574 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +// Copyright (C) 2020 Arm Ltd.
> > +// based on the H6 dtsi, which is:
> > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > +
> > +/ {
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu@0 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <1>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <2>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			compatible = "arm,cortex-a53";
> > +			device_type = "cpu";
> > +			reg = <3>;
> > +			enable-method = "psci";
> > +			clocks = <&ccu CLK_CPUX>;
> > +		};
> > +	};
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > +		secmon_reserved: secmon@40000000 {
> > +			reg = <0x0 0x40000000 0x0 0x80000>;
> > +			no-map;
> > +		};
> > +	};  
> 
> I'm not a fan of above. If anything changes in future in BL31, U-Boot would 
> need to reconfigure it anyway. Can we just skip it?

I am not a fan neither, but last time I checked this is needed to boot.
Indeed TF-A inserts this node, with the right values, into U-Boot's DT.
And that's nicely preserved if you use that DT ($fdtcontroladdr) for
the kernel as well.
But if someone *loads* a DTB into U-Boot (to $fdt_addr_r), then
U-Boot fails to propagate the /reserved-memory node into that copy.
There does not seem to be a global notion of reserved memory in U-Boot.
Some commands (like tftp) explicitly parse the control DT to find and
respect reserved memory regions. bootm does that also, but only to
avoid placing the ramdisk or DTB into reserved memory. The information
ends up in images->lmb, but is not used to generate or amend nodes in
the target DT.
So the bits and pieces are there, but it will require some code to be
added to the generic U-Boot code.

So what do you think? Leaving this out will prevent loading DTBs into
U-Boot, at the moment, which sounds bad. I suggest we keep it in, for
now, it should not really hurt. U-Boot will hopefully start to do the
right thing soon, then we can either phase it out here (maybe when we
actually change something in TF-A), or let U-Boot fix it.

> 
> > +
> > +	osc24M: osc24M-clk {
> > +		#clock-cells = <0>;
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "osc24M";
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,cortex-a53-pmu";
> > +		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		arm,no-tick-in-suspend;
> > +		interrupts = <GIC_PPI 13
> > +			(GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 14
> > +			(GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 11
> > +			(GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 10
> > +			(GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_HIGH)>;
> > +	};  
> 
> Vendor kernel sets IRQ to low level. What is the difference?

Nothing, really. The polarity of SPI level IRQ lines is hardwired at
integration time, both at the peripheral and the GIC distributor. The
GIC software interface has no register to control that - all you can
configure is edge or level. There *is* some underlying polarity, but to
my understanding this is just mentioned here for completeness, and
because the binding requires to name one.

> 
> > +
> > +	soc@0 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x0 0x0 0x0 0x40000000>;
> > +
> > +		syscon: syscon@3000000 {
> > +			compatible = "allwinner,sun50i-h616-system-  
> control";
> > +			reg = <0x03000000 0x1000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +
> > +			sram_c: sram@28000 {
> > +				compatible = "mmio-sram";
> > +				reg = <0x00028000 0x30000>;
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				ranges = <0 0x00028000 0x30000>;
> > +			};
> > +		};
> > +
> > +		ccu: clock@3001000 {
> > +			compatible = "allwinner,sun50i-h616-ccu";
> > +			reg = <0x03001000 0x1000>;
> > +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>;
> > +			clock-names = "hosc", "losc", "iosc";
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +		};
> > +
> > +		watchdog: watchdog@30090a0 {
> > +			compatible = "allwinner,sun50i-h616-wdt",
> > +				     "allwinner,sun6i-a31-wdt";
> > +			reg = <0x030090a0 0x20>;
> > +			interrupts = <GIC_SPI 50 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&osc24M>;
> > +		};
> > +
> > +		pio: pinctrl@300b000 {
> > +			compatible = "allwinner,sun50i-h616-pinctrl";
> > +			reg = <0x0300b000 0x400>;
> > +			interrupts = <GIC_SPI 51 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 52 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 53 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 43 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 54 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 55 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 56 
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 57 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 
> 0>;
> > +			clock-names = "apb", "hosc", "losc";
> > +			gpio-controller;
> > +			#gpio-cells = <3>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +
> > +			ext_rgmii_pins: rgmii-pins {
> > +				pins = "PI0", "PI1", "PI2", "PI3",   
> "PI4",
> > +				       "PI5", "PI7", "PI8", "PI9",   
> "PI10",
> > +				       "PI11", "PI12", "PI13",   
> "PI14", "PI15",
> > +				       "PI16";
> > +				function = "emac0";
> > +				drive-strength = <40>;
> > +			};
> > +
> > +			i2c0_pins: i2c0-pins {
> > +				pins = "PI6", "PI7";
> > +				function = "i2c0";
> > +			};
> > +
> > +			i2c3_ph_pins: i2c3-ph-pins {
> > +				pins = "PH4", "PH5";
> > +				function = "i2c3";
> > +			};
> > +
> > +			ir_rx_pin: ir-rx-pin {
> > +				pins = "PH10";
> > +				function = "ir_rx";
> > +			};
> > +
> > +			mmc0_pins: mmc0-pins {
> > +				pins = "PF0", "PF1", "PF2", "PF3",
> > +				       "PF4", "PF5";
> > +				function = "mmc0";
> > +				drive-strength = <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			mmc1_pins: mmc1-pins {
> > +				pins = "PG0", "PG1", "PG2", "PG3",
> > +				       "PG4", "PG5";
> > +				function = "mmc1";
> > +				drive-strength = <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			mmc2_pins: mmc2-pins {
> > +				pins = "PC0", "PC1", "PC5", "PC6",
> > +				       "PC8", "PC9", "PC10",   
> "PC11",
> > +				       "PC13", "PC14", "PC15",   
> "PC16";
> > +				function = "mmc2";
> > +				drive-strength = <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			spi0_pins: spi0-pins {
> > +				pins = "PC0", "PC2", "PC3", "PC4";
> > +				function = "spi0";
> > +			};
> > +
> > +			spi1_pins: spi1-pins {
> > +				pins = "PH6", "PH7", "PH8";
> > +				function = "spi1";
> > +			};
> > +
> > +			spi1_cs_pin: spi1-cs-pin {
> > +				pins = "PH5";
> > +				function = "spi1";
> > +			};
> > +
> > +			uart0_ph_pins: uart0-ph-pins {
> > +				pins = "PH0", "PH1";
> > +				function = "uart0";
> > +			};
> > +
> > +			uart1_pins: uart1-pins {
> > +				pins = "PG6", "PG7";
> > +				function = "uart1";
> > +			};
> > +
> > +			uart1_rts_cts_pins: uart1-rts-cts-pins {
> > +				pins = "PG8", "PG9";
> > +				function = "uart1";
> > +			};  
> 
> Please add /omit-if-no-ref/ where applicable.

OK. I think most boards have Bluetooth at UART1, though.

> 
> > +		};
> > +
> > +		gic: interrupt-controller@3021000 {
> > +			compatible = "arm,gic-400";
> > +			reg = <0x03021000 0x1000>,
> > +			      <0x03022000 0x2000>,
> > +			      <0x03024000 0x2000>,
> > +			      <0x03026000 0x2000>;
> > +			interrupts = <GIC_PPI 9   
> (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +		};
> > +
> > +		mmc0: mmc@4020000 {
> > +			compatible = "allwinner,sun50i-h616-mmc",
> > +				     "allwinner,sun50i-a100-mmc";
> > +			reg = <0x04020000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu 
> CLK_MMC0>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC0>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 35 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc0_pins>;
> > +			status = "disabled";
> > +			max-frequency = <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			cap-sdio-irq;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		mmc1: mmc@4021000 {
> > +			compatible = "allwinner,sun50i-h616-mmc",
> > +				     "allwinner,sun50i-a100-mmc";
> > +			reg = <0x04021000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu 
> CLK_MMC1>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC1>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 36 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc1_pins>;
> > +			status = "disabled";
> > +			max-frequency = <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			cap-sdio-irq;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		mmc2: mmc@4022000 {
> > +			compatible = "allwinner,sun50i-h616-emmc",
> > +				     "allwinner,sun50i-a100-emmc";
> > +			reg = <0x04022000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu 
> CLK_MMC2>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC2>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 37 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc2_pins>;
> > +			status = "disabled";
> > +			max-frequency = <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			cap-sdio-irq;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		uart0: serial@5000000 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x05000000 0x400>;
> > +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&ccu CLK_BUS_UART0>;
> > +			resets = <&ccu RST_BUS_UART0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart1: serial@5000400 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x05000400 0x400>;
> > +			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&ccu CLK_BUS_UART1>;
> > +			resets = <&ccu RST_BUS_UART1>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart2: serial@5000800 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x05000800 0x400>;
> > +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&ccu CLK_BUS_UART2>;
> > +			resets = <&ccu RST_BUS_UART2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart3: serial@5000c00 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x05000c00 0x400>;
> > +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&ccu CLK_BUS_UART3>;
> > +			resets = <&ccu RST_BUS_UART3>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart4: serial@5001000 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x05001000 0x400>;
> > +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&ccu CLK_BUS_UART4>;
> > +			resets = <&ccu RST_BUS_UART4>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart5: serial@5001400 {
> > +			compatible = "snps,dw-apb-uart";
> > +			reg = <0x05001400 0x400>;
> > +			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift = <2>;
> > +			reg-io-width = <4>;
> > +			clocks = <&ccu CLK_BUS_UART5>;
> > +			resets = <&ccu RST_BUS_UART5>;
> > +			status = "disabled";
> > +		};
> > +
> > +		i2c0: i2c@5002000 {
> > +			compatible = "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg = <0x05002000 0x400>;
> > +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_I2C0>;
> > +			resets = <&ccu RST_BUS_I2C0>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&i2c0_pins>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		i2c1: i2c@5002400 {
> > +			compatible = "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg = <0x05002400 0x400>;
> > +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_I2C1>;
> > +			resets = <&ccu RST_BUS_I2C1>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		i2c2: i2c@5002800 {
> > +			compatible = "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg = <0x05002800 0x400>;
> > +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_I2C2>;
> > +			resets = <&ccu RST_BUS_I2C2>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		i2c3: i2c@5002c00 {
> > +			compatible = "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg = <0x05002c00 0x400>;
> > +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_I2C3>;
> > +			resets = <&ccu RST_BUS_I2C3>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		i2c4: i2c@5003000 {
> > +			compatible = "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg = <0x05003000 0x400>;
> > +			interrupts = <GIC_SPI 10 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_I2C4>;
> > +			resets = <&ccu RST_BUS_I2C4>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		spi0: spi@5010000 {
> > +			compatible = "allwinner,sun50i-h616-spi",
> > +				     "allwinner,sun8i-h3-spi";
> > +			reg = <0x05010000 0x1000>;
> > +			interrupts = <GIC_SPI 12 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu 
> CLK_SPI0>;
> > +			clock-names = "ahb", "mod";
> > +			resets = <&ccu RST_BUS_SPI0>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&spi0_pins>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		spi1: spi@5011000 {
> > +			compatible = "allwinner,sun50i-h616-spi",
> > +				     "allwinner,sun8i-h3-spi";
> > +			reg = <0x05011000 0x1000>;
> > +			interrupts = <GIC_SPI 13 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu 
> CLK_SPI1>;
> > +			clock-names = "ahb", "mod";
> > +			resets = <&ccu RST_BUS_SPI1>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&spi1_pins>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		emac0: ethernet@5020000 {
> > +			compatible = "allwinner,sun50i-h616-emac",
> > +				     "allwinner,sun50i-a64-emac";
> > +			syscon = <&syscon>;
> > +			reg = <0x05020000 0x10000>;
> > +			interrupts = <GIC_SPI 14 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			resets = <&ccu RST_BUS_EMAC0>;
> > +			reset-names = "stmmaceth";
> > +			clocks = <&ccu CLK_BUS_EMAC0>;
> > +			clock-names = "stmmaceth";
> > +			status = "disabled";
> > +
> > +			mdio0: mdio {
> > +				compatible = "snps,dwmac-mdio";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +		};
> > +
> > +		rtc: rtc@7000000 {
> > +			compatible = "allwinner,sun50i-h616-rtc";
> > +			reg = <0x07000000 0x400>;
> > +			interrupts = <GIC_SPI 101 
> IRQ_TYPE_LEVEL_HIGH>;  
> 
> Above interrupt doesn't seem to be correct according to documentation. It 
> should be 104.

That is a very good catch, 101/133 is indeed the RTC IRQ number on the
H6.

> 
> > +			clocks = <&r_ccu CLK_R_APB1_RTC>, <&osc24M>,
> > +				 <&ccu CLK_PLL_SYSTEM_32K>;
> > +			clock-names = "bus", "hosc",
> > +				      "pll-32k";
> > +			clock-output-names = "osc32k", "osc32k-out",   
> "iosc";
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		r_ccu: clock@7010000 {
> > +			compatible = "allwinner,sun50i-h616-r-ccu";
> > +			reg = <0x07010000 0x210>;
> > +			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>,
> > +				 <&ccu CLK_PLL_PERIPH0>;
> > +			clock-names = "hosc", "losc", "iosc", "pll-  
> periph";
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +		};
> > +
> > +		r_pio: pinctrl@7022000 {
> > +			compatible = "allwinner,sun50i-h616-r-  
> pinctrl";
> > +			reg = <0x07022000 0x400>;
> > +			interrupts = <GIC_SPI 43 
> IRQ_TYPE_LEVEL_HIGH>;  
> 
> Above interrupt is already used for port E in first pinctrl. Is this shared 
> somehow?

Huh, another good find. The manual does not seem to mention a GPIO_L
interrupt, and the two PL pins do not report function 6.
when probing the registers in U-Boot there are no other pins (neither in
PortL nor PortM), also the interrupt registers (@+0x200) are not
implemented. So there does not seem to be an interrupt.

The pinctrl driver does not seem to care (by looking at the code,
and by booting it), as .irq_banks is 0, so no IRQ controller
functionality is ever instantiated.
The binding makes the interrupts property mandatory, though, so this
needs to be amended there.


I will try to post a new version till the end of the week.

Thanks!
Andre


> 
> Best regards,
> Jernej
> 
> > +			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>,   
> <&rtc 0>;
> > +			clock-names = "apb", "hosc", "losc";
> > +			gpio-controller;
> > +			#gpio-cells = <3>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +
> > +			r_i2c_pins: r-i2c-pins {
> > +				pins = "PL0", "PL1";
> > +				function = "s_i2c";
> > +			};
> > +
> > +			r_rsb_pins: r-rsb-pins {
> > +				pins = "PL0", "PL1";
> > +				function = "s_rsb";
> > +			};
> > +		};
> > +
> > +		ir: ir@7040000 {
> > +			compatible = "allwinner,sun50i-h616-ir",
> > +				     "allwinner,sun6i-a31-ir";
> > +			reg = <0x07040000 0x400>;
> > +			interrupts = <GIC_SPI 106 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&r_ccu CLK_R_APB1_IR>,
> > +				 <&r_ccu CLK_IR>;
> > +			clock-names = "apb", "ir";
> > +			resets = <&r_ccu RST_R_APB1_IR>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&ir_rx_pin>;
> > +			status = "disabled";
> > +		};
> > +
> > +		r_i2c: i2c@7081400 {
> > +			compatible = "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg = <0x07081400 0x400>;
> > +			interrupts = <GIC_SPI 105 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&r_ccu CLK_R_APB2_I2C>;
> > +			resets = <&r_ccu RST_R_APB2_I2C>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +
> > +		r_rsb: rsb@7083000 {
> > +			compatible = "allwinner,sun50i-h616-rsb",
> > +				     "allwinner,sun8i-a23-rsb";
> > +			reg = <0x07083000 0x400>;
> > +			interrupts = <GIC_SPI 109 
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&r_ccu CLK_R_APB2_RSB>;
> > +			clock-frequency = <3000000>;
> > +			resets = <&r_ccu RST_R_APB2_RSB>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&r_rsb_pins>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};
> > +	};
> > +};
> > -- 
> > 2.35.3
> > 
> >   
> 
> 
> 

