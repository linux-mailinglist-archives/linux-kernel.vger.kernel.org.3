Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A3E4E3CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiCVKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiCVKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799782D19;
        Tue, 22 Mar 2022 03:46:08 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7RL1hjGz67PTQ;
        Tue, 22 Mar 2022 18:45:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:46:06 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:46:02 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 07/11] scsi: libsas: Send internal abort commands through the block layer
Date:   Tue, 22 Mar 2022 18:39:41 +0800
Message-ID: <1647945585-197349-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like what we did for SMP commands, send internal abort commands through
the block layer.

At this point no code in libsas relies on the sas_slow_task.timer;
unfortunately we can't delete it as some LLDDs (pm8001) still rely on it -
let's try to remove them in future.

But we can delete the legacy timeout handler, sas_task_internal_timedout().

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 59 +++++++++++++++--------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 04c6298d1340..f139977098c2 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -899,24 +899,6 @@ void sas_task_internal_done(struct sas_task *task)
 	complete(&task->slow_task->completion);
 }
 
-void sas_task_internal_timedout(struct timer_list *t)
-{
-	struct sas_task_slow *slow = from_timer(slow, t, timer);
-	struct sas_task *task = slow->task;
-	bool is_completed = true;
-	unsigned long flags;
-
-	spin_lock_irqsave(&task->task_state_lock, flags);
-	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
-		is_completed = false;
-	}
-	spin_unlock_irqrestore(&task->task_state_lock, flags);
-
-	if (!is_completed)
-		complete(&task->slow_task->completion);
-}
-
 #define TASK_TIMEOUT			(20 * HZ)
 #define TASK_RETRY			3
 
@@ -979,35 +961,52 @@ static int sas_execute_internal_abort(struct domain_device *device,
 {
 	struct sas_ha_struct *ha = device->port->ha;
 	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
+	struct Scsi_Host *shost = ha->core.shost;
 	struct sas_task *task = NULL;
 	int res, retry;
+	struct request_queue *request_queue;
+	struct request *rq;
+
+	request_queue = sas_alloc_request_queue(shost);
+	if (IS_ERR(request_queue))
+		return PTR_ERR(request_queue);
 
 	for (retry = 0; retry < TASK_RETRY; retry++) {
+		struct scsi_cmnd *scmd;
+
 		task = sas_alloc_slow_task(GFP_KERNEL);
-		if (!task)
-			return -ENOMEM;
+		if (!task) {
+			res = -ENOMEM;
+			break;
+		}
 
 		task->dev = device;
 		task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
 		task->task_done = sas_task_internal_done;
-		task->slow_task->timer.function = sas_task_internal_timedout;
-		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
-		add_timer(&task->slow_task->timer);
 
 		task->abort_task.tag = tag;
 		task->abort_task.type = type;
 		task->abort_task.qid = qid;
 
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-		if (res) {
-			del_timer_sync(&task->slow_task->timer);
-			pr_err("Executing internal abort failed %016llx (%d)\n",
-			       SAS_ADDR(device->sas_addr), res);
+		rq = scsi_alloc_request_hwq(request_queue, REQ_OP_DRV_IN, BLK_MQ_REQ_NOWAIT, qid);
+		if (!rq) {
+			res = PTR_ERR(rq);
 			break;
 		}
 
+		scmd = blk_mq_rq_to_pdu(rq);
+		scmd->submitter = SUBMITTED_BY_SCSI_CUSTOM_OPS;
+		ASSIGN_SAS_TASK(scmd, task);
+
+		task->uldd_task = scmd;
+
+		rq->timeout = TASK_TIMEOUT;
+
+		blk_execute_rq_nowait(rq, true, NULL);
+
 		wait_for_completion(&task->slow_task->completion);
 		res = TMF_RESP_FUNC_FAILED;
+		__blk_mq_end_request(rq, BLK_STS_OK);
 
 		/* Even if the internal abort timed out, return direct. */
 		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
@@ -1042,7 +1041,11 @@ static int sas_execute_internal_abort(struct domain_device *device,
 		task = NULL;
 	}
 	BUG_ON(retry == TASK_RETRY && task != NULL);
+
 	sas_free_task(task);
+
+	blk_cleanup_queue(request_queue);
+
 	return res;
 }
 
-- 
2.26.2

