Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D985884ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiHBXzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiHBXyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:54:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A879854AE8;
        Tue,  2 Aug 2022 16:54:50 -0700 (PDT)
X-UUID: 85e546883c8448b99df7b62c713ec1a6-20220803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:af080c16-3fc7-4cb8-acb0-24b29a4a02b7,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:a87e1525-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 85e546883c8448b99df7b62c713ec1a6-20220803
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1963949752; Wed, 03 Aug 2022 07:54:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 3 Aug 2022 07:54:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 3 Aug 2022 07:54:45 +0800
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
Subject: [PATCH v5 4/5] scsi: ufs: ufs-mediatek: Fix performance scaling
Date:   Wed, 3 Aug 2022 07:54:36 +0800
Message-ID: <20220802235437.4547-5-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220802235437.4547-1-stanley.chu@mediatek.com>
References: <20220802235437.4547-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Wang <peter.wang@mediatek.com>

If clk-scaling is enabled, performance scaling can be bound
to the decision of clk-scaling to avoid unnecessary boosting.

Meanwhile, fix missing initialization of pm-qos request.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 2b85d2406714..e1f131a93792 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -635,6 +635,12 @@ static void ufs_mtk_boost_pm_qos(struct ufs_hba *hba, bool boost)
 				       boost ? 0 : PM_QOS_DEFAULT_VALUE);
 }
 
+static void ufs_mtk_scale_perf(struct ufs_hba *hba, bool scale_up)
+{
+	ufs_mtk_boost_crypt(hba, scale_up);
+	ufs_mtk_boost_pm_qos(hba, scale_up);
+}
+
 static void ufs_mtk_pwr_ctrl(struct ufs_hba *hba, bool on)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
@@ -642,11 +648,11 @@ static void ufs_mtk_pwr_ctrl(struct ufs_hba *hba, bool on)
 	if (on) {
 		phy_power_on(host->mphy);
 		ufs_mtk_setup_ref_clk(hba, on);
-		ufs_mtk_boost_crypt(hba, on);
-		ufs_mtk_boost_pm_qos(hba, on);
+		if (!ufshcd_is_clkscaling_supported(hba))
+			ufs_mtk_scale_perf(hba, on);
 	} else {
-		ufs_mtk_boost_pm_qos(hba, on);
-		ufs_mtk_boost_crypt(hba, on);
+		if (!ufshcd_is_clkscaling_supported(hba))
+			ufs_mtk_scale_perf(hba, on);
 		ufs_mtk_setup_ref_clk(hba, on);
 		phy_power_off(host->mphy);
 	}
@@ -870,6 +876,10 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
 	host->ip_ver = ufshcd_readl(hba, REG_UFS_MTK_IP_VER);
 
+	/* Initialize pm-qos request */
+	cpu_latency_qos_add_request(&host->pm_qos_req, PM_QOS_DEFAULT_VALUE);
+	host->pm_qos_init = true;
+
 	goto out;
 
 out_variant_clear:
-- 
2.18.0

