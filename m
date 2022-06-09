Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB09544924
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbiFIKhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbiFIKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407EF215649;
        Thu,  9 Jun 2022 03:36:25 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgPM0jHwz6GCX1;
        Thu,  9 Jun 2022 18:31:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:23 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:19 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 08/18] libata: Queue ATA internal commands as requests
Date:   Thu, 9 Jun 2022 18:29:09 +0800
Message-ID: <1654770559-101375-9-git-send-email-john.garry@huawei.com>
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

Follow the normal path for requests and queue through the block layer.

We hold the qc pointer in the scmd host scribble, which is less than
ideal. In future we can hold the ata_queued_cmd in the scmd priv_data,
allowing for easy lookup.

We need to use the shost sdev to queue these requests. That is because we
initially do not have the target disk scsi_device allocated yet when
queueing internal commands. This is less than ideal, and makes it hard for
libsas to know when queueing an internal command whether it is a ATA
internal command or not.

Also make ata_exec_internal_sg() static - there are no users outside
libata-core.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-core.c | 137 +++++++++++++++++++++-----------------
 drivers/ata/libata-sata.c |   5 +-
 drivers/ata/libata.h      |   4 --
 3 files changed, 80 insertions(+), 66 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 40e816419f48..6b1aaeccb253 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1438,9 +1438,18 @@ unsigned long ata_id_xfermask(const u16 *id)
 }
 EXPORT_SYMBOL_GPL(ata_id_xfermask);
 
-static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
+void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
-	struct completion *waiting = qc->private_data;
+	struct scsi_cmnd *scmd = qc->scsicmd;
+
+	scsi_done(scmd);
+}
+
+static void ata_internal_end_rq(struct request *rq, blk_status_t error)
+{
+	struct completion *waiting = rq->end_io_data;
+
+	rq->end_io_data = (void *)(uintptr_t)error;
 
 	complete(waiting);
 }
@@ -1467,52 +1476,74 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, AC_ERR_* mask on failure
  */
-unsigned ata_exec_internal_sg(struct ata_device *dev,
+static unsigned ata_exec_internal_sg(struct ata_device *dev,
 			      struct ata_taskfile *tf, const u8 *cdb,
-			      int dma_dir, struct scatterlist *sgl,
-			      unsigned int n_elem, unsigned long timeout)
+			      int dma_dir, void *buf, unsigned int buflen,
+			      unsigned long timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
+	struct Scsi_Host *scsi_host = ap->scsi_host;
+	struct scsi_device *sdev = scsi_host->sdev;
 	u8 command = tf->command;
 	int auto_timeout = 0;
 	struct ata_queued_cmd *qc;
-	unsigned int preempted_tag;
-	u32 preempted_sactive;
-	u64 preempted_qc_active;
-	int preempted_nr_active_links;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
 	unsigned int err_mask;
+	struct scsi_cmnd *scmd;
+	struct request *req;
 	int rc;
 
-	spin_lock_irqsave(ap->lock, flags);
+	/*
+	 * We only support a single reserved command, so this guarantees
+	 * serialization. However the code already assumed that (we are
+	 * serialized here per-port).
+	 */
+	req = scsi_alloc_request(sdev->request_queue,
+			dma_dir == DMA_TO_DEVICE ?
+			REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
+			BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(req))
+		return AC_ERR_OTHER;
 
-	/* no internal command while frozen */
-	if (ap->pflags & ATA_PFLAG_FROZEN) {
-		spin_unlock_irqrestore(ap->lock, flags);
-		return AC_ERR_SYSTEM;
+
+	if (!timeout) {
+		if (ata_probe_timeout)
+			timeout = ata_probe_timeout * 1000;
+		else {
+			timeout = ata_internal_cmd_timeout(dev, command);
+			auto_timeout = 1;
+		}
 	}
 
-	/* initialize internal qc */
+	scmd = blk_mq_rq_to_pdu(req);
+	scmd->allowed = 0;
+	req->timeout = timeout;
+	//TODO: Hook up timeout handler
+	req->rq_flags |= RQF_QUIET;
+	scmd->device = sdev;
 	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
 
+	/* Do this until we can hold ata_queued_cmd in the SCMD priv data */
+	scmd->host_scribble = (unsigned char *)qc;
+
+	if (buflen) {
+		int ret = blk_rq_map_kern(sdev->request_queue, req,
+					  buf, buflen, GFP_NOIO);
+		if (ret) {
+			blk_mq_free_request(req);
+			return AC_ERR_OTHER;
+		}
+	}
+
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
@@ -1525,32 +1556,14 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir = dma_dir;
-	if (dma_dir != DMA_NONE) {
-		unsigned int i, buflen = 0;
-		struct scatterlist *sg;
-
-		for_each_sg(sgl, sg, n_elem, i)
-			buflen += sg->length;
-
-		ata_sg_init(qc, sgl, n_elem);
-		qc->nbytes = buflen;
-	}
 
-	qc->private_data = &wait;
+	qc->private_data = ap;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	ata_qc_issue(qc);
-
-	spin_unlock_irqrestore(ap->lock, flags);
+	req->end_io_data = &wait;
+	req->end_io = ata_internal_end_rq;
 
-	if (!timeout) {
-		if (ata_probe_timeout)
-			timeout = ata_probe_timeout * 1000;
-		else {
-			timeout = ata_internal_cmd_timeout(dev, command);
-			auto_timeout = 1;
-		}
-	}
+	blk_execute_rq_nowait(req, true);
 
 	if (ap->ops->error_handler)
 		ata_eh_release(ap);
@@ -1610,13 +1623,15 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	err_mask = qc->err_mask;
 
 	ata_qc_free(qc);
-	link->active_tag = preempted_tag;
-	link->sactive = preempted_sactive;
-	ap->qc_active = preempted_qc_active;
-	ap->nr_active_links = preempted_nr_active_links;
+	link->active_tag = link->preempted_tag;
+	link->sactive = link->preempted_sactive;
+	ap->qc_active = ap->preempted_qc_active;
+	ap->nr_active_links = ap->preempted_nr_active_links;
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
+	blk_mq_free_request(req);
+
 	if ((err_mask & AC_ERR_TIMEOUT) && auto_timeout)
 		ata_internal_cmd_timed_out(dev, command);
 
@@ -1647,18 +1662,20 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   int dma_dir, void *buf, unsigned int buflen,
 			   unsigned long timeout)
 {
-	struct scatterlist *psg = NULL, sg;
-	unsigned int n_elem = 0;
+	/* buf may not be aligned, so copy to/from an aligned buffer */
+	void *tmpbuf = kmemdup(buf, buflen, GFP_KERNEL);
+	unsigned res;
 
-	if (dma_dir != DMA_NONE) {
-		WARN_ON(!buf);
-		sg_init_one(&sg, buf, buflen);
-		psg = &sg;
-		n_elem++;
-	}
+	if (!tmpbuf)
+		return AC_ERR_OTHER;
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
+	res = ata_exec_internal_sg(dev, tf, cdb, dma_dir, tmpbuf, buflen,
 				    timeout);
+
+	memcpy(buf, tmpbuf, buflen);
+	kfree(tmpbuf);
+
+	return res;
 }
 
 /**
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 7a5fe41aa5ae..3cecc45d54ab 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1258,9 +1258,10 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	int rc = 0;
 
-	if (likely(ata_dev_enabled(ap->link.device)))
+	if (likely(ata_dev_enabled(ap->link.device)) ||
+		scsi_is_reserved_cmd(cmd)) {
 		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
-	else {
+	} else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		scsi_done(cmd);
 	}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 926a7f41303d..1446a482835d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -53,10 +53,6 @@ extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen,
 				  unsigned long timeout);
-extern unsigned ata_exec_internal_sg(struct ata_device *dev,
-				     struct ata_taskfile *tf, const u8 *cdb,
-				     int dma_dir, struct scatterlist *sg,
-				     unsigned int n_elem, unsigned long timeout);
 extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-- 
2.26.2

