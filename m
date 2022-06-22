Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05280554487
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353421AbiFVHhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353245AbiFVHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:37:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD00377DD;
        Wed, 22 Jun 2022 00:37:29 -0700 (PDT)
X-UUID: 7a4c61dc1b0142c68d7f0f82bf2e7088-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:6bacb469-5688-43bf-a93c-02461ca8184d,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.6,REQID:6bacb469-5688-43bf-a93c-02461ca8184d,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:90
X-CID-META: VersionHash:b14ad71,CLOUDID:85a1ba2d-1756-4fa3-be7f-474a6e4be921,C
        OID:d1d2169eb362,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7a4c61dc1b0142c68d7f0f82bf2e7088-20220622
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 74774015; Wed, 22 Jun 2022 15:37:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 15:37:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 22 Jun 2022 15:37:21 +0800
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
Subject: [PATCH v1 6/7] scsi: ufs-mediatek: Support host power control
Date:   Wed, 22 Jun 2022 15:37:18 +0800
Message-ID: <20220622073719.21599-7-stanley.chu@mediatek.com>
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

From: Po-Wen Kao <powen.kao@mediatek.com>

Add interfaces for controlling the host power to
optimize the power consumption in MediaTek UFS platforms.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c |  5 +++++
 drivers/ufs/host/ufs-mediatek.h | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 348966dbad78..085ba05ff4d4 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1190,6 +1190,8 @@ static int ufs_mtk_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	if (ufshcd_is_link_off(hba))
 		ufs_mtk_device_reset_ctrl(0, res);
 
+	ufs_mtk_host_pwr_ctrl(HOST_PWR_HCI, false, res);
+
 	return 0;
 fail:
 	/*
@@ -1204,10 +1206,13 @@ static int ufs_mtk_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 static int ufs_mtk_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	int err;
+	struct arm_smccc_res res;
 
 	if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL)
 		ufs_mtk_dev_vreg_set_lpm(hba, false);
 
+	ufs_mtk_host_pwr_ctrl(HOST_PWR_HCI, true, res);
+
 	err = ufs_mtk_mphy_power_on(hba, true);
 	if (err)
 		goto fail;
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index c12ceb4d941f..cdf40851e626 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -84,6 +84,7 @@ enum {
 #define UFS_MTK_SIP_DEVICE_RESET          BIT(1)
 #define UFS_MTK_SIP_CRYPTO_CTRL           BIT(2)
 #define UFS_MTK_SIP_REF_CLK_NOTIFICATION  BIT(3)
+#define UFS_MTK_SIP_HOST_PWR_CTRL         BIT(5)
 #define UFS_MTK_SIP_GET_VCC_NUM           BIT(6)
 #define UFS_MTK_SIP_DEVICE_PWR_CTRL       BIT(7)
 
@@ -156,6 +157,14 @@ enum ufs_mtk_vcc_num {
 	UFS_VCC_MAX
 };
 
+/*
+ * Host Power Control options
+ */
+enum {
+	HOST_PWR_HCI = 0,
+	HOST_PWR_MPHY
+};
+
 /*
  * SMC call wrapper function
  */
@@ -195,6 +204,9 @@ static void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
 #define ufs_mtk_device_reset_ctrl(high, res) \
 	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, &(res), high)
 
+#define ufs_mtk_host_pwr_ctrl(opt, on, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_HOST_PWR_CTRL, &(res), opt, on)
+
 #define ufs_mtk_get_vcc_num(res) \
 	ufs_mtk_smc(UFS_MTK_SIP_GET_VCC_NUM, &(res))
 
-- 
2.18.0

