Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0822C575501
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiGNSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbiGNSaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:30:01 -0400
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CF6B262;
        Thu, 14 Jul 2022 11:29:58 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.149])
        by sinmsgout02.his.huawei.com (SkyGuard) with ESMTP id 4LkNL13Y76z9v7Hs;
        Fri, 15 Jul 2022 02:28:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 20:29:46 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 19:29:44 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/5] scsi: hisi_sas: Relocate DMA unmap of SMP task
Date:   Fri, 15 Jul 2022 02:23:20 +0800
Message-ID: <1657823002-139010-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
References: <1657823002-139010-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Currently SMP tasks are DMA unmapped only when cq of SMP IO is returned
normally. If the cq of SMP IO is returned with exception actually SMP tas
is never unmapped. Relocate DMA unmap of SMP task to fix the issue.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 6 +++++-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 2 --
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 --
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 --
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index bd62e441f947..33af5b8dede2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -219,11 +219,15 @@ void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 		task->lldd_task = NULL;
 
 		if (!sas_protocol_ata(task->task_proto)) {
-			if (slot->n_elem)
+			if (slot->n_elem) {
 				if (task->task_proto & SAS_PROTOCOL_SSP)
 					dma_unmap_sg(dev, task->scatter,
 						     task->num_scatter,
 						     task->data_dir);
+				else
+					dma_unmap_sg(dev, &task->smp_task.smp_req,
+						     1, DMA_TO_DEVICE);
+			}
 			if (slot->n_elem_dif) {
 				struct sas_ssp_task *ssp_task = &task->ssp_task;
 				struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 4582791def32..349546bacb2b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1282,8 +1282,6 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 
 		ts->stat = SAS_SAM_STAT_GOOD;
 
-		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
-			     DMA_TO_DEVICE);
 		memcpy(to + sg_resp->offset,
 		       hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 18297ab5a32b..70e401fd432a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2428,8 +2428,6 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 
 		ts->stat = SAS_SAM_STAT_GOOD;
 
-		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
-			     DMA_TO_DEVICE);
 		memcpy(to + sg_resp->offset,
 		       hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 76c4173e277d..4d3eb53a8209 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2311,8 +2311,6 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 
 		ts->stat = SAS_SAM_STAT_GOOD;
 
-		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
-			     DMA_TO_DEVICE);
 		memcpy(to + sg_resp->offset,
 			hisi_sas_status_buf_addr_mem(slot) +
 		       sizeof(struct hisi_sas_err_record),
-- 
2.35.3

