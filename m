Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1053E49B321
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383410AbiAYLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:45:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4504 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382511AbiAYLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:39:21 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlCj6XJlz686my;
        Tue, 25 Jan 2022 19:35:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:39:10 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:39:06 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 13/16] scsi: libsas: Add sas_lu_reset()
Date:   Tue, 25 Jan 2022 19:32:49 +0800
Message-ID: <1643110372-85470-14-git-send-email-john.garry@huawei.com>
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

Add a generic implementation of LU reset TMF handler, and use in LLDDs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  4 +---
 drivers/scsi/libsas/sas_scsi_host.c   | 10 ++++++++++
 drivers/scsi/mvsas/mv_sas.c           |  4 +---
 drivers/scsi/pm8001/pm8001_sas.c      |  4 +---
 include/scsi/libsas.h                 |  1 +
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 12919b063572..858f4b2aa211 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1938,9 +1938,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 			hisi_sas_release_task(hisi_hba, device);
 		sas_put_local_phy(phy);
 	} else {
-		struct sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
-
-		rc = hisi_sas_debug_issue_ssp_tmf(device, lun, &tmf_task);
+		rc = sas_lu_reset(device, lun);
 		if (rc == TMF_RESP_FUNC_COMPLETE)
 			hisi_sas_release_task(hisi_hba, device);
 	}
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 5520c857598b..a7beca31d1e8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1066,6 +1066,16 @@ int sas_clear_task_set(struct domain_device *dev, u8 *lun)
 }
 EXPORT_SYMBOL_GPL(sas_clear_task_set);
 
+int sas_lu_reset(struct domain_device *dev, u8 *lun)
+{
+	struct sas_tmf_task tmf_task = {
+		.tmf = TMF_LU_RESET,
+	};
+
+	return sas_execute_ssp_tmf(dev, lun, &tmf_task);
+}
+EXPORT_SYMBOL_GPL(sas_lu_reset);
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 146005d2d75c..61bf4d1e8355 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1384,13 +1384,11 @@ int mvs_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	unsigned long flags;
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct sas_tmf_task tmf_task;
 	struct mvs_device * mvi_dev = dev->lldd_dev;
 	struct mvs_info *mvi = mvi_dev->mvi_info;
 
-	tmf_task.tmf = TMF_LU_RESET;
 	mvi_dev->dev_status = MVS_DEV_EH;
-	rc = mvs_debug_issue_ssp_tmf(dev, lun, &tmf_task);
+	rc = sas_lu_reset(dev, lun);
 	if (rc == TMF_RESP_FUNC_COMPLETE) {
 		spin_lock_irqsave(&mvi->lock, flags);
 		mvs_release_task(mvi, dev);
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 3547e8538670..afea130807f2 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1111,7 +1111,6 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
 int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
-	struct sas_tmf_task tmf_task;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
@@ -1126,8 +1125,7 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 			pm8001_dev, DS_OPERATIONAL);
 		wait_for_completion(&completion_setstate);
 	} else {
-		tmf_task.tmf = TMF_LU_RESET;
-		rc = pm8001_issue_ssp_tmf(dev, lun, &tmf_task);
+		rc = sas_lu_reset(dev, lun);
 	}
 	/* If failed, fall-through I_T_Nexus reset */
 	pm8001_dbg(pm8001_ha, EH, "for device[%x]:rc=%d\n",
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 710f93ddc5d4..12caf688806c 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -726,6 +726,7 @@ int sas_request_addr(struct Scsi_Host *shost, u8 *addr);
 
 int sas_abort_task_set(struct domain_device *dev, u8 *lun);
 int sas_clear_task_set(struct domain_device *dev, u8 *lun);
+int sas_lu_reset(struct domain_device *dev, u8 *lun);
 
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
-- 
2.26.2

