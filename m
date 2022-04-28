Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E3513322
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346097AbiD1MAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345840AbiD1L7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC588B0A;
        Thu, 28 Apr 2022 04:56:32 -0700 (PDT)
X-UUID: 3b068e6ae44a4f5b9e2943097bfd345c-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5a2b4a0e-5f95-474f-a97e-cf0904b1a5d4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:325a0c2f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3b068e6ae44a4f5b9e2943097bfd345c-20220428
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 913292482; Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 19:56:23 +0800
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
Subject: [PATCH V5 07/16] clk: mediatek: reset: Support nonsequence base offsets of reset registers
Date:   Thu, 28 Apr 2022 19:56:10 +0800
Message-ID: <20220428115620.13512-8-rex-bc.chen@mediatek.com>
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

The bank offsets are not serial for all reset registers.
For example, there are five infra reset banks for MT8192: 0x120, 0x130,
0x140, 0x150 and 0x730.

To support this,
- Change reg_ofs to rst_bank_ofs which is a pointer to base offsets of
  the reset register.
- Add a new define RST_NR_PER_BANK to define reset number for each
  reset bank.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  6 ++++--
 drivers/clk/mediatek/clk-mt2701-g3d.c |  6 ++++--
 drivers/clk/mediatek/clk-mt2701-hif.c |  6 ++++--
 drivers/clk/mediatek/clk-mt2701.c     | 11 +++++++----
 drivers/clk/mediatek/clk-mt2712.c     | 11 +++++++----
 drivers/clk/mediatek/clk-mt7622-eth.c |  6 ++++--
 drivers/clk/mediatek/clk-mt7622-hif.c |  6 ++++--
 drivers/clk/mediatek/clk-mt7622.c     | 11 +++++++----
 drivers/clk/mediatek/clk-mt7629-eth.c |  6 ++++--
 drivers/clk/mediatek/clk-mt7629-hif.c |  6 ++++--
 drivers/clk/mediatek/clk-mt8135.c     | 11 +++++++----
 drivers/clk/mediatek/clk-mt8173.c     | 11 +++++++----
 drivers/clk/mediatek/clk-mt8183.c     | 14 ++++++++++++--
 drivers/clk/mediatek/reset.c          | 11 ++++++-----
 drivers/clk/mediatek/reset.h          |  6 ++++--
 15 files changed, 85 insertions(+), 43 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 2cc35dfdbca7..0ae4bce3bb37 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -36,10 +36,12 @@ static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
 };
 
+static u16 rst_ofs[] = { 0x34, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0x34,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static const struct of_device_id of_match_clk_mt2701_eth[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 0905d5c12691..8d2053517ddc 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -35,10 +35,12 @@ static const struct mtk_gate g3d_clks[] = {
 	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
 };
 
+static u16 rst_ofs[] = { 0xC, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0xc,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 24d5bac1bb9b..e40865a6f45e 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -33,10 +33,12 @@ static const struct mtk_gate hif_clks[] = {
 	GATE_HIF(CLK_HIFSYS_PCIE2, "pcie2_clk", "ethpll_500m_ck", 26),
 };
 
+static u16 rst_ofs[] = { 0x34, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0x34,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 70a934faa529..572d62f76e96 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -735,18 +735,21 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
+static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	/* infrasys */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x30,
+		.rst_bank_ofs = infrasys_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 	},
 	/* pericfg */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x0,
+		.rst_bank_ofs = pericfg_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 	},
 };
 
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index cef7c79788ec..9eb8866ec77a 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1258,18 +1258,21 @@ static const struct mtk_pll_data plls[] = {
 		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
 };
 
+static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	/* infra */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x30,
+		.rst_bank_ofs = infrasys_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 	},
 	/* peri */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x0,
+		.rst_bank_ofs = pericfg_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 	},
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index b6da1871a1f9..b58fe61a8443 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -65,10 +65,12 @@ static const struct mtk_gate sgmii_clks[] = {
 		   "ssusb_cdr_fb", 5),
 };
 
+static u16 rst_ofs[] = { 0x34, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0x34,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index c2841deb52a5..1ee79d4837a4 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -76,10 +76,12 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_SATA_PM_EN, "sata_pm_en", "univpll2_d4", 30),
 };
 
+static u16 rst_ofs[] = { 0x34, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0x34,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 880e752527a9..8ebd66dcb946 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -610,18 +610,21 @@ static struct mtk_composite peri_muxes[] = {
 	MUX(CLK_PERIBUS_SEL, "peribus_ck_sel", peribus_ck_parents, 0x05C, 0, 1),
 };
 
+static u16 infrasys_rst_ofs[] = { 0x30, };
+static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	/* infrasys */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 1,
-		.reg_ofs = 0x30,
+		.rst_bank_ofs = infrasys_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 	},
 	/* pericfg */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x0,
+		.rst_bank_ofs = pericfg_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 	},
 };
 
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index e054aa1e1479..56ff7c1f6ec1 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -76,10 +76,12 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 	}
 };
 
+static u16 rst_ofs[] = { 0x34, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0x34,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index ab085092041e..fc12110b04fc 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -71,10 +71,12 @@ static const struct mtk_gate pcie_clks[] = {
 	GATE_PCIE(CLK_PCIE_P0_PIPE_EN, "pcie_p0_pipe_en", "pcie0_pipe_en", 23),
 };
 
+static u16 rst_ofs[] = { 0x34, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SIMPLE,
-	.rst_bank_nr = 1,
-	.reg_ofs = 0x34,
+	.rst_bank_ofs = rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index a4cfc094895c..8b7fb5e2c5c2 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -514,18 +514,21 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
+static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	/* infrasys */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x30,
+		.rst_bank_ofs = infrasys_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 	},
 	/* pericfg */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x0,
+		.rst_bank_ofs = pericfg_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 	}
 };
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index cba1495b2a67..4228ee56da37 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,18 +819,21 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
+static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
+static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
+
 static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	/* infrasys */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x30,
+		.rst_bank_ofs = infrasys_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 	},
 	/* pericfg */
 	{
 		.version = MTK_RST_SIMPLE,
-		.rst_bank_nr = 2,
-		.reg_ofs = 0x0,
+		.rst_bank_ofs = pericfg_rst_ofs,
+		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
 	}
 };
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 3517eca5ee83..de4ba5e055ca 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -20,6 +20,9 @@
 
 /* Infra global controller reset set register */
 #define INFRA_RST0_SET_OFFSET		0x120
+#define INFRA_RST1_SET_OFFSET		0x130
+#define INFRA_RST2_SET_OFFSET		0x140
+#define INFRA_RST3_SET_OFFSET		0x150
 
 static DEFINE_SPINLOCK(mt8183_clk_lock);
 
@@ -1153,10 +1156,17 @@ static const struct mtk_pll_data plls[] = {
 		0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
+static u16 infra_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+};
+
 static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.version = MTK_RST_SET_CLR,
-	.rst_bank_nr = 4,
-	.reg_ofs = INFRA_RST0_SET_OFFSET,
+	.rst_bank_ofs = infra_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
 };
 
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 47bc6b1842fd..11b2f74f121d 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -24,8 +24,8 @@ static int mtk_reset_update(struct reset_controller_dev *rcdev,
 	unsigned int val = deassert ? 0 : ~0;
 
 	return regmap_update_bits(data->regmap,
-				  data->desc->reg_ofs + ((id / 32) << 2),
-				  BIT(id % 32), val);
+				  data->desc->rst_bank_ofs[id / RST_NR_PER_BANK],
+				  BIT(id % RST_NR_PER_BANK), val);
 }
 
 static int mtk_reset_assert(struct reset_controller_dev *rcdev,
@@ -58,8 +58,9 @@ static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
 	unsigned int deassert_ofs = deassert ? 0x4 : 0;
 
 	return regmap_write(data->regmap,
-			    data->desc->reg_ofs + ((id / 32) << 4) + deassert_ofs,
-			    BIT(id % 32));
+			    data->desc->rst_bank_ofs[id / RST_NR_PER_BANK] +
+			    deassert_ofs,
+			    BIT(id % RST_NR_PER_BANK));
 }
 
 static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
@@ -135,7 +136,7 @@ void mtk_register_reset_controller(struct device_node *np,
 	data->desc = desc;
 	data->regmap = regmap;
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = desc->rst_bank_nr * 32;
+	data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
 	data->rcdev.ops = rcops;
 	data->rcdev.of_node = np;
 
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 91358e8cb851..482df8012c5c 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -9,6 +9,8 @@
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
+#define RST_NR_PER_BANK 32
+
 /**
  * enum mtk_reset_version - Version of MediaTek clock reset controller.
  * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
@@ -24,12 +26,12 @@ enum mtk_reset_version {
 /**
  * struct mtk_clk_rst_desc - Description of MediaTek clock reset.
  * @version: Reset version which is defined in enum mtk_reset_version.
- * @reg_ofs: Base offset of the reset register.
+ * @rst_bank_ofs: Pointer to an array containing base offsets of the reset register.
  * @rst_bank_nr: Quantity of reset bank.
  */
 struct mtk_clk_rst_desc {
 	u8 version;
-	u16 reg_ofs;
+	u16 *rst_bank_ofs;
 	u32 rst_bank_nr;
 };
 
-- 
2.18.0

