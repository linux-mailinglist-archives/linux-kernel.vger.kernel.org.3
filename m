Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195D5166B0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353443AbiEARiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiEARiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:38:22 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34A419295;
        Sun,  1 May 2022 10:34:54 -0700 (PDT)
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651426492;
        bh=ZlYQ6zXPRyx9tIJksGvtci2N5RBaWhofXYTcshNRkV8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=f11JUJqZz4GDB2IcOlSnA8sIKvXmojnQU/guQTUqnHXhhMKiJzmpuuJj3dqZ03+Wm
         XmAS29ZazgYnLTxSI/hqU6ctfUFTLd7qKNJo86AezfPZ0Up9xUFL+rJqCjMMtSCaU1
         31PPxdMlCZ8oAxYLBbyzS2QSjYmEE8itUVrJI/7LZRKmViF8CcHpelznFPemATUZOw
         4nUUznbx/eBuNYy0PgNYZZImKzdrr82BpmOiNtgK2jEfZvUNK2TgsNynFflw0dxesZ
         6f1enyMsxdgAI2Dq0cBOQMVHiiz6EgcdufTYpoijhr9bnPmc1oLtfAVbFMswpC+Pd1
         f9qBSz4GHSZEA==
To:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        hanetzer@startmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
Subject: [RFC v2 2/2] arm: hisi: enable Hi3521a soc
Date:   Sun,  1 May 2022 12:34:23 -0500
Message-Id: <20220501173423.2473093-3-hanetzer@startmail.com>
In-Reply-To: <20220501173423.2473093-1-hanetzer@startmail.com>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Hisilicon Hi3521A/Hi3520DCV300 SoC. This SoC series includes
hardware mutlimedia codec cores, commonly used in consumer cctv/dvr
security systems and ipcameras. The arm core is a Cortex A7.

Add hi3521a.dtsi and hi3521a-rs-dm290e.dts for RaySharp CCTV systems,
marketed under the name Samsung SDR-B74301N.

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/hi3521a-rs-dm290e.dts | 134 ++++++++
 arch/arm/boot/dts/hi3521a.dtsi          | 423 ++++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig              |   9 +
 4 files changed, 568 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3521a-rs-dm290e.dts
 create mode 100644 arch/arm/boot/dts/hi3521a.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..535cef3b14ab 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -242,6 +242,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-ssi1328.dtb \
 	gemini-wbd111.dtb \
 	gemini-wbd222.dtb
+dtb-$(CONFIG_ARCH_HI3521A) += \
+	hi3521a-rs-dm290e.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += \
diff --git a/arch/arm/boot/dts/hi3521a-rs-dm290e.dts b/arch/arm/boot/dts/hi3521a-rs-dm290e.dts
new file mode 100644
index 000000000000..b24fcf2ca85e
--- /dev/null
+++ b/arch/arm/boot/dts/hi3521a-rs-dm290e.dts
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017-2022 Marty Plummer <hanetzer@startmail.com>
+ */
+
+#include "hi3521a.dtsi"
+
+/ {
+	model = "RaySharp RS-DM-290E DVR Board";
+	compatible = "raysharp,rs-dm-290e", "hisilicon,hi3521a";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@800000000 {
+		device_type = "memory";
+		reg = <0x80000000 0xf00000>;
+	};
+};
+
+&hi_sfc {
+	status = "okay";
+	spi-nor@0 {
+		// compatible = "jedec,spi-nor";
+		compatible = "macronix,mx25l25635e", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <150000000>;
+		// spi-rx-bus-width = <1>;
+		// spi-tx-bus-width = <1>;
+		// m25p,default-addr-width = <4>;
+		// spi-max-frequency = <160000000>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			
+			u-boot@0 {
+				label = "u-boot";
+				reg = <0x0 0x50000>;
+				read-only;
+			};
+			u-boot-env@50000 {
+				label = "u-boot-env";
+				reg = <0x50000 0x20000>;
+			};
+			kernel@70000 {
+				label = "kernel";
+				reg = <0x70000 0x700000>;
+			};
+			rootfs@770000 {
+				label = "rootfs";
+				reg = <0x800000 0x300000>;
+				read-only;
+			};
+			extra@b00000 {
+				label = "extra";
+				reg = <0xb00000 0x1500000>;
+			};
+		};
+	};
+};
+
+&dual_timer0 {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
+	status = "okay";
+};
+
+&pmx0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sfc_pmx_func>;
+	uart0_pmx_func: uart0_pmx_func {
+		pinctrl-single,pins = <
+			0x00e8 0x0
+			0x00ec 0x0
+		>;
+	};
+
+	sfc_pmx_func: sfc_pmx_func {
+		pinctrl-single,pins = <
+			0x00c4 0x1
+			0x00c8 0x1
+			0x00cc 0x1
+			0x00d0 0x1
+			0x00d4 0x1
+		>;
+	};
+};
+
+&pmx1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sfc_cfg_func>;
+	uart0_cfg_func: uart0_cfg_func {
+		pinctrl-single,pins = <
+			0x00e8 0x0
+			0x00ec 0x0
+		>;
+	};
+	sfc_cfg_func: sfc_cfg_func {
+		pinctrl-single,pins = <
+			0x00c4 0x58
+			0x00c8 0x28
+			0x00cc 0x38
+			0x00d0 0x38
+			0x00d4 0x38
+		>;
+	};
+};
+
+/* &gmac0 { */
+/* 	#address-cells = <1>; */
+/* 	#size-cells = <0>; */
+/* 	phy-handle = <&phy3>; */
+/* 	phy-mode = "rgmii"; */
+/* 	mac-address = [00 00 00 00 00 00]; */
+/* 	status = "okay"; */
+/**/
+/* 	phy3: ethernet-phy@3 { */
+/* 		reg = <3>; */
+/* 	}; */
+/* }; */
diff --git a/arch/arm/boot/dts/hi3521a.dtsi b/arch/arm/boot/dts/hi3521a.dtsi
new file mode 100644
index 000000000000..53993a32fd5d
--- /dev/null
+++ b/arch/arm/boot/dts/hi3521a.dtsi
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017-2022 Marty Plummer <hanetzer@startmail.com>
+ */
+
+#include <dt-bindings/clock/hi3521a-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clock-frequency = <1100000000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 0xf08>,
+			     <GIC_PPI 14 0xf08>,
+			     <GIC_PPI 11 0xf08>,
+			     <GIC_PPI 10 0xf08>;
+		clock-frequency = <24000000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gic: interrupt-controller@10301000 {
+		compatible = "arm,pl390";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x10301000 0x1000>, <0x10302000 0x1000>;
+	};
+
+	xtal24m: xtal24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	clk_3m: clk_3m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <3000000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		hi_sfc: spi@10000000 {
+			compatible = "hisilicon,hi3521a-spi-nor", "hisilicon,fmc-spi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x10000000 0x1000>, <0x14000000 0x10000>;
+			reg-names = "control", "memory";
+			clocks = <&crg HI3521A_FMC_CLK>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		/* usb0: usb@10030000 { */
+		/* 		compatible = "generic-ohci"; */
+		/* 		reg = <0x10030000 0x1000>; */
+		/* 		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>; */
+		/* 		clocks = <&crg > */
+		/* 	}; */
+		dmac: dma-controller@10060000 {
+			compatible = "arm,pl080", "arm,primecell";
+			arm,primecell-periphid = <0x00041080>;
+			reg = <0x10060000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_DMAC_CLK>;
+			clock-names = "apb_pclk";
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb1;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+			status = "okay";
+		};
+
+		gmac0: ethernet@100a0000 {
+			compatible = "hisilicon,hisi-gmac-v1";
+			reg = <0x100a0000 0x1000>, <0x1204008c 0x4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_ETH_CLK>, <&crg HI3521A_ETH_MACIF_CLK>;
+			clock-names = "mac_core", "mac_ifc";
+			/* resets = <&crg 0x78 0>, <&crg 0x78 2>, <&crg 0x78 5>; */
+			/* reset-names = "mac_core", "mac_ifc", "phy"; */
+			/* hisilicon,phy-reset-delays-us = <10000 10000 30000>; */
+			status = "disabled";
+		};
+
+		dual_timer0: timer@12000000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12000000 0x1000>;
+			clocks = <&sysctrl HI3521A_TIMER0_CLK>,
+				 <&sysctrl HI3521A_TIMER1_CLK>,
+				 <&crg HI3521A_APB_CLK>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer1: timer@12010000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12010000 0x1000>;
+			clocks = <&sysctrl HI3521A_TIMER2_CLK>,
+				 <&sysctrl HI3521A_TIMER3_CLK>,
+				 <&crg HI3521A_APB_CLK>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer2: timer@12020000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12020000 0x1000>;
+			clocks = <&sysctrl HI3521A_TIMER4_CLK>,
+				 <&sysctrl HI3521A_TIMER5_CLK>,
+				 <&crg HI3521A_APB_CLK>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer3: timer@12030000 {
+			compatible = "arm,sp804", "arm,primecell";
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x12030000 0x1000>;
+			clocks = <&sysctrl HI3521A_TIMER6_CLK>,
+				 <&sysctrl HI3521A_TIMER7_CLK>,
+				 <&crg HI3521A_APB_CLK>;
+			clock-names = "timer0clk", "timer1clk", "apb_pclk";
+			status = "disabled";
+		};
+
+		crg: clock-reset-controller@12040000 {
+			compatible = "hisilicon,hi3521a-crg";
+			#clock-cells = <1>;
+			#reset-cells = <2>;
+			reg = <0x12040000 0x1000>;
+		};
+
+		sysctrl: system-controller@12050000 {
+			compatible = "hisilicon,hi3521a-sysctrl", "syscon";
+			reg = <0x12050000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <2>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&sysctrl>;
+			offset = <0x4>;
+			mask = <0xdeadbeef>;
+		};
+
+		wdt0: watchdog@12070000 {
+			compatible = "arm,sp805", "arm,primecell";
+			arm,primecell-periphid = <0x00141805>;
+			reg = <0x12070000 0x1000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_FIXED_3M>;
+			clock-names = "apb_pclk";
+		};
+
+		uart0: serial@12080000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12080000 0x1000>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_UART0_CLK>, <&crg HI3521A_UART0_CLK>;
+			clock-names = "uartclk", "apb_pclk";
+			dmas = <&dmac 0 1>, <&dmac 1 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart1: serial@12090000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12090000 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_UART1_CLK>;
+			clock-names = "apb_pclk";
+			dmas = <&dmac 2 1>, <&dmac 3 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart2: serial@120a0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x120a0000 0x1000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_UART2_CLK>;
+			clock-names = "apb_pclk";
+			dmas = <&dmac 4 1>, <&dmac 5 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi_bus0: spi@120d0000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x120d0000 0x1000>;
+			arm,primecell-periphid = <0x00041022>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HI3521A_SPI0_CLK>;
+			clock-names = "apb_pclk";
+			dmas = <&dmac 6 1>, <&dmac 7 2>;
+			dma-names = "rx", "tx";
+			num-cs = <2>;
+			status = "disabled";
+		};
+
+		pmx0: pinmux@120f0000 {
+			compatible = "pinctrl-single";
+			reg = <0x120f0000 0x188>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#pinctrl-cells = <1>;
+			#gpio-range-cells = <3>;
+			ranges;
+
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <
+				&range 58 4 0
+			>;
+
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
+		pmx1: pinmux@120f0800 {
+			compatible = "pinconf-single";
+			reg = <0x120f0800 0x1d4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#pinctrl-cells = <1>;
+			ranges;
+
+			pinctrl-single,register-width = <32>;
+		};
+
+		gpio0: gpio@12150000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12150000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio1: gpio@12160000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12160000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio2: gpio@12170000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12170000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio3: gpio@12180000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12180000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio4: gpio@12190000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12190000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio5: gpio@121a0000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x121a0000 0x1000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio6: gpio@121b0000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x121b0000 0x1000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio7: gpio@121c0000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x121c0000 0x1000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio8: gpio@121d0000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x121d0000 0x1000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio9: gpio@121e0000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x121e0000 0x1000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio10: gpio@121f0000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x121f0000 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio11: gpio@12200000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12200000 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio12: gpio@12210000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12210000 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio13: gpio@12220000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12220000 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 2e980f834a6a..165ffb972157 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -13,6 +13,15 @@ if ARCH_HISI
 
 menu "Hisilicon platform type"
 
+config ARCH_HI3521A
+	bool "Hisilicon Hi3521a/Hi3520dcv300 family"
+	depends on ARCH_MULTI_V7
+	select CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  Hisilicon Hi3521a/Hi3520dcv300 family
+
 config ARCH_HI3xxx
 	bool "Hisilicon Hi36xx family"
 	depends on ARCH_MULTI_V7
-- 
2.35.1

