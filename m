Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E773E49E335
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiA0NSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:18:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4527 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiA0NSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:18:35 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jl1KL71wQz6GCwl;
        Thu, 27 Jan 2022 21:15:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 27 Jan 2022 14:18:33 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 13:18:31 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Viswas.G@microchip.com>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] scsi: pm8001: Fix use-after-free for aborted TMF sas_task
Date:   Thu, 27 Jan 2022 21:12:51 +0800
Message-ID: <1643289172-165636-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
References: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a use-after-free may occur if a TMF sas_task is aborted before
we handle the IO completion in mpi_ssp_completion(). The abort occurs due
to timeout.

When the timeout occurs, the SAS_TASK_STATE_ABORTED flag is set and the
sas_task is freed in pm8001_exec_internal_tmf_task().

However, if the IO completion occurs later, the IO completion still thinks
that the sas_task is available. Fix this by clearing the ccb->task if
the TMF times out - the IO completion handler does nothing if this pointer
is cleared.

Signed-off-by: John Garry <john.garry@huawei.com>
---

Note: For hisi_sas driver we already do something similar. However there
we also flush the completion queue interrupt to ensure that there is no
race in clearing the task pointer. Please advise if/how something similar
can be done here.

 drivers/scsi/pm8001/pm8001_sas.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 160ee8b228c9..32edda3e55c6 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -769,8 +769,13 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 		res = -TMF_RESP_FUNC_FAILED;
 		/* Even TMF timed out, return direct. */
 		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
+			struct pm8001_ccb_info *ccb = task->lldd_task;
+
 			pm8001_dbg(pm8001_ha, FAIL, "TMF task[%x]timeout.\n",
 				   tmf->tmf);
+
+			if (ccb)
+				ccb->task = NULL;
 			goto ex_err;
 		}
 
-- 
2.26.2

