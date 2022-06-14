Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1554A385
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbiFNBRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiFNBQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:16:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3DA30548;
        Mon, 13 Jun 2022 18:16:53 -0700 (PDT)
X-UUID: 127015ffe93c40a38ae5e4c956229dab-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:5b3edc86-b118-49ff-8f60-5a81abed7fa1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:33609b37-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 127015ffe93c40a38ae5e4c956229dab-20220614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 219984168; Tue, 14 Jun 2022 09:16:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Jun 2022 09:16:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 09:16:41 +0800
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
Subject: [PATCH v2 7/8] scsi: ufs-mediatek: Support flexible parameters for smc calls
Date:   Tue, 14 Jun 2022 09:16:38 +0800
Message-ID: <20220614011639.2825-8-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614011639.2825-1-stanley.chu@mediatek.com>
References: <20220614011639.2825-1-stanley.chu@mediatek.com>
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

From: Alice Chao <alice.chao@mediatek.com>

Provide flexible number of parameters for UFS SMC calls to be
easily used for future SMC usages.

This is a preparation patch for the next patch.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Alice Chao <alice.chao@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 16 ----------
 drivers/ufs/host/ufs-mediatek.h | 56 +++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 178043ab837c..9337ce27329b 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -30,22 +30,6 @@
 #define CREATE_TRACE_POINTS
 #include "ufs-mediatek-trace.h"
 
-#define ufs_mtk_smc(cmd, val, res) \
-	arm_smccc_smc(MTK_SIP_UFS_CONTROL, \
-		      cmd, val, 0, 0, 0, 0, 0, &(res))
-
-#define ufs_mtk_va09_pwr_ctrl(res, on) \
-	ufs_mtk_smc(UFS_MTK_SIP_VA09_PWR_CTRL, on, res)
-
-#define ufs_mtk_crypto_ctrl(res, enable) \
-	ufs_mtk_smc(UFS_MTK_SIP_CRYPTO_CTRL, enable, res)
-
-#define ufs_mtk_ref_clk_notify(on, res) \
-	ufs_mtk_smc(UFS_MTK_SIP_REF_CLK_NOTIFICATION, on, res)
-
-#define ufs_mtk_device_reset_ctrl(high, res) \
-	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, high, res)
-
 static const struct ufs_dev_quirk ufs_mtk_dev_fixups[] = {
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
 	  .model = UFS_ANY_MODEL,
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index 7e1913769671..9117427ca6c4 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -143,4 +143,60 @@ struct ufs_mtk_host {
 	u32 ip_ver;
 };
 
+/*
+ * SMC call wapper function
+ */
+#define _ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, v6) \
+		arm_smccc_smc(MTK_SIP_UFS_CONTROL, \
+				  cmd, v1, v2, v3, v4, v5, v6, &(res))
+
+#define _ufs_mtk_smc_0(cmd, res) \
+	_ufs_mtk_smc(cmd, res, 0, 0, 0, 0, 0, 0)
+
+#define _ufs_mtk_smc_1(cmd, res, v1) \
+	_ufs_mtk_smc(cmd, res, v1, 0, 0, 0, 0, 0)
+
+#define _ufs_mtk_smc_2(cmd, res, v1, v2) \
+	_ufs_mtk_smc(cmd, res, v1, v2, 0, 0, 0, 0)
+
+#define _ufs_mtk_smc_3(cmd, res, v1, v2, v3) \
+	_ufs_mtk_smc(cmd, res, v1, v2, v3, 0, 0, 0)
+
+#define _ufs_mtk_smc_4(cmd, res, v1, v2, v3, v4) \
+	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, 0, 0)
+
+#define _ufs_mtk_smc_5(cmd, res, v1, v2, v3, v4, v5) \
+	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, 0)
+
+#define _ufs_mtk_smc_6(cmd, res, v1, v2, v3, v4, v5, v6) \
+	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, v6)
+
+#define _ufs_mtk_smc_selector(cmd, res, v1, v2, v3, v4, v5, v6, FUNC, ...) FUNC
+
+#define ufs_mtk_smc(...) \
+	_ufs_mtk_smc_selector(__VA_ARGS__, \
+	_ufs_mtk_smc_6(__VA_ARGS__), \
+	_ufs_mtk_smc_5(__VA_ARGS__), \
+	_ufs_mtk_smc_4(__VA_ARGS__), \
+	_ufs_mtk_smc_3(__VA_ARGS__), \
+	_ufs_mtk_smc_2(__VA_ARGS__), \
+	_ufs_mtk_smc_1(__VA_ARGS__), \
+	_ufs_mtk_smc_0(__VA_ARGS__) \
+	)
+
+/*
+ * Sip kernel interface
+ */
+#define ufs_mtk_va09_pwr_ctrl(res, on) \
+	ufs_mtk_smc(UFS_MTK_SIP_VA09_PWR_CTRL, res, on)
+
+#define ufs_mtk_crypto_ctrl(res, enable) \
+	ufs_mtk_smc(UFS_MTK_SIP_CRYPTO_CTRL, res, enable)
+
+#define ufs_mtk_ref_clk_notify(on, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_REF_CLK_NOTIFICATION, res, on)
+
+#define ufs_mtk_device_reset_ctrl(high, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, res, high)
+
 #endif /* !_UFS_MEDIATEK_H */
-- 
2.18.0

