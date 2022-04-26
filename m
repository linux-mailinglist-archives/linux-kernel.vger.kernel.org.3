Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1606150F4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiDZIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbiDZIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6746F4A7;
        Tue, 26 Apr 2022 01:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4C2B81CF7;
        Tue, 26 Apr 2022 08:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24655C385A4;
        Tue, 26 Apr 2022 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650961583;
        bh=Q27TqYlgk6lviYzg0sNURHKEbuAkNXjesHKLsg3DP9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdQVY/Z4zicEVOUhpQVn6YGXfMzFgzXO/7J5vojBkcUzX30Naco6Yae0QXiGAKjOC
         s6v1nXMdG7uy4UXc8kVHN0X0DPTS5zSKSDxSH9ESFA9/Skz4vIlyQ/D/dVu+cFtGql
         L3t+bTZbAKzB/eWmGTenfWLRGOK1sKC6rdaTuJLIyT/ixkN7g91KK7lcWya4cF8V22
         pgqN6zg74Rzv+PEXp/G+WrxXyCcggsgtkWH0hfhEqoEO7iva1i3KmvT+j/FCFuifLT
         HbGwgV2gPgIjXeAcxV/W76JpIREXxYzGtgE+WvbOB4V2xrKv/tvBip481IlEQt+4BM
         F53nM4Y8je81A==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 2/2] memory: omap-gpmc: Allow building as a module
Date:   Tue, 26 Apr 2022 11:26:11 +0300
Message-Id: <20220426082611.24427-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426082611.24427-1-rogerq@kernel.org>
References: <20220426082611.24427-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index da9634daad04..b7800b37af78 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -103,7 +103,7 @@ config TI_EMIF
 	  temperature changes
 
 config OMAP_GPMC
-	bool "Texas Instruments OMAP SoC GPMC driver"
+	tristate "Texas Instruments OMAP SoC GPMC driver"
 	depends on OF_ADDRESS
 	select GPIOLIB
 	help
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index ed11887c1b7c..2351f2708da2 100644
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
+MODULE_LICENSE("GPL");
-- 
2.17.1

