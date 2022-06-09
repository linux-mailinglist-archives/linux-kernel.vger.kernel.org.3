Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64145544929
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbiFIKiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbiFIKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:37:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5072132AB;
        Thu,  9 Jun 2022 03:36:54 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgRL3bLtz67ClN;
        Thu,  9 Jun 2022 18:33:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:51 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:48 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 17/18] scsi: libsas: Queue internal abort commands as requests
Date:   Thu, 9 Jun 2022 18:29:18 +0800
Message-ID: <1654770559-101375-18-git-send-email-john.garry@huawei.com>
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

Like what we did for SMP commands, send internal abort commands through
the block layer.

In future we can now also take advantage of the block layer request
timeout handling.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  4 +---
 drivers/scsi/libsas/sas_init.c        | 19 ++++++++++++++----
 drivers/scsi/libsas/sas_internal.h    |  3 +++
 drivers/scsi/libsas/sas_scsi_host.c   | 28 +++++++++++++++------------
 include/scsi/libsas.h                 | 16 ++++++++++++++-
 5 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 2c5c6301f224..50ca7d63ab58 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -554,13 +554,11 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 		if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
 			return -EIO;
 
-		hisi_hba = dev_to_hisi_hba(device);
-
 		if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
 			return -EINVAL;
 
 		port = to_hisi_sas_port(sas_port);
-		dq = &hisi_hba->dq[task->abort_task.qid];
+		dq = &hisi_hba->dq[sas_task_to_hwq(task)];
 		break;
 	default:
 		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 8d03b8abcaa3..1224ad2b44ce 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -23,7 +23,8 @@
 
 static struct kmem_cache *sas_event_cache;
 
-struct sas_task *sas_alloc_slow_task(struct sas_ha_struct *sas_ha, gfp_t flags)
+struct sas_task *sas_alloc_slow_task_qid(struct sas_ha_struct *sas_ha,
+					 gfp_t flags, unsigned int qid)
 {
 	struct request *rq;
 	struct sas_task *task;
@@ -34,9 +35,14 @@ struct sas_task *sas_alloc_slow_task(struct sas_ha_struct *sas_ha, gfp_t flags)
 
 	sdev = shost->sdev;
 
-	rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
-				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
-
+	if (qid == -1U) {
+		rq = scsi_alloc_request(sdev->request_queue, REQ_OP_DRV_IN,
+					BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	} else {
+		rq = scsi_alloc_request_hwq(sdev->request_queue, REQ_OP_DRV_IN,
+					BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
+					qid);
+	}
 	if (IS_ERR(rq))
 		return NULL;
 
@@ -57,6 +63,11 @@ struct sas_task *sas_alloc_slow_task(struct sas_ha_struct *sas_ha, gfp_t flags)
 	scmd->host_scribble = NULL;
 	return task;
 }
+
+struct sas_task *sas_alloc_slow_task(struct sas_ha_struct *sas_ha, gfp_t flags)
+{
+	return sas_alloc_slow_task_qid(sas_ha, flags, -1U);
+}
 EXPORT_SYMBOL_GPL(sas_alloc_slow_task);
 
 void sas_free_task(struct sas_task *task)
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 52cfa75d432b..eb70cc0d04fe 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -102,6 +102,9 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 void sas_task_complete_internal(struct sas_task *task);
 void sas_blk_end_sync_rq(struct request *rq, blk_status_t error);
 
+struct sas_task *sas_alloc_slow_task_qid(struct sas_ha_struct *sas_ha,
+					 gfp_t flags, unsigned int qid);
+
 #ifdef CONFIG_SCSI_SAS_HOST_SMP
 extern void sas_smp_host_handler(struct bsg_job *job, struct Scsi_Host *shost);
 #else
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 520c301e4319..3c62a104f049 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -973,28 +973,32 @@ static int sas_execute_internal_abort(struct domain_device *device,
 	int res, retry;
 
 	for (retry = 0; retry < TASK_RETRY; retry++) {
-		task = sas_alloc_slow_task(ha, GFP_KERNEL);
-		if (!task)
-			return -ENOMEM;
+		struct scsi_cmnd *scmd;
+		struct request *rq;
+
+		task = sas_alloc_slow_task_qid(ha, GFP_KERNEL, qid);
+		if (!task) {
+			res = -ENOMEM;
+			break;
+		}
 
 		task->dev = device;
 		task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
-		task->task_done = sas_task_internal_done;
+		task->task_done = sas_task_complete_internal;
 		task->slow_task->timer.function = sas_task_internal_timedout;
 		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
 		add_timer(&task->slow_task->timer);
 
 		task->abort_task.tag = tag;
 		task->abort_task.type = type;
-		task->abort_task.qid = qid;
 
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-		if (res) {
-			del_timer_sync(&task->slow_task->timer);
-			pr_err("Executing internal abort failed %016llx (%d)\n",
-			       SAS_ADDR(device->sas_addr), res);
-			break;
-		}
+		rq = sas_rq_from_task(task);
+
+		scmd = blk_mq_rq_to_pdu(rq);
+		ASSIGN_SAS_TASK(scmd, task);
+
+		rq->end_io = sas_blk_end_sync_rq;
+		blk_execute_rq_nowait(rq, true);
 
 		wait_for_completion(&task->slow_task->completion);
 		res = TMF_RESP_FUNC_FAILED;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 024b4c4eec3b..62acbc8a46fd 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -565,7 +565,6 @@ enum sas_internal_abort {
 
 struct sas_internal_abort_task {
 	enum sas_internal_abort type;
-	unsigned int qid;
 	u16 tag;
 };
 
@@ -785,4 +784,19 @@ static inline struct sas_task *sas_scmd_to_task(struct scsi_cmnd *scmd)
 	return sas_rq_to_task(rq);
 }
 
+static inline u32 sas_task_to_rq_unique_tag(struct sas_task *task)
+{
+	struct request *rq = sas_rq_from_task(task);
+
+	return blk_mq_unique_tag(rq);
+}
+
+static inline unsigned int sas_task_to_hwq(struct sas_task *task)
+{
+	u32 unique = sas_task_to_rq_unique_tag(task);
+
+	return blk_mq_unique_tag_to_hwq(unique);
+}
+
+
 #endif /* _SASLIB_H_ */
-- 
2.26.2

