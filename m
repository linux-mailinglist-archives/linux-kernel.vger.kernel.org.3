Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572B506381
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbiDSEwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiDSEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393B42F3A5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:50 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002uZ-FN; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047RF-PB; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 10/17] ARM: dts: imx6dl-victgo.dts: update gpio names
Date:   Tue, 19 Apr 2022 06:48:17 +0200
Message-Id: <20220419044824.981747-11-o.rempel@pengutronix.de>
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

Following changes was made:
- Add MDIO signal names
- Add missing ISB_IN2 name. Also correct ISB_nIN1. These two signals were used
  together in older HW revisions. Later ISB_IN2 was removed. Software should
  still be able to use both.
- Add missing CAN1 and UART line names
- Add missing ON1/2_CTRL line names
- fix CPU_* line names. The real signal names are without the CPU_ prefix, like
  on imx6qdl-vicut1.dtsi
- Fix ETH_INT signal name

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-victgo.dts | 41 ++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 9cf4df3eaeb0..7fc5bb499cbc 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -408,8 +408,8 @@ &gpio1 {
 			"CAM2_MIRROR", "", "", "SMBALERT",
 		"DEBUG_0", "DEBUG_1", "", "", "", "", "", "",
 		"SD1_DATA0", "SD1_DATA1", "SD1_CMD", "SD1_DATA2", "SD1_CLK",
-			"SD1_DATA3", "", "",
-		"", "", "", "", "", "", "", "";
+			"SD1_DATA3", "ETH_MDIO", "",
+		"", "", "", "", "", "", "", "ETH_MDC";
 };
 
 &gpio2 {
@@ -417,7 +417,7 @@ &gpio2 {
 		"YACO_WHEEL", "YACO_RADAR", "YACO_PTO", "", "", "", "", "",
 		"", "LED_PWM", "", "", "",
 			"", "", "",
-		"", "", "", "", "", "", "ISB_IN1", "ON_SWITCH",
+		"", "", "", "", "", "ISB_IN2", "ISB_nIN1", "ON_SWITCH",
 		"POWER_LED", "", "", "", "", "", "", "";
 };
 
@@ -426,18 +426,20 @@ &gpio3 {
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
 		"ECSPI1_SCLK", "ECSPI1_MISO", "ECSPI1_MOSI", "ECSPI1_SS1",
-			"CPU_ON1_FB", "USB_EXT1_OC", "USB_EXT1_PWR", "YACO_IRQ",
+			"CPU_ON1_FB", "USB_OTG_OC", "USB_OTG_PWR", "YACO_IRQ",
 		"TSS_TXD", "TSS_RXD", "", "", "", "", "YACO_BOOT0",
 			"YACO_RESET";
 };
 
 &gpio4 {
 	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "CAN1_SR", "CAN2_SR", "CAN2_TX", "CAN2_RX",
-		"", "", "DIP1_FB", "", "VCAM_EN", "", "", "",
-		"CPU_LIGHT_ON", "", "ETH_RESET", "CPU_CONTACT_IN", "BL_EN",
-			"BL_PWM", "ETH_INTRP", "ISB_LED";
+		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
+		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
+			"CAN2_SR", "CAN2_TX", "CAN2_RX",
+		"", "", "DIP1_FB", "", "VCAM_EN", "ON1_CTRL", "ON2_CTRL",
+			"HITCH_IN_OUT",
+		"LIGHT_ON", "", "ETH_RESET", "CONTACT_IN", "BL_EN",
+			"BL_PWM", "ETH_INT", "ISB_LED";
 };
 
 &gpio5 {
@@ -445,11 +447,30 @@ &gpio5 {
 		"", "", "", "", "", "", "", "",
 		"TSC_PENIRQ", "TSC_BUSY", "ECSPI2_MOSI", "ECSPI2_MISO",
 			"ECSPI2_SS0", "ECSPI2_SCLK", "", "",
-		"", "", "", "", "", "", "", "",
+		"", "", "ITU656_CLK", "I2S_MCLK", "ITU656_PDN", "AUDIO_RESET",
+			"I2S_BITCLK", "I2S_DOUT",
 		"I2S_LRCLK", "I2S_DIN", "I2C1_SDA", "I2C1_SCL", "YACO_AUX_RX",
 			"YACO_AUX_TX", "ITU656_D0", "ITU656_D1";
 };
 
+&gpio6 {
+	gpio-line-names =
+		"ITU656_D2", "ITU656_D3", "ITU656_D4", "ITU656_D5",
+			"ITU656_D6", "ITU656_D7", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio7 {
+	gpio-line-names =
+		"EMMC_DAT5", "EMMC_DAT4", "EMMC_CMD", "EMMC_CLK", "EMMC_DAT0",
+			"EMMC_DAT1", "EMMC_DAT2", "EMMC_DAT3",
+		"EMMC_RST", "", "", "", "CAM_DETECT", "", "", "",
+		"", "EMMC_DAT7", "EMMC_DAT6", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.30.2

