Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EE4FDAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389826AbiDLJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352957AbiDLIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:03:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BF4580D3;
        Tue, 12 Apr 2022 00:35:48 -0700 (PDT)
X-UUID: 7cba71d56fb7494cb4f3d71a18242d68-20220412
X-UUID: 7cba71d56fb7494cb4f3d71a18242d68-20220412
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 307447765; Tue, 12 Apr 2022 15:35:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 12 Apr 2022 15:35:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 15:35:37 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <huobean@gmail.com>,
        <yohan.joung@sk.com>, <jason.li@sk.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
Date:   Tue, 12 Apr 2022 15:31:28 +0800
Message-ID: <20220412073131.10644-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the HPB mapping is already reset in ufshpb_init by setting
flag QUERY_FLAG_IDN_HPB_RESET, there is no need doing so again in
ufshpb_hpb_lu_prepared.

This would also resolve the issue where HPB WRTIE BUFFER is issued
before UAC being cleared.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/scsi/ufs/ufshpb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index a86d0cc50de2..5c09d44c4bd5 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -934,11 +934,6 @@ static int ufshpb_issue_umap_single_req(struct ufshpb_lu *hpb,
 	return ufshpb_issue_umap_req(hpb, rgn, true);
 }
 
-static int ufshpb_issue_umap_all_req(struct ufshpb_lu *hpb)
-{
-	return ufshpb_issue_umap_req(hpb, NULL, false);
-}
-
 static void __ufshpb_evict_region(struct ufshpb_lu *hpb,
 				 struct ufshpb_region *rgn)
 {
@@ -2459,8 +2454,6 @@ static void ufshpb_hpb_lu_prepared(struct ufs_hba *hba)
 			ufshpb_set_state(hpb, HPB_PRESENT);
 			if ((hpb->lu_pinned_end - hpb->lu_pinned_start) > 0)
 				queue_work(ufshpb_wq, &hpb->map_work);
-			if (!hpb->is_hcm)
-				ufshpb_issue_umap_all_req(hpb);
 		} else {
 			dev_err(hba->dev, "destroy HPB lu %d\n", hpb->lun);
 			ufshpb_destroy_lu(hba, sdev);
-- 
2.18.0

