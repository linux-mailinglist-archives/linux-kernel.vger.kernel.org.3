Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741E54D9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358798AbiFPFhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358707AbiFPFhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:37:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1892251A;
        Wed, 15 Jun 2022 22:37:37 -0700 (PDT)
X-UUID: 945be648b0884f6982eda365b7d33570-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:cd077dae-ee09-4591-93de-bddda7f36d43,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:5aaeb248-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 945be648b0884f6982eda365b7d33570-20220616
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 506156841; Thu, 16 Jun 2022 13:37:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 13:37:27 +0800
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
Subject: [PATCH v5 07/11] scsi: ufs-mediatek: Support flexible parameters for smc calls
Date:   Thu, 16 Jun 2022 13:37:21 +0800
Message-ID: <20220616053725.5681-8-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220616053725.5681-1-stanley.chu@mediatek.com>
References: <20220616053725.5681-1-stanley.chu@mediatek.com>
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

Provide flexible number of parameters for UFS SMC calls to be
easily used for future SMC usages.

This is a preparation patch for the next patch.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 16 --------------
 drivers/ufs/host/ufs-mediatek.h | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 65a2a4185ef6..9c5d1213c290 100755
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
index 7e1913769671..bf6ca96cafb6 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -143,4 +143,43 @@ struct ufs_mtk_host {
 	u32 ip_ver;
 };
 
+/*
+ * SMC call wrapper function
+ */
+struct ufs_mtk_smc_arg {
+	unsigned long cmd;
+	struct arm_smccc_res *res;
+	unsigned long v1;
+	unsigned long v2;
+	unsigned long v3;
+	unsigned long v4;
+	unsigned long v5;
+	unsigned long v6;
+	unsigned long v7;
+};
+
+static void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
+{
+	arm_smccc_smc(MTK_SIP_UFS_CONTROL,
+		      s.cmd, s.v1, s.v2, s.v3, s.v4, s.v5, s.v6, s.res);
+}
+
+#define ufs_mtk_smc(...) \
+	_ufs_mtk_smc((struct ufs_mtk_smc_arg) {__VA_ARGS__})
+
+/*
+ * SMC call interface
+ */
+#define ufs_mtk_va09_pwr_ctrl(res, on) \
+	ufs_mtk_smc(UFS_MTK_SIP_VA09_PWR_CTRL, &(res), on)
+
+#define ufs_mtk_crypto_ctrl(res, enable) \
+	ufs_mtk_smc(UFS_MTK_SIP_CRYPTO_CTRL, &(res), enable)
+
+#define ufs_mtk_ref_clk_notify(on, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_REF_CLK_NOTIFICATION, &(res), on)
+
+#define ufs_mtk_device_reset_ctrl(high, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, &(res), high)
+
 #endif /* !_UFS_MEDIATEK_H */
-- 
2.18.0

