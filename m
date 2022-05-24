Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82368532582
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiEXIjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiEXIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:39:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127284A14;
        Tue, 24 May 2022 01:39:03 -0700 (PDT)
X-UUID: 1fc62866a0f14d48a08fdd1a2e8564d1-20220524
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:57ec1f73-a9d0-4da8-b6f6-e7cbbbeceb5f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:087f6e7a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 1fc62866a0f14d48a08fdd1a2e8564d1-20220524
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2121820680; Tue, 24 May 2022 16:38:59 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 24 May 2022 16:38:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 24 May 2022 16:38:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 24 May 2022 16:38:57 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/7] clk: mediatek: mt8183: use mtk_clk_simple_probe to simplify driver
Date:   Tue, 24 May 2022 16:38:39 +0800
Message-ID: <20220524083843.9994-7-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220524083843.9994-1-miles.chen@mediatek.com>
References: <20220524083843.9994-1-miles.chen@mediatek.com>
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
 drivers/clk/mediatek/clk-mt8183-cam.c      | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-img.c      | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-ipu0.c     | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-ipu1.c     | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c  | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c   | 29 +++++++++-------------
 drivers/clk/mediatek/clk-mt8183-vdec.c     | 27 +++++++++-----------
 drivers/clk/mediatek/clk-mt8183-venc.c     | 27 +++++++++-----------
 9 files changed, 108 insertions(+), 137 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index fcc598a45165..6907b1a6a824 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -34,26 +34,23 @@ static const struct mtk_gate cam_clks[] = {
 	GATE_CAM(CLK_CAM_CCU, "cam_ccu", "cam_sel", 12),
 };
 
-static int clk_mt8183_cam_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
-
-	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc cam_desc = {
+	.clks = cam_clks,
+	.num_clks = ARRAY_SIZE(cam_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_cam[] = {
-	{ .compatible = "mediatek,mt8183-camsys", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-camsys",
+		.data = &cam_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_cam_drv = {
-	.probe = clk_mt8183_cam_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-cam",
 		.of_match_table = of_match_clk_mt8183_cam,
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index eb2def2cf0ae..8d884425d79f 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -34,26 +34,23 @@ static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_OWE, "img_owe", "img_sel", 9),
 };
 
-static int clk_mt8183_img_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
-
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_img[] = {
-	{ .compatible = "mediatek,mt8183-imgsys", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-imgsys",
+		.data = &img_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_img_drv = {
-	.probe = clk_mt8183_img_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-img",
 		.of_match_table = of_match_clk_mt8183_img,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index b30fc9f47518..953a8a33d048 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -27,26 +27,23 @@ static const struct mtk_gate ipu_core0_clks[] = {
 	GATE_IPU_CORE0(CLK_IPU_CORE0_IPU, "ipu_core0_ipu", "dsp_sel", 2),
 };
 
-static int clk_mt8183_ipu_core0_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IPU_CORE0_NR_CLK);
-
-	mtk_clk_register_gates(node, ipu_core0_clks, ARRAY_SIZE(ipu_core0_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc ipu_core0_desc = {
+	.clks = ipu_core0_clks,
+	.num_clks = ARRAY_SIZE(ipu_core0_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_ipu_core0[] = {
-	{ .compatible = "mediatek,mt8183-ipu_core0", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-ipu_core0",
+		.data = &ipu_core0_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_ipu_core0_drv = {
-	.probe = clk_mt8183_ipu_core0_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_core0",
 		.of_match_table = of_match_clk_mt8183_ipu_core0,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index b378957e11d0..221d12265974 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -27,26 +27,23 @@ static const struct mtk_gate ipu_core1_clks[] = {
 	GATE_IPU_CORE1(CLK_IPU_CORE1_IPU, "ipu_core1_ipu", "dsp_sel", 2),
 };
 
-static int clk_mt8183_ipu_core1_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IPU_CORE1_NR_CLK);
-
-	mtk_clk_register_gates(node, ipu_core1_clks, ARRAY_SIZE(ipu_core1_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc ipu_core1_desc = {
+	.clks = ipu_core1_clks,
+	.num_clks = ARRAY_SIZE(ipu_core1_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_ipu_core1[] = {
-	{ .compatible = "mediatek,mt8183-ipu_core1", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-ipu_core1",
+		.data = &ipu_core1_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_ipu_core1_drv = {
-	.probe = clk_mt8183_ipu_core1_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_core1",
 		.of_match_table = of_match_clk_mt8183_ipu_core1,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 941b43ac8bec..8c4fd96df821 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -25,26 +25,23 @@ static const struct mtk_gate ipu_adl_clks[] = {
 	GATE_IPU_ADL_I(CLK_IPU_ADL_CABGEN, "ipu_adl_cabgen", "dsp_sel", 24),
 };
 
-static int clk_mt8183_ipu_adl_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IPU_ADL_NR_CLK);
-
-	mtk_clk_register_gates(node, ipu_adl_clks, ARRAY_SIZE(ipu_adl_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc ipu_adl_desc = {
+	.clks = ipu_adl_clks,
+	.num_clks = ARRAY_SIZE(ipu_adl_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_ipu_adl[] = {
-	{ .compatible = "mediatek,mt8183-ipu_adl", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-ipu_adl",
+		.data = &ipu_adl_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_ipu_adl_drv = {
-	.probe = clk_mt8183_ipu_adl_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_adl",
 		.of_match_table = of_match_clk_mt8183_ipu_adl,
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index ae82c2e17110..14a4c3ff82a1 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -94,26 +94,23 @@ static const struct mtk_gate ipu_conn_clks[] = {
 		"ipu_conn_cab3to1_slice", "dsp1_sel", 17),
 };
 
-static int clk_mt8183_ipu_conn_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IPU_CONN_NR_CLK);
-
-	mtk_clk_register_gates(node, ipu_conn_clks, ARRAY_SIZE(ipu_conn_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc ipu_conn_desc = {
+	.clks = ipu_conn_clks,
+	.num_clks = ARRAY_SIZE(ipu_conn_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_ipu_conn[] = {
-	{ .compatible = "mediatek,mt8183-ipu_conn", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-ipu_conn",
+		.data = &ipu_conn_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_ipu_conn_drv = {
-	.probe = clk_mt8183_ipu_conn_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-ipu_conn",
 		.of_match_table = of_match_clk_mt8183_ipu_conn,
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index d774edaf760b..f578b393f41e 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -26,28 +26,23 @@ static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0)
 };
 
-static int clk_mt8183_mfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	pm_runtime_enable(&pdev->dev);
-
-	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
-
-	mtk_clk_register_gates_with_dev(node, mfg_clks, ARRAY_SIZE(mfg_clks),
-			clk_data, &pdev->dev);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc mfg_desc = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_mfg[] = {
-	{ .compatible = "mediatek,mt8183-mfgcfg", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-mfgcfg",
+		.data = &mfg_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_mfg_drv = {
-	.probe = clk_mt8183_mfg_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-mfg",
 		.of_match_table = of_match_clk_mt8183_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index 0548cde159d0..c294e50b96b7 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -38,26 +38,23 @@ static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC1_I(CLK_VDEC_LARB1, "vdec_larb1", "mm_sel", 0),
 };
 
-static int clk_mt8183_vdec_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
-
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_vdec[] = {
-	{ .compatible = "mediatek,mt8183-vdecsys", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-vdecsys",
+		.data = &vdec_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_vdec_drv = {
-	.probe = clk_mt8183_vdec_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-vdec",
 		.of_match_table = of_match_clk_mt8183_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index f86ec607d87a..0051c5d92fc5 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -30,26 +30,23 @@ static const struct mtk_gate venc_clks[] = {
 		"mm_sel", 8),
 };
 
-static int clk_mt8183_venc_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
-
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-			clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_venc[] = {
-	{ .compatible = "mediatek,mt8183-vencsys", },
-	{}
+	{
+		.compatible = "mediatek,mt8183-vencsys",
+		.data = &venc_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt8183_venc_drv = {
-	.probe = clk_mt8183_venc_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-venc",
 		.of_match_table = of_match_clk_mt8183_venc,
-- 
2.18.0

