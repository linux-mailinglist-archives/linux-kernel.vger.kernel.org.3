Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8078D5AEFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiIFP52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbiIFPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599A1A3AC;
        Tue,  6 Sep 2022 08:14:42 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMTS60QXyz67xfT;
        Tue,  6 Sep 2022 23:13:58 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 17:14:40 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:14:37 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>, <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 1/6] scsi: pm8001: Modify task abort handling for SATA task
Date:   Tue, 6 Sep 2022 23:08:05 +0800
Message-ID: <1662476890-15467-2-git-send-email-john.garry@huawei.com>
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

When we try to abort a SATA task, the CCB of the task which we are trying
to avoid may still complete. In this case, we should not touch the task
associated with that CCB as we can race with libsas freeing the last later
in sas_eh_handle_sas_errors() -> sas_eh_finish_cmd() for when
TASK_IS_ABORTED is returned from sas_scsi_find_task()

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 15 +++++++++++++--
 drivers/scsi/pm8001/pm8001_sas.c |  8 ++++++++
 drivers/scsi/pm8001/pm80xx_hwi.c | 14 ++++++++++----
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 91d78d0a38fe..1c8a43bf54ad 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -2295,7 +2295,9 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		if (t->dev && (t->dev->lldd_dev))
 			pm8001_dev = t->dev->lldd_dev;
 	} else {
-		pm8001_dbg(pm8001_ha, FAIL, "task null\n");
+		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
+			   ccb->ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
 	}
 
@@ -2675,8 +2677,17 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
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
index 78cae33aa620..ca29d1454b66 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -984,6 +984,7 @@ int pm8001_query_task(struct sas_task *task)
 /*  mandatory SAM-3, still need free task/ccb info, abort the specified task */
 int pm8001_abort_task(struct sas_task *task)
 {
+	struct pm8001_ccb_info *ccb = task->lldd_task;
 	unsigned long flags;
 	u32 tag;
 	struct domain_device *dev ;
@@ -1114,6 +1115,13 @@ int pm8001_abort_task(struct sas_task *task)
 				pm8001_dev, DS_OPERATIONAL);
 			wait_for_completion(&completion);
 		} else {
+			/*
+			 * Ensure that if we see a completion for the ccb
+			 * associated with the task which we are trying to
+			 * abort then we should not touch the sas_task as it
+			 * may race with libsas freeing it when return here.
+			 */
+			ccb->task = NULL;
 			ret = sas_execute_internal_abort_single(dev, tag, 0, NULL);
 		}
 		rc = TMF_RESP_FUNC_COMPLETE;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index f8b8624458f7..dd0e06983cd3 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -2396,7 +2396,9 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
 		if (t->dev && (t->dev->lldd_dev))
 			pm8001_dev = t->dev->lldd_dev;
 	} else {
-		pm8001_dbg(pm8001_ha, FAIL, "task null\n");
+		pm8001_dbg(pm8001_ha, FAIL, "task null, freeing CCB tag %d\n",
+			   ccb->ccb_tag);
+		pm8001_ccb_free(pm8001_ha, ccb);
 		return;
 	}
 
@@ -2813,12 +2815,16 @@ static void mpi_sata_event(struct pm8001_hba_info *pm8001_ha,
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

