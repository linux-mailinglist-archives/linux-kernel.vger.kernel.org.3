Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754BB544C48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbiFIMht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245552AbiFIMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:37:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C481723141;
        Thu,  9 Jun 2022 05:37:34 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJk9Z280fzjXM5;
        Thu,  9 Jun 2022 20:36:34 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:37:33 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:37:32 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH 3/3] crypto: hisilicon/qm - modify event irq processing
Date:   Thu, 9 Jun 2022 20:31:19 +0800
Message-ID: <20220609123119.27252-4-qianweili@huawei.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver receives an event interrupt, the driver will enable
the event interrupt after handling all completed tasks on the function,
tasks on the function are parsed through only one thread. If the task's
user callback takes time, other tasks on the function will be blocked.

Therefore, the event irq processing is modified as follows:
1. Obtain the ID of the queue that completes the task.
2. Enable event interrupt.
3. Parse the completed tasks in the queue and call the user callback.
Enabling event interrupt in advance can quickly report pending event
interrupts and process tasks in multiple threads.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 142 ++++++++++++++++++++++------------
 include/linux/hisi_acc_qm.h   |   8 +-
 2 files changed, 99 insertions(+), 51 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f8d36b68494e..ad83c194d664 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -877,13 +877,6 @@ static void qm_pm_put_sync(struct hisi_qm *qm)
 	pm_runtime_put_autosuspend(dev);
 }
 
-static struct hisi_qp *qm_to_hisi_qp(struct hisi_qm *qm, struct qm_eqe *eqe)
-{
-	u16 cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-
-	return &qm->qp_array[cqn];
-}
-
 static void qm_cq_head_update(struct hisi_qp *qp)
 {
 	if (qp->qp_status.cq_head == QM_Q_DEPTH - 1) {
@@ -894,47 +887,37 @@ static void qm_cq_head_update(struct hisi_qp *qp)
 	}
 }
 
-static void qm_poll_qp(struct hisi_qp *qp, struct hisi_qm *qm)
+static void qm_poll_req_cb(struct hisi_qp *qp)
 {
-	if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP))
-		return;
-
-	if (qp->event_cb) {
-		qp->event_cb(qp);
-		return;
-	}
-
-	if (qp->req_cb) {
-		struct qm_cqe *cqe = qp->cqe + qp->qp_status.cq_head;
-
-		while (QM_CQE_PHASE(cqe) == qp->qp_status.cqc_phase) {
-			dma_rmb();
-			qp->req_cb(qp, qp->sqe + qm->sqe_size *
-				   le16_to_cpu(cqe->sq_head));
-			qm_cq_head_update(qp);
-			cqe = qp->cqe + qp->qp_status.cq_head;
-			qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
-			      qp->qp_status.cq_head, 0);
-			atomic_dec(&qp->qp_status.used);
-		}
+	struct qm_cqe *cqe = qp->cqe + qp->qp_status.cq_head;
+	struct hisi_qm *qm = qp->qm;
 
-		/* set c_flag */
+	while (QM_CQE_PHASE(cqe) == qp->qp_status.cqc_phase) {
+		dma_rmb();
+		qp->req_cb(qp, qp->sqe + qm->sqe_size *
+			   le16_to_cpu(cqe->sq_head));
+		qm_cq_head_update(qp);
+		cqe = qp->cqe + qp->qp_status.cq_head;
 		qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
-		      qp->qp_status.cq_head, 1);
+		      qp->qp_status.cq_head, 0);
+		atomic_dec(&qp->qp_status.used);
 	}
+
+	/* set c_flag */
+	qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ, qp->qp_status.cq_head, 1);
 }
 
-static void qm_work_process(struct work_struct *work)
+static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
 {
-	struct hisi_qm *qm = container_of(work, struct hisi_qm, work);
+	struct hisi_qm *qm = poll_data->qm;
 	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	struct hisi_qp *qp;
 	int eqe_num = 0;
+	u16 cqn;
 
 	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
+		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
+		poll_data->qp_finish_id[eqe_num] = cqn;
 		eqe_num++;
-		qp = qm_to_hisi_qp(qm, eqe);
-		qm_poll_qp(qp, qm);
 
 		if (qm->status.eq_head == QM_EQ_DEPTH - 1) {
 			qm->status.eqc_phase = !qm->status.eqc_phase;
@@ -945,34 +928,70 @@ static void qm_work_process(struct work_struct *work)
 			qm->status.eq_head++;
 		}
 
-		if (eqe_num == QM_EQ_DEPTH / 2 - 1) {
-			eqe_num = 0;
-			qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
-		}
+		if (eqe_num == (QM_EQ_DEPTH >> 1) - 1)
+			break;
 	}
 
 	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+
+	return eqe_num;
 }
 
-static irqreturn_t do_qm_irq(int irq, void *data)
+static void qm_work_process(struct work_struct *work)
 {
-	struct hisi_qm *qm = (struct hisi_qm *)data;
+	struct hisi_qm_poll_data *poll_data =
+		container_of(work, struct hisi_qm_poll_data, work);
+	struct hisi_qm *qm = poll_data->qm;
+	struct hisi_qp *qp;
+	int eqe_num, i;
 
-	/* the workqueue created by device driver of QM */
-	queue_work(qm->wq, &qm->work);
+	/* Get qp id of completed tasks and re-enable the interrupt. */
+	eqe_num = qm_get_complete_eqe_num(poll_data);
+	for (i = eqe_num - 1; i >= 0; i--) {
+		qp = &qm->qp_array[poll_data->qp_finish_id[i]];
+		if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP))
+			continue;
 
-	return IRQ_HANDLED;
+		if (qp->event_cb) {
+			qp->event_cb(qp);
+			continue;
+		}
+
+		if (likely(qp->req_cb))
+			qm_poll_req_cb(qp);
+	}
+}
+
+static bool do_qm_irq(struct hisi_qm *qm)
+{
+	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
+	struct hisi_qm_poll_data *poll_data;
+	u16 cqn;
+
+	if (!readl(qm->io_base + QM_VF_EQ_INT_SOURCE))
+		return false;
+
+	if (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
+		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
+		poll_data = &qm->poll_data[cqn];
+		queue_work(qm->wq, &poll_data->work);
+
+		return true;
+	}
+
+	return false;
 }
 
 static irqreturn_t qm_irq(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
+	bool ret;
 
-	if (readl(qm->io_base + QM_VF_EQ_INT_SOURCE))
-		return do_qm_irq(irq, data);
+	ret = do_qm_irq(qm);
+	if (ret)
+		return IRQ_HANDLED;
 
 	atomic64_inc(&qm->debug.dfx.err_irq_cnt);
-	dev_err(&qm->pdev->dev, "invalid int source\n");
 	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
 
 	return IRQ_NONE;
@@ -3551,8 +3570,10 @@ static void hisi_qp_memory_uninit(struct hisi_qm *qm, int num)
 	for (i = num - 1; i >= 0; i--) {
 		qdma = &qm->qp_array[i].qdma;
 		dma_free_coherent(dev, qdma->size, qdma->va, qdma->dma);
+		kfree(qm->poll_data[i].qp_finish_id);
 	}
 
+	kfree(qm->poll_data);
 	kfree(qm->qp_array);
 }
 
@@ -3561,12 +3582,18 @@ static int hisi_qp_memory_init(struct hisi_qm *qm, size_t dma_size, int id)
 	struct device *dev = &qm->pdev->dev;
 	size_t off = qm->sqe_size * QM_Q_DEPTH;
 	struct hisi_qp *qp;
+	int ret = -ENOMEM;
+
+	qm->poll_data[id].qp_finish_id = kcalloc(qm->qp_num, sizeof(u16),
+						 GFP_KERNEL);
+	if (!qm->poll_data[id].qp_finish_id)
+		return -ENOMEM;
 
 	qp = &qm->qp_array[id];
 	qp->qdma.va = dma_alloc_coherent(dev, dma_size, &qp->qdma.dma,
 					 GFP_KERNEL);
 	if (!qp->qdma.va)
-		return -ENOMEM;
+		goto err_free_qp_finish_id;
 
 	qp->sqe = qp->qdma.va;
 	qp->sqe_dma = qp->qdma.dma;
@@ -3577,6 +3604,10 @@ static int hisi_qp_memory_init(struct hisi_qm *qm, size_t dma_size, int id)
 	qp->qp_id = id;
 
 	return 0;
+
+err_free_qp_finish_id:
+	kfree(qm->poll_data[id].qp_finish_id);
+	return ret;
 }
 
 static void hisi_qm_pre_init(struct hisi_qm *qm)
@@ -6024,7 +6055,11 @@ static int hisi_qm_pci_init(struct hisi_qm *qm)
 
 static int hisi_qm_init_work(struct hisi_qm *qm)
 {
-	INIT_WORK(&qm->work, qm_work_process);
+	int i;
+
+	for (i = 0; i < qm->qp_num; i++)
+		INIT_WORK(&qm->poll_data[i].work, qm_work_process);
+
 	if (qm->fun_type == QM_HW_PF)
 		INIT_WORK(&qm->rst_work, hisi_qm_controller_reset);
 
@@ -6052,11 +6087,18 @@ static int hisi_qp_alloc_memory(struct hisi_qm *qm)
 	if (!qm->qp_array)
 		return -ENOMEM;
 
+	qm->poll_data = kcalloc(qm->qp_num, sizeof(struct hisi_qm_poll_data), GFP_KERNEL);
+	if (!qm->poll_data) {
+		kfree(qm->qp_array);
+		return -ENOMEM;
+	}
+
 	/* one more page for device or qp statuses */
 	qp_dma_size = qm->sqe_size * QM_Q_DEPTH +
 		      sizeof(struct qm_cqe) * QM_Q_DEPTH;
 	qp_dma_size = PAGE_ALIGN(qp_dma_size) + PAGE_SIZE;
 	for (i = 0; i < qm->qp_num; i++) {
+		qm->poll_data[i].qm = qm;
 		ret = hisi_qp_memory_init(qm, qp_dma_size, i);
 		if (ret)
 			goto err_init_qp_mem;
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 6cabafffd0dd..116e8bd68c99 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -265,6 +265,12 @@ struct hisi_qm_list {
 	void (*unregister_from_crypto)(struct hisi_qm *qm);
 };
 
+struct hisi_qm_poll_data {
+	struct hisi_qm *qm;
+	struct work_struct work;
+	u16 *qp_finish_id;
+};
+
 struct hisi_qm {
 	enum qm_hw_ver ver;
 	enum qm_fun_type fun_type;
@@ -302,6 +308,7 @@ struct hisi_qm {
 	struct rw_semaphore qps_lock;
 	struct idr qp_idr;
 	struct hisi_qp *qp_array;
+	struct hisi_qm_poll_data *poll_data;
 
 	struct mutex mailbox_lock;
 
@@ -312,7 +319,6 @@ struct hisi_qm {
 	u32 error_mask;
 
 	struct workqueue_struct *wq;
-	struct work_struct work;
 	struct work_struct rst_work;
 	struct work_struct cmd_process;
 
-- 
2.33.0

