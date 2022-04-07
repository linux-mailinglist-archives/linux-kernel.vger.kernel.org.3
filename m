Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B888D4F7E43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiDGLrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiDGLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241918C0DC;
        Thu,  7 Apr 2022 04:44:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 29DCE1F46126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331874;
        bh=Fw3AxGJB3md7hhOZg96E69MvUfwyG7YhoKw4DXM4Mw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RekK7T3pXz32IceFZbD5eJCxkiuO5Uvcy50lqRddynUi85vzh0Pzen+RbFo4XlpLC
         ZnzG8AyixDHJPgBE5YzLoBaM/juyiPRAq8MmwHp7mNr8K8nPoEG97t2q10NPD6rIiD
         r5p0HmlwQ4eIFZ3Ggo+IJOYALQ20GsW7IlOQFJnwNa9IaDek3MWCv19FK+uigmvVce
         9c0gnOfO98lkaX21UBN5LWZONkyjWSkWmvRD2binfuZM4hi0WctTtgmR9i1fzfhAmg
         GYdCx5iP//I9y+DqVGN9j99FvmmrKe/jYPCfVuENUNI3tA6RPjE1XBEoEVghEphmed
         VNzbG/TlWrvag==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/8] spi: mt65xx: Simplify probe function with devm_spi_alloc_master
Date:   Thu,  7 Apr 2022 13:44:21 +0200
Message-Id: <20220407114428.167091-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
References: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the devm variant of spi_alloc_master() to save some gotos.
This patch is a cleanup that brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 43 +++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 99ce570a88a7..4c84b67ac85c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1087,7 +1087,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	int i, irq, ret, addr_bits;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
 		dev_err(&pdev->dev, "failed to alloc spi master\n");
 		return -ENOMEM;
@@ -1108,8 +1108,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
 	if (!of_id) {
 		dev_err(&pdev->dev, "failed to probe of_node\n");
-		ret = -EINVAL;
-		goto err_put_master;
+		return -EINVAL;
 	}
 
 	mdata = spi_master_get_devdata(master);
@@ -1136,16 +1135,13 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		if (mdata->pad_num < 0) {
 			dev_err(&pdev->dev,
 				"No 'mediatek,pad-select' property\n");
-			ret = -EINVAL;
-			goto err_put_master;
+			return -EINVAL;
 		}
 
 		mdata->pad_sel = devm_kmalloc_array(&pdev->dev, mdata->pad_num,
 						    sizeof(u32), GFP_KERNEL);
-		if (!mdata->pad_sel) {
-			ret = -ENOMEM;
-			goto err_put_master;
-		}
+		if (!mdata->pad_sel)
+			return -ENOMEM;
 
 		for (i = 0; i < mdata->pad_num; i++) {
 			of_property_read_u32_index(pdev->dev.of_node,
@@ -1154,24 +1150,19 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			if (mdata->pad_sel[i] > MT8173_SPI_MAX_PAD_SEL) {
 				dev_err(&pdev->dev, "wrong pad-sel[%d]: %u\n",
 					i, mdata->pad_sel[i]);
-				ret = -EINVAL;
-				goto err_put_master;
+				return -EINVAL;
 			}
 		}
 	}
 
 	platform_set_drvdata(pdev, master);
 	mdata->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mdata->base)) {
-		ret = PTR_ERR(mdata->base);
-		goto err_put_master;
-	}
+	if (IS_ERR(mdata->base))
+		return PTR_ERR(mdata->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_put_master;
-	}
+	if (irq < 0)
+		return irq;
 
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
@@ -1180,41 +1171,41 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	mdata->parent_clk = devm_clk_get(&pdev->dev, "parent-clk");
 	if (IS_ERR(mdata->parent_clk)) {
 		ret = PTR_ERR(mdata->parent_clk);
 		dev_err(&pdev->dev, "failed to get parent-clk: %d\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	mdata->sel_clk = devm_clk_get(&pdev->dev, "sel-clk");
 	if (IS_ERR(mdata->sel_clk)) {
 		ret = PTR_ERR(mdata->sel_clk);
 		dev_err(&pdev->dev, "failed to get sel-clk: %d\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi-clk");
 	if (IS_ERR(mdata->spi_clk)) {
 		ret = PTR_ERR(mdata->spi_clk);
 		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	mdata->spi_hclk = devm_clk_get_optional(&pdev->dev, "hclk");
 	if (IS_ERR(mdata->spi_hclk)) {
 		ret = PTR_ERR(mdata->spi_hclk);
 		dev_err(&pdev->dev, "failed to get hclk: %d\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(mdata->spi_hclk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable hclk (%d)\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(mdata->spi_clk);
@@ -1281,8 +1272,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mdata->spi_clk);
 err_disable_spi_hclk:
 	clk_disable_unprepare(mdata->spi_hclk);
-err_put_master:
-	spi_master_put(master);
 
 	return ret;
 }
-- 
2.35.1

