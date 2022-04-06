Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C84F60DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiDFOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiDFOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:11:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C6464C06;
        Wed,  6 Apr 2022 03:05:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 318F51F4390F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649239457;
        bh=E8FhNhaGBVpp9KYAfMViAIYnlBsslTuXK5L56LwxxPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDroqQIjwGb1F45SMf1ymLcMRoiCrTI2tU6b17nIfl9XUwDoeczop+FCOASkmf+9v
         6+X4j77EdD+bcta1wEuiDuyhCrIZdbeJgKcLFniP4MwWnNpzjQXrUEAVW4c313/raH
         vfsjIlE3v2a3NeIs48Vu9k8BCgIGfrJoGMPDt65ixnTc5um3CcZKxP0tP8/4tagVbR
         R0lrZxrBNnSpxteEga3SI9ShWtcuPtpwJ0c/dacT9QMGZMdrgN9pJvzpllHM9XmSM9
         2hix9HziDZMV/sonCUyxfErF1PTCPxDmozbB4g9FZ+srzoD6LMGjlNIE6L1n6LdRHR
         zFh8SamPhFS4w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/7] spi: mt65xx: Simplify probe function with dev_err_probe()
Date:   Wed,  6 Apr 2022 12:04:07 +0200
Message-Id: <20220406100409.93113-6-angelogioacchino.delregno@collabora.com>
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

Switch to dev_err_probe() to remove all dev_err() -> return repeated
patterns, simplifying and shortening the probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 70 ++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b8ec04795141..c5b8aecfada6 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -795,10 +795,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	int i, irq, ret, addr_bits;
 
 	master = devm_spi_alloc_master(dev, sizeof(*mdata));
-	if (!master) {
-		dev_err(dev, "failed to alloc spi master\n");
-		return -ENOMEM;
-	}
+	if (!master)
+		return dev_err_probe(dev, -ENOMEM, "failed to alloc spi master\n");
 
 	master->auto_runtime_pm = true;
 	master->dev.of_node = dev->of_node;
@@ -826,11 +824,9 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (mdata->dev_comp->need_pad_sel) {
 		mdata->pad_num = of_property_count_u32_elems(dev->of_node,
 			"mediatek,pad-select");
-		if (mdata->pad_num < 0) {
-			dev_err(dev,
+		if (mdata->pad_num < 0)
+			return dev_err_probe(dev, -EINVAL,
 				"No 'mediatek,pad-select' property\n");
-			return -EINVAL;
-		}
 
 		mdata->pad_sel = devm_kmalloc_array(dev, mdata->pad_num,
 						    sizeof(u32), GFP_KERNEL);
@@ -841,11 +837,10 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			of_property_read_u32_index(dev->of_node,
 						   "mediatek,pad-select",
 						   i, &mdata->pad_sel[i]);
-			if (mdata->pad_sel[i] > MT8173_SPI_MAX_PAD_SEL) {
-				dev_err(dev, "wrong pad-sel[%d]: %u\n",
-					i, mdata->pad_sel[i]);
-				return -EINVAL;
-			}
+			if (mdata->pad_sel[i] > MT8173_SPI_MAX_PAD_SEL)
+				return dev_err_probe(dev, -EINVAL,
+						     "wrong pad-sel[%d]: %u\n",
+						     i, mdata->pad_sel[i]);
 		}
 	}
 
@@ -863,40 +858,30 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, mtk_spi_interrupt,
 			       IRQF_TRIGGER_NONE, dev_name(dev), master);
-	if (ret) {
-		dev_err(dev, "failed to register irq (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register irq\n");
 
 	mdata->parent_clk = devm_clk_get(dev, "parent-clk");
-	if (IS_ERR(mdata->parent_clk)) {
-		dev_err(dev, "failed to get parent-clk: %d\n", ret);
-		return PTR_ERR(mdata->parent_clk);
-	}
+	if (IS_ERR(mdata->parent_clk))
+		return dev_err_probe(dev, PTR_ERR(mdata->parent_clk),
+				     "failed to get parent-clk\n");
 
 	mdata->sel_clk = devm_clk_get(dev, "sel-clk");
-	if (IS_ERR(mdata->sel_clk)) {
-		dev_err(dev, "failed to get sel-clk: %d\n", ret);
-		return PTR_ERR(mdata->sel_clk);
-	}
+	if (IS_ERR(mdata->sel_clk))
+		return dev_err_probe(dev, PTR_ERR(mdata->sel_clk), "failed to get sel-clk\n");
 
 	mdata->spi_clk = devm_clk_get(dev, "spi-clk");
-	if (IS_ERR(mdata->spi_clk)) {
-		dev_err(dev, "failed to get spi-clk: %d\n", ret);
-		return PTR_ERR(mdata->spi_clk);
-	}
+	if (IS_ERR(mdata->spi_clk))
+		return dev_err_probe(dev, PTR_ERR(mdata->spi_clk), "failed to get spi-clk\n");
 
 	ret = clk_prepare_enable(mdata->spi_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to enable spi_clk\n");
 
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
-		dev_err(dev, "failed to clk_set_parent (%d)\n", ret);
 		clk_disable_unprepare(mdata->spi_clk);
-		return ret;
+		return dev_err_probe(dev, ret, "failed to clk_set_parent\n");
 	}
 
 	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -907,18 +892,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		clk_disable_unprepare(mdata->spi_clk);
 
 	if (mdata->dev_comp->need_pad_sel) {
-		if (mdata->pad_num != master->num_chipselect) {
-			dev_err(dev,
+		if (mdata->pad_num != master->num_chipselect)
+			return dev_err_probe(dev, -EINVAL,
 				"pad_num does not match num_chipselect(%d != %d)\n",
 				mdata->pad_num, master->num_chipselect);
-			return -EINVAL;
-		}
 
-		if (!master->cs_gpiods && master->num_chipselect > 1) {
-			dev_err(dev,
+		if (!master->cs_gpiods && master->num_chipselect > 1)
+			return dev_err_probe(dev, -EINVAL,
 				"cs_gpios not specified and num_chipselect > 1\n");
-			return -EINVAL;
-		}
 	}
 
 	if (mdata->dev_comp->dma_ext)
@@ -935,8 +916,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
 		pm_runtime_disable(dev);
-		dev_err(dev, "failed to register master (%d)\n", ret);
-		return ret;
+		return dev_err_probe(dev, ret, "failed to register master\n");
 	}
 
 	return 0;
-- 
2.35.1

