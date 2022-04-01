Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF444EDBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiCaOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbiCaOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:40:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9879927CD7;
        Thu, 31 Mar 2022 07:38:50 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KTm6B5Gg7zBrdT;
        Thu, 31 Mar 2022 22:34:42 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 22:38:47 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 31 Mar
 2022 22:38:46 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH] scsi: core: always finish successfully aborted notry command
Date:   Thu, 31 Mar 2022 23:50:20 -0400
Message-ID: <20220401035020.1043239-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the abort command succeed and it does not need to be retired, do not add
it to error handle list. 

Adding command to error handle list is an annoying flow which would stop I/O
of all LUNs which shared a same HBA.

So here if we successfully abort a command, we can finish it via
scsi_finish_command() which would reduce time spent on scsi_error_handler()

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_error.c | 55 +++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index cdaca13ac1f1..15299603b7ee 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -173,41 +173,44 @@ scmd_eh_abort_handler(struct work_struct *work)
 		goto out;
 	}
 	set_host_byte(scmd, DID_TIME_OUT);
-	if (scsi_host_eh_past_deadline(shost)) {
-		SCSI_LOG_ERROR_RECOVERY(3,
-			scmd_printk(KERN_INFO, scmd,
-				    "eh timeout, not retrying "
-				    "aborted command\n"));
-		goto out;
-	}
 
-	spin_lock_irqsave(shost->host_lock, flags);
-	list_del_init(&scmd->eh_entry);
+	if (scsi_noretry_cmd(scmd) ||
+	    !scsi_cmd_retry_allowed(scmd) &&
+	    !scsi_eh_should_retry_cmd(scmd)) {
+		spin_lock_irqsave(shost->host_lock, flags);
+		list_del_init(&scmd->eh_entry);
 
-	/*
-	 * If the abort succeeds, and there is no further
-	 * EH action, clear the ->last_reset time.
-	 */
-	if (list_empty(&shost->eh_abort_list) &&
-	    list_empty(&shost->eh_cmd_q))
-		if (shost->eh_deadline != -1)
-			shost->last_reset = 0;
+		/*
+		 * If the abort succeeds, and there is no further
+		 * EH action, clear the ->last_reset time.
+		 */
+		if (list_empty(&shost->eh_abort_list) &&
+		    list_empty(&shost->eh_cmd_q))
+			if (shost->eh_deadline != -1)
+				shost->last_reset = 0;
 
-	spin_unlock_irqrestore(shost->host_lock, flags);
+		spin_unlock_irqrestore(shost->host_lock, flags);
 
-	if (!scsi_noretry_cmd(scmd) &&
-	    scsi_cmd_retry_allowed(scmd) &&
-	    scsi_eh_should_retry_cmd(scmd)) {
-		SCSI_LOG_ERROR_RECOVERY(3,
-			scmd_printk(KERN_WARNING, scmd,
-				    "retry aborted command\n"));
-		scsi_queue_insert(scmd, SCSI_MLQUEUE_EH_RETRY);
-	} else {
 		SCSI_LOG_ERROR_RECOVERY(3,
 			scmd_printk(KERN_WARNING, scmd,
 				    "finish aborted command\n"));
 		scsi_finish_command(scmd);
+		return;
 	}
+
+	if (scsi_host_eh_past_deadline(shost)) {
+		SCSI_LOG_ERROR_RECOVERY(3,
+			scmd_printk(KERN_INFO, scmd,
+				    "eh timeout, not retrying "
+				    "aborted command\n"));
+		goto out;
+	}
+
+	SCSI_LOG_ERROR_RECOVERY(3,
+		scmd_printk(KERN_WARNING, scmd,
+			    "retry aborted command\n"));
+	scsi_queue_insert(scmd, SCSI_MLQUEUE_EH_RETRY);
+
 	return;
 
 out:
-- 
2.32.0

