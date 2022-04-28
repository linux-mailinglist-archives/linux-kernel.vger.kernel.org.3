Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D023513329
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbiD1MAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345819AbiD1L7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E388B15;
        Thu, 28 Apr 2022 04:56:29 -0700 (PDT)
X-UUID: bff4e55952bc40c9950d76e7786f6e06-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f241ee84-343a-4328-ba57-17f1397193b8,OB:30,L
        OB:50,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:f241ee84-343a-4328-ba57-17f1397193b8,OB:30,LOB
        :50,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:d6590c2f-6199-437e-8ab4-9920b4bc5b76,C
        OID:d7c54ea7e6a2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: bff4e55952bc40c9950d76e7786f6e06-20220428
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1417614304; Thu, 28 Apr 2022 19:56:23 +0800
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
Subject: [PATCH V5 05/16] clk: mediatek: reset: Merge and revise reset register function
Date:   Thu, 28 Apr 2022 19:56:08 +0800
Message-ID: <20220428115620.13512-6-rex-bc.chen@mediatek.com>
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

There are two versions for clock reset register control for MediaTek
SoCs. The old hardware is one bit per reset control, and does not
have separate registers for bit set, clear and read-back operations.
This matches the scheme supported by the simple reset driver.

However, because we need to use different data structure from
reset_simple_data, we can not use the operation of simple reset
driver.
For this reason, we keep the original functions and name this version
as "MTK_RST_SIMPLE".

In this patch:
- Add a version enumeration to separate different reset hardware.
- Merge the reset register function of simple and set_clr into one
  function "mtk_register_reset_controller".
- Rename input variable "num_regs" to "rst_bank_nr" to avoid
  confusion. This variable is used to define the quantity of reset bank.
- Document mtk_reset_version and mtk_register_reset_controller.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 drivers/clk/mediatek/clk-mt8183.c     |  3 +-
 drivers/clk/mediatek/reset.c          | 40 ++++++++++++---------------
 drivers/clk/mediatek/reset.h          | 24 +++++++++++++---
 15 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 100ff6ca609e..0270979ccc20 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -58,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1328c112a38f..e406f863dcf0 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -52,7 +52,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0xc);
+	mtk_register_reset_controller(node, 1, 0xc, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 61444881c539..352ca7a646c3 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,7 +57,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 1eb3e4563c3f..591479222e75 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -785,7 +785,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
 
 	return 0;
 }
@@ -908,7 +908,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 2, 0x0);
+	mtk_register_reset_controller(node, 2, 0x0, MTK_RST_SIMPLE);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index ff72b9ab945b..b311b43fbbd3 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1361,7 +1361,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
 
 	return r;
 }
@@ -1383,7 +1383,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0);
+	mtk_register_reset_controller(node, 2, 0, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index c9947dc7ba5a..bfdd09f3b72d 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -82,7 +82,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 628be0c9f888..892da27f6077 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -93,7 +93,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
@@ -115,7 +115,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0e1fb30a1e98..5bb3757f4217 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -663,7 +663,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 1, 0x30);
+	mtk_register_reset_controller(node, 1, 0x30, MTK_RST_SIMPLE);
 
 	return 0;
 }
@@ -714,7 +714,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_register_reset_controller(node, 2, 0x0);
+	mtk_register_reset_controller(node, 2, 0x0, MTK_RST_SIMPLE);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 88279d0ea1a7..1c57589b39fd 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -92,7 +92,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 5c5b37207afb..6761151ca839 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -88,7 +88,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
@@ -110,7 +110,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller(node, 1, 0x34, MTK_RST_SIMPLE);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 09ad272d51f1..d95b5dfa580c 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -559,7 +559,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -587,7 +587,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0);
+	mtk_register_reset_controller(node, 2, 0, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 46b7655feeaa..56120b148761 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -882,7 +882,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller(node, 2, 0x30, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -910,7 +910,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0);
+	mtk_register_reset_controller(node, 2, 0, MTK_RST_SIMPLE);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 68496554dd3d..9b27f1ffc600 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1239,7 +1239,8 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_set_clr(node, 4, INFRA_RST0_SET_OFFSET);
+	mtk_register_reset_controller(node, 4,
+				      INFRA_RST0_SET_OFFSET, MTK_RST_SET_CLR);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 22fa9f09752c..a54a835c1d47 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -92,14 +92,25 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 	.reset = mtk_reset_set_clr,
 };
 
-static void mtk_register_reset_controller_common(struct device_node *np,
-						 unsigned int num_regs,
-						 int regofs,
-						 const struct reset_control_ops *reset_ops)
+void mtk_register_reset_controller(struct device_node *np,
+				   u32 rst_bank_nr, u16 reg_ofs, u8 version)
 {
 	struct mtk_reset *data;
 	int ret;
 	struct regmap *regmap;
+	const struct reset_control_ops *rcops = NULL;
+
+	switch (version) {
+	case MTK_RST_SIMPLE:
+		rcops = &mtk_reset_ops;
+		break;
+	case MTK_RST_SET_CLR:
+		rcops = &mtk_reset_ops_set_clr;
+		break;
+	default:
+		pr_err("Unknown reset version %d\n", version);
+		return;
+	}
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
@@ -112,32 +123,17 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 		return;
 
 	data->regmap = regmap;
-	data->regofs = regofs;
+	data->regofs = reg_ofs;
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = num_regs * 32;
-	data->rcdev.ops = reset_ops;
+	data->rcdev.nr_resets = rst_bank_nr * 32;
+	data->rcdev.ops = rcops;
 	data->rcdev.of_node = np;
 
 	ret = reset_controller_register(&data->rcdev);
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
 		kfree(data);
-		return;
 	}
 }
 
-void mtk_register_reset_controller(struct device_node *np,
-				   unsigned int num_regs, int regofs)
-{
-	mtk_register_reset_controller_common(np, num_regs, regofs,
-					     &mtk_reset_ops);
-}
-
-void mtk_register_reset_controller_set_clr(struct device_node *np,
-					   unsigned int num_regs, int regofs)
-{
-	mtk_register_reset_controller_common(np, num_regs, regofs,
-					     &mtk_reset_ops_set_clr);
-}
-
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 764a8affe206..2a39eec9cff7 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -9,16 +9,32 @@
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
+/**
+ * enum mtk_reset_version - Version of MediaTek clock reset controller.
+ * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
+ * @MTK_RST_SET_CLR: Use separate registers for bit set and clear.
+ * @MTK_RST_MAX: Total quantity of version for MediaTek clock reset controller.
+ */
+enum mtk_reset_version {
+	MTK_RST_SIMPLE = 0,
+	MTK_RST_SET_CLR,
+	MTK_RST_MAX,
+};
+
 struct mtk_reset {
 	struct regmap *regmap;
 	int regofs;
 	struct reset_controller_dev rcdev;
 };
 
+/**
+ * mtk_register_reset_controller - Register MediaTek clock reset controller
+ * @np: Pointer to device node.
+ * @rst_bank_nr: Quantity of reset bank.
+ * @reg_ofs: Base offset of the reset register.
+ * @version: Version of MediaTek clock reset controller.
+ */
 void mtk_register_reset_controller(struct device_node *np,
-				   unsigned int num_regs, int regofs);
-
-void mtk_register_reset_controller_set_clr(struct device_node *np,
-					   unsigned int num_regs, int regofs);
+				   u32 rst_bank_nr, u16 reg_ofs, u8 version);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

