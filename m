Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04B2513327
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbiD1MAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiD1L7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:59:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA34988B1C;
        Thu, 28 Apr 2022 04:56:31 -0700 (PDT)
X-UUID: 93c02dac41eb48389fd4d6f119e2e127-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:aa7bb79a-c7ce-4799-8a61-f7be834e1f52,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:8165d4c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 93c02dac41eb48389fd4d6f119e2e127-20220428
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 815750933; Thu, 28 Apr 2022 19:56:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 19:56:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 19:56:23 +0800
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
Subject: [PATCH V5 08/16] clk: mediatek: reset: Change return type for clock reset register function
Date:   Thu, 28 Apr 2022 19:56:11 +0800
Message-ID: <20220428115620.13512-9-rex-bc.chen@mediatek.com>
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

To deal with error handling, we change the function return type from
void to int for mtk_clk_register_rst_ctrl().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/reset.c | 15 +++++++++------
 drivers/clk/mediatek/reset.h |  6 ++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 11b2f74f121d..a1d281d2a2d5 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -98,8 +98,8 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 	.reset = mtk_reset_set_clr,
 };
 
-void mtk_register_reset_controller(struct device_node *np,
-				   const struct mtk_clk_rst_desc *desc)
+int mtk_register_reset_controller(struct device_node *np,
+				  const struct mtk_clk_rst_desc *desc)
 {
 	struct regmap *regmap;
 	const struct reset_control_ops *rcops = NULL;
@@ -108,7 +108,7 @@ void mtk_register_reset_controller(struct device_node *np,
 
 	if (!desc) {
 		pr_err("mtk clock reset desc is NULL\n");
-		return;
+		return -EINVAL;
 	}
 
 	switch (desc->version) {
@@ -120,18 +120,18 @@ void mtk_register_reset_controller(struct device_node *np,
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
@@ -144,7 +144,10 @@ void mtk_register_reset_controller(struct device_node *np,
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
index 482df8012c5c..bbd269b0a797 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -51,8 +51,10 @@ struct mtk_clk_rst_data {
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

