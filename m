Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A796F49B31B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382997AbiAYLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:44:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4502 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382409AbiAYLjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:39:09 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlBX12p1z687WJ;
        Tue, 25 Jan 2022 19:34:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:59 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:55 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 10/16] scsi: libsas: Add TMF handler aborted callback
Date:   Tue, 25 Jan 2022 19:32:46 +0800
Message-ID: <1643110372-85470-11-git-send-email-john.garry@huawei.com>
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

The hisi_sas TMF handler has some special processing when the TMF is
aborted, so add a callback and fill it in for the hisi_sas driver.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 20 ++++++++++++++++++++
 drivers/scsi/libsas/sas_scsi_host.c   |  2 ++
 include/scsi/libsas.h                 |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 4f146aa50423..a2c03cb6414f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -671,6 +671,25 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
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
@@ -2327,6 +2346,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_clear_nexus_ha	= hisi_sas_clear_nexus_ha,
 	.lldd_port_formed	= hisi_sas_port_formed,
 	.lldd_write_gpio	= hisi_sas_write_gpio,
+	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
 };
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 79a0a90cb359..956b4387c1b8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -969,6 +969,8 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 				pr_err("TMF (%d) task timeout for %016llx and not done\n",
 				       tmf->tmf, SAS_ADDR(device->sas_addr));
+				if (i->dft->lldd_tmf_aborted)
+					i->dft->lldd_tmf_aborted(task);
 				break;
 			}
 			pr_warn("TMF (%d) task timeout for %016llx and done\n",
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 9c2e58cbadc5..1e5ecfb2f36e 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -656,6 +656,7 @@ struct sas_domain_function_template {
 
 	/* Special TMF callbacks */
 	void (*lldd_tmf_exec_complete)(struct domain_device *dev);
+	void (*lldd_tmf_aborted)(struct sas_task *task);
 
 	/* Port and Adapter management */
 	int (*lldd_clear_nexus_port)(struct asd_sas_port *);
-- 
2.26.2

