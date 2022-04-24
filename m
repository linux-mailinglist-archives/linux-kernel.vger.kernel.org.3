Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2853E50CEC3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiDXDBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiDXDA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:00:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EC13FB72;
        Sat, 23 Apr 2022 19:57:54 -0700 (PDT)
X-UUID: 83a395d4d9f34e929909b2f9a9eb2d7e-20220424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f01cc64b-3fc5-4b64-84b8-fedf49e2cdad,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:f829b9f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 83a395d4d9f34e929909b2f9a9eb2d7e-20220424
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1556752049; Sun, 24 Apr 2022 10:57:48 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 24 Apr 2022 10:57:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 24 Apr
 2022 10:57:42 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 Apr 2022 10:57:41 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <eddie.huang@mediatek.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>, <sean.wang@mediatek.com>,
        <macpaul.lin@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 1/1] pwrap: mediatek: fix FSM timeout issue
Date:   Sun, 24 Apr 2022 10:57:38 +0800
Message-ID: <20220424025738.32271-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220424025738.32271-1-zhiyong.tao@mediatek.com>
References: <20220424025738.32271-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>

Fix pwrap FSM timeout issue which leads the system crash on GFX VSRAM
power on.
Add a usleep delay to avoid busy read for the H/W status.
For avoiding the system behavior(ex. disable interrupt in suspend/resume
flow, schedule block task)cause if (time_after()) be turn first,
we change it after sleep delay.
Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
MT8173 SoCs")

Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 952bc554f443..ac7139a67e87 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/delay.h>
 
 #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
 #define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
@@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
 	timeout = jiffies + usecs_to_jiffies(10000);
 
 	do {
-		if (time_after(jiffies, timeout))
-			return fp(wrp) ? 0 : -ETIMEDOUT;
 		if (fp(wrp))
 			return 0;
+
+		usleep_range(10, 11);
+
+		if (time_after(jiffies, timeout))
+			return fp(wrp) ? 0 : -ETIMEDOUT;
 	} while (1);
 }
 
-- 
2.18.0

