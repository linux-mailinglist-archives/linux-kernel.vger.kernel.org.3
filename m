Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC574713A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhLKLaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:30:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28309 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLKLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:30:10 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JB5Ck0Gx2zbj7s;
        Sat, 11 Dec 2021 19:29:54 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:08 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:08 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 4/6] crypto: hisilicon/qm - use request_threaded_irq instead
Date:   Sat, 11 Dec 2021 19:25:17 +0800
Message-ID: <20211211112519.21201-5-qianweili@huawei.com>
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

The abnormal interrupt method needs to be changed, and the changed method
needs to be locked in order to maintain atomicity. Therefore,
replace request_irq() with request_threaded_irq().

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index beea3a0fd0a5..93abe1feb0b7 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -988,16 +988,12 @@ static void qm_set_qp_disable(struct hisi_qp *qp, int offset)
 	mb();
 }
 
-static irqreturn_t qm_aeq_irq(int irq, void *data)
+static irqreturn_t qm_aeq_thread(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
 	struct qm_aeqe *aeqe = qm->aeqe + qm->status.aeq_head;
 	u32 type;
 
-	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
-	if (!readl(qm->io_base + QM_VF_AEQ_INT_SOURCE))
-		return IRQ_NONE;
-
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
 		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
 		if (type < ARRAY_SIZE(qm_fifo_overflow))
@@ -1022,6 +1018,17 @@ static irqreturn_t qm_aeq_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t qm_aeq_irq(int irq, void *data)
+{
+	struct hisi_qm *qm = data;
+
+	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
+	if (!readl(qm->io_base + QM_VF_AEQ_INT_SOURCE))
+		return IRQ_NONE;
+
+	return IRQ_WAKE_THREAD;
+}
+
 static void qm_irq_unregister(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -5299,8 +5306,10 @@ static int qm_irq_register(struct hisi_qm *qm)
 		return ret;
 
 	if (qm->ver > QM_HW_V1) {
-		ret = request_irq(pci_irq_vector(pdev, QM_AEQ_EVENT_IRQ_VECTOR),
-				  qm_aeq_irq, 0, qm->dev_name, qm);
+		ret = request_threaded_irq(pci_irq_vector(pdev,
+					   QM_AEQ_EVENT_IRQ_VECTOR),
+					   qm_aeq_irq, qm_aeq_thread,
+					   0, qm->dev_name, qm);
 		if (ret)
 			goto err_aeq_irq;
 
-- 
2.33.0

