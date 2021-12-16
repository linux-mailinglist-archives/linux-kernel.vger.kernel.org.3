Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27CB477C89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhLPT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:29:04 -0500
Received: from finn.gateworks.com ([108.161.129.64]:36086 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232560AbhLPT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:29:03 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mxwQy-0093O5-0a; Thu, 16 Dec 2021 19:28:56 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlay for imx219 rpi v2 camera
Date:   Thu, 16 Dec 2021 11:28:54 -0800
Message-Id: <20211216192854.26427-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RaspberryPi Camera v2 which is an IMX219 8MP module:
 - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
 - has its own on-board 24MHz osc so no clock required from baseboard
 - pin 11 enables 1.8V and 2.8V LDO which is connected to
   GW73xx MIPI_GPIO4 (IMX8MM GPIO1_IO1) so we use this as a gpio
   controlled regulator enable.

Support is added via a device-tree overlay.

The IMX219 supports RAW8/RAW10 image formats.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../imx8mm-venice-gw73xx-0x-imx219.dts        | 84 +++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 5ec8d59347b6..eb9fe81ce61e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-imx219.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
new file mode 100644
index 000000000000..2b76c3201ad6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mm-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
+
+	reg_cam: regulator-cam {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_cam>;
+		compatible = "regulator-fixed";
+		regulator-name = "reg_cam";
+		gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	cam24m: cam24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "cam24m";
+	};
+};
+
+&csi {
+	status = "okay";
+};
+
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	imx219: sensor@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&cam24m>;
+		VDIG-supply = <&reg_cam>;
+
+		port {
+			/* MIPI CSI-2 bus endpoint */
+			imx219_to_mipi_csi2: endpoint {
+				remote-endpoint = <&imx8mm_mipi_csi_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
+};
+
+&mipi_csi {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			imx8mm_mipi_csi_in: endpoint {
+				remote-endpoint = <&imx219_to_mipi_csi2>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_reg_cam: regcamgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1	0x41
+		>;
+	};
+};
-- 
2.17.1

