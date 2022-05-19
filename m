Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59652CBC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiESGIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiESGII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:08:08 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96825819AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:08:05 -0700 (PDT)
Received: from epcas3p1.samsung.com (unknown [182.195.41.19])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220519060803epoutp02f4ee23128855bfc881bfa241fabf153f~wbJyWcceF1530615306epoutp02-
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220519060803epoutp02f4ee23128855bfc881bfa241fabf153f~wbJyWcceF1530615306epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652940483;
        bh=08kcVObZMGmflDkwaR63MNwsdaqkDNUIB29kvNBTLfM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=PPbSvpbxPThGILT+rYKvUtcP5Mq/EeoWaqY/hxzR6GQ4rsJMk2Oz9rVOdCqffpapj
         15jvKlhBjmvuXAVAd1chNFVJtPnlSDQtoUomzyXmoF4p1TnWs0LaU8cNV+bCrkav2i
         RcRnjqUTZlrVgwTyDq66444dV9asWFRGAGO0AQDM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20220519060802epcas3p379ab0aab40cd2d5992e0b9c514f71576~wbJyCC73H1166711667epcas3p3-;
        Thu, 19 May 2022 06:08:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4L3fXy4kMCz4x9QB; Thu, 19 May 2022 06:08:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: Fix referencing invalid rsp field
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
Date:   Thu, 19 May 2022 15:05:29 +0900
X-CMS-MailID: 20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612
References: <CGME20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612@epcms2p8>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for fixing referencing sense data when it is invalid.
When the length of the data segment is 0, there is no valid information in
the rsp field, so ufshpb_rsp_upiu() is returned without additional
operation.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 drivers/scsi/ufs/ufshpb.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index f1f65383e97d..8882b47f76d3 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -1304,6 +1304,13 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	struct utp_hpb_rsp *rsp_field = &lrbp->ucd_rsp_ptr->hr;
 	int data_seg_len;
 
+	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
+		& MASK_RSP_UPIU_DATA_SEG_LEN;
+
+	/* If data segment length is zero, rsp_field is not valid */
+	if (!data_seg_len)
+		return;
+
 	if (unlikely(lrbp->lun != rsp_field->lun)) {
 		struct scsi_device *sdev;
 		bool found = false;
@@ -1338,18 +1345,6 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		return;
 	}
 
-	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
-		& MASK_RSP_UPIU_DATA_SEG_LEN;
-
-	/* To flush remained rsp_list, we queue the map_work task */
-	if (!data_seg_len) {
-		if (!ufshpb_is_general_lun(hpb->lun))
-			return;
-
-		ufshpb_kick_map_work(hpb);
-		return;
-	}
-
 	BUILD_BUG_ON(sizeof(struct utp_hpb_rsp) != UTP_HPB_RSP_SIZE);
 
 	if (!ufshpb_is_hpb_rsp_valid(hba, lrbp, rsp_field))
-- 
2.25.1


