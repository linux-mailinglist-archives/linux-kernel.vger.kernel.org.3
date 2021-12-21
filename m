Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BAD47C0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhLUNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:18:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34380 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhLUNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:18:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A9261599;
        Tue, 21 Dec 2021 13:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE06C36AE9;
        Tue, 21 Dec 2021 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092695;
        bh=Nqe6mT09B1kTX33/VRmKBI2xx5UPngqh2E87CJblXg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q11EtiJnQ+VoC6JNDoZINAHnuKhWEUMv7E0sC7FV5AmFsGffUrgodM7PDzKsrdmKA
         jJvF7Q7YMIJXB+P5R5xgJY5IwE0JXwbUmtz713iWbBTuwhbqbuyvzpHcFmCRYA6MJa
         53i6EJVnT7WcpyNzjVYT0C6kdl9Y2DzoQ9791vDzk/B2cur/IaKIuD9HR53TOGRhV/
         uOXD4SbNuCtKfZtkfd5UtixKiYO7flM6Q+k1Kbj9Ssx9F3Pg76NO0s6yyt0+lPoJqo
         S5MKX27Pswdy3yRLBaffxZKUHSkQBJdQdox/9ihrdowrLOoYdHQ15dMDmPN8e5Zmfe
         GHi/trBBx+ZVw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, miquel.raynal@bootlin.com,
        tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 3/4] memory: omap-gpmc: Use a compatible match table when checking for NAND controller
Date:   Tue, 21 Dec 2021 15:17:56 +0200
Message-Id: <20211221131757.2030-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221131757.2030-1-rogerq@kernel.org>
References: <20211221131757.2030-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As more compatibles can be added to the GPMC NAND controller driver
use a compatible match table.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/omap-gpmc.c                   | 6 +++++-
 drivers/mtd/nand/raw/omap2.c                 | 5 +----
 include/linux/platform_data/mtd-nand-omap2.h | 9 ++++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 624153048182..d19ffc895e5b 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	u32 val;
 	struct gpio_desc *waitpin_desc = NULL;
 	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
+	bool is_nand = false;
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
@@ -2183,7 +2184,10 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
-	if (of_device_is_compatible(child, "ti,omap2-nand")) {
+	if (of_match_node(omap_nand_ids, child))
+		is_nand = true;
+
+	if (is_nand) {
 		/* NAND specific setup */
 		val = 8;
 		of_property_read_u32(child, "nand-bus-width", &val);
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index b26d4947af02..e6dd8b4cf0d2 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2352,10 +2352,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct of_device_id omap_nand_ids[] = {
-	{ .compatible = "ti,omap2-nand", },
-	{},
-};
+/* omap_nand_ids defined in linux/platform_data/mtd-nand-omap2.h */
 MODULE_DEVICE_TABLE(of, omap_nand_ids);
 
 static struct platform_driver omap_nand_driver = {
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index de6ada739121..92f011805ad4 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -7,6 +7,7 @@
 #define	_MTD_NAND_OMAP2_H
 
 #include <linux/mtd/partitions.h>
+#include <linux/mod_devicetable.h>
 
 #define	GPMC_BCH_NUM_REMAINDER	8
 
@@ -61,4 +62,10 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
 };
-#endif
+
+static const struct of_device_id omap_nand_ids[] = {
+	{ .compatible = "ti,omap2-nand", },
+	{},
+};
+
+#endif /* _MTD_NAND_OMAP2_H */
-- 
2.17.1

