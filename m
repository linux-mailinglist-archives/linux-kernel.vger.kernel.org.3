Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970FB5836E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiG1C3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiG1C2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:28:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22515925B;
        Wed, 27 Jul 2022 19:28:40 -0700 (PDT)
X-UUID: d78be424955e4a73986028aecdea8610-20220728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1a8c5091-7276-47e7-85f6-569b3921000a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:1a8c5091-7276-47e7-85f6-569b3921000a,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:ffbf1836-fd9a-435f-8e8b-e247f150d0a2,C
        OID:b3b2d735b6a3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d78be424955e4a73986028aecdea8610-20220728
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1628196119; Thu, 28 Jul 2022 10:28:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 28 Jul 2022 10:28:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 28 Jul 2022 10:28:35 +0800
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
Subject: [PATCH v3 2/5] scsi: ufs: ufs-mediatek: Provide detailed description for UIC errors
Date:   Thu, 28 Jul 2022 10:28:30 +0800
Message-ID: <20220728022833.16243-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220728022833.16243-1-stanley.chu@mediatek.com>
References: <20220728022833.16243-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide detailed description in logs for UIC errors for
eaiser issue breakdown.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index ff6fd8f52ebc..572fafa069a4 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -46,6 +46,44 @@ static const struct of_device_id ufs_mtk_of_match[] = {
 	{},
 };
 
+/*
+ * Details of UIC Errors
+ */
+static const char *const ufs_uic_err_str[] = {
+	"PHY Adapter Layer",
+	"Data Link Layer",
+	"Network Link Layer",
+	"Transport Link Layer",
+	"DME"
+};
+
+static const char *const ufs_uic_pa_err_str[] = {
+	"PHY error on Lane 0",
+	"PHY error on Lane 1",
+	"PHY error on Lane 2",
+	"PHY error on Lane 3",
+	"Generic PHY Adapter Error. This should be the LINERESET indication"
+};
+
+static const char *const ufs_uic_dl_err_str[] = {
+	"NAC_RECEIVED",
+	"TCx_REPLAY_TIMER_EXPIRED",
+	"AFCx_REQUEST_TIMER_EXPIRED",
+	"FCx_PROTECTION_TIMER_EXPIRED",
+	"CRC_ERROR",
+	"RX_BUFFER_OVERFLOW",
+	"MAX_FRAME_LENGTH_EXCEEDED",
+	"WRONG_SEQUENCE_NUMBER",
+	"AFC_FRAME_SYNTAX_ERROR",
+	"NAC_FRAME_SYNTAX_ERROR",
+	"EOF_SYNTAX_ERROR",
+	"FRAME_SYNTAX_ERROR",
+	"BAD_CTRL_SYMBOL_TYPE",
+	"PA_INIT_ERROR",
+	"PA_ERROR_IND_RECEIVED",
+	"PA_INIT"
+};
+
 static bool ufs_mtk_is_boost_crypt_enabled(struct ufs_hba *hba)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
@@ -1309,8 +1347,28 @@ static void ufs_mtk_event_notify(struct ufs_hba *hba,
 				 enum ufs_event_type evt, void *data)
 {
 	unsigned int val = *(u32 *)data;
+	unsigned long reg;
+	int bit;
 
 	trace_ufs_mtk_event(evt, val);
+
+	/* Print details of UIC Errors */
+	if (evt <= UFS_EVT_DME_ERR) {
+		dev_info(hba->dev,
+			 "Host UIC Error Code (%s): %08x\n",
+			 ufs_uic_err_str[evt], val);
+		reg = val;
+	}
+
+	if (evt == UFS_EVT_PA_ERR) {
+		for_each_set_bit(bit, &reg, ARRAY_SIZE(ufs_uic_pa_err_str))
+			dev_info(hba->dev, "%s\n", ufs_uic_pa_err_str[bit]);
+	}
+
+	if (evt == UFS_EVT_DL_ERR) {
+		for_each_set_bit(bit, &reg, ARRAY_SIZE(ufs_uic_dl_err_str))
+			dev_info(hba->dev, "%s\n", ufs_uic_dl_err_str[bit]);
+	}
 }
 
 /*
-- 
2.18.0

