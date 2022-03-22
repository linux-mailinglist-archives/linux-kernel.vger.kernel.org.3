Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2794E3CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiCVKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiCVKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31F82316;
        Tue, 22 Mar 2022 03:46:01 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7RB66vHz67L71;
        Tue, 22 Mar 2022 18:44:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:45:59 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:45:55 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 05/11] scsi: libsas: Send TMF commands through the block layer
Date:   Tue, 22 Mar 2022 18:39:39 +0800
Message-ID: <1647945585-197349-6-git-send-email-john.garry@huawei.com>
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

Like what we did with SMP commands, send TMF commands through the block
layer.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 44 +++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 91133ad37ae8..04c6298d1340 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1070,15 +1070,39 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 	struct sas_internal *i =
 		to_sas_internal(device->port->ha->core.shost->transportt);
 	int res, retry;
+	struct request_queue *request_queue;
+	struct request *rq;
+	struct sas_ha_struct *ha = device->port->ha;
+	struct Scsi_Host *shost = ha->core.shost;
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
 		task->task_proto = device->tproto;
 
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
+		task->uldd_task = scmd;
+
 		if (dev_is_sata(device)) {
 			task->ata_task.device_control_reg_update = 1;
 			if (force_phy_id >= 0) {
@@ -1093,20 +1117,14 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 		task->task_done = sas_task_internal_done;
 		task->tmf = tmf;
 
-		task->slow_task->timer.function = sas_task_internal_timedout;
-		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
-		add_timer(&task->slow_task->timer);
+		rq->timeout = TASK_TIMEOUT;
 
-		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
-		if (res) {
-			del_timer_sync(&task->slow_task->timer);
-			pr_err("executing TMF task failed %016llx (%d)\n",
-			       SAS_ADDR(device->sas_addr), res);
-			break;
-		}
+		blk_execute_rq_nowait(rq, true, NULL);
 
 		wait_for_completion(&task->slow_task->completion);
 
+		__blk_mq_end_request(rq, BLK_STS_OK);
+
 		if (i->dft->lldd_tmf_exec_complete)
 			i->dft->lldd_tmf_exec_complete(device);
 
@@ -1177,6 +1195,8 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 			SAS_ADDR(device->sas_addr), TASK_RETRY);
 	sas_free_task(task);
 
+	blk_cleanup_queue(request_queue);
+
 	return res;
 }
 
-- 
2.26.2

