Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346DD49B316
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356594AbiAYLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:43:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4499 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382347AbiAYLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:57 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjlGq01mfz67P7p;
        Tue, 25 Jan 2022 19:38:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 25 Jan 2022 12:38:48 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 11:38:44 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 07/16] scsi: libsas: Add sas_execute_tmf()
Date:   Tue, 25 Jan 2022 19:32:43 +0800
Message-ID: <1643110372-85470-8-git-send-email-john.garry@huawei.com>
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

Drivers using libsas have to issue their own TMFs, and the code to do this
is duplicated between drivers.

Add a common function to handle TMFs. This will be also used for sending
ATA commands, but use name "tmf" as the purpose is similar between SCSI
and ATA in the usage.

The force_phy_id argument will be used for a hisi_sas HW bug workaround.

We check the sas task status stat field against TMF codes, as according to
the SAS v1.1 spec 9.2.2.5.3, if response_data is in datapres, then the
response code should be a TMF code - see table 128.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_internal.h  |   3 +
 drivers/scsi/libsas/sas_scsi_host.c | 105 ++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index cd6aa723c3e1..b60f0bf612cf 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -97,6 +97,9 @@ extern const work_func_t sas_port_event_fns[PORT_NUM_EVENTS];
 
 void sas_task_internal_done(struct sas_task *task);
 void sas_task_internal_timedout(struct timer_list *t);
+int sas_execute_tmf(struct domain_device *device, void *parameter,
+		    int para_len, int force_phy_id,
+		    struct sas_tmf_task *tmf);
 
 #ifdef CONFIG_SCSI_SAS_HOST_SMP
 extern void sas_smp_host_handler(struct bsg_job *job, struct Scsi_Host *shost);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 42b6041d10fc..93ca6da63104 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -918,6 +918,111 @@ void sas_task_internal_timedout(struct timer_list *t)
 		complete(&task->slow_task->completion);
 }
 
+#define TASK_TIMEOUT			(20 * HZ)
+#define TASK_RETRY			3
+
+int sas_execute_tmf(struct domain_device *device, void *parameter,
+		    int para_len, int force_phy_id,
+		    struct sas_tmf_task *tmf)
+{
+	struct sas_task *task;
+	struct sas_internal *i =
+		to_sas_internal(device->port->ha->core.shost->transportt);
+	int res, retry;
+
+	for (retry = 0; retry < TASK_RETRY; retry++) {
+		task = sas_alloc_slow_task(GFP_KERNEL);
+		if (!task)
+			return -ENOMEM;
+
+		task->dev = device;
+		task->task_proto = device->tproto;
+
+		task->task_done = sas_task_internal_done;
+		task->tmf = tmf;
+
+		task->slow_task->timer.function = sas_task_internal_timedout;
+		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
+		add_timer(&task->slow_task->timer);
+
+		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
+		if (res) {
+			del_timer_sync(&task->slow_task->timer);
+			pr_err("executing TMF (%d) task failed %016llx (%d)\n", tmf->tmf,
+			       SAS_ADDR(device->sas_addr), res);
+			break;
+		}
+
+		wait_for_completion(&task->slow_task->completion);
+
+		res = TMF_RESP_FUNC_FAILED;
+
+		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
+			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
+				pr_err("TMF (%d) task timeout for %016llx and not done\n",
+				       tmf->tmf, SAS_ADDR(device->sas_addr));
+				break;
+			}
+			pr_warn("TMF (%d) task timeout for %016llx and done\n",
+				tmf->tmf, SAS_ADDR(device->sas_addr));
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+		    task->task_status.stat == TMF_RESP_FUNC_COMPLETE) {
+			res = TMF_RESP_FUNC_COMPLETE;
+			break;
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+		    task->task_status.stat == TMF_RESP_FUNC_SUCC) {
+			res = TMF_RESP_FUNC_SUCC;
+			break;
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+		    task->task_status.stat == SAS_DATA_UNDERRUN) {
+			/* no error, but return the number of bytes of
+			 * underrun
+			 */
+			pr_warn("TMF (%d) task to dev %016llx resp: 0x%x sts 0x%x underrun\n",
+				tmf->tmf, SAS_ADDR(device->sas_addr),
+				task->task_status.resp,
+				task->task_status.stat);
+			res = task->task_status.residual;
+			break;
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+		    task->task_status.stat == SAS_DATA_OVERRUN) {
+			pr_warn("TMF (%d) task blocked task error %016llx\n",
+				tmf->tmf, SAS_ADDR(device->sas_addr));
+			res = -EMSGSIZE;
+			break;
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+		    task->task_status.stat == SAS_OPEN_REJECT) {
+			pr_warn("TMF (%d) task open reject failed  %016llx\n",
+				tmf->tmf, SAS_ADDR(device->sas_addr));
+			res = -EIO;
+		} else {
+			pr_warn("TMF (%d) task to dev %016llx resp: 0x%x status 0x%x\n",
+				tmf->tmf, SAS_ADDR(device->sas_addr),
+				task->task_status.resp,
+				task->task_status.stat);
+		}
+		sas_free_task(task);
+		task = NULL;
+	}
+
+	if (retry == TASK_RETRY)
+		pr_warn("executing TMF (%d) for %016llx failed after %d attempts!\n",
+			tmf->tmf, SAS_ADDR(device->sas_addr), TASK_RETRY);
+	sas_free_task(task);
+
+	return res;
+}
+
 /*
  * Tell an upper layer that it needs to initiate an abort for a given task.
  * This should only ever be called by an LLDD.
-- 
2.26.2

