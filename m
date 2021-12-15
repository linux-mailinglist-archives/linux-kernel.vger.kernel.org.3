Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87738475ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbhLOOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4289 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbhLOOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:10 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdH713HLz67vxv;
        Wed, 15 Dec 2021 22:41:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:08 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:43:06 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/8] scsi: hisi_sas: Factor out task prep and delivery code
Date:   Wed, 15 Dec 2021 22:37:37 +0800
Message-ID: <1639579061-179473-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task prep code is the same between the normal path (in
hisi_sas_task_prep()) and the internal abort path, so factor is out into
a common function.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 281 ++++++++++++--------------
 1 file changed, 124 insertions(+), 157 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9bad59e77eae..8df1fd680eac 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -395,94 +395,20 @@ static int hisi_sas_dif_dma_map(struct hisi_hba *hisi_hba,
 	return rc;
 }
 
-static int hisi_sas_task_prep(struct sas_task *task,
-			      struct hisi_sas_dq **dq_pointer,
-			      bool is_tmf, struct hisi_sas_tmf_task *tmf)
+static
+void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
+			   struct hisi_sas_slot *slot,
+			   struct hisi_sas_dq *dq,
+			   struct hisi_sas_device *sas_dev,
+			   struct hisi_sas_internal_abort *abort,
+			   struct hisi_sas_tmf_task *tmf)
 {
-	struct domain_device *device = task->dev;
-	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
-	struct hisi_sas_device *sas_dev = device->lldd_dev;
-	struct hisi_sas_port *port;
-	struct hisi_sas_slot *slot;
-	struct hisi_sas_cmd_hdr	*cmd_hdr_base;
-	struct asd_sas_port *sas_port = device->port;
-	struct device *dev = hisi_hba->dev;
-	int dlvry_queue_slot, dlvry_queue, rc, slot_idx;
-	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
-	struct scsi_cmnd *scmd = NULL;
-	struct hisi_sas_dq *dq;
+	struct hisi_sas_cmd_hdr *cmd_hdr_base;
+	int dlvry_queue_slot, dlvry_queue;
+	struct sas_task *task = slot->task;
 	unsigned long flags;
 	int wr_q_index;
 
-	if (DEV_IS_GONE(sas_dev)) {
-		if (sas_dev)
-			dev_info(dev, "task prep: device %d not ready\n",
-				 sas_dev->device_id);
-		else
-			dev_info(dev, "task prep: device %016llx not ready\n",
-				 SAS_ADDR(device->sas_addr));
-
-		return -ECOMM;
-	}
-
-	if (task->uldd_task) {
-		struct ata_queued_cmd *qc;
-
-		if (dev_is_sata(device)) {
-			qc = task->uldd_task;
-			scmd = qc->scsicmd;
-		} else {
-			scmd = task->uldd_task;
-		}
-	}
-
-	if (scmd) {
-		unsigned int dq_index;
-		u32 blk_tag;
-
-		blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
-		*dq_pointer = dq = &hisi_hba->dq[dq_index];
-	} else {
-		struct Scsi_Host *shost = hisi_hba->shost;
-		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-		int queue = qmap->mq_map[raw_smp_processor_id()];
-
-		*dq_pointer = dq = &hisi_hba->dq[queue];
-	}
-
-	port = to_hisi_sas_port(sas_port);
-	if (port && !port->port_attached) {
-		dev_info(dev, "task prep: %s port%d not attach device\n",
-			 (dev_is_sata(device)) ?
-			 "SATA/STP" : "SAS",
-			 device->port->id);
-
-		return -ECOMM;
-	}
-
-	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
-			      &n_elem_req);
-	if (rc < 0)
-		goto prep_out;
-
-	if (!sas_protocol_ata(task->task_proto)) {
-		rc = hisi_sas_dif_dma_map(hisi_hba, &n_elem_dif, task);
-		if (rc < 0)
-			goto err_out_dma_unmap;
-	}
-
-	if (hisi_hba->hw->slot_index_alloc)
-		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
-
-	if (rc < 0)
-		goto err_out_dif_dma_unmap;
-
-	slot_idx = rc;
-	slot = &hisi_hba->slot_info[slot_idx];
-
 	spin_lock(&dq->lock);
 	wr_q_index = dq->wr_point;
 	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
@@ -496,16 +422,13 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	dlvry_queue_slot = wr_q_index;
 
 	slot->device_id = sas_dev->device_id;
-	slot->n_elem = n_elem;
-	slot->n_elem_dif = n_elem_dif;
 	slot->dlvry_queue = dlvry_queue;
 	slot->dlvry_queue_slot = dlvry_queue_slot;
 	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
 	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
-	slot->task = task;
-	slot->port = port;
+
 	slot->tmf = tmf;
-	slot->is_internal = is_tmf;
+	slot->is_internal = tmf;
 	task->lldd_task = slot;
 
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
@@ -525,8 +448,14 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		hisi_sas_task_prep_ata(hisi_hba, slot);
 		break;
+	case SAS_PROTOCOL_NONE:
+		if (abort) {
+			hisi_sas_task_prep_abort(hisi_hba, abort, slot, sas_dev->device_id);
+			break;
+		}
+	fallthrough;
 	default:
-		dev_err(dev, "task prep: unknown/unsupported proto (0x%x)\n",
+		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
 			task->task_proto);
 		break;
 	}
@@ -540,29 +469,22 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	spin_lock(&dq->lock);
 	hisi_hba->hw->start_delivery(dq);
 	spin_unlock(&dq->lock);
-
-	return 0;
-
-err_out_dif_dma_unmap:
-	if (!sas_protocol_ata(task->task_proto))
-		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
-err_out_dma_unmap:
-	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
-			   n_elem_req);
-prep_out:
-	dev_err(dev, "task prep: failed[%d]!\n", rc);
-	return rc;
 }
 
 static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
-			      bool is_tmf, struct hisi_sas_tmf_task *tmf)
+			      struct hisi_sas_tmf_task *tmf)
 {
-	u32 rc;
-	struct hisi_hba *hisi_hba;
-	struct device *dev;
+	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
 	struct domain_device *device = task->dev;
 	struct asd_sas_port *sas_port = device->port;
+	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq = NULL;
+	struct hisi_sas_port *port;
+	struct hisi_hba *hisi_hba;
+	struct hisi_sas_slot *slot;
+	struct device *dev;
+	int rc;
 
 	if (!sas_port) {
 		struct task_status_struct *ts = &task->task_status;
@@ -589,11 +511,94 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 		up(&hisi_hba->sem);
 	}
 
+	if (DEV_IS_GONE(sas_dev)) {
+		if (sas_dev)
+			dev_info(dev, "task prep: device %d not ready\n",
+				 sas_dev->device_id);
+		else
+			dev_info(dev, "task prep: device %016llx not ready\n",
+				 SAS_ADDR(device->sas_addr));
+
+		return -ECOMM;
+	}
+
+	if (task->uldd_task) {
+		struct ata_queued_cmd *qc;
+
+		if (dev_is_sata(device)) {
+			qc = task->uldd_task;
+			scmd = qc->scsicmd;
+		} else {
+			scmd = task->uldd_task;
+		}
+	}
+
+	if (scmd) {
+		unsigned int dq_index;
+		u32 blk_tag;
+
+		blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
+		dq = &hisi_hba->dq[dq_index];
+	} else {
+		struct Scsi_Host *shost = hisi_hba->shost;
+		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+		int queue = qmap->mq_map[raw_smp_processor_id()];
+
+		dq = &hisi_hba->dq[queue];
+	}
+
+	port = to_hisi_sas_port(sas_port);
+	if (port && !port->port_attached) {
+		dev_info(dev, "task prep: %s port%d not attach device\n",
+			 (dev_is_sata(device)) ?
+			 "SATA/STP" : "SAS",
+			 device->port->id);
+
+		return -ECOMM;
+	}
+
+	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
+			      &n_elem_req);
+	if (rc < 0)
+		goto prep_out;
+
+	if (!sas_protocol_ata(task->task_proto)) {
+		rc = hisi_sas_dif_dma_map(hisi_hba, &n_elem_dif, task);
+		if (rc < 0)
+			goto err_out_dma_unmap;
+	}
+
+	if (hisi_hba->hw->slot_index_alloc)
+		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
+	else
+		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
+
+	if (rc < 0)
+		goto err_out_dif_dma_unmap;
+
+	slot = &hisi_hba->slot_info[rc];
+	slot->n_elem = n_elem;
+	slot->n_elem_dif = n_elem_dif;
+	slot->task = task;
+	slot->port = port;
+
+	slot->tmf = tmf;
+	slot->is_internal = tmf;
+
 	/* protect task_prep and start_delivery sequence */
-	rc = hisi_sas_task_prep(task, &dq, is_tmf, tmf);
-	if (rc)
-		dev_err(dev, "task exec: failed[%d]!\n", rc);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL, tmf);
 
+	return 0;
+
+err_out_dif_dma_unmap:
+	if (!sas_protocol_ata(task->task_proto))
+		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
+err_out_dma_unmap:
+	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
+				   n_elem_req);
+prep_out:
+	dev_err(dev, "task exec: failed[%d]!\n", rc);
 	return rc;
 }
 
@@ -1092,7 +1097,7 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 
 static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
-	return hisi_sas_task_exec(task, gfp_flags, 0, NULL);
+	return hisi_sas_task_exec(task, gfp_flags, NULL);
 }
 
 static int hisi_sas_phy_set_linkrate(struct hisi_hba *hisi_hba, int phy_no,
@@ -1246,8 +1251,7 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
 		add_timer(&task->slow_task->timer);
 
-		res = hisi_sas_task_exec(task, GFP_KERNEL, 1, tmf);
-
+		res = hisi_sas_task_exec(task, GFP_KERNEL, tmf);
 		if (res) {
 			del_timer_sync(&task->slow_task->timer);
 			dev_err(dev, "abort tmf: executing internal task failed: %d\n",
@@ -2016,12 +2020,9 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct device *dev = hisi_hba->dev;
 	struct hisi_sas_port *port;
-	struct hisi_sas_slot *slot;
 	struct asd_sas_port *sas_port = device->port;
-	struct hisi_sas_cmd_hdr *cmd_hdr_base;
-	int dlvry_queue_slot, dlvry_queue, n_elem = 0, rc, slot_idx;
-	unsigned long flags;
-	int wr_q_index;
+	struct hisi_sas_slot *slot;
+	int slot_idx;
 
 	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
 		return -EINVAL;
@@ -2032,58 +2033,24 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	port = to_hisi_sas_port(sas_port);
 
 	/* simply get a slot and send abort command */
-	rc = hisi_sas_slot_index_alloc(hisi_hba, NULL);
-	if (rc < 0)
+	slot_idx = hisi_sas_slot_index_alloc(hisi_hba, NULL);
+	if (slot_idx < 0)
 		goto err_out;
 
-	slot_idx = rc;
 	slot = &hisi_hba->slot_info[slot_idx];
-
-	spin_lock(&dq->lock);
-	wr_q_index = dq->wr_point;
-	dq->wr_point = (dq->wr_point + 1) % HISI_SAS_QUEUE_SLOTS;
-	list_add_tail(&slot->delivery, &dq->list);
-	spin_unlock(&dq->lock);
-	spin_lock(&sas_dev->lock);
-	list_add_tail(&slot->entry, &sas_dev->list);
-	spin_unlock(&sas_dev->lock);
-
-	dlvry_queue = dq->id;
-	dlvry_queue_slot = wr_q_index;
-
-	slot->device_id = sas_dev->device_id;
-	slot->n_elem = n_elem;
-	slot->dlvry_queue = dlvry_queue;
-	slot->dlvry_queue_slot = dlvry_queue_slot;
-	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
-	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
+	slot->n_elem = 0;
 	slot->task = task;
 	slot->port = port;
 	slot->is_internal = true;
-	task->lldd_task = slot;
 
-	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
-	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
-	memset(hisi_sas_status_buf_addr_mem(slot), 0,
-	       sizeof(struct hisi_sas_err_record));
-
-	hisi_sas_task_prep_abort(hisi_hba, abort, slot, device_id);
-
-	spin_lock_irqsave(&task->task_state_lock, flags);
-	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
-	spin_unlock_irqrestore(&task->task_state_lock, flags);
-	WRITE_ONCE(slot->ready, 1);
-	/* send abort command to the chip */
-	spin_lock(&dq->lock);
-	hisi_hba->hw->start_delivery(dq);
-	spin_unlock(&dq->lock);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort, NULL);
 
 	return 0;
 
 err_out:
-	dev_err(dev, "internal abort task prep: failed[%d]!\n", rc);
+	dev_err(dev, "internal abort task prep: failed[%d]!\n", slot_idx);
 
-	return rc;
+	return slot_idx;
 }
 
 /**
-- 
2.26.2

