Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAA4BA4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbiBQPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:49:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiBQPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:49:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EA169235;
        Thu, 17 Feb 2022 07:49:10 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzzkQ1ShHz67ycM;
        Thu, 17 Feb 2022 23:48:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:49:08 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:49:04 +0000
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
Subject: [PATCH v2 11/18] scsi: libsas: Add TMF handler exec complete callback
Date:   Thu, 17 Feb 2022 23:42:39 +0800
Message-ID: <1645112566-115804-12-git-send-email-john.garry@huawei.com>
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

The pm8001 TMF handler has some special processing when the TMF completes,
so add a callback and fill it in for the pm8001 driver.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
---
 drivers/scsi/libsas/sas_scsi_host.c |  3 +++
 drivers/scsi/pm8001/pm8001_init.c   |  1 +
 drivers/scsi/pm8001/pm8001_sas.c    | 14 ++++++++++++++
 drivers/scsi/pm8001/pm8001_sas.h    |  1 +
 include/scsi/libsas.h               |  3 +++
 5 files changed, 22 insertions(+)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index af2dd95a2b28..0f599744738d 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -957,6 +957,9 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 
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
index a53e4b54154f..69da7246ea20 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -1376,3 +1376,17 @@ void pm8001_port_formed(struct asd_sas_phy *sas_phy)
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
index 9c181ebccfee..dd6551e809a0 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -652,6 +652,9 @@ struct sas_domain_function_template {
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

