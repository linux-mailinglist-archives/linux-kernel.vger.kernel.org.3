Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD74BD4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiBUEIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:08:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245659AbiBUEIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:08:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571B45529;
        Sun, 20 Feb 2022 20:07:32 -0800 (PST)
X-UUID: 1804d2669bd5490486a48795be487d3f-20220221
X-UUID: 1804d2669bd5490486a48795be487d3f-20220221
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 575632855; Mon, 21 Feb 2022 12:07:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 21 Feb 2022 12:07:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Feb 2022 12:07:25 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH V2 6/6] spi: mediatek: support spi-hclk
Date:   Mon, 21 Feb 2022 12:07:17 +0800
Message-ID: <20220221040717.3729-7-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221040717.3729-1-leilk.liu@mediatek.com>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch adds spi-hclk support.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 85 ++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 852fc008329a..7d6d8d7dea47 100644
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
@@ -1203,25 +1203,38 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
+	mdata->spi_hclk = devm_clk_get(&pdev->dev, "spi-hclk");
+	if (!IS_ERR(mdata->spi_hclk)) {
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
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_disable(mdata->spi_hclk);
+	} else {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -1261,6 +1274,11 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
+err_disable_spi_clk:
+	clk_disable_unprepare(mdata->spi_clk);
+err_disable_spi_hclk:
+	if (!IS_ERR(mdata->spi_hclk))
+		clk_disable_unprepare(mdata->spi_hclk);
 err_put_master:
 	spi_master_put(master);
 
@@ -1276,8 +1294,11 @@ static int mtk_spi_remove(struct platform_device *pdev)
 
 	mtk_spi_reset(mdata);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_unprepare(mdata->spi_clk);
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_unprepare(mdata->spi_hclk);
+	}
 
 	return 0;
 }
@@ -1293,8 +1314,11 @@ static int mtk_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(dev))
+	if (!pm_runtime_suspended(dev)) {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return ret;
 }
@@ -1311,11 +1335,23 @@ static int mtk_spi_resume(struct device *dev)
 			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
 		}
+
+		if (!IS_ERR(mdata->spi_hclk)) {
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
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return ret;
 }
@@ -1327,10 +1363,15 @@ static int mtk_spi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		clk_disable(mdata->spi_clk);
-	else
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_disable(mdata->spi_hclk);
+	} else {
 		clk_disable_unprepare(mdata->spi_clk);
+		if (!IS_ERR(mdata->spi_hclk))
+			clk_disable_unprepare(mdata->spi_hclk);
+	}
 
 	return 0;
 }
@@ -1341,13 +1382,25 @@ static int mtk_spi_runtime_resume(struct device *dev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
-	if (mdata->dev_comp->no_need_unprepare)
+	if (mdata->dev_comp->no_need_unprepare) {
 		ret = clk_enable(mdata->spi_clk);
-	else
+		if (!IS_ERR(mdata->spi_hclk))
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
+		if (!IS_ERR(mdata->spi_hclk)) {
+			ret = clk_prepare_enable(mdata->spi_hclk);
+			if (ret < 0) {
+				dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
+				clk_disable_unprepare(mdata->spi_clk);
+				return ret;
+			}
+		}
 	}
 
 	return 0;
-- 
2.25.1

