Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B952D320
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiESMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiESMzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:55:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3EA7E28;
        Thu, 19 May 2022 05:55:33 -0700 (PDT)
X-UUID: 8202cfeb095e4ff58a4ade731d116dae-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4335a90b-ea10-470c-9c87-8dcb580a43f0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:ee8fdf79-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 8202cfeb095e4ff58a4ade731d116dae-20220519
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1539566960; Thu, 19 May 2022 20:55:30 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 19 May 2022 20:55:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 May 2022 20:55:29 +0800
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
Subject: [PATCH v7 04/19] clk: mediatek: reset: Extract common drivers to update function
Date:   Thu, 19 May 2022 20:55:12 +0800
Message-ID: <20220519125527.18544-5-rex-bc.chen@mediatek.com>
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

To make drivers more clear and readable, we extract common code
within assert and deassert to mtk_reset_update_set_clr() and
mtk_reset_update().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/reset.c | 38 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 5cbbcc22a4fc..22fa9f09752c 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -12,24 +12,27 @@
 
 #include "reset.h"
 
-static int mtk_reset_assert(struct reset_controller_dev *rcdev,
-			    unsigned long id)
+static int mtk_reset_update(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool deassert)
 {
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	unsigned int val = deassert ? 0 : ~0;
 
 	return regmap_update_bits(data->regmap,
 				  data->regofs + ((id / 32) << 2),
-				  BIT(id % 32), ~0);
+				  BIT(id % 32), val);
+}
+
+static int mtk_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	return mtk_reset_update(rcdev, id, false);
 }
 
 static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
-
-	return regmap_update_bits(data->regmap,
-				  data->regofs + ((id / 32) << 2),
-				  BIT(id % 32), 0);
+	return mtk_reset_update(rcdev, id, true);
 }
 
 static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
@@ -43,24 +46,27 @@ static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	return mtk_reset_deassert(rcdev, id);
 }
 
-static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
-				    unsigned long id)
+static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
+				    unsigned long id, bool deassert)
 {
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
+	unsigned int deassert_ofs = deassert ? 0x4 : 0;
 
 	return regmap_write(data->regmap,
-			    data->regofs + ((id / 32) << 4),
+			    data->regofs + ((id / 32) << 4) + deassert_ofs,
 			    BIT(id % 32));
 }
 
+static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	return mtk_reset_update_set_clr(rcdev, id, false);
+}
+
 static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
 				      unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
-
-	return regmap_write(data->regmap,
-			    data->regofs + ((id / 32) << 4) + 0x4,
-			    BIT(id % 32));
+	return mtk_reset_update_set_clr(rcdev, id, true);
 }
 
 static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
-- 
2.18.0

