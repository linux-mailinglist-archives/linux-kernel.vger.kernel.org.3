Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E36495BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379473AbiAUISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:18:50 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48796 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379488AbiAUISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:33 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B21D21BE5;
        Fri, 21 Jan 2022 09:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753102;
        bh=lBC5b4kV8HrL/lrzJBBA+UGHFsGP4j1YLwAfhDKoIbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMu71+o9LBUCQWsyI2dP21AxrgDjEXHdjzjC0W98UHi4RqkzLtWGgOL6sRqYdHKOA
         FKEfdXg8PE0dg7l0RObJxnaXOvwHizzz+t2Uj3FVMquun5vHzjGT+T/A62mGppy3um
         dzbnHqSCgbU7paQCUV19DO7TxTSZeVVtzEuDW5LY=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 7/7] media: bcm283x: Include the imx219 node
Date:   Fri, 21 Jan 2022 09:18:10 +0100
Message-Id: <20220121081810.155500-8-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the csi1 endpoint, add the imx219 node and connect it through
the i2c mux.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 MAINTAINERS                               |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts     |   1 +
 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi | 102 ++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index b17bb533e007..56544ac98d69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3684,6 +3684,7 @@ M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
+F:	arch/arm/boot/dts/bcm283x*
 F:	drivers/media/platform/bcm2835/
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
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

