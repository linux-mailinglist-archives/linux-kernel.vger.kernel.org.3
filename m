Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8034FD4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354346AbiDLJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiDLIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:10:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB01098
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:40:18 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1neB8A-0007gA-Ll; Tue, 12 Apr 2022 09:40:06 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1neB89-00AQYt-7s; Tue, 12 Apr 2022 09:40:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v1 02/17] arm: dts: imx6qdl-vicut1.dtsi: Put nON_SWITCH in own pinctrl grp
Date:   Tue, 12 Apr 2022 09:39:49 +0200
Message-Id: <20220412074004.2485264-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412074004.2485264-1-o.rempel@pengutronix.de>
References: <20220412074004.2485264-1-o.rempel@pengutronix.de>
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

Unify nON_SWITCH pinctrl configuration with imx6dl-victgo.dts.

This patch is a preparation to reduce duplicated code between vicut1 and
victgo.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index fe2685642bf1..32f7eb379e60 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -72,6 +72,8 @@ counter-2 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
 		autorepeat;
 
 		power {
@@ -621,6 +623,13 @@ MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x1b0b1
 		>;
 	};
 
+	pinctrl_gpiokeys: gpiokeygrp {
+		fsl,pins = <
+			/* nON_SWITCH */
+			MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
+		>;
+	};
+
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* ITU656_nRESET */
@@ -631,8 +640,6 @@ MX6QDL_PAD_GPIO_3__GPIO1_IO03			0x130b0
 			MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x130b0
 			/* CAM_nDETECT */
 			MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x1b0b0
-			/* nON_SWITCH */
-			MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
 			/* ISB_IN1 */
 			MX6QDL_PAD_EIM_A16__GPIO2_IO22			0x130b0
 			/* ISB_nIN2 */
-- 
2.30.2

