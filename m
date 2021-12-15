Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40399475AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbhLOOnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4288 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbhLOOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:08 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdGK2yYcz67WZ3;
        Wed, 15 Dec 2021 22:40:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:06 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:43:03 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/8] scsi: hisi_sas: Pass abort structure for internal abort
Date:   Wed, 15 Dec 2021 22:37:36 +0800
Message-ID: <1639579061-179473-4-git-send-email-john.garry@huawei.com>
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

To help factor out code in future, it's useful to know if we're executing
an internal abort, so pass a pointer to the structure. The idea is that
a NULL pointer means not an internal abort.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      |  5 +++++
 drivers/scsi/hisi_sas/hisi_sas_main.c | 21 ++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index ed9419643235..07b473de9136 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -133,6 +133,11 @@ struct hisi_sas_rst {
 	bool done;
 };
 
+struct hisi_sas_internal_abort {
+	unsigned int flag;
+	unsigned int tag;
+};
+
 #define HISI_SAS_RST_WORK_INIT(r, c) \
 	{	.hisi_hba = hisi_hba, \
 		.completion = &c, \
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index b2299db01a80..9bad59e77eae 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -265,11 +265,11 @@ static void hisi_sas_task_prep_ata(struct hisi_hba *hisi_hba,
 }
 
 static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
-		struct hisi_sas_slot *slot,
-		int device_id, int abort_flag, int tag_to_abort)
+		struct hisi_sas_internal_abort *abort,
+		struct hisi_sas_slot *slot, int device_id)
 {
 	hisi_hba->hw->prep_abort(hisi_hba, slot,
-			device_id, abort_flag, tag_to_abort);
+			device_id, abort->flag, abort->tag);
 }
 
 static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
@@ -2008,8 +2008,9 @@ static int hisi_sas_query_task(struct sas_task *task)
 
 static int
 hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
-				  struct sas_task *task, int abort_flag,
-				  int task_tag, struct hisi_sas_dq *dq)
+				  struct hisi_sas_internal_abort *abort,
+				  struct sas_task *task,
+				  struct hisi_sas_dq *dq)
 {
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
@@ -2066,8 +2067,7 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	memset(hisi_sas_status_buf_addr_mem(slot), 0,
 	       sizeof(struct hisi_sas_err_record));
 
-	hisi_sas_task_prep_abort(hisi_hba, slot, device_id,
-				      abort_flag, task_tag);
+	hisi_sas_task_prep_abort(hisi_hba, abort, slot, device_id);
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
@@ -2105,9 +2105,12 @@ _hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 {
 	struct sas_task *task;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	struct hisi_sas_internal_abort abort = {
+		.flag = abort_flag,
+		.tag = tag,
+	};
 	struct device *dev = hisi_hba->dev;
 	int res;
-
 	/*
 	 * The interface is not realized means this HW don't support internal
 	 * abort, or don't need to do internal abort. Then here, we return
@@ -2132,7 +2135,7 @@ _hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 	add_timer(&task->slow_task->timer);
 
 	res = hisi_sas_internal_abort_task_exec(hisi_hba, sas_dev->device_id,
-						task, abort_flag, tag, dq);
+						&abort, task, dq);
 	if (res) {
 		del_timer_sync(&task->slow_task->timer);
 		dev_err(dev, "internal task abort: executing internal task failed: %d\n",
-- 
2.26.2

