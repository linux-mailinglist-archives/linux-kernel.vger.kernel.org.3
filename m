Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396F549B318
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359743AbiAYLof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:44:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4501 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351199AbiAYLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:39:02 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlCR0PN6z6842f;
        Tue, 25 Jan 2022 19:35:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:55 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:52 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 09/16] scsi: libsas: Add TMF handler exec complete callback
Date:   Tue, 25 Jan 2022 19:32:45 +0800
Message-ID: <1643110372-85470-10-git-send-email-john.garry@huawei.com>
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

The pm8001 TMF handler has some special processing when the TMF completes,
so add a callback and fill it in for the pm8001 driver.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c |  3 +++
 drivers/scsi/pm8001/pm8001_init.c   |  1 +
 drivers/scsi/pm8001/pm8001_sas.c    | 14 ++++++++++++++
 drivers/scsi/pm8001/pm8001_sas.h    |  1 +
 include/scsi/libsas.h               |  3 +++
 5 files changed, 22 insertions(+)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index cfdf4a031be0..79a0a90cb359 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -960,6 +960,9 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 
 		wait_for_completion(&task->slow_task->completion);
 
+		if (i->dft->lldd_tmf_exec_complete)
+			i->dft->lldd_tmf_exec_complete(device);
+
 		res = TMF_RESP_FUNC_FAILED;
 
 		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index b8cf1bae4040..8eef8f4de42f 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -128,6 +128,7 @@ static struct sas_domain_function_template pm8001_transport_ops = {
 	.lldd_lu_reset		= pm8001_lu_reset,
 	.lldd_query_task	= pm8001_query_task,
 	.lldd_port_formed	= pm8001_port_formed,
+	.lldd_tmf_exec_complete = pm8001_setds_completion,
 };
 
 /**
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 323b172243b8..06e5d5741ae2 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1375,3 +1375,17 @@ void pm8001_port_formed(struct asd_sas_phy *sas_phy)
 	}
 	sas_port->lldd_port = port;
 }
+
+void pm8001_setds_completion(struct domain_device *dev)
+{
+	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
+	struct pm8001_device *pm8001_dev = dev->lldd_dev;
+	DECLARE_COMPLETION_ONSTACK(completion_setstate);
+
+	if (pm8001_ha->chip_id != chip_8001) {
+		pm8001_dev->setds_completion = &completion_setstate;
+		PM8001_CHIP_DISP->set_dev_state_req(pm8001_ha,
+			pm8001_dev, DS_OPERATIONAL);
+		wait_for_completion(&completion_setstate);
+	}
+}
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 0b1086042ca6..c19c9c80206c 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -742,6 +742,7 @@ pm8001_ccb_task_free_done(struct pm8001_hba_info *pm8001_ha,
 	smp_mb(); /*in order to force CPU ordering*/
 	task->task_done(task);
 }
+void pm8001_setds_completion(struct domain_device *dev);
 
 #endif
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 802b4e04e3a1..9c2e58cbadc5 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -654,6 +654,9 @@ struct sas_domain_function_template {
 	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
 	int (*lldd_query_task)(struct sas_task *);
 
+	/* Special TMF callbacks */
+	void (*lldd_tmf_exec_complete)(struct domain_device *dev);
+
 	/* Port and Adapter management */
 	int (*lldd_clear_nexus_port)(struct asd_sas_port *);
 	int (*lldd_clear_nexus_ha)(struct sas_ha_struct *);
-- 
2.26.2

