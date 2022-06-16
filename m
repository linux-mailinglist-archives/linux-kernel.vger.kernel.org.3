Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4B54D9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358874AbiFPFiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358720AbiFPFhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:37:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DAE5838F;
        Wed, 15 Jun 2022 22:37:40 -0700 (PDT)
X-UUID: 6ceafa1d88b94203b86dc0ae5105633d-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:edd4c073-8594-4c57-8fdc-3d47f83e6b1f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:c45b6ff6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 6ceafa1d88b94203b86dc0ae5105633d-20220616
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 484333221; Thu, 16 Jun 2022 13:37:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 13:37:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 13:37:26 +0800
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
        <stanley.chu@mediatek.com>, Peter Wang <peter.want@medaitek.com>
Subject: [PATCH v5 03/11] scsi: ufs-mediatek: Introduce workaround for power mode change
Date:   Thu, 16 Jun 2022 13:37:17 +0800
Message-ID: <20220616053725.5681-4-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220616053725.5681-1-stanley.chu@mediatek.com>
References: <20220616053725.5681-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CC Chou <cc.chou@mediatek.com>

Some MediaTek SoC chips need special flow for power mode change,
especially for chips supporting HS-G5.

Enable the workaround by setting the host-specific capability.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: CC Chou <cc.chou@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
Signed-off-by: Dennis Yu <tun-yu.yu@mediatek.com>
Signed-off-by: Peter Wang <peter.want@medaitek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 60 +++++++++++++++++++++++++++++++--
 drivers/ufs/host/ufs-mediatek.h |  1 +
 include/ufs/unipro.h            |  1 +
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index beabc3ccd30b..2931fd21e38a 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -82,6 +82,13 @@ static bool ufs_mtk_is_broken_vcc(struct ufs_hba *hba)
 	return !!(host->caps & UFS_MTK_CAP_BROKEN_VCC);
 }
 
+static bool ufs_mtk_is_pmc_via_fastauto(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+
+	return (host->caps & UFS_MTK_CAP_PMC_VIA_FASTAUTO);
+}
+
 static void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
 {
 	u32 tmp;
@@ -579,6 +586,9 @@ static void ufs_mtk_init_host_caps(struct ufs_hba *hba)
 	if (of_property_read_bool(np, "mediatek,ufs-broken-vcc"))
 		host->caps |= UFS_MTK_CAP_BROKEN_VCC;
 
+	if (of_property_read_bool(np, "mediatek,ufs-pmc-via-fastauto"))
+		host->caps |= UFS_MTK_CAP_PMC_VIA_FASTAUTO;
+
 	dev_info(hba->dev, "caps: 0x%x", host->caps);
 }
 
@@ -754,6 +764,26 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 	return err;
 }
 
+static bool ufs_mtk_pmc_via_fastauto(struct ufs_hba *hba,
+				     struct ufs_pa_layer_attr *dev_req_params)
+{
+	if (!ufs_mtk_is_pmc_via_fastauto(hba))
+		return false;
+
+	if (dev_req_params->hs_rate == hba->pwr_info.hs_rate)
+		return false;
+
+	if (dev_req_params->pwr_tx != FAST_MODE &&
+	    dev_req_params->gear_tx < UFS_HS_G4)
+		return false;
+
+	if (dev_req_params->pwr_rx != FAST_MODE &&
+	    dev_req_params->gear_rx < UFS_HS_G4)
+		return false;
+
+	return true;
+}
+
 static int ufs_mtk_pre_pwr_change(struct ufs_hba *hba,
 				  struct ufs_pa_layer_attr *dev_max_params,
 				  struct ufs_pa_layer_attr *dev_req_params)
@@ -763,8 +793,8 @@ static int ufs_mtk_pre_pwr_change(struct ufs_hba *hba,
 	int ret;
 
 	ufshcd_init_pwr_dev_param(&host_cap);
-	host_cap.hs_rx_gear = UFS_HS_G4;
-	host_cap.hs_tx_gear = UFS_HS_G4;
+	host_cap.hs_rx_gear = UFS_HS_G5;
+	host_cap.hs_tx_gear = UFS_HS_G5;
 
 	ret = ufshcd_get_pwr_dev_param(&host_cap,
 				       dev_max_params,
@@ -774,6 +804,32 @@ static int ufs_mtk_pre_pwr_change(struct ufs_hba *hba,
 			__func__);
 	}
 
+	if (ufs_mtk_pmc_via_fastauto(hba, dev_req_params)) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXTERMINATION), true);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXGEAR), UFS_HS_G1);
+
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_RXTERMINATION), true);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_RXGEAR), UFS_HS_G1);
+
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_ACTIVETXDATALANES),
+			       dev_req_params->lane_tx);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_ACTIVERXDATALANES),
+			       dev_req_params->lane_rx);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HSSERIES),
+			       dev_req_params->hs_rate);
+
+		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXHSADAPTTYPE),
+			       PA_NO_ADAPT);
+
+		ret = ufshcd_uic_change_pwr_mode(hba,
+					FASTAUTO_MODE << 4 | FASTAUTO_MODE);
+
+		if (ret) {
+			dev_err(hba->dev, "%s: HSG1B FASTAUTO failed ret=%d\n",
+				__func__, ret);
+		}
+	}
+
 	if (host->hw_ver.major >= 3) {
 		ret = ufshcd_dme_configure_adapt(hba,
 					   dev_req_params->gear_tx,
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index 414dca86c09f..7e1913769671 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -108,6 +108,7 @@ enum ufs_mtk_host_caps {
 	UFS_MTK_CAP_VA09_PWR_CTRL              = 1 << 1,
 	UFS_MTK_CAP_DISABLE_AH8                = 1 << 2,
 	UFS_MTK_CAP_BROKEN_VCC                 = 1 << 3,
+	UFS_MTK_CAP_PMC_VIA_FASTAUTO           = 1 << 6,
 };
 
 struct ufs_mtk_crypt_cfg {
diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index 0521f887e3ac..4b13fbf8ee18 100755
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -229,6 +229,7 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G2,		/* HS Gear 2 */
 	UFS_HS_G3,		/* HS Gear 3 */
 	UFS_HS_G4,		/* HS Gear 4 */
+	UFS_HS_G5		/* HS Gear 5 */
 };
 
 enum ufs_unipro_ver {
-- 
2.18.0

