Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2765AEFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiIFP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiIFPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25C1CB02;
        Tue,  6 Sep 2022 08:14:49 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMTNP2xH5z67Klm;
        Tue,  6 Sep 2022 23:10:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:14:47 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:14:43 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFT v3 3/6] scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
Date:   Tue, 6 Sep 2022 23:08:07 +0800
Message-ID: <1662476890-15467-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
References: <1662476890-15467-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
b. Issue SATA_ABORT all command

Indeed, in libata EH, we do similar to above:
a. ata_do_eh() -> ata_eh_autopsy() -> ata_eh_link_autopsy() ->
   ata_eh_analyze_ncq_error() -> ata_eh_read_log_10h()
b. ata_do_eh() -> ata_eh_recover() which will issue a device soft reset
   or hard reset

Since there is so much duplication, use sas_ata_device_link_abort() which
will abort all pending IOs and kick of ATA EH which will do the steps,
above.

However we will not follow the advisory to send the SATA_ABORT all command
after the autopsy in read log ext10. Indeed, in libsas EH, we already send
a per-task SATA_ABORT command, and this is prior to the ATA EH kicking in
and issuing the read log ext10 in the recovery process. I judge that this
is ok as the SATA_ABORT command does not actually send any protocol on the
link to abort IO on the other side, so would not change any state on the
disk (for the read log ext10 command).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 171 +++----------------------------
 drivers/scsi/pm8001/pm8001_sas.h |   4 -
 drivers/scsi/pm8001/pm80xx_hwi.c | 163 ++---------------------------
 3 files changed, 19 insertions(+), 319 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 1c8a43bf54ad..0bc16994f0b5 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1724,7 +1724,14 @@ void pm8001_work_fn(struct work_struct *work)
 				pm8001_free_dev(pm8001_dev);
 			}
 		}
-	}	break;
+	}
+	break;
+	case IO_XFER_ERROR_ABORTED_NCQ_MODE:
+	{
+		dev = pm8001_dev->sas_device;
+		sas_ata_device_link_abort(dev, false);
+	}
+	break;
 	}
 	kfree(pw);
 }
@@ -1748,110 +1755,6 @@ int pm8001_handle_event(struct pm8001_hba_info *pm8001_ha, void *data,
 	return ret;
 }
 
-static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
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
-
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
-	if (ret) {
-		sas_free_task(task);
-		pm8001_ccb_free(pm8001_ha, ccb);
-	}
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
-}
-
 /**
  * mpi_ssp_completion- process the event that FW response to the SSP request.
  * @pm8001_ha: our hba card information
@@ -2301,8 +2204,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		return;
 	}
 
-	if ((pm8001_dev && !(pm8001_dev->id & NCQ_READ_LOG_FLAG))
-		&& unlikely(!t || !t->lldd_task || !t->dev)) {
+	if (pm8001_dev && unlikely(!t || !t->lldd_task || !t->dev)) {
 		pm8001_dbg(pm8001_ha, FAIL, "task or dev null\n");
 		return;
 	}
@@ -2360,15 +2262,6 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
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
@@ -2666,9 +2559,10 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
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
 
@@ -3645,12 +3539,7 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
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
@@ -4202,7 +4091,6 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 	u64 phys_addr;
 	u32 ATAP = 0x0;
 	u32 dir;
-	unsigned long flags;
 	u32  opc = OPC_INB_SATA_HOST_OPSTART;
 
 	memset(&sata_cmd, 0, sizeof(sata_cmd));
@@ -4257,39 +4145,6 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
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
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index c5e3f380a01c..571ed927298b 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -579,10 +579,6 @@ struct pm8001_fw_image_header {
 #define FLASH_UPDATE_DNLD_NOT_SUPPORTED		0x10
 #define FLASH_UPDATE_DISABLED			0x11
 
-#define	NCQ_READ_LOG_FLAG			0x80000000
-#define	NCQ_ABORT_ALL_FLAG			0x40000000
-#define	NCQ_2ND_RLE_FLAG			0x20000000
-
 /* Device states */
 #define DS_OPERATIONAL				0x01
 #define DS_PORT_IN_RESET			0x02
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

