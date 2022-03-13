Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E34D75CF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiCMOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCMOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:20:02 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2DD27B14;
        Sun, 13 Mar 2022 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oUw08iIpNlygYly08MUnof6lcGY7VIecIfYGombIoYI=;
  b=aESEUeMXhAHD94xBHKwIkW/ULJB1+YT56YrwSh1/6GtGfkJrZ3/TgGfx
   hOGDQyQQQ/KxyWuaTnT/7HEfOFd8JxMxJX6o9lMgGZfowf2HkGXLSY6yz
   JQxWG2inP7sKNbqc+g+igQf2d3MbouIppRt/Tex33kV7+RYjno6Bq2/VO
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25859617"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 15:18:51 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     James Smart <james.smart@broadcom.com>,
        Joe Perches <joe@perches.com>
Cc:     kernel-janitors@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6 v2] scsi: lpfc: use kcalloc
Date:   Sun, 13 Mar 2022 15:18:47 +0100
Message-Id: <20220313141847.109804-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kcalloc instead of kmalloc + memset.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

v2: Use kcalloc instead of kzalloc

 drivers/scsi/lpfc/lpfc_debugfs.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 30fac2f6fb06..7b24c932e812 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -6272,9 +6272,9 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_slow_ring_trc);
 		if (!phba->slow_ring_trc) {
-			phba->slow_ring_trc = kmalloc(
-				(sizeof(struct lpfc_debugfs_trc) *
-				lpfc_debugfs_max_slow_ring_trc),
+			phba->slow_ring_trc = kcalloc(
+				lpfc_debugfs_max_slow_ring_trc,
+				sizeof(struct lpfc_debugfs_trc),
 				GFP_KERNEL);
 			if (!phba->slow_ring_trc) {
 				lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
@@ -6283,9 +6283,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 				goto debug_failed;
 			}
 			atomic_set(&phba->slow_ring_trc_cnt, 0);
-			memset(phba->slow_ring_trc, 0,
-				(sizeof(struct lpfc_debugfs_trc) *
-				lpfc_debugfs_max_slow_ring_trc));
 		}
 
 		snprintf(name, sizeof(name), "nvmeio_trc");

