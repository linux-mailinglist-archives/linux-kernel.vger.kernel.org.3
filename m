Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F24BF8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiBVM61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiBVM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:58:04 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF323B0C48;
        Tue, 22 Feb 2022 04:57:36 -0800 (PST)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2zh10SVWz67yJP;
        Tue, 22 Feb 2022 20:56:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 13:57:34 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:57:30 +0000
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
Subject: [PATCH v3 16/18] scsi: libsas: Add sas_query_task()
Date:   Tue, 22 Feb 2022 20:50:57 +0800
Message-ID: <1645534259-27068-17-git-send-email-john.garry@huawei.com>
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

Add a generic implementation of query task TMF handler, and use in LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 12 +-----------
 drivers/scsi/libsas/sas_scsi_host.c   | 16 ++++++++++++++++
 drivers/scsi/mvsas/mv_sas.c           |  9 +--------
 drivers/scsi/pm8001/pm8001_sas.c      |  7 +------
 include/scsi/libsas.h                 |  1 +
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 3773874b0c2e..808eefaf3359 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1988,23 +1988,13 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 
 static int hisi_sas_query_task(struct sas_task *task)
 {
-	struct scsi_lun lun;
-	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
-		struct scsi_cmnd *cmnd = task->uldd_task;
-		struct domain_device *device = task->dev;
 		struct hisi_sas_slot *slot = task->lldd_task;
 		u32 tag = slot->idx;
 
-		int_to_scsilun(cmnd->device->lun, &lun);
-		tmf_task.tmf = TMF_QUERY_TASK;
-		tmf_task.tag_of_task_to_be_managed = tag;
-
-		rc = hisi_sas_debug_issue_ssp_tmf(device,
-						  lun.scsi_lun,
-						  &tmf_task);
+		rc = sas_query_task(task, tag);
 		switch (rc) {
 		/* The task is still in Lun, release it then */
 		case TMF_RESP_FUNC_SUCC:
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index d6f29e13204e..1923a0627ce7 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1073,6 +1073,22 @@ int sas_lu_reset(struct domain_device *dev, u8 *lun)
 }
 EXPORT_SYMBOL_GPL(sas_lu_reset);
 
+int sas_query_task(struct sas_task *task, u16 tag)
+{
+	struct sas_tmf_task tmf_task = {
+		.tmf = TMF_QUERY_TASK,
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
+EXPORT_SYMBOL_GPL(sas_query_task);
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index fdaaa4380e74..63a96c307e3c 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1422,27 +1422,20 @@ int mvs_I_T_nexus_reset(struct domain_device *dev)
 int mvs_query_task(struct sas_task *task)
 {
 	u32 tag;
-	struct scsi_lun lun;
-	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	if (task->lldd_task && task->task_proto & SAS_PROTOCOL_SSP) {
-		struct scsi_cmnd * cmnd = (struct scsi_cmnd *)task->uldd_task;
 		struct domain_device *dev = task->dev;
 		struct mvs_device *mvi_dev = (struct mvs_device *)dev->lldd_dev;
 		struct mvs_info *mvi = mvi_dev->mvi_info;
 
-		int_to_scsilun(cmnd->device->lun, &lun);
 		rc = mvs_find_tag(mvi, task, &tag);
 		if (rc == 0) {
 			rc = TMF_RESP_FUNC_FAILED;
 			return rc;
 		}
 
-		tmf_task.tmf = TMF_QUERY_TASK;
-		tmf_task.tag_of_task_to_be_managed = cpu_to_le16(tag);
-
-		rc = mvs_debug_issue_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
+		rc = sas_query_task(task, tag);
 		switch (rc) {
 		/* The task is still in Lun, release it then */
 		case TMF_RESP_FUNC_SUCC:
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 18e8420055b5..e8bdc3390019 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1138,8 +1138,6 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 int pm8001_query_task(struct sas_task *task)
 {
 	u32 tag = 0xdeadbeef;
-	struct scsi_lun lun;
-	struct sas_tmf_task tmf_task;
 	int rc = TMF_RESP_FUNC_FAILED;
 	if (unlikely(!task || !task->lldd_task || !task->dev))
 		return rc;
@@ -1150,17 +1148,14 @@ int pm8001_query_task(struct sas_task *task)
 		struct pm8001_hba_info *pm8001_ha =
 			pm8001_find_ha_by_dev(dev);
 
-		int_to_scsilun(cmnd->device->lun, &lun);
 		rc = pm8001_find_tag(task, &tag);
 		if (rc == 0) {
 			rc = TMF_RESP_FUNC_FAILED;
 			return rc;
 		}
 		pm8001_dbg(pm8001_ha, EH, "Query:[%16ph]\n", cmnd->cmnd);
-		tmf_task.tmf = 	TMF_QUERY_TASK;
-		tmf_task.tag_of_task_to_be_managed = tag;
 
-		rc = pm8001_issue_ssp_tmf(dev, lun.scsi_lun, &tmf_task);
+		rc = sas_query_task(task, tag);
 		switch (rc) {
 		/* The task is still in Lun, release it then */
 		case TMF_RESP_FUNC_SUCC:
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 7b1e2e7f5a6c..bf8613fb1c4e 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -725,6 +725,7 @@ int sas_request_addr(struct Scsi_Host *shost, u8 *addr);
 int sas_abort_task_set(struct domain_device *dev, u8 *lun);
 int sas_clear_task_set(struct domain_device *dev, u8 *lun);
 int sas_lu_reset(struct domain_device *dev, u8 *lun);
+int sas_query_task(struct sas_task *task, u16 tag);
 
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
-- 
2.26.2

