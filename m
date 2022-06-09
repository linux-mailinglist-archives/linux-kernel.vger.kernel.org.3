Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4D54492E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbiFIKhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbiFIKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:37:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1DA217601;
        Thu,  9 Jun 2022 03:36:44 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgR84zmYz67yc5;
        Thu,  9 Jun 2022 18:33:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:42 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 14/18] scsi: libsas: Queue SMP commands as requests
Date:   Thu, 9 Jun 2022 18:29:15 +0800
Message-ID: <1654770559-101375-15-git-send-email-john.garry@huawei.com>
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

Send SMP commands through the block layer so that each command gets a
unique tag associated.

In future we can now also take advantage of the block layer request
timeout handling.

Function sas_task_complete_internal() is what the LLDD calls to signal
that the CQ is complete and this calls into the SCSI midlayer. And then
sas_blk_end_sync_rq() is called when the request completes.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c  | 13 +++----------
 drivers/scsi/libsas/sas_internal.h  |  3 +++
 drivers/scsi/libsas/sas_scsi_host.c | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index b833de062f88..d0bf63286b7d 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -66,20 +66,13 @@ static int smp_execute_task_sg(struct domain_device *dev,
 		task->task_proto = dev->tproto;
 		task->smp_task.smp_req = *req;
 		task->smp_task.smp_resp = *resp;
-
-		task->task_done = sas_task_internal_done;
+		task->task_done = sas_task_complete_internal;
 
 		task->slow_task->timer.function = sas_task_internal_timedout;
 		task->slow_task->timer.expires = jiffies + SMP_TIMEOUT*HZ;
 		add_timer(&task->slow_task->timer);
-
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-
-		if (res) {
-			del_timer(&task->slow_task->timer);
-			pr_notice("executing SMP task failed:%d\n", res);
-			break;
-		}
+		rq->end_io = sas_blk_end_sync_rq;
+		blk_execute_rq_nowait(rq, true);
 
 		wait_for_completion(&task->slow_task->completion);
 		res = -ECOMM;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 13d0ffaada93..52cfa75d432b 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -99,6 +99,9 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf);
 
+void sas_task_complete_internal(struct sas_task *task);
+void sas_blk_end_sync_rq(struct request *rq, blk_status_t error);
+
 #ifdef CONFIG_SCSI_SAS_HOST_SMP
 extern void sas_smp_host_handler(struct bsg_job *job, struct Scsi_Host *shost);
 #else
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 3abb1d622a32..f0566f4512b2 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -926,6 +926,16 @@ void sas_task_internal_done(struct sas_task *task)
 	complete(&task->slow_task->completion);
 }
 
+void sas_task_complete_internal(struct sas_task *task)
+{
+	struct request *rq = sas_rq_from_task(task);
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+
+	del_timer(&task->slow_task->timer);
+
+	scsi_done(scmd);
+}
+
 void sas_task_internal_timedout(struct timer_list *t)
 {
 	struct sas_task_slow *slow = from_timer(slow, t, timer);
@@ -947,6 +957,12 @@ void sas_task_internal_timedout(struct timer_list *t)
 #define TASK_TIMEOUT			(20 * HZ)
 #define TASK_RETRY			3
 
+void sas_blk_end_sync_rq(struct request *rq, blk_status_t error)
+{
+	struct sas_task *task = sas_rq_to_task(rq);
+	complete(&task->slow_task->completion);
+}
+
 static int sas_execute_internal_abort(struct domain_device *device,
 				      enum sas_internal_abort type, u16 tag,
 				      unsigned int qid, void *data)
-- 
2.26.2

