Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5314654492F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiFIKia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbiFIKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:37:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57262213ADC;
        Thu,  9 Jun 2022 03:36:57 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgPz3D4hz683T0;
        Thu,  9 Jun 2022 18:32:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:55 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:51 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 18/18] scsi: libsas drivers: Remove private tag management
Date:   Thu, 9 Jun 2022 18:29:19 +0800
Message-ID: <1654770559-101375-19-git-send-email-john.garry@huawei.com>
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

Now every sas_task which the driver sees has a SCSI command and also
request associated, so drop the internal tag management.

For now we are only fixing up hisi_sas v2 HW, but all others need this.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 74 +++-----------------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  3 +-
 drivers/scsi/libsas/sas_ata.c          |  5 +-
 include/scsi/libsas.h                  |  8 ++-
 5 files changed, 19 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 50ca7d63ab58..e487a6e6fe7e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -169,41 +169,6 @@ static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
 	}
 }
 
-static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
-{
-	void *bitmap = hisi_hba->slot_index_tags;
-
-	__set_bit(slot_idx, bitmap);
-}
-
-static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
-				     struct scsi_cmnd *scsi_cmnd)
-{
-	int index;
-	void *bitmap = hisi_hba->slot_index_tags;
-
-	if (scsi_cmnd)
-		return scsi_cmd_to_rq(scsi_cmnd)->tag;
-
-	spin_lock(&hisi_hba->lock);
-	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
-				   hisi_hba->last_slot_index + 1);
-	if (index >= hisi_hba->slot_index_count) {
-		index = find_next_zero_bit(bitmap,
-				hisi_hba->slot_index_count,
-				HISI_SAS_UNRESERVED_IPTT);
-		if (index >= hisi_hba->slot_index_count) {
-			spin_unlock(&hisi_hba->lock);
-			return -SAS_QUEUE_FULL;
-		}
-	}
-	hisi_sas_slot_index_set(hisi_hba, index);
-	hisi_hba->last_slot_index = index;
-	spin_unlock(&hisi_hba->lock);
-
-	return index;
-}
-
 void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 			     struct hisi_sas_slot *slot)
 {
@@ -458,18 +423,17 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
 	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
+	struct scsi_cmnd *scmd = sas_scmd_from_task(task);
 	struct domain_device *device = task->dev;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	bool internal_abort = sas_is_internal_abort(task);
-	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq = NULL;
 	struct hisi_sas_port *port;
 	struct hisi_hba *hisi_hba;
 	struct hisi_sas_slot *slot;
 	struct device *dev;
 	int rc;
-
 	if (!sas_port) {
 		struct task_status_struct *ts = &task->task_status;
 
@@ -487,6 +451,8 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	hisi_hba = dev_to_hisi_hba(device);
 	dev = hisi_hba->dev;
 
+	dq = &hisi_hba->dq[sas_task_to_hwq(task)];
+
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SSP:
 	case SAS_PROTOCOL_SMP:
@@ -521,31 +487,6 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
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
-
-		if (scmd) {
-			unsigned int dq_index;
-			u32 blk_tag;
-
-			blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-			dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
-			dq = &hisi_hba->dq[dq_index];
-		} else {
-			struct Scsi_Host *shost = hisi_hba->shost;
-			struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-			int queue = qmap->mq_map[raw_smp_processor_id()];
-
-			dq = &hisi_hba->dq[queue];
-		}
 		break;
 	case SAS_PROTOCOL_INTERNAL_ABORT:
 		if (!hisi_hba->hw->prep_abort)
@@ -556,9 +497,6 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 
 		if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
 			return -EINVAL;
-
-		port = to_hisi_sas_port(sas_port);
-		dq = &hisi_hba->dq[sas_task_to_hwq(task)];
 		break;
 	default:
 		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
@@ -577,10 +515,12 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 			goto err_out_dma_unmap;
 	}
 
-	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
+	if (scsi_is_reserved_cmd(scmd))
+		rc = sas_task_to_unique_tag(task);
+	else if (hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
 	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
+		rc = sas_task_to_unique_tag(task);
 
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index a1e60d2ef070..c2af2adf75c3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2493,6 +2493,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
 	struct sas_ata_task *ata_task = &task->ata_task;
 	struct sas_tmf_task *tmf = slot->tmf;
+	struct scsi_cmnd *scmd = sas_scmd_from_task(task);
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw0, dw1 = 0, dw2 = 0;
@@ -2538,7 +2539,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 
 	/* dw2 */
 	if (task->ata_task.use_ncq) {
-		struct ata_queued_cmd *qc = task->uldd_task;
+		struct ata_queued_cmd *qc = (struct ata_queued_cmd *)scmd->host_scribble;
 
 		hdr_tag = qc->tag;
 		task->ata_task.fis.sector_count |= (u8) (hdr_tag << 3);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7d819fc0395e..6a76cc2e34af 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1382,6 +1382,7 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
+	struct scsi_cmnd *scmd = sas_scmd_from_task(task);
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw1 = 0, dw2 = 0;
@@ -1421,7 +1422,7 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 
 	/* dw2 */
 	if (task->ata_task.use_ncq) {
-		struct ata_queued_cmd *qc = task->uldd_task;
+		struct ata_queued_cmd *qc = (struct ata_queued_cmd *)scmd->host_scribble;
 
 		hdr_tag = qc->tag;
 		task->ata_task.fis.sector_count |= (u8) (hdr_tag << 3);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 66534332e9ac..6ebcabdf0c01 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -188,7 +188,6 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 		qc->tf.nsect = 0;
 
 	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, (u8 *)&task->ata_task.fis);
-	task->uldd_task = qc;
 	if (ata_is_atapi(qc->tf.protocol)) {
 		memcpy(task->ata_task.atapi_packet, qc->cdb, qc->dev->cdb_len);
 		task->total_xfer_len = qc->nbytes;
@@ -211,8 +210,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	task->ata_task.use_ncq = ata_is_ncq(qc->tf.protocol);
 	task->ata_task.dma_xfer = ata_is_dma(qc->tf.protocol);
 
-	if (qc->scsicmd)
-		ASSIGN_SAS_TASK(qc->scsicmd, task);
+	ASSIGN_SAS_TASK(qc->scsicmd, qc);
 
 	ret = i->dft->lldd_execute_task(task, GFP_ATOMIC);
 	if (ret) {
@@ -473,7 +471,6 @@ static void sas_ata_post_internal(struct ata_queued_cmd *qc)
 		qc->lldd_task = NULL;
 		if (!task)
 			return;
-		task->uldd_task = NULL;
 		sas_ata_internal_abort(task);
 	}
 }
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 62acbc8a46fd..3dd4d9c47b2b 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -619,7 +619,6 @@ struct sas_task {
 	void   (*task_done)(struct sas_task *);
 
 	void   *lldd_task;	  /* for use by LLDDs */
-	void   *uldd_task;
 	struct sas_task_slow *slow_task;
 	struct sas_tmf_task *tmf;
 };
@@ -798,5 +797,12 @@ static inline unsigned int sas_task_to_hwq(struct sas_task *task)
 	return blk_mq_unique_tag_to_hwq(unique);
 }
 
+static inline unsigned int sas_task_to_unique_tag(struct sas_task *task)
+{
+	u32 unique = sas_task_to_rq_unique_tag(task);
+
+	return blk_mq_unique_tag_to_tag(unique);
+
+}
 
 #endif /* _SASLIB_H_ */
-- 
2.26.2

