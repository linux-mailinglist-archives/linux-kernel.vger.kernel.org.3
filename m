Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A792E4E1EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiCUBlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbiCUBlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:41:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75663B540;
        Sun, 20 Mar 2022 18:39:34 -0700 (PDT)
X-UUID: d03bf63df1a945b4abd172d97eef40ff-20220321
X-UUID: d03bf63df1a945b4abd172d97eef40ff-20220321
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 90882289; Mon, 21 Mar 2022 09:39:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Mar 2022 09:39:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 09:39:26 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH V6 3/3] spi: mediatek: support hclk
Date:   Mon, 21 Mar 2022 09:39:22 +0800
Message-ID: <20220321013922.24067-4-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321013922.24067-1-leilk.liu@mediatek.com>
References: <20220321013922.24067-1-leilk.liu@mediatek.com>
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

this patch adds hclk support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 85 ++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0f91c176b878..99ce570a88a7 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -129,7 +129,7 @@ struct mtk_spi {
 	u32 state;
 	int pad_num;
 	u32 *pad_sel;
-	struct clk *parent_clk, *sel_clk, *spi_clk;
+	struct clk *parent_clk, *sel_clk, *spi_clk, *spi_hclk;
 	struct spi_transfer *cur_transfer;
 	u32 xfer_len;
 	u32 num_xfered;
@@ -1204,25 +1204,40 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
+	mdata->spi_hclk = devm_clk_get_optional(&pdev->dev, "hclk");
+	if (IS_ERR(mdata->spi_hclk)) {
+		ret = PTR_ERR(mdata->spi_hclk);
+		dev_err(&pdev->dev, "failed to get hclk: %d\n", ret);
+		goto err_put_master;
+	}
+
+	ret = clk_prepare_enable(mdata->spi_hclk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable hclk (%d)\n", ret);
+		goto err_put_master;
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
+		clk_disable(mdata->spi_hclk);
+	} else {
 		clk_disable_unprepare(mdata->spi_clk);
+		clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -1262,6 +1277,10 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
+err_disable_spi_clk:
+	clk_disable_unprepare(mdata->spi_clk);
+err_disable_spi_hclk:
+	clk_disable_unprepare(mdata->spi_hclk);
 err_put_master:
 	spi_master_put(master);
 
@@ -1277,8 +1296,10 @@ static int mtk_spi_remove(struct platform_device *pdev)
 
 	mtk_spi_reset(mdata);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_unprepare(mdata->spi_clk);
+		clk_unprepare(mdata->spi_hclk);
+	}
 
 	return 0;
 }
@@ -1294,8 +1315,10 @@ static int mtk_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(dev))
+	if (!pm_runtime_suspended(dev)) {
 		clk_disable_unprepare(mdata->spi_clk);
+		clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return ret;
 }
@@ -1312,11 +1335,20 @@ static int mtk_spi_resume(struct device *dev)
 			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
 		}
+
+		ret = clk_prepare_enable(mdata->spi_hclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
+			clk_disable_unprepare(mdata->spi_clk);
+			return ret;
+		}
 	}
 
 	ret = spi_master_resume(master);
-	if (ret < 0)
+	if (ret < 0) {
 		clk_disable_unprepare(mdata->spi_clk);
+		clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return ret;
 }
@@ -1328,10 +1360,13 @@ static int mtk_spi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_disable(mdata->spi_clk);
-	else
+		clk_disable(mdata->spi_hclk);
+	} else {
 		clk_disable_unprepare(mdata->spi_clk);
+		clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return 0;
 }
@@ -1342,13 +1377,31 @@ static int mtk_spi_runtime_resume(struct device *dev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		ret = clk_enable(mdata->spi_clk);
-	else
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
+			return ret;
+		}
+		ret = clk_enable(mdata->spi_hclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
+			clk_disable(mdata->spi_clk);
+			return ret;
+		}
+	} else {
 		ret = clk_prepare_enable(mdata->spi_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
-		return ret;
+		if (ret < 0) {
+			dev_err(dev, "failed to prepare_enable spi_clk (%d)\n", ret);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(mdata->spi_hclk);
+		if (ret < 0) {
+			dev_err(dev, "failed to prepare_enable spi_hclk (%d)\n", ret);
+			clk_disable_unprepare(mdata->spi_clk);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.1

