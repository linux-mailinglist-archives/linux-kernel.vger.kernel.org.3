Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292D44CBDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiCCMZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiCCMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:25:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC1F1186;
        Thu,  3 Mar 2022 04:24:35 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8VXk6rrRz67xX3;
        Thu,  3 Mar 2022 20:24:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 13:24:33 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 12:24:29 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/4] scsi: libsas: Add sas_execute_internal_abort_single()
Date:   Thu, 3 Mar 2022 20:18:47 +0800
Message-ID: <1646309930-138960-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
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

The internal abort feature is common to hisi_sas and pm8001 HBAs, and the
driver support is similar also, so add a common handler.

Two modes of operation will be supported:
- single: Abort a single tagged command
- device: Abort all commands associated with a specific domain device

A new protocol is added, SAS_PROTOCOL_INTERNAL_ABORT, so the common queue
command API may be re-used.

Only add "single" support as a first step.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 75 +++++++++++++++++++++++++++++
 include/scsi/libsas.h               | 14 ++++++
 include/scsi/sas.h                  |  2 +
 3 files changed, 91 insertions(+)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 5b5747e33dbd..0d05826e6e8c 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -920,6 +920,81 @@ void sas_task_internal_timedout(struct timer_list *t)
 #define TASK_TIMEOUT			(20 * HZ)
 #define TASK_RETRY			3
 
+static int sas_execute_internal_abort(struct domain_device *device,
+				      enum sas_internal_abort type, u16 tag,
+				      unsigned int qid, void *data)
+{
+	struct sas_ha_struct *ha = device->port->ha;
+	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
+	struct sas_task *task = NULL;
+	int res, retry;
+
+	for (retry = 0; retry < TASK_RETRY; retry++) {
+		task = sas_alloc_slow_task(GFP_KERNEL);
+		if (!task)
+			return -ENOMEM;
+
+		task->dev = device;
+		task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
+		task->task_done = sas_task_internal_done;
+		task->slow_task->timer.function = sas_task_internal_timedout;
+		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
+		add_timer(&task->slow_task->timer);
+
+		task->abort_task.tag = tag;
+		task->abort_task.type = type;
+
+		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
+		if (res) {
+			del_timer_sync(&task->slow_task->timer);
+			pr_err("Executing internal abort failed %016llx (%d)\n",
+			       SAS_ADDR(device->sas_addr), res);
+			break;
+		}
+
+		wait_for_completion(&task->slow_task->completion);
+		res = TMF_RESP_FUNC_FAILED;
+
+		/* Even if the internal abort timed out, return direct. */
+		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
+			pr_err("Internal abort: timeout %016llx\n",
+			       SAS_ADDR(device->sas_addr));
+
+			res = -EIO;
+			break;
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+			task->task_status.stat == SAS_SAM_STAT_GOOD) {
+			res = TMF_RESP_FUNC_COMPLETE;
+			break;
+		}
+
+		if (task->task_status.resp == SAS_TASK_COMPLETE &&
+			task->task_status.stat == TMF_RESP_FUNC_SUCC) {
+			res = TMF_RESP_FUNC_SUCC;
+			break;
+		}
+
+		pr_err("Internal abort: task to dev %016llx response: 0x%x status 0x%x\n",
+		       SAS_ADDR(device->sas_addr), task->task_status.resp,
+		       task->task_status.stat);
+		sas_free_task(task);
+		task = NULL;
+	}
+	BUG_ON(retry == TASK_RETRY && task != NULL);
+	sas_free_task(task);
+	return res;
+}
+
+int sas_execute_internal_abort_single(struct domain_device *device, u16 tag,
+				      unsigned int qid, void *data)
+{
+	return sas_execute_internal_abort(device, SAS_INTERNAL_ABORT_SINGLE,
+					  tag, qid, data);
+}
+EXPORT_SYMBOL_GPL(sas_execute_internal_abort_single);
+
 int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index df2c8fc43429..2d30d57916e5 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -557,6 +557,16 @@ struct sas_ata_task {
 	int    force_phy_id;
 };
 
+/* LLDDs rely on these values */
+enum sas_internal_abort {
+	SAS_INTERNAL_ABORT_SINGLE	= 0,
+};
+
+struct sas_internal_abort_task {
+	enum sas_internal_abort type;
+	u16 tag;
+};
+
 struct sas_smp_task {
 	struct scatterlist smp_req;
 	struct scatterlist smp_resp;
@@ -596,6 +606,7 @@ struct sas_task {
 		struct sas_ata_task ata_task;
 		struct sas_smp_task smp_task;
 		struct sas_ssp_task ssp_task;
+		struct sas_internal_abort_task abort_task;
 	};
 
 	struct scatterlist *scatter;
@@ -683,6 +694,9 @@ extern int sas_slave_configure(struct scsi_device *);
 extern int sas_change_queue_depth(struct scsi_device *, int new_depth);
 extern int sas_bios_param(struct scsi_device *, struct block_device *,
 			  sector_t capacity, int *hsc);
+int sas_execute_internal_abort_single(struct domain_device *device,
+				      u16 tag, unsigned int qid,
+				      void *data);
 extern struct scsi_transport_template *
 sas_domain_attach_transport(struct sas_domain_function_template *);
 extern struct device_attribute dev_attr_phy_event_threshold;
diff --git a/include/scsi/sas.h b/include/scsi/sas.h
index 332a463d08ef..acfc69fd72d0 100644
--- a/include/scsi/sas.h
+++ b/include/scsi/sas.h
@@ -95,6 +95,8 @@ enum sas_protocol {
 	SAS_PROTOCOL_SSP		= 0x08,
 	SAS_PROTOCOL_ALL		= 0x0E,
 	SAS_PROTOCOL_STP_ALL		= SAS_PROTOCOL_STP|SAS_PROTOCOL_SATA,
+	/* these are internal to libsas */
+	SAS_PROTOCOL_INTERNAL_ABORT	= 0x10,
 };
 
 /* From the spec; local phys only */
-- 
2.26.2

