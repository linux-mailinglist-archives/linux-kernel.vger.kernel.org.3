Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABA505A07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbiDRObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbiDRO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:27:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8A52B19;
        Mon, 18 Apr 2022 06:22:28 -0700 (PDT)
X-UUID: 50c7e66351af474da1f771aa3d23058b-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:46f4d9a7-debe-4fc7-821f-b6ff8e4a6401,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:539c41ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 50c7e66351af474da1f771aa3d23058b-20220418
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1371199606; Mon, 18 Apr 2022 21:22:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 18 Apr 2022 21:22:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 21:22:22 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <yong.liang@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <allen-kh.cheng@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 3/7] clk: mediatek: reset: Merge and revise reset register function
Date:   Mon, 18 Apr 2022 21:21:50 +0800
Message-ID: <20220418132154.7401-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the reset register function of v1 and v2 into one function.
- Input the version number to determine which version we will use.
- Add return value of reset register function for error handling.
- Rename reset register function to "mtk_clk_register_rst_ctrl"

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  8 +++---
 drivers/clk/mediatek/clk-mt2701-g3d.c |  8 +++---
 drivers/clk/mediatek/clk-mt2701-hif.c |  4 +--
 drivers/clk/mediatek/clk-mt2701.c     |  8 ++----
 drivers/clk/mediatek/clk-mt2712.c     | 16 +++++------
 drivers/clk/mediatek/clk-mt7622-eth.c |  8 +++---
 drivers/clk/mediatek/clk-mt7622-hif.c | 16 +++++------
 drivers/clk/mediatek/clk-mt7622.c     |  8 ++----
 drivers/clk/mediatek/clk-mt7629-eth.c |  8 +++---
 drivers/clk/mediatek/clk-mt7629-hif.c | 16 +++++------
 drivers/clk/mediatek/clk-mt8135.c     | 12 +++++---
 drivers/clk/mediatek/clk-mt8173.c     | 12 +++++---
 drivers/clk/mediatek/clk-mt8183.c     |  5 ++--
 drivers/clk/mediatek/clk-mtk.h        | 13 +++++----
 drivers/clk/mediatek/reset.c          | 41 +++++++++++++--------------
 15 files changed, 90 insertions(+), 93 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index f3e56a988177..71257714e6a6 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -53,14 +53,14 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 						clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static struct platform_driver clk_mt2701_eth_drv = {
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 5a41d4607e77..f878ffba48a9 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -47,14 +47,14 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0xc);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0xc, MTK_RST_V1);
 }
 
 static const struct of_device_id of_match_clk_mt2701_g3d[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 426a54cb077b..ee53b227e99a 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,9 +57,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return 0;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static struct platform_driver clk_mt2701_hif_drv = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 0e103d6735bb..c1100a20c7ed 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -785,9 +785,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_v1(node, 2, 0x30);
-
-	return 0;
+	return mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
 }
 
 static const struct mtk_gate_regs peri0_cg_regs = {
@@ -908,9 +906,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_v1(node, 2, 0x0);
-
-	return 0;
+	return mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_V1);
 }
 
 #define MT8590_PLL_FMAX		(2000 * MHZ)
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index e80fc89a5a07..a8cfa85f06a1 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1357,13 +1357,13 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 
-	if (r != 0)
+	if (r != 0) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 2, 0x30);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
 }
 
 static int clk_mt2712_peri_probe(struct platform_device *pdev)
@@ -1379,13 +1379,13 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 
-	if (r != 0)
+	if (r != 0) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 2, 0);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_V1);
 }
 
 static int clk_mt2712_mcu_probe(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 13f346643e26..33359250fab3 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -77,14 +77,14 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 32855bb489a2..6be894299ae3 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -88,14 +88,14 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static int clk_mt7622_pciesys_init(struct platform_device *pdev)
@@ -110,14 +110,14 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static const struct of_device_id of_match_clk_mt7622_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 953e81049957..e8387df38798 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -663,9 +663,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_v1(node, 1, 0x30);
-
-	return 0;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x30, MTK_RST_V1);
 }
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
@@ -714,9 +712,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_register_reset_controller_v1(node, 2, 0x0);
-
-	return 0;
+	return mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_V1);
 }
 
 static const struct of_device_id of_match_clk_mt7622[] = {
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index e47b66c67079..bf1791efe05d 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -87,14 +87,14 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 72f261f12e92..23d22c69d47b 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -83,14 +83,14 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static int clk_mt7629_pciesys_init(struct platform_device *pdev)
@@ -105,14 +105,14 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			       clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
+		return r;
+	}
 
-	mtk_register_reset_controller_v1(node, 1, 0x34);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
 }
 
 static const struct of_device_id of_match_clk_mt7629_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index d649e817b320..68ce0866c5b7 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -555,11 +555,13 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	clk_prepare_enable(clk_data->clks[CLK_INFRA_M4U]);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return;
+	}
 
-	mtk_register_reset_controller_v1(node, 2, 0x30);
+	r = mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -583,11 +585,13 @@ static void __init mtk_pericfg_init(struct device_node *node)
 			&mt8135_clk_lock, clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return;
+	}
 
-	mtk_register_reset_controller_v1(node, 2, 0);
+	r = mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_V1);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 11becf2f7a9f..fd56dbe8ff95 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -878,11 +878,13 @@ static void __init mtk_infrasys_init(struct device_node *node)
 				  clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return;
+	}
 
-	mtk_register_reset_controller_v1(node, 2, 0x30);
+	r = mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -906,11 +908,13 @@ static void __init mtk_pericfg_init(struct device_node *node)
 			&mt8173_clk_lock, clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-	if (r)
+	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+		return;
+	}
 
-	mtk_register_reset_controller_v1(node, 2, 0);
+	r = mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_V1);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index ac76328c423d..e796af76f960 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1239,9 +1239,8 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_v2(node, 4, INFRA_RST0_SET_OFFSET);
-
-	return r;
+	return mtk_clk_register_rst_ctrl(node, 4,
+					 INFRA_RST0_SET_OFFSET, MTK_RST_V2);
 }
 
 static int clk_mt8183_peri_probe(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 601db24a342b..dafdf30fe94e 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -178,6 +178,12 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
+enum mtk_reset_version {
+	MTK_RST_V1 = 0,
+	MTK_RST_V2,
+	MTK_RST_MAX,
+};
+
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
 			      struct clk_onecell_data *clk_data);
@@ -190,11 +196,8 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data);
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
-void mtk_register_reset_controller_v1(struct device_node *np,
-				      unsigned int num_regs, int regofs);
-
-void mtk_register_reset_controller_v2(struct device_node *np,
-				      unsigned int num_regs, int regofs);
+int mtk_clk_register_rst_ctrl(struct device_node *np,
+			      u32 reg_num, u16 reg_ofs, u8 version);
 
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index b1012b0c44d0..2a55e8bf6b28 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -94,51 +94,48 @@ static const struct reset_control_ops mtk_reset_ops_v2 = {
 	.reset = mtk_reset_v2,
 };
 
-static void mtk_register_reset_controller_common(struct device_node *np,
-			unsigned int num_regs, int regofs,
-			const struct reset_control_ops *reset_ops)
+static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
+	[MTK_RST_V1] = &mtk_reset_ops_v1,
+	[MTK_RST_V2] = &mtk_reset_ops_v2,
+};
+
+int mtk_clk_register_rst_ctrl(struct device_node *np,
+			      u32 reg_num, u16 reg_ofs, u8 version)
 {
 	struct mtk_reset *data;
 	int ret;
 	struct regmap *regmap;
 
+	if (version >= MTK_RST_MAX) {
+		pr_err("Error version number: %d\n", version);
+		return -EINVAL;
+	}
+
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
-		return;
+		return -EINVAL;
 	}
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return;
+		return -ENOMEM;
 
 	data->regmap = regmap;
-	data->regofs = regofs;
+	data->regofs = reg_ofs;
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = num_regs * 32;
-	data->rcdev.ops = reset_ops;
+	data->rcdev.nr_resets = reg_num * 32;
+	data->rcdev.ops = rst_op[version];
 	data->rcdev.of_node = np;
 
 	ret = reset_controller_register(&data->rcdev);
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
 		kfree(data);
-		return;
+		return -EINVAL;
 	}
-}
 
-void mtk_register_reset_controller_v1(struct device_node *np,
-	unsigned int num_regs, int regofs)
-{
-	mtk_register_reset_controller_common(np, num_regs, regofs,
-					     &mtk_reset_ops_v1);
-}
-
-void mtk_register_reset_controller_v2(struct device_node *np,
-	unsigned int num_regs, int regofs)
-{
-	mtk_register_reset_controller_common(np, num_regs, regofs,
-					     &mtk_reset_ops_v2);
+	return 0;
 }
 
 MODULE_LICENSE("GPL");
-- 
2.18.0

