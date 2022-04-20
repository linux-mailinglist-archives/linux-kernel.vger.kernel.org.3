Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034015088DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378841AbiDTNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378835AbiDTNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32823427DE;
        Wed, 20 Apr 2022 06:05:48 -0700 (PDT)
X-UUID: 896ad5c2ae5c41998de3e0a01ef00ac7-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4ee30c01-9368-442c-9edb-32244c95bbcc,OB:-327
        68,LOB:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Rele
        ase_Ham,ACTION:release,TS:-20
X-CID-INFO: VERSION:1.1.4,REQID:4ee30c01-9368-442c-9edb-32244c95bbcc,OB:-32768
        ,LOB:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Releas
        e_Ham,ACTION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:70e286ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:nil,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 896ad5c2ae5c41998de3e0a01ef00ac7-20220420
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 838861984; Wed, 20 Apr 2022 21:05:30 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 20 Apr 2022 21:05:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Apr
 2022 21:05:29 +0800
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
Subject: [PATCH V2 04/12] clk: mediatek: reset: Merge and revise reset register function
Date:   Wed, 20 Apr 2022 21:05:19 +0800
Message-ID: <20220420130527.23200-5-rex-bc.chen@mediatek.com>
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

Merge the reset register function of simple and set_clr into one function.
- Input the version number to determine which version we will use.
- Rename reset register function to "mtk_clk_register_rst_ctrl"

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c |  2 +-
 drivers/clk/mediatek/clk-mt2701.c     |  4 +--
 drivers/clk/mediatek/clk-mt2712.c     |  4 +--
 drivers/clk/mediatek/clk-mt7622-eth.c |  2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c |  4 +--
 drivers/clk/mediatek/clk-mt7622.c     |  4 +--
 drivers/clk/mediatek/clk-mt7629-eth.c |  2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c |  4 +--
 drivers/clk/mediatek/clk-mt8135.c     |  4 +--
 drivers/clk/mediatek/clk-mt8173.c     |  4 +--
 drivers/clk/mediatek/clk-mt8183.c     |  3 ++-
 drivers/clk/mediatek/clk-mtk.h        | 13 ++++++----
 drivers/clk/mediatek/reset.c          | 35 ++++++++++++---------------
 15 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 1a6318fbcb32..85a993279506 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -58,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 0cd6b57657b3..42b9ec1bc926 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -52,7 +52,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0xc);
+	mtk_clk_register_rst_ctrl(node, 1, 0xc, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 883a23bb024d..f20e9b1033e7 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,7 +57,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 3f6508ff8e7f..e6ff09b2f915 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -785,7 +785,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_simple(node, 2, 0x30);
+	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
 
 	return 0;
 }
@@ -908,7 +908,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_simple(node, 2, 0x0);
+	mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_SIMPLE);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 9b4470ac7be7..d337ca91de60 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1361,7 +1361,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_simple(node, 2, 0x30);
+	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
 
 	return r;
 }
@@ -1383,7 +1383,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_simple(node, 2, 0);
+	mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 647bf752a8af..ac3bf5aba73b 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -82,7 +82,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 1287db1e3cc2..5041126852b6 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -93,7 +93,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
@@ -115,7 +115,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 2b744afd9233..d453a2db0da7 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -663,7 +663,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller_simple(node, 1, 0x30);
+	mtk_clk_register_rst_ctrl(node, 1, 0x30, MTK_RST_SIMPLE);
 
 	return 0;
 }
@@ -714,7 +714,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_register_reset_controller_simple(node, 2, 0x0);
+	mtk_clk_register_rst_ctrl(node, 2, 0x0, MTK_RST_SIMPLE);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 0fb5780ae048..6baf515591f3 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -92,7 +92,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 6f7d013814ac..2f27dac66e38 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -88,7 +88,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
@@ -110,7 +110,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller_simple(node, 1, 0x34);
+	mtk_clk_register_rst_ctrl(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 476c6fb5fc5d..fa860e3b2257 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -559,7 +559,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_simple(node, 2, 0x30);
+	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -587,7 +587,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_simple(node, 2, 0);
+	mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 92beb45de8a0..13ec0e4bdf5c 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -882,7 +882,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_simple(node, 2, 0x30);
+	mtk_clk_register_rst_ctrl(node, 2, 0x30, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -910,7 +910,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller_simple(node, 2, 0);
+	mtk_clk_register_rst_ctrl(node, 2, 0, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 68496554dd3d..82a0a4980180 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1239,7 +1239,8 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_set_clr(node, 4, INFRA_RST0_SET_OFFSET);
+	mtk_clk_register_rst_ctrl(node, 4,
+				  INFRA_RST0_SET_OFFSET, MTK_RST_SET_CLR);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f767c9585d8c..399f1b2dc7d0 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -178,6 +178,12 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
+enum mtk_reset_version {
+	MTK_RST_SIMPLE = 0,
+	MTK_RST_SET_CLR,
+	MTK_RST_MAX,
+};
+
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
 			      struct clk_onecell_data *clk_data);
@@ -190,11 +196,8 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data);
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
-void mtk_register_reset_controller_simple(struct device_node *np,
-					  unsigned int num_regs, int regofs);
-
-void mtk_register_reset_controller_set_clr(struct device_node *np,
-					   unsigned int num_regs, int regofs);
+void mtk_clk_register_rst_ctrl(struct device_node *np,
+			       u32 reg_num, u16 reg_ofs, u8 version);
 
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 6574b19daf0f..8e42deee80a3 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -65,14 +65,23 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 	.reset = mtk_reset_set_clr,
 };
 
-static void mtk_register_reset_controller_common(struct device_node *np,
-			unsigned int num_regs, int regofs,
-			const struct reset_control_ops *reset_ops)
+static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
+	[MTK_RST_SIMPLE] = &reset_simple_ops,
+	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
+};
+
+void mtk_clk_register_rst_ctrl(struct device_node *np,
+			       u32 reg_num, u16 reg_ofs, u8 version)
 {
 	struct mtk_reset *data;
 	int ret;
 	struct regmap *regmap;
 
+	if (version >= MTK_RST_MAX) {
+		pr_err("Error version number: %d\n", version);
+		return;
+	}
+
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
@@ -84,10 +93,10 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 		return;
 
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
@@ -98,18 +107,4 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 	}
 }
 
-void mtk_register_reset_controller_simple(struct device_node *np,
-	unsigned int num_regs, int regofs)
-{
-	mtk_register_reset_controller_common(np, num_regs, regofs,
-					     &reset_simple_ops);
-}
-
-void mtk_register_reset_controller_set_clr(struct device_node *np,
-	unsigned int num_regs, int regofs)
-{
-	mtk_register_reset_controller_common(np, num_regs, regofs,
-					     &mtk_reset_ops_set_clr);
-}
-
 MODULE_LICENSE("GPL");
-- 
2.18.0

