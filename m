Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98674584D01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiG2Hzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG2Hzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:55:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DDC2D1F4;
        Fri, 29 Jul 2022 00:55:30 -0700 (PDT)
X-UUID: 4c0975a4053b4d99b8e60b74514fb5d8-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:5630dc57-9195-4a3e-9daf-c264d9961ceb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:d8f6b524-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4c0975a4053b4d99b8e60b74514fb5d8-20220729
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 885014646; Fri, 29 Jul 2022 15:55:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 15:55:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jul 2022 15:55:20 +0800
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
Subject: [PATCH v1] scsi: ufs: Fix ufshcd_scale_clks decision in recovery flow
Date:   Fri, 29 Jul 2022 15:55:19 +0800
Message-ID: <20220729075519.4665-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When someone toggles clk-scaling feature via sysfs interface,
the flag "hba->clk_scaling.is_enabled" shall be changed after
ufshcd_devfreq_scale() is finished.

By this change, we can use this flag to make right decision for
invoking ufshcd_scale_clks() in host recovery flow, i.e., in
ufshcd_host_reset_and_restore().

ufshcd_scale_clks() shall be invoked only if both conditions
are satisfied,

1. Clk-scaling is supported, and
2. Clk-scaling is enabled

Otherwise, the clk and gear which would be scaled by
ufshcd_scale_clks() shall be already in the default state
so the scaling is not required anymore.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 581d88af07ab..dc57a7988023 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1574,8 +1574,6 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 	ufshcd_rpm_get_sync(hba);
 	ufshcd_hold(hba, false);
 
-	hba->clk_scaling.is_enabled = value;
-
 	if (value) {
 		ufshcd_resume_clkscaling(hba);
 	} else {
@@ -1586,6 +1584,8 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 					__func__, err);
 	}
 
+	hba->clk_scaling.is_enabled = value;
+
 	ufshcd_release(hba);
 	ufshcd_rpm_put_sync(hba);
 out:
@@ -7259,7 +7259,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
+	if (ufshcd_is_clkscaling_supported(hba) && hba->clk_scaling.is_enabled)
+		ufshcd_scale_clks(hba, true);
 
 	err = ufshcd_hba_enable(hba);
 
-- 
2.18.0

