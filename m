Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386CF49B32E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384334AbiAYLpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:45:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4505 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354216AbiAYLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:40:54 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlH52hXXz685x5;
        Tue, 25 Jan 2022 19:38:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:39:03 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:59 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 11/16] scsi: libsas: Add sas_abort_task_set()
Date:   Tue, 25 Jan 2022 19:32:47 +0800
Message-ID: <1643110372-85470-12-git-send-email-john.garry@huawei.com>
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

Add a generic implementation of abort task set TMF handler, and use in
LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  5 +----
 drivers/scsi/libsas/sas_scsi_host.c   | 16 ++++++++++++----
 drivers/scsi/mvsas/mv_init.c          |  2 +-
 drivers/scsi/mvsas/mv_sas.c           | 11 -----------
 drivers/scsi/mvsas/mv_sas.h           |  1 -
 drivers/scsi/pm8001/pm8001_init.c     |  2 +-
 drivers/scsi/pm8001/pm8001_sas.c      |  8 --------
 drivers/scsi/pm8001/pm8001_sas.h      |  1 -
 include/scsi/libsas.h                 |  2 ++
 9 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a2c03cb6414f..7bf0d400d11f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1793,7 +1793,6 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 {
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
-	struct sas_tmf_task tmf_task;
 	int rc;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
@@ -1804,9 +1803,7 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 	}
 	hisi_sas_dereg_device(hisi_hba, device);
 
-	tmf_task.tmf = TMF_ABORT_TASK_SET;
-	rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
-
+	rc = sas_abort_task_set(device, lun);
 	if (rc == TMF_RESP_FUNC_COMPLETE)
 		hisi_sas_release_task(hisi_hba, device);
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 956b4387c1b8..b18cbb617710 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1033,10 +1033,8 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 	return res;
 }
 
-int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
-			struct sas_tmf_task *tmf);
-int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
-			struct sas_tmf_task *tmf)
+static int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
+			       struct sas_tmf_task *tmf)
 {
 	struct sas_ssp_task ssp_task;
 
@@ -1048,6 +1046,16 @@ int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
 	return sas_execute_tmf(device, &ssp_task, sizeof(ssp_task), -1, tmf);
 }
 
+int sas_abort_task_set(struct domain_device *dev, u8 *lun)
+{
+	struct sas_tmf_task tmf_task = {
+		.tmf = TMF_ABORT_TASK_SET,
+	};
+
+	return sas_execute_ssp_tmf(dev, lun, &tmf_task);
+}
+EXPORT_SYMBOL_GPL(sas_abort_task_set);
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 21429e3a3632..484ad2f41f48 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -63,7 +63,7 @@ static struct sas_domain_function_template mvs_transport_ops = {
 	.lldd_control_phy	= mvs_phy_control,
 
 	.lldd_abort_task	= mvs_abort_task,
-	.lldd_abort_task_set    = mvs_abort_task_set,
+	.lldd_abort_task_set    = sas_abort_task_set,
 	.lldd_clear_task_set    = mvs_clear_task_set,
 	.lldd_I_T_nexus_reset	= mvs_I_T_nexus_reset,
 	.lldd_lu_reset 		= mvs_lu_reset,
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 5105d55eb00c..3b2aa7117eb4 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1539,17 +1539,6 @@ int mvs_abort_task(struct sas_task *task)
 	return rc;
 }
 
-int mvs_abort_task_set(struct domain_device *dev, u8 *lun)
-{
-	int rc;
-	struct sas_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_ABORT_TASK_SET;
-	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
-
-	return rc;
-}
-
 int mvs_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
index fa654c73beee..0bee63596208 100644
--- a/drivers/scsi/mvsas/mv_sas.h
+++ b/drivers/scsi/mvsas/mv_sas.h
@@ -440,7 +440,6 @@ void mvs_scan_start(struct Scsi_Host *shost);
 int mvs_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int mvs_abort_task(struct sas_task *task);
-int mvs_abort_task_set(struct domain_device *dev, u8 *lun);
 int mvs_clear_task_set(struct domain_device *dev, u8 * lun);
 void mvs_port_formed(struct asd_sas_phy *sas_phy);
 void mvs_port_deformed(struct asd_sas_phy *sas_phy);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 8eef8f4de42f..65489c52c50a 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -122,7 +122,7 @@ static struct sas_domain_function_template pm8001_transport_ops = {
 	.lldd_control_phy	= pm8001_phy_control,
 
 	.lldd_abort_task	= pm8001_abort_task,
-	.lldd_abort_task_set	= pm8001_abort_task_set,
+	.lldd_abort_task_set	= sas_abort_task_set,
 	.lldd_clear_task_set	= pm8001_clear_task_set,
 	.lldd_I_T_nexus_reset   = pm8001_I_T_nexus_reset,
 	.lldd_lu_reset		= pm8001_lu_reset,
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 06e5d5741ae2..c142bd0ce634 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1341,14 +1341,6 @@ int pm8001_abort_task(struct sas_task *task)
 	return rc;
 }
 
-int pm8001_abort_task_set(struct domain_device *dev, u8 *lun)
-{
-	struct sas_tmf_task tmf_task;
-
-	tmf_task.tmf = TMF_ABORT_TASK_SET;
-	return pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
-}
-
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun)
 {
 	struct sas_tmf_task tmf_task;
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index c19c9c80206c..817a37608133 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -644,7 +644,6 @@ void pm8001_scan_start(struct Scsi_Host *shost);
 int pm8001_scan_finished(struct Scsi_Host *shost, unsigned long time);
 int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags);
 int pm8001_abort_task(struct sas_task *task);
-int pm8001_abort_task_set(struct domain_device *dev, u8 *lun);
 int pm8001_clear_task_set(struct domain_device *dev, u8 *lun);
 int pm8001_dev_found(struct domain_device *dev);
 void pm8001_dev_gone(struct domain_device *dev);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 1e5ecfb2f36e..434437b0e89c 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -724,6 +724,8 @@ struct sas_phy *sas_get_local_phy(struct domain_device *dev);
 
 int sas_request_addr(struct Scsi_Host *shost, u8 *addr);
 
+int sas_abort_task_set(struct domain_device *dev, u8 *lun);
+
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
 int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
-- 
2.26.2

