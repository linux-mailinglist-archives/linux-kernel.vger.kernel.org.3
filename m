Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56B52D34A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiESM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiESMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:55:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F51B0A48;
        Thu, 19 May 2022 05:55:38 -0700 (PDT)
X-UUID: 984dd0ed30104dd59b193232a42d520f-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a08f618c-0692-4970-9dfa-1f77f9e597d4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:3990df79-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 984dd0ed30104dd59b193232a42d520f-20220519
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1730935697; Thu, 19 May 2022 20:55:31 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 19 May 2022 20:55:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 May 2022 20:55:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 20:55:29 +0800
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
Subject: [PATCH v7 09/19] clk: mediatek: reset: Change return type for clock reset register function
Date:   Thu, 19 May 2022 20:55:17 +0800
Message-ID: <20220519125527.18544-10-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To deal with error handling, we change the function return type from
void to int for mtk_clk_register_rst_ctrl().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/reset.c | 15 +++++++++------
 drivers/clk/mediatek/reset.h |  6 ++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 89e617ea6393..b9718f0f9d16 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -110,8 +110,8 @@ static int reset_xlate(struct reset_controller_dev *rcdev,
 	return data->desc->rst_idx_map[reset_spec->args[0]];
 }
 
-void mtk_register_reset_controller(struct device_node *np,
-				   const struct mtk_clk_rst_desc *desc)
+int mtk_register_reset_controller(struct device_node *np,
+				  const struct mtk_clk_rst_desc *desc)
 {
 	struct regmap *regmap;
 	const struct reset_control_ops *rcops = NULL;
@@ -120,7 +120,7 @@ void mtk_register_reset_controller(struct device_node *np,
 
 	if (!desc) {
 		pr_err("mtk clock reset desc is NULL\n");
-		return;
+		return -EINVAL;
 	}
 
 	switch (desc->version) {
@@ -132,18 +132,18 @@ void mtk_register_reset_controller(struct device_node *np,
 		break;
 	default:
 		pr_err("Unknown reset version %d\n", desc->version);
-		return;
+		return -EINVAL;
 	}
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
-		return;
+		return -EINVAL;
 	}
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return;
+		return -ENOMEM;
 
 	data->desc = desc;
 	data->regmap = regmap;
@@ -163,7 +163,10 @@ void mtk_register_reset_controller(struct device_node *np,
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
 		kfree(data);
+		return ret;
 	}
+
+	return 0;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 47635d964c69..cc67934c69e2 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -56,8 +56,10 @@ struct mtk_clk_rst_data {
  * mtk_register_reset_controller - Register MediaTek clock reset controller
  * @np: Pointer to device node.
  * @desc: Constant pointer to description of clock reset.
+ *
+ * Return: 0 on success and errorno otherwise.
  */
-void mtk_register_reset_controller(struct device_node *np,
-				   const struct mtk_clk_rst_desc *desc);
+int mtk_register_reset_controller(struct device_node *np,
+				  const struct mtk_clk_rst_desc *desc);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

