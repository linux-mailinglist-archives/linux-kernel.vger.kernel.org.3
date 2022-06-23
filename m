Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208E05571D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiFWEmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiFWDvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:51:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7013E5FD;
        Wed, 22 Jun 2022 20:51:03 -0700 (PDT)
X-UUID: 8605db21ed5b4b0c9e540786b06d053a-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:336c56d7-6a73-424c-9d4b-cff73a00d4cb,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:a43ed02d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 8605db21ed5b4b0c9e540786b06d053a-20220623
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1802570432; Thu, 23 Jun 2022 11:50:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 23 Jun 2022 11:50:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jun 2022 11:50:54 +0800
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
Subject: [PATCH v2 4/8] scsi: ufs-mediatek: Add stage information for ref-clk control
Date:   Thu, 23 Jun 2022 11:50:48 +0800
Message-ID: <20220623035052.18802-5-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220623035052.18802-1-stanley.chu@mediatek.com>
References: <20220623035052.18802-1-stanley.chu@mediatek.com>
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

Add "PRE_CHANGE" and "POST_CHANGE" information for
ref-clk control to precisely configure the low-power
state of the parent of ref-clk.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 9 +++++----
 drivers/ufs/host/ufs-mediatek.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index d6b2734e7f81..8184e871ff8e 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -244,8 +244,9 @@ static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
 	if (host->ref_clk_enabled == on)
 		return 0;
 
+	ufs_mtk_ref_clk_notify(on, PRE_CHANGE, res);
+
 	if (on) {
-		ufs_mtk_ref_clk_notify(on, res);
 		ufshcd_writel(hba, REFCLK_REQUEST, REG_UFS_REFCLK_CTRL);
 	} else {
 		ufshcd_delay_us(host->ref_clk_gating_wait_us, 10);
@@ -267,7 +268,7 @@ static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
 
 	dev_err(hba->dev, "missing ack of refclk req, reg: 0x%x\n", value);
 
-	ufs_mtk_ref_clk_notify(host->ref_clk_enabled, res);
+	ufs_mtk_ref_clk_notify(host->ref_clk_enabled, POST_CHANGE, res);
 
 	return -ETIMEDOUT;
 
@@ -275,8 +276,8 @@ static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
 	host->ref_clk_enabled = on;
 	if (on)
 		ufshcd_delay_us(host->ref_clk_ungating_wait_us, 10);
-	else
-		ufs_mtk_ref_clk_notify(on, res);
+
+	ufs_mtk_ref_clk_notify(on, POST_CHANGE, res);
 
 	return 0;
 }
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index f5c1c643dd52..c12ceb4d941f 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -189,8 +189,8 @@ static void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
 #define ufs_mtk_crypto_ctrl(res, enable) \
 	ufs_mtk_smc(UFS_MTK_SIP_CRYPTO_CTRL, &(res), enable)
 
-#define ufs_mtk_ref_clk_notify(on, res) \
-	ufs_mtk_smc(UFS_MTK_SIP_REF_CLK_NOTIFICATION, &(res), on)
+#define ufs_mtk_ref_clk_notify(on, stage, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_REF_CLK_NOTIFICATION, &(res), on, stage)
 
 #define ufs_mtk_device_reset_ctrl(high, res) \
 	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, &(res), high)
-- 
2.18.0

