Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9C47797A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhLPQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:42:00 -0500
Received: from finn.gateworks.com ([108.161.129.64]:36038 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232873AbhLPQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:41:58 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mxtpI-0093Ej-1C; Thu, 16 Dec 2021 16:41:52 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice*: add PCIe support
Date:   Thu, 16 Dec 2021 08:41:49 -0800
Message-Id: <20211216164149.13333-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe support to GW71xx/GW72xx/GW73xx/GW7901/GW7902

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
This goes on top of the series recently applied to pci/dwc [1]:
[PATCH v7 0/8] Add the imx8m pcie phy driver and imx8mm pcie support
[1] -
https://patchwork.kernel.org/project/linux-pci/list/?series=589031&state=*

 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   | 35 +++++++++++
 .../dts/freescale/imx8mm-venice-gw72xx.dtsi   | 62 +++++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw73xx.dtsi   | 62 +++++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw7901.dts    | 36 +++++++++++
 .../dts/freescale/imx8mm-venice-gw7902.dts    | 50 +++++++++++++++
 5 files changed, 245 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 28012279f6f6..506335efc391 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 
 / {
 	aliases {
@@ -33,6 +34,12 @@
 		};
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		pinctrl-names = "default";
@@ -87,6 +94,28 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk>;
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-rates = <10000000>, <250000000>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	status = "okay";
+};
+
 /* GPS */
 &uart1 {
 	pinctrl-names = "default";
@@ -148,6 +177,12 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x41
+		>;
+	};
+
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index 27afa46a253a..72a3a3aa8fcd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -5,9 +5,11 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 
 / {
 	aliases {
+		ethernet1 = &eth1;
 		usb0 = &usbotg1;
 		usb1 = &usbotg2;
 	};
@@ -33,6 +35,12 @@
 		};
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		pinctrl-names = "default";
@@ -106,6 +114,54 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk>;
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-rates = <10000000>, <250000000>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x0000 0 0 0 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pcie@1,0 {
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pcie@2,3 {
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eth1: pcie@5,0 {
+					reg = <0x0000 0 0 0 0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					local-mac-address = [00 00 00 00 00 00];
+				};
+			};
+		};
+	};
+};
+
 /* off-board header */
 &sai3 {
 	pinctrl-names = "default";
@@ -198,6 +254,12 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x41
+		>;
+	};
+
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
index a59e849c7be2..7b00b6b5bb38 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -5,9 +5,11 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 
 / {
 	aliases {
+		ethernet1 = &eth1;
 		usb0 = &usbotg1;
 		usb1 = &usbotg2;
 	};
@@ -33,6 +35,12 @@
 		};
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		pinctrl-names = "default";
@@ -126,6 +134,54 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk>;
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-rates = <10000000>, <250000000>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x0000 0 0 0 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pcie@1,0 {
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pcie@2,4 {
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eth1: pcie@6,0 {
+					reg = <0x0000 0 0 0 0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					local-mac-address = [00 00 00 00 00 00];
+				};
+			};
+		};
+	};
+};
+
 /* off-board header */
 &sai3 {
 	pinctrl-names = "default";
@@ -241,6 +297,12 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6	0x41
+		>;
+	};
+
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 65ee72fc1487..4bf2b97b3ef5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 
 #include "imx8mm.dtsi"
 
@@ -179,6 +180,12 @@
 		};
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "3P3V";
@@ -644,6 +651,28 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk>;
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio5 2 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-rates = <10000000>, <250000000>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	status = "okay";
+};
+
 &pgc_gpu {
 	status = "disabled";
 };
@@ -820,6 +849,13 @@
 		>;
 	};
 
+	pinctrl_pcie0: pciegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x40000041 /* WDIS# */
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x41
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20	0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index d52686f4c059..1b2aaf299b24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 
 #include "imx8mm.dtsi"
 
@@ -17,6 +18,7 @@
 	compatible = "gw,imx8mm-gw7902", "fsl,imx8mm";
 
 	aliases {
+		ethernet1 = &eth1;
 		usb0 = &usbotg1;
 		usb1 = &usbotg2;
 	};
@@ -128,6 +130,12 @@
 		};
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	pps {
 		compatible = "pps-gpio";
 		pinctrl-names = "default";
@@ -547,6 +555,42 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&clk IMX8MM_CLK_DUMMY>;
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 5 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-rates = <10000000>, <250000000>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x0000 0 0 0 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth1: pcie@1,0 {
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			local-mac-address = [00 00 00 00 00 00];
+		};
+	};
+};
+
 /* off-board header */
 &sai3 {
 	pinctrl-names = "default";
@@ -737,6 +781,12 @@
 		>;
 	};
 
+	pinctrl_pcie0: pciegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x41
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8	0x41
-- 
2.17.1

