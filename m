Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED564CBDB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiCCMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiCCMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:25:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E00D179268;
        Thu,  3 Mar 2022 04:24:46 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8VWm6s9Fz67dN2;
        Thu,  3 Mar 2022 20:23:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 3 Mar 2022 13:24:44 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 12:24:40 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] scsi: hisi_sas: Use libsas internal abort support
Date:   Thu, 3 Mar 2022 20:18:50 +0800
Message-ID: <1646309930-138960-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common libsas internal abort functionality.

In addition, this driver has special handling for internal abort timeouts -
specifically whether to reset the controller in that instance, so extend
the API for that.

Timeout is now increased to 20 * Hz from 6 * Hz.

We also retry for failure now, but this should not make a difference.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |   8 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 453 +++++++++----------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  18 +-
 drivers/scsi/libsas/sas_scsi_host.c    |  12 +-
 include/scsi/libsas.h                  |   2 +
 6 files changed, 182 insertions(+), 322 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 99ceffad4bd9..24c83bc4f5dc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -133,11 +133,6 @@ struct hisi_sas_rst {
 	bool done;
 };
 
-struct hisi_sas_internal_abort {
-	unsigned int flag;
-	unsigned int tag;
-};
-
 #define HISI_SAS_RST_WORK_INIT(r, c) \
 	{	.hisi_hba = hisi_hba, \
 		.completion = &c, \
@@ -325,8 +320,7 @@ struct hisi_sas_hw {
 	void (*prep_stp)(struct hisi_hba *hisi_hba,
 			struct hisi_sas_slot *slot);
 	void (*prep_abort)(struct hisi_hba *hisi_hba,
-			  struct hisi_sas_slot *slot,
-			  int device_id, int abort_flag, int tag_to_abort);
+			  struct hisi_sas_slot *slot);
 	void (*phys_init)(struct hisi_hba *hisi_hba);
 	void (*phy_start)(struct hisi_hba *hisi_hba, int phy_no);
 	void (*phy_disable)(struct hisi_hba *hisi_hba, int phy_no);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index cd8ec851e760..461ef8a76c4c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,10 +10,6 @@
 #define DEV_IS_GONE(dev) \
 	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
 
-static int
-hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
-			     struct domain_device *device,
-			     int abort_flag, int tag, bool rst_to_recover);
 static int hisi_sas_softreset_ata_disk(struct domain_device *device);
 static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 				void *funcdata);
@@ -21,6 +17,10 @@ static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
 				  struct domain_device *device);
 static void hisi_sas_dev_gone(struct domain_device *device);
 
+struct hisi_sas_internal_abort_data {
+	bool rst_ha_timeout; /* reset the HA for timeout */
+};
+
 u8 hisi_sas_get_ata_protocol(struct host_to_dev_fis *fis, int direction)
 {
 	switch (fis->command) {
@@ -263,11 +263,9 @@ static void hisi_sas_task_prep_ata(struct hisi_hba *hisi_hba,
 }
 
 static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
-		struct hisi_sas_internal_abort *abort,
-		struct hisi_sas_slot *slot, int device_id)
+				     struct hisi_sas_slot *slot)
 {
-	hisi_hba->hw->prep_abort(hisi_hba, slot,
-			device_id, abort->flag, abort->tag);
+	hisi_hba->hw->prep_abort(hisi_hba, slot);
 }
 
 static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
@@ -397,8 +395,7 @@ static
 void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 			   struct hisi_sas_slot *slot,
 			   struct hisi_sas_dq *dq,
-			   struct hisi_sas_device *sas_dev,
-			   struct hisi_sas_internal_abort *abort)
+			   struct hisi_sas_device *sas_dev)
 {
 	struct hisi_sas_cmd_hdr *cmd_hdr_base;
 	int dlvry_queue_slot, dlvry_queue;
@@ -439,19 +436,15 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 		break;
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
-	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
+	case SAS_PROTOCOL_STP_ALL:
 		hisi_sas_task_prep_ata(hisi_hba, slot);
 		break;
-	case SAS_PROTOCOL_NONE:
-		if (abort) {
-			hisi_sas_task_prep_abort(hisi_hba, abort, slot, sas_dev->device_id);
-			break;
-		}
+	case SAS_PROTOCOL_INTERNAL_ABORT:
+		hisi_sas_task_prep_abort(hisi_hba, slot);
+		break;
 	fallthrough;
 	default:
-		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
-			task->task_proto);
-		break;
+		return;
 	}
 
 	WRITE_ONCE(slot->ready, 1);
@@ -467,6 +460,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	struct domain_device *device = task->dev;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	bool internal_abort = sas_is_internal_abort(task);
 	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq = NULL;
 	struct hisi_sas_port *port;
@@ -484,7 +478,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 		 * libsas will use dev->port, should
 		 * not call task_done for sata
 		 */
-		if (device->dev_type != SAS_SATA_DEV)
+		if (device->dev_type != SAS_SATA_DEV && !internal_abort)
 			task->task_done(task);
 		return -ECOMM;
 	}
@@ -492,59 +486,85 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	hisi_hba = dev_to_hisi_hba(device);
 	dev = hisi_hba->dev;
 
-	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags))) {
-		if (!gfpflags_allow_blocking(gfp_flags))
-			return -EINVAL;
+	switch (task->task_proto) {
+	case SAS_PROTOCOL_SSP:
+	case SAS_PROTOCOL_SMP:
+	case SAS_PROTOCOL_SATA:
+	case SAS_PROTOCOL_STP:
+	case SAS_PROTOCOL_STP_ALL:
+		if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags))) {
+			if (!gfpflags_allow_blocking(gfp_flags))
+				return -EINVAL;
 
-		down(&hisi_hba->sem);
-		up(&hisi_hba->sem);
-	}
+			down(&hisi_hba->sem);
+			up(&hisi_hba->sem);
+		}
 
-	if (DEV_IS_GONE(sas_dev)) {
-		if (sas_dev)
-			dev_info(dev, "task prep: device %d not ready\n",
-				 sas_dev->device_id);
-		else
-			dev_info(dev, "task prep: device %016llx not ready\n",
-				 SAS_ADDR(device->sas_addr));
+		if (DEV_IS_GONE(sas_dev)) {
+			if (sas_dev)
+				dev_info(dev, "task prep: device %d not ready\n",
+					 sas_dev->device_id);
+			else
+				dev_info(dev, "task prep: device %016llx not ready\n",
+					 SAS_ADDR(device->sas_addr));
 
-		return -ECOMM;
-	}
+			return -ECOMM;
+		}
 
-	if (task->uldd_task) {
-		struct ata_queued_cmd *qc;
+		port = to_hisi_sas_port(sas_port);
+		if (!port->port_attached) {
+			dev_info(dev, "task prep: %s port%d not attach device\n",
+				 dev_is_sata(device) ? "SATA/STP" : "SAS",
+				 device->port->id);
 
-		if (dev_is_sata(device)) {
-			qc = task->uldd_task;
-			scmd = qc->scsicmd;
-		} else {
-			scmd = task->uldd_task;
+				return -ECOMM;
 		}
-	}
 
-	if (scmd) {
-		unsigned int dq_index;
-		u32 blk_tag;
+		if (task->uldd_task) {
+			struct ata_queued_cmd *qc;
 
-		blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
-		dq = &hisi_hba->dq[dq_index];
-	} else {
-		struct Scsi_Host *shost = hisi_hba->shost;
-		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-		int queue = qmap->mq_map[raw_smp_processor_id()];
+			if (dev_is_sata(device)) {
+				qc = task->uldd_task;
+				scmd = qc->scsicmd;
+			} else {
+				scmd = task->uldd_task;
+			}
+		}
 
-		dq = &hisi_hba->dq[queue];
-	}
+		if (scmd) {
+			unsigned int dq_index;
+			u32 blk_tag;
 
-	port = to_hisi_sas_port(sas_port);
-	if (port && !port->port_attached) {
-		dev_info(dev, "task prep: %s port%d not attach device\n",
-			 (dev_is_sata(device)) ?
-			 "SATA/STP" : "SAS",
-			 device->port->id);
+			blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
+			dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
+			dq = &hisi_hba->dq[dq_index];
+		} else {
+			struct Scsi_Host *shost = hisi_hba->shost;
+			struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+			int queue = qmap->mq_map[raw_smp_processor_id()];
 
-		return -ECOMM;
+			dq = &hisi_hba->dq[queue];
+		}
+		break;
+	case SAS_PROTOCOL_INTERNAL_ABORT:
+		if (!hisi_hba->hw->prep_abort)
+			return TMF_RESP_FUNC_FAILED;
+
+		if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
+			return -EIO;
+
+		hisi_hba = dev_to_hisi_hba(device);
+
+		if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
+			return -EINVAL;
+
+		port = to_hisi_sas_port(sas_port);
+		dq = &hisi_hba->dq[task->abort_task.qid];
+		break;
+	default:
+		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
+			task->task_proto);
+		return -EINVAL;
 	}
 
 	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
@@ -558,7 +578,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 			goto err_out_dma_unmap;
 	}
 
-	if (hisi_hba->hw->slot_index_alloc)
+	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
 	else
 		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
@@ -573,10 +593,10 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	slot->port = port;
 
 	slot->tmf = task->tmf;
-	slot->is_internal = task->tmf;
+	slot->is_internal = !!task->tmf || internal_abort;
 
 	/* protect task_prep and start_delivery sequence */
-	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev);
 
 	return 0;
 
@@ -1088,6 +1108,29 @@ static void hisi_sas_dereg_device(struct hisi_hba *hisi_hba,
 		hisi_hba->hw->dereg_device(hisi_hba, device);
 }
 
+static int
+hisi_sas_internal_task_abort_dev(struct hisi_sas_device *sas_dev,
+				 bool rst_ha_timeout)
+{
+	struct hisi_sas_internal_abort_data data = { rst_ha_timeout };
+	struct domain_device *device = sas_dev->sas_device;
+	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
+	int i, rc;
+
+	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
+		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
+		const struct cpumask *mask = cq->irq_mask;
+
+		if (mask && !cpumask_intersects(cpu_online_mask, mask))
+			continue;
+		rc = sas_execute_internal_abort_dev(device, i, &data);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static void hisi_sas_dev_gone(struct domain_device *device)
 {
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
@@ -1100,8 +1143,7 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 
 	down(&hisi_hba->sem);
 	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags)) {
-		hisi_sas_internal_task_abort(hisi_hba, device,
-					     HISI_SAS_INT_ABT_DEV, 0, true);
+		hisi_sas_internal_task_abort_dev(sas_dev, true);
 
 		hisi_sas_dereg_device(hisi_hba, device);
 
@@ -1216,32 +1258,6 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 	return ret;
 }
 
-static void hisi_sas_task_done(struct sas_task *task)
-{
-	del_timer_sync(&task->slow_task->timer);
-	complete(&task->slow_task->completion);
-}
-
-static void hisi_sas_tmf_timedout(struct timer_list *t)
-{
-	struct sas_task_slow *slow = from_timer(slow, t, timer);
-	struct sas_task *task = slow->task;
-	unsigned long flags;
-	bool is_completed = true;
-
-	spin_lock_irqsave(&task->task_state_lock, flags);
-	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
-		is_completed = false;
-	}
-	spin_unlock_irqrestore(&task->task_state_lock, flags);
-
-	if (!is_completed)
-		complete(&task->slow_task->completion);
-}
-
-#define INTERNAL_ABORT_TIMEOUT		(6 * HZ)
-
 static void hisi_sas_fill_ata_reset_cmd(struct ata_device *dev,
 		bool reset, int pmp, u8 *fis)
 {
@@ -1426,9 +1442,7 @@ static void hisi_sas_terminate_stp_reject(struct hisi_hba *hisi_hba)
 		if ((sas_dev->dev_type == SAS_PHY_UNUSED) || !device)
 			continue;
 
-		rc = hisi_sas_internal_task_abort(hisi_hba, device,
-						  HISI_SAS_INT_ABT_DEV, 0,
-						  false);
+		rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 		if (rc < 0)
 			dev_err(dev, "STP reject: abort dev failed %d\n", rc);
 	}
@@ -1536,6 +1550,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 
 static int hisi_sas_abort_task(struct sas_task *task)
 {
+	struct hisi_sas_internal_abort_data internal_abort_data = { false };
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba;
@@ -1575,9 +1590,8 @@ static int hisi_sas_abort_task(struct sas_task *task)
 		int rc2;
 
 		rc = sas_abort_task(task, tag);
-		rc2 = hisi_sas_internal_task_abort(hisi_hba, device,
-						   HISI_SAS_INT_ABT_CMD, tag,
-						   false);
+		rc2 = sas_execute_internal_abort_single(device, tag,
+				slot->dlvry_queue, &internal_abort_data);
 		if (rc2 < 0) {
 			dev_err(dev, "abort task: internal abort (%d)\n", rc2);
 			return TMF_RESP_FUNC_FAILED;
@@ -1597,9 +1611,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
 		task->task_proto & SAS_PROTOCOL_STP) {
 		if (task->dev->dev_type == SAS_SATA_DEV) {
-			rc = hisi_sas_internal_task_abort(hisi_hba, device,
-							  HISI_SAS_INT_ABT_DEV,
-							  0, false);
+			rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 			if (rc < 0) {
 				dev_err(dev, "abort task: internal abort failed\n");
 				goto out;
@@ -1613,9 +1625,9 @@ static int hisi_sas_abort_task(struct sas_task *task)
 		u32 tag = slot->idx;
 		struct hisi_sas_cq *cq = &hisi_hba->cq[slot->dlvry_queue];
 
-		rc = hisi_sas_internal_task_abort(hisi_hba, device,
-						  HISI_SAS_INT_ABT_CMD, tag,
-						  false);
+		rc = sas_execute_internal_abort_single(device,
+						       tag, slot->dlvry_queue,
+						       &internal_abort_data);
 		if (((rc < 0) || (rc == TMF_RESP_FUNC_FAILED)) &&
 					task->lldd_task) {
 			/*
@@ -1635,12 +1647,12 @@ static int hisi_sas_abort_task(struct sas_task *task)
 
 static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 {
+	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	int rc;
 
-	rc = hisi_sas_internal_task_abort(hisi_hba, device,
-					  HISI_SAS_INT_ABT_DEV, 0, false);
+	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 	if (rc < 0) {
 		dev_err(dev, "abort task set: internal abort rc=%d\n", rc);
 		return TMF_RESP_FUNC_FAILED;
@@ -1713,12 +1725,12 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 
 static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 {
+	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	int rc;
 
-	rc = hisi_sas_internal_task_abort(hisi_hba, device,
-					  HISI_SAS_INT_ABT_DEV, 0, false);
+	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 	if (rc < 0) {
 		dev_err(dev, "I_T nexus reset: internal abort (%d)\n", rc);
 		return TMF_RESP_FUNC_FAILED;
@@ -1766,8 +1778,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	/* Clear internal IO and then lu reset */
-	rc = hisi_sas_internal_task_abort(hisi_hba, device,
-					  HISI_SAS_INT_ABT_DEV, 0, false);
+	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
 	if (rc < 0) {
 		dev_err(dev, "lu_reset: internal abort failed\n");
 		goto out;
@@ -1862,203 +1873,48 @@ static int hisi_sas_query_task(struct sas_task *task)
 	return rc;
 }
 
-static int
-hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
-				  struct hisi_sas_internal_abort *abort,
-				  struct sas_task *task,
-				  struct hisi_sas_dq *dq)
+static bool hisi_sas_internal_abort_timeout(struct sas_task *task,
+					    void *data)
 {
 	struct domain_device *device = task->dev;
-	struct hisi_sas_device *sas_dev = device->lldd_dev;
-	struct device *dev = hisi_hba->dev;
-	struct hisi_sas_port *port;
-	struct asd_sas_port *sas_port = device->port;
-	struct hisi_sas_slot *slot;
-	int slot_idx;
-
-	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
-		return -EINVAL;
-
-	if (!device->port)
-		return -1;
-
-	port = to_hisi_sas_port(sas_port);
-
-	/* simply get a slot and send abort command */
-	slot_idx = hisi_sas_slot_index_alloc(hisi_hba, NULL);
-	if (slot_idx < 0)
-		goto err_out;
-
-	slot = &hisi_hba->slot_info[slot_idx];
-	slot->n_elem = 0;
-	slot->task = task;
-	slot->port = port;
-	slot->is_internal = true;
-
-	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort);
-
-	return 0;
-
-err_out:
-	dev_err(dev, "internal abort task prep: failed[%d]!\n", slot_idx);
-
-	return slot_idx;
-}
-
-/**
- * _hisi_sas_internal_task_abort -- execute an internal
- * abort command for single IO command or a device
- * @hisi_hba: host controller struct
- * @device: domain device
- * @abort_flag: mode of operation, device or single IO
- * @tag: tag of IO to be aborted (only relevant to single
- *       IO mode)
- * @dq: delivery queue for this internal abort command
- * @rst_to_recover: If rst_to_recover set, queue a controller
- *		    reset if an internal abort times out.
- */
-static int
-_hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
-			      struct domain_device *device, int abort_flag,
-			      int tag, struct hisi_sas_dq *dq, bool rst_to_recover)
-{
-	struct sas_task *task;
-	struct hisi_sas_device *sas_dev = device->lldd_dev;
-	struct hisi_sas_internal_abort abort = {
-		.flag = abort_flag,
-		.tag = tag,
-	};
-	struct device *dev = hisi_hba->dev;
-	int res;
-	/*
-	 * The interface is not realized means this HW don't support internal
-	 * abort, or don't need to do internal abort. Then here, we return
-	 * TMF_RESP_FUNC_FAILED and let other steps go on, which depends that
-	 * the internal abort has been executed and returned CQ.
-	 */
-	if (!hisi_hba->hw->prep_abort)
-		return TMF_RESP_FUNC_FAILED;
-
-	if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
-		return -EIO;
-
-	task = sas_alloc_slow_task(GFP_KERNEL);
-	if (!task)
-		return -ENOMEM;
-
-	task->dev = device;
-	task->task_proto = SAS_PROTOCOL_NONE;
-	task->task_done = hisi_sas_task_done;
-	task->slow_task->timer.function = hisi_sas_tmf_timedout;
-	task->slow_task->timer.expires = jiffies + INTERNAL_ABORT_TIMEOUT;
-	add_timer(&task->slow_task->timer);
-
-	res = hisi_sas_internal_abort_task_exec(hisi_hba, sas_dev->device_id,
-						&abort, task, dq);
-	if (res) {
-		del_timer_sync(&task->slow_task->timer);
-		dev_err(dev, "internal task abort: executing internal task failed: %d\n",
-			res);
-		goto exit;
-	}
-	wait_for_completion(&task->slow_task->completion);
-	res = TMF_RESP_FUNC_FAILED;
-
-	/* Internal abort timed out */
-	if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
-		if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
-			queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
-
-		if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-			struct hisi_sas_slot *slot = task->lldd_task;
-
-			set_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags);
-
-			if (slot) {
-				struct hisi_sas_cq *cq =
-					&hisi_hba->cq[slot->dlvry_queue];
-				/*
-				 * sync irq to avoid free'ing task
-				 * before using task in IO completion
-				 */
-				synchronize_irq(cq->irq_no);
-				slot->task = NULL;
-			}
-
-			if (rst_to_recover) {
-				dev_err(dev, "internal task abort: timeout and not done. Queuing reset.\n");
-				queue_work(hisi_hba->wq, &hisi_hba->rst_work);
-			} else {
-				dev_err(dev, "internal task abort: timeout and not done.\n");
-			}
-
-			res = -EIO;
-			goto exit;
-		} else
-			dev_err(dev, "internal task abort: timeout.\n");
-	}
-
-	if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		task->task_status.stat == TMF_RESP_FUNC_COMPLETE) {
-		res = TMF_RESP_FUNC_COMPLETE;
-		goto exit;
-	}
+	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
+	struct hisi_sas_internal_abort_data *timeout = data;
 
-	if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		task->task_status.stat == TMF_RESP_FUNC_SUCC) {
-		res = TMF_RESP_FUNC_SUCC;
-		goto exit;
-	}
+	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
+		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
 
-exit:
-	dev_dbg(dev, "internal task abort: task to dev %016llx task=%pK resp: 0x%x sts 0x%x\n",
-		SAS_ADDR(device->sas_addr), task,
-		task->task_status.resp, /* 0 is complete, -1 is undelivered */
-		task->task_status.stat);
-	sas_free_task(task);
+	if (task->task_state_flags & SAS_TASK_STATE_DONE) {
+		pr_err("Internal abort: timeout %016llx\n",
+		       SAS_ADDR(device->sas_addr));
+	} else {
+		struct hisi_sas_slot *slot = task->lldd_task;
 
-	return res;
-}
+		set_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags);
 
-static int
-hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
-			     struct domain_device *device,
-			     int abort_flag, int tag, bool rst_to_recover)
-{
-	struct hisi_sas_slot *slot;
-	struct device *dev = hisi_hba->dev;
-	struct hisi_sas_dq *dq;
-	int i, rc;
+		if (slot) {
+			struct hisi_sas_cq *cq =
+				&hisi_hba->cq[slot->dlvry_queue];
+			/*
+			 * sync irq to avoid free'ing task
+			 * before using task in IO completion
+			 */
+			synchronize_irq(cq->irq_no);
+			slot->task = NULL;
+		}
 
-	switch (abort_flag) {
-	case HISI_SAS_INT_ABT_CMD:
-		slot = &hisi_hba->slot_info[tag];
-		dq = &hisi_hba->dq[slot->dlvry_queue];
-		return _hisi_sas_internal_task_abort(hisi_hba, device,
-						     abort_flag, tag, dq,
-						     rst_to_recover);
-	case HISI_SAS_INT_ABT_DEV:
-		for (i = 0; i < hisi_hba->cq_nvecs; i++) {
-			struct hisi_sas_cq *cq = &hisi_hba->cq[i];
-			const struct cpumask *mask = cq->irq_mask;
-
-			if (mask && !cpumask_intersects(cpu_online_mask, mask))
-				continue;
-			dq = &hisi_hba->dq[i];
-			rc = _hisi_sas_internal_task_abort(hisi_hba, device,
-							   abort_flag, tag,
-							   dq, rst_to_recover);
-			if (rc)
-				return rc;
+		if (timeout->rst_ha_timeout) {
+			pr_err("Internal abort: timeout and not done %016llx. Queuing reset.\n",
+			       SAS_ADDR(device->sas_addr));
+			queue_work(hisi_hba->wq, &hisi_hba->rst_work);
+		} else {
+			pr_err("Internal abort: timeout and not done %016llx.\n",
+			       SAS_ADDR(device->sas_addr));
 		}
-		break;
-	default:
-		dev_err(dev, "Unrecognised internal abort flag (%d)\n",
-			abort_flag);
-		return -EINVAL;
+
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
@@ -2176,6 +2032,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_port_formed	= hisi_sas_port_formed,
 	.lldd_write_gpio	= hisi_sas_write_gpio,
 	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
+	.lldd_abort_timeout	= hisi_sas_internal_abort_timeout,
 };
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 441ac4b6f1f4..455d49299ddf 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2603,14 +2603,15 @@ static void hisi_sas_internal_abort_quirk_timeout(struct timer_list *t)
 }
 
 static void prep_abort_v2_hw(struct hisi_hba *hisi_hba,
-		struct hisi_sas_slot *slot,
-		int device_id, int abort_flag, int tag_to_abort)
+			     struct hisi_sas_slot *slot)
 {
 	struct sas_task *task = slot->task;
+	struct sas_internal_abort_task *abort = &task->abort_task;
 	struct domain_device *dev = task->dev;
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct hisi_sas_port *port = slot->port;
 	struct timer_list *timer = &slot->internal_abort_timer;
+	struct hisi_sas_device *sas_dev = dev->lldd_dev;
 
 	/* setup the quirk timer */
 	timer_setup(timer, hisi_sas_internal_abort_quirk_timeout, 0);
@@ -2622,13 +2623,13 @@ static void prep_abort_v2_hw(struct hisi_hba *hisi_hba,
 			       (port->id << CMD_HDR_PORT_OFF) |
 			       (dev_is_sata(dev) <<
 				CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
-			       (abort_flag << CMD_HDR_ABORT_FLAG_OFF));
+			       (abort->type << CMD_HDR_ABORT_FLAG_OFF));
 
 	/* dw1 */
-	hdr->dw1 = cpu_to_le32(device_id << CMD_HDR_DEV_ID_OFF);
+	hdr->dw1 = cpu_to_le32(sas_dev->device_id << CMD_HDR_DEV_ID_OFF);
 
 	/* dw7 */
-	hdr->dw7 = cpu_to_le32(tag_to_abort << CMD_HDR_ABORT_IPTT_OFF);
+	hdr->dw7 = cpu_to_le32(abort->tag << CMD_HDR_ABORT_IPTT_OFF);
 	hdr->transfer_tags = cpu_to_le32(slot->idx);
 }
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 914ae4e82f5e..79f87d7c3e68 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1452,28 +1452,28 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 }
 
 static void prep_abort_v3_hw(struct hisi_hba *hisi_hba,
-		struct hisi_sas_slot *slot,
-		int device_id, int abort_flag, int tag_to_abort)
+			     struct hisi_sas_slot *slot)
 {
 	struct sas_task *task = slot->task;
+	struct sas_internal_abort_task *abort = &task->abort_task;
 	struct domain_device *dev = task->dev;
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct hisi_sas_port *port = slot->port;
+	struct hisi_sas_device *sas_dev = dev->lldd_dev;
+	bool sata = dev_is_sata(dev);
 
 	/* dw0 */
-	hdr->dw0 = cpu_to_le32((5U << CMD_HDR_CMD_OFF) | /*abort*/
+	hdr->dw0 = cpu_to_le32((5U << CMD_HDR_CMD_OFF) | /* abort */
 			       (port->id << CMD_HDR_PORT_OFF) |
-				   (dev_is_sata(dev)
-					<< CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
-					(abort_flag
-					 << CMD_HDR_ABORT_FLAG_OFF));
+				(sata << CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
+				(abort->type << CMD_HDR_ABORT_FLAG_OFF));
 
 	/* dw1 */
-	hdr->dw1 = cpu_to_le32(device_id
+	hdr->dw1 = cpu_to_le32(sas_dev->device_id
 			<< CMD_HDR_DEV_ID_OFF);
 
 	/* dw7 */
-	hdr->dw7 = cpu_to_le32(tag_to_abort << CMD_HDR_ABORT_IPTT_OFF);
+	hdr->dw7 = cpu_to_le32(abort->tag << CMD_HDR_ABORT_IPTT_OFF);
 	hdr->transfer_tags = cpu_to_le32(slot->idx);
 }
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 8d6c83d15148..9c82e5dc4fcc 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -943,6 +943,7 @@ static int sas_execute_internal_abort(struct domain_device *device,
 
 		task->abort_task.tag = tag;
 		task->abort_task.type = type;
+		task->abort_task.qid = qid;
 
 		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
 		if (res) {
@@ -957,11 +958,16 @@ static int sas_execute_internal_abort(struct domain_device *device,
 
 		/* Even if the internal abort timed out, return direct. */
 		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
-			pr_err("Internal abort: timeout %016llx\n",
-			       SAS_ADDR(device->sas_addr));
+			bool quit = true;
 
+			if (i->dft->lldd_abort_timeout)
+				quit = i->dft->lldd_abort_timeout(task, data);
+			else
+				pr_err("Internal abort: timeout %016llx\n",
+				       SAS_ADDR(device->sas_addr));
 			res = -EIO;
-			break;
+			if (quit)
+				break;
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 71f632b2d2bd..ff04eb6d250b 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -565,6 +565,7 @@ enum sas_internal_abort {
 
 struct sas_internal_abort_task {
 	enum sas_internal_abort type;
+	unsigned int qid;
 	u16 tag;
 };
 
@@ -671,6 +672,7 @@ struct sas_domain_function_template {
 	/* Special TMF callbacks */
 	void (*lldd_tmf_exec_complete)(struct domain_device *dev);
 	void (*lldd_tmf_aborted)(struct sas_task *task);
+	bool (*lldd_abort_timeout)(struct sas_task *task, void *data);
 
 	/* Port and Adapter management */
 	int (*lldd_clear_nexus_port)(struct asd_sas_port *);
-- 
2.26.2

