Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B24E3CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiCVKty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiCVKrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D068167E;
        Tue, 22 Mar 2022 03:46:16 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7QC5qZ7z683yD;
        Tue, 22 Mar 2022 18:44:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:46:14 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:46:10 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 09/11] scsi: libsas: Add sas_task_to_unique_tag()
Date:   Tue, 22 Mar 2022 18:39:43 +0800
Message-ID: <1647945585-197349-10-git-send-email-john.garry@huawei.com>
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

Add a function to get the unique request tag from a sas_task.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c |  8 ++++----
 drivers/scsi/libsas/sas_scsi_host.c   | 14 ++++++++++++++
 include/scsi/libsas.h                 |  2 ++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index e438c68e249a..f6b64c789335 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -177,13 +177,13 @@ static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
 }
 
 static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
-				     struct scsi_cmnd *scsi_cmnd)
+				     struct sas_task *task)
 {
 	int index;
 	void *bitmap = hisi_hba->slot_index_tags;
 
-	if (scsi_cmnd)
-		return scsi_cmd_to_rq(scsi_cmnd)->tag;
+	if (task)
+		return sas_task_to_unique_tag(task);
 
 	spin_lock(&hisi_hba->lock);
 	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
@@ -572,7 +572,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
 	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
+		rc = hisi_sas_slot_index_alloc(hisi_hba, task);
 
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index f139977098c2..425904fa4cc7 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1065,6 +1065,20 @@ int sas_execute_internal_abort_dev(struct domain_device *device,
 }
 EXPORT_SYMBOL_GPL(sas_execute_internal_abort_dev);
 
+static u32 sas_task_to_rq_unique_tag(struct sas_task *task)
+{
+	return blk_mq_unique_tag(scsi_cmd_to_rq(task->uldd_task));
+}
+
+unsigned int sas_task_to_unique_tag(struct sas_task *task)
+{
+	u32 unique = sas_task_to_rq_unique_tag(task);
+
+	return blk_mq_unique_tag_to_tag(unique);
+
+}
+EXPORT_SYMBOL_GPL(sas_task_to_unique_tag);
+
 int sas_execute_tmf(struct domain_device *device, void *parameter,
 		    int para_len, int force_phy_id,
 		    struct sas_tmf_task *tmf)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index ff04eb6d250b..3d9ef4c2c889 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -625,6 +625,8 @@ struct sas_task {
 	struct sas_tmf_task *tmf;
 };
 
+unsigned int sas_task_to_unique_tag(struct sas_task *task);
+
 struct sas_task_slow {
 	/* standard/extra infrastructure for slow path commands (SMP and
 	 * internal lldd commands
-- 
2.26.2

