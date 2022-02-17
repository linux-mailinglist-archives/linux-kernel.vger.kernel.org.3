Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26554BA4FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiBQPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:49:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbiBQPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:49:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218415DDFC;
        Thu, 17 Feb 2022 07:49:15 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jzzl06JVnz67w0f;
        Thu, 17 Feb 2022 23:48:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:49:13 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:49:08 +0000
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
Subject: [PATCH v2 12/18] scsi: libsas: Add TMF handler aborted callback
Date:   Thu, 17 Feb 2022 23:42:40 +0800
Message-ID: <1645112566-115804-13-git-send-email-john.garry@huawei.com>
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

The hisi_sas and pm8001 TMF handlers have some special processing for when
the TMF is aborted, so add a callback and fill it in for those drivers.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 20 ++++++++++++++++++++
 drivers/scsi/libsas/sas_scsi_host.c   |  2 ++
 drivers/scsi/pm8001/pm8001_init.c     |  1 +
 drivers/scsi/pm8001/pm8001_sas.c      |  8 ++++++++
 drivers/scsi/pm8001/pm8001_sas.h      |  1 +
 include/scsi/libsas.h                 |  1 +
 6 files changed, 33 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index bd40323f7053..21e929c8bdb0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -666,6 +666,25 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
 	return sas_dev;
 }
 
+static void hisi_sas_tmf_aborted(struct sas_task *task)
+{
+	struct hisi_sas_slot *slot = task->lldd_task;
+	struct domain_device *device = task->dev;
+	struct hisi_sas_device *sas_dev = device->lldd_dev;
+	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
+
+	if (slot) {
+		struct hisi_sas_cq *cq =
+			   &hisi_hba->cq[slot->dlvry_queue];
+		/*
+		 * sync irq to avoid free'ing task
+		 * before using task in IO completion
+		 */
+		synchronize_irq(cq->irq_no);
+		slot->task = NULL;
+	}
+}
+
 #define HISI_SAS_DISK_RECOVER_CNT 3
 static int hisi_sas_init_device(struct domain_device *device)
 {
@@ -2322,6 +2341,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_clear_nexus_ha	= hisi_sas_clear_nexus_ha,
 	.lldd_port_formed	= hisi_sas_port_formed,
 	.lldd_write_gpio	= hisi_sas_write_gpio,
+	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
 };
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 0f599744738d..c5d9c6a6b870 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -966,6 +966,8 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 				pr_err("TMF task timeout for %016llx and not done\n",
 				       SAS_ADDR(device->sas_addr));
+				if (i->dft->lldd_tmf_aborted)
+					i->dft->lldd_tmf_aborted(task);
 				break;
 			}
 			pr_warn("TMF task timeout for %016llx and done\n",
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 8eef8f4de42f..6a3635c39f6a 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -129,6 +129,7 @@ static struct sas_domain_function_template pm8001_transport_ops = {
 	.lldd_query_task	= pm8001_query_task,
 	.lldd_port_formed	= pm8001_port_formed,
 	.lldd_tmf_exec_complete = pm8001_setds_completion,
+	.lldd_tmf_aborted	= pm8001_tmf_aborted,
 };
 
 /**
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 69da7246ea20..a530fb0aaa05 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1390,3 +1390,11 @@ void pm8001_setds_completion(struct domain_device *dev)
 		wait_for_completion(&completion_setstate);
 	}
 }
+
+void pm8001_tmf_aborted(struct sas_task *task)
+{
+	struct pm8001_ccb_info *ccb = task->lldd_task;
+
+	if (ccb)
+		ccb->task = NULL;
+}
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index c19c9c80206c..aa018d2d19a3 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -743,6 +743,7 @@ pm8001_ccb_task_free_done(struct pm8001_hba_info *pm8001_ha,
 	task->task_done(task);
 }
 void pm8001_setds_completion(struct domain_device *dev);
+void pm8001_tmf_aborted(struct sas_task *task);
 
 #endif
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index dd6551e809a0..c44de478e314 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -654,6 +654,7 @@ struct sas_domain_function_template {
 
 	/* Special TMF callbacks */
 	void (*lldd_tmf_exec_complete)(struct domain_device *dev);
+	void (*lldd_tmf_aborted)(struct sas_task *task);
 
 	/* Port and Adapter management */
 	int (*lldd_clear_nexus_port)(struct asd_sas_port *);
-- 
2.26.2

