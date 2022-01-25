Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C049B31E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383074AbiAYLov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:44:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4503 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382459AbiAYLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:39:16 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlBg2Z72z67wsC;
        Tue, 25 Jan 2022 19:34:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:39:07 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:39:03 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 12/16] scsi: libsas: Add sas_clear_task_set()
Date:   Tue, 25 Jan 2022 19:32:48 +0800
Message-ID: <1643110372-85470-13-git-send-email-john.garry@huawei.com>
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

Add a generic implementation of clear task set TMF handler, and use in
LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  5 +----
 drivers/scsi/libsas/sas_scsi_host.c   | 10 ++++++++++
 drivers/scsi/mvsas/mv_init.c          |  2 +-
 drivers/scsi/mvsas/mv_sas.c           | 11 -----------
 drivers/scsi/mvsas/mv_sas.h           |  1 -
 drivers/scsi/pm8001/pm8001_sas.c      |  4 +---
 include/scsi/libsas.h                 |  1 +
 7 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7bf0d400d11f..12919b063572 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -695,7 +695,6 @@ static int hisi_sas_init_device(struct domain_device *device)
 {
 	int rc = TMF_RESP_FUNC_COMPLETE;
 	struct scsi_lun lun;
-	struct sas_tmf_task tmf_task;
 	int retry = HISI_SAS_DISK_RECOVER_CNT;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
@@ -705,10 +704,8 @@ static int hisi_sas_init_device(struct domain_device *device)
 	case SAS_END_DEVICE:
 		int_to_scsilun(0, &lun);
 
-		tmf_task.tmf = TMF_CLEAR_TASK_SET;
 		while (retry-- > 0) {
-			rc = hisi_sas_debug_issue_ssp_tmf(device, lun.scsi_lun,
-							  &tmf_task);
+			rc = sas_clear_task_set(device, lun.scsi_lun);
 			if (rc == TMF_RESP_FUNC_COMPLETE) {
 				hisi_sas_release_task(hisi_hba, device);
 				break;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index b18cbb617710..5520c857598b 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1056,6 +1056,16 @@ int sas_abort_task_set(struct domain_device *dev, u8 *lun)
 }
 EXPORT_SYMBOL_GPL(sas_abort_task_set);
 
+int sas_clear_task_set(struct domain_device *dev, u8 *lun)
+{
+	struct sas_tmf_task tmf_task = {
+		.tmf = TMF_CLEAR_TASK_SET,
+	};
+
+	return sas_execute_ssp_tmf(dev, lun, &tmf_task);
+}
+EXPORT_SYMBOL_GPL(sas_clear_task_set);
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 484ad2f41f48..dac66dddfaf6 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -64,7 +64,7 @@ static struct sas_domain_function_template mvs_transport_ops = {
 
 	.lldd_abort_task	= mvs_abort_task,
 	.lldd_abort_task_set    = sas_abort_task_set,
-	.lldd_clear_task_set    = mvs_clear_task_set,
+	.lldd_clear_task_set    = sas_clear_task_set,
 	.lldd_I_T_nexus_reset	= mvs_I_T_nexus_reset,
 	.lldd_lu_reset 		= mvs_lu_reset,
 	.lldd_query_task	= mvs_query_task,
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 3b2aa7117eb4..146005d2d75c 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1539,17 +1539,6 @@ int mvs_abort_task(struct sas_task *task)
 	return rc;
 }
 
-int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
-{
-	int rc = TMF_RESP_FUNC_FAILED;
-	struct sas_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_CLEAR_TASK_SET;
-	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
-
-	return rc;
-}
-
 static int mvs_sata_done(struct mvs_info *mvi, struct sas_task *task,
 			u32 slot_idx, int err)
 {
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index 0bee63596208..509d8f32a04f 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -440,7 +440,6 @@ void mvs_scan_start(struct Scsi_Host *shost);
 int mvs_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int mvs_abort_task(struct sas_task *task);
-int mvs_clear_task_set(struct domain_device *dev, u8 * lun);
 void mvs_port_formed(struct asd_sas_phy *sas_phy);
 void mvs_port_deformed(struct asd_sas_phy *sas_phy);
 int mvs_dev_found(struct domain_device *dev);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index c142bd0ce634..3547e8538670 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1343,14 +1343,12 @@ int pm8001_abort_task(struct sas_task *task)
 
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 {
-	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 
 	pm8001_dbg(pm8001_ha, EH, "I_T_L_Q clear task set[%x]\n",
 		   pm8001_dev->device_id);
-	tmf_task.tmf = TMF_CLEAR_TASK_SET;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+	return sas_clear_task_set(dev, lun);
 }
 
 void pm8001_port_formed(struct asd_sas_phy *sas_phy)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 434437b0e89c..710f93ddc5d4 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -725,6 +725,7 @@ struct sas_phy *sas_get_local_phy(struct domain_device *dev);
 int sas_request_addr(struct Scsi_Host *shost, u8 *addr);
 
 int sas_abort_task_set(struct domain_device *dev, u8 *lun);
+int sas_clear_task_set(struct domain_device *dev, u8 *lun);
 
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
-- 
2.26.2

