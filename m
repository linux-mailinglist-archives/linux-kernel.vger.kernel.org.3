Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE794FB8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbiDKJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343781AbiDKJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA61E1263F;
        Mon, 11 Apr 2022 02:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7297AB811CE;
        Mon, 11 Apr 2022 09:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54F3C385AD;
        Mon, 11 Apr 2022 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670928;
        bh=NCNYVToRizDs7+QdVooNoSbWYHm2S6GGdRBc+kHEwco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWsF6cj3sPT1ZRnjCYR+BGmmBNqmSHFJQq3UYVVDGtJfUUtblyfhdR6yNAQm3o0Fx
         dOoWAMG5tWjSaFXTfl+9viRYTkm+qOJXLmhGhO1X4qiDv/htwQO4DlbS2jypjIrp0a
         QXVozr5QP7pplllH3euxH/NJpkxR6XDeDril3NU1L/KKj0WCrklAhvgUskMTJvze4G
         +0zQXkwsP3oewZ3Dt7lblTJLxSXhFVpW7ApktP4cPkW/KS3eFz0rfsdAQOgGRX6YVi
         9LfhCGolboHLAHGTtpt1A6nYVvAcxoCBWMe5S/+5JYgsHMY8Hdbf77qRaPEIBUGSHk
         DrVujxef5cExg==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 2/2] memory: omap-gpmc: Allow building as a module
Date:   Mon, 11 Apr 2022 12:55:16 +0300
Message-Id: <20220411095516.24754-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411095516.24754-1-rogerq@kernel.org>
References: <20220411095516.24754-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow OMAP_GPMC to be built as a module.

When building this driver as a module, the symbol
'of_default_bus_match_table' will not be found
as it is not being exported.

The of_match_node() call is redundant anyways as
of_platform_default_populate() already takes care of
matching with 'of_default_bus_match_table'. So get
rid of that call. This will also resolve the
module build failure.

Move compatible match table to the end where it is
usually expected.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/Kconfig     |  2 +-
 drivers/memory/omap-gpmc.c | 43 ++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index da2af9c38fe3..4debd4b2c8da 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -103,7 +103,7 @@ config TI_EMIF
 	  temperature changes
 
 config OMAP_GPMC
-	bool "Texas Instruments OMAP SoC GPMC driver"
+	tristate "Texas Instruments OMAP SoC GPMC driver"
 	depends on OF_ADDRESS || COMPILE_TEST
 	select GPIOLIB
 	help
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index ed11887c1b7c..de41c9795fb8 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -12,6 +12,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -1889,16 +1890,6 @@ int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
 }
 
 #ifdef CONFIG_OF
-static const struct of_device_id gpmc_dt_ids[] = {
-	{ .compatible = "ti,omap2420-gpmc" },
-	{ .compatible = "ti,omap2430-gpmc" },
-	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
-	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
-	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
-	{ .compatible = "ti,am64-gpmc" },
-	{ }
-};
-
 static void gpmc_cs_set_name(int cs, const char *name)
 {
 	struct gpmc_cs_data *gpmc = &gpmc_cs[cs];
@@ -2257,11 +2248,9 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	if (!of_platform_device_create(child, NULL, &pdev->dev))
 		goto err_child_fail;
 
-	/* is child a common bus? */
-	if (of_match_node(of_default_bus_match_table, child))
-		/* create children and other common bus children */
-		if (of_platform_default_populate(child, NULL, &pdev->dev))
-			goto err_child_fail;
+	/* create children and other common bus children */
+	if (of_platform_default_populate(child, NULL, &pdev->dev))
+		goto err_child_fail;
 
 	return 0;
 
@@ -2278,6 +2267,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	return ret;
 }
 
+static const struct of_device_id gpmc_dt_ids[];
+
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -2644,6 +2635,19 @@ static int gpmc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(gpmc_pm_ops, gpmc_suspend, gpmc_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id gpmc_dt_ids[] = {
+	{ .compatible = "ti,omap2420-gpmc" },
+	{ .compatible = "ti,omap2430-gpmc" },
+	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
+	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
+	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
+	{ .compatible = "ti,am64-gpmc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
+#endif
+
 static struct platform_driver gpmc_driver = {
 	.probe		= gpmc_probe,
 	.remove		= gpmc_remove,
@@ -2654,8 +2658,7 @@ static struct platform_driver gpmc_driver = {
 	},
 };
 
-static __init int gpmc_init(void)
-{
-	return platform_driver_register(&gpmc_driver);
-}
-postcore_initcall(gpmc_init);
+module_platform_driver(gpmc_driver);
+
+MODULE_DESCRIPTION("Texas Instruments GPMC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

