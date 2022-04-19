Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3DB506380
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiDSEwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiDSEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178B2F382
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:49 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002ub-FT; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047RY-Ss; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 12/17] ARM: dts: imx6qdl-vicut1.dtsi: Move some node out to DTS files
Date:   Tue, 19 Apr 2022 06:48:19 +0200
Message-Id: <20220419044824.981747-13-o.rempel@pengutronix.de>
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

This commit will finally make this file identical to imx6qdl-victgo.dtsi.
All nodes that are removed here are added as-is to the DTS files that
include this file.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-vicut1.dts   | 122 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-vicut1.dts    | 122 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 120 -------------------------
 arch/arm/boot/dts/imx6qp-vicutp.dts   | 122 ++++++++++++++++++++++++++
 4 files changed, 366 insertions(+), 120 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-vicut1.dts b/arch/arm/boot/dts/imx6dl-vicut1.dts
index 174fd913bf96..c6a904bbed01 100644
--- a/arch/arm/boot/dts/imx6dl-vicut1.dts
+++ b/arch/arm/boot/dts/imx6dl-vicut1.dts
@@ -10,4 +10,126 @@
 / {
 	model = "Kverneland UT1 Board";
 	compatible = "kvg,vicut1", "fsl,imx6dl";
+
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
 };
diff --git a/arch/arm/boot/dts/imx6q-vicut1.dts b/arch/arm/boot/dts/imx6q-vicut1.dts
index e6c5d3cb48d7..8b228d5fc4a3 100644
--- a/arch/arm/boot/dts/imx6q-vicut1.dts
+++ b/arch/arm/boot/dts/imx6q-vicut1.dts
@@ -10,4 +10,126 @@
 / {
 	model = "Kverneland UT1Q Board";
 	compatible = "kvg,vicut1q", "fsl,imx6q";
+
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
 };
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index 6c943ca950f4..2a86136a04e8 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -70,20 +70,6 @@ counter-2 {
 		gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 	};
 
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
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -111,18 +97,6 @@ led-2 {
 		};
 	};
 
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
-
 	reg_1v8: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "1v8";
@@ -231,38 +205,6 @@ flash@0 {
 	};
 };
 
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
 &gpio2 {
 	gpio-line-names =
 		"YACO_WHEEL", "YACO_RADAR", "YACO_PTO", "", "", "", "", "",
@@ -282,38 +224,6 @@ &gpio3 {
 			"YACO_RESET";
 };
 
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
 &gpio7 {
 	gpio-line-names =
 		"EMMC_DAT5", "EMMC_DAT4", "EMMC_CMD", "EMMC_CLK", "EMMC_DAT0",
@@ -589,36 +499,6 @@ MX6QDL_PAD_EIM_D19__GPIO3_IO19			0x000b1
 		>;
 	};
 
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
-
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* ITU656_nRESET */
diff --git a/arch/arm/boot/dts/imx6qp-vicutp.dts b/arch/arm/boot/dts/imx6qp-vicutp.dts
index 7bad7ca6b12e..31c748e9d92f 100644
--- a/arch/arm/boot/dts/imx6qp-vicutp.dts
+++ b/arch/arm/boot/dts/imx6qp-vicutp.dts
@@ -10,4 +10,126 @@
 / {
 	model = "Kverneland UT1P Board";
 	compatible = "kvg,vicutp", "fsl,imx6qp";
+
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
 };
-- 
2.30.2

