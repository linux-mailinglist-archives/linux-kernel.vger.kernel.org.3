Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE60F49B315
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383011AbiAYLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:43:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4498 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382284AbiAYLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:48 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlBF2hR3z689R4;
        Tue, 25 Jan 2022 19:34:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:44 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:41 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 06/16] scsi: libsas: Add sas_task.tmf
Date:   Tue, 25 Jan 2022 19:32:42 +0800
Message-ID: <1643110372-85470-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pointer to a sas_tmf_task to the sas_task struct, as this will be
used when the common LLDD TMF code is factored out.

Also set it for the LLDDs to store per-sas_task TMF info.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 25 +++++++++---------------
 drivers/scsi/mvsas/mv_sas.c           | 15 ++++++--------
 drivers/scsi/pm8001/pm8001_sas.c      | 28 ++++++++++-----------------
 include/scsi/libsas.h                 |  1 +
 4 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index db6f8ea7864d..4f146aa50423 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -400,8 +400,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 			   struct hisi_sas_slot *slot,
 			   struct hisi_sas_dq *dq,
 			   struct hisi_sas_device *sas_dev,
-			   struct hisi_sas_internal_abort *abort,
-			   struct sas_tmf_task *tmf)
+			   struct hisi_sas_internal_abort *abort)
 {
 	struct hisi_sas_cmd_hdr *cmd_hdr_base;
 	int dlvry_queue_slot, dlvry_queue;
@@ -427,8 +426,6 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 	cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
 	slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
 
-	slot->tmf = tmf;
-	slot->is_internal = tmf;
 	task->lldd_task = slot;
 
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
@@ -471,8 +468,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 	spin_unlock(&dq->lock);
 }
 
-static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
-			      struct sas_tmf_task *tmf)
+static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
 	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
 	struct domain_device *device = task->dev;
@@ -583,11 +579,11 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 	slot->task = task;
 	slot->port = port;
 
-	slot->tmf = tmf;
-	slot->is_internal = tmf;
+	slot->tmf = task->tmf;
+	slot->is_internal = task->tmf;
 
 	/* protect task_prep and start_delivery sequence */
-	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL, tmf);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL);
 
 	return 0;
 
@@ -1115,11 +1111,6 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 	up(&hisi_hba->sem);
 }
 
-static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
-{
-	return hisi_sas_task_exec(task, gfp_flags, NULL);
-}
-
 static int hisi_sas_phy_set_linkrate(struct hisi_hba *hisi_hba, int phy_no,
 			struct sas_phy_linkrates *r)
 {
@@ -1273,7 +1264,9 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
 		add_timer(&task->slow_task->timer);
 
-		res = hisi_sas_task_exec(task, GFP_KERNEL, tmf);
+		task->tmf = tmf;
+
+		res = hisi_sas_queue_command(task, GFP_KERNEL);
 		if (res) {
 			del_timer_sync(&task->slow_task->timer);
 			dev_err(dev, "abort tmf: executing internal task failed: %d\n",
@@ -2054,7 +2047,7 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	slot->port = port;
 	slot->is_internal = true;
 
-	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort, NULL);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort);
 
 	return 0;
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 22bffaaf2eb0..5105d55eb00c 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -840,14 +840,14 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	return rc;
 }
 
-static int mvs_task_exec(struct sas_task *task, gfp_t gfp_flags,
-				struct completion *completion, int is_tmf,
-				struct sas_tmf_task *tmf)
+int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
 	struct mvs_info *mvi = NULL;
 	u32 rc = 0;
 	u32 pass = 0;
 	unsigned long flags = 0;
+	struct sas_tmf_task *tmf = task->tmf;
+	int is_tmf = !!task->tmf;
 
 	mvi = ((struct mvs_device *)task->dev->lldd_dev)->mvi_info;
 
@@ -864,11 +864,6 @@ static int mvs_task_exec(struct sas_task *task, gfp_t gfp_flags,
 	return rc;
 }
 
-int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
-{
-	return mvs_task_exec(task, gfp_flags, NULL, 0, NULL);
-}
-
 static void mvs_slot_free(struct mvs_info *mvi, u32 rx_desc)
 {
 	u32 slot_idx = rx_desc & RXQ_SLOT_MASK;
@@ -1300,7 +1295,9 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 		task->slow_task->timer.expires = jiffies + MVS_TASK_TIMEOUT*HZ;
 		add_timer(&task->slow_task->timer);
 
-		res = mvs_task_exec(task, GFP_KERNEL, NULL, 1, tmf);
+		task->tmf = tmf;
+
+		res = mvs_queue_command(task, GFP_KERNEL);
 
 		if (res) {
 			del_timer(&task->slow_task->timer);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 0a3701d97549..323b172243b8 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -371,15 +371,14 @@ static int sas_find_local_port_id(struct domain_device *dev)
 
 #define DEV_IS_GONE(pm8001_dev)	\
 	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
+
 /**
-  * pm8001_task_exec - queue the task(ssp, smp && ata) to the hardware.
+  * pm8001_queue_command - register for upper layer used, all IO commands sent
+  * to HBA are from this interface.
   * @task: the task to be execute.
-  * @gfp_flags: gfp_flags.
-  * @is_tmf: if it is task management task.
-  * @tmf: the task management IU
+  * @gfp_flags: gfp_flags
   */
-static int pm8001_task_exec(struct sas_task *task,
-	gfp_t gfp_flags, int is_tmf, struct sas_tmf_task *tmf)
+int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
 	struct domain_device *dev = task->dev;
 	struct pm8001_hba_info *pm8001_ha;
@@ -390,6 +389,8 @@ static int pm8001_task_exec(struct sas_task *task,
 	u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
 	unsigned long flags = 0;
 	enum sas_protocol task_proto = t->task_proto;
+	struct sas_tmf_task *tmf = task->tmf;
+	int is_tmf = !!task->tmf;
 
 	if (!dev->port) {
 		struct task_status_struct *tsm = &t->task_status;
@@ -507,17 +508,6 @@ static int pm8001_task_exec(struct sas_task *task,
 	return rc;
 }
 
-/**
-  * pm8001_queue_command - register for upper layer used, all IO commands sent
-  * to HBA are from this interface.
-  * @task: the task to be execute.
-  * @gfp_flags: gfp_flags
-  */
-int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
-{
-	return pm8001_task_exec(task, gfp_flags, 0, NULL);
-}
-
 /**
   * pm8001_ccb_task_free - free the sg for ssp and smp command, free the ccb.
   * @pm8001_ha: our hba card information
@@ -752,7 +742,9 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 		task->slow_task->timer.expires = jiffies + PM8001_TASK_TIMEOUT*HZ;
 		add_timer(&task->slow_task->timer);
 
-		res = pm8001_task_exec(task, GFP_KERNEL, 1, tmf);
+		task->tmf = tmf;
+
+		res = pm8001_queue_command(task, GFP_KERNEL);
 
 		if (res) {
 			del_timer(&task->slow_task->timer);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 30b9afec1e1d..802b4e04e3a1 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -611,6 +611,7 @@ struct sas_task {
 	void   *lldd_task;	  /* for use by LLDDs */
 	void   *uldd_task;
 	struct sas_task_slow *slow_task;
+	struct sas_tmf_task *tmf;
 };
 
 struct sas_task_slow {
-- 
2.26.2

