Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FCE49B312
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382727AbiAYLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:43:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4496 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382137AbiAYLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:43 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlB55lvNz6FGxF;
        Tue, 25 Jan 2022 19:34:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:37 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:33 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 04/16] scsi: libsas: Move SMP task handlers to core
Date:   Tue, 25 Jan 2022 19:32:40 +0800
Message-ID: <1643110372-85470-5-git-send-email-john.garry@huawei.com>
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

Move the SMP task handlers to the core host code as they will be re-used
for executing internal abort and TMF tasks.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c  | 24 ++----------------------
 drivers/scsi/libsas/sas_internal.h  |  3 +++
 drivers/scsi/libsas/sas_scsi_host.c | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 6abce9dfc17b..260e735d06fa 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -28,26 +28,6 @@ static int sas_disable_routing(struct domain_device *dev,  u8 *sas_addr);
 
 /* ---------- SMP task management ---------- */
 
-static void smp_task_timedout(struct timer_list *t)
-{
-	struct sas_task_slow *slow = from_timer(slow, t, timer);
-	struct sas_task *task = slow->task;
-	unsigned long flags;
-
-	spin_lock_irqsave(&task->task_state_lock, flags);
-	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
-		complete(&task->slow_task->completion);
-	}
-	spin_unlock_irqrestore(&task->task_state_lock, flags);
-}
-
-static void smp_task_done(struct sas_task *task)
-{
-	del_timer(&task->slow_task->timer);
-	complete(&task->slow_task->completion);
-}
-
 /* Give it some long enough timeout. In seconds. */
 #define SMP_TIMEOUT 10
 
@@ -78,9 +58,9 @@ static int smp_execute_task_sg(struct domain_device *dev,
 		task->smp_task.smp_req = *req;
 		task->smp_task.smp_resp = *resp;
 
-		task->task_done = smp_task_done;
+		task->task_done = sas_task_internal_done;
 
-		task->slow_task->timer.function = smp_task_timedout;
+		task->slow_task->timer.function = sas_task_internal_timedout;
 		task->slow_task->timer.expires = jiffies + SMP_TIMEOUT*HZ;
 		add_timer(&task->slow_task->timer);
 
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index acd515c01861..cd6aa723c3e1 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -95,6 +95,9 @@ void sas_destruct_devices(struct asd_sas_port *port);
 extern const work_func_t sas_phy_event_fns[PHY_NUM_EVENTS];
 extern const work_func_t sas_port_event_fns[PORT_NUM_EVENTS];
 
+void sas_task_internal_done(struct sas_task *task);
+void sas_task_internal_timedout(struct timer_list *t);
+
 #ifdef CONFIG_SCSI_SAS_HOST_SMP
 extern void sas_smp_host_handler(struct bsg_job *job, struct Scsi_Host *shost);
 #else
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index fb19e739a39c..42b6041d10fc 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -894,6 +894,30 @@ int sas_bios_param(struct scsi_device *scsi_dev,
 }
 EXPORT_SYMBOL_GPL(sas_bios_param);
 
+void sas_task_internal_done(struct sas_task *task)
+{
+	del_timer(&task->slow_task->timer);
+	complete(&task->slow_task->completion);
+}
+
+void sas_task_internal_timedout(struct timer_list *t)
+{
+	struct sas_task_slow *slow = from_timer(slow, t, timer);
+	struct sas_task *task = slow->task;
+	bool is_completed = true;
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
+		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+		is_completed = false;
+	}
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
+	if (!is_completed)
+		complete(&task->slow_task->completion);
+}
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
-- 
2.26.2

