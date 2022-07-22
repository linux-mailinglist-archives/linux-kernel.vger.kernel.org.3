Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630F657E0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiGVLae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiGVLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:30:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0974CC2;
        Fri, 22 Jul 2022 04:30:28 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lq6Z71wcNz67gtM;
        Fri, 22 Jul 2022 19:25:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 22 Jul 2022 13:30:26 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 12:30:23 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <yangxingui@huawei.com>, <chenxiang66@hisilicon.com>,
        <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/6] scsi: pm8001: Modify task abort handling for SATA task
Date:   Fri, 22 Jul 2022 19:24:04 +0800
Message-ID: <1658489049-232850-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we try to abort a SATA task, the CCB of the task which we are trying
to avoid may still complete. In this case, we should not touch the task
associated with that CCB as we can race with libsas freeing the last later
in sas_eh_handle_sas_errors() -> sas_eh_finish_cmd() for when
TASK_IS_ABORTED is returned from sas_scsi_find_task()

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 15 +++++++++++++--
 drivers/scsi/pm8001/pm8001_sas.c |  8 ++++++++
 drivers/scsi/pm8001/pm80xx_hwi.c | 14 ++++++++++----
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index f7466a895d3b..6a88255cb3c3 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -2291,7 +2291,9 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		if (t->dev && (t->dev->lldd_dev))
 			pm8001_dev = t->dev->lldd_dev;
 	} else {
-		pm8001_dbg(pm8001_ha, FAIL, "task null\n");
+		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
+			   ccb->ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
 	}
 
@@ -2671,8 +2673,17 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	pm8001_dev = ccb->device;
 	if (event)
 		pm8001_dbg(pm8001_ha, FAIL, "sata IO status 0x%x\n", event);
-	if (unlikely(!t || !t->lldd_task || !t->dev))
+
+	if (unlikely(!t)) {
+		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
+			   ccb->ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
+	}
+
+	if (unlikely(!t->lldd_task || !t->dev))
+		return;
+
 	ts = &t->task_status;
 	pm8001_dbg(pm8001_ha, DEVIO,
 		   "port_id:0x%x, device_id:0x%x, tag:0x%x, event:0x%x\n",
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index e8ffe56228a9..a2ccb3484f90 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -980,6 +980,7 @@ int pm8001_query_task(struct sas_task *task)
 /*  mandatory SAM-3, still need free task/ccb info, abort the specified task */
 int pm8001_abort_task(struct sas_task *task)
 {
+	struct pm8001_ccb_info *ccb = task->lldd_task;
 	unsigned long flags;
 	u32 tag;
 	struct domain_device *dev ;
@@ -1110,6 +1111,13 @@ int pm8001_abort_task(struct sas_task *task)
 				pm8001_dev, DS_OPERATIONAL);
 			wait_for_completion(&completion);
 		} else {
+			/*
+			 * Ensure that if we see a completion for the ccb
+			 * associated with the task we are trying to abort then
+			 * we should not touch the sas_task as it may race with
+			 * libsas freeing it when return here.
+			 */
+			ccb->task = NULL;
 			ret = sas_execute_internal_abort_single(dev, tag, 0, NULL);
 		}
 		rc = TMF_RESP_FUNC_COMPLETE;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 01c5e8ff4cc5..d55f8b1c236d 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2390,7 +2390,9 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 		if (t->dev && (t->dev->lldd_dev))
 			pm8001_dev = t->dev->lldd_dev;
 	} else {
-		pm8001_dbg(pm8001_ha, FAIL, "task null\n");
+		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
+			   ccb->ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
 	}
 
@@ -2807,12 +2809,16 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha,
 	ccb = &pm8001_ha->ccb_info[tag];
 	t = ccb->task;
 	pm8001_dev = ccb->device;
-
-	if (unlikely(!t || !t->lldd_task || !t->dev)) {
-		pm8001_dbg(pm8001_ha, FAIL, "task or dev null\n");
+	if (unlikely(!t)) {
+		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
+			   ccb->ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
 	}
 
+	if (unlikely(!t->lldd_task || !t->dev))
+		return;
+
 	ts = &t->task_status;
 	pm8001_dbg(pm8001_ha, IOERR, "port_id:0x%x, tag:0x%x, event:0x%x\n",
 		   port_id, tag, event);
-- 
2.35.3

