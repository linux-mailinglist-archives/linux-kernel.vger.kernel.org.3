Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5854C06B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352949AbiFODwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiFODv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:51:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1E5005E;
        Tue, 14 Jun 2022 20:51:55 -0700 (PDT)
X-UUID: 6da093a912f34a91b69678f47be0baf4-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b5310148-119a-4f24-84b7-7ec94e8d2fe6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:503b42f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 6da093a912f34a91b69678f47be0baf4-20220615
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1469923884; Wed, 15 Jun 2022 11:51:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 11:51:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:51:47 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v4 06/10] scsi: ufs-mediatek: Support low-power mode for VCCQ
Date:   Wed, 15 Jun 2022 11:51:42 +0800
Message-ID: <20220615035146.20964-7-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220615035146.20964-1-stanley.chu@mediatek.com>
References: <20220615035146.20964-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Wang <peter.wang@mediatek.com>

Also allow VCCQ to enter low-power mode, and meanwhile
remove the restriction of VCC because VCCQ/VCCQ2 can
be changed to low-power mode even if VCC keeps on while
the device is not in active power mode.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 03762ecaaaf8..65a2a4185ef6 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1031,7 +1031,13 @@ static int ufs_mtk_link_set_lpm(struct ufs_hba *hba)
 
 static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 {
-	if (!hba->vreg_info.vccq2 || !hba->vreg_info.vcc)
+	struct ufs_vreg *vccqx = NULL;
+
+	if (!hba->vreg_info.vccq && !hba->vreg_info.vccq2)
+		return;
+
+	/* Skip if VCC is assumed always-on */
+	if (!hba->vreg_info.vcc)
 		return;
 
 	/* Bypass LPM when device is still active */
@@ -1042,12 +1048,13 @@ static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 	if (lpm && hba->vreg_info.vcc->enabled)
 		return;
 
-	if (lpm)
-		regulator_set_mode(hba->vreg_info.vccq2->reg,
-				   REGULATOR_MODE_IDLE);
+	if (hba->vreg_info.vccq)
+		vccqx = hba->vreg_info.vccq;
 	else
-		regulator_set_mode(hba->vreg_info.vccq2->reg,
-				   REGULATOR_MODE_NORMAL);
+		vccqx = hba->vreg_info.vccq2;
+
+	regulator_set_mode(vccqx->reg,
+			   lpm ? REGULATOR_MODE_IDLE : REGULATOR_MODE_NORMAL);
 }
 
 static void ufs_mtk_auto_hibern8_disable(struct ufs_hba *hba)
-- 
2.18.0

