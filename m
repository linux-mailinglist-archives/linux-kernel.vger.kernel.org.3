Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAE532578
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiEXIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiEXIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:39:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E27E1EC;
        Tue, 24 May 2022 01:38:57 -0700 (PDT)
X-UUID: 2957b3c3af1a46cbb03bdca6c9348708-20220524
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:af136d66-dbc1-4ca0-a955-8251959bbd73,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:9f7d6e7a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 2957b3c3af1a46cbb03bdca6c9348708-20220524
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1635386091; Tue, 24 May 2022 16:38:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 24 May 2022 16:38:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 24 May 2022 16:38:52 +0800
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
Subject: [PATCH v2 3/7] clk: mediatek: mt6765: use mtk_clk_simple_probe to simplify driver
Date:   Tue, 24 May 2022 16:38:36 +0800
Message-ID: <20220524083843.9994-4-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220524083843.9994-1-miles.chen@mediatek.com>
References: <20220524083843.9994-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
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
 drivers/clk/mediatek/clk-mt6765-audio.c  | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt6765-cam.c    | 33 +++++++++--------------
 drivers/clk/mediatek/clk-mt6765-img.c    | 33 +++++++++--------------
 drivers/clk/mediatek/clk-mt6765-mipi0a.c | 34 +++++++++---------------
 drivers/clk/mediatek/clk-mt6765-mm.c     | 33 +++++++++--------------
 drivers/clk/mediatek/clk-mt6765-vcodec.c | 34 +++++++++---------------
 6 files changed, 72 insertions(+), 129 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 9c6e9caad597..0aa6c0d352ca 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -64,33 +64,23 @@ static const struct mtk_gate audio_clks[] = {
 		    "audio_ck", 7),
 };
 
-static int clk_mt6765_audio_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
-
-	mtk_clk_register_gates(node, audio_clks,
-			       ARRAY_SIZE(audio_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc audio_desc = {
+	.clks = audio_clks,
+	.num_clks = ARRAY_SIZE(audio_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6765_audio[] = {
-	{ .compatible = "mediatek,mt6765-audsys", },
-	{}
+	{
+		.compatible = "mediatek,mt6765-audsys",
+		.data = &audio_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6765_audio_drv = {
-	.probe = clk_mt6765_audio_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-audio",
 		.of_match_table = of_match_clk_mt6765_audio,
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 2586d3ac4cd4..25f2bef38126 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -39,32 +39,23 @@ static const struct mtk_gate cam_clks[] = {
 	GATE_CAM(CLK_CAM_CCU, "cam_ccu", "mm_ck", 12),
 };
 
-static int clk_mt6765_cam_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
-
-	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc cam_desc = {
+	.clks = cam_clks,
+	.num_clks = ARRAY_SIZE(cam_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6765_cam[] = {
-	{ .compatible = "mediatek,mt6765-camsys", },
-	{}
+	{
+		.compatible = "mediatek,mt6765-camsys",
+		.data = &cam_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6765_cam_drv = {
-	.probe = clk_mt6765_cam_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-cam",
 		.of_match_table = of_match_clk_mt6765_cam,
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index 8cc95b98921e..a62303ef4f41 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -35,32 +35,23 @@ static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_RSC, "img_rsc", "mm_ck", 5),
 };
 
-static int clk_mt6765_img_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
-
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6765_img[] = {
-	{ .compatible = "mediatek,mt6765-imgsys", },
-	{}
+	{
+		.compatible = "mediatek,mt6765-imgsys",
+		.data = &img_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6765_img_drv = {
-	.probe = clk_mt6765_img_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-img",
 		.of_match_table = of_match_clk_mt6765_img,
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index c816e26a95f9..25c829fc3866 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -32,33 +32,23 @@ static const struct mtk_gate mipi0a_clks[] = {
 		    "mipi0a_csr_0a", "f_fseninf_ck", 1),
 };
 
-static int clk_mt6765_mipi0a_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_MIPI0A_NR_CLK);
-
-	mtk_clk_register_gates(node, mipi0a_clks,
-			       ARRAY_SIZE(mipi0a_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc mipi0a_desc = {
+	.clks = mipi0a_clks,
+	.num_clks = ARRAY_SIZE(mipi0a_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6765_mipi0a[] = {
-	{ .compatible = "mediatek,mt6765-mipi0a", },
-	{}
+	{
+		.compatible = "mediatek,mt6765-mipi0a",
+		.data = &mipi0a_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6765_mipi0a_drv = {
-	.probe = clk_mt6765_mipi0a_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-mipi0a",
 		.of_match_table = of_match_clk_mt6765_mipi0a,
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index ee6d3b859a6c..bda774668a36 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -61,32 +61,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM(CLK_MM_F26M_HRTWT, "mm_hrtwt", "f_f26m_ck", 29),
 };
 
-static int clk_mt6765_mm_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6765_mm[] = {
-	{ .compatible = "mediatek,mt6765-mmsys", },
-	{}
+	{
+		.compatible = "mediatek,mt6765-mmsys",
+		.data = &mm_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6765_mm_drv = {
-	.probe = clk_mt6765_mm_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-mm",
 		.of_match_table = of_match_clk_mt6765_mm,
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index d8045979d48a..2bc1fbde87da 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -34,33 +34,23 @@ static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_SET3_VDEC, "venc_set3_vdec", "mm_ck", 12),
 };
 
-static int clk_mt6765_vcodec_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
-
-	mtk_clk_register_gates(node, venc_clks,
-			       ARRAY_SIZE(venc_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-
-	return r;
-}
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
 
 static const struct of_device_id of_match_clk_mt6765_vcodec[] = {
-	{ .compatible = "mediatek,mt6765-vcodecsys", },
-	{}
+	{
+		.compatible = "mediatek,mt6765-vcodecsys",
+		.data = &venc_desc,
+	}, {
+		/* sentinel */
+	}
 };
 
 static struct platform_driver clk_mt6765_vcodec_drv = {
-	.probe = clk_mt6765_vcodec_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6765-vcodec",
 		.of_match_table = of_match_clk_mt6765_vcodec,
-- 
2.18.0

