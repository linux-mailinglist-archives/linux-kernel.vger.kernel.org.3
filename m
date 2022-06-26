Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48C55AEF2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiFZEkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiFZEkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:40:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDE12D07;
        Sat, 25 Jun 2022 21:40:10 -0700 (PDT)
X-UUID: 511476afc9044665b625e8235c78e1f3-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:2fe1bedc-0ebf-408a-8135-2cfa755d5720,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:b14ad71,CLOUDID:308b91d8-850a-491d-a127-60d9309b2b3e,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:1,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 511476afc9044665b625e8235c78e1f3-20220626
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2041971117; Sun, 26 Jun 2022 12:40:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 26 Jun 2022 12:40:03 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 12:40:02 +0800
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?N=EDcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v3 2/5] pinctrl: mediatek: add drive for I2C related pins on mt8192
Date:   Sun, 26 Jun 2022 12:39:52 +0800
Message-ID: <20220626043955.32756-3-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220626043955.32756-1-guodong.liu@mediatek.com>
References: <20220626043955.32756-1-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the advanced drive raw data setting version
for I2C used pins on mt8192

Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 96 ++++++-----------------
 1 file changed, 26 insertions(+), 70 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 2421a12fc573..efabeb422aea 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1259,74 +1259,32 @@ static const struct mtk_pin_field_calc mt8192_pin_r1_range[] = {
 	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 5, 1),
 };
 
-static const struct mtk_pin_field_calc mt8192_pin_e1e0en_range[] = {
-	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 0, 1),
-	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 18, 1),
-	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 15, 1),
-	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 3, 1),
-	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 12, 1),
-	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 0, 1),
-	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 9, 1),
-	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 27, 1),
-	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 6, 1),
-	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 24, 1),
-	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 3, 1),
-	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 21, 1),
-	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 0, 1),
-	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 3, 1),
-	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 3, 1),
-	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 9, 1),
-	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 0, 1),
-	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 3, 1),
-	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 0, 1),
-	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 6, 1),
-};
+static const struct mtk_pin_field_calc mt8192_pin_drv_adv_range[] = {
+	PIN_FIELD_BASE(89, 89, 2, 0x0040, 0x10, 0, 5),
+	PIN_FIELD_BASE(90, 90, 2, 0x0040, 0x10, 5, 5),
 
-static const struct mtk_pin_field_calc mt8192_pin_e0_range[] = {
-	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 1, 1),
-	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 19, 1),
-	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 16, 1),
-	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 4, 1),
-	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 13, 1),
-	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 1, 1),
-	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 10, 1),
-	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 28, 1),
-	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 7, 1),
-	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 25, 1),
-	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 4, 1),
-	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 22, 1),
-	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 1, 1),
-	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 4, 1),
-	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 4, 1),
-	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 10, 1),
-	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 1, 1),
-	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 4, 1),
-	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 1, 1),
-	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 7, 1),
+	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 0, 3),
+	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 18, 3),
+	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 15, 3),
+	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 3, 3),
+	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 12, 3),
+	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 0, 3),
+	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 9, 3),
+	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 27, 3),
+	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 6, 3),
+	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 24, 3),
+	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 3, 3),
+	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 21, 3),
+	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 3, 3),
+	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 3, 3),
+	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 9, 3),
+	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 0, 3),
+	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 0, 3),
+	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 6, 3),
 };
 
-static const struct mtk_pin_field_calc mt8192_pin_e1_range[] = {
-	PIN_FIELD_BASE(118, 118, 4, 0x0040, 0x10, 2, 1),
-	PIN_FIELD_BASE(119, 119, 4, 0x0040, 0x10, 20, 1),
-	PIN_FIELD_BASE(120, 120, 4, 0x0040, 0x10, 17, 1),
-	PIN_FIELD_BASE(121, 121, 4, 0x0050, 0x10, 5, 1),
-	PIN_FIELD_BASE(122, 122, 4, 0x0040, 0x10, 14, 1),
-	PIN_FIELD_BASE(123, 123, 4, 0x0050, 0x10, 2, 1),
-	PIN_FIELD_BASE(124, 124, 4, 0x0040, 0x10, 11, 1),
-	PIN_FIELD_BASE(125, 125, 4, 0x0040, 0x10, 29, 1),
-	PIN_FIELD_BASE(139, 139, 4, 0x0040, 0x10, 8, 1),
-	PIN_FIELD_BASE(140, 140, 4, 0x0040, 0x10, 26, 1),
-	PIN_FIELD_BASE(141, 141, 4, 0x0040, 0x10, 5, 1),
-	PIN_FIELD_BASE(142, 142, 4, 0x0040, 0x10, 23, 1),
-	PIN_FIELD_BASE(160, 160, 7, 0x0030, 0x10, 2, 1),
-	PIN_FIELD_BASE(161, 161, 7, 0x0030, 0x10, 5, 1),
-	PIN_FIELD_BASE(200, 200, 8, 0x0010, 0x10, 5, 1),
-	PIN_FIELD_BASE(201, 201, 8, 0x0010, 0x10, 11, 1),
-	PIN_FIELD_BASE(202, 202, 5, 0x0020, 0x10, 2, 1),
-	PIN_FIELD_BASE(203, 203, 5, 0x0020, 0x10, 5, 1),
-	PIN_FIELD_BASE(204, 204, 8, 0x0010, 0x10, 2, 1),
-	PIN_FIELD_BASE(205, 205, 8, 0x0010, 0x10, 8, 1),
-};
 
 
 static const char * const mt8192_pinctrl_register_base_names[] = {
@@ -1355,9 +1313,7 @@ static const struct mtk_pin_reg_calc mt8192_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8192_pin_pupd_range),
 	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8192_pin_r0_range),
 	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8192_pin_r1_range),
-	[PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8192_pin_e1e0en_range),
-	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8192_pin_e0_range),
-	[PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8192_pin_e1_range),
+	[PINCTRL_PIN_REG_DRV_ADV] = MTK_RANGE(mt8192_pin_drv_adv_range),
 };
 
 static const struct mtk_pin_soc mt8192_data = {
@@ -1376,8 +1332,8 @@ static const struct mtk_pin_soc mt8192_data = {
 	.drive_get = mtk_pinconf_drive_get_rev1,
 	.adv_pull_get = mtk_pinconf_adv_pull_get,
 	.adv_pull_set = mtk_pinconf_adv_pull_set,
-	.adv_drive_get = mtk_pinconf_adv_drive_get,
-	.adv_drive_set = mtk_pinconf_adv_drive_set,
+	.adv_drive_get = mtk_pinconf_adv_drive_get_raw,
+	.adv_drive_set = mtk_pinconf_adv_drive_set_raw,
 };
 
 static const struct of_device_id mt8192_pinctrl_of_match[] = {
-- 
2.25.5

