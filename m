Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1E4F7E45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiDGLrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244888AbiDGLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EE193156;
        Thu,  7 Apr 2022 04:44:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0C80B1F46135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331885;
        bh=pTStl/14Z/S+CR10wg8/YuEaIz0uvQeEvLyXgSz/Y5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUtDE9WMM46QqXOyyYTt0JrWUL707XCubtrbcINdX28SGw47oqmJ2+ySXmNNEaziT
         BkHv+nmE2jj5BEoFhnv7Bp96rIMmxJNa/K7Zl0wLtFni5hMVk/9NFdm1dKQ+krh3rC
         q/jYyeJE7JeplSQpTGH2OIFlZD8fJrzGCzLo6HE6xaf3S4AsLO4+6pXy3/WPHNT40n
         6Nbf0kTzsSrXwRBO1T+pbt2qdGSNFLyG3wzIB8g/ZcMHAJX5HXg0AH75yWb57UUviv
         jHJZzOGGSwTlFfAanD97Eq0IgvAYop3HSwzMpptQyZ+3BU1L34KexwTNNXPq3+H99L
         AD+cRoqr9aK/g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 6/8] spi: mt65xx: Simplify probe function with dev_err_probe()
Date:   Thu,  7 Apr 2022 13:44:26 +0200
Message-Id: <20220407114428.167091-7-angelogioacchino.delregno@collabora.com>
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

Switch to dev_err_probe() to remove all dev_err() -> return repeated
patterns, simplifying and shortening the probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 86 ++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3f307b25433d..111ce351359a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1088,10 +1088,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
@@ -1125,11 +1123,9 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
@@ -1140,11 +1136,10 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
 
@@ -1162,56 +1157,38 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
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
-		ret = PTR_ERR(mdata->parent_clk);
-		dev_err(dev, "failed to get parent-clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mdata->parent_clk))
+		return dev_err_probe(dev, PTR_ERR(mdata->parent_clk),
+				     "failed to get parent-clk\n");
 
 	mdata->sel_clk = devm_clk_get(dev, "sel-clk");
-	if (IS_ERR(mdata->sel_clk)) {
-		ret = PTR_ERR(mdata->sel_clk);
-		dev_err(dev, "failed to get sel-clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mdata->sel_clk))
+		return dev_err_probe(dev, PTR_ERR(mdata->sel_clk), "failed to get sel-clk\n");
 
 	mdata->spi_clk = devm_clk_get(dev, "spi-clk");
-	if (IS_ERR(mdata->spi_clk)) {
-		ret = PTR_ERR(mdata->spi_clk);
-		dev_err(dev, "failed to get spi-clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mdata->spi_clk))
+		return dev_err_probe(dev, PTR_ERR(mdata->spi_clk), "failed to get spi-clk\n");
 
 	mdata->spi_hclk = devm_clk_get_optional(dev, "hclk");
-	if (IS_ERR(mdata->spi_hclk)) {
-		ret = PTR_ERR(mdata->spi_hclk);
-		dev_err(dev, "failed to get hclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mdata->spi_hclk))
+		return dev_err_probe(dev, PTR_ERR(mdata->spi_hclk), "failed to get hclk\n");
 
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to clk_set_parent (%d)\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to clk_set_parent\n");
 
 	ret = clk_prepare_enable(mdata->spi_hclk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable hclk (%d)\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to enable hclk\n");
 
 	ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
-		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 		clk_disable_unprepare(mdata->spi_hclk);
-		return ret;
+		return dev_err_probe(dev, ret, "failed to enable spi_clk\n");
 	}
 
 	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -1225,18 +1202,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	}
 
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
@@ -1253,8 +1226,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
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

