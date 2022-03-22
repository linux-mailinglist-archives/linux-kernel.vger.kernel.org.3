Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22734E3CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiCVKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiCVKrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6474182322;
        Tue, 22 Mar 2022 03:46:20 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7QJ0GhKz67Xmk;
        Tue, 22 Mar 2022 18:44:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:46:18 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:46:14 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 10/11] scsi: libsas: Add sas_task_to_hwq()
Date:   Tue, 22 Mar 2022 18:39:44 +0800
Message-ID: <1647945585-197349-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to get the hw queue index from a sas_task.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 20 ++------------------
 drivers/scsi/libsas/sas_scsi_host.c   |  9 ++++++++-
 include/scsi/libsas.h                 |  2 +-
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index f6b64c789335..b3e03c229cb5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -461,7 +461,6 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
 	bool internal_abort = sas_is_internal_abort(task);
-	struct scsi_cmnd *scmd = NULL;
 	struct hisi_sas_dq *dq = NULL;
 	struct hisi_sas_port *port;
 	struct hisi_hba *hisi_hba;
@@ -486,6 +485,8 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	hisi_hba = dev_to_hisi_hba(device);
 	dev = hisi_hba->dev;
 
+	dq = &hisi_hba->dq[sas_task_to_hwq(task)];
+
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SSP:
 	case SAS_PROTOCOL_SMP:
@@ -520,22 +521,6 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 				return -ECOMM;
 		}
 
-		scmd = task->uldd_task;
-
-		if (scmd) {
-			unsigned int dq_index;
-			u32 blk_tag;
-
-			blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
-			dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
-			dq = &hisi_hba->dq[dq_index];
-		} else {
-			struct Scsi_Host *shost = hisi_hba->shost;
-			struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-			int queue = qmap->mq_map[raw_smp_processor_id()];
-
-			dq = &hisi_hba->dq[queue];
-		}
 		break;
 	case SAS_PROTOCOL_INTERNAL_ABORT:
 		if (!hisi_hba->hw->prep_abort)
@@ -550,7 +535,6 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 			return -EINVAL;
 
 		port = to_hisi_sas_port(sas_port);
-		dq = &hisi_hba->dq[task->abort_task.qid];
 		break;
 	default:
 		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 425904fa4cc7..b808b23e265e 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -986,7 +986,6 @@ static int sas_execute_internal_abort(struct domain_device *device,
 
 		task->abort_task.tag = tag;
 		task->abort_task.type = type;
-		task->abort_task.qid = qid;
 
 		rq = scsi_alloc_request_hwq(request_queue, REQ_OP_DRV_IN, BLK_MQ_REQ_NOWAIT, qid);
 		if (!rq) {
@@ -1079,6 +1078,14 @@ unsigned int sas_task_to_unique_tag(struct sas_task *task)
 }
 EXPORT_SYMBOL_GPL(sas_task_to_unique_tag);
 
+unsigned int sas_task_to_hwq(struct sas_task *task)
+{
+	u32 unique = sas_task_to_rq_unique_tag(task);
+
+	return blk_mq_unique_tag_to_hwq(unique);
+}
+EXPORT_SYMBOL_GPL(sas_task_to_hwq);
+
 int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3d9ef4c2c889..368c45016af0 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -565,7 +565,6 @@ enum sas_internal_abort {
 
 struct sas_internal_abort_task {
 	enum sas_internal_abort type;
-	unsigned int qid;
 	u16 tag;
 };
 
@@ -626,6 +625,7 @@ struct sas_task {
 };
 
 unsigned int sas_task_to_unique_tag(struct sas_task *task);
+unsigned int sas_task_to_hwq(struct sas_task *task);
 
 struct sas_task_slow {
 	/* standard/extra infrastructure for slow path commands (SMP and
-- 
2.26.2

