Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A7544933
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiFIKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243144AbiFIKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:37:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9521683A;
        Thu,  9 Jun 2022 03:36:40 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgPg0Wz3z67dbJ;
        Thu,  9 Jun 2022 18:31:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:39 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:35 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 13/18] scsi: libsas: Allocate SCSI commands for tasks
Date:   Thu, 9 Jun 2022 18:29:14 +0800
Message-ID: <1654770559-101375-14-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a SCSI command for a SAS task.

The next step will be to send tasks same as we do for other requests -
through the block layer.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c       | 17 +++++---
 drivers/scsi/libsas/sas_expander.c  | 11 +++++-
 drivers/scsi/libsas/sas_init.c      | 60 +++++++++++++++--------------
 drivers/scsi/libsas/sas_scsi_host.c | 17 ++++----
 include/scsi/libsas.h               | 17 +++++++-
 5 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d35c9296f738..66534332e9ac 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -72,7 +72,8 @@ static enum ata_completion_errors sas_to_ata_err(struct task_status_struct *ts)
 
 static void sas_ata_task_done(struct sas_task *task)
 {
-	struct ata_queued_cmd *qc = task->uldd_task;
+	struct scsi_cmnd *scmd = sas_scmd_from_task(task);
+	struct ata_queued_cmd *qc = TO_SAS_TASK(scmd);
 	struct domain_device *dev = task->dev;
 	struct task_status_struct *stat = &task->task_status;
 	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
@@ -149,7 +150,9 @@ static void sas_ata_task_done(struct sas_task *task)
 	spin_unlock_irqrestore(ap->lock, flags);
 
 qc_already_gone:
-	sas_free_task(task);
+	/* We rely on libata internal command to do this for us */
+	if (!ata_is_scmd_ata_internal(scmd))
+		sas_free_task(task);
 }
 
 static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
@@ -164,6 +167,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	struct sas_ha_struct *sas_ha = dev->port->ha;
 	struct Scsi_Host *host = sas_ha->core.shost;
 	struct sas_internal *i = to_sas_internal(host->transportt);
+	struct scsi_cmnd *scmd;
 
 	/* TODO: we should try to remove that unlock */
 	spin_unlock(ap->lock);
@@ -172,9 +176,9 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	if (test_bit(SAS_DEV_GONE, &dev->state))
 		goto out;
 
-	task = sas_alloc_task(GFP_ATOMIC);
-	if (!task)
-		goto out;
+	scmd = qc->scsicmd;
+	task = sas_scmd_to_task(scmd);
+
 	task->dev = dev;
 	task->task_proto = SAS_PROTOCOL_STP;
 	task->task_done = sas_ata_task_done;
@@ -596,7 +600,8 @@ int sas_ata_init(struct domain_device *found_dev)
 
 void sas_ata_task_abort(struct sas_task *task)
 {
-	struct ata_queued_cmd *qc = task->uldd_task;
+	struct scsi_cmnd *scmd = sas_scmd_from_task(task);
+	struct ata_queued_cmd *qc = TO_SAS_TASK(scmd);
 	struct completion *waiting;
 
 	/* Bounce SCSI-initiated commands to the SCSI EH */
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 260e735d06fa..b833de062f88 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -39,20 +39,29 @@ static int smp_execute_task_sg(struct domain_device *dev,
 	struct sas_internal *i =
 		to_sas_internal(dev->port->ha->core.shost->transportt);
 	struct sas_ha_struct *ha = dev->port->ha;
+	struct request *rq;
 
 	pm_runtime_get_sync(ha->dev);
 	mutex_lock(&dev->ex_dev.cmd_mutex);
 	for (retry = 0; retry < 3; retry++) {
+		struct scsi_cmnd *scmd;
+
 		if (test_bit(SAS_DEV_GONE, &dev->state)) {
 			res = -ECOMM;
 			break;
 		}
 
-		task = sas_alloc_slow_task(GFP_KERNEL);
+		task = sas_alloc_slow_task(dev->port->ha, GFP_KERNEL);
 		if (!task) {
 			res = -ENOMEM;
 			break;
 		}
+
+		rq = sas_rq_from_task(task);
+
+		scmd = blk_mq_rq_to_pdu(rq);
+		ASSIGN_SAS_TASK(scmd, task);
+
 		task->dev = dev;
 		task->task_proto = dev->tproto;
 		task->smp_task.smp_req = *req;
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index b0921fbc35b1..8d03b8abcaa3 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -21,30 +21,31 @@
 
 #include "scsi_sas_internal.h"
 
-static struct kmem_cache *sas_task_cache;
 static struct kmem_cache *sas_event_cache;
 
-struct sas_task *sas_alloc_task(gfp_t flags)
+struct sas_task *sas_alloc_slow_task(struct sas_ha_struct *sas_ha, gfp_t flags)
 {
-	struct sas_task *task = kmem_cache_zalloc(sas_task_cache, flags);
+	struct request *rq;
+	struct sas_task *task;
+	struct sas_task_slow *slow;
+	struct Scsi_Host *shost = sas_ha->core.shost;
+	struct scsi_cmnd *scmd;
+	struct scsi_device *sdev;
 
-	if (task) {
-		spin_lock_init(&task->task_state_lock);
-		task->task_state_flags = SAS_TASK_STATE_PENDING;
-	}
+	sdev = shost->sdev;
 
-	return task;
-}
-EXPORT_SYMBOL_GPL(sas_alloc_task);
+	rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
+				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 
-struct sas_task *sas_alloc_slow_task(gfp_t flags)
-{
-	struct sas_task *task = sas_alloc_task(flags);
-	struct sas_task_slow *slow = kmalloc(sizeof(*slow), flags);
+	if (IS_ERR(rq))
+		return NULL;
+
+	scmd = blk_mq_rq_to_pdu(rq);
+	task = sas_rq_to_task(rq);
+
+	slow = kmalloc(sizeof(*slow), flags);
 
 	if (!task || !slow) {
-		if (task)
-			kmem_cache_free(sas_task_cache, task);
 		kfree(slow);
 		return NULL;
 	}
@@ -53,17 +54,19 @@ struct sas_task *sas_alloc_slow_task(gfp_t flags)
 	slow->task = task;
 	timer_setup(&slow->timer, NULL, 0);
 	init_completion(&slow->completion);
-
+	scmd->host_scribble = NULL;
 	return task;
 }
 EXPORT_SYMBOL_GPL(sas_alloc_slow_task);
 
 void sas_free_task(struct sas_task *task)
 {
-	if (task) {
-		kfree(task->slow_task);
-		kmem_cache_free(sas_task_cache, task);
-	}
+	struct request *rq = sas_rq_from_task(task);
+
+	kfree(task->slow_task);
+
+	if (blk_mq_is_reserved_rq(rq))
+		blk_mq_free_request(rq);
 }
 EXPORT_SYMBOL_GPL(sas_free_task);
 
@@ -95,6 +98,13 @@ void sas_hash_addr(u8 *hashed, const u8 *sas_addr)
 
 int sas_init_priv_cmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 {
+	struct sas_task *task = sas_scmd_to_task(cmd);
+
+	memset(task, 0, sizeof(*task));
+	spin_lock_init(&task->task_state_lock);
+	task->task_state_flags = SAS_TASK_STATE_PENDING;
+	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
+
 	return 0;
 }
 
@@ -685,24 +695,18 @@ void sas_free_event(struct asd_sas_event *event)
 
 static int __init sas_class_init(void)
 {
-	sas_task_cache = KMEM_CACHE(sas_task, SLAB_HWCACHE_ALIGN);
-	if (!sas_task_cache)
-		goto out;
-
 	sas_event_cache = KMEM_CACHE(asd_sas_event, SLAB_HWCACHE_ALIGN);
 	if (!sas_event_cache)
 		goto free_task_kmem;
 
 	return 0;
 free_task_kmem:
-	kmem_cache_destroy(sas_task_cache);
-out:
+
 	return -ENOMEM;
 }
 
 static void __exit sas_class_exit(void)
 {
-	kmem_cache_destroy(sas_task_cache);
 	kmem_cache_destroy(sas_event_cache);
 }
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 532e734c1fb6..3abb1d622a32 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -98,7 +98,7 @@ static void sas_end_task(struct scsi_cmnd *sc, struct sas_task *task)
 
 static void sas_scsi_task_done(struct sas_task *task)
 {
-	struct scsi_cmnd *sc = task->uldd_task;
+	struct scsi_cmnd *sc = sas_scmd_from_task(task);
 	struct domain_device *dev = task->dev;
 	struct sas_ha_struct *ha = dev->port->ha;
 	unsigned long flags;
@@ -130,13 +130,12 @@ static struct sas_task *sas_create_task(struct scsi_cmnd *cmd,
 					       struct domain_device *dev,
 					       gfp_t gfp_flags)
 {
-	struct sas_task *task = sas_alloc_task(gfp_flags);
+	struct sas_task *task = sas_scmd_to_task(cmd);
 	struct scsi_lun lun;
 
 	if (!task)
 		return NULL;
 
-	task->uldd_task = cmd;
 	ASSIGN_SAS_TASK(cmd, task);
 
 	task->dev = dev;
@@ -958,7 +957,7 @@ static int sas_execute_internal_abort(struct domain_device *device,
 	int res, retry;
 
 	for (retry = 0; retry < TASK_RETRY; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
+		task = sas_alloc_slow_task(ha, GFP_KERNEL);
 		if (!task)
 			return -ENOMEM;
 
@@ -1044,10 +1043,12 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 	struct sas_task *task;
 	struct sas_internal *i =
 		to_sas_internal(device->port->ha->core.shost->transportt);
+	struct sas_ha_struct *ha = device->port->ha;
 	int res, retry;
 
+
 	for (retry = 0; retry < TASK_RETRY; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
+		task = sas_alloc_slow_task(ha, GFP_KERNEL);
 		if (!task)
 			return -ENOMEM;
 
@@ -1204,7 +1205,7 @@ int sas_query_task(struct sas_task *task, u16 tag)
 		.tmf = TMF_QUERY_TASK,
 		.tag_of_task_to_be_managed = tag,
 	};
-	struct scsi_cmnd *cmnd = task->uldd_task;
+	struct scsi_cmnd *cmnd = sas_scmd_from_task(task);
 	struct domain_device *dev = task->dev;
 	struct scsi_lun lun;
 
@@ -1220,7 +1221,7 @@ int sas_abort_task(struct sas_task *task, u16 tag)
 		.tmf = TMF_ABORT_TASK,
 		.tag_of_task_to_be_managed = tag,
 	};
-	struct scsi_cmnd *cmnd = task->uldd_task;
+	struct scsi_cmnd *cmnd = sas_scmd_from_task(task);
 	struct domain_device *dev = task->dev;
 	struct scsi_lun lun;
 
@@ -1236,7 +1237,7 @@ EXPORT_SYMBOL_GPL(sas_abort_task);
  */
 void sas_task_abort(struct sas_task *task)
 {
-	struct scsi_cmnd *sc = task->uldd_task;
+	struct scsi_cmnd *sc = sas_scmd_from_task(task);
 
 	/* Escape for libsas internal commands */
 	if (!sc) {
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 92fc3e5ef297..024b4c4eec3b 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -639,8 +639,7 @@ struct sas_task_slow {
 #define SAS_TASK_STATE_ABORTED      4
 #define SAS_TASK_NEED_DEV_RESET     8
 
-extern struct sas_task *sas_alloc_task(gfp_t flags);
-extern struct sas_task *sas_alloc_slow_task(gfp_t flags);
+extern struct sas_task *sas_alloc_slow_task(struct sas_ha_struct *, gfp_t flags);
 extern void sas_free_task(struct sas_task *task);
 
 static inline bool sas_is_internal_abort(struct sas_task *task)
@@ -766,10 +765,24 @@ static inline struct sas_task *sas_rq_to_task(struct request *rq)
 	return (struct sas_task *)(scmd + 1);
 }
 
+static inline struct request *sas_rq_from_task(void *task)
+{
+	struct scsi_cmnd *scmd = task - sizeof(*scmd);
+
+	return blk_mq_rq_from_pdu(scmd);
+}
+
 static inline struct scsi_cmnd *sas_scmd_from_task(void *task)
 {
 	struct scsi_cmnd *scmd = task - sizeof(*scmd);
 
 	return scmd;
 }
+
+static inline struct sas_task *sas_scmd_to_task(struct scsi_cmnd *scmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+	return sas_rq_to_task(rq);
+}
+
 #endif /* _SASLIB_H_ */
-- 
2.26.2

