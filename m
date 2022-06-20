Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D985518D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiFTM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbiFTM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:26:14 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5217A9F;
        Mon, 20 Jun 2022 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655727972; x=1687263972;
  h=from:to:cc:subject:date:message-id;
  bh=7dMi0VSxEF25HQUGoDLHHZiqB64+Uo3ECtSt/tonNIc=;
  b=Wa8f/QOHl6/qO84nUSaLcRRbQK1VESGd/eCQcskYi09gzDv2bSL27gy/
   OEfRcRKPdDodd4VO09MnimJfdoeBzoTvdGMyDcWYDI0wclfm5Ceq/Rk2n
   2zDfGVXA5pDRNMBCFoYtHfj7bJbomeFACX/Bpp7KCa4gcQY6AJ7LnHS6g
   1yQzO9jFEfst4CQ3DRcOyII6RLhS583xLWl+wYzT3/iN/zPfT8YP7karT
   4UTt+9+XhGjDL7LmJRLmy/xrExUsaU07EukwOEMh6E4ccyebnLaV6UwS+
   TGQtNHL4CQSfQPWGOWJqzFVLvqEvuGV+eAfvarpK1S/J5r02VdGvmhU7u
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208482930"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 20:26:11 +0800
IronPort-SDR: SSnpdvgb3S51Is0/+vIW9HK/H6YyCmDiBU8W//FJI9IbYa8+pEVsjSVkHYGz5pVyFz5QHnNuWa
 rJQOTIbRpoPdmfz55Q3pZOckPeRPfkP93Ra1u6FblS9XGx0+s5yUlMy3Tm54aU64F7leFN6R3B
 y7vztXH6c8H/oPnePe1B5Koklmc53WLSbBNBDHhLIJa2m0MFulcyo5RMW9PDUeQvNkq5zhHtwq
 fl4TprEjephoY+lp/O3VCe9Lpellu/ZcYytmscFkttMGNhGO4r/yQeaVK2dfbQnlJXZKkGPxqw
 sPhi1ts+FQlbACQqcw9C0TBq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 04:48:43 -0700
IronPort-SDR: gOHrNyTLB1Q2JcXE3fbb+uMwK4jheduZjWDMh+IhxiaaVP3yvPp9DSVUzLQxb0H9BZEAAcYeEX
 TpUyZ3G0FedEG5Cw4w1UQEZGJsUKC5jPlA4DbxKHT1RfNcCBqCjCcD2w1ZpeSBagydZsK4LjB4
 A5ScgfzOs3t3YGT8NzQ/g9EW3f9VsXG7srkIYNL1jzr20+URMa7JGT+xQqP8tlOFj3IBLGUJvi
 /juigmHhrkk4bE8KS+kB2eW1Ll6huiPR7kIB5bEfOffnidYASM96Tj7SVjBFzQpHgRt4m7A1rZ
 YlQ=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jun 2022 05:26:09 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     James@vger.kernel.org, E.J.Bottomley@vger.kernel.org,
        jejb@linux.vnet.ibm.com, Martin@vger.kernel.org,
        K.Petersen@vger.kernel.org, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean@vger.kernel.org, Huo@vger.kernel.org, beanhuo@micron.com,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size function
Date:   Mon, 20 Jun 2022 15:26:06 +0300
Message-Id: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bsg driver allows user space to send device management commands.
As such, it is often used by field application engineers to debug various problems,
and as a test bed for new features as well.

Let's not bound ourself to hard coded descriptor sizes, as the new
Descriptors that supports new features are not defined yet.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/scsi/ufs/ufs_bsg.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 39bf204..7c56eba 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -6,24 +6,6 @@
  */
 #include "ufs_bsg.h"
 
-static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
-				       struct utp_upiu_query *qr)
-{
-	int desc_size = be16_to_cpu(qr->length);
-	int desc_id = qr->idn;
-
-	if (desc_size <= 0)
-		return -EINVAL;
-
-	ufshcd_map_desc_id_to_length(hba, desc_id, desc_len);
-	if (!*desc_len)
-		return -EINVAL;
-
-	*desc_len = min_t(int, *desc_len, desc_size);
-
-	return 0;
-}
-
 static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
 				     unsigned int request_len,
 				     unsigned int reply_len)
@@ -52,13 +34,11 @@ static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job *job,
 		goto out;
 
 	qr = &bsg_request->upiu_req.qr;
-	if (ufs_bsg_get_query_desc_size(hba, desc_len, qr)) {
-		dev_err(hba->dev, "Illegal desc size\n");
-		return -EINVAL;
-	}
+	*desc_len = be16_to_cpu(qr->length);
 
-	if (*desc_len > job->request_payload.payload_len) {
-		dev_err(hba->dev, "Illegal desc size\n");
+	if (*desc_len <= 0 || *desc_len > QUERY_DESC_MAX_SIZE ||
+	    *desc_len > job->request_payload.payload_len) {
+		dev_err(hba->dev, "Illegal desc size %d\n", *desc_len);
 		return -EINVAL;
 	}
 
-- 
2.7.4

