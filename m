Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680C5513326
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245177AbiD1MAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbiD1L7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBEB636A;
        Thu, 28 Apr 2022 04:56:29 -0700 (PDT)
X-UUID: a1f9ecfda774469fabcd8f37940becbe-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1b43542b-8a36-44ac-b48e-cdfa216c27be,OB:50,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:1b43542b-8a36-44ac-b48e-cdfa216c27be,OB:50,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:df590c2f-6199-437e-8ab4-9920b4bc5b76,C
        OID:d7c54ea7e6a2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: a1f9ecfda774469fabcd8f37940becbe-20220428
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 864249597; Thu, 28 Apr 2022 19:56:23 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 28 Apr 2022 19:56:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 19:56:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 19:56:22 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V5 06/16] clk: mediatek: reset: Revise structure to control reset register
Date:   Thu, 28 Apr 2022 19:56:09 +0800
Message-ID: <20220428115620.13512-7-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
References: <20220428115620.13512-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To declare the reset data easier, we add a strucure to do this instead
of using many input variables to mtk_register_reset_controller().

- Add mtk_clk_rst_desc to define the reset description when registering
  the reset controller.
- Rename "mtk_reset" to "mtk_clk_rst_data". We use it to store data of
  reset controller.
- Document mtk_clk_rst_desc and mtk_clk_rst_data.
- Modify the documentation of mtk_register_reset_controller.
- Extract container_of in update functions to to_mtk_clk_rst_data().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  8 ++++++-
 drivers/clk/mediatek/clk-mt2701-g3d.c |  8 ++++++-
 drivers/clk/mediatek/clk-mt2701-hif.c |  8 ++++++-
 drivers/clk/mediatek/clk-mt2701.c     | 19 ++++++++++++++--
 drivers/clk/mediatek/clk-mt2712.c     | 19 ++++++++++++++--
 drivers/clk/mediatek/clk-mt7622-eth.c |  8 ++++++-
 drivers/clk/mediatek/clk-mt7622-hif.c | 10 +++++++--
 drivers/clk/mediatek/clk-mt7622.c     | 19 ++++++++++++++--
 drivers/clk/mediatek/clk-mt7629-eth.c |  8 ++++++-
 drivers/clk/mediatek/clk-mt7629-hif.c | 10 +++++++--
 drivers/clk/mediatek/clk-mt8135.c     | 19 ++++++++++++++--
 drivers/clk/mediatek/clk-mt8173.c     | 19 ++++++++++++++--
 drivers/clk/mediatek/clk-mt8183.c     |  9 ++++++--
 drivers/clk/mediatek/reset.c          | 32 ++++++++++++++++++---------
 drivers/clk/mediatek/reset.h          | 28 ++++++++++++++++++-----
 15 files changed, 186 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 0270979ccc20..2cc35dfdbca7 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -36,6 +36,12 @@ static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0x34,
+};
+
 static const struct of_device_id of_match_clk_mt2701_eth[] = {
 	{ .compatible = "mediatek,mt2701-ethsys", },
 	{}
@@ -58,7 +64,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index e406f863dcf0..0905d5c12691 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -35,6 +35,12 @@ static const struct mtk_gate g3d_clks[] = {
 	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0xc,
+};
+
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -52,7 +58,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0xc, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 352ca7a646c3..24d5bac1bb9b 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -33,6 +33,12 @@ static const struct mtk_gate hif_clks[] = {
 	GATE_HIF(CLK_HIFSYS_PCIE2, "pcie2_clk", "ethpll_500m_ck", 26),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0x34,
+};
+
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
 	{ .compatible = "mediatek,mt2701-hifsys", },
 	{}
@@ -57,7 +63,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 591479222e75..70a934faa529 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -735,6 +735,21 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
+		.reg_ofs = 0x0,
+	},
+};
+
 static struct clk_onecell_data *infra_clk_data;
 
 static void __init mtk_infrasys_init_early(struct device_node *node)
@@ -785,7 +800,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -908,7 +923,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 2, 0x0, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index b311b43fbbd3..cef7c79788ec 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1258,6 +1258,21 @@ static const struct mtk_pll_data plls[] = {
 		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infra */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
+		.reg_ofs = 0x30,
+	},
+	/* peri */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
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
 
-	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[0]);
 
 	return r;
 }
@@ -1383,7 +1398,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[1]);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index bfdd09f3b72d..b6da1871a1f9 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -65,6 +65,12 @@ static const struct mtk_gate sgmii_clks[] = {
 		   "ssusb_cdr_fb", 5),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -82,7 +88,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 892da27f6077..c2841deb52a5 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -76,6 +76,12 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_SATA_PM_EN, "sata_pm_en", "univpll2_d4", 30),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -93,7 +99,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
@@ -115,7 +121,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 5bb3757f4217..880e752527a9 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -610,6 +610,21 @@ static struct mtk_composite peri_muxes[] = {
 	MUX(CLK_PERIBUS_SEL, "peribus_ck_sel", peribus_ck_parents, 0x05C, 0, 1),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 1,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
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
 
-	mtk_register_reset_controller(node, 1, 0x30, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -714,7 +729,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_register_reset_controller(node, 2, 0x0, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 1c57589b39fd..e054aa1e1479 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -76,6 +76,12 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 	}
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -92,7 +98,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 6761151ca839..ab085092041e 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -71,6 +71,12 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_PCIE_P0_PIPE_EN, "pcie_p0_pipe_en", "pcie0_pipe_en", 23),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_nr = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -88,7 +94,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
@@ -110,7 +116,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index d95b5dfa580c..a4cfc094895c 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -514,6 +514,21 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
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
 
-	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[0]);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -587,7 +602,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 56120b148761..cba1495b2a67 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,6 +819,21 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc[] = {
+	/* infrasys */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
+		.reg_ofs = 0x30,
+	},
+	/* pericfg */
+	{
+		.version = MTK_RST_SIMPLE,
+		.rst_bank_nr = 2,
+		.reg_ofs = 0x0,
+	}
+};
+
 static struct clk_onecell_data *mt8173_top_clk_data __initdata;
 static struct clk_onecell_data *mt8173_pll_clk_data __initdata;
 
@@ -882,7 +897,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[0]);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -910,7 +925,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0, MTK_RST_SIMPLE);
+	mtk_register_reset_controller(node, &clk_rst_desc[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 9b27f1ffc600..3517eca5ee83 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1153,6 +1153,12 @@ static const struct mtk_pll_data plls[] = {
 		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_nr = 4,
+	.reg_ofs = INFRA_RST0_SET_OFFSET,
+};
+
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -1239,8 +1245,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, 4,
-				      INFRA_RST0_SET_OFFSET, MTK_RST_SET_CLR);
+	mtk_register_reset_controller(node, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index a54a835c1d47..47bc6b1842fd 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -12,14 +12,19 @@
 
 #include "reset.h"
 
+static inline struct mtk_clk_rst_data *to_mtk_clk_rst_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct mtk_clk_rst_data, rcdev);
+}
+
 static int mtk_reset_update(struct reset_controller_dev *rcdev,
 			    unsigned long id, bool deassert)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
 	unsigned int val = deassert ? 0 : ~0;
 
 	return regmap_update_bits(data->regmap,
-				  data->regofs + ((id / 32) << 2),
+				  data->desc->reg_ofs + ((id / 32) << 2),
 				  BIT(id % 32), val);
 }
 
@@ -49,11 +54,11 @@ static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
 static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
 				    unsigned long id, bool deassert)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
 	unsigned int deassert_ofs = deassert ? 0x4 : 0;
 
 	return regmap_write(data->regmap,
-			    data->regofs + ((id / 32) << 4) + deassert_ofs,
+			    data->desc->reg_ofs + ((id / 32) << 4) + deassert_ofs,
 			    BIT(id % 32));
 }
 
@@ -93,14 +98,19 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 };
 
 void mtk_register_reset_controller(struct device_node *np,
-				   u32 rst_bank_nr, u16 reg_ofs, u8 version)
+				   const struct mtk_clk_rst_desc *desc)
 {
-	struct mtk_reset *data;
-	int ret;
 	struct regmap *regmap;
 	const struct reset_control_ops *rcops = NULL;
+	struct mtk_clk_rst_data *data;
+	int ret;
+
+	if (!desc) {
+		pr_err("mtk clock reset desc is NULL\n");
+		return;
+	}
 
-	switch (version) {
+	switch (desc->version) {
 	case MTK_RST_SIMPLE:
 		rcops = &mtk_reset_ops;
 		break;
@@ -108,7 +118,7 @@ void mtk_register_reset_controller(struct device_node *np,
 		rcops = &mtk_reset_ops_set_clr;
 		break;
 	default:
-		pr_err("Unknown reset version %d\n", version);
+		pr_err("Unknown reset version %d\n", desc->version);
 		return;
 	}
 
@@ -122,10 +132,10 @@ void mtk_register_reset_controller(struct device_node *np,
 	if (!data)
 		return;
 
+	data->desc = desc;
 	data->regmap = regmap;
-	data->regofs = reg_ofs;
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = rst_bank_nr * 32;
+	data->rcdev.nr_resets = desc->rst_bank_nr * 32;
 	data->rcdev.ops = rcops;
 	data->rcdev.of_node = np;
 
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 2a39eec9cff7..91358e8cb851 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -21,20 +21,36 @@ enum mtk_reset_version {
 	MTK_RST_MAX,
 };
 
-struct mtk_reset {
+/**
+ * struct mtk_clk_rst_desc - Description of MediaTek clock reset.
+ * @version: Reset version which is defined in enum mtk_reset_version.
+ * @reg_ofs: Base offset of the reset register.
+ * @rst_bank_nr: Quantity of reset bank.
+ */
+struct mtk_clk_rst_desc {
+	u8 version;
+	u16 reg_ofs;
+	u32 rst_bank_nr;
+};
+
+/**
+ * struct mtk_clk_rst_data - Data of MediaTek clock reset controller.
+ * @regmap: Pointer to base address of reset register address.
+ * @rcdev: Reset controller device.
+ * @desc: Pointer to description of the reset controller.
+ */
+struct mtk_clk_rst_data {
 	struct regmap *regmap;
-	int regofs;
 	struct reset_controller_dev rcdev;
+	const struct mtk_clk_rst_desc *desc;
 };
 
 /**
  * mtk_register_reset_controller - Register MediaTek clock reset controller
  * @np: Pointer to device node.
- * @rst_bank_nr: Quantity of reset bank.
- * @reg_ofs: Base offset of the reset register.
- * @version: Version of MediaTek clock reset controller.
+ * @desc: Constant pointer to description of clock reset.
  */
 void mtk_register_reset_controller(struct device_node *np,
-				   u32 rst_bank_nr, u16 reg_ofs, u8 version);
+				   const struct mtk_clk_rst_desc *desc);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

