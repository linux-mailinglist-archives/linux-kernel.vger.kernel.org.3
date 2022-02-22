Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81394BF8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiBVM6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiBVM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:58:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5436BB0E9A;
        Tue, 22 Feb 2022 04:57:40 -0800 (PST)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2zh44m5Vz67xLh;
        Tue, 22 Feb 2022 20:56:36 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 13:57:38 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:57:34 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <damien.lemoal@opensource.wdc.com>,
        <hch@lst.de>
CC:     <Ajish.Koshy@microchip.com>, <yanaijie@huawei.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <Viswas.G@microchip.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 17/18] scsi: libsas: Add sas_abort_task()
Date:   Tue, 22 Feb 2022 20:50:58 +0800
Message-ID: <1645534259-27068-18-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
References: <1645534259-27068-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Add a generic implementation of abort task TMF handler, and use in LLDDs.

With that, some LLDDs custom TMF functions can now be deleted.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  27 +-----
 drivers/scsi/libsas/sas_scsi_host.c   |  16 ++++
 drivers/scsi/mvsas/mv_sas.c           | 118 +-------------------------
 drivers/scsi/pm8001/pm8001_sas.c      | 117 +------------------------
 include/scsi/libsas.h                 |   1 +
 5 files changed, 20 insertions(+), 259 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 808eefaf3359..34ed4f8da7cc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -10,8 +10,6 @@
 #define DEV_IS_GONE(dev) \
 	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
 
-static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct sas_tmf_task *tmf);
 static int
 hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 			     struct domain_device *device,
@@ -1416,20 +1414,6 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	return rc;
 }
 
-static int hisi_sas_debug_issue_ssp_tmf(struct domain_device *device,
-				u8 *lun, struct sas_tmf_task *tmf)
-{
-	struct sas_ssp_task ssp_task;
-
-	if (!(device->tproto & SAS_PROTOCOL_SSP))
-		return TMF_RESP_FUNC_ESUPP;
-
-	memcpy(ssp_task.LUN, lun, 8);
-
-	return hisi_sas_exec_internal_tmf_task(device, &ssp_task,
-				sizeof(ssp_task), tmf);
-}
-
 static void hisi_sas_refresh_port_id(struct hisi_hba *hisi_hba)
 {
 	u32 state = hisi_hba->hw->get_phys_state(hisi_hba);
@@ -1675,8 +1659,6 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 
 static int hisi_sas_abort_task(struct sas_task *task)
 {
-	struct scsi_lun lun;
-	struct sas_tmf_task tmf_task;
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	struct hisi_hba *hisi_hba;
@@ -1711,18 +1693,11 @@ static int hisi_sas_abort_task(struct sas_task *task)
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
-		struct scsi_cmnd *cmnd = task->uldd_task;
 		struct hisi_sas_slot *slot = task->lldd_task;
 		u16 tag = slot->idx;
 		int rc2;
 
-		int_to_scsilun(cmnd->device->lun, &lun);
-		tmf_task.tmf = TMF_ABORT_TASK;
-		tmf_task.tag_of_task_to_be_managed = tag;
-
-		rc = hisi_sas_debug_issue_ssp_tmf(task->dev, lun.scsi_lun,
-						  &tmf_task);
-
+		rc = sas_abort_task(task, tag);
 		rc2 = hisi_sas_internal_task_abort(hisi_hba, device,
 						   HISI_SAS_INT_ABT_CMD, tag,
 						   false);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 1923a0627ce7..87dd18a85f6f 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1089,6 +1089,22 @@ int sas_query_task(struct sas_task *task, u16 tag)
 }
 EXPORT_SYMBOL_GPL(sas_query_task);
 
+int sas_abort_task(struct sas_task *task, u16 tag)
+{
+	struct sas_tmf_task tmf_task = {
+		.tmf = TMF_ABORT_TASK,
+		.tag_of_task_to_be_managed = tag,
+	};
+	struct scsi_cmnd *cmnd = task->uldd_task;
+	struct domain_device *dev = task->dev;
+	struct scsi_lun lun;
+
+	int_to_scsilun(cmnd->device->lun, &lun);
+
+	return sas_execute_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
+}
+EXPORT_SYMBOL_GPL(sas_abort_task);
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 63a96c307e3c..a6867dae0e7c 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1254,114 +1254,6 @@ void mvs_dev_gone(struct domain_device *dev)
 	mvs_dev_gone_notify(dev);
 }
 
-static void mvs_task_done(struct sas_task *task)
-{
-	if (!del_timer(&task->slow_task->timer))
-		return;
-	complete(&task->slow_task->completion);
-}
-
-static void mvs_tmf_timedout(struct timer_list *t)
-{
-	struct sas_task_slow *slow = from_timer(slow, t, timer);
-	struct sas_task *task = slow->task;
-
-	task->task_state_flags |= SAS_TASK_STATE_ABORTED;
-	complete(&task->slow_task->completion);
-}
-
-#define MVS_TASK_TIMEOUT 20
-static int mvs_exec_internal_tmf_task(struct domain_device *dev,
-			void *parameter, u32 para_len, struct sas_tmf_task *tmf)
-{
-	int res, retry;
-	struct sas_task *task = NULL;
-
-	for (retry = 0; retry < 3; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
-		if (!task)
-			return -ENOMEM;
-
-		task->dev = dev;
-		task->task_proto = dev->tproto;
-
-		memcpy(&task->ssp_task, parameter, para_len);
-		task->task_done = mvs_task_done;
-
-		task->slow_task->timer.function = mvs_tmf_timedout;
-		task->slow_task->timer.expires = jiffies + MVS_TASK_TIMEOUT*HZ;
-		add_timer(&task->slow_task->timer);
-
-		task->tmf = tmf;
-
-		res = mvs_queue_command(task, GFP_KERNEL);
-
-		if (res) {
-			del_timer(&task->slow_task->timer);
-			mv_printk("executing internal task failed:%d\n", res);
-			goto ex_err;
-		}
-
-		wait_for_completion(&task->slow_task->completion);
-		res = TMF_RESP_FUNC_FAILED;
-		/* Even TMF timed out, return direct. */
-		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
-			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-				mv_printk("TMF task[%x] timeout.\n", tmf->tmf);
-				goto ex_err;
-			}
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAS_SAM_STAT_GOOD) {
-			res = TMF_RESP_FUNC_COMPLETE;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		      task->task_status.stat == SAS_DATA_UNDERRUN) {
-			/* no error, but return the number of bytes of
-			 * underrun */
-			res = task->task_status.residual;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		      task->task_status.stat == SAS_DATA_OVERRUN) {
-			mv_dprintk("blocked task error.\n");
-			res = -EMSGSIZE;
-			break;
-		} else {
-			mv_dprintk(" task to dev %016llx response: 0x%x "
-				    "status 0x%x\n",
-				    SAS_ADDR(dev->sas_addr),
-				    task->task_status.resp,
-				    task->task_status.stat);
-			sas_free_task(task);
-			task = NULL;
-
-		}
-	}
-ex_err:
-	BUG_ON(retry == 3 && task != NULL);
-	sas_free_task(task);
-	return res;
-}
-
-static int mvs_debug_issue_ssp_tmf(struct domain_device *dev,
-				u8 *lun, struct sas_tmf_task *tmf)
-{
-	struct sas_ssp_task ssp_task;
-	if (!(dev->tproto & SAS_PROTOCOL_SSP))
-		return TMF_RESP_FUNC_ESUPP;
-
-	memcpy(ssp_task.LUN, lun, 8);
-
-	return mvs_exec_internal_tmf_task(dev, &ssp_task,
-				sizeof(ssp_task), tmf);
-}
-
-
 /*  Standard mandates link reset for ATA  (type 0)
     and hard reset for SSP (type 1) , only for RECOVERY */
 static int mvs_debug_I_T_nexus_reset(struct domain_device *dev)
@@ -1452,8 +1344,6 @@ int mvs_query_task(struct sas_task *task)
 /*  mandatory SAM-3, still need free task/slot info */
 int mvs_abort_task(struct sas_task *task)
 {
-	struct scsi_lun lun;
-	struct sas_tmf_task tmf_task;
 	struct domain_device *dev = task->dev;
 	struct mvs_device *mvi_dev = (struct mvs_device *)dev->lldd_dev;
 	struct mvs_info *mvi;
@@ -1477,9 +1367,6 @@ int mvs_abort_task(struct sas_task *task)
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 	mvi_dev->dev_status = MVS_DEV_EH;
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
-		struct scsi_cmnd * cmnd = (struct scsi_cmnd *)task->uldd_task;
-
-		int_to_scsilun(cmnd->device->lun, &lun);
 		rc = mvs_find_tag(mvi, task, &tag);
 		if (rc == 0) {
 			mv_printk("No such tag in %s\n", __func__);
@@ -1487,10 +1374,7 @@ int mvs_abort_task(struct sas_task *task)
 			return rc;
 		}
 
-		tmf_task.tmf = TMF_ABORT_TASK;
-		tmf_task.tag_of_task_to_be_managed = cpu_to_le16(tag);
-
-		rc = mvs_debug_issue_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
+		rc = sas_abort_task(task, tag);
 
 		/* if successful, clear the task and callback forwards.*/
 		if (rc == TMF_RESP_FUNC_COMPLETE) {
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index e8bdc3390019..828d719afa1b 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -706,103 +706,6 @@ static void pm8001_tmf_timedout(struct timer_list *t)
 }
 
 #define PM8001_TASK_TIMEOUT 20
-/**
-  * pm8001_exec_internal_tmf_task - execute some task management commands.
-  * @dev: the wanted device.
-  * @tmf: which task management wanted to be take.
-  * @para_len: para_len.
-  * @parameter: ssp task parameter.
-  *
-  * when errors or exception happened, we may want to do something, for example
-  * abort the issued task which result in this exception, it is done by calling
-  * this function, note it is also with the task execute interface.
-  */
-static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
-	void *parameter, u32 para_len, struct sas_tmf_task *tmf)
-{
-	int res, retry;
-	struct sas_task *task = NULL;
-	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
-	struct pm8001_device *pm8001_dev = dev->lldd_dev;
-	DECLARE_COMPLETION_ONSTACK(completion_setstate);
-
-	for (retry = 0; retry < 3; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
-		if (!task)
-			return -ENOMEM;
-
-		task->dev = dev;
-		task->task_proto = dev->tproto;
-		memcpy(&task->ssp_task, parameter, para_len);
-		task->task_done = pm8001_task_done;
-		task->slow_task->timer.function = pm8001_tmf_timedout;
-		task->slow_task->timer.expires = jiffies + PM8001_TASK_TIMEOUT*HZ;
-		add_timer(&task->slow_task->timer);
-
-		task->tmf = tmf;
-
-		res = pm8001_queue_command(task, GFP_KERNEL);
-
-		if (res) {
-			del_timer(&task->slow_task->timer);
-			pm8001_dbg(pm8001_ha, FAIL, "Executing internal task failed\n");
-			goto ex_err;
-		}
-		wait_for_completion(&task->slow_task->completion);
-		if (pm8001_ha->chip_id != chip_8001) {
-			pm8001_dev->setds_completion = &completion_setstate;
-			PM8001_CHIP_DISP->set_dev_state_req(pm8001_ha,
-				pm8001_dev, DS_OPERATIONAL);
-			wait_for_completion(&completion_setstate);
-		}
-		res = -TMF_RESP_FUNC_FAILED;
-		/* Even TMF timed out, return direct. */
-		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
-			struct pm8001_ccb_info *ccb = task->lldd_task;
-
-			pm8001_dbg(pm8001_ha, FAIL, "TMF task[%x]timeout.\n",
-				   tmf->tmf);
-
-			if (ccb)
-				ccb->task = NULL;
-			goto ex_err;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAS_SAM_STAT_GOOD) {
-			res = TMF_RESP_FUNC_COMPLETE;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		task->task_status.stat == SAS_DATA_UNDERRUN) {
-			/* no error, but return the number of bytes of
-			* underrun */
-			res = task->task_status.residual;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAS_DATA_OVERRUN) {
-			pm8001_dbg(pm8001_ha, FAIL, "Blocked task error.\n");
-			res = -EMSGSIZE;
-			break;
-		} else {
-			pm8001_dbg(pm8001_ha, EH,
-				   " Task to dev %016llx response:0x%x status 0x%x\n",
-				   SAS_ADDR(dev->sas_addr),
-				   task->task_status.resp,
-				   task->task_status.stat);
-			sas_free_task(task);
-			task = NULL;
-		}
-	}
-ex_err:
-	BUG_ON(retry == 3 && task != NULL);
-	sas_free_task(task);
-	return res;
-}
-
 static int
 pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
 	struct pm8001_device *pm8001_dev, struct domain_device *dev, u32 flag,
@@ -910,18 +813,6 @@ void pm8001_dev_gone(struct domain_device *dev)
 	pm8001_dev_gone_notify(dev);
 }
 
-static int pm8001_issue_ssp_tmf(struct domain_device *dev,
-	u8 *lun, struct sas_tmf_task *tmf)
-{
-	struct sas_ssp_task ssp_task;
-	if (!(dev->tproto & SAS_PROTOCOL_SSP))
-		return TMF_RESP_FUNC_ESUPP;
-
-	memcpy((u8 *)&ssp_task.LUN, lun, 8);
-	return pm8001_exec_internal_tmf_task(dev, &ssp_task, sizeof(ssp_task),
-		tmf);
-}
-
 /* retry commands by ha, by task and/or by device */
 void pm8001_open_reject_retry(
 	struct pm8001_hba_info *pm8001_ha,
@@ -1181,9 +1072,7 @@ int pm8001_abort_task(struct sas_task *task)
 	u32 tag;
 	struct domain_device *dev ;
 	struct pm8001_hba_info *pm8001_ha;
-	struct scsi_lun lun;
 	struct pm8001_device *pm8001_dev;
-	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED, ret;
 	u32 phy_id, port_id;
 	struct sas_task_slow slow_task;
@@ -1219,11 +1108,7 @@ int pm8001_abort_task(struct sas_task *task)
 	}
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 	if (task->task_proto & SAS_PROTOCOL_SSP) {
-		struct scsi_cmnd *cmnd = task->uldd_task;
-		int_to_scsilun(cmnd->device->lun, &lun);
-		tmf_task.tmf = TMF_ABORT_TASK;
-		tmf_task.tag_of_task_to_be_managed = tag;
-		rc = pm8001_issue_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
+		rc = sas_abort_task(task, tag);
 		pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
 			pm8001_dev->sas_device, 0, tag);
 	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index bf8613fb1c4e..4ea964d33600 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -726,6 +726,7 @@ int sas_abort_task_set(struct domain_device *dev, u8 *lun);
 int sas_clear_task_set(struct domain_device *dev, u8 *lun);
 int sas_lu_reset(struct domain_device *dev, u8 *lun);
 int sas_query_task(struct sas_task *task, u16 tag);
+int sas_abort_task(struct sas_task *task, u16 tag);
 
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
-- 
2.26.2

