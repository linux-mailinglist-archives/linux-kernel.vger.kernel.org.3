Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92084F5FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiDFNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiDFNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:21:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C02C62E2AF;
        Wed,  6 Apr 2022 03:04:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6A8431F43901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649239455;
        bh=vFZRSUCtzPmI05FbkG5koMycIxN2nba9jZW7kLwOcfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4Vk7efUMCoApCY0Gl4KRXzkQIm19g5H5ymp3IUIMtqQ68duLQ4OnQ/osMDQftCgX
         Hiw1XB27d6hmcCIUNlUQU0L6WOxMkyE9GLNiH/Sfuf88roOSG3PXosQhxUq1PqxlFr
         h81KxqflxYfgLRGh7kdWbc1/XjDR2Elgx4NzPp2HIX5g8u2Z/1dcD0P5ATPW6HNO8Z
         +3NfB6ZSMMqrhn+/IcZ5c1gf7OlGAcqsMZscyP5IJ8p8oNeW8CpLqJ65cA1Qv2zSn8
         jf0b36XFRY7QYRvHErHA436VdjeRFpFtfDgKYn83a/Xeh2ec3VW0ev5BcGuQNv8om5
         DeRrZJnzbe11Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/7] spi: mt65xx: Simplify probe function with devm_spi_alloc_master
Date:   Wed,  6 Apr 2022 12:04:03 +0200
Message-Id: <20220406100409.93113-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
References: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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
 drivers/spi/spi-mt65xx.c | 46 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 1a0b3208dfca..4f53c3446bc0 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -794,7 +794,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	int i, irq, ret, addr_bits;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
 		dev_err(&pdev->dev, "failed to alloc spi master\n");
 		return -ENOMEM;
@@ -815,8 +815,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
 	if (!of_id) {
 		dev_err(&pdev->dev, "failed to probe of_node\n");
-		ret = -EINVAL;
-		goto err_put_master;
+		return -EINVAL;
 	}
 
 	mdata = spi_master_get_devdata(master);
@@ -837,16 +836,13 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
@@ -855,24 +851,19 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
@@ -881,41 +872,38 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	mdata->parent_clk = devm_clk_get(&pdev->dev, "parent-clk");
 	if (IS_ERR(mdata->parent_clk)) {
-		ret = PTR_ERR(mdata->parent_clk);
 		dev_err(&pdev->dev, "failed to get parent-clk: %d\n", ret);
-		goto err_put_master;
+		return PTR_ERR(mdata->parent_clk);
 	}
 
 	mdata->sel_clk = devm_clk_get(&pdev->dev, "sel-clk");
 	if (IS_ERR(mdata->sel_clk)) {
-		ret = PTR_ERR(mdata->sel_clk);
 		dev_err(&pdev->dev, "failed to get sel-clk: %d\n", ret);
-		goto err_put_master;
+		return PTR_ERR(mdata->sel_clk);
 	}
 
 	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi-clk");
 	if (IS_ERR(mdata->spi_clk)) {
-		ret = PTR_ERR(mdata->spi_clk);
 		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
-		goto err_put_master;
+		return PTR_ERR(mdata->spi_clk);
 	}
 
 	ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n", ret);
-		goto err_put_master;
+		return ret;
 	}
 
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
 		clk_disable_unprepare(mdata->spi_clk);
-		goto err_put_master;
+		return ret;
 	}
 
 	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -963,8 +951,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
-err_put_master:
-	spi_master_put(master);
 
 	return ret;
 }
-- 
2.35.1

