Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2B4788E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhLQKaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhLQKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:30:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87893C06173E;
        Fri, 17 Dec 2021 02:30:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51504B82787;
        Fri, 17 Dec 2021 10:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F7BC36AE1;
        Fri, 17 Dec 2021 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639736999;
        bh=MeirT4xGsKt7osRpBz1wQ0uIbtgu/8LH4Sy26maoJnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbwo7JFWmmshN6xvIhp6y49zTWllXsbvLvYOP0ZotJzJjDWtVWNPSmzUqeCdFKG0s
         Yk5NIa63dlFwmTggoGOj06ZanK/eYCT/Zel0396hDXLKhRBih6XeqVREw4XANrkEJX
         ywhjDqjsyu3oNF3BgYg/ajfEWWGA2n1cJoQqzRgUCQcr4auFGuysKTk90DBO8jYOgA
         pFElyxL9uQKeXZhaJCiC99V17d5xCgFpGx+6Cpz18kKsza1XPZJA1uLH7dBmVKJ4tq
         hXTxpGLaD01mrq2djX1I2LO5RJ5CZwmlyrz0suZuz7amRl4yP6fsPFxXbBnyADhWdf
         hMHUIpe4kVZiQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 2/4] memory: omap-gpmc: Add support for GPMC on AM64 SoC
Date:   Fri, 17 Dec 2021 12:29:43 +0200
Message-Id: <20211217102945.17432-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217102945.17432-1-rogerq@kernel.org>
References: <20211217102945.17432-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI's AM64 SoC has the GPMC module. Add compatible for it.

Traditionally GPMC external addresses have always been mapped to first
1GB physical address. However newer platforms, can have it mapped
at different locations. Support this address provision via device tree.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/omap-gpmc.c | 40 ++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index be0858bff4d3..624153048182 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -237,6 +237,7 @@ struct gpmc_device {
 	struct omap3_gpmc_regs context;
 	int nirqs;
 	unsigned int is_suspended:1;
+	struct resource *data;
 };
 
 static struct irq_domain *gpmc_irq_domain;
@@ -1456,12 +1457,18 @@ static void gpmc_mem_exit(void)
 	}
 }
 
-static void gpmc_mem_init(void)
+static void gpmc_mem_init(struct gpmc_device *gpmc)
 {
 	int cs;
 
-	gpmc_mem_root.start = GPMC_MEM_START;
-	gpmc_mem_root.end = GPMC_MEM_END;
+	if (!gpmc->data) {
+		/* All legacy devices have same data IO window */
+		gpmc_mem_root.start = GPMC_MEM_START;
+		gpmc_mem_root.end = GPMC_MEM_END;
+	} else {
+		gpmc_mem_root.start = gpmc->data->start;
+		gpmc_mem_root.end = gpmc->data->end;
+	}
 
 	/* Reserve all regions that has been set up by bootloader */
 	for (cs = 0; cs < gpmc_cs_num; cs++) {
@@ -1888,6 +1895,7 @@ static const struct of_device_id gpmc_dt_ids[] = {
 	{ .compatible = "ti,omap3430-gpmc" },	/* omap3430 & omap3630 */
 	{ .compatible = "ti,omap4430-gpmc" },	/* omap4430 & omap4460 & omap543x */
 	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
+	{ .compatible = "ti,am64-gpmc" },
 	{ }
 };
 
@@ -2502,13 +2510,25 @@ static int gpmc_probe(struct platform_device *pdev)
 	gpmc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gpmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!res) {
+		/* legacy DT */
+		gpmc_base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(gpmc_base))
+			return PTR_ERR(gpmc_base);
+	} else {
+		gpmc_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(gpmc_base))
+			return PTR_ERR(gpmc_base);
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "data");
+		if (!res) {
+			dev_err(&pdev->dev, "couldn't get data reg resource\n");
+			return -ENOENT;
+		}
 
-	gpmc_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(gpmc_base))
-		return PTR_ERR(gpmc_base);
+		gpmc->data = res;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
@@ -2562,7 +2582,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	dev_info(gpmc->dev, "GPMC revision %d.%d\n", GPMC_REVISION_MAJOR(l),
 		 GPMC_REVISION_MINOR(l));
 
-	gpmc_mem_init();
+	gpmc_mem_init(gpmc);
 	rc = gpmc_gpio_init(gpmc);
 	if (rc)
 		goto gpio_init_failed;
-- 
2.17.1

