Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444B5754FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiGNS3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiGNS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:29:51 -0400
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B206A9F2;
        Thu, 14 Jul 2022 11:29:50 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.156.148])
        by sinmsgout03.his.huawei.com (SkyGuard) with ESMTP id 4LkNKg6n9kz9v79V;
        Fri, 15 Jul 2022 02:28:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 20:29:44 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 19:29:41 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/5] scsi: hisi_sas: Remove unnecessary variable to hold DMA map elements
Date:   Fri, 15 Jul 2022 02:23:19 +0800
Message-ID: <1657823002-139010-3-git-send-email-john.garry@huawei.com>
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

Use slot->n_elem to store the return value of dma_map_sg() for SSP and
SMP IOs, and remove unnecessary variable n_elem_req.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 43 +++++++++++----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 764e859d0106..bd62e441f947 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -220,9 +220,10 @@ void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 
 		if (!sas_protocol_ata(task->task_proto)) {
 			if (slot->n_elem)
-				dma_unmap_sg(dev, task->scatter,
-					     task->num_scatter,
-					     task->data_dir);
+				if (task->task_proto & SAS_PROTOCOL_SSP)
+					dma_unmap_sg(dev, task->scatter,
+						     task->num_scatter,
+						     task->data_dir);
 			if (slot->n_elem_dif) {
 				struct sas_ssp_task *ssp_task = &task->ssp_task;
 				struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
@@ -269,28 +270,23 @@ static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
 }
 
 static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
-			       struct sas_task *task, int n_elem,
-			       int n_elem_req)
+			       struct sas_task *task, int n_elem)
 {
 	struct device *dev = hisi_hba->dev;
 
-	if (!sas_protocol_ata(task->task_proto)) {
+	if (!sas_protocol_ata(task->task_proto) && n_elem) {
 		if (task->num_scatter) {
-			if (n_elem)
-				dma_unmap_sg(dev, task->scatter,
-					     task->num_scatter,
-					     task->data_dir);
+			dma_unmap_sg(dev, task->scatter, task->num_scatter,
+				     task->data_dir);
 		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
-			if (n_elem_req)
-				dma_unmap_sg(dev, &task->smp_task.smp_req,
-					     1, DMA_TO_DEVICE);
+			dma_unmap_sg(dev, &task->smp_task.smp_req,
+				     1, DMA_TO_DEVICE);
 		}
 	}
 }
 
 static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
-			    struct sas_task *task, int *n_elem,
-			    int *n_elem_req)
+			    struct sas_task *task, int *n_elem)
 {
 	struct device *dev = hisi_hba->dev;
 	int rc;
@@ -308,9 +304,9 @@ static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
 				goto prep_out;
 			}
 		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
-			*n_elem_req = dma_map_sg(dev, &task->smp_task.smp_req,
-						 1, DMA_TO_DEVICE);
-			if (!*n_elem_req) {
+			*n_elem = dma_map_sg(dev, &task->smp_task.smp_req,
+					     1, DMA_TO_DEVICE);
+			if (!*n_elem) {
 				rc = -ENOMEM;
 				goto prep_out;
 			}
@@ -332,8 +328,7 @@ static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
 
 err_out_dma_unmap:
 	/* It would be better to call dma_unmap_sg() here, but it's messy */
-	hisi_sas_dma_unmap(hisi_hba, task, *n_elem,
-			   *n_elem_req);
+	hisi_sas_dma_unmap(hisi_hba, task, *n_elem);
 prep_out:
 	return rc;
 }
@@ -457,7 +452,7 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
 
 static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 {
-	int n_elem = 0, n_elem_dif = 0, n_elem_req = 0;
+	int n_elem = 0, n_elem_dif = 0;
 	struct domain_device *device = task->dev;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
@@ -568,8 +563,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 		return -EINVAL;
 	}
 
-	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
-			      &n_elem_req);
+	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem);
 	if (rc < 0)
 		goto prep_out;
 
@@ -605,8 +599,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	if (!sas_protocol_ata(task->task_proto))
 		hisi_sas_dif_dma_unmap(hisi_hba, task, n_elem_dif);
 err_out_dma_unmap:
-	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
-				   n_elem_req);
+	hisi_sas_dma_unmap(hisi_hba, task, n_elem);
 prep_out:
 	dev_err(dev, "task exec: failed[%d]!\n", rc);
 	return rc;
-- 
2.35.3

