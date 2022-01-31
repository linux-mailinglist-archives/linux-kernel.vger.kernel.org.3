Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2774C4A4437
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377340AbiAaL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:27:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4559 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377699AbiAaLSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:18:51 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnQXm0rh8z67xg8;
        Mon, 31 Jan 2022 19:18:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 31 Jan 2022 12:18:46 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 11:18:44 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Fix setting of hisi_sas_slot.is_internal
Date:   Mon, 31 Jan 2022 19:13:27 +0800
Message-ID: <1643627607-138785-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hisi_sas_slot.is_internal member is not set properly for ATA commands
which the driver sends directly. A TMF struct pointer is normally used as
a test to set this, but it is NULL for those commands. It's not ideal, but
pass an empty TMF struct to set that member properly.

Fixes: dc313f6b125b ("scsi: hisi_sas: Factor out task prep and delivery code")
Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
Please consider this change for v5.17, thanks!

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 2f53a2ee024a..ebf5ec38891b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -400,8 +400,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 			   struct hisi_sas_slot *slot,
 			   struct hisi_sas_dq *dq,
 			   struct hisi_sas_device *sas_dev,
-			   struct hisi_sas_internal_abort *abort,
-			   struct hisi_sas_tmf_task *tmf)
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
@@ -587,7 +584,7 @@ static int hisi_sas_task_exec(struct sas_task *task, gfp_t gfp_flags,
 	slot->is_internal = tmf;
 
 	/* protect task_prep and start_delivery sequence */
-	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL, tmf);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL);
 
 	return 0;
 
@@ -1380,12 +1377,13 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
 	int s = sizeof(struct host_to_dev_fis);
+	struct hisi_sas_tmf_task tmf = {};
 
 	ata_for_each_link(link, ap, EDGE) {
 		int pmp = sata_srst_pmp(link);
 
 		hisi_sas_fill_ata_reset_cmd(link->device, 1, pmp, fis);
-		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, NULL);
+		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, &tmf);
 		if (rc != TMF_RESP_FUNC_COMPLETE)
 			break;
 	}
@@ -1396,7 +1394,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 
 			hisi_sas_fill_ata_reset_cmd(link->device, 0, pmp, fis);
 			rc = hisi_sas_exec_internal_tmf_task(device, fis,
-							     s, NULL);
+							     s, &tmf);
 			if (rc != TMF_RESP_FUNC_COMPLETE)
 				dev_err(dev, "ata disk %016llx de-reset failed\n",
 					SAS_ADDR(device->sas_addr));
@@ -2067,7 +2065,7 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	slot->port = port;
 	slot->is_internal = true;
 
-	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort, NULL);
+	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort);
 
 	return 0;
 
-- 
2.26.2

