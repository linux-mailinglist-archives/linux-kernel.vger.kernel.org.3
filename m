Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078D505A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbiDRObh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344473AbiDRO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:27:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40152E76;
        Mon, 18 Apr 2022 06:22:31 -0700 (PDT)
X-UUID: 97e3ac0d6ecc4e8db23002ebc03f733d-20220418
X-UUID: 97e3ac0d6ecc4e8db23002ebc03f733d-20220418
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 394762372; Mon, 18 Apr 2022 21:22:26 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Apr 2022 21:22:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 21:22:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 21:22:23 +0800
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
Subject: [PATCH 5/7] clk: mediatek: reset: Revise structure to control reset register
Date:   Mon, 18 Apr 2022 21:21:52 +0800
Message-ID: <20220418132154.7401-6-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the structure "struct mtk_reset" to reset.h, and rename it as
"mtk_clk_rst_data". We use it to input the resset register data and
store reset controller device.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  9 +++-
 drivers/clk/mediatek/clk-mt2701-g3d.c |  9 +++-
 drivers/clk/mediatek/clk-mt2701-hif.c |  9 +++-
 drivers/clk/mediatek/clk-mt2701.c     | 19 +++++++-
 drivers/clk/mediatek/clk-mt2712.c     | 19 +++++++-
 drivers/clk/mediatek/clk-mt7622-eth.c |  9 +++-
 drivers/clk/mediatek/clk-mt7622-hif.c | 19 +++++++-
 drivers/clk/mediatek/clk-mt7622.c     | 19 +++++++-
 drivers/clk/mediatek/clk-mt7629-eth.c |  9 +++-
 drivers/clk/mediatek/clk-mt7629-hif.c | 19 +++++++-
 drivers/clk/mediatek/clk-mt8135.c     | 19 +++++++-
 drivers/clk/mediatek/clk-mt8173.c     | 19 +++++++-
 drivers/clk/mediatek/clk-mt8183.c     | 10 ++++-
 drivers/clk/mediatek/reset.c          | 62 +++++++++++++--------------
 drivers/clk/mediatek/reset.h          | 12 +++++-
 15 files changed, 209 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 71257714e6a6..16fc4a50d513 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -36,6 +36,13 @@ static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
 };
 
+static struct mtk_clk_rst_data clk_rst_data = {
+	.supported = true,
+	.version = MTK_RST_V1,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static const struct of_device_id of_match_clk_mt2701_eth[] = {
 	{ .compatible = "mediatek,mt2701-ethsys", },
 	{}
@@ -60,7 +67,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data);
 }
 
 static struct platform_driver clk_mt2701_eth_drv = {
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index f878ffba48a9..bdaa210813f4 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -35,6 +35,13 @@ static const struct mtk_gate g3d_clks[] = {
 	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
 };
 
+static struct mtk_clk_rst_data clk_rst_data = {
+	.supported = true,
+	.version = MTK_RST_V1,
+	.reg_num = 1,
+	.reg_ofs = 0xc,
+};
+
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -54,7 +61,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0xc, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data);
 }
 
 static const struct of_device_id of_match_clk_mt2701_g3d[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index ee53b227e99a..b79cf799d8f6 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -33,6 +33,13 @@ static const struct mtk_gate hif_clks[] = {
 	GATE_HIF(CLK_HIFSYS_PCIE2, "pcie2_clk", "ethpll_500m_ck", 26),
 };
 
+static struct mtk_clk_rst_data clk_rst_data = {
+	.supported = true,
+	.version = MTK_RST_V1,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
 	{ .compatible = "mediatek,mt2701-hifsys", },
 	{}
@@ -57,7 +64,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data);
 }
 
 static struct platform_driver clk_mt2701_hif_drv = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index c1100a20c7ed..a8ac3d11ced6 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -735,6 +735,21 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
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
 
-	return mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 
 static const struct mtk_gate_regs peri0_cg_regs = {
@@ -906,7 +921,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	return mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 
 #define MT8590_PLL_FMAX		(2000 * MHZ)
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a8cfa85f06a1..cc92a54d84ce 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1258,6 +1258,21 @@ static const struct mtk_pll_data plls[] = {
 		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	},
+};
+
 static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -1363,7 +1378,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 
 static int clk_mt2712_peri_probe(struct platform_device *pdev)
@@ -1385,7 +1400,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 
 static int clk_mt2712_mcu_probe(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 33359250fab3..2d5e00a3ae5b 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -65,6 +65,13 @@ static const struct mtk_gate sgmii_clks[] = {
 		   "ssusb_cdr_fb", 5),
 };
 
+static struct mtk_clk_rst_data clk_rst_data = {
+	.supported = true,
+	.version = MTK_RST_V1,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -84,7 +91,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data);
 }
 
 static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 6be894299ae3..a10ecc5b88a1 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -76,6 +76,21 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_SATA_PM_EN, "sata_pm_en", "univpll2_d4", 30),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 1,
+		.reg_ofs = 0x34,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 1,
+		.reg_ofs = 0x34,
+	},
+};
+
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -95,7 +110,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 
 static int clk_mt7622_pciesys_init(struct platform_device *pdev)
@@ -117,7 +132,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 
 static const struct of_device_id of_match_clk_mt7622_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index e8387df38798..cd5181a43132 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -610,6 +610,21 @@ static struct mtk_composite peri_muxes[] = {
 	MUX(CLK_PERIBUS_SEL, "peribus_ck_sel", peribus_ck_parents, 0x05C, 0, 1),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 1,
+		.reg_ofs = 0x30,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
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
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x30, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
@@ -712,7 +727,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	return mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 
 static const struct of_device_id of_match_clk_mt7622[] = {
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index bf1791efe05d..c0ff826a9769 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -76,6 +76,13 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 	}
 };
 
+static struct mtk_clk_rst_data clk_rst_data = {
+	.supported = true,
+	.version = MTK_RST_V1,
+	.reg_num = 1,
+	.reg_ofs = 0x34,
+};
+
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -94,7 +101,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data);
 }
 
 static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 23d22c69d47b..3b81b7e546a4 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -71,6 +71,21 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_PCIE_P0_PIPE_EN, "pcie_p0_pipe_en", "pcie0_pipe_en", 23),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 1,
+		.reg_ofs = 0x34,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 1,
+		.reg_ofs = 0x34,
+	},
+};
+
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -90,7 +105,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 
 static int clk_mt7629_pciesys_init(struct platform_device *pdev)
@@ -112,7 +127,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_V1);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 
 static const struct of_device_id of_match_clk_mt7629_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 68ce0866c5b7..272a201c13ca 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -514,6 +514,21 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	}
+};
+
 static void __init mtk_topckgen_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
@@ -561,7 +576,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		return;
 	}
 
-	r = mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
+	r = mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -591,7 +606,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		return;
 	}
 
-	r = mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_V1);
+	r = mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index fd56dbe8ff95..56f324948a8c 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,6 +819,21 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
+static struct mtk_clk_rst_data clk_rst_data[] = {
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x30,
+	},
+	{
+		.supported = true,
+		.version = MTK_RST_V1,
+		.reg_num = 2,
+		.reg_ofs = 0x0,
+	}
+};
+
 static struct clk_onecell_data *mt8173_top_clk_data __initdata;
 static struct clk_onecell_data *mt8173_pll_clk_data __initdata;
 
@@ -884,7 +899,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		return;
 	}
 
-	r = mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_V1);
+	r = mtk_clk_register_rst_ctrl(node, &clk_rst_data[0]);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -914,7 +929,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		return;
 	}
 
-	r = mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_V1);
+	r = mtk_clk_register_rst_ctrl(node, &clk_rst_data[1]);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index e796af76f960..adf78d882c72 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1153,6 +1153,13 @@ static const struct mtk_pll_data plls[] = {
 		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
+static struct mtk_clk_rst_data clk_rst_data = {
+	.supported = true,
+	.version = MTK_RST_V2,
+	.reg_num = 4,
+	.reg_ofs = INFRA_RST0_SET_OFFSET,
+};
+
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
@@ -1239,8 +1246,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	return mtk_clk_register_rst_ctrl(node, 4,
-					 INFRA_RST0_SET_OFFSET, MTK_RST_V2);
+	return mtk_clk_register_rst_ctrl(node, &clk_rst_data);
 }
 
 static int clk_mt8183_peri_probe(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 2a55e8bf6b28..709ae54efc18 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -13,49 +13,51 @@
 
 #include "clk-mtk.h"
 
-struct mtk_reset {
-	struct regmap *regmap;
-	int regofs;
-	struct reset_controller_dev rcdev;
-};
-
 static int mtk_reset_assert_v1(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	struct mtk_clk_rst_data *data = container_of(rcdev,
+						     struct mtk_clk_rst_data,
+						     rcdev);
 
 	return regmap_update_bits(data->regmap,
-				  data->regofs + ((id / 32) << 2),
+				  data->reg_ofs + ((id / 32) << 2),
 				  BIT(id % 32), ~0);
 }
 
 static int mtk_reset_deassert_v1(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	struct mtk_clk_rst_data *data = container_of(rcdev,
+						     struct mtk_clk_rst_data,
+						     rcdev);
 
 	return regmap_update_bits(data->regmap,
-				  data->regofs + ((id / 32) << 2),
+				  data->reg_ofs + ((id / 32) << 2),
 				  BIT(id % 32), 0);
 }
 
 static int mtk_reset_assert_v2(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	struct mtk_clk_rst_data *data = container_of(rcdev,
+						     struct mtk_clk_rst_data,
+						     rcdev);
 
 	return regmap_write(data->regmap,
-			    data->regofs + ((id / 32) << 4),
+			    data->reg_ofs + ((id / 32) << 4),
 			    BIT(id % 32));
 }
 
 static int mtk_reset_deassert_v2(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	struct mtk_clk_rst_data *data = container_of(rcdev,
+						     struct mtk_clk_rst_data,
+						     rcdev);
 
 	return regmap_write(data->regmap,
-			    data->regofs + ((id / 32) << 4) + 0x4,
+			    data->reg_ofs + ((id / 32) << 4) + 0x4,
 			    BIT(id % 32));
 }
 
@@ -100,14 +102,18 @@ static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
 };
 
 int mtk_clk_register_rst_ctrl(struct device_node *np,
-			      u32 reg_num, u16 reg_ofs, u8 version)
+			      struct mtk_clk_rst_data *clk_rst)
 {
-	struct mtk_reset *data;
-	int ret;
 	struct regmap *regmap;
+	int ret;
 
-	if (version >= MTK_RST_MAX) {
-		pr_err("Error version number: %d\n", version);
+	if (!clk_rst) {
+		pr_err("mtk clock reset data is NULL\n");
+		return -EINVAL;
+	}
+
+	if (clk_rst->version >= MTK_RST_MAX) {
+		pr_err("Error version number: %d\n", clk_rst->version);
 		return -EINVAL;
 	}
 
@@ -117,21 +123,15 @@ int mtk_clk_register_rst_ctrl(struct device_node *np,
 		return -EINVAL;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->regmap = regmap;
-	data->regofs = reg_ofs;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = reg_num * 32;
-	data->rcdev.ops = rst_op[version];
-	data->rcdev.of_node = np;
+	clk_rst->regmap = regmap;
+	clk_rst->rcdev.owner = THIS_MODULE;
+	clk_rst->rcdev.nr_resets = clk_rst->reg_num * 32;
+	clk_rst->rcdev.ops = rst_op[clk_rst->version];
+	clk_rst->rcdev.of_node = np;
 
-	ret = reset_controller_register(&data->rcdev);
+	ret = reset_controller_register(&clk_rst->rcdev);
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
-		kfree(data);
 		return -EINVAL;
 	}
 
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 0af77531b918..851a29c92440 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -6,6 +6,7 @@
 #ifndef __DRV_CLK_MTK_RESET_H
 #define __DRV_CLK_MTK_RESET_H
 
+#include <linux/reset-controller.h>
 #include <linux/types.h>
 
 enum mtk_reset_version {
@@ -14,7 +15,16 @@ enum mtk_reset_version {
 	MTK_RST_MAX,
 };
 
+struct mtk_clk_rst_data {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+	bool supported;
+	u8 version;
+	u32 reg_num;
+	u16 reg_ofs;
+};
+
 int mtk_clk_register_rst_ctrl(struct device_node *np,
-			      u32 reg_num, u16 reg_ofs, u8 version);
+			      struct mtk_clk_rst_data *clk_rst);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

