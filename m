Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164454D9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358770AbiFPFht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358700AbiFPFhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:37:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8CA205E3;
        Wed, 15 Jun 2022 22:37:37 -0700 (PDT)
X-UUID: be1527b3f93c4ad897e44f80291c87b6-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:85a9e3c0-f0cc-4eac-affb-6ba2354a46fd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:c15b6ff6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: be1527b3f93c4ad897e44f80291c87b6-20220616
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1953433498; Thu, 16 Jun 2022 13:37:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 13:37:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 13:37:27 +0800
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
Subject: [PATCH v5 11/11] scsi: ufs-mediatek: Disable unused VCCQx power rails
Date:   Thu, 16 Jun 2022 13:37:25 +0800
Message-ID: <20220616053725.5681-12-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220616053725.5681-1-stanley.chu@mediatek.com>
References: <20220616053725.5681-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MediaTek UFS platforms support different VCCQx power rails,
for example, both 1.2v and 1.8v VCCQx, in a single kernel image.

To optimize the system power consumption, provide a way to disable
and release the unused power rail during the device probing.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 34e51c094366..bfe04a4d1dce 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -712,6 +712,29 @@ static int ufs_mtk_vreg_fix_vcc(struct ufs_hba *hba)
 	return err;
 }
 
+static void ufs_mtk_vreg_fix_vccqx(struct ufs_hba *hba)
+{
+	struct ufs_vreg_info *info = &hba->vreg_info;
+	struct ufs_vreg **vreg_on, **vreg_off;
+
+	if (hba->dev_info.wspecversion >= 0x0300) {
+		vreg_on = &info->vccq;
+		vreg_off = &info->vccq2;
+	} else {
+		vreg_on = &info->vccq2;
+		vreg_off = &info->vccq;
+	}
+
+	if (*vreg_on)
+		(*vreg_on)->always_on = true;
+
+	if (*vreg_off) {
+		regulator_disable((*vreg_off)->reg);
+		devm_kfree(hba->dev, (*vreg_off)->name);
+		devm_kfree(hba->dev, *vreg_off);
+	}
+}
+
 /**
  * ufs_mtk_init - find other essential mmio bases
  * @hba: host controller instance
@@ -1241,6 +1264,7 @@ static void ufs_mtk_fixup_dev_quirks(struct ufs_hba *hba)
 	}
 
 	ufs_mtk_vreg_fix_vcc(hba);
+	ufs_mtk_vreg_fix_vccqx(hba);
 }
 
 static void ufs_mtk_event_notify(struct ufs_hba *hba,
-- 
2.18.0

