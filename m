Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA2F510F64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357497AbiD0DQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357433AbiD0DPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:15:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83613CD0;
        Tue, 26 Apr 2022 20:12:30 -0700 (PDT)
X-UUID: 01c80bacd0b344d0afc9a7116e9745ff-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:818a6438-f540-417f-8b5f-a46bd4918206,OB:30,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:818a6438-f540-417f-8b5f-a46bd4918206,OB:30,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:bbf59bc6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:1263bd427694,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 01c80bacd0b344d0afc9a7116e9745ff-20220427
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 190287399; Wed, 27 Apr 2022 11:12:20 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 11:12:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 11:12:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 11:12:13 +0800
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
Subject: [PATCH V4 02/15] clk: mediatek: reset: Fix written reset bit offset
Date:   Wed, 27 Apr 2022 11:09:37 +0800
Message-ID: <20220427030950.23395-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
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

Original assert/deassert bit is BIT(0), but it's more resonable to modify
them to BIT(id % 32) which is based on id.

This patch will not influence any previous driver because the reset is
only used for thermal. The id (MT8183_INFRACFG_AO_THERM_SW_RST) is 0.

Fixes: 64ebb57a3df6 ("clk: reset: Modify reset-controller driver")
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 9f3cb22aea1b..5191becb45dd 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -18,7 +18,7 @@ static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
 	unsigned int reg = data->regofs + ((id / 32) << 4);
 
-	return regmap_write(data->regmap, reg, 1);
+	return regmap_write(data->regmap, reg, BIT(id % 32));
 }
 
 static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
@@ -27,7 +27,7 @@ static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
 	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
 	unsigned int reg = data->regofs + ((id / 32) << 4) + 0x4;
 
-	return regmap_write(data->regmap, reg, 1);
+	return regmap_write(data->regmap, reg, BIT(id % 32));
 }
 
 static int mtk_reset_assert(struct reset_controller_dev *rcdev,
-- 
2.18.0

