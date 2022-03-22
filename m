Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796A44E3CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiCVKro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiCVKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29AF8164B;
        Tue, 22 Mar 2022 03:45:57 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7QQ0YRSz67m9x;
        Tue, 22 Mar 2022 18:44:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:45:55 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:45:51 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 04/11] scsi: libsas: Send SMP commands through the block layer
Date:   Tue, 22 Mar 2022 18:39:38 +0800
Message-ID: <1647945585-197349-5-git-send-email-john.garry@huawei.com>
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

Send SMP commands through the block layer so that each command gets a
unique tag associated.

We can now also take advantage of the block layer request timeout handling.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c  | 38 +++++++++++++++------
 drivers/scsi/libsas/sas_internal.h  |  1 +
 drivers/scsi/libsas/sas_scsi_host.c | 53 +++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 260e735d06fa..bd25b00912ac 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -39,10 +39,19 @@ static int smp_execute_task_sg(struct domain_device *dev,
 	struct sas_internal *i =
 		to_sas_internal(dev->port->ha->core.shost->transportt);
 	struct sas_ha_struct *ha = dev->port->ha;
+	struct Scsi_Host *shost = ha->core.shost;
+	struct request_queue *request_queue;
+	struct request *rq;
+
+	request_queue = sas_alloc_request_queue(shost);
+	if (IS_ERR(request_queue))
+		return PTR_ERR(request_queue);
 
 	pm_runtime_get_sync(ha->dev);
 	mutex_lock(&dev->ex_dev.cmd_mutex);
 	for (retry = 0; retry < 3; retry++) {
+		struct scsi_cmnd *scmd;
+
 		if (test_bit(SAS_DEV_GONE, &dev->state)) {
 			res = -ECOMM;
 			break;
@@ -53,26 +62,30 @@ static int smp_execute_task_sg(struct domain_device *dev,
 			res = -ENOMEM;
 			break;
 		}
+
+		rq = scsi_alloc_request(request_queue, REQ_OP_DRV_IN, 0);
+		if (IS_ERR(rq)) {
+			res = PTR_ERR(rq);
+			break;
+		}
+
+		scmd = blk_mq_rq_to_pdu(rq);
+		scmd->submitter = SUBMITTED_BY_SCSI_CUSTOM_OPS;
+		ASSIGN_SAS_TASK(scmd, task);
+
 		task->dev = dev;
+		task->uldd_task = scmd;
 		task->task_proto = dev->tproto;
 		task->smp_task.smp_req = *req;
 		task->smp_task.smp_resp = *resp;
-
 		task->task_done = sas_task_internal_done;
 
-		task->slow_task->timer.function = sas_task_internal_timedout;
-		task->slow_task->timer.expires = jiffies + SMP_TIMEOUT*HZ;
-		add_timer(&task->slow_task->timer);
+		rq->timeout = SMP_TIMEOUT*HZ;
 
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-
-		if (res) {
-			del_timer(&task->slow_task->timer);
-			pr_notice("executing SMP task failed:%d\n", res);
-			break;
-		}
+		blk_execute_rq_nowait(rq, true, NULL);
 
 		wait_for_completion(&task->slow_task->completion);
+		__blk_mq_end_request(rq, BLK_STS_OK);
 		res = -ECOMM;
 		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
 			pr_notice("smp task timed out or aborted\n");
@@ -117,6 +130,9 @@ static int smp_execute_task_sg(struct domain_device *dev,
 
 	BUG_ON(retry == 3 && task != NULL);
 	sas_free_task(task);
+
+	blk_cleanup_queue(request_queue);
+
 	return res;
 }
 
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 13d0ffaada93..ca2bace16953 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -95,6 +95,7 @@ extern const work_func_t sas_port_event_fns[PORT_NUM_EVENTS];
 
 void sas_task_internal_done(struct sas_task *task);
 void sas_task_internal_timedout(struct timer_list *t);
+struct request_queue *sas_alloc_request_queue(struct Scsi_Host *shost);
 int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 9c82e5dc4fcc..91133ad37ae8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -920,6 +920,59 @@ void sas_task_internal_timedout(struct timer_list *t)
 #define TASK_TIMEOUT			(20 * HZ)
 #define TASK_RETRY			3
 
+static enum blk_eh_timer_return sas_task_timedout(struct request *rq, bool resv)
+{
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	struct sas_task *task = TO_SAS_TASK(scmd);
+	bool is_completed = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
+		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+		is_completed = false;
+	}
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
+	if (!is_completed)
+		complete(&task->slow_task->completion);
+	return BLK_EH_DONE;
+}
+
+static blk_status_t sas_exec_rq(struct blk_mq_hw_ctx *hctx,
+				const struct blk_mq_queue_data *bd)
+{
+	struct request *rq = bd->rq;
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	struct sas_task *task = (struct sas_task *)scmd->host_scribble;
+	struct domain_device *device = task->dev;
+	struct sas_ha_struct *ha = device->port->ha;
+	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
+	int res;
+
+	blk_mq_start_request(bd->rq);
+
+	res = i->dft->lldd_execute_task(task, GFP_KERNEL);
+	if (res) {
+		pr_notice("executing task proto 0x%x failed:%d\n", task->task_proto, res);
+		task->task_status.resp = SAS_TASK_UNDELIVERED;
+		task->task_status.stat = SAS_DEVICE_UNKNOWN;
+		complete(&task->slow_task->completion);
+	}
+
+	return BLK_STS_OK;
+}
+
+static const struct blk_mq_ops sas_blk_mq_ops = {
+	.queue_rq	= sas_exec_rq,
+	.timeout	= sas_task_timedout,
+};
+
+struct request_queue *sas_alloc_request_queue(struct Scsi_Host *shost)
+{
+	return blk_mq_init_queue_ops(&shost->tag_set, &sas_blk_mq_ops);
+}
+
 static int sas_execute_internal_abort(struct domain_device *device,
 				      enum sas_internal_abort type, u16 tag,
 				      unsigned int qid, void *data)
-- 
2.26.2

