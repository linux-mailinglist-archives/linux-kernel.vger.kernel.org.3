Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C774849B317
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383178AbiAYLoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:44:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4500 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382389AbiAYLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:58 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlGt32kGz6864m;
        Tue, 25 Jan 2022 19:38:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:52 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:48 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 08/16] scsi: libsas: Add sas_execute_ssp_tmf()
Date:   Tue, 25 Jan 2022 19:32:44 +0800
Message-ID: <1643110372-85470-9-git-send-email-john.garry@huawei.com>
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

Add a function to issue an SSP TMF.

Add a temp prototype to keep make W=1 happy.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 93ca6da63104..cfdf4a031be0 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -938,6 +938,11 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 		task->dev = device;
 		task->task_proto = device->tproto;
 
+		if (dev_is_sata(device)) {
+		} else {
+			memcpy(&task->ssp_task, parameter, para_len);
+		}
+
 		task->task_done = sas_task_internal_done;
 		task->tmf = tmf;
 
@@ -1023,6 +1028,21 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 	return res;
 }
 
+int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
+			struct sas_tmf_task *tmf);
+int sas_execute_ssp_tmf(struct domain_device *device, u8 *lun,
+			struct sas_tmf_task *tmf)
+{
+	struct sas_ssp_task ssp_task;
+
+	if (!(device->tproto & SAS_PROTOCOL_SSP))
+		return TMF_RESP_FUNC_ESUPP;
+
+	memcpy(ssp_task.LUN, lun, 8);
+
+	return sas_execute_tmf(device, &ssp_task, sizeof(ssp_task), -1, tmf);
+}
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
-- 
2.26.2

