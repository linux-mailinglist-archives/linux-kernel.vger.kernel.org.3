Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0869E587DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiHBNzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiHBNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:55:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A625E8E;
        Tue,  2 Aug 2022 06:55:02 -0700 (PDT)
X-UUID: 893876ca688a4710ab94eba443991586-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0e928615-eb22-437d-a8df-76cfdbf7f9ac,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:0e928615-eb22-437d-a8df-76cfdbf7f9ac,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:316006d1-841b-4e95-ad42-8f86e18f54fc,C
        OID:0d121fdfd654,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 893876ca688a4710ab94eba443991586-20220802
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 194313668; Tue, 02 Aug 2022 21:54:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 21:54:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Aug 2022 21:54:55 +0800
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
Subject: [PATCH v4 2/5] scsi: ufs: ufs-mediatek: Provide detailed description for UIC errors
Date:   Tue, 2 Aug 2022 21:54:20 +0800
Message-ID: <20220802135423.1007-3-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220802135423.1007-1-stanley.chu@mediatek.com>
References: <20220802135423.1007-1-stanley.chu@mediatek.com>
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
index ff6fd8f52ebc..62bc3b791b38 100644
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
+	u8 bit;
 
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

