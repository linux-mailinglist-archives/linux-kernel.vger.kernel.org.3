Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF554C05F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351239AbiFODwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbiFODvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:51:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F750053;
        Tue, 14 Jun 2022 20:51:54 -0700 (PDT)
X-UUID: e2042728323d447489e38b32e5576eeb-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:fb538b12-5519-4d3b-b11b-8b298200fef3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:4f3b42f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e2042728323d447489e38b32e5576eeb-20220615
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1872199788; Wed, 15 Jun 2022 11:51:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 11:51:47 +0800
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
Subject: [PATCH v4 05/10] scsi: ufs-mediatek: Prevent device regulators setting as LPM incorrectly
Date:   Wed, 15 Jun 2022 11:51:41 +0800
Message-ID: <20220615035146.20964-6-stanley.chu@mediatek.com>
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

From: Po-Wen Kao <powen.kao@mediatek.com>

Device regulatrs are allowed to enter low-power mode
if neither device is not in active mode, nor VCC does not
keep on.

Simply fix this by adding conditions before LPM decision.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 817d957512a3..03762ecaaaf8 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1034,10 +1034,18 @@ static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 	if (!hba->vreg_info.vccq2 || !hba->vreg_info.vcc)
 		return;
 
-	if (lpm && !hba->vreg_info.vcc->enabled)
+	/* Bypass LPM when device is still active */
+	if (lpm && ufshcd_is_ufs_dev_active(hba))
+		return;
+
+	/* Bypass LPM if VCC is enabled */
+	if (lpm && hba->vreg_info.vcc->enabled)
+		return;
+
+	if (lpm)
 		regulator_set_mode(hba->vreg_info.vccq2->reg,
 				   REGULATOR_MODE_IDLE);
-	else if (!lpm)
+	else
 		regulator_set_mode(hba->vreg_info.vccq2->reg,
 				   REGULATOR_MODE_NORMAL);
 }
-- 
2.18.0

