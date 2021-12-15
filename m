Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17F475AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243456AbhLOOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:43:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4286 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbhLOOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:43:03 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdGD5TWxz6H6sV;
        Wed, 15 Dec 2021 22:40:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 15:43:01 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 14:42:59 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/8] scsi: hisi_sas: Start delivery hisi_sas_task_exec() directly
Date:   Wed, 15 Dec 2021 22:37:34 +0800
Message-ID: <1639579061-179473-2-git-send-email-john.garry@huawei.com>
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

Currently we start delivery of commands to the DQ after returning from
hisi_sas_task_exec() with success.

Let's just start delivery directly in that function without having to
check if some local variable is set.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 889c36fa9309..0137ce7c544e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -397,8 +397,7 @@ static int hisi_sas_dif_dma_map(struct hisi_hba *hisi_hba,
 
 static int hisi_sas_task_prep(struct sas_task *task,
 			      struct hisi_sas_dq **dq_pointer,
-			      bool is_tmf, struct hisi_sas_tmf_task *tmf,
-			      int *pass)
+			      bool is_tmf, struct hisi_sas_tmf_task *tmf)
 {
 	struct domain_device *device = task->dev;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
@@ -536,9 +535,12 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
-	++(*pass);
 	WRITE_ONCE(slot->ready, 1);
 
+	spin_lock(&dq->lock);
+	hisi_hba->hw->start_delivery(dq);
+	spin_unlock(&dq->lock);
+
 	return 0;
 
 err_out_dif_dma_unmap:
@@ -556,7 +558,6 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 			      bool is_tmf, struct hisi_sas_tmf_task *tmf)
 {
 	u32 rc;
-	u32 pass = 0;
 	struct hisi_hba *hisi_hba;
 	struct device *dev;
 	struct domain_device *device = task->dev;
@@ -589,16 +590,10 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 	}
 
 	/* protect task_prep and start_delivery sequence */
-	rc = hisi_sas_task_prep(task, &dq, is_tmf, tmf, &pass);
+	rc = hisi_sas_task_prep(task, &dq, is_tmf, tmf);
 	if (rc)
 		dev_err(dev, "task exec: failed[%d]!\n", rc);
 
-	if (likely(pass)) {
-		spin_lock(&dq->lock);
-		hisi_hba->hw->start_delivery(dq);
-		spin_unlock(&dq->lock);
-	}
-
 	return rc;
 }
 
-- 
2.26.2

