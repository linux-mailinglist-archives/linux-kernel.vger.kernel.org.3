Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8254275E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiFHG70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348792AbiFHGNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:13:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3CD1C4224;
        Tue,  7 Jun 2022 22:39:58 -0700 (PDT)
X-UUID: f18a994ce727490c8531a2f5d1f9568a-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:b88ac77b-3b31-417c-8568-32712abd46e3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:2a19b09,CLOUDID:1d7e0ce5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:1,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: f18a994ce727490c8531a2f5d1f9568a-20220608
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 856678529; Wed, 08 Jun 2022 13:39:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 8 Jun 2022 13:39:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jun 2022 13:39:50 +0800
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
Subject: [PATCH v1 4/4] pinctrl: mediatek: fix the pinconf definition of some GPIO pins
Date:   Wed, 8 Jun 2022 13:39:09 +0800
Message-ID: <20220608053909.1252-5-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608053909.1252-1-guodong.liu@mediatek.com>
References: <20220608053909.1252-1-guodong.liu@mediatek.com>
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

Remove pin definitions that do not support the R0 & R1 pinconfig property

Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 60 -----------------------
 1 file changed, 60 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 1486c141ee8c..13784a92a536 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1107,24 +1107,10 @@ static const struct mtk_pin_field_calc mt8192_pin_pupd_range[] = {
 	PIN_FIELD_BASE(54, 54, 1, 0x0060, 0x10, 2, 1),
 	PIN_FIELD_BASE(55, 55, 1, 0x0060, 0x10, 4, 1),
 	PIN_FIELD_BASE(56, 56, 1, 0x0060, 0x10, 3, 1),
-	PIN_FIELD_BASE(118, 118, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(119, 119, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(120, 120, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(121, 121, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(122, 122, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(123, 123, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(124, 124, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(125, 125, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(139, 139, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(140, 140, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(141, 141, 4, 0x00e0, 0x10, 31, 1),
-	PIN_FIELD_BASE(142, 142, 4, 0x00e0, 0x10, 31, 1),
 	PIN_FIELD_BASE(152, 152, 7, 0x0090, 0x10, 3, 1),
 	PIN_FIELD_BASE(153, 153, 7, 0x0090, 0x10, 2, 1),
 	PIN_FIELD_BASE(154, 154, 7, 0x0090, 0x10, 0, 1),
 	PIN_FIELD_BASE(155, 155, 7, 0x0090, 0x10, 1, 1),
-	PIN_FIELD_BASE(160, 160, 7, 0x00f0, 0x10, 31, 1),
-	PIN_FIELD_BASE(161, 161, 7, 0x00f0, 0x10, 31, 1),
 	PIN_FIELD_BASE(183, 183, 9, 0x0030, 0x10, 1, 1),
 	PIN_FIELD_BASE(184, 184, 9, 0x0030, 0x10, 2, 1),
 	PIN_FIELD_BASE(185, 185, 9, 0x0030, 0x10, 4, 1),
@@ -1137,12 +1123,6 @@ static const struct mtk_pin_field_calc mt8192_pin_pupd_range[] = {
 	PIN_FIELD_BASE(192, 192, 9, 0x0030, 0x10, 0, 1),
 	PIN_FIELD_BASE(193, 193, 9, 0x0030, 0x10, 5, 1),
 	PIN_FIELD_BASE(194, 194, 9, 0x0030, 0x10, 11, 1),
-	PIN_FIELD_BASE(200, 200, 8, 0x0070, 0x10, 31, 1),
-	PIN_FIELD_BASE(201, 201, 8, 0x0070, 0x10, 31, 1),
-	PIN_FIELD_BASE(202, 202, 5, 0x0070, 0x10, 31, 1),
-	PIN_FIELD_BASE(203, 203, 5, 0x0070, 0x10, 31, 1),
-	PIN_FIELD_BASE(204, 204, 8, 0x0070, 0x10, 31, 1),
-	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 31, 1),
 };
 
 static const struct mtk_pin_field_calc mt8192_pin_r0_range[] = {
@@ -1164,24 +1144,10 @@ static const struct mtk_pin_field_calc mt8192_pin_r0_range[] = {
 	PIN_FIELD_BASE(54, 54, 1, 0x0080, 0x10, 2, 1),
 	PIN_FIELD_BASE(55, 55, 1, 0x0080, 0x10, 4, 1),
 	PIN_FIELD_BASE(56, 56, 1, 0x0080, 0x10, 3, 1),
-	PIN_FIELD_BASE(118, 118, 4, 0x00e0, 0x10, 0, 1),
-	PIN_FIELD_BASE(119, 119, 4, 0x00e0, 0x10, 12, 1),
-	PIN_FIELD_BASE(120, 120, 4, 0x00e0, 0x10, 10, 1),
-	PIN_FIELD_BASE(121, 121, 4, 0x00e0, 0x10, 22, 1),
-	PIN_FIELD_BASE(122, 122, 4, 0x00e0, 0x10, 8, 1),
-	PIN_FIELD_BASE(123, 123, 4, 0x00e0, 0x10, 20, 1),
-	PIN_FIELD_BASE(124, 124, 4, 0x00e0, 0x10, 6, 1),
-	PIN_FIELD_BASE(125, 125, 4, 0x00e0, 0x10, 18, 1),
-	PIN_FIELD_BASE(139, 139, 4, 0x00e0, 0x10, 4, 1),
-	PIN_FIELD_BASE(140, 140, 4, 0x00e0, 0x10, 16, 1),
-	PIN_FIELD_BASE(141, 141, 4, 0x00e0, 0x10, 2, 1),
-	PIN_FIELD_BASE(142, 142, 4, 0x00e0, 0x10, 14, 1),
 	PIN_FIELD_BASE(152, 152, 7, 0x00c0, 0x10, 3, 1),
 	PIN_FIELD_BASE(153, 153, 7, 0x00c0, 0x10, 2, 1),
 	PIN_FIELD_BASE(154, 154, 7, 0x00c0, 0x10, 0, 1),
 	PIN_FIELD_BASE(155, 155, 7, 0x00c0, 0x10, 1, 1),
-	PIN_FIELD_BASE(160, 160, 7, 0x00f0, 0x10, 0, 1),
-	PIN_FIELD_BASE(161, 161, 7, 0x00f0, 0x10, 2, 1),
 	PIN_FIELD_BASE(183, 183, 9, 0x0040, 0x10, 1, 1),
 	PIN_FIELD_BASE(184, 184, 9, 0x0040, 0x10, 2, 1),
 	PIN_FIELD_BASE(185, 185, 9, 0x0040, 0x10, 4, 1),
@@ -1194,12 +1160,6 @@ static const struct mtk_pin_field_calc mt8192_pin_r0_range[] = {
 	PIN_FIELD_BASE(192, 192, 9, 0x0040, 0x10, 0, 1),
 	PIN_FIELD_BASE(193, 193, 9, 0x0040, 0x10, 5, 1),
 	PIN_FIELD_BASE(194, 194, 9, 0x0040, 0x10, 11, 1),
-	PIN_FIELD_BASE(200, 200, 8, 0x0070, 0x10, 2, 1),
-	PIN_FIELD_BASE(201, 201, 8, 0x0070, 0x10, 6, 1),
-	PIN_FIELD_BASE(202, 202, 5, 0x0070, 0x10, 0, 1),
-	PIN_FIELD_BASE(203, 203, 5, 0x0070, 0x10, 2, 1),
-	PIN_FIELD_BASE(204, 204, 8, 0x0070, 0x10, 0, 1),
-	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 4, 1),
 };
 
 static const struct mtk_pin_field_calc mt8192_pin_r1_range[] = {
@@ -1221,24 +1181,10 @@ static const struct mtk_pin_field_calc mt8192_pin_r1_range[] = {
 	PIN_FIELD_BASE(54, 54, 1, 0x0090, 0x10, 2, 1),
 	PIN_FIELD_BASE(55, 55, 1, 0x0090, 0x10, 4, 1),
 	PIN_FIELD_BASE(56, 56, 1, 0x0090, 0x10, 3, 1),
-	PIN_FIELD_BASE(118, 118, 4, 0x00e0, 0x10, 1, 1),
-	PIN_FIELD_BASE(119, 119, 4, 0x00e0, 0x10, 13, 1),
-	PIN_FIELD_BASE(120, 120, 4, 0x00e0, 0x10, 11, 1),
-	PIN_FIELD_BASE(121, 121, 4, 0x00e0, 0x10, 23, 1),
-	PIN_FIELD_BASE(122, 122, 4, 0x00e0, 0x10, 9, 1),
-	PIN_FIELD_BASE(123, 123, 4, 0x00e0, 0x10, 21, 1),
-	PIN_FIELD_BASE(124, 124, 4, 0x00e0, 0x10, 7, 1),
-	PIN_FIELD_BASE(125, 125, 4, 0x00e0, 0x10, 19, 1),
-	PIN_FIELD_BASE(139, 139, 4, 0x00e0, 0x10, 5, 1),
-	PIN_FIELD_BASE(140, 140, 4, 0x00e0, 0x10, 17, 1),
-	PIN_FIELD_BASE(141, 141, 4, 0x00e0, 0x10, 3, 1),
-	PIN_FIELD_BASE(142, 142, 4, 0x00e0, 0x10, 15, 1),
 	PIN_FIELD_BASE(152, 152, 7, 0x00d0, 0x10, 3, 1),
 	PIN_FIELD_BASE(153, 153, 7, 0x00d0, 0x10, 2, 1),
 	PIN_FIELD_BASE(154, 154, 7, 0x00d0, 0x10, 0, 1),
 	PIN_FIELD_BASE(155, 155, 7, 0x00d0, 0x10, 1, 1),
-	PIN_FIELD_BASE(160, 160, 7, 0x00f0, 0x10, 1, 1),
-	PIN_FIELD_BASE(161, 161, 7, 0x00f0, 0x10, 3, 1),
 	PIN_FIELD_BASE(183, 183, 9, 0x0050, 0x10, 1, 1),
 	PIN_FIELD_BASE(184, 184, 9, 0x0050, 0x10, 2, 1),
 	PIN_FIELD_BASE(185, 185, 9, 0x0050, 0x10, 4, 1),
@@ -1251,12 +1197,6 @@ static const struct mtk_pin_field_calc mt8192_pin_r1_range[] = {
 	PIN_FIELD_BASE(192, 192, 9, 0x0050, 0x10, 0, 1),
 	PIN_FIELD_BASE(193, 193, 9, 0x0050, 0x10, 5, 1),
 	PIN_FIELD_BASE(194, 194, 9, 0x0050, 0x10, 11, 1),
-	PIN_FIELD_BASE(200, 200, 8, 0x0070, 0x10, 3, 1),
-	PIN_FIELD_BASE(201, 201, 8, 0x0070, 0x10, 7, 1),
-	PIN_FIELD_BASE(202, 202, 5, 0x0070, 0x10, 1, 1),
-	PIN_FIELD_BASE(203, 203, 5, 0x0070, 0x10, 3, 1),
-	PIN_FIELD_BASE(204, 204, 8, 0x0070, 0x10, 1, 1),
-	PIN_FIELD_BASE(205, 205, 8, 0x0070, 0x10, 5, 1),
 };
 
 static const struct mtk_pin_field_calc mt8192_pin_drv_adv_range[] = {
-- 
2.25.5

