Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412B0597250
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiHQO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiHQO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:58:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436734A818;
        Wed, 17 Aug 2022 07:58:43 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7B0830xzz67fK4;
        Wed, 17 Aug 2022 22:55:36 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:58:41 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:58:38 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <yangxingui@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/6] scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
Date:   Wed, 17 Aug 2022 22:52:11 +0800
Message-ID: <1660747934-60059-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
References: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c6b9ef5779c3 ("[SCSI] pm80xx: NCQ error handling changes") the
driver had support added to handle NCQ errors but much of what is done
in this handling is duplicated from the libata EH.

In that named commit we handle in 2x main steps:
a. Issue read log ext10 to examine and clear the errors
b. Issue SATA_ABORT command

Indeed, in libata EH, we do similar to above:
a. ata_do_eh() -> ata_eh_autopsy() -> ata_eh_link_autopsy() ->#
   ata_eh_analyze_ncq_error() -> ata_eh_read_log_10h()
b. ata_do_eh() -> ata_eh_recover() which will issue a device soft reset
   or hard reset

Since there is so much duplication, use sas_ata_link_abort() which will
abort all pending IOs and kick off ATA EH which will do the steps, above.

The pm8001_send_abort_all() call to issue the SATA_ABORT command is added
in pm8001_I_T_nexus_reset() [which is called from ata_eh_recover() to
issue the device reset] as there is currently no better place to locate it.
In future if we add ata_port_operations.softreset callback implementation
for libsas then that may be better.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 179 ++++++++-----------------------
 drivers/scsi/pm8001/pm8001_sas.c |   5 +
 drivers/scsi/pm8001/pm8001_sas.h |   8 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 163 ++--------------------------
 4 files changed, 58 insertions(+), 297 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 1c8a43bf54ad..82de80bb12f3 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1724,7 +1724,15 @@ void pm8001_work_fn(struct work_struct *work)
 				pm8001_free_dev(pm8001_dev);
 			}
 		}
-	}	break;
+	}
+	break;
+	case IO_XFER_ERROR_ABORTED_NCQ_MODE:
+	{
+		pm8001_dev->id |= NCQ_ERR_FLAG;
+		dev = pm8001_dev->sas_device;
+		sas_ata_device_link_abort(dev);
+	}
+	break;
 	}
 	kfree(pw);
 }
@@ -1748,108 +1756,47 @@ int pm8001_handle_event(struct pm8001_hba_info *pm8001_ha, void *data,
 	return ret;
 }
 
-static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_device *pm8001_ha_dev)
+void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
+		struct pm8001_device *pm8001_dev)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	struct pm8001_ccb_info *ccb;
-	struct sas_task *task;
 	struct task_abort_req task_abort;
 	u32 opc = OPC_INB_SATA_ABORT;
+	struct domain_device *dev = pm8001_dev->sas_device;
 	int ret;
 
-	pm8001_ha_dev->id |= NCQ_ABORT_ALL_FLAG;
-	pm8001_ha_dev->id &= ~NCQ_READ_LOG_FLAG;
-
-	task = sas_alloc_slow_task(GFP_ATOMIC);
-	if (!task) {
-		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task\n");
-		return;
-	}
-
-	task->task_done = pm8001_task_done;
-
-	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
-	if (!ccb) {
-		sas_free_task(task);
+	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
+	if (!ccb)
 		return;
-	}
 
 	memset(&task_abort, 0, sizeof(task_abort));
 	task_abort.abort_all = cpu_to_le32(1);
-	task_abort.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
+	task_abort.device_id = cpu_to_le32(pm8001_dev->device_id);
 	task_abort.tag = cpu_to_le32(ccb->ccb_tag);
-
+	pm8001_dev->sata_abort_all_completion = &completion;
+	pm8001_dev->id |= NCQ_ERR_ABORT_ALL_FLAG;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
 				   sizeof(task_abort), 0);
 	if (ret) {
-		sas_free_task(task);
+		pm8001_dev->sata_abort_all_completion = NULL;
 		pm8001_ccb_free(pm8001_ha, ccb);
 	}
-}
-
-static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_device *pm8001_ha_dev)
-{
-	struct sata_start_req sata_cmd;
-	int res;
-	struct pm8001_ccb_info *ccb;
-	struct sas_task *task = NULL;
-	struct host_to_dev_fis fis;
-	struct domain_device *dev;
-	u32 opc = OPC_INB_SATA_HOST_OPSTART;
-
-	task = sas_alloc_slow_task(GFP_ATOMIC);
-	if (!task) {
-		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task !!!\n");
-		return;
-	}
-	task->task_done = pm8001_task_done;
 
 	/*
-	 * Allocate domain device by ourselves as libsas is not going to
-	 * provide any.
+	 * It's always wise to use a timeout when dealing with HW.
+	 * The value is abritary, same as PM8001_TASK_TIMEOUT at time of
+	 * writing.
 	 */
-	dev = kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
-	if (!dev) {
-		sas_free_task(task);
-		pm8001_dbg(pm8001_ha, FAIL,
-			   "Domain device cannot be allocated\n");
-		return;
-	}
-	task->dev = dev;
-	task->dev->lldd_dev = pm8001_ha_dev;
-
-	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
-	if (!ccb) {
-		sas_free_task(task);
-		kfree(dev);
-		return;
-	}
-
-	pm8001_ha_dev->id |= NCQ_READ_LOG_FLAG;
-	pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
-
-	/* construct read log FIS */
-	memset(&fis, 0, sizeof(struct host_to_dev_fis));
-	fis.fis_type = 0x27;
-	fis.flags = 0x80;
-	fis.command = ATA_CMD_READ_LOG_EXT;
-	fis.lbal = 0x10;
-	fis.sector_count = 0x1;
-
-	memset(&sata_cmd, 0, sizeof(sata_cmd));
-	sata_cmd.tag = cpu_to_le32(ccb->ccb_tag);
-	sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
-	sata_cmd.ncqtag_atap_dir_m = cpu_to_le32((0x1 << 7) | (0x5 << 9));
-	memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
-
-	res = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sata_cmd,
-				   sizeof(sata_cmd), 0);
-	if (res) {
-		sas_free_task(task);
-		pm8001_ccb_free(pm8001_ha, ccb);
-		kfree(dev);
-	}
+	ret = wait_for_completion_timeout(&completion, 20 * HZ);
+	if (!ret)
+		pm8001_dbg(pm8001_ha, FAIL, "Failed to send SATA ABORT ALL:%016llx\n",
+			   SAS_ADDR(dev->sas_addr));
+
+	pm8001_dev->sata_abort_all_completion = NULL;
+	/* Clear the flag regardless - not much else which we can do */
+	pm8001_dev->id	&= ~NCQ_ERR_FLAG;
+	pm8001_dev->id	&= ~NCQ_ERR_ABORT_ALL_FLAG;
 }
 
 /**
@@ -2301,8 +2248,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		return;
 	}
 
-	if ((pm8001_dev && !(pm8001_dev->id & NCQ_READ_LOG_FLAG))
-		&& unlikely(!t || !t->lldd_task || !t->dev)) {
+	if (pm8001_dev && unlikely(!t || !t->lldd_task || !t->dev)) {
 		pm8001_dbg(pm8001_ha, FAIL, "task or dev null\n");
 		return;
 	}
@@ -2360,15 +2306,6 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_SAM_STAT_GOOD;
-			/* check if response is for SEND READ LOG */
-			if (pm8001_dev &&
-			    (pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
-				pm8001_send_abort_all(pm8001_ha, pm8001_dev);
-				/* Free the tag */
-				pm8001_tag_free(pm8001_ha, tag);
-				sas_free_task(t);
-				return;
-			}
 		} else {
 			u8 len;
 			ts->resp = SAS_TASK_COMPLETE;
@@ -2666,9 +2603,10 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	if (event == IO_XFER_ERROR_ABORTED_NCQ_MODE) {
 		/* find device using device id */
 		pm8001_dev = pm8001_find_dev(pm8001_ha, dev_id);
-		/* send read log extension */
 		if (pm8001_dev)
-			pm8001_send_read_log(pm8001_ha, pm8001_dev);
+			pm8001_handle_event(pm8001_ha,
+				pm8001_dev,
+				IO_XFER_ERROR_ABORTED_NCQ_MODE);
 		return;
 	}
 
@@ -3619,6 +3557,12 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	t = ccb->task;
 	pm8001_dev = ccb->device; /* retrieve device */
 
+	if (pm8001_dev->id & NCQ_ERR_ABORT_ALL_FLAG) {
+		if (pm8001_dev->sata_abort_all_completion)
+			complete(pm8001_dev->sata_abort_all_completion);
+		return 0;
+	}
+
 	if (!t)	{
 		pm8001_dbg(pm8001_ha, FAIL, " TASK NULL. RETURNING !!!\n");
 		return -1;
@@ -3645,12 +3589,7 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	pm8001_ccb_task_free(pm8001_ha, ccb);
 	mb();
 
-	if (pm8001_dev->id & NCQ_ABORT_ALL_FLAG) {
-		sas_free_task(t);
-		pm8001_dev->id &= ~NCQ_ABORT_ALL_FLAG;
-	} else {
-		t->task_done(t);
-	}
+	t->task_done(t);
 
 	return 0;
 }
@@ -4202,7 +4141,6 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 	u64 phys_addr;
 	u32 ATAP = 0x0;
 	u32 dir;
-	unsigned long flags;
 	u32  opc = OPC_INB_SATA_HOST_OPSTART;
 
 	memset(&sata_cmd, 0, sizeof(sata_cmd));
@@ -4257,39 +4195,6 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 		sata_cmd.esgl = 0;
 	}
 
-	/* Check for read log for failed drive and return */
-	if (sata_cmd.sata_fis.command == 0x2f) {
-		if (((pm8001_ha_dev->id & NCQ_READ_LOG_FLAG) ||
-			(pm8001_ha_dev->id & NCQ_ABORT_ALL_FLAG) ||
-			(pm8001_ha_dev->id & NCQ_2ND_RLE_FLAG))) {
-			struct task_status_struct *ts;
-
-			pm8001_ha_dev->id &= 0xDFFFFFFF;
-			ts = &task->task_status;
-
-			spin_lock_irqsave(&task->task_state_lock, flags);
-			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAS_SAM_STAT_GOOD;
-			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
-			task->task_state_flags |= SAS_TASK_STATE_DONE;
-			if (unlikely((task->task_state_flags &
-					SAS_TASK_STATE_ABORTED))) {
-				spin_unlock_irqrestore(&task->task_state_lock,
-							flags);
-				pm8001_dbg(pm8001_ha, FAIL,
-					   "task 0x%p resp 0x%x  stat 0x%x but aborted by upper layer\n",
-					   task, ts->resp,
-					   ts->stat);
-				pm8001_ccb_task_free(pm8001_ha, ccb);
-			} else {
-				spin_unlock_irqrestore(&task->task_state_lock,
-							flags);
-				pm8001_ccb_task_free_done(pm8001_ha, ccb);
-				return 0;
-			}
-		}
-	}
-
 	return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sata_cmd,
 				    sizeof(sata_cmd), 0);
 }
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ca29d1454b66..895203975e47 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -822,6 +822,11 @@ int pm8001_I_T_nexus_reset(struct domain_device *dev)
 
 	pm8001_dev = dev->lldd_dev;
 	pm8001_ha = pm8001_find_ha_by_dev(dev);
+
+	/* If in NCQ ABORT MODE then we need to issue a SATA_ABORT */
+	if (pm8001_dev->id & NCQ_ERR_FLAG)
+		pm8001_send_abort_all(pm8001_ha, pm8001_dev);
+
 	phy = sas_get_local_phy(dev);
 
 	if (dev_is_sata(dev)) {
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index c5e3f380a01c..1f602e0dbe92 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -266,6 +266,7 @@ struct pm8001_device {
 	u32			id;
 	struct completion	*dcompletion;
 	struct completion	*setds_completion;
+	struct completion	*sata_abort_all_completion;
 	u32			device_id;
 	atomic_t		running_req;
 };
@@ -579,9 +580,8 @@ struct pm8001_fw_image_header {
 #define FLASH_UPDATE_DNLD_NOT_SUPPORTED		0x10
 #define FLASH_UPDATE_DISABLED			0x11
 
-#define	NCQ_READ_LOG_FLAG			0x80000000
-#define	NCQ_ABORT_ALL_FLAG			0x40000000
-#define	NCQ_2ND_RLE_FLAG			0x20000000
+#define	NCQ_ERR_FLAG			0x20000000
+#define	NCQ_ERR_ABORT_ALL_FLAG	0x40000000
 
 /* Device states */
 #define DS_OPERATIONAL				0x01
@@ -661,6 +661,8 @@ void pm8001_open_reject_retry(
 int pm8001_mem_alloc(struct pci_dev *pdev, void **virt_addr,
 	dma_addr_t *pphys_addr, u32 *pphys_addr_hi, u32 *pphys_addr_lo,
 	u32 mem_size, u32 align);
+void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
+		struct pm8001_device *pm8001_ha_dev);
 
 void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha);
 int pm8001_mpi_build_cmd(struct pm8001_hba_info *pm8001_ha,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index dd0e06983cd3..4484c498bcb6 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1778,113 +1778,6 @@ pm80xx_chip_interrupt_disable(struct pm8001_hba_info *pm8001_ha, u8 vec)
 	pm80xx_chip_intx_interrupt_disable(pm8001_ha);
 }
 
-static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_device *pm8001_ha_dev)
-{
-	struct pm8001_ccb_info *ccb;
-	struct sas_task *task;
-	struct task_abort_req task_abort;
-	u32 opc = OPC_INB_SATA_ABORT;
-	int ret;
-
-	pm8001_ha_dev->id |= NCQ_ABORT_ALL_FLAG;
-	pm8001_ha_dev->id &= ~NCQ_READ_LOG_FLAG;
-
-	task = sas_alloc_slow_task(GFP_ATOMIC);
-	if (!task) {
-		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task\n");
-		return;
-	}
-	task->task_done = pm8001_task_done;
-
-	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
-	if (!ccb) {
-		sas_free_task(task);
-		return;
-	}
-
-	memset(&task_abort, 0, sizeof(task_abort));
-	task_abort.abort_all = cpu_to_le32(1);
-	task_abort.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
-	task_abort.tag = cpu_to_le32(ccb->ccb_tag);
-
-	ret = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
-				   sizeof(task_abort), 0);
-	pm8001_dbg(pm8001_ha, FAIL, "Executing abort task end\n");
-	if (ret) {
-		sas_free_task(task);
-		pm8001_ccb_free(pm8001_ha, ccb);
-	}
-}
-
-static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
-		struct pm8001_device *pm8001_ha_dev)
-{
-	struct sata_start_req sata_cmd;
-	int res;
-	struct pm8001_ccb_info *ccb;
-	struct sas_task *task = NULL;
-	struct host_to_dev_fis fis;
-	struct domain_device *dev;
-	u32 opc = OPC_INB_SATA_HOST_OPSTART;
-
-	task = sas_alloc_slow_task(GFP_ATOMIC);
-	if (!task) {
-		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task !!!\n");
-		return;
-	}
-	task->task_done = pm8001_task_done;
-
-	/*
-	 * Allocate domain device by ourselves as libsas is not going to
-	 * provide any.
-	 */
-	dev = kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
-	if (!dev) {
-		sas_free_task(task);
-		pm8001_dbg(pm8001_ha, FAIL,
-			   "Domain device cannot be allocated\n");
-		return;
-	}
-
-	task->dev = dev;
-	task->dev->lldd_dev = pm8001_ha_dev;
-
-	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
-	if (!ccb) {
-		sas_free_task(task);
-		kfree(dev);
-		return;
-	}
-
-	pm8001_ha_dev->id |= NCQ_READ_LOG_FLAG;
-	pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
-
-	memset(&sata_cmd, 0, sizeof(sata_cmd));
-
-	/* construct read log FIS */
-	memset(&fis, 0, sizeof(struct host_to_dev_fis));
-	fis.fis_type = 0x27;
-	fis.flags = 0x80;
-	fis.command = ATA_CMD_READ_LOG_EXT;
-	fis.lbal = 0x10;
-	fis.sector_count = 0x1;
-
-	sata_cmd.tag = cpu_to_le32(ccb->ccb_tag);
-	sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
-	sata_cmd.ncqtag_atap_dir_m_dad = cpu_to_le32(((0x1 << 7) | (0x5 << 9)));
-	memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
-
-	res = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sata_cmd,
-				   sizeof(sata_cmd), 0);
-	pm8001_dbg(pm8001_ha, FAIL, "Executing read log end\n");
-	if (res) {
-		sas_free_task(task);
-		pm8001_ccb_free(pm8001_ha, ccb);
-		kfree(dev);
-	}
-}
-
 /**
  * mpi_ssp_completion - process the event that FW response to the SSP request.
  * @pm8001_ha: our hba card information
@@ -2402,11 +2295,9 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 		return;
 	}
 
-	if ((pm8001_dev && !(pm8001_dev->id & NCQ_READ_LOG_FLAG))
-		&& unlikely(!t || !t->lldd_task || !t->dev)) {
-		pm8001_dbg(pm8001_ha, FAIL, "task or dev null\n");
+
+	if (pm8001_dev && unlikely(!t->lldd_task || !t->dev))
 		return;
-	}
 
 	ts = &t->task_status;
 
@@ -2463,15 +2354,6 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_SAM_STAT_GOOD;
-			/* check if response is for SEND READ LOG */
-			if (pm8001_dev &&
-			    (pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
-				pm80xx_send_abort_all(pm8001_ha, pm8001_dev);
-				/* Free the tag */
-				pm8001_tag_free(pm8001_ha, tag);
-				sas_free_task(t);
-				return;
-			}
 		} else {
 			u8 len;
 			ts->resp = SAS_TASK_COMPLETE;
@@ -2806,9 +2688,11 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha,
 	if (event == IO_XFER_ERROR_ABORTED_NCQ_MODE) {
 		/* find device using device id */
 		pm8001_dev = pm8001_find_dev(pm8001_ha, dev_id);
-		/* send read log extension */
+		/* send read log extension by aborting the link - libata does what we want */
 		if (pm8001_dev)
-			pm80xx_send_read_log(pm8001_ha, pm8001_dev);
+			pm8001_handle_event(pm8001_ha,
+				pm8001_dev,
+				IO_XFER_ERROR_ABORTED_NCQ_MODE);
 		return;
 	}
 
@@ -4556,7 +4440,6 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 	u32 end_addr_high, end_addr_low;
 	u32 ATAP = 0x0;
 	u32 dir;
-	unsigned long flags;
 	u32 opc = OPC_INB_SATA_HOST_OPSTART;
 	memset(&sata_cmd, 0, sizeof(sata_cmd));
 
@@ -4735,40 +4618,6 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 				     (task->ata_task.atapi_packet[15] << 24)));
 	}
 
-	/* Check for read log for failed drive and return */
-	if (sata_cmd.sata_fis.command == 0x2f) {
-		if (pm8001_ha_dev && ((pm8001_ha_dev->id & NCQ_READ_LOG_FLAG) ||
-			(pm8001_ha_dev->id & NCQ_ABORT_ALL_FLAG) ||
-			(pm8001_ha_dev->id & NCQ_2ND_RLE_FLAG))) {
-			struct task_status_struct *ts;
-
-			pm8001_ha_dev->id &= 0xDFFFFFFF;
-			ts = &task->task_status;
-
-			spin_lock_irqsave(&task->task_state_lock, flags);
-			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAS_SAM_STAT_GOOD;
-			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
-			task->task_state_flags |= SAS_TASK_STATE_DONE;
-			if (unlikely((task->task_state_flags &
-					SAS_TASK_STATE_ABORTED))) {
-				spin_unlock_irqrestore(&task->task_state_lock,
-							flags);
-				pm8001_dbg(pm8001_ha, FAIL,
-					   "task 0x%p resp 0x%x  stat 0x%x but aborted by upper layer\n",
-					   task, ts->resp,
-					   ts->stat);
-				pm8001_ccb_task_free(pm8001_ha, ccb);
-				return 0;
-			} else {
-				spin_unlock_irqrestore(&task->task_state_lock,
-							flags);
-				pm8001_ccb_task_free_done(pm8001_ha, ccb);
-				atomic_dec(&pm8001_ha_dev->running_req);
-				return 0;
-			}
-		}
-	}
 	trace_pm80xx_request_issue(pm8001_ha->id,
 				ccb->device ? ccb->device->attached_phy : PM8001_MAX_PHYS,
 				ccb->ccb_tag, opc,
-- 
2.35.3

