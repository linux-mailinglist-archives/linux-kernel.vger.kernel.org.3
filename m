Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3494BE9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354881AbiBUKdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:33:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355009AbiBUKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:33:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577101D30F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:53:34 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nM5Nb-0007AV-9r; Mon, 21 Feb 2022 10:53:15 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nM5NZ-00FUeR-K4; Mon, 21 Feb 2022 10:53:13 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 3/8] ARM: dts: imx6qdl-vicut1/vicutgo: Add backlight_led node
Date:   Mon, 21 Feb 2022 10:53:07 +0100
Message-Id: <20220221095312.3692669-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221095312.3692669-1-o.rempel@pengutronix.de>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
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

backlight_led is the dimmable backlight for the rubber border on the case. It
is also used to highlight the power- and some other buttons.

MX6QDL_PAD_SD4_DAT1__PWM3_OUT is also assigned as output for pwm3. Since
we need pwm3 for the backlight, we're forced to disable user space hardware
revision detection. The bootloader will have to supply this information
(i.e. through device tree).

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-victgo.dts   | 24 +++++++++----------
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 33 +++++++++++++++++----------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 833340c30537..d542ddad4e32 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -33,6 +33,15 @@ backlight_lcd: backlight {
 		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	};
 
+	backlight_led: backlight_led {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 5000000 0>;
+		brightness-levels = <0 16 64 255>;
+		num-interpolated-steps = <16>;
+		default-brightness-level = <48>;
+		power-supply = <&reg_3v3>;
+	};
+
 	connector {
 		compatible = "composite-video-connector";
 		label = "Composite0";
@@ -392,8 +401,8 @@ &gpio1 {
 &gpio2 {
 	gpio-line-names =
 		"", "", "", "", "", "", "", "",
-		"REV_ID0", "REV_ID1", "REV_ID2", "REV_ID3", "REV_ID4",
-			"BOARD_ID0", "BOARD_ID1", "BOARD_ID2",
+		"", "LED_PWM", "", "", "",
+			"", "", "",
 		"", "", "", "", "", "", "ISB_IN1", "ON_SWITCH",
 		"POWER_LED", "", "", "", "", "", "", "";
 };
@@ -778,17 +787,6 @@ MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21		0x1f0b0
 			/* ITU656_nPDN */
 			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x1b0b0
 
-			/* HW revision detect */
-			/* REV_ID0 */
-			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08			0x1b0b0
-			/* REV_ID1 is shared with PWM3 */
-			/* REV_ID2 */
-			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10			0x1b0b0
-			/* REV_ID3 */
-			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11			0x1b0b0
-			/* REV_ID4 */
-			MX6QDL_PAD_SD4_DAT4__GPIO2_IO12			0x1b0b0
-
 			/* New in HW revision 1 */
 			/* ON1_FB */
 			MX6QDL_PAD_EIM_D20__GPIO3_IO20			0x100b0
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index a1fbbc9c26b6..2f6b263eea66 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -28,6 +28,15 @@ backlight_lcd: backlight {
 		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
 	};
 
+	backlight_led: backlight_led {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 5000000 0>;
+		brightness-levels = <0 16 64 255>;
+		num-interpolated-steps = <16>;
+		default-brightness-level = <48>;
+		power-supply = <&reg_3v3>;
+	};
+
 	connector {
 		compatible = "composite-video-connector";
 		label = "Composite0";
@@ -448,6 +457,12 @@ &pwm1 {
 	status = "okay";
 };
 
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
 &ssi1 {
 	#sound-dai-cells = <0>;
 	fsl,mode = "ac97-slave";
@@ -669,18 +684,6 @@ MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21		0x1f0b0
 			/* ITU656_nPDN */
 			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x1b0b0
 
-			/* HW revision detect */
-			/* REV_ID0 */
-			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08			0x1b0b0
-			/* REV_ID1 */
-			MX6QDL_PAD_SD4_DAT1__GPIO2_IO09			0x1b0b0
-			/* REV_ID2 */
-			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10			0x1b0b0
-			/* REV_ID3 */
-			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11			0x1b0b0
-			/* REV_ID4 */
-			MX6QDL_PAD_SD4_DAT4__GPIO2_IO12			0x1b0b0
-
 			/* New in HW revision 1 */
 			/* ON1_FB */
 			MX6QDL_PAD_EIM_D20__GPIO3_IO20			0x100b0
@@ -738,6 +741,12 @@ MX6QDL_PAD_DISP0_DAT8__PWM1_OUT			0x1b0b0
 		>;
 	};
 
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b0
+		>;
+	};
+
 	/* YaCO AUX Uart */
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-- 
2.30.2

