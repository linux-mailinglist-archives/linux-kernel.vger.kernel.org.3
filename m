Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04911513328
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiD1MAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbiD1L7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BBF88B21;
        Thu, 28 Apr 2022 04:56:33 -0700 (PDT)
X-UUID: 64f7e014552d4aa4bc6fa6260df7816f-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a5682003-f63a-4749-9784-045bfeeb351f,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:8665d4c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 64f7e014552d4aa4bc6fa6260df7816f-20220428
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 100305742; Thu, 28 Apr 2022 19:56:24 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 19:56:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 19:56:23 +0800
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
Subject: [PATCH V5 09/16] clk: mediatek: reset: Add new register reset function with device
Date:   Thu, 28 Apr 2022 19:56:12 +0800
Message-ID: <20220428115620.13512-10-rex-bc.chen@mediatek.com>
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

Using device to register reset controller is a better implementation in
current drivers. Howerver, some clock drviers of MediaTek only provide
device_node.

Therefore, we still remain the register reset function with device_node
and add a new function with device to register reset controller.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 drivers/clk/mediatek/reset.c          | 53 +++++++++++++++++++++++++++
 drivers/clk/mediatek/reset.h          | 10 +++++
 13 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 0ae4bce3bb37..38fd15c8f6f6 100644
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
index 8d2053517ddc..d5ff16e02d0e 100644
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
index e40865a6f45e..b642109e7fa8 100644
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
index 572d62f76e96..1c3afa1fdfde 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -803,7 +803,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[0]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
 
 	return 0;
 }
@@ -926,7 +926,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 9eb8866ec77a..a01e5d53e68d 100644
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
index b58fe61a8443..ecaf0717947d 100644
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
index 1ee79d4837a4..98aac2b5b504 100644
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
index 8ebd66dcb946..110ab6ced22c 100644
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
 
 	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
 
-	mtk_register_reset_controller(node, &clk_rst_desc[1]);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 56ff7c1f6ec1..69b9682f9ceb 100644
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
index fc12110b04fc..9b80b771a62b 100644
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
index de4ba5e055ca..c7d5ffacbd1d 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1255,7 +1255,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 		return r;
 	}
 
-	mtk_register_reset_controller(node, &clk_rst_desc);
+	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
 
 	return r;
 }
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index a1d281d2a2d5..de3e2ccef4e8 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -150,4 +150,57 @@ int mtk_register_reset_controller(struct device_node *np,
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
+	data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
+	data->rcdev.ops = rcops;
+	data->rcdev.of_node = np;
+	data->rcdev.dev = dev;
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
index bbd269b0a797..ac1ca902c200 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -57,4 +57,14 @@ struct mtk_clk_rst_data {
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

