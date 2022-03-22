Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9544E3CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiCVKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiCVKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F93814AF;
        Tue, 22 Mar 2022 03:45:53 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7R337J0z6800j;
        Tue, 22 Mar 2022 18:44:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:45:51 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:45:47 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 03/11] libata: Send internal commands through the block layer
Date:   Tue, 22 Mar 2022 18:39:37 +0800
Message-ID: <1647945585-197349-4-git-send-email-john.garry@huawei.com>
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

When SCSI HBA device drivers are required to process an ATA internal
command they still need a tag for the IO. This often requires the driver
to set aside a set of tags for these sorts of IOs and manage the tags
themselves.

If we associate a SCSI command (and request) with an ATA internal command
then the tag is already provided, so introduce the change to send ATA
internal commands through the block layer with a set of custom blk-mq ops.

note: I think that the timeout handling needs to be fixed up.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-core.c | 121 ++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 67f88027680a..9db0428d0511 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1438,6 +1438,59 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 	complete(waiting);
 }
 
+struct ata_internal_sg_data {
+	struct completion wait;
+
+	unsigned int preempted_tag;
+	u32 preempted_sactive;
+	u64 preempted_qc_active;
+	int preempted_nr_active_links;
+};
+
+static blk_status_t ata_exec_internal_sg_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct request *rq = bd->rq;
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+	struct ata_queued_cmd *qc = (struct ata_queued_cmd *)scmd->host_scribble;
+	struct ata_internal_sg_data *data;
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = qc->ap;
+	struct ata_link *link = dev->link;
+	unsigned long flags;
+
+	data = container_of(qc->private_data, struct ata_internal_sg_data, wait);
+
+	blk_mq_start_request(bd->rq);
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	/* no internal command while frozen */
+	if (ap->pflags & ATA_PFLAG_FROZEN) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return BLK_STS_TARGET;
+	}
+
+	data->preempted_tag = link->active_tag;
+	data->preempted_sactive = link->sactive;
+	data->preempted_qc_active = ap->qc_active;
+	data->preempted_nr_active_links = ap->nr_active_links;
+	link->active_tag = ATA_TAG_POISON;
+	link->sactive = 0;
+	ap->qc_active = 0;
+	ap->nr_active_links = 0;
+
+	ata_qc_issue(qc);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return BLK_STS_OK;
+}
+
+static const struct blk_mq_ops ata_exec_internal_sg_mq_ops = {
+	.queue_rq	= ata_exec_internal_sg_queue_rq,
+};
+
 /**
  *	ata_exec_internal_sg - execute libata internal command
  *	@dev: Device to which the command is sent
@@ -1467,45 +1520,46 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
+	struct Scsi_Host *scsi_host = ap->scsi_host;
+	struct request_queue *request_queue;
 	u8 command = tf->command;
-	int auto_timeout = 0;
 	struct ata_queued_cmd *qc;
-	unsigned int preempted_tag;
-	u32 preempted_sactive;
-	u64 preempted_qc_active;
-	int preempted_nr_active_links;
-	DECLARE_COMPLETION_ONSTACK(wait);
-	unsigned long flags;
+	struct scsi_cmnd *scmd;
 	unsigned int err_mask;
-	int rc;
+	unsigned long flags;
+	struct request *rq;
+	int rc, auto_timeout = 0;
+	struct ata_internal_sg_data data = {
+		.wait = COMPLETION_INITIALIZER_ONSTACK(data.wait),
+	};
+	unsigned int op;
 
-	spin_lock_irqsave(ap->lock, flags);
+	op = (dma_dir == DMA_TO_DEVICE) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 
-	/* no internal command while frozen */
-	if (ap->pflags & ATA_PFLAG_FROZEN) {
-		spin_unlock_irqrestore(ap->lock, flags);
-		return AC_ERR_SYSTEM;
+	request_queue = blk_mq_init_queue_ops(&scsi_host->tag_set,
+					      &ata_exec_internal_sg_mq_ops);
+	if (!request_queue)
+		return AC_ERR_OTHER;
+
+	rq = scsi_alloc_request(request_queue, op, 0);
+	if (IS_ERR(rq)) {
+		err_mask = AC_ERR_OTHER;
+		goto out;
 	}
 
+	scmd = blk_mq_rq_to_pdu(rq);
+	scmd->submitter = SUBMITTED_BY_SCSI_CUSTOM_OPS;
+
 	/* initialize internal qc */
 	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
 
 	qc->tag = ATA_TAG_INTERNAL;
 	qc->hw_tag = 0;
-	qc->scsicmd = NULL;
+	qc->scsicmd = scmd;
 	qc->ap = ap;
 	qc->dev = dev;
 	ata_qc_reinit(qc);
 
-	preempted_tag = link->active_tag;
-	preempted_sactive = link->sactive;
-	preempted_qc_active = ap->qc_active;
-	preempted_nr_active_links = ap->nr_active_links;
-	link->active_tag = ATA_TAG_POISON;
-	link->sactive = 0;
-	ap->qc_active = 0;
-	ap->nr_active_links = 0;
-
 	/* prepare & issue qc */
 	qc->tf = *tf;
 	if (cdb)
@@ -1529,12 +1583,11 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 		qc->nbytes = buflen;
 	}
 
-	qc->private_data = &wait;
+	qc->private_data = &data.wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	ata_qc_issue(qc);
-
-	spin_unlock_irqrestore(ap->lock, flags);
+	scmd->host_scribble = (unsigned char *)qc;
+	blk_execute_rq_nowait(rq, true, NULL);
 
 	if (!timeout) {
 		if (ata_probe_timeout)
@@ -1548,7 +1601,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	if (ap->ops->error_handler)
 		ata_eh_release(ap);
 
-	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
+	rc = wait_for_completion_timeout(&data.wait, msecs_to_jiffies(timeout));
 
 	if (ap->ops->error_handler)
 		ata_eh_acquire(ap);
@@ -1603,16 +1656,20 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
-	link->active_tag = preempted_tag;
-	link->sactive = preempted_sactive;
-	ap->qc_active = preempted_qc_active;
-	ap->nr_active_links = preempted_nr_active_links;
+	link->active_tag = data.preempted_tag;
+	link->sactive = data.preempted_sactive;
+	ap->qc_active = data.preempted_qc_active;
+	ap->nr_active_links = data.preempted_nr_active_links;
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	if ((err_mask & AC_ERR_TIMEOUT) && auto_timeout)
 		ata_internal_cmd_timed_out(dev, command);
 
+	__blk_mq_end_request(rq, BLK_STS_OK);
+
+out:
+	blk_cleanup_queue(request_queue);
 	return err_mask;
 }
 
-- 
2.26.2

