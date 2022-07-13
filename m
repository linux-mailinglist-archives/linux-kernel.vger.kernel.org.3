Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AF4573158
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiGMIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiGMIkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:40:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44BDF639
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:40:38 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oBXvB-00046d-6h; Wed, 13 Jul 2022 10:40:37 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] Revert "reset: microchip-sparx5: allow building as a module"
Date:   Wed, 13 Jul 2022 10:40:10 +0200
Message-Id: <20220713084010.168720-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b6b9585876da018bdde2d5f15d206a689c0d70f3.

This breaks MDIO on kswitch-d10, presumably because the global switch
reset is not released early enough anymore.

Reported-by: Michael Walle <michael@walle.cc>
Cc: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig                  | 2 +-
 drivers/reset/reset-microchip-sparx5.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d9a08ec343e2..f9a7cee01659 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -115,7 +115,7 @@ config RESET_LPC18XX
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
 config RESET_MCHP_SPARX5
-	tristate "Microchip Sparx5 reset driver"
+	bool "Microchip Sparx5 reset driver"
 	depends on ARCH_SPARX5 || SOC_LAN966 || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 3d54dda3593e..00b612a0effa 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -149,7 +149,6 @@ static const struct of_device_id mchp_sparx5_reset_of_match[] = {
 	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, mchp_sparx5_reset_of_match);
 
 static struct platform_driver mchp_sparx5_reset_driver = {
 	.probe = mchp_sparx5_reset_probe,
@@ -159,7 +158,12 @@ static struct platform_driver mchp_sparx5_reset_driver = {
 	},
 };
 
-module_platform_driver(mchp_sparx5_reset_driver);
+static int __init mchp_sparx5_reset_init(void)
+{
+	return platform_driver_register(&mchp_sparx5_reset_driver);
+}
+
+postcore_initcall(mchp_sparx5_reset_init);
 
 MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
 MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
-- 
2.30.2

