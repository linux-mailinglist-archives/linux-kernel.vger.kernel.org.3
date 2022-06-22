Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC35543D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353616AbiFVHht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353238AbiFVHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:37:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0F377DC;
        Wed, 22 Jun 2022 00:37:28 -0700 (PDT)
X-UUID: a0c07be0e83843498b1475e59c031ef6-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d4bf5cc2-30ef-44c5-a898-c29d15e42452,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.6,REQID:d4bf5cc2-30ef-44c5-a898-c29d15e42452,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:b14ad71,CLOUDID:c9272738-5e4b-44d7-80b2-bb618cb09d29,C
        OID:5488c44df5a1,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: a0c07be0e83843498b1475e59c031ef6-20220622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1276742694; Wed, 22 Jun 2022 15:37:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 15:37:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 22 Jun 2022 15:37:20 +0800
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
Subject: [PATCH v1 1/7] scsi: ufs-mediatek: Fix build warnings
Date:   Wed, 22 Jun 2022 15:37:13 +0800
Message-ID: <20220622073719.21599-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220622073719.21599-1-stanley.chu@mediatek.com>
References: <20220622073719.21599-1-stanley.chu@mediatek.com>
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

Fix build warnings as below,
1.
../drivers/ufs/host/ufs-mediatek.c:1375:5: error: no previous prototype for function 'ufs_mtk_system_suspend' [-Werror,-Wmissing-prototypes]
int ufs_mtk_system_suspend(struct device *dev)
    ^
../drivers/ufs/host/ufs-mediatek.c:1375:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
int ufs_mtk_system_suspend(struct device *dev)
^
static

2.
../drivers/ufs/host/ufs-mediatek.c:702:50: error: format specifies type 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
                snprintf(vcc_name, MAX_VCC_NAME, "vcc-ufs%lu", ver);
                                                         ~~~   ^~~
                                                         %d

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 3ee27f2bcdfc..d970c6607b4a 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -690,7 +690,7 @@ static int ufs_mtk_vreg_fix_vcc(struct ufs_hba *hba)
 			return -ENODEV;
 	} else if (of_property_read_bool(np, "mediatek,ufs-vcc-by-ver")) {
 		ver = (hba->dev_info.wspecversion & 0xF00) >> 8;
-		snprintf(vcc_name, MAX_VCC_NAME, "vcc-ufs%lu", ver);
+		snprintf(vcc_name, MAX_VCC_NAME, "vcc-ufs%d", ver);
 	} else {
 		return 0;
 	}
@@ -1364,7 +1364,7 @@ static int ufs_mtk_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-int ufs_mtk_system_suspend(struct device *dev)
+static int ufs_mtk_system_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret;
@@ -1378,7 +1378,7 @@ int ufs_mtk_system_suspend(struct device *dev)
 	return 0;
 }
 
-int ufs_mtk_system_resume(struct device *dev)
+static int ufs_mtk_system_resume(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
@@ -1388,7 +1388,7 @@ int ufs_mtk_system_resume(struct device *dev)
 }
 #endif
 
-int ufs_mtk_runtime_suspend(struct device *dev)
+static int ufs_mtk_runtime_suspend(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1402,7 +1402,7 @@ int ufs_mtk_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-int ufs_mtk_runtime_resume(struct device *dev)
+static int ufs_mtk_runtime_resume(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-- 
2.18.0

