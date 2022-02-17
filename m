Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C364BA4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbiBQPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:50:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242866AbiBQPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:49:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01D160FF4;
        Thu, 17 Feb 2022 07:49:19 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzzkZ5HTqz67rcd;
        Thu, 17 Feb 2022 23:48:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:49:17 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:49:13 +0000
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
Subject: [PATCH v2 13/18] scsi: libsas: Add sas_abort_task_set()
Date:   Thu, 17 Feb 2022 23:42:41 +0800
Message-ID: <1645112566-115804-14-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Add a generic implementation of abort task set TMF handler, and use in
LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
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
index 21e929c8bdb0..54fe25ddac5b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1788,7 +1788,6 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 {
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
-	struct sas_tmf_task tmf_task;
 	int rc;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
@@ -1799,9 +1798,7 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 	}
 	hisi_sas_dereg_device(hisi_hba, device);
 
-	tmf_task.tmf = TMF_ABORT_TASK_SET;
-	rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
-
+	rc = sas_abort_task_set(device, lun);
 	if (rc == TMF_RESP_FUNC_COMPLETE)
 		hisi_sas_release_task(hisi_hba, device);
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index c5d9c6a6b870..06bc7221ac3a 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1030,10 +1030,8 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
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
 
@@ -1045,6 +1043,16 @@ int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
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
index 3fe0a9351cea..13a002e08a12 100644
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
index 47fcd8de9ece..0cdbba31f327 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1536,17 +1536,6 @@ int mvs_abort_task(struct sas_task *task)
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
index 6a3635c39f6a..d7b95ad4533e 100644
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
index a530fb0aaa05..543113564a58 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1342,14 +1342,6 @@ int pm8001_abort_task(struct sas_task *task)
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
index aa018d2d19a3..d26f25186779 100644
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
index c44de478e314..53fdc18bdd09 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -722,6 +722,8 @@ struct sas_phy *sas_get_local_phy(struct domain_device *dev);
 
 int sas_request_addr(struct Scsi_Host *shost, u8 *addr);
 
+int sas_abort_task_set(struct domain_device *dev, u8 *lun);
+
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
 int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
-- 
2.26.2

