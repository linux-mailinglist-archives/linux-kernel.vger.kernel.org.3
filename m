Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83C5245FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350518AbiELGkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349128AbiELGjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:39:48 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B234E674FF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:39:27 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26385:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 12 May 2022 14:32:14 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v15 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board device tree
Date:   Thu, 12 May 2022 14:31:05 +0800
Message-Id: <daeccdfb9655e549656af0af955a4697871e3ab0.1652329411.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1652329411.git.qinjian@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the basic support for Sunplus SP7021-Demo-V3 board.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                                  |   1 +
 arch/arm/boot/dts/sunplus-sp7021-achip.dtsi  |  85 +++++
 arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts |  27 ++
 arch/arm/boot/dts/sunplus-sp7021.dtsi        | 369 +++++++++++++++++++
 4 files changed, 482 insertions(+)
 create mode 100644 arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
 create mode 100644 arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
 create mode 100644 arch/arm/boot/dts/sunplus-sp7021.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cf30e776..b55ec0768 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2747,6 +2747,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	arch/arm/boot/dts/sunplus-sp7021*.dts*
 F:	arch/arm/configs/sp7021_*defconfig
 F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
diff --git a/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi b/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
new file mode 100644
index 000000000..1560c95d9
--- /dev/null
+++ b/arch/arm/boot/dts/sunplus-sp7021-achip.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for Sunplus SP7021
+ *
+ * Copyright (C) 2021 Sunplus Technology Co.
+ */
+
+#include "sunplus-sp7021.dtsi"
+
+/ {
+	compatible = "sunplus,sp7021-achip";
+	model = "Sunplus SP7021 (CA7)";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		extclk: clk@osc0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+			clock-output-names = "extclk";
+		};
+
+		divextclk: clk@0 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks  = <&extclk>;
+			clock-mult = <1>;
+			clock-div = <2>;
+			clock-output-names = "extdivclk";
+		};
+
+		A_pll0: clk@A_pll0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <2000000000>;
+			clock-output-names = "A_pll0";
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <931000000>;
+		};
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <1>;
+			clock-frequency = <931000000>;
+		};
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <2>;
+			clock-frequency = <931000000>;
+		};
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <3>;
+			clock-frequency = <931000000>;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+};
diff --git a/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts b/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
new file mode 100644
index 000000000..05e164115
--- /dev/null
+++ b/arch/arm/boot/dts/sunplus-sp7021-demo-v3.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for Sunplus SP7021 Demo V3 SBC board
+ *
+ * Copyright (C) Sunplus Technology Co.
+ */
+
+/dts-v1/;
+
+#include "sunplus-sp7021-achip.dtsi"
+
+/ {
+	compatible = "sunplus,sp7021-demo-v3";
+	model = "SP7021/CA7/Demo_V3";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+		bootargs = "console=ttyS0,115200 loglevel=8 earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/sunplus-sp7021.dtsi b/arch/arm/boot/dts/sunplus-sp7021.dtsi
new file mode 100644
index 000000000..4777abdce
--- /dev/null
+++ b/arch/arm/boot/dts/sunplus-sp7021.dtsi
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for Sunplus SP7021
+ *
+ * Copyright (C) 2021 Sunplus Technology Co.
+ */
+
+#include <dt-bindings/clock/sunplus,sp7021-clkc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/sunplus,sp7021-reset.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/sppctl-sp7021.h>
+
+/ {
+	compatible = "sunplus,sp7021";
+	model = "Sunplus SP7021";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	soc@A {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&gic>;
+
+		gic: interrupt-controller@CPU {
+			compatible = "arm,cortex-a7-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x9f101000 0x1000>,
+			      <0x9f102000 0x2000>,
+			      <0x9f104000 0x2000>,
+			      <0x9f106000 0x2000>;
+		};
+
+		timer: timer@CPU {
+			compatible = "arm,armv7-timer";
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			clock-frequency = <27000000>;
+			arm,cpu-registers-not-fw-configured;
+		};
+	};
+
+	soc@B {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		intc: interrupt-controller@9c000780 {
+			compatible = "sunplus,sp7021-intc";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x9c000780 0x80>, <0x9c000a80 0x80>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>, /* EXT_INT0 */
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>; /* EXT_INT1 */
+		};
+
+		clkc: clock-controller@9c000000 {
+			compatible = "sunplus,sp7021-clkc";
+			reg = <0x9c000000 0x280>;
+			#clock-cells = <1>;
+			clocks = <&extclk>;
+		};
+
+		rstc: reset@9c000054 {
+			compatible = "sunplus,sp7021-reset";
+			reg = <0x9c000054 0x28>;
+			#reset-cells = <1>;
+		};
+
+		rtc: serial@9c003a00 {
+			compatible = "sunplus,sp7021-rtc";
+			reg = <0x9c003a00 0x80>;
+			reg-names = "rtc";
+			clocks = <&clkc CLK_RTC>;
+			resets = <&rstc RST_RTC>;
+			interrupt-parent = <&intc>;
+			interrupts = <163 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		otp: otp@9c00af00 {
+			compatible = "sunplus,sp7021-ocotp";
+			reg = <0x9c00af00 0x34>, <0x9c00af80 0x58>;
+			reg-names = "hb_gpio", "otprx";
+			clocks = <&clkc CLK_OTPRX>;
+			resets = <&rstc RST_OTPRX>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			therm_calib: thermal-calibration@14 {
+				reg = <0x14 0x3>;
+			};
+			disc_vol: disconnect-voltage@18 {
+				reg = <0x18 0x2>;
+			};
+			mac_addr0: mac-address0@34 {
+				reg = <0x34 0x6>;
+			};
+			mac_addr1: mac-address1@3a {
+				reg = <0x3a 0x6>;
+			};
+		};
+
+		led {
+			compatible = "gpio-leds";
+			pinctrl-names = "default";
+			pinctrl-0 = <&leds_pins>;
+			system-led {
+				label = "system-led";
+				gpios = <&pctl 0 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+				linux,default-trigger = "heartbeat";
+			};
+		};
+
+		uart0: serial@9c000900 {
+			compatible = "sunplus,sp7021-uart";
+			reg = <0x9c000900 0x80>;
+			interrupt-parent = <&intc>;
+			interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_UA0>;
+			resets = <&rstc RST_UA0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
+		};
+
+		uart1: serial@9c000980 {
+			compatible = "sunplus,sp7021-uart";
+			reg = <0x9c000980 0x80>;
+			interrupt-parent = <&intc>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_UA1>;
+			resets = <&rstc RST_UA1>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_pins>;
+		};
+
+		uart2: serial@9c000800 {
+			compatible = "sunplus,sp7021-uart";
+			reg = <0x9c000800 0x80>;
+			interrupt-parent = <&intc>;
+			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_UA2>;
+			resets = <&rstc RST_UA2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_pins>;
+			status = "disabled";
+		};
+
+		uart3: serial@9c000880 {
+			compatible = "sunplus,sp7021-uart";
+			reg = <0x9c000880 0x80>;
+			interrupt-parent = <&intc>;
+			interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_UA3>;
+			resets = <&rstc RST_UA3>;
+			status = "disabled";
+		};
+
+		uart4: serial@9c008780 {
+			compatible = "sunplus,sp7021-uart";
+			reg = <0x9c008780 0x80>;
+			interrupt-parent = <&intc>;
+			interrupts = <134 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_UA4>;
+			resets = <&rstc RST_UA4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart4_pins>;
+			status = "disabled";
+		};
+
+		spi_controller0: spi@9c002d80 {
+			compatible = "sunplus,sp7021-spi";
+			reg = <0x9c002d80 0x80>, <0x9c002e00 0x80>;
+			reg-names = "master", "slave";
+			interrupt-parent = <&intc>;
+			interrupt-names = "dma_w",
+					  "master_risc",
+					  "slave_risc";
+			interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
+				     <146 IRQ_TYPE_LEVEL_HIGH>,
+				     <145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_SPI_COMBO_0>;
+			resets = <&rstc RST_SPI_COMBO_0>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pins>;
+			cs-gpios = <&pctl 26 GPIO_ACTIVE_LOW>, <&pctl 28 GPIO_ACTIVE_LOW>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi@0 {
+				compatible = "rohm,dh2228fv";
+				spi-max-frequency = <5000000>;
+				reg = <0x0>;
+				status = "okay";
+			};
+			spi@1 {
+				compatible = "rohm,dh2228fv";
+				spi-max-frequency = <5000000>;
+				reg = <0x1>;
+				status = "okay";
+			};
+		};
+
+		spi_controller1: spi@9c00f480 {
+			compatible = "sunplus,sp7021-spi";
+			reg = <0x9c00f480 0x80>, <0x9c00f500 0x80>;
+			reg-names = "master", "slave";
+			interrupt-parent = <&intc>;
+			interrupt-names = "dma_w",
+					  "master_risc",
+					  "slave_risc";
+			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>,
+				     <69 IRQ_TYPE_LEVEL_HIGH>,
+				     <68 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_SPI_COMBO_1>;
+			resets = <&rstc RST_SPI_COMBO_1>;
+			spi-max-frequency = <25000000>;
+			status = "disabled";
+		};
+
+		spi_controller2: spi@9c00f600 {
+			compatible = "sunplus,sp7021-spi";
+			reg = <0x9c00f600 0x80>, <0x9c00f680 0x80>;
+			reg-names = "master", "slave";
+			interrupt-parent = <&intc>;
+			interrupt-names = "dma_w",
+					  "master_risc",
+					  "slave_risc";
+			interrupts = <70 IRQ_TYPE_LEVEL_HIGH>,
+				     <72 IRQ_TYPE_LEVEL_HIGH>,
+				     <71 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_SPI_COMBO_2>;
+			resets = <&rstc RST_SPI_COMBO_2>;
+			spi-max-frequency = <25000000>;
+			status = "disabled";
+		};
+
+		spi_controller3: spi@9c00f780 {
+			compatible = "sunplus,sp7021-spi";
+			reg = <0x9c00f780 0x80>, <0x9c00f800 0x80>;
+			reg-names = "master", "slave";
+			interrupt-parent = <&intc>;
+			interrupt-names = "dma_w",
+					  "master_risc",
+					  "slave_risc";
+			interrupts = <73 IRQ_TYPE_LEVEL_HIGH>,
+				     <75 IRQ_TYPE_LEVEL_HIGH>,
+				     <74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkc CLK_SPI_COMBO_3>;
+			resets = <&rstc RST_SPI_COMBO_3>;
+			spi-max-frequency = <25000000>;
+			status = "disabled";
+		};
+
+		pctl: pinctl@9c000100 {
+			compatible = "sunplus,sp7021-pctl";
+			reg = <0x9C000100 0x100>,
+			      <0x9C000300 0x100>,
+			      <0x9C0032e4 0x1C>,
+			      <0x9C000080 0x20>;
+			reg-names = "moon2", "gpioxt", "first", "moon1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			clocks = <&clkc CLK_GPIO>;
+			resets = <&rstc RST_GPIO>;
+			pinctrl-names = "default";
+
+			leds_pins: pinmux_gpio_leds-pins {
+				sunplus,pins = < SPPCTL_IOPAD(0,SPPCTL_PCTL_G_GPIO,0,SPPCTL_PCTL_L_OUT) >;
+			};
+
+			emmc_pins: emmc-pins {
+				function = "CARD0_EMMC";
+				groups = "CARD0_EMMC";
+			};
+
+			sdcard-pins {
+				function = "SD_CARD";
+				groups = "SD_CARD";
+				sunplus,pins = < SPPCTL_IOPAD(91, SPPCTL_PCTL_G_GPIO, 0, 0) >;
+			};
+
+			emac_pins: pinmux_emac_demo_board_v3-pins {
+				sunplus,pins = <
+					SPPCTL_IOPAD(49,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_CLK_OUT,0)
+					SPPCTL_IOPAD(44,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_MAC_SMI_MDC,0)
+					SPPCTL_IOPAD(43,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_MAC_SMI_MDIO,0)
+					SPPCTL_IOPAD(52,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_TXEN,0)
+					SPPCTL_IOPAD(50,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_TXD0,0)
+					SPPCTL_IOPAD(51,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_TXD1,0)
+					SPPCTL_IOPAD(46,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_CRSDV,0)
+					SPPCTL_IOPAD(47,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_RXD0,0)
+					SPPCTL_IOPAD(48,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_RXD1,0)
+					SPPCTL_IOPAD(45,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P0_MAC_RMII_RXER,0)
+					SPPCTL_IOPAD(59,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_TXEN,0)
+					SPPCTL_IOPAD(57,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_TXD0,0)
+					SPPCTL_IOPAD(58,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_TXD1,0)
+					SPPCTL_IOPAD(54,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_CRSDV,0)
+					SPPCTL_IOPAD(55,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_RXD0,0)
+					SPPCTL_IOPAD(56,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_RXD1,0)
+					SPPCTL_IOPAD(53,SPPCTL_PCTL_G_PMUX,MUXF_L2SW_P1_MAC_RMII_RXER,0)
+				>;
+				sunplus,zerofunc = <
+					MUXF_L2SW_LED_FLASH0
+					MUXF_L2SW_LED_FLASH1
+					MUXF_L2SW_LED_ON0
+					MUXF_L2SW_LED_ON1
+					MUXF_DAISY_MODE
+				>;
+			};
+
+			uart0_pins: pinmux_uart0-pins {
+				function = "UA0";
+				groups = "UA0";
+			};
+
+			uart1_pins: pinmux_uart1-pins {
+				sunplus,pins = <
+					SPPCTL_IOPAD(14,SPPCTL_PCTL_G_PMUX,MUXF_UA4_TX,0)
+					SPPCTL_IOPAD(16,SPPCTL_PCTL_G_PMUX,MUXF_UA4_RX,0)
+				>;
+			};
+
+			uart2_pins: pinmux_uart2-pins {
+				sunplus,pins = <
+					SPPCTL_IOPAD(16,SPPCTL_PCTL_G_PMUX,MUXF_UA2_TX,0)
+					SPPCTL_IOPAD(17,SPPCTL_PCTL_G_PMUX,MUXF_UA2_RX,0)
+					SPPCTL_IOPAD(18,SPPCTL_PCTL_G_PMUX,MUXF_UA2_RTS,0)
+					SPPCTL_IOPAD(19,SPPCTL_PCTL_G_PMUX,MUXF_UA2_CTS,0)
+				>;
+			};
+
+			uart4_pins: pinmux_uart4-pins {
+				sunplus,pins = <
+					SPPCTL_IOPAD(22,SPPCTL_PCTL_G_PMUX,MUXF_UA4_TX,0)
+					SPPCTL_IOPAD(20,SPPCTL_PCTL_G_PMUX,MUXF_UA4_RX,0)
+					SPPCTL_IOPAD(23,SPPCTL_PCTL_G_PMUX,MUXF_UA4_RTS,0)
+					SPPCTL_IOPAD(21,SPPCTL_PCTL_G_PMUX,MUXF_UA4_CTS,0)
+				>;
+			};
+
+			spi0_pins: pinmux_spi0-pins {
+				sunplus,pins = <
+					SPPCTL_IOPAD(26,SPPCTL_PCTL_G_GPIO,0,0)
+					SPPCTL_IOPAD(28,SPPCTL_PCTL_G_GPIO,0,0)
+					SPPCTL_IOPAD(23,SPPCTL_PCTL_G_PMUX,MUXF_SPI0S_DO,0)
+					SPPCTL_IOPAD(25,SPPCTL_PCTL_G_PMUX,MUXF_SPI0S_DI,0)
+					SPPCTL_IOPAD(27,SPPCTL_PCTL_G_PMUX,MUXF_SPI0S_CLK,0)
+				>;
+			};
+		};
+	};
+};
-- 
2.33.1

