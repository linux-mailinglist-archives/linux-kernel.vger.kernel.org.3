Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D700D4B0B48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiBJKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:48:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiBJKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:48:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E174FD8;
        Thu, 10 Feb 2022 02:48:51 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JvYPK0Hmhz67lKF;
        Thu, 10 Feb 2022 18:48:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 11:48:49 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 10:48:46 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <chenxiang66@hisilicon.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <hch@lst.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH 1/2] scsi: isci: Drop SAS_TASK_AT_INITIATOR check in isci_task_abort_task()
Date:   Thu, 10 Feb 2022 18:43:23 +0800
Message-ID: <1644489804-85730-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
References: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the queue path, move around when we assign sas_task->lldd_task such
that this pointer and the SAS_TASK_AT_INITIATOR flag are set atomically.
It is also not required to clear SAS_TASK_AT_INITIATOR in
isci_task_execute_task() error path as it is also cleared immediately
after in isci_task_refuse() call.

Now the following items may be considered:
- SAS_TASK_STATE_DONE and SAS_TASK_AT_INITIATOR are mutually exclusive
  apart from possibly when SAS_TASK_STATE_DONE is set in
  sas_scsi_find_task(), but that is after .lldd_abort_task, i.e. the
  considered callback, is called.
- If isci_task_refuse() is called in the queue path, then
  sas_task->lldd_task and SAS_TASK_AT_INITIATOR are cleared atomically
  in isci_task_refuse().
- In the completion path, SAS_TASK_STATE_DONE is set and
  SAS_TASK_AT_INITIATOR is cleared atomically before the sas_task.lldd_task
  is cleared later.

So in isci_task_abort_task() if SAS_TASK_STATE_DONE is not set and
sas_task.lldd_task is still set, then SAS_TASK_AT_INITIATOR must be set -
so we can drop this check on SAS_TASK_AT_INITIATOR.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/isci/request.c | 12 ++++--------
 drivers/scsi/isci/request.h |  5 ++++-
 drivers/scsi/isci/task.c    | 13 ++++++-------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index fcaa84a3c210..b48ec64f745a 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -3406,9 +3406,9 @@ static struct isci_request *isci_request_from_tag(struct isci_host *ihost, u16 t
 	return ireq;
 }
 
-static struct isci_request *isci_io_request_from_tag(struct isci_host *ihost,
-						     struct sas_task *task,
-						     u16 tag)
+struct isci_request *isci_io_request_from_tag(struct isci_host *ihost,
+					      struct sas_task *task,
+					      u16 tag)
 {
 	struct isci_request *ireq;
 
@@ -3434,16 +3434,12 @@ struct isci_request *isci_tmf_request_from_tag(struct isci_host *ihost,
 }
 
 int isci_request_execute(struct isci_host *ihost, struct isci_remote_device *idev,
-			 struct sas_task *task, u16 tag)
+			 struct sas_task *task, struct isci_request * ireq)
 {
 	enum sci_status status;
-	struct isci_request *ireq;
 	unsigned long flags;
 	int ret = 0;
 
-	/* do common allocation and init of request object. */
-	ireq = isci_io_request_from_tag(ihost, task, tag);
-
 	status = isci_io_request_build(ihost, ireq, idev);
 	if (status != SCI_SUCCESS) {
 		dev_dbg(&ihost->pdev->dev,
diff --git a/drivers/scsi/isci/request.h b/drivers/scsi/isci/request.h
index aff95317fcf4..40b71b3fd03e 100644
--- a/drivers/scsi/isci/request.h
+++ b/drivers/scsi/isci/request.h
@@ -291,7 +291,10 @@ struct isci_request *isci_tmf_request_from_tag(struct isci_host *ihost,
 					       struct isci_tmf *isci_tmf,
 					       u16 tag);
 int isci_request_execute(struct isci_host *ihost, struct isci_remote_device *idev,
-			 struct sas_task *task, u16 tag);
+			 struct sas_task *task, struct isci_request * ireq);
+struct isci_request *isci_io_request_from_tag(struct isci_host *ihost,
+					      struct sas_task *task,
+					      u16 tag);
 enum sci_status
 sci_task_request_construct(struct isci_host *ihost,
 			    struct isci_remote_device *idev,
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 3fd88d72a0c0..14738702d4c9 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -162,18 +162,18 @@ int isci_task_execute_task(struct sas_task *task, gfp_t gfp_flags)
 					 SAS_TASK_UNDELIVERED,
 					 SAS_SAM_STAT_TASK_ABORTED);
 		} else {
+			struct isci_request *ireq;
+
 			task->task_state_flags |= SAS_TASK_AT_INITIATOR;
+			/* do common allocation and init of request object. */
+			ireq = isci_io_request_from_tag(ihost, task, tag);
 			spin_unlock_irqrestore(&task->task_state_lock, flags);
 
 			/* build and send the request. */
-			status = isci_request_execute(ihost, idev, task, tag);
+			/* do common allocation and init of request object. */
+			status = isci_request_execute(ihost, idev, task, ireq);
 
 			if (status != SCI_SUCCESS) {
-				spin_lock_irqsave(&task->task_state_lock, flags);
-				/* Did not really start this command. */
-				task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
-				spin_unlock_irqrestore(&task->task_state_lock, flags);
-
 				if (test_bit(IDEV_GONE, &idev->flags)) {
 					/* Indicate that the device
 					 * is gone.
@@ -498,7 +498,6 @@ int isci_task_abort_task(struct sas_task *task)
 
 	/* If task is already done, the request isn't valid */
 	if (!(task->task_state_flags & SAS_TASK_STATE_DONE) &&
-	    (task->task_state_flags & SAS_TASK_AT_INITIATOR) &&
 	    old_request) {
 		idev = isci_get_device(task->dev->lldd_dev);
 		target_done_already = test_bit(IREQ_COMPLETE_IN_TARGET,
-- 
2.26.2

