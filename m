Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0254E3CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiCVKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiCVKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844FA82D31;
        Tue, 22 Mar 2022 03:46:12 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7Qj1513z67Qtq;
        Tue, 22 Mar 2022 18:44:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:46:10 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:46:06 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 08/11] scsi: libsas: Change ATA support to deal with each qc having a SCSI command
Date:   Tue, 22 Mar 2022 18:39:42 +0800
Message-ID: <1647945585-197349-9-git-send-email-john.garry@huawei.com>
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

Now that each ATA qc has a SCSI command associated, change the qc <->
scsi_cmnd <-> sas_task referencing to deal with this. Essentially
task->uldd_task = scmd always. We need to do this for sas_execute_tmf(),
as those ATA commands have no qc.

TODO: rename ASSIGN_SAS_TASK and TO_SAS_TASK to be more appropriate.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 11 +----------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 ++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  3 ++-
 drivers/scsi/libsas/sas_ata.c          | 11 ++++++-----
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 461ef8a76c4c..e438c68e249a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -520,16 +520,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 				return -ECOMM;
 		}
 
-		if (task->uldd_task) {
-			struct ata_queued_cmd *qc;
-
-			if (dev_is_sata(device)) {
-				qc = task->uldd_task;
-				scmd = qc->scsicmd;
-			} else {
-				scmd = task->uldd_task;
-			}
-		}
+		scmd = task->uldd_task;
 
 		if (scmd) {
 			unsigned int dq_index;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 455d49299ddf..d1f2c8fbdc79 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2538,7 +2538,8 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 
 	/* dw2 */
 	if (task->ata_task.use_ncq) {
-		struct ata_queued_cmd *qc = task->uldd_task;
+		struct scsi_cmnd *scmd = task->uldd_task;
+		struct ata_queued_cmd *qc = (struct ata_queued_cmd *)scmd->host_scribble;
 
 		hdr_tag = qc->tag;
 		task->ata_task.fis.sector_count |= (u8) (hdr_tag << 3);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 79f87d7c3e68..e3e02a24ee76 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1421,7 +1421,8 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 
 	/* dw2 */
 	if (task->ata_task.use_ncq) {
-		struct ata_queued_cmd *qc = task->uldd_task;
+		struct scsi_cmnd *scmd = task->uldd_task;
+		struct ata_queued_cmd *qc = (struct ata_queued_cmd *)scmd->host_scribble;
 
 		hdr_tag = qc->tag;
 		task->ata_task.fis.sector_count |= (u8) (hdr_tag << 3);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d34c82e24d9a..4d2b8fb31f30 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -72,7 +72,8 @@ static enum ata_completion_errors sas_to_ata_err(struct task_status_struct *ts)
 
 static void sas_ata_task_done(struct sas_task *task)
 {
-	struct ata_queued_cmd *qc = task->uldd_task;
+	struct scsi_cmnd *scmd = task->uldd_task;
+	struct ata_queued_cmd *qc = TO_SAS_TASK(scmd);
 	struct domain_device *dev = task->dev;
 	struct task_status_struct *stat = &task->task_status;
 	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
@@ -184,7 +185,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 		qc->tf.nsect = 0;
 
 	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, (u8 *)&task->ata_task.fis);
-	task->uldd_task = qc;
+	task->uldd_task = qc->scsicmd;
 	if (ata_is_atapi(qc->tf.protocol)) {
 		memcpy(task->ata_task.atapi_packet, qc->cdb, qc->dev->cdb_len);
 		task->total_xfer_len = qc->nbytes;
@@ -207,8 +208,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	task->ata_task.use_ncq = ata_is_ncq(qc->tf.protocol);
 	task->ata_task.dma_xfer = ata_is_dma(qc->tf.protocol);
 
-	if (qc->scsicmd)
-		ASSIGN_SAS_TASK(qc->scsicmd, task);
+	ASSIGN_SAS_TASK(qc->scsicmd, qc);
 
 	ret = i->dft->lldd_execute_task(task, GFP_ATOMIC);
 	if (ret) {
@@ -583,7 +583,8 @@ int sas_ata_init(struct domain_device *found_dev)
 
 void sas_ata_task_abort(struct sas_task *task)
 {
-	struct ata_queued_cmd *qc = task->uldd_task;
+	struct scsi_cmnd *scmd = task->uldd_task;
+	struct ata_queued_cmd *qc = TO_SAS_TASK(scmd);
 	struct completion *waiting;
 
 	/* Bounce SCSI-initiated commands to the SCSI EH */
-- 
2.26.2

