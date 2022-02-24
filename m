Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D34C2B47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiBXL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiBXL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:57:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D249932;
        Thu, 24 Feb 2022 03:57:10 -0800 (PST)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4B8y22VHz687sK;
        Thu, 24 Feb 2022 19:52:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:57:08 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:57:05 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/6] scsi: hisi_sas: Free irq vectors in order for v3 HW
Date:   Thu, 24 Feb 2022 19:51:26 +0800
Message-ID: <1645703489-87194-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
References: <1645703489-87194-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

From: Qi Liu <liuqi115@huawei.com>

If the driver probe fails to request the channel IRQ or fatal IRQ, the
driver will free the IRQ vectors before freeing the IRQs in free_irq(),
and this will cause a kernel BUG like this:

------------[ cut here ]------------
kernel BUG at drivers/pci/msi.c:369!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Call trace:
   free_msi_irqs+0x118/0x13c
   pci_disable_msi+0xfc/0x120
   pci_free_irq_vectors+0x24/0x3c
   hisi_sas_v3_probe+0x360/0x9d0 [hisi_sas_v3_hw]
   local_pci_probe+0x44/0xb0
   work_for_cpu_fn+0x20/0x34
   process_one_work+0x1d0/0x340
   worker_thread+0x2e0/0x460
   kthread+0x180/0x190
   ret_from_fork+0x10/0x20
---[ end trace b88990335b610c11 ]---

So we use devm_add_action() to control the order in which we free the
vectors.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 29a566a19219..5b5557cab7ed 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2397,17 +2397,25 @@ static irqreturn_t cq_interrupt_v3_hw(int irq_no, void *p)
 	return IRQ_WAKE_THREAD;
 }
 
+static void hisi_sas_v3_free_vectors(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	pci_free_irq_vectors(pdev);
+}
+
 static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
 {
 	int vectors;
 	int max_msi = HISI_SAS_MSI_COUNT_V3_HW, min_msi;
 	struct Scsi_Host *shost = hisi_hba->shost;
+	struct pci_dev *pdev = hisi_hba->pci_dev;
 	struct irq_affinity desc = {
 		.pre_vectors = BASE_VECTORS_V3_HW,
 	};
 
 	min_msi = MIN_AFFINE_VECTORS_V3_HW;
-	vectors = pci_alloc_irq_vectors_affinity(hisi_hba->pci_dev,
+	vectors = pci_alloc_irq_vectors_affinity(pdev,
 						 min_msi, max_msi,
 						 PCI_IRQ_MSI |
 						 PCI_IRQ_AFFINITY,
@@ -2419,6 +2427,7 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
 	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
 	shost->nr_hw_queues = hisi_hba->cq_nvecs;
 
+	devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);
 	return 0;
 }
 
@@ -4768,7 +4777,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	rc = scsi_add_host(shost, dev);
 	if (rc)
-		goto err_out_free_irq_vectors;
+		goto err_out_debugfs;
 
 	rc = sas_register_ha(sha);
 	if (rc)
@@ -4799,8 +4808,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sas_unregister_ha(sha);
 err_out_register_ha:
 	scsi_remove_host(shost);
-err_out_free_irq_vectors:
-	pci_free_irq_vectors(pdev);
 err_out_debugfs:
 	debugfs_exit_v3_hw(hisi_hba);
 err_out_ha:
@@ -4824,7 +4831,6 @@ hisi_sas_v3_destroy_irqs(struct pci_dev *pdev, struct hisi_hba *hisi_hba)
 
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, nr), cq);
 	}
-	pci_free_irq_vectors(pdev);
 }
 
 static void hisi_sas_v3_remove(struct pci_dev *pdev)
-- 
2.26.2

