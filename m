Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61974A8AED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353514AbiBCRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:52:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59002 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353235AbiBCRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:50 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5173:4d3f:4ddc:2012])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E60E01C4C;
        Thu,  3 Feb 2022 18:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643910630;
        bh=3lrGwNeqv8zUuSa8vZIr+ceF4CcaJqG9pp3tPlC2K/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVSBrSufYzDbkdy3RP2C9vBMveY7RjztG8OuOAiX9EsU5MJqPqLI5lQymotrPc03T
         WAu748J89PIwUOjSw4M66got0kEFdywOCuPvzTOTf0SxgB5nC6y5MRkMATQPzvWAss
         yR3QRHB899ZKwc8E3J0PwGfaXiX2JSqkKkiIiVOc=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [RFC PATCH v4 12/12] media: bcm283x: Include the imx219 node
Date:   Thu,  3 Feb 2022 18:50:09 +0100
Message-Id: <20220203175009.558868-13-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING:
This patch is only used to demonstrate how the imx219 node is included
in the bcm2711-rpi-4-b device tree, and is not intended to be merged.

Configure the csi1 endpoint, add the imx219 node and connect it through
the i2c mux.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts     |   1 +
 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi | 102 ++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 4432412044de..f7625b70fe57 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -4,6 +4,7 @@
 #include "bcm2711-rpi.dtsi"
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 #include "bcm283x-rpi-wifi-bt.dtsi"
+#include "bcm283x-rpi-imx219.dtsi"
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
diff --git a/arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi b/arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
new file mode 100644
index 000000000000..f2c6a85fd731
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/clock/bcm2835.h>
+
+/ {
+	compatible = "brcm,bcm2835";
+
+	imx219_vdig: fixedregulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "imx219_vdig";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	imx219_vddl: fixedregulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "imx219_vddl";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	imx219_clk: imx219_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "24MHz-clock";
+	};
+
+	cam1_reg: cam1_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "imx219_vana";
+		enable-active-high;
+		status = "okay";
+		gpio = <&expgpio 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	i2c0mux {
+		compatible = "i2c-mux-pinctrl";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c-parent = <&i2c0>;
+
+		pinctrl-names = "i2c0", "i2c_csi_dsi";
+		pinctrl-0 = <&i2c0_gpio0>;
+		pinctrl-1 = <&i2c0_gpio44>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			imx219: sensor@10 {
+				compatible = "sony,imx219";
+				reg = <0x10>;
+				status = "okay";
+
+				clocks = <&imx219_clk>;
+				clock-names = "xclk";
+
+				VANA-supply = <&cam1_reg>;   /* 2.8v */
+				VDIG-supply = <&imx219_vdig>;   /* 1.8v */
+				VDDL-supply = <&imx219_vddl>;   /* 1.2v */
+
+				rotation = <0>;
+				orientation = <0>;
+
+				port {
+					imx219_0: endpoint {
+						remote-endpoint = <&csi1_ep>;
+						clock-lanes = <0>;
+						data-lanes = <1 2>;
+						clock-noncontinuous;
+						link-frequencies = /bits/ 64 <456000000>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&csi1 {
+	status="okay";
+	num-data-lanes = <2>;
+	port {
+		csi1_ep: endpoint {
+			remote-endpoint = <&imx219_0>;
+			data-lanes = <1 2>;
+			clock-lanes = <0>;
+		};
+	};
+};
+
+&i2c0 {
+	/delete-property/ pinctrl-names;
+	/delete-property/ pinctrl-0;
+};
+
-- 
2.32.0

