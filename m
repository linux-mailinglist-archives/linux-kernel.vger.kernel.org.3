Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA74E3CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiCVKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiCVKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:48:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68283009;
        Tue, 22 Mar 2022 03:46:24 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7QM4npFz67l7t;
        Tue, 22 Mar 2022 18:44:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:46:22 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:46:18 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 11/11] scsi: hisi_sas: Remove private tag management
Date:   Tue, 22 Mar 2022 18:39:45 +0800
Message-ID: <1647945585-197349-12-git-send-email-john.garry@huawei.com>
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

Now every sas_task which the driver sees has a SCSI command and also
request associated, so drop the internal tag management.

No reserved tags have been set aside in the tagset yet, but this is simple
to do.

For v2 HW we need to continue to allocate the tag internally as the HW is
so broken and we need to use special rules for tag allocation, see
slot_index_alloc_quirk_v2_hw()

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 37 +--------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index b3e03c229cb5..19c9ed169c91 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -169,41 +169,6 @@ static void hisi_sas_slot_index_free(struct hisi_hba *hisi_hba, int slot_idx)
 	}
 }
 
-static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
-{
-	void *bitmap = hisi_hba->slot_index_tags;
-
-	__set_bit(slot_idx, bitmap);
-}
-
-static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
-				     struct sas_task *task)
-{
-	int index;
-	void *bitmap = hisi_hba->slot_index_tags;
-
-	if (task)
-		return sas_task_to_unique_tag(task);
-
-	spin_lock(&hisi_hba->lock);
-	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
-				   hisi_hba->last_slot_index + 1);
-	if (index >= hisi_hba->slot_index_count) {
-		index = find_next_zero_bit(bitmap,
-				hisi_hba->slot_index_count,
-				HISI_SAS_UNRESERVED_IPTT);
-		if (index >= hisi_hba->slot_index_count) {
-			spin_unlock(&hisi_hba->lock);
-			return -SAS_QUEUE_FULL;
-		}
-	}
-	hisi_sas_slot_index_set(hisi_hba, index);
-	hisi_hba->last_slot_index = index;
-	spin_unlock(&hisi_hba->lock);
-
-	return index;
-}
-
 void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba, struct sas_task *task,
 			     struct hisi_sas_slot *slot)
 {
@@ -556,7 +521,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
 	else
-		rc = hisi_sas_slot_index_alloc(hisi_hba, task);
+		rc = sas_task_to_unique_tag(task);
 
 	if (rc < 0)
 		goto err_out_dif_dma_unmap;
-- 
2.26.2

