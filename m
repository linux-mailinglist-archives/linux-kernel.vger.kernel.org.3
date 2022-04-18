Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD76505A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbiDRObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbiDRO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:27:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09B532C7;
        Mon, 18 Apr 2022 06:22:33 -0700 (PDT)
X-UUID: 4e4fae0afe094a9799ab825ebc8af60e-20220418
X-UUID: 4e4fae0afe094a9799ab825ebc8af60e-20220418
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 240949655; Mon, 18 Apr 2022 21:22:24 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Apr 2022 21:22:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 21:22:22 +0800
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
Subject: [PATCH 2/7] clk: mediatek: reset: Rename reset function
Date:   Mon, 18 Apr 2022 21:21:49 +0800
Message-ID: <20220418132154.7401-3-rex-bc.chen@mediatek.com>
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

There are two version for clock reset register control of MediaTek SoCs.
Since MT8183, the version 2 is adopted.

To make the driver more readable,
- Rename them to v2 for MT8183 and v1 for previous SoCs.
- Adjust the fuinction order in reset.c.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701-eth.c |  2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c |  2 +-
 drivers/clk/mediatek/clk-mt2701.c     |  4 +-
 drivers/clk/mediatek/clk-mt2712.c     |  4 +-
 drivers/clk/mediatek/clk-mt7622-eth.c |  2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c |  4 +-
 drivers/clk/mediatek/clk-mt7622.c     |  4 +-
 drivers/clk/mediatek/clk-mt7629-eth.c |  2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c |  4 +-
 drivers/clk/mediatek/clk-mt8135.c     |  4 +-
 drivers/clk/mediatek/clk-mt8173.c     |  4 +-
 drivers/clk/mediatek/clk-mt8183.c     |  2 +-
 drivers/clk/mediatek/clk-mtk.h        |  8 +--
 drivers/clk/mediatek/reset.c          | 76 ++++++++++++++-------------
 15 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 100ff6ca609e..f3e56a988177 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -58,7 +58,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1328c112a38f..5a41d4607e77 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -52,7 +52,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0xc);
+	mtk_register_reset_controller_v1(node, 1, 0xc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 61444881c539..426a54cb077b 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,7 +57,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 1eb3e4563c3f..0e103d6735bb 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -785,7 +785,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller_v1(node, 2, 0x30);
 
 	return 0;
 }
@@ -908,7 +908,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 2, 0x0);
+	mtk_register_reset_controller_v1(node, 2, 0x0);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index ff72b9ab945b..e80fc89a5a07 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1361,7 +1361,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller_v1(node, 2, 0x30);
 
 	return r;
 }
@@ -1383,7 +1383,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0);
+	mtk_register_reset_controller_v1(node, 2, 0);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index c9947dc7ba5a..13f346643e26 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -82,7 +82,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 628be0c9f888..32855bb489a2 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -93,7 +93,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
@@ -115,7 +115,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0e1fb30a1e98..953e81049957 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -663,7 +663,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, 1, 0x30);
+	mtk_register_reset_controller_v1(node, 1, 0x30);
 
 	return 0;
 }
@@ -714,7 +714,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_register_reset_controller(node, 2, 0x0);
+	mtk_register_reset_controller_v1(node, 2, 0x0);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 88279d0ea1a7..e47b66c67079 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -92,7 +92,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 5c5b37207afb..72f261f12e92 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -88,7 +88,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
@@ -110,7 +110,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, 1, 0x34);
+	mtk_register_reset_controller_v1(node, 1, 0x34);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 09ad272d51f1..d649e817b320 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -559,7 +559,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller_v1(node, 2, 0x30);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
@@ -587,7 +587,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0);
+	mtk_register_reset_controller_v1(node, 2, 0);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8135-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 46b7655feeaa..11becf2f7a9f 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -882,7 +882,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0x30);
+	mtk_register_reset_controller_v1(node, 2, 0x30);
 }
 CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
@@ -910,7 +910,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, 2, 0);
+	mtk_register_reset_controller_v1(node, 2, 0);
 }
 CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 68496554dd3d..ac76328c423d 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1239,7 +1239,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller_set_clr(node, 4, INFRA_RST0_SET_OFFSET);
+	mtk_register_reset_controller_v2(node, 4, INFRA_RST0_SET_OFFSET);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index bf6565aa7319..601db24a342b 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -190,11 +190,11 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data);
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
-void mtk_register_reset_controller(struct device_node *np,
-			unsigned int num_regs, int regofs);
+void mtk_register_reset_controller_v1(struct device_node *np,
+				      unsigned int num_regs, int regofs);
 
-void mtk_register_reset_controller_set_clr(struct device_node *np,
-	unsigned int num_regs, int regofs);
+void mtk_register_reset_controller_v2(struct device_node *np,
+				      unsigned int num_regs, int regofs);
 
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 834d26e9bdfd..b1012b0c44d0 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -19,75 +19,79 @@ struct mtk_reset {
 	struct reset_controller_dev rcdev;
 };
 
-static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
-	unsigned long id)
+static int mtk_reset_assert_v1(struct reset_controller_dev *rcdev,
+			       unsigned long id)
 {
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
-	unsigned int reg = data->regofs + ((id / 32) << 4);
 
-	return regmap_write(data->regmap, reg, BIT(id % 32));
+	return regmap_update_bits(data->regmap,
+				  data->regofs + ((id / 32) << 2),
+				  BIT(id % 32), ~0);
 }
 
-static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
-	unsigned long id)
+static int mtk_reset_deassert_v1(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
-	unsigned int reg = data->regofs + ((id / 32) << 4) + 0x4;
 
-	return regmap_write(data->regmap, reg, BIT(id % 32));
+	return regmap_update_bits(data->regmap,
+				  data->regofs + ((id / 32) << 2),
+				  BIT(id % 32), 0);
 }
 
-static int mtk_reset_assert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int mtk_reset_assert_v2(struct reset_controller_dev *rcdev,
+			       unsigned long id)
 {
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
 
-	return regmap_update_bits(data->regmap, data->regofs + ((id / 32) << 2),
-			BIT(id % 32), ~0);
+	return regmap_write(data->regmap,
+			    data->regofs + ((id / 32) << 4),
+			    BIT(id % 32));
 }
 
-static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
+static int mtk_reset_deassert_v2(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
 
-	return regmap_update_bits(data->regmap, data->regofs + ((id / 32) << 2),
-			BIT(id % 32), 0);
+	return regmap_write(data->regmap,
+			    data->regofs + ((id / 32) << 4) + 0x4,
+			    BIT(id % 32));
 }
 
-static int mtk_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int mtk_reset_v1(struct reset_controller_dev *rcdev,
+			unsigned long id)
 {
 	int ret;
 
-	ret = mtk_reset_assert(rcdev, id);
+	ret = mtk_reset_assert_v1(rcdev, id);
 	if (ret)
 		return ret;
 
-	return mtk_reset_deassert(rcdev, id);
+	return mtk_reset_deassert_v1(rcdev, id);
 }
 
-static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
-	unsigned long id)
+static int mtk_reset_v2(struct reset_controller_dev *rcdev,
+			unsigned long id)
 {
 	int ret;
 
-	ret = mtk_reset_assert_set_clr(rcdev, id);
+	ret = mtk_reset_assert_v2(rcdev, id);
 	if (ret)
 		return ret;
-	return mtk_reset_deassert_set_clr(rcdev, id);
+	return mtk_reset_deassert_v2(rcdev, id);
 }
 
-static const struct reset_control_ops mtk_reset_ops = {
-	.assert = mtk_reset_assert,
-	.deassert = mtk_reset_deassert,
-	.reset = mtk_reset,
+static const struct reset_control_ops mtk_reset_ops_v1 = {
+	.assert = mtk_reset_assert_v1,
+	.deassert = mtk_reset_deassert_v1,
+	.reset = mtk_reset_v1,
 };
 
-static const struct reset_control_ops mtk_reset_ops_set_clr = {
-	.assert = mtk_reset_assert_set_clr,
-	.deassert = mtk_reset_deassert_set_clr,
-	.reset = mtk_reset_set_clr,
+static const struct reset_control_ops mtk_reset_ops_v2 = {
+	.assert = mtk_reset_assert_v2,
+	.deassert = mtk_reset_deassert_v2,
+	.reset = mtk_reset_v2,
 };
 
 static void mtk_register_reset_controller_common(struct device_node *np,
@@ -123,18 +127,18 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 	}
 }
 
-void mtk_register_reset_controller(struct device_node *np,
+void mtk_register_reset_controller_v1(struct device_node *np,
 	unsigned int num_regs, int regofs)
 {
 	mtk_register_reset_controller_common(np, num_regs, regofs,
-		&mtk_reset_ops);
+					     &mtk_reset_ops_v1);
 }
 
-void mtk_register_reset_controller_set_clr(struct device_node *np,
+void mtk_register_reset_controller_v2(struct device_node *np,
 	unsigned int num_regs, int regofs)
 {
 	mtk_register_reset_controller_common(np, num_regs, regofs,
-		&mtk_reset_ops_set_clr);
+					     &mtk_reset_ops_v2);
 }
 
 MODULE_LICENSE("GPL");
-- 
2.18.0

