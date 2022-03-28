Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0754E9317
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiC1LP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbiC1LPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:15:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4655523B;
        Mon, 28 Mar 2022 04:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3F0EB8104F;
        Mon, 28 Mar 2022 11:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFE6C34112;
        Mon, 28 Mar 2022 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466011;
        bh=jn2ZJ5F2Y7hAHYlXc+gmUJTzR90M4Zkj9GyGopzq6xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjNzqt3AaSp77g1FWQ/Vuu6wkpj68AEgWyL+E19vJrXh3+aCy1E/srHTEFOsyNWTQ
         cnep1h6FZ5TAW6rdP3dFdQvcqnP8OAHF0fAlPgCvC5kbqioegmysR59/Ia0P7QPx8D
         Y9AXU2agp96vb534IiTkp77RDiLbZ6Xr+DPFgO9i3wCVHPgvS01bNyv1Ge8C3jW/d5
         b780HK1V8VjU2MXRKmI4tmBYbtkX4oSsQ97tlSyIcTK76uVWsd8ODoTw9xAFhF+BsN
         WqNi/jJZLa2aIWv5cj6SLtM6h7eOSRQ9EuJ1+SOWHUVcFArrfmYVD0gC6YErmm+zCy
         eFA559wwOrvgQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/2] memory: omap-gpmc: Allow building as a module
Date:   Mon, 28 Mar 2022 14:13:19 +0300
Message-Id: <20220328111319.1236-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220328111319.1236-1-rogerq@kernel.org>
References: <20220328111319.1236-1-rogerq@kernel.org>
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

Remove redundant of_match_node() call before
of_platform_default_populate() as the latter takes
care of matching with of_default_bus_match_table.

Move compatible match table to the end where it is usually expected.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/Kconfig     |  2 +-
 drivers/memory/omap-gpmc.c | 44 +++++++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 21 deletions(-)

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
index ed11887c1b7c..6fdb76cc3bc9 100644
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
@@ -2654,8 +2658,8 @@ static struct platform_driver gpmc_driver = {
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
+MODULE_ALIAS("platform:" DEVICE_NAME);
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

