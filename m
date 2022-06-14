Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0554B2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbiFNORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243290AbiFNORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D82F3BE;
        Tue, 14 Jun 2022 07:17:06 -0700 (PDT)
X-UUID: 11ddc7d4789642d7a3bb81cf04fc21bc-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b821cd78-0b8e-4faa-b204-eea377ee563a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:1f8d9407-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 11ddc7d4789642d7a3bb81cf04fc21bc-20220614
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 646176408; Tue, 14 Jun 2022 22:16:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Jun 2022 22:16:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 22:16:57 +0800
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
Subject: [PATCH v3 09/10] scsi: ufs: Export regulator functions
Date:   Tue, 14 Jun 2022 22:16:54 +0800
Message-ID: <20220614141655.14409-10-stanley.chu@mediatek.com>
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

Export below regulator functions to allow vendors to
customize regulator configuration in their own platforms.

int ufshcd_populate_vreg(struct device *dev, const char *name,
                         struct ufs_vreg **out_vreg);
int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg);

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c        | 3 ++-
 drivers/ufs/host/ufshcd-pltfrm.c | 3 ++-
 drivers/ufs/host/ufshcd-pltfrm.h | 2 ++
 include/ufs/ufshcd.h             | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0d16739c67bb..8131a75e41e5 100755
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8408,7 +8408,7 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on)
 	return ufshcd_toggle_vreg(hba->dev, info->vdd_hba, on);
 }
 
-static int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg)
+int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg)
 {
 	int ret = 0;
 
@@ -8424,6 +8424,7 @@ static int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ufshcd_get_vreg);
 
 static int ufshcd_init_vreg(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index e7332cc65b1f..332f66828d80 100755
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -109,7 +109,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 }
 
 #define MAX_PROP_SIZE 32
-static int ufshcd_populate_vreg(struct device *dev, const char *name,
+int ufshcd_populate_vreg(struct device *dev, const char *name,
 		struct ufs_vreg **out_vreg)
 {
 	char prop_name[MAX_PROP_SIZE];
@@ -145,6 +145,7 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 	*out_vreg = vreg;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ufshcd_populate_vreg);
 
 /**
  * ufshcd_parse_regulator_info - get regulator info from device tree
diff --git a/drivers/ufs/host/ufshcd-pltfrm.h b/drivers/ufs/host/ufshcd-pltfrm.h
index 43c2e412bd99..5130c9471dc2 100755
--- a/drivers/ufs/host/ufshcd-pltfrm.h
+++ b/drivers/ufs/host/ufshcd-pltfrm.h
@@ -32,5 +32,7 @@ void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param);
 int ufshcd_pltfrm_init(struct platform_device *pdev,
 		       const struct ufs_hba_variant_ops *vops);
 void ufshcd_pltfrm_shutdown(struct platform_device *pdev);
+int ufshcd_populate_vreg(struct device *dev, const char *name,
+			 struct ufs_vreg **out_vreg);
 
 #endif /* UFSHCD_PLTFRM_H_ */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index aa778418703f..18eb253cfd91 100755
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1187,6 +1187,8 @@ void ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 
 u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba);
 
+int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg);
+
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd);
 
 int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
-- 
2.18.0

