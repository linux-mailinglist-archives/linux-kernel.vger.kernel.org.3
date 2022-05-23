Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF425313C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiEWQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiEWQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:01:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B013617C;
        Mon, 23 May 2022 09:01:07 -0700 (PDT)
X-UUID: e278bddb63d04ad28e2e5d8e5b878e88-20220524
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f2111391-fad2-47c5-b568-3293009903ab,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:55a540e3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: e278bddb63d04ad28e2e5d8e5b878e88-20220524
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 663651487; Tue, 24 May 2022 00:00:59 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 24 May 2022 00:00:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 May 2022 00:00:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 24 May 2022 00:00:58 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/8] clk: mediatek: mt2712: use mtk_clk_simple_probe to simplify driver
Date:   Tue, 24 May 2022 00:00:45 +0800
Message-ID: <20220523160053.1922-4-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220523160053.1922-1-miles.chen@mediatek.com>
References: <20220523160053.1922-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_clk_simple_probe was added by Chun-Jie to simply common flow
of MediaTek clock drivers and ChenYu enhanced the error path of
mtk_clk_simple_probe and added mtk_clk_simple_remove.

Let's use mtk_clk_simple_probe and mtk_clk_simple_probe in other
MediaTek clock drivers as well.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2712-bdp.c    | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt2712-img.c    | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt2712-jpgdec.c | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt2712-mfg.c    | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt2712-vdec.c   | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt2712-venc.c   | 34 +++++++++---------------
 6 files changed, 72 insertions(+), 132 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 9acab4357133..684d03e9f6de 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -58,33 +58,23 @@ static const struct mtk_gate bdp_clks[] = {
 	GATE_BDP(CLK_BDP_TVD_CBUS, "bdp_tvd_cbus", "mm_sel", 30),
 };
 
-static int clk_mt2712_bdp_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_BDP_NR_CLK);
-
-	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
-			clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc bdp_desc = {
+	.clks = bdp_clks,
+	.num_clks = ARRAY_SIZE(bdp_clks),
+};
 
 static const struct of_device_id of_match_clk_mt2712_bdp[] = {
-	{ .compatible = "mediatek,mt2712-bdpsys", },
-	{}
+	{
+		.compatible = "mediatek,mt2712-bdpsys",
+		.data = &bdp_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt2712_bdp_drv = {
-	.probe = clk_mt2712_bdp_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-bdp",
 		.of_match_table = of_match_clk_mt2712_bdp,
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 5cc143e65e42..335049cdc856 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -36,33 +36,23 @@ static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_CAM_SV2_EN, "img_cam_sv2_en", "mm_sel", 11),
 };
 
-static int clk_mt2712_img_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
-
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-			clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
 
 static const struct of_device_id of_match_clk_mt2712_img[] = {
-	{ .compatible = "mediatek,mt2712-imgsys", },
-	{}
+	{
+		.compatible = "mediatek,mt2712-imgsys",
+		.data = &img_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt2712_img_drv = {
-	.probe = clk_mt2712_img_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-img",
 		.of_match_table = of_match_clk_mt2712_img,
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 31fc30370d98..07ba7c5e80af 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -32,33 +32,23 @@ static const struct mtk_gate jpgdec_clks[] = {
 	GATE_JPGDEC(CLK_JPGDEC_JPGDEC, "jpgdec_jpgdec", "jpgdec_sel", 4),
 };
 
-static int clk_mt2712_jpgdec_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_JPGDEC_NR_CLK);
-
-	mtk_clk_register_gates(node, jpgdec_clks, ARRAY_SIZE(jpgdec_clks),
-			clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc jpgdec_desc = {
+	.clks = jpgdec_clks,
+	.num_clks = ARRAY_SIZE(jpgdec_clks),
+};
 
 static const struct of_device_id of_match_clk_mt2712_jpgdec[] = {
-	{ .compatible = "mediatek,mt2712-jpgdecsys", },
-	{}
+	{
+		.compatible = "mediatek,mt2712-jpgdecsys",
+		.data = &jpgdec_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt2712_jpgdec_drv = {
-	.probe = clk_mt2712_jpgdec_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-jpgdec",
 		.of_match_table = of_match_clk_mt2712_jpgdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index a4d09675bf18..42f8cf3ecf4c 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -31,33 +31,23 @@ static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
 };
 
-static int clk_mt2712_mfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
-
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
-			clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc mfg_desc = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
 
 static const struct of_device_id of_match_clk_mt2712_mfg[] = {
-	{ .compatible = "mediatek,mt2712-mfgcfg", },
-	{}
+	{
+		.compatible = "mediatek,mt2712-mfgcfg",
+		.data = &mfg_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt2712_mfg_drv = {
-	.probe = clk_mt2712_mfg_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-mfg",
 		.of_match_table = of_match_clk_mt2712_mfg,
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index af13f43dd831..6296ed5c5b55 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -50,33 +50,23 @@ static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC1(CLK_VDEC_IMGRZ_CKEN, "vdec_imgrz_cken", "vdec_sel", 1),
 };
 
-static int clk_mt2712_vdec_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
-
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-			clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
 
 static const struct of_device_id of_match_clk_mt2712_vdec[] = {
-	{ .compatible = "mediatek,mt2712-vdecsys", },
-	{}
+	{
+		.compatible = "mediatek,mt2712-vdecsys",
+		.data = &vdec_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt2712_vdec_drv = {
-	.probe = clk_mt2712_vdec_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-vdec",
 		.of_match_table = of_match_clk_mt2712_vdec,
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index abc08a029753..b9bfc35de629 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -33,33 +33,23 @@ static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_SMI_LARB6, "venc_smi_larb6", "jpgdec_sel", 12),
 };
 
-static int clk_mt2712_venc_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
-
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-			clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
 
 static const struct of_device_id of_match_clk_mt2712_venc[] = {
-	{ .compatible = "mediatek,mt2712-vencsys", },
-	{}
+	{
+		.compatible = "mediatek,mt2712-vencsys",
+		.data = &venc_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt2712_venc_drv = {
-	.probe = clk_mt2712_venc_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2712-venc",
 		.of_match_table = of_match_clk_mt2712_venc,
-- 
2.18.0

