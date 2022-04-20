Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22755088CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377832AbiDTNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378774AbiDTNIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D3340E6B;
        Wed, 20 Apr 2022 06:05:36 -0700 (PDT)
X-UUID: f040cd105bfe4368982faccdc4cf3817-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a4f6cd21-4cfc-4b4c-a27c-f102d8c825ed,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:f5e55cf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: f040cd105bfe4368982faccdc4cf3817-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1747573874; Wed, 20 Apr 2022 21:05:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 20 Apr 2022 21:05:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 21:05:29 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V2 06/12] clk: mediatek: reset: Revise structure to control reset register
Date:   Wed, 20 Apr 2022 21:05:21 +0800
Message-ID: <20220420130527.23200-7-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mtk_clk_rst_desc to input the reset register data, and replace the
structure "struct mtk_reset" to reset.h, and rename it as
"mtk_clk_rst_data". We use them to store reset register data and
store reset controller device.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  8 +++++-
 drivers/clk/mediatek/clk-mt2701-g3d.c |  8 +++++-
 drivers/clk/mediatek/clk-mt2701-hif.c |  8 +++++-
 drivers/clk/mediatek/clk-mt2701.c     | 19 ++++++++++++--
 drivers/clk/mediatek/clk-mt2712.c     | 19 ++++++++++++--
 drivers/clk/mediatek/clk-mt7622-eth.c |  8 +++++-
 drivers/clk/mediatek/clk-mt7622-hif.c | 10 ++++++--
 drivers/clk/mediatek/clk-mt7622.c     | 19 ++++++++++++--
 drivers/clk/mediatek/clk-mt7629-eth.c |  8 +++++-
 drivers/clk/mediatek/clk-mt7629-hif.c | 10 ++++++--
 drivers/clk/mediatek/clk-mt8135.c     | 19 ++++++++++++--
 drivers/clk/mediatek/clk-mt8173.c     | 19 ++++++++++++--
 drivers/clk/mediatek/clk-mt8183.c     |  9 +++++--
 drivers/clk/mediatek/reset.c          | 36 +++++++++++++--------------
 drivers/clk/mediatek/reset.h          | 15 ++++++++++-
 15 files changed, 174 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 85a993279506..1c83ac4ee1a9 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -36,6 +36,12 @@ static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static const struct of_device_id of_match_clk_mt2701_eth[] = {
 	{ .compatible = "mediatek,mt2701-ethsys", },
 	{}
@@ -58,7 +64,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 42b9ec1bc926..8b802083642e 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -35,6 +35,12 @@ static const struct mtk_gate g3d_clks[] = {
 	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0xc,
+};
+
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -52,7 +58,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0xc, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index f20e9b1033e7..4bf57ed948dc 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -33,6 +33,12 @@ static const struct mtk_gate hif_clks[] = {
 	GATE_HIF(CLK_HIFSYS_PCIE2, "pcie2_clk", "ethpll_500m_ck", 26),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
 	{ .compatible = "mediatek,mt2701-hifsys", },
 	{}
@@ -57,7 +63,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index e6ff09b2f915..24af9588358c 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -735,6 +735,21 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	},
+};
+
 static struct clk_onecell_data *infra_clk_data;
 
 static void __init mtk_infrasys_init_early(struct device_node *node)
@@ -785,7 +800,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -908,7 +923,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index d337ca91de60..4942129bdd54 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1258,6 +1258,21 @@ static const struct mtk_pll_data plls[] = {
 		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infra */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	/* peri */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	},
+};
+
 static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -1361,7 +1376,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
 
 	return r;
 }
@@ -1383,7 +1398,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index ac3bf5aba73b..f822e8538037 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -65,6 +65,12 @@ static const struct mtk_gate sgmii_clks[] = {
 		   "ssusb_cdr_fb", 5),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -82,7 +88,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 5041126852b6..fee784fc3468 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -76,6 +76,12 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_SATA_PM_EN, "sata_pm_en", "univpll2_d4", 30),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -93,7 +99,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
@@ -115,7 +121,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index d453a2db0da7..2bcd1d95f8f9 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -610,6 +610,21 @@ static struct mtk_composite peri_muxes[] = {
 	MUX(CLK_PERIBUS_SEL, "peribus_ck_sel", peribus_ck_parents, 0x05C, 0, 1),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 1,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	},
+};
+
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -663,7 +678,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x30, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -714,7 +729,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 6baf515591f3..a6e53ce1a309 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -76,6 +76,12 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 	}
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -92,7 +98,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 2f27dac66e38..db936bdb140f 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -71,6 +71,12 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_PCIE_P0_PIPE_EN, "pcie_p0_pipe_en", "pcie0_pipe_en", 23),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -88,7 +94,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
@@ -110,7 +116,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index fa860e3b2257..1353b1695742 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -514,6 +514,21 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	}
+};
+
 static void __init mtk_topckgen_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
@@ -559,7 +574,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -587,7 +602,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 13ec0e4bdf5c..07e406459866 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,6 +819,21 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	}
+};
+
 static struct clk_onecell_data *mt8173_top_clk_data __initdata;
 static struct clk_onecell_data *mt8173_pll_clk_data __initdata;
 
@@ -882,7 +897,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -910,7 +925,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_SIMPLE);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 82a0a4980180..0130f0b1ceac 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1153,6 +1153,12 @@ static const struct mtk_pll_data plls[] = {
 		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.reg_num = 4,
+	.reg_ofs = INFRA_RST0_SET_OFFSET,
+};
+
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -1239,8 +1245,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_clk_register_rst_ctrl(node, 4,
-				  INFRA_RST0_SET_OFFSET, MTK_RST_SET_CLR);
+	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 8e42deee80a3..d67c13958458 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -14,25 +14,19 @@
 
 #include "clk-mtk.h"
 
-struct mtk_reset {
-	struct regmap *regmap;
-	int regofs;
-	struct reset_controller_dev rcdev;
-};
-
-static inline struct mtk_reset *to_rst_data(struct reset_controller_dev *rcdev)
+static inline struct mtk_clk_rst_data *to_rst_data(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct mtk_reset, rcdev);
+	return container_of(rcdev, struct mtk_clk_rst_data, rcdev);
 }
 
 static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
 				    unsigned long id, bool deassert)
 {
-	struct mtk_reset *data = to_rst_data(rcdev);
+	struct mtk_clk_rst_data *data = to_rst_data(rcdev);
 	unsigned int deassert_ofs = deassert ? 0x4 : 0;
 
 	return regmap_write(data->regmap,
-			    data->regofs + ((id / 32) << 4) + deassert_ofs,
+			    data->desc->reg_ofs + ((id / 32) << 4) + deassert_ofs,
 			    BIT(id % 32));
 }
 
@@ -71,14 +65,19 @@ static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
 };
 
 void mtk_clk_register_rst_ctrl(struct device_node *np,
-			       u32 reg_num, u16 reg_ofs, u8 version)
+			       const struct mtk_clk_rst_desc *desc)
 {
-	struct mtk_reset *data;
-	int ret;
 	struct regmap *regmap;
+	struct mtk_clk_rst_data *data;
+	int ret;
 
-	if (version >= MTK_RST_MAX) {
-		pr_err("Error version number: %d\n", version);
+	if (!desc) {
+		pr_err("mtk clock reset desc is NULL\n");
+		return;
+	}
+
+	if (desc->version >= MTK_RST_MAX) {
+		pr_err("Error version number: %d\n", desc->version);
 		return;
 	}
 
@@ -92,18 +91,17 @@ void mtk_clk_register_rst_ctrl(struct device_node *np,
 	if (!data)
 		return;
 
+	data->desc = desc;
 	data->regmap = regmap;
-	data->regofs = reg_ofs;
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = reg_num * 32;
-	data->rcdev.ops = rst_op[version];
+	data->rcdev.nr_resets = desc->reg_num * 32;
+	data->rcdev.ops = rst_op[desc->version];
 	data->rcdev.of_node = np;
 
 	ret = reset_controller_register(&data->rcdev);
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
 		kfree(data);
-		return;
 	}
 }
 
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index e4081c7217e3..3a93f61e106e 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -6,6 +6,7 @@
 #ifndef __DRV_CLK_MTK_RESET_H
 #define __DRV_CLK_MTK_RESET_H
 
+#include <linux/reset-controller.h>
 #include <linux/types.h>
 
 enum mtk_reset_version {
@@ -14,7 +15,19 @@ enum mtk_reset_version {
 	MTK_RST_MAX,
 };
 
+struct mtk_clk_rst_desc {
+	u8 version;
+	u32 reg_num;
+	u16 reg_ofs;
+};
+
+struct mtk_clk_rst_data {
+	struct regmap *regmap;
+	struct reset_controller_dev rcdev;
+	const struct mtk_clk_rst_desc *desc;
+};
+
 void mtk_clk_register_rst_ctrl(struct device_node *np,
-			       u32 reg_num, u16 reg_ofs, u8 version);
+			       const struct mtk_clk_rst_desc *desc);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

