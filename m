Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E905088E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378825AbiDTNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378833AbiDTNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E823427DF;
        Wed, 20 Apr 2022 06:05:48 -0700 (PDT)
X-UUID: ed446005ab06441e8a7c98830d14c3bd-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e9a0b140-6418-4b94-8520-bd93f794bc32,OB:-327
        68,LOB:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Rele
        ase_Ham,ACTION:release,TS:-12
X-CID-INFO: VERSION:1.1.4,REQID:e9a0b140-6418-4b94-8520-bd93f794bc32,OB:-32768
        ,LOB:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Releas
        e_Ham,ACTION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:89e286ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:nil,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ed446005ab06441e8a7c98830d14c3bd-20220420
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 462038439; Wed, 20 Apr 2022 21:05:31 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 21:05:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Apr
 2022 21:05:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 21:05:30 +0800
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
Subject: [PATCH V2 08/12] clk: mediatek: reset: Add new register reset function with device
Date:   Wed, 20 Apr 2022 21:05:23 +0800
Message-ID: <20220420130527.23200-9-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
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

Some clock drvier only support device_node, so we still remain
register reset function with device_node and add a function to
register reset controller with device.

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
 drivers/clk/mediatek/clk-mt8183.c     |  2 +-
 drivers/clk/mediatek/reset.c          | 43 +++++++++++++++++++++++++++
 drivers/clk/mediatek/reset.h          |  2 ++
 13 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 1c83ac4ee1a9..d63b70eda7f5 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -64,7 +64,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 8b802083642e..6fd9db8e81d6 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -58,7 +58,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 4bf57ed948dc..2465dd95fd24 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -63,7 +63,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 24af9588358c..8cc90b1218df 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -800,7 +800,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -923,7 +923,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 4942129bdd54..20a613c3651e 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1376,7 +1376,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return r;
 }
@@ -1398,7 +1398,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index f822e8538037..c68a7990e7f3 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -88,7 +88,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index fee784fc3468..ecb6b3732b72 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -99,7 +99,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
@@ -121,7 +121,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 2bcd1d95f8f9..26bcaabb1f40 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -678,7 +678,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[0]);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -729,7 +729,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc[1]);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index a6e53ce1a309..6cf6fb4b55d1 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -98,7 +98,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index db936bdb140f..975ba8ec523f 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -94,7 +94,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
@@ -116,7 +116,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 0130f0b1ceac..e0bb6b0d2740 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1245,7 +1245,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_clk_register_rst_ctrl(node, &clk_rst_desc);
+	mtk_clk_register_rst_ctrl_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index b164b1da7dd3..1173111af3ab 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -107,4 +107,47 @@ int mtk_clk_register_rst_ctrl(struct device_node *np,
 	return ret;
 }
 
+int mtk_clk_register_rst_ctrl_with_dev(struct device *dev,
+				       const struct mtk_clk_rst_desc *desc)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *regmap;
+	struct mtk_clk_rst_data *data;
+	int ret;
+
+	if (!desc) {
+		dev_err(dev, "mtk clock reset desc is NULL\n");
+		return -EINVAL;
+	}
+
+	if (desc->version >= MTK_RST_MAX) {
+		dev_err(dev, "Error version number: %d\n", desc->version);
+		return -EINVAL;
+	}
+
+	regmap = device_node_to_regmap(np);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Cannot find regmap %pe\n", regmap);
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->desc = desc;
+	data->regmap = regmap;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = desc->reg_num * 32;
+	data->rcdev.ops = rst_op[desc->version];
+	data->rcdev.of_node = np;
+	data->rcdev.dev = dev;
+
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret)
+		dev_err(dev, "could not register reset controller: %d\n", ret);
+
+	return ret;
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index d59f4b89384d..30559bf45f7e 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -29,5 +29,7 @@ struct mtk_clk_rst_data {
 
 int mtk_clk_register_rst_ctrl(struct device_node *np,
 			      const struct mtk_clk_rst_desc *desc);
+int mtk_clk_register_rst_ctrl_with_dev(struct device *dev,
+				       const struct mtk_clk_rst_desc *desc);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

