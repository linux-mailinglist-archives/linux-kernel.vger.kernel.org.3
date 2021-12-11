Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0214713A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhLKLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:30:20 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28310 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhLKLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:30:11 -0500
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JB5Ck6g9vzbj8F;
        Sat, 11 Dec 2021 19:29:54 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:09 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:09 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 5/6] crypto: hisilicon/qm - reset function if event queue overflows
Date:   Sat, 11 Dec 2021 19:25:18 +0800
Message-ID: <20211211112519.21201-6-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211211112519.21201-1-qianweili@huawei.com>
References: <20211211112519.21201-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hardware reports the event queue overflow by the abnormal interrupt,
the driver needs to reset the function and re-enable the event queue
interrupt and abnormal interrupt.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 68 +++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 93abe1feb0b7..6c61f9d25f75 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -89,6 +89,7 @@
 
 #define QM_AEQE_PHASE(aeqe)		((le32_to_cpu((aeqe)->dw0) >> 16) & 0x1)
 #define QM_AEQE_TYPE_SHIFT		17
+#define QM_EQ_OVERFLOW			1
 
 #define QM_DOORBELL_CMD_SQ		0
 #define QM_DOORBELL_CMD_CQ		1
@@ -988,6 +989,35 @@ static void qm_set_qp_disable(struct hisi_qp *qp, int offset)
 	mb();
 }
 
+static void qm_reset_function(struct hisi_qm *qm)
+{
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	if (qm_check_dev_error(pf_qm))
+		return;
+
+	ret = qm_reset_prepare_ready(qm);
+	if (ret) {
+		dev_err(dev, "reset function not ready\n");
+		return;
+	}
+
+	ret = hisi_qm_stop(qm, QM_FLR);
+	if (ret) {
+		dev_err(dev, "failed to stop qm when reset function\n");
+		goto clear_bit;
+	}
+
+	ret = hisi_qm_start(qm);
+	if (ret)
+		dev_err(dev, "failed to start qm when reset function\n");
+
+clear_bit:
+	qm_reset_bit_clear(qm);
+}
+
 static irqreturn_t qm_aeq_thread(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
@@ -996,12 +1026,17 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
 		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
-		if (type < ARRAY_SIZE(qm_fifo_overflow))
-			dev_err(&qm->pdev->dev, "%s overflow\n",
-				qm_fifo_overflow[type]);
-		else
+
+		switch (type) {
+		case QM_EQ_OVERFLOW:
+			dev_err(&qm->pdev->dev, "eq overflow, reset function\n");
+			qm_reset_function(qm);
+			return IRQ_HANDLED;
+		default:
 			dev_err(&qm->pdev->dev, "unknown error type %u\n",
 				type);
+			break;
+		}
 
 		if (qm->status.aeq_head == QM_Q_DEPTH - 1) {
 			qm->status.aeqc_phase = !qm->status.aeqc_phase;
@@ -3545,6 +3580,22 @@ static void qm_init_eq_aeq_status(struct hisi_qm *qm)
 	status->aeqc_phase = true;
 }
 
+static void qm_enable_eq_aeq_interrupts(struct hisi_qm *qm)
+{
+	/* Clear eq/aeq interrupt source */
+	qm_db(qm, 0, QM_DOORBELL_CMD_AEQ, qm->status.aeq_head, 0);
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+
+	writel(0x0, qm->io_base + QM_VF_EQ_INT_MASK);
+	writel(0x0, qm->io_base + QM_VF_AEQ_INT_MASK);
+}
+
+static void qm_disable_eq_aeq_interrupts(struct hisi_qm *qm)
+{
+	writel(0x1, qm->io_base + QM_VF_EQ_INT_MASK);
+	writel(0x1, qm->io_base + QM_VF_AEQ_INT_MASK);
+}
+
 static int qm_eq_ctx_cfg(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -3646,9 +3697,7 @@ static int __hisi_qm_start(struct hisi_qm *qm)
 		return ret;
 
 	qm_init_prefetch(qm);
-
-	writel(0x0, qm->io_base + QM_VF_EQ_INT_MASK);
-	writel(0x0, qm->io_base + QM_VF_AEQ_INT_MASK);
+	qm_enable_eq_aeq_interrupts(qm);
 
 	return 0;
 }
@@ -3796,10 +3845,7 @@ int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r)
 		hisi_qm_set_hw_reset(qm, QM_RESET_STOP_RX_OFFSET);
 	}
 
-	/* Mask eq and aeq irq */
-	writel(0x1, qm->io_base + QM_VF_EQ_INT_MASK);
-	writel(0x1, qm->io_base + QM_VF_AEQ_INT_MASK);
-
+	qm_disable_eq_aeq_interrupts(qm);
 	if (qm->fun_type == QM_HW_PF) {
 		ret = hisi_qm_set_vft(qm, 0, 0, 0);
 		if (ret < 0) {
-- 
2.33.0

