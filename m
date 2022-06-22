Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06093554415
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353709AbiFVHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353254AbiFVHhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:37:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D2377E1;
        Wed, 22 Jun 2022 00:37:30 -0700 (PDT)
X-UUID: 3b5b2ba541d44b11afd5e67be939f36e-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:7d4e7a49-7aa9-4232-ab96-2ea5cc4331bc,OB:20,L
        OB:20,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:7d4e7a49-7aa9-4232-ab96-2ea5cc4331bc,OB:20,LOB
        :20,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:df1b32ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:d1d2169eb362,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3b5b2ba541d44b11afd5e67be939f36e-20220622
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1612904803; Wed, 22 Jun 2022 15:37:22 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 15:37:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jun 2022 15:37:22 +0800
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
Subject: [PATCH v1 7/7] scsi: ufs-mediatek: Support performance boosting
Date:   Wed, 22 Jun 2022 15:37:19 +0800
Message-ID: <20220622073719.21599-8-stanley.chu@mediatek.com>
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

From: Peter Wang <peter.wang@mediatek.com>

Add pm-qos request to support performance boosting in
MediaTek UFS platforms.

In the same time, adjust the order of function calls
to be symmetric during the low-power control flow.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 34 +++++++++++++++++++++++++--------
 drivers/ufs/host/ufs-mediatek.h |  3 +++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 085ba05ff4d4..125d64e097f2 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -16,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sched/clock.h>
@@ -586,17 +587,32 @@ static void ufs_mtk_init_host_caps(struct ufs_hba *hba)
 	dev_info(hba->dev, "caps: 0x%x", host->caps);
 }
 
-static void ufs_mtk_scale_perf(struct ufs_hba *hba, bool up)
+static void ufs_mtk_boost_pm_qos(struct ufs_hba *hba, bool boost)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
 
-	ufs_mtk_boost_crypt(hba, up);
-	ufs_mtk_setup_ref_clk(hba, up);
+	if (!host || !host->pm_qos_init)
+		return;
+
+	cpu_latency_qos_update_request(&host->pm_qos_req,
+				       boost ? 0 : PM_QOS_DEFAULT_VALUE);
+}
+
+static void ufs_mtk_pwr_ctrl(struct ufs_hba *hba, bool on)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
 
-	if (up)
+	if (on) {
 		phy_power_on(host->mphy);
-	else
+		ufs_mtk_setup_ref_clk(hba, on);
+		ufs_mtk_boost_crypt(hba, on);
+		ufs_mtk_boost_pm_qos(hba, on);
+	} else {
+		ufs_mtk_boost_pm_qos(hba, on);
+		ufs_mtk_boost_crypt(hba, on);
+		ufs_mtk_setup_ref_clk(hba, on);
 		phy_power_off(host->mphy);
+	}
 }
 
 /**
@@ -641,9 +657,9 @@ static int ufs_mtk_setup_clocks(struct ufs_hba *hba, bool on,
 		}
 
 		if (clk_pwr_off)
-			ufs_mtk_scale_perf(hba, false);
+			ufs_mtk_pwr_ctrl(hba, false);
 	} else if (on && status == POST_CHANGE) {
-		ufs_mtk_scale_perf(hba, true);
+		ufs_mtk_pwr_ctrl(hba, true);
 	}
 
 	return ret;
@@ -1248,8 +1264,10 @@ static int ufs_mtk_apply_dev_quirks(struct ufs_hba *hba)
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	u16 mid = dev_info->wmanufacturerid;
 
-	if (mid == UFS_VENDOR_SAMSUNG)
+	if (mid == UFS_VENDOR_SAMSUNG) {
 		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TACTIVATE), 6);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HIBERN8TIME), 10);
+	}
 
 	/*
 	 * Decide waiting time before gating reference clock and
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index cdf40851e626..aa26d415527b 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -7,6 +7,7 @@
 #define _UFS_MEDIATEK_H
 
 #include <linux/bitops.h>
+#include <linux/pm_qos.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 
 /*
@@ -131,6 +132,7 @@ struct ufs_mtk_hw_ver {
 
 struct ufs_mtk_host {
 	struct phy *mphy;
+	struct pm_qos_request pm_qos_req;
 	struct regulator *reg_va09;
 	struct reset_control *hci_reset;
 	struct reset_control *unipro_reset;
@@ -140,6 +142,7 @@ struct ufs_mtk_host {
 	struct ufs_mtk_hw_ver hw_ver;
 	enum ufs_mtk_host_caps caps;
 	bool mphy_powered_on;
+	bool pm_qos_init;
 	bool unipro_lpm;
 	bool ref_clk_enabled;
 	u16 ref_clk_ungating_wait_us;
-- 
2.18.0

