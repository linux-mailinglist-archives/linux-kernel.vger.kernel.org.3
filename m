Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411D544C49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245685AbiFIMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiFIMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:37:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFA23143;
        Thu,  9 Jun 2022 05:37:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJk6z5dstzDq5Z;
        Thu,  9 Jun 2022 20:34:19 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:37:32 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:37:32 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH 2/3] crypto: hisilicon/qm - move alloc qm->wq to qm.c
Date:   Thu, 9 Jun 2022 20:31:18 +0800
Message-ID: <20220609123119.27252-3-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609123119.27252-1-qianweili@huawei.com>
References: <20220609123119.27252-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before stopping the function, the driver needs to flush all the remaining
work about event irq. Therefore, accelerator drivers use a private
workqueue(qm->wq) to handle event irq instead of the system workqueue.
This patch moves alloc workqueue from sec_main.c and zip_main.c to qm.c.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c            | 35 +++++++++++++++++-------
 drivers/crypto/hisilicon/sec2/sec_main.c | 24 +---------------
 drivers/crypto/hisilicon/zip/zip_main.c  | 17 +-----------
 3 files changed, 27 insertions(+), 49 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 903896ab5be5..f8d36b68494e 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -959,10 +959,7 @@ static irqreturn_t do_qm_irq(int irq, void *data)
 	struct hisi_qm *qm = (struct hisi_qm *)data;
 
 	/* the workqueue created by device driver of QM */
-	if (qm->wq)
-		queue_work(qm->wq, &qm->work);
-	else
-		schedule_work(&qm->work);
+	queue_work(qm->wq, &qm->work);
 
 	return IRQ_HANDLED;
 }
@@ -3134,11 +3131,8 @@ static int qm_stop_qp_nolock(struct hisi_qp *qp)
 	if (ret)
 		dev_err(dev, "Failed to drain out data for stopping!\n");
 
-	if (qp->qm->wq)
-		flush_workqueue(qp->qm->wq);
-	else
-		flush_work(&qp->qm->work);
 
+	flush_workqueue(qp->qm->wq);
 	if (unlikely(qp->is_resetting && atomic_read(&qp->qp_status.used)))
 		qp_stop_fail_cb(qp);
 
@@ -3672,6 +3666,11 @@ static void qm_last_regs_uninit(struct hisi_qm *qm)
 	debug->qm_last_words = NULL;
 }
 
+static void hisi_qm_unint_work(struct hisi_qm *qm)
+{
+	destroy_workqueue(qm->wq);
+}
+
 static void hisi_qm_memory_uninit(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -3698,6 +3697,7 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	qm_last_regs_uninit(qm);
 
 	qm_cmd_uninit(qm);
+	hisi_qm_unint_work(qm);
 	down_write(&qm->qps_lock);
 
 	if (!qm_avail_state(qm, QM_CLOSE)) {
@@ -6022,7 +6022,7 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 	return ret;
 }
 
-static void hisi_qm_init_work(struct hisi_qm *qm)
+static int hisi_qm_init_work(struct hisi_qm *qm)
 {
 	INIT_WORK(&qm->work, qm_work_process);
 	if (qm->fun_type == QM_HW_PF)
@@ -6030,6 +6030,16 @@ static void hisi_qm_init_work(struct hisi_qm *qm)
 
 	if (qm->ver > QM_HW_V2)
 		INIT_WORK(&qm->cmd_process, qm_cmd_process);
+
+	qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_MEM_RECLAIM |
+				 WQ_UNBOUND, num_online_cpus(),
+				 pci_name(qm->pdev));
+	if (!qm->wq) {
+		pci_err(qm->pdev, "failed to alloc workqueue!\n");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 static int hisi_qp_alloc_memory(struct hisi_qm *qm)
@@ -6180,7 +6190,10 @@ int hisi_qm_init(struct hisi_qm *qm)
 	if (ret)
 		goto err_alloc_uacce;
 
-	hisi_qm_init_work(qm);
+	ret = hisi_qm_init_work(qm);
+	if (ret)
+		goto err_free_qm_memory;
+
 	qm_cmd_init(qm);
 	atomic_set(&qm->status.flags, QM_INIT);
 
@@ -6188,6 +6201,8 @@ int hisi_qm_init(struct hisi_qm *qm)
 
 	return 0;
 
+err_free_qm_memory:
+	hisi_qm_memory_uninit(qm);
 err_alloc_uacce:
 	if (qm->use_sva) {
 		uacce_remove(qm->uacce);
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 4d85d2cbf376..bdb690aaed12 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1002,8 +1002,6 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 
 static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
-	int ret;
-
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
 	qm->algs = "cipher\ndigest\naead";
@@ -1029,25 +1027,7 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = SEC_QUEUE_NUM_V1 - SEC_PF_DEF_Q_NUM;
 	}
 
-	/*
-	 * WQ_HIGHPRI: SEC request must be low delayed,
-	 * so need a high priority workqueue.
-	 * WQ_UNBOUND: SEC task is likely with long
-	 * running CPU intensive workloads.
-	 */
-	qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_MEM_RECLAIM |
-				 WQ_UNBOUND, num_online_cpus(),
-				 pci_name(qm->pdev));
-	if (!qm->wq) {
-		pci_err(qm->pdev, "fail to alloc workqueue\n");
-		return -ENOMEM;
-	}
-
-	ret = hisi_qm_init(qm);
-	if (ret)
-		destroy_workqueue(qm->wq);
-
-	return ret;
+	return hisi_qm_init(qm);
 }
 
 static void sec_qm_uninit(struct hisi_qm *qm)
@@ -1078,8 +1058,6 @@ static int sec_probe_init(struct sec_dev *sec)
 static void sec_probe_uninit(struct hisi_qm *qm)
 {
 	hisi_qm_dev_err_uninit(qm);
-
-	destroy_workqueue(qm->wq);
 }
 
 static void sec_iommu_used_check(struct sec_dev *sec)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 9c925e9c0a2d..c3303d99acac 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -990,8 +990,6 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 
 static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
-	int ret;
-
 	qm->pdev = pdev;
 	qm->ver = pdev->revision;
 	if (pdev->revision >= QM_HW_V3)
@@ -1021,25 +1019,12 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		qm->qp_num = HZIP_QUEUE_NUM_V1 - HZIP_PF_DEF_Q_NUM;
 	}
 
-	qm->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_MEM_RECLAIM |
-				 WQ_UNBOUND, num_online_cpus(),
-				 pci_name(qm->pdev));
-	if (!qm->wq) {
-		pci_err(qm->pdev, "fail to alloc workqueue\n");
-		return -ENOMEM;
-	}
-
-	ret = hisi_qm_init(qm);
-	if (ret)
-		destroy_workqueue(qm->wq);
-
-	return ret;
+	return hisi_qm_init(qm);
 }
 
 static void hisi_zip_qm_uninit(struct hisi_qm *qm)
 {
 	hisi_qm_uninit(qm);
-	destroy_workqueue(qm->wq);
 }
 
 static int hisi_zip_probe_init(struct hisi_zip *hisi_zip)
-- 
2.33.0

