Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D61506383
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348354AbiDSEww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348371AbiDSEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B52F38A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:50 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmx-0002ud-Rr; Tue, 19 Apr 2022 06:48:31 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfms-0047Rq-0G; Tue, 19 Apr 2022 06:48:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 14/17] ARM: dts: imx6qdl-vicut1: Factor out common parts of 12inch board variants
Date:   Tue, 19 Apr 2022 06:48:21 +0200
Message-Id: <20220419044824.981747-15-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419044824.981747-1-o.rempel@pengutronix.de>
References: <20220419044824.981747-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

Factor out common parts of vicut1 and vicutp to reduce maintenance
overhead.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-vicut1.dts          | 123 +-----------------
 arch/arm/boot/dts/imx6q-vicut1.dts           | 123 +-----------------
 arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi | 128 +++++++++++++++++++
 arch/arm/boot/dts/imx6qp-vicutp.dts          | 123 +-----------------
 4 files changed, 131 insertions(+), 366 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-vicut1.dts b/arch/arm/boot/dts/imx6dl-vicut1.dts
index c6a904bbed01..5035d303447d 100644
--- a/arch/arm/boot/dts/imx6dl-vicut1.dts
+++ b/arch/arm/boot/dts/imx6dl-vicut1.dts
@@ -6,130 +6,9 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-vicut1.dtsi"
+#include "imx6qdl-vicut1-12inch.dtsi"
 
 / {
 	model = "Kverneland UT1 Board";
 	compatible = "kvg,vicut1", "fsl,imx6dl";
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-		autorepeat;
-
-		power {
-			label = "Power Button";
-			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_POWER>;
-			wakeup-source;
-		};
-	};
-
-	panel {
-		compatible = "kyo,tcg121xglp";
-		backlight = <&backlight_lcd>;
-		power-supply = <&reg_3v3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&rgmii_phy>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Microchip KSZ9031RNX PHY */
-		rgmii_phy: ethernet-phy@0 {
-			reg = <0>;
-			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <300>;
-		};
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"CAN1_TERM", "SD1_CD", "ITU656_RESET", "CAM1_MIRROR",
-			"CAM2_MIRROR", "", "", "SMBALERT",
-		"DEBUG_0", "DEBUG_1", "", "", "", "", "", "",
-		"SD1_DATA0", "SD1_DATA1", "SD1_CMD", "SD1_DATA2", "SD1_CLK",
-			"SD1_DATA3", "ETH_MDIO", "",
-		"", "ETH_RESET", "", "", "ETH_INT", "", "", "ETH_MDC";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
-		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
-			"CAN2_SR", "CAN2_TX", "CAN2_RX",
-		"", "", "DIP1_FB", "", "VCAM_EN", "ON1_CTRL", "ON2_CTRL",
-			"HITCH_IN_OUT",
-		"LIGHT_ON", "", "", "CONTACT_IN", "BL_EN", "BL_PWM", "",
-			"ISB_LED";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "ITU656_CLK", "I2S_MCLK", "ITU656_PDN", "AUDIO_RESET",
-			"I2S_BITCLK", "I2S_DOUT",
-		"I2S_LRCLK", "I2S_DIN", "I2C1_SDA", "I2C1_SCL", "YACO_AUX_RX",
-			"YACO_AUX_TX", "ITU656_D0", "ITU656_D1";
-};
-
-&gpio6 {
-	gpio-line-names =
-		"ITU656_D2", "ITU656_D3", "ITU656_D4", "ITU656_D5",
-			"ITU656_D6", "ITU656_D7", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "RGMII_TXC", "RGMII_TD0", "RGMII_TD1", "RGMII_TD2",
-			"RGMII_TD3",
-		"RGMII_RX_CTL", "RGMII_RD0", "RGMII_TX_CTL", "RGMII_RD1",
-			"RGMII_RD2", "RGMII_RD3", "", "";
-};
-
-&iomuxc {
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x10030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x10030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x10030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x10030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x10030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x10030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x10030
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x10030
-			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x10030
-			/* Phy reset */
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25		0x1b0b0
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x1b0b1
-		>;
-	};
-
-	pinctrl_gpiokeys: gpiokeygrp {
-		fsl,pins = <
-			/* nON_SWITCH */
-			MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6q-vicut1.dts b/arch/arm/boot/dts/imx6q-vicut1.dts
index 8b228d5fc4a3..dd91aff3f9e2 100644
--- a/arch/arm/boot/dts/imx6q-vicut1.dts
+++ b/arch/arm/boot/dts/imx6q-vicut1.dts
@@ -6,130 +6,9 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-vicut1.dtsi"
+#include "imx6qdl-vicut1-12inch.dtsi"
 
 / {
 	model = "Kverneland UT1Q Board";
 	compatible = "kvg,vicut1q", "fsl,imx6q";
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-		autorepeat;
-
-		power {
-			label = "Power Button";
-			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_POWER>;
-			wakeup-source;
-		};
-	};
-
-	panel {
-		compatible = "kyo,tcg121xglp";
-		backlight = <&backlight_lcd>;
-		power-supply = <&reg_3v3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&rgmii_phy>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Microchip KSZ9031RNX PHY */
-		rgmii_phy: ethernet-phy@0 {
-			reg = <0>;
-			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <300>;
-		};
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"CAN1_TERM", "SD1_CD", "ITU656_RESET", "CAM1_MIRROR",
-			"CAM2_MIRROR", "", "", "SMBALERT",
-		"DEBUG_0", "DEBUG_1", "", "", "", "", "", "",
-		"SD1_DATA0", "SD1_DATA1", "SD1_CMD", "SD1_DATA2", "SD1_CLK",
-			"SD1_DATA3", "ETH_MDIO", "",
-		"", "ETH_RESET", "", "", "ETH_INT", "", "", "ETH_MDC";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
-		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
-			"CAN2_SR", "CAN2_TX", "CAN2_RX",
-		"", "", "DIP1_FB", "", "VCAM_EN", "ON1_CTRL", "ON2_CTRL",
-			"HITCH_IN_OUT",
-		"LIGHT_ON", "", "", "CONTACT_IN", "BL_EN", "BL_PWM", "",
-			"ISB_LED";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "ITU656_CLK", "I2S_MCLK", "ITU656_PDN", "AUDIO_RESET",
-			"I2S_BITCLK", "I2S_DOUT",
-		"I2S_LRCLK", "I2S_DIN", "I2C1_SDA", "I2C1_SCL", "YACO_AUX_RX",
-			"YACO_AUX_TX", "ITU656_D0", "ITU656_D1";
-};
-
-&gpio6 {
-	gpio-line-names =
-		"ITU656_D2", "ITU656_D3", "ITU656_D4", "ITU656_D5",
-			"ITU656_D6", "ITU656_D7", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "RGMII_TXC", "RGMII_TD0", "RGMII_TD1", "RGMII_TD2",
-			"RGMII_TD3",
-		"RGMII_RX_CTL", "RGMII_RD0", "RGMII_TX_CTL", "RGMII_RD1",
-			"RGMII_RD2", "RGMII_RD3", "", "";
-};
-
-&iomuxc {
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x10030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x10030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x10030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x10030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x10030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x10030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x10030
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x10030
-			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x10030
-			/* Phy reset */
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25		0x1b0b0
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x1b0b1
-		>;
-	};
-
-	pinctrl_gpiokeys: gpiokeygrp {
-		fsl,pins = <
-			/* nON_SWITCH */
-			MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi
new file mode 100644
index 000000000000..f505f2704530
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 Protonic Holland
+ */
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+		autorepeat;
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	panel {
+		compatible = "kyo,tcg121xglp";
+		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmii_phy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Microchip KSZ9031RNX PHY */
+		rgmii_phy: ethernet-phy@0 {
+			reg = <0>;
+			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
+			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <300>;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"CAN1_TERM", "SD1_CD", "ITU656_RESET", "CAM1_MIRROR",
+			"CAM2_MIRROR", "", "", "SMBALERT",
+		"DEBUG_0", "DEBUG_1", "", "", "", "", "", "",
+		"SD1_DATA0", "SD1_DATA1", "SD1_CMD", "SD1_DATA2", "SD1_CLK",
+			"SD1_DATA3", "ETH_MDIO", "",
+		"", "ETH_RESET", "", "", "ETH_INT", "", "", "ETH_MDC";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
+		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
+			"CAN2_SR", "CAN2_TX", "CAN2_RX",
+		"", "", "DIP1_FB", "", "VCAM_EN", "ON1_CTRL", "ON2_CTRL",
+			"HITCH_IN_OUT",
+		"LIGHT_ON", "", "", "CONTACT_IN", "BL_EN", "BL_PWM", "",
+			"ISB_LED";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "ITU656_CLK", "I2S_MCLK", "ITU656_PDN", "AUDIO_RESET",
+			"I2S_BITCLK", "I2S_DOUT",
+		"I2S_LRCLK", "I2S_DIN", "I2C1_SDA", "I2C1_SCL", "YACO_AUX_RX",
+			"YACO_AUX_TX", "ITU656_D0", "ITU656_D1";
+};
+
+&gpio6 {
+	gpio-line-names =
+		"ITU656_D2", "ITU656_D3", "ITU656_D4", "ITU656_D5",
+			"ITU656_D6", "ITU656_D7", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "RGMII_TXC", "RGMII_TD0", "RGMII_TD1", "RGMII_TD2",
+			"RGMII_TD3",
+		"RGMII_RX_CTL", "RGMII_RD0", "RGMII_TX_CTL", "RGMII_RD1",
+			"RGMII_RD2", "RGMII_RD3", "", "";
+};
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x10030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x10030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x10030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x10030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x10030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x10030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x10030
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x10030
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x10030
+			/* Phy reset */
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25		0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x1b0b1
+		>;
+	};
+
+	pinctrl_gpiokeys: gpiokeygrp {
+		fsl,pins = <
+			/* nON_SWITCH */
+			MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qp-vicutp.dts b/arch/arm/boot/dts/imx6qp-vicutp.dts
index 31c748e9d92f..49ff145fffe5 100644
--- a/arch/arm/boot/dts/imx6qp-vicutp.dts
+++ b/arch/arm/boot/dts/imx6qp-vicutp.dts
@@ -6,130 +6,9 @@
 /dts-v1/;
 #include "imx6qp.dtsi"
 #include "imx6qdl-vicut1.dtsi"
+#include "imx6qdl-vicut1-12inch.dtsi"
 
 / {
 	model = "Kverneland UT1P Board";
 	compatible = "kvg,vicutp", "fsl,imx6qp";
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-		autorepeat;
-
-		power {
-			label = "Power Button";
-			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_POWER>;
-			wakeup-source;
-		};
-	};
-
-	panel {
-		compatible = "kyo,tcg121xglp";
-		backlight = <&backlight_lcd>;
-		power-supply = <&reg_3v3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&rgmii_phy>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Microchip KSZ9031RNX PHY */
-		rgmii_phy: ethernet-phy@0 {
-			reg = <0>;
-			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <300>;
-		};
-	};
-};
-
-&gpio1 {
-	gpio-line-names =
-		"CAN1_TERM", "SD1_CD", "ITU656_RESET", "CAM1_MIRROR",
-			"CAM2_MIRROR", "", "", "SMBALERT",
-		"DEBUG_0", "DEBUG_1", "", "", "", "", "", "",
-		"SD1_DATA0", "SD1_DATA1", "SD1_CMD", "SD1_DATA2", "SD1_CLK",
-			"SD1_DATA3", "ETH_MDIO", "",
-		"", "ETH_RESET", "", "", "ETH_INT", "", "", "ETH_MDC";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
-		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
-			"CAN2_SR", "CAN2_TX", "CAN2_RX",
-		"", "", "DIP1_FB", "", "VCAM_EN", "ON1_CTRL", "ON2_CTRL",
-			"HITCH_IN_OUT",
-		"LIGHT_ON", "", "", "CONTACT_IN", "BL_EN", "BL_PWM", "",
-			"ISB_LED";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "ITU656_CLK", "I2S_MCLK", "ITU656_PDN", "AUDIO_RESET",
-			"I2S_BITCLK", "I2S_DOUT",
-		"I2S_LRCLK", "I2S_DIN", "I2C1_SDA", "I2C1_SCL", "YACO_AUX_RX",
-			"YACO_AUX_TX", "ITU656_D0", "ITU656_D1";
-};
-
-&gpio6 {
-	gpio-line-names =
-		"ITU656_D2", "ITU656_D3", "ITU656_D4", "ITU656_D5",
-			"ITU656_D6", "ITU656_D7", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "RGMII_TXC", "RGMII_TD0", "RGMII_TD1", "RGMII_TD2",
-			"RGMII_TD3",
-		"RGMII_RX_CTL", "RGMII_RD0", "RGMII_TX_CTL", "RGMII_RD1",
-			"RGMII_RD2", "RGMII_RD3", "", "";
-};
-
-&iomuxc {
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x10030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x10030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x10030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x10030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x10030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x10030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x10030
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x10030
-			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x10030
-			/* Phy reset */
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25		0x1b0b0
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x1b0b1
-		>;
-	};
-
-	pinctrl_gpiokeys: gpiokeygrp {
-		fsl,pins = <
-			/* nON_SWITCH */
-			MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
-		>;
-	};
 };
-- 
2.30.2

