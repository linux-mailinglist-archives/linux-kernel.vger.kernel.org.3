Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034FB4AF0E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiBIMHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiBIMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E34C1036B2;
        Wed,  9 Feb 2022 03:19:47 -0800 (PST)
X-UUID: fdd5064321cc4c2c95c543df8c0cde7d-20220209
X-UUID: fdd5064321cc4c2c95c543df8c0cde7d-20220209
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1432437706; Wed, 09 Feb 2022 19:19:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 9 Feb 2022 19:19:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 19:19:43 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 6/6] spi: mediatek: add need_ahb_clk support
Date:   Wed, 9 Feb 2022 19:19:38 +0800
Message-ID: <20220209111938.16137-7-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209111938.16137-1-leilk.liu@mediatek.com>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch adds need_ahb_clk support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 113 ++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9a40c6cd13ab..62bfbd7bf718 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -122,6 +122,8 @@ struct mtk_spi_compatible {
 	bool ipm_design;
 	/* IPM design that support quad mode */
 	bool support_quad;
+	/* some IC ahb & apb clk is different and also need to be enabled */
+	bool need_ahb_clk;
 };
 
 struct mtk_spi {
@@ -129,13 +131,13 @@ struct mtk_spi {
 	u32 state;
 	int pad_num;
 	u32 *pad_sel;
-	struct clk *parent_clk, *sel_clk, *spi_clk;
+	struct clk *parent_clk, *sel_clk, *spi_clk, *spi_hclk;
 	struct spi_transfer *cur_transfer;
 	u32 xfer_len;
 	u32 num_xfered;
 	struct scatterlist *tx_sgl, *rx_sgl;
 	u32 tx_sgl_len, rx_sgl_len;
-	const struct mtk_spi_compatible *dev_comp;
+	struct mtk_spi_compatible *dev_comp;
 	u32 spi_clk_hz;
 	struct completion spimem_done;
 	bool use_spimem;
@@ -144,49 +146,49 @@ struct mtk_spi {
 	dma_addr_t rx_dma;
 };
 
-static const struct mtk_spi_compatible mtk_common_compat;
+static struct mtk_spi_compatible mtk_common_compat;
 
-static const struct mtk_spi_compatible mt2712_compat = {
+static struct mtk_spi_compatible mt2712_compat = {
 	.must_tx = true,
 };
 
-static const struct mtk_spi_compatible ipm_compat_single = {
+static struct mtk_spi_compatible ipm_compat_single = {
 	.enhance_timing = true,
 	.dma_ext = true,
 	.ipm_design = true,
 };
 
-static const struct mtk_spi_compatible ipm_compat_quad = {
+static struct mtk_spi_compatible ipm_compat_quad = {
 	.enhance_timing = true,
 	.dma_ext = true,
 	.ipm_design = true,
 	.support_quad = true,
 };
 
-static const struct mtk_spi_compatible mt6765_compat = {
+static struct mtk_spi_compatible mt6765_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
 	.enhance_timing = true,
 	.dma_ext = true,
 };
 
-static const struct mtk_spi_compatible mt7622_compat = {
+static struct mtk_spi_compatible mt7622_compat = {
 	.must_tx = true,
 	.enhance_timing = true,
 };
 
-static const struct mtk_spi_compatible mt8173_compat = {
+static struct mtk_spi_compatible mt8173_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
 };
 
-static const struct mtk_spi_compatible mt8183_compat = {
+static struct mtk_spi_compatible mt8183_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
 	.enhance_timing = true,
 };
 
-static const struct mtk_spi_compatible mt6893_compat = {
+static struct mtk_spi_compatible mt6893_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
 	.enhance_timing = true,
@@ -1201,25 +1203,46 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
+	mdata->dev_comp->need_ahb_clk = of_property_read_bool(pdev->dev.of_node,
+							      "mediatek,need_ahb_clk");
+	if (mdata->dev_comp->need_ahb_clk) {
+		mdata->spi_hclk = devm_clk_get(&pdev->dev, "spi-hclk");
+		if (IS_ERR(mdata->spi_hclk)) {
+			ret = PTR_ERR(mdata->spi_hclk);
+			dev_err(&pdev->dev, "failed to get spi-hclk: %d\n", ret);
+			goto err_put_master;
+		}
+
+		ret = clk_prepare_enable(mdata->spi_hclk);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to enable spi_hclk (%d)\n", ret);
+			goto err_put_master;
+		}
+	}
+
 	ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n", ret);
-		goto err_put_master;
+		goto err_disable_spi_hclk;
 	}
 
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
-		clk_disable_unprepare(mdata->spi_clk);
-		goto err_put_master;
+		goto err_disable_spi_clk;
 	}
 
 	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_disable(mdata->spi_clk);
-	else
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_disable(mdata->spi_hclk);
+	} else {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -1272,6 +1295,11 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
+err_disable_spi_clk:
+	clk_disable_unprepare(mdata->spi_clk);
+err_disable_spi_hclk:
+	if (mdata->dev_comp->need_ahb_clk)
+		clk_disable_unprepare(mdata->spi_hclk);
 err_put_master:
 	spi_master_put(master);
 
@@ -1287,8 +1315,11 @@ static int mtk_spi_remove(struct platform_device *pdev)
 
 	mtk_spi_reset(mdata);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_unprepare(mdata->spi_clk);
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_unprepare(mdata->spi_hclk);
+	}
 
 	return 0;
 }
@@ -1304,8 +1335,11 @@ static int mtk_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(dev))
+	if (!pm_runtime_suspended(dev)) {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return ret;
 }
@@ -1322,11 +1356,23 @@ static int mtk_spi_resume(struct device *dev)
 			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
 		}
+
+		if (mdata->dev_comp->need_ahb_clk) {
+			clk_prepare_enable(mdata->spi_hclk);
+			if (ret < 0) {
+				dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
+				clk_disable_unprepare(mdata->spi_clk);
+				return ret;
+			}
+		}
 	}
 
 	ret = spi_master_resume(master);
-	if (ret < 0)
+	if (ret < 0) {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return ret;
 }
@@ -1338,10 +1384,15 @@ static int mtk_spi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_disable(mdata->spi_clk);
-	else
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_disable(mdata->spi_hclk);
+	} else {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return 0;
 }
@@ -1352,13 +1403,23 @@ static int mtk_spi_runtime_resume(struct device *dev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		ret = clk_enable(mdata->spi_clk);
-	else
+		if (mdata->dev_comp->need_ahb_clk)
+			clk_enable(mdata->spi_hclk);
+	} else {
 		ret = clk_prepare_enable(mdata->spi_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
-		return ret;
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(mdata->spi_hclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
+			clk_disable_unprepare(mdata->spi_clk);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.1

