Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCB4F17B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378281AbiDDO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378115AbiDDO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:58:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C694217044;
        Mon,  4 Apr 2022 07:56:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 169781F44CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649084163;
        bh=L53ghdeLUWVQzV2A3ZJW1vrW7GualNW/UOaTx+cxwGc=;
        h=From:To:Cc:Subject:Date:From;
        b=G64xZBO+iYwNgp1QUxsfrqodzBDNqX27J415NbYquxbYvI0GghMuCpBRIke5XlCSt
         57m7fD99GFJAan7qJ09f6Ih4AZvUIzITKpNd/uOCTtJWmEnkGlp2m653BIEwucjjIf
         g8IoGHT6tlQmlBJAheW21CbhtWVS95Qs84aTxLeomYG5WO/9jM/O7SQ6YWC/FHDMdB
         9F5GKaWFfoeWuFzUe0EQex+viItxcKfMSte0igad3e1QCY552D8JI0KmAXIN/mWE30
         zbh6OAJQilOtmDzbhRIWDj55hyFGlh67cdZXLGz8Lrjxkowr1IMW4S6Ah4ymp2iQH0
         Dv/WjoMPSMcXg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] usb: musb: mediatek: Use clk_bulk API to simplify clock operations
Date:   Mon,  4 Apr 2022 16:55:58 +0200
Message-Id: <20220404145558.93340-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

This driver uses three clocks and there's no special handling, they're
either enabled or disabled sequentially: migrate to the clk_bulk API
to simplify clock handling.

This patch brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/usb/musb/mediatek.c | 73 +++++--------------------------------
 1 file changed, 10 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index 1aeb34dbe24f..cad991380b0c 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -36,6 +36,8 @@
 #define DMA_INTR_STATUS_MSK	GENMASK(7, 0)
 #define DMA_INTR_UNMASK_SET_MSK	GENMASK(31, 24)
 
+#define MTK_MUSB_CLKS_NUM	3
+
 struct mtk_glue {
 	struct device *dev;
 	struct musb *musb;
@@ -44,9 +46,7 @@ struct mtk_glue {
 	struct phy *phy;
 	struct usb_phy *xceiv;
 	enum phy_mode phy_mode;
-	struct clk *main;
-	struct clk *mcu;
-	struct clk *univpll;
+	struct clk_bulk_data clks[MTK_MUSB_CLKS_NUM];
 	enum usb_role role;
 	struct usb_role_switch *role_sw;
 };
@@ -55,64 +55,11 @@ static int mtk_musb_clks_get(struct mtk_glue *glue)
 {
 	struct device *dev = glue->dev;
 
-	glue->main = devm_clk_get(dev, "main");
-	if (IS_ERR(glue->main)) {
-		dev_err(dev, "fail to get main clock\n");
-		return PTR_ERR(glue->main);
-	}
-
-	glue->mcu = devm_clk_get(dev, "mcu");
-	if (IS_ERR(glue->mcu)) {
-		dev_err(dev, "fail to get mcu clock\n");
-		return PTR_ERR(glue->mcu);
-	}
-
-	glue->univpll = devm_clk_get(dev, "univpll");
-	if (IS_ERR(glue->univpll)) {
-		dev_err(dev, "fail to get univpll clock\n");
-		return PTR_ERR(glue->univpll);
-	}
-
-	return 0;
-}
+	glue->clks[0].id = "main";
+	glue->clks[1].id = "mcu";
+	glue->clks[2].id = "univpll";
 
-static int mtk_musb_clks_enable(struct mtk_glue *glue)
-{
-	int ret;
-
-	ret = clk_prepare_enable(glue->main);
-	if (ret) {
-		dev_err(glue->dev, "failed to enable main clock\n");
-		goto err_main_clk;
-	}
-
-	ret = clk_prepare_enable(glue->mcu);
-	if (ret) {
-		dev_err(glue->dev, "failed to enable mcu clock\n");
-		goto err_mcu_clk;
-	}
-
-	ret = clk_prepare_enable(glue->univpll);
-	if (ret) {
-		dev_err(glue->dev, "failed to enable univpll clock\n");
-		goto err_univpll_clk;
-	}
-
-	return 0;
-
-err_univpll_clk:
-	clk_disable_unprepare(glue->mcu);
-err_mcu_clk:
-	clk_disable_unprepare(glue->main);
-err_main_clk:
-	return ret;
-}
-
-static void mtk_musb_clks_disable(struct mtk_glue *glue)
-{
-	clk_disable_unprepare(glue->univpll);
-	clk_disable_unprepare(glue->mcu);
-	clk_disable_unprepare(glue->main);
+	return devm_clk_bulk_get(dev, MTK_MUSB_CLKS_NUM, glue->clks);
 }
 
 static int mtk_otg_switch_set(struct mtk_glue *glue, enum usb_role role)
@@ -390,7 +337,7 @@ static int mtk_musb_exit(struct musb *musb)
 	mtk_otg_switch_exit(glue);
 	phy_power_off(glue->phy);
 	phy_exit(glue->phy);
-	mtk_musb_clks_disable(glue);
+	clk_bulk_disable_unprepare(MTK_MUSB_CLKS_NUM, glue->clks);
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
@@ -528,7 +475,7 @@ static int mtk_musb_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ret = mtk_musb_clks_enable(glue);
+	ret = clk_bulk_prepare_enable(MTK_MUSB_CLKS_NUM, glue->clks);
 	if (ret)
 		goto err_enable_clk;
 
@@ -551,7 +498,7 @@ static int mtk_musb_probe(struct platform_device *pdev)
 	return 0;
 
 err_device_register:
-	mtk_musb_clks_disable(glue);
+	clk_bulk_disable_unprepare(MTK_MUSB_CLKS_NUM, glue->clks);
 err_enable_clk:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-- 
2.35.1

