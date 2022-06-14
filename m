Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8011D54B2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiFNORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbiFNORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D19F33A0A;
        Tue, 14 Jun 2022 07:17:08 -0700 (PDT)
X-UUID: c5dc939ae53e4d038d2f9752a91acaea-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:aa14c2e9-3569-4971-be8a-9616760e2ce2,OB:20,L
        OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:aa14c2e9-3569-4971-be8a-9616760e2ce2,OB:20,LOB
        :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:46766cc5-c67b-4a73-9b18-726dd8f2eb58,C
        OID:2e28f976cb89,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c5dc939ae53e4d038d2f9752a91acaea-20220614
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 405432962; Tue, 14 Jun 2022 22:16:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Jun 2022 22:16:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 22:16:56 +0800
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
Subject: [PATCH v3 01/10] scsi: ufs: Export ufshcd_uic_change_pwr_mode()
Date:   Tue, 14 Jun 2022 22:16:46 +0800
Message-ID: <20220614141655.14409-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614141655.14409-1-stanley.chu@mediatek.com>
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
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

Export ufshcd_uic_change_pwr_mode() to allow vendors to
use it for SoC-specific power mode change design limitation.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 include/ufs/ufshcd.h      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 936a6d5467c9..19e17c898319 100755
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4091,7 +4091,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
  *
  * Returns 0 on success, non-zero value on failure
  */
-static int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
+int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 {
 	struct uic_command uic_cmd = {0};
 	int ret;
@@ -4116,6 +4116,7 @@ static int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_uic_change_pwr_mode);
 
 int ufshcd_link_recovery(struct ufs_hba *hba)
 {
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a92271421718..aa778418703f 100755
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1087,6 +1087,7 @@ extern int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			       u32 *mib_val, u8 peer);
 extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 			struct ufs_pa_layer_attr *desired_pwr_mode);
+extern int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
-- 
2.18.0

