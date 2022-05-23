Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB1530E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiEWJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiEWJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:34:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FFD49922;
        Mon, 23 May 2022 02:33:55 -0700 (PDT)
X-UUID: d22992d7184847b0b0e4bfe5e376d7ab-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:70ac881b-d2d7-4842-b9c6-c5cf3f7afb1c,OB:10,L
        OB:30,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:70ac881b-d2d7-4842-b9c6-c5cf3f7afb1c,OB:10,LOB
        :30,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:c5fd37e3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:15aacf212e67,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: d22992d7184847b0b0e4bfe5e376d7ab-20220523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2069350668; Mon, 23 May 2022 17:33:50 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 17:33:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 17:33:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 17:33:49 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <chun-jie.chen@mediatek.com>,
        <wenst@chromium.org>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND v8 10/19] clk: mediatek: reset: Add new register reset function with device
Date:   Mon, 23 May 2022 17:33:37 +0800
Message-ID: <20220523093346.28493-11-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using device to register reset controller is a better implementation in
current drivers. Howerver, some clock drviers of MediaTek only provide
device_node.

Therefore, we still remain the register reset function with device_node
and add a new function with device to register reset controller.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
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
 drivers/clk/mediatek/clk-mt8183.c     |  2 +-
 drivers/clk/mediatek/reset.c          | 60 +++++++++++++++++++++++++++
 drivers/clk/mediatek/reset.h          | 10 +++++
 13 files changed, 86 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index b4e7f38860d0..edf1e2ed2b59 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -66,7 +66,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1431fa76a0f8..1458109d99d9 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -60,7 +60,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 60bda56a102c..434cbbe8c037 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -65,7 +65,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 6c7a80fb4349..9b442af37e67 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -805,7 +805,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -928,7 +928,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index fd310c375fdf..56980dd6c2ea 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1379,7 +1379,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return r;
 }
@@ -1401,7 +1401,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 90d55f882215..43de0477d5d9 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -90,7 +90,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 489b64725b22..67e96231dd25 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -101,7 +101,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
@@ -123,7 +123,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0cba74d38499..3b55f8641fae 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -681,7 +681,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -732,7 +732,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 11b346c9d916..282dd6559465 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -100,7 +100,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index c0583043710f..0c8b9e139789 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -96,7 +96,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
@@ -118,7 +118,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5bc738f4d0e7..b1d810f85b71 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1256,7 +1256,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index b9718f0f9d16..179505549a7c 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -169,4 +169,64 @@ int mtk_register_reset_controller(struct device_node *np,
 	return 0;
 }
 
+int mtk_register_reset_controller_with_dev(struct device *dev,
+					   const struct mtk_clk_rst_desc *desc)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *regmap;
+	const struct reset_control_ops *rcops = NULL;
+	struct mtk_clk_rst_data *data;
+	int ret;
+
+	if (!desc) {
+		dev_err(dev, "mtk clock reset desc is NULL\n");
+		return -EINVAL;
+	}
+
+	switch (desc->version) {
+	case MTK_RST_SIMPLE:
+		rcops = &mtk_reset_ops;
+		break;
+	case MTK_RST_SET_CLR:
+		rcops = &mtk_reset_ops_set_clr;
+		break;
+	default:
+		dev_err(dev, "Unknown reset version %d\n", desc->version);
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
+	data->rcdev.ops = rcops;
+	data->rcdev.of_node = np;
+	data->rcdev.dev = dev;
+
+	if (data->desc->rst_idx_map_nr > 0) {
+		data->rcdev.of_reset_n_cells = 1;
+		data->rcdev.nr_resets = desc->rst_idx_map_nr;
+		data->rcdev.of_xlate = reset_xlate;
+	} else {
+		data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
+	}
+
+	ret = devm_reset_controller_register(dev, &data->rcdev);
+	if (ret) {
+		dev_err(dev, "could not register reset controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 260f25f27656..f7e1f31e3946 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -62,4 +62,14 @@ struct mtk_clk_rst_data {
 int mtk_register_reset_controller(struct device_node *np,
 				  const struct mtk_clk_rst_desc *desc);
 
+/**
+ * mtk_register_reset_controller - Register mediatek clock reset controller with device
+ * @np: Pointer to device.
+ * @desc: Constant pointer to description of clock reset.
+ *
+ * Return: 0 on success and errorno otherwise.
+ */
+int mtk_register_reset_controller_with_dev(struct device *dev,
+					   const struct mtk_clk_rst_desc *desc);
+
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

