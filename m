Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EFD54C061
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiFODw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346065AbiFODwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:52:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A250072;
        Tue, 14 Jun 2022 20:51:56 -0700 (PDT)
X-UUID: 6fc14475d1854d8a9fdcc2d021dd096e-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:8a1f4f1d-f19a-4455-96da-e52e35236fab,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.6,REQID:8a1f4f1d-f19a-4455-96da-e52e35236fab,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:b14ad71,CLOUDID:d0988548-4c92-421c-ad91-b806c0f58b2a,C
        OID:4a4ece901a66,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6fc14475d1854d8a9fdcc2d021dd096e-20220615
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 390776483; Wed, 15 Jun 2022 11:51:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 15 Jun 2022 11:51:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:51:48 +0800
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
Subject: [PATCH v4 08/10] scsi: ufs-mediatek: Support low-power mode for parents of VCCQx
Date:   Wed, 15 Jun 2022 11:51:44 +0800
Message-ID: <20220615035146.20964-9-stanley.chu@mediatek.com>
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

Provide the facility to configure parents of VCCQx power rails
as low-power or full-power mode in MediaTek UFS platforms.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 46 +++++++++++++++++++++++----------
 drivers/ufs/host/ufs-mediatek.h |  4 +++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 9c5d1213c290..e756aba45acd 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1013,10 +1013,30 @@ static int ufs_mtk_link_set_lpm(struct ufs_hba *hba)
 	return 0;
 }
 
-static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
+static void ufs_mtk_vccqx_set_lpm(struct ufs_hba *hba, bool lpm)
 {
 	struct ufs_vreg *vccqx = NULL;
 
+	if (hba->vreg_info.vccq)
+		vccqx = hba->vreg_info.vccq;
+	else
+		vccqx = hba->vreg_info.vccq2;
+
+	regulator_set_mode(vccqx->reg,
+			   lpm ? REGULATOR_MODE_IDLE : REGULATOR_MODE_NORMAL);
+}
+
+static void ufs_mtk_vsx_set_lpm(struct ufs_hba *hba, bool lpm)
+{
+	struct arm_smccc_res res;
+
+	ufs_mtk_device_pwr_ctrl(!lpm,
+				(unsigned long)hba->dev_info.wspecversion,
+				res);
+}
+
+static void ufs_mtk_dev_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
+{
 	if (!hba->vreg_info.vccq && !hba->vreg_info.vccq2)
 		return;
 
@@ -1032,13 +1052,13 @@ static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 	if (lpm && hba->vreg_info.vcc->enabled)
 		return;
 
-	if (hba->vreg_info.vccq)
-		vccqx = hba->vreg_info.vccq;
-	else
-		vccqx = hba->vreg_info.vccq2;
-
-	regulator_set_mode(vccqx->reg,
-			   lpm ? REGULATOR_MODE_IDLE : REGULATOR_MODE_NORMAL);
+	if (lpm) {
+		ufs_mtk_vccqx_set_lpm(hba, lpm);
+		ufs_mtk_vsx_set_lpm(hba, lpm);
+	} else {
+		ufs_mtk_vsx_set_lpm(hba, lpm);
+		ufs_mtk_vccqx_set_lpm(hba, lpm);
+	}
 }
 
 static void ufs_mtk_auto_hibern8_disable(struct ufs_hba *hba)
@@ -1105,7 +1125,7 @@ static int ufs_mtk_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	int err;
 
 	if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
-		ufs_mtk_vreg_set_lpm(hba, false);
+		ufs_mtk_dev_vreg_set_lpm(hba, false);
 
 	err = ufs_mtk_mphy_power_on(hba, true);
 	if (err)
@@ -1284,7 +1304,7 @@ int ufs_mtk_system_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ufs_mtk_vreg_set_lpm(hba, true);
+	ufs_mtk_dev_vreg_set_lpm(hba, true);
 
 	return 0;
 }
@@ -1293,7 +1313,7 @@ int ufs_mtk_system_resume(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	ufs_mtk_vreg_set_lpm(hba, false);
+	ufs_mtk_dev_vreg_set_lpm(hba, false);
 
 	return ufshcd_system_resume(dev);
 }
@@ -1307,7 +1327,7 @@ int ufs_mtk_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ufs_mtk_vreg_set_lpm(hba, true);
+	ufs_mtk_dev_vreg_set_lpm(hba, true);
 
 	return 0;
 }
@@ -1316,7 +1336,7 @@ int ufs_mtk_runtime_resume(struct device *dev)
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	ufs_mtk_vreg_set_lpm(hba, false);
+	ufs_mtk_dev_vreg_set_lpm(hba, false);
 
 	return ufshcd_runtime_resume(dev);
 }
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index bf6ca96cafb6..5c6101ac518f 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -83,6 +83,7 @@ enum {
 #define UFS_MTK_SIP_DEVICE_RESET          BIT(1)
 #define UFS_MTK_SIP_CRYPTO_CTRL           BIT(2)
 #define UFS_MTK_SIP_REF_CLK_NOTIFICATION  BIT(3)
+#define UFS_MTK_SIP_DEVICE_PWR_CTRL       BIT(7)
 
 /*
  * VS_DEBUGCLOCKENABLE
@@ -182,4 +183,7 @@ static void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
 #define ufs_mtk_device_reset_ctrl(high, res) \
 	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, &(res), high)
 
+#define ufs_mtk_device_pwr_ctrl(on, ufs_ver, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_PWR_CTRL, &(res), on, ufs_ver)
+
 #endif /* !_UFS_MEDIATEK_H */
-- 
2.18.0

