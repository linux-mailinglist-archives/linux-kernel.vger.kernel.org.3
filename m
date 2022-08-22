Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9059B923
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiHVGT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHVGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:19:55 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Aug 2022 23:19:51 PDT
Received: from atl4mhfb01.myregisteredsite.com (atl4mhfb01.myregisteredsite.com [209.17.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7225293
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:19:51 -0700 (PDT)
Received: from atl4mhob13.registeredsite.com (atl4mhob13.registeredsite.com [209.17.115.51])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 27M6Ikdi005669
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:18:46 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by atl4mhob13.registeredsite.com (8.14.4/8.14.4) with ESMTP id 27M6IfZ3004506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:18:41 -0400
Received: (qmail 3289 invoked by uid 0); 22 Aug 2022 06:18:41 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 22 Aug 2022 06:18:41 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-leds@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        p.meerwald@bct-electronic.com
Subject: [PATCH 1/2] leds: pca963x: Add support for PCA962x chips
Date:   Mon, 22 Aug 2022 08:18:37 +0200
Message-Id: <20220822061838.8212-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCA962x family shares the same I2C register layout and functionality.
This adds support for the following chips:
PCA9623 4-channel
PCA9624 8-channel
PCA9622 16-channel
PCA9626 24-channel

Tested only the PCA9624. Other devices based on datasheet information.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 drivers/leds/Kconfig        |  8 ++++----
 drivers/leds/leds-pca963x.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..9a99190c13af 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -497,13 +497,13 @@ config LEDS_PCA955X_GPIO
 
 
 config LEDS_PCA963X
-	tristate "LED support for PCA963x I2C chip"
+	tristate "LED support for PCA962x and PCA963x I2C chips"
 	depends on LEDS_CLASS
 	depends on I2C
 	help
-	  This option enables support for LEDs connected to the PCA963x
-	  LED driver chip accessed via the I2C bus. Supported
-	  devices include PCA9633 and PCA9634
+	  This option enables support for LEDs connected to the PCA96xx
+	  LED driver chip accessed via the I2C bus. Supported devices:
+	  PCA9622, PCA9623, PCA9624, PCA9626, PCA9633, PCA9634, PCA9635.
 
 config LEDS_WM831X_STATUS
 	tristate "LED support for status LEDs on WM831x PMICs"
diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 00aecd67e348..4d589624d192 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -48,6 +48,10 @@
 #define PCA963X_PWM_BASE	0x02
 
 enum pca963x_type {
+	pca9622,
+	pca9623,
+	pca9624,
+	pca9626,
 	pca9633,
 	pca9634,
 	pca9635,
@@ -62,6 +66,30 @@ struct pca963x_chipdef {
 };
 
 static struct pca963x_chipdef pca963x_chipdefs[] = {
+	[pca9622] = {
+		.grppwm		= 0x12,
+		.grpfreq	= 0x13,
+		.ledout_base	= 0x14,
+		.n_leds		= 16,
+	},
+	[pca9623] = {
+		.grppwm		= 0x6,
+		.grpfreq	= 0x7,
+		.ledout_base	= 0x8,
+		.n_leds		= 4,
+	},
+	[pca9624] = {
+		.grppwm		= 0xa,
+		.grpfreq	= 0xb,
+		.ledout_base	= 0xc,
+		.n_leds		= 8,
+	},
+	[pca9626] = {
+		.grppwm		= 0x1a,
+		.grpfreq	= 0x1b,
+		.ledout_base	= 0x1d,
+		.n_leds		= 24,
+	},
 	[pca9633] = {
 		.grppwm		= 0x6,
 		.grpfreq	= 0x7,
@@ -87,6 +115,10 @@ static struct pca963x_chipdef pca963x_chipdefs[] = {
 #define PCA963X_BLINK_PERIOD_MAX	10667
 
 static const struct i2c_device_id pca963x_id[] = {
+	{ "pca9622", pca9622 },
+	{ "pca9623", pca9623 },
+	{ "pca9624", pca9624 },
+	{ "pca9626", pca9626 },
 	{ "pca9632", pca9633 },
 	{ "pca9633", pca9633 },
 	{ "pca9634", pca9634 },
@@ -363,6 +395,10 @@ static int pca963x_register_leds(struct i2c_client *client,
 }
 
 static const struct of_device_id of_pca963x_match[] = {
+	{ .compatible = "nxp,pca9622", },
+	{ .compatible = "nxp,pca9623", },
+	{ .compatible = "nxp,pca9624", },
+	{ .compatible = "nxp,pca9626", },
 	{ .compatible = "nxp,pca9632", },
 	{ .compatible = "nxp,pca9633", },
 	{ .compatible = "nxp,pca9634", },
-- 
2.17.1

