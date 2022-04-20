Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A70C5088D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378803AbiDTNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378776AbiDTNIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3A6565;
        Wed, 20 Apr 2022 06:05:38 -0700 (PDT)
X-UUID: 2bc8eefb15294387ab8c5cbb2af48cc0-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fbf3316f-3d82-48f2-8099-cb368e871edf,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:30e65cf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 2bc8eefb15294387ab8c5cbb2af48cc0-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1538950905; Wed, 20 Apr 2022 21:05:31 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 21:05:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Apr
 2022 21:05:30 +0800
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
Subject: [PATCH V2 07/12] clk: mediatek: reset: Add return for clock reset register function
Date:   Wed, 20 Apr 2022 21:05:22 +0800
Message-ID: <20220420130527.23200-8-rex-bc.chen@mediatek.com>
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

To make error handling, we add return for mtk_clk_register_rst_ctrl().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/reset.c | 14 ++++++++------
 drivers/clk/mediatek/reset.h |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index d67c13958458..b164b1da7dd3 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -64,8 +64,8 @@ static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
 	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
 };
 
-void mtk_clk_register_rst_ctrl(struct device_node *np,
-			       const struct mtk_clk_rst_desc *desc)
+int mtk_clk_register_rst_ctrl(struct device_node *np,
+			      const struct mtk_clk_rst_desc *desc)
 {
 	struct regmap *regmap;
 	struct mtk_clk_rst_data *data;
@@ -73,23 +73,23 @@ void mtk_clk_register_rst_ctrl(struct device_node *np,
 
 	if (!desc) {
 		pr_err("mtk clock reset desc is NULL\n");
-		return;
+		return -EINVAL;
 	}
 
 	if (desc->version >= MTK_RST_MAX) {
 		pr_err("Error version number: %d\n", desc->version);
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
@@ -103,6 +103,8 @@ void mtk_clk_register_rst_ctrl(struct device_node *np,
 		pr_err("could not register reset controller: %d\n", ret);
 		kfree(data);
 	}
+
+	return ret;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 3a93f61e106e..d59f4b89384d 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -27,7 +27,7 @@ struct mtk_clk_rst_data {
 	const struct mtk_clk_rst_desc *desc;
 };
 
-void mtk_clk_register_rst_ctrl(struct device_node *np,
-			       const struct mtk_clk_rst_desc *desc);
+int mtk_clk_register_rst_ctrl(struct device_node *np,
+			      const struct mtk_clk_rst_desc *desc);
 
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

