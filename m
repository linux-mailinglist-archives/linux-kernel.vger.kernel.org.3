Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E94788E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhLQKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhLQKaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:30:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44586C06173E;
        Fri, 17 Dec 2021 02:30:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0CF4620F7;
        Fri, 17 Dec 2021 10:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF9AC36AE8;
        Fri, 17 Dec 2021 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639737002;
        bh=33+oNgZLqDGwuRKfoQVGuh5cPLd3WugMokzWh54u7Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOWtCCx9Lq5tSKEtfCacLJwWBVzGQF2dilHSi3qbWGnGMNv4rbPO6AkFPZOexePBT
         0wZwikFaPw8nxQkiyTrzfOFIG+kiHs0UwnG2LRgAOcNCoUVWTz+H4sLj8yXTIRK2bl
         ypJFsCo+vC7/6DSpfYmoe4ta81PdTgwiM6LcmaASGO+dHs9HX/a1SPepYjyj1yyL8S
         ETm+pZsW9Z8Z9eiDMhcKHUEqowlNoGlajhA1/U7UVjDr3CYTvg7fgBTl5BxMaSxKP+
         /mvvR98NJZRSi7Oy+I7nD0C1TZNcOh+KkntxFPQTSulsXtbCaM+UHheLZ7S8D863LY
         frfH2NnlnjjGg==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 3/4] memory: omap-gpmc: Use a compatible match table when checking for NAND controller
Date:   Fri, 17 Dec 2021 12:29:44 +0200
Message-Id: <20211217102945.17432-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217102945.17432-1-rogerq@kernel.org>
References: <20211217102945.17432-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As more compatibles can be added to the GPMC NAND controller driver
use a compatible match table.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/omap-gpmc.c                   | 8 +++++++-
 drivers/mtd/nand/raw/omap2.c                 | 2 +-
 include/linux/platform_data/mtd-nand-omap2.h | 5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 624153048182..814ddb45c13d 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	u32 val;
 	struct gpio_desc *waitpin_desc = NULL;
 	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+	bool is_nand = false;
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
@@ -2183,7 +2184,12 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
-	if (of_device_is_compatible(child, "ti,omap2-nand")) {
+#if defined(CONFIG_MTD_NAND_OMAP2)
+	if (of_match_node(omap_nand_ids, child))
+		is_nand = true;
+#endif
+
+	if (is_nand) {
 		/* NAND specific setup */
 		val = 8;
 		of_property_read_u32(child, "nand-bus-width", &val);
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index b26d4947af02..fff834ee726f 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2352,7 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct of_device_id omap_nand_ids[] = {
+const struct of_device_id omap_nand_ids[] = {
 	{ .compatible = "ti,omap2-nand", },
 	{},
 };
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index de6ada739121..e1bb90a8db03 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -61,4 +61,9 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
 };
+
+#if defined(CONFIG_MTD_NAND_OMAP2)
+extern const struct of_device_id omap_nand_ids[];
+#endif
+
 #endif
-- 
2.17.1

