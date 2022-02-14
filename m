Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883334B5E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiBNXOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:14:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiBNXOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:14:48 -0500
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBE1B10FC;
        Mon, 14 Feb 2022 15:14:39 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nJkYC-00AkNe-Cy; Mon, 14 Feb 2022 23:14:32 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 4/4] arm64: dts: imx8mm-venice-gw72xx-0x: add dt overlay for imx219 rpi v2 camera
Date:   Mon, 14 Feb 2022 15:14:24 -0800
Message-Id: <20220214231424.30927-5-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214231424.30927-1-tharvey@gateworks.com>
References: <20220214231424.30927-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RaspberryPi Camera v2 which is an IMX219 8MP module:
 - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
 - has its own on-board 24MHz osc so no clock required from baseboard
 - pin 11 enables 1.8V and 2.8V LDO which is connected to
   GW73xx MIPI_GPIO4 (IMX8MM GPIO1_IO1) so we use this as a gpio

Support is added via a device-tree overlay.

The IMX219 supports RAW8/RAW10 image formats.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3: use overlay target for simplicity
v2:
 - added DTC_FLAGS
 - add line between prop and subnode of mipi_csi/port@0
 - add mipi_csi/port@1 to fix compile warning
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx8mm-venice-gw72xx-0x-imx219.dts        | 93 +++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a84463bea15c..7f51b537df40 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -99,6 +99,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 
+imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
 imx8mm-venice-gw72xx-0x-rs422-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs422.dtbo
 imx8mm-venice-gw72xx-0x-rs485-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs485.dtbo
@@ -107,6 +108,7 @@ imx8mm-venice-gw73xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-ven
 imx8mm-venice-gw73xx-0x-rs422-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs422.dtbo
 imx8mm-venice-gw73xx-0x-rs485-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs485.dtbo
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-imx219.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs232-rts.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs422.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs485.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts
new file mode 100644
index 000000000000..4eaf8aabcbff
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Gateworks Corporation
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
+	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
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
+
+			imx8mm_mipi_csi_in: endpoint {
+				remote-endpoint = <&imx219_to_mipi_csi2>;
+				data-lanes = <1 2>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			imx8mm_mipi_csi_out: endpoint {
+				remote-endpoint = <&csi_in>;
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

