Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1A5088C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378771AbiDTNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378730AbiDTNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22C222AC;
        Wed, 20 Apr 2022 06:05:35 -0700 (PDT)
X-UUID: 8efc8a194b904a08b4a9be22b1302d1a-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:afe8f461-0493-4026-80dd-6d9311084c55,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:f2e55cf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 8efc8a194b904a08b4a9be22b1302d1a-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1575507492; Wed, 20 Apr 2022 21:05:31 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 20 Apr 2022 21:05:29 +0800
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
Subject: [PATCH V2 03/12] clk: mediatek: reset: Refine functions of set_clr
Date:   Wed, 20 Apr 2022 21:05:18 +0800
Message-ID: <20220420130527.23200-4-rex-bc.chen@mediatek.com>
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

To make driver more readable, revise functions of set_clr.
- Add to_rst_data().
- Extract common code within assert and deassert to
  mtk_reset_update_set_clr().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/reset.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 9110d0b4229f..6574b19daf0f 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -20,26 +20,36 @@ struct mtk_reset {
 	struct reset_controller_dev rcdev;
 };
 
-static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
-	unsigned long id)
+static inline struct mtk_reset *to_rst_data(struct reset_controller_dev *rcdev)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
-	unsigned int reg = data->regofs + ((id / 32) << 4);
+	return container_of(rcdev, struct mtk_reset, rcdev);
+}
 
-	return regmap_write(data->regmap, reg, BIT(id % 32));
+static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
+				    unsigned long id, bool deassert)
+{
+	struct mtk_reset *data = to_rst_data(rcdev);
+	unsigned int deassert_ofs = deassert ? 0x4 : 0;
+
+	return regmap_write(data->regmap,
+			    data->regofs + ((id / 32) << 4) + deassert_ofs,
+			    BIT(id % 32));
 }
 
-static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
-	unsigned long id)
+static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
+				    unsigned long id)
 {
-	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
-	unsigned int reg = data->regofs + ((id / 32) << 4) + 0x4;
+	return mtk_reset_update_set_clr(rcdev, id, false);
+}
 
-	return regmap_write(data->regmap, reg, BIT(id % 32));
+static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	return mtk_reset_update_set_clr(rcdev, id, true);
 }
 
 static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
-	unsigned long id)
+			     unsigned long id)
 {
 	int ret;
 
-- 
2.18.0

