Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F954A392
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347866AbiFNBRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbiFNBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:16:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846642D1CC;
        Mon, 13 Jun 2022 18:16:53 -0700 (PDT)
X-UUID: 9ba52f8d4b5a425f9fe6655086fd5055-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d8fbfaa5-6b9f-407c-a6b2-6aa06f3e7e8f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:1f619b37-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 9ba52f8d4b5a425f9fe6655086fd5055-20220614
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1678278686; Tue, 14 Jun 2022 09:16:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 09:16:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 09:16:42 +0800
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
Subject: [PATCH v2 8/8] scsi: ufs-mediatek: Support low-power mode for parents of VCCQx
Date:   Tue, 14 Jun 2022 09:16:39 +0800
Message-ID: <20220614011639.2825-9-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614011639.2825-1-stanley.chu@mediatek.com>
References: <20220614011639.2825-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/ufs/host/ufs-mediatek.c | 45 +++++++++++++++++++++++----------
 drivers/ufs/host/ufs-mediatek.h |  4 +++
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 9337ce27329b..2c1e55f8d7c6 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1013,10 +1013,29 @@ static int ufs_mtk_link_set_lpm(struct ufs_hba *hba)
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
+		lpm ? REGULATOR_MODE_IDLE : REGULATOR_MODE_NORMAL);
+}
+
+static void ufs_mtk_vsx_set_lpm(struct ufs_hba *hba, bool lpm)
+{
+	struct arm_smccc_res res;
+
+	ufs_mtk_device_pwr_ctrl(!lpm,
+		(unsigned long)hba->dev_info.wspecversion, res);
+}
+
+static void ufs_mtk_dev_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
+{
 	if (!hba->vreg_info.vccq && !hba->vreg_info.vccq2)
 		return;
 
@@ -1032,13 +1051,13 @@ static void ufs_mtk_vreg_set_lpm(struct ufs_hba *hba, bool lpm)
 	if (lpm && hba->vreg_info.vcc->enabled)
 		return;
 
-	if (hba->vreg_info.vccq)
-		vccqx = hba->vreg_info.vccq;
-	else
-		vccqx = hba->vreg_info.vccq2;
-
-	regulator_set_mode(vccqx->reg,
-		lpm ? REGULATOR_MODE_IDLE : REGULATOR_MODE_NORMAL);
+	if (lpm) {
+		ufs_mtk_vccqx_set_lpm(hba, lpm);
+		ufs_mtk_vsx_set_lpm(hba, lpm);
+	} else {
+		ufs_mtk_vsx_set_lpm(hba, lpm);
+		ufs_mtk_vccqx_set_lpm(hba, lpm);
+	}
 }
 
 static void ufs_mtk_auto_hibern8_disable(struct ufs_hba *hba)
@@ -1105,7 +1124,7 @@ static int ufs_mtk_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	int err;
 
 	if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
-		ufs_mtk_vreg_set_lpm(hba, false);
+		ufs_mtk_dev_vreg_set_lpm(hba, false);
 
 	err = ufs_mtk_mphy_power_on(hba, true);
 	if (err)
@@ -1283,7 +1302,7 @@ int ufs_mtk_system_suspend(struct device *dev)
 	ret = ufshcd_system_suspend(dev);
 
 	if (!ret)
-		ufs_mtk_vreg_set_lpm(hba, true);
+		ufs_mtk_dev_vreg_set_lpm(hba, true);
 
 	return ret;
 }
@@ -1293,7 +1312,7 @@ int ufs_mtk_system_resume(struct device *dev)
 	int ret = 0;
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	ufs_mtk_vreg_set_lpm(hba, false);
+	ufs_mtk_dev_vreg_set_lpm(hba, false);
 
 	ret = ufshcd_system_resume(dev);
 
@@ -1308,7 +1327,7 @@ int ufs_mtk_runtime_suspend(struct device *dev)
 	ret = ufshcd_runtime_suspend(dev);
 
 	if (!ret)
-		ufs_mtk_vreg_set_lpm(hba, true);
+		ufs_mtk_dev_vreg_set_lpm(hba, true);
 
 	return ret;
 }
@@ -1318,7 +1337,7 @@ int ufs_mtk_runtime_resume(struct device *dev)
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	int ret = 0;
 
-	ufs_mtk_vreg_set_lpm(hba, false);
+	ufs_mtk_dev_vreg_set_lpm(hba, false);
 
 	ret = ufshcd_runtime_resume(dev);
 
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index 9117427ca6c4..eb26306a719f 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -83,6 +83,7 @@ enum {
 #define UFS_MTK_SIP_DEVICE_RESET          BIT(1)
 #define UFS_MTK_SIP_CRYPTO_CTRL           BIT(2)
 #define UFS_MTK_SIP_REF_CLK_NOTIFICATION  BIT(3)
+#define UFS_MTK_SIP_DEVICE_PWR_CTRL       BIT(7)
 
 /*
  * VS_DEBUGCLOCKENABLE
@@ -199,4 +200,7 @@ struct ufs_mtk_host {
 #define ufs_mtk_device_reset_ctrl(high, res) \
 	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, res, high)
 
+#define ufs_mtk_device_pwr_ctrl(on, ufs_ver, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_PWR_CTRL, res, on, ufs_ver)
+
 #endif /* !_UFS_MEDIATEK_H */
-- 
2.18.0

