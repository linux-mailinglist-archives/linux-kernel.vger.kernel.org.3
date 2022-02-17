Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258684BA520
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbiBQPuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:50:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiBQPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:49:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11716AA47;
        Thu, 17 Feb 2022 07:49:41 -0800 (PST)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JzzlV5J2Mz67bpd;
        Thu, 17 Feb 2022 23:49:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:49:39 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 15:49:34 +0000
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
Subject: [PATCH v2 18/18] scsi: libsas: Add sas_execute_ata_cmd()
Date:   Thu, 17 Feb 2022 23:42:46 +0800
Message-ID: <1645112566-115804-19-git-send-email-john.garry@huawei.com>
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

Add a function to execute an ATA command using the TMF code, and use in
the hisi_sas driver. That driver needs to be able to issue the command on
a specific phy, so add an interface for that.

With that, hisi_sas_exec_internal_tmf_task() may be deleted.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yihang Li <liyihang6@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 130 +------------------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   5 +-
 drivers/scsi/libsas/sas_ata.c          |   8 ++
 drivers/scsi/libsas/sas_scsi_host.c    |  10 +-
 include/scsi/libsas.h                  |  10 +-
 5 files changed, 29 insertions(+), 134 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 34ed4f8da7cc..efedfb3332c3 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1239,124 +1239,7 @@ static void hisi_sas_tmf_timedout(struct timer_list *t)
 		complete(&task->slow_task->completion);
 }
 
-#define TASK_TIMEOUT			(20 * HZ)
-#define TASK_RETRY			3
 #define INTERNAL_ABORT_TIMEOUT		(6 * HZ)
-static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
-					   void *parameter, u32 para_len,
-					   struct sas_tmf_task *tmf)
-{
-	struct hisi_sas_device *sas_dev = device->lldd_dev;
-	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
-	struct device *dev = hisi_hba->dev;
-	struct sas_task *task;
-	int res, retry;
-
-	for (retry = 0; retry < TASK_RETRY; retry++) {
-		task = sas_alloc_slow_task(GFP_KERNEL);
-		if (!task)
-			return -ENOMEM;
-
-		task->dev = device;
-		task->task_proto = device->tproto;
-
-		if (dev_is_sata(device)) {
-			task->ata_task.device_control_reg_update = 1;
-			memcpy(&task->ata_task.fis, parameter, para_len);
-		} else {
-			memcpy(&task->ssp_task, parameter, para_len);
-		}
-		task->task_done = hisi_sas_task_done;
-
-		task->slow_task->timer.function = hisi_sas_tmf_timedout;
-		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
-		add_timer(&task->slow_task->timer);
-
-		task->tmf = tmf;
-
-		res = hisi_sas_queue_command(task, GFP_KERNEL);
-		if (res) {
-			del_timer_sync(&task->slow_task->timer);
-			dev_err(dev, "abort tmf: executing internal task failed: %d\n",
-				res);
-			goto ex_err;
-		}
-
-		wait_for_completion(&task->slow_task->completion);
-		res = TMF_RESP_FUNC_FAILED;
-		/* Even TMF timed out, return direct. */
-		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
-			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
-				struct hisi_sas_slot *slot = task->lldd_task;
-
-				dev_err(dev, "abort tmf: TMF task timeout and not done\n");
-				if (slot) {
-					struct hisi_sas_cq *cq =
-					       &hisi_hba->cq[slot->dlvry_queue];
-					/*
-					 * sync irq to avoid free'ing task
-					 * before using task in IO completion
-					 */
-					synchronize_irq(cq->irq_no);
-					slot->task = NULL;
-				}
-
-				goto ex_err;
-			} else
-				dev_err(dev, "abort tmf: TMF task timeout\n");
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		     task->task_status.stat == TMF_RESP_FUNC_COMPLETE) {
-			res = TMF_RESP_FUNC_COMPLETE;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == TMF_RESP_FUNC_SUCC) {
-			res = TMF_RESP_FUNC_SUCC;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		      task->task_status.stat == SAS_DATA_UNDERRUN) {
-			/* no error, but return the number of bytes of
-			 * underrun
-			 */
-			dev_warn(dev, "abort tmf: task to dev %016llx resp: 0x%x sts 0x%x underrun\n",
-				 SAS_ADDR(device->sas_addr),
-				 task->task_status.resp,
-				 task->task_status.stat);
-			res = task->task_status.residual;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAS_DATA_OVERRUN) {
-			dev_warn(dev, "abort tmf: blocked task error\n");
-			res = -EMSGSIZE;
-			break;
-		}
-
-		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAS_OPEN_REJECT) {
-			dev_warn(dev, "abort tmf: open reject failed\n");
-			res = -EIO;
-		} else {
-			dev_warn(dev, "abort tmf: task to dev %016llx resp: 0x%x status 0x%x\n",
-				 SAS_ADDR(device->sas_addr),
-				 task->task_status.resp,
-				 task->task_status.stat);
-		}
-		sas_free_task(task);
-		task = NULL;
-	}
-ex_err:
-	if (retry == TASK_RETRY)
-		dev_warn(dev, "abort tmf: executing internal task failed!\n");
-	sas_free_task(task);
-	return res;
-}
 
 static void hisi_sas_fill_ata_reset_cmd(struct ata_device *dev,
 		bool reset, int pmp, u8 *fis)
@@ -1380,14 +1263,12 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 	int rc = TMF_RESP_FUNC_FAILED;
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct device *dev = hisi_hba->dev;
-	int s = sizeof(struct host_to_dev_fis);
-	struct sas_tmf_task tmf = {};
 
 	ata_for_each_link(link, ap, EDGE) {
 		int pmp = sata_srst_pmp(link);
 
 		hisi_sas_fill_ata_reset_cmd(link->device, 1, pmp, fis);
-		rc = hisi_sas_exec_internal_tmf_task(device, fis, s, &tmf);
+		rc = sas_execute_ata_cmd(device, fis, -1);
 		if (rc != TMF_RESP_FUNC_COMPLETE)
 			break;
 	}
@@ -1397,8 +1278,7 @@ static int hisi_sas_softreset_ata_disk(struct domain_device *device)
 			int pmp = sata_srst_pmp(link);
 
 			hisi_sas_fill_ata_reset_cmd(link->device, 0, pmp, fis);
-			rc = hisi_sas_exec_internal_tmf_task(device, fis,
-							     s, &tmf);
+			rc = sas_execute_ata_cmd(device, fis, -1);
 			if (rc != TMF_RESP_FUNC_COMPLETE)
 				dev_err(dev, "ata disk %016llx de-reset failed\n",
 					SAS_ADDR(device->sas_addr));
@@ -1508,10 +1388,8 @@ static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
 					     struct asd_sas_port *sas_port,
 					     struct domain_device *device)
 {
-	struct sas_tmf_task tmf_task = { .force_phy = 1 };
 	struct ata_port *ap = device->sata_dev.ap;
 	struct device *dev = hisi_hba->dev;
-	int s = sizeof(struct host_to_dev_fis);
 	int rc = TMF_RESP_FUNC_FAILED;
 	struct ata_link *link;
 	u8 fis[20] = {0};
@@ -1524,10 +1402,8 @@ static void hisi_sas_send_ata_reset_each_phy(struct hisi_hba *hisi_hba,
 		ata_for_each_link(link, ap, EDGE) {
 			int pmp = sata_srst_pmp(link);
 
-			tmf_task.phy_id = i;
 			hisi_sas_fill_ata_reset_cmd(link->device, 1, pmp, fis);
-			rc = hisi_sas_exec_internal_tmf_task(device, fis, s,
-							     &tmf_task);
+			rc = sas_execute_ata_cmd(device, fis, i);
 			if (rc != TMF_RESP_FUNC_COMPLETE) {
 				dev_err(dev, "phy%d ata reset failed rc=%d\n",
 					i, rc);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 5bab51dc21b3..441ac4b6f1f4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2491,6 +2491,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
+	struct sas_ata_task *ata_task = &task->ata_task;
 	struct sas_tmf_task *tmf = slot->tmf;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
@@ -2504,9 +2505,9 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	else
 		dw0 |= 4 << CMD_HDR_CMD_OFF;
 
-	if (tmf && tmf->force_phy) {
+	if (tmf && ata_task->force_phy) {
 		dw0 |= CMD_HDR_FORCE_PHY_MSK;
-		dw0 |= (1 << tmf->phy_id) << CMD_HDR_PHY_ID_OFF;
+		dw0 |= (1 << ata_task->force_phy_id) << CMD_HDR_PHY_ID_OFF;
 	}
 
 	hdr->dw0 = cpu_to_le32(dw0);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 71b42fe95b6f..d89ffb357f14 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -852,3 +852,11 @@ void sas_ata_wait_eh(struct domain_device *dev)
 	ap = dev->sata_dev.ap;
 	ata_port_wait_eh(ap);
 }
+
+int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
+{
+	struct sas_tmf_task tmf_task = {};
+	return sas_execute_tmf(device, fis, sizeof(struct host_to_dev_fis),
+			       force_phy_id, &tmf_task);
+}
+EXPORT_SYMBOL_GPL(sas_execute_ata_cmd);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 87dd18a85f6f..5b5747e33dbd 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -937,8 +937,16 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 		task->dev = device;
 		task->task_proto = device->tproto;
 
-		if (!dev_is_sata(device))
+		if (dev_is_sata(device)) {
+			task->ata_task.device_control_reg_update = 1;
+			if (force_phy_id >= 0) {
+				task->ata_task.force_phy = true;
+				task->ata_task.force_phy_id = force_phy_id;
+			}
+			memcpy(&task->ata_task.fis, parameter, para_len);
+		} else {
 			memcpy(&task->ssp_task, parameter, para_len);
+		}
 
 		task->task_done = sas_task_internal_done;
 		task->tmf = tmf;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 4ea964d33600..e295c67eb453 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -552,6 +552,9 @@ struct sas_ata_task {
 	u8     stp_affil_pol:1;
 
 	u8     device_control_reg_update:1;
+
+	bool   force_phy;
+	int    force_phy_id;
 };
 
 struct sas_smp_task {
@@ -579,10 +582,6 @@ struct sas_ssp_task {
 struct sas_tmf_task {
 	u8 tmf;
 	u16 tag_of_task_to_be_managed;
-
-	/* Temp */
-	int force_phy;
-	int phy_id;
 };
 
 struct sas_task {
@@ -727,10 +726,13 @@ int sas_clear_task_set(struct domain_device *dev, u8 *lun);
 int sas_lu_reset(struct domain_device *dev, u8 *lun);
 int sas_query_task(struct sas_task *task, u16 tag);
 int sas_abort_task(struct sas_task *task, u16 tag);
+int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
+			int force_phy_id);
 
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags);
 int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 			 gfp_t gfp_flags);
 
+
 #endif /* _SASLIB_H_ */
-- 
2.26.2

