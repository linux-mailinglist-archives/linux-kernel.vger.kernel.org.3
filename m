Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212E34713A5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhLKLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:30:28 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16367 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhLKLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:30:12 -0500
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JB5CF6Q04z91Px;
        Sat, 11 Dec 2021 19:29:29 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:10 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:10 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 6/6] crypto: hisilicon/qm - disable queue when 'CQ' error
Date:   Sat, 11 Dec 2021 19:25:19 +0800
Message-ID: <20211211112519.21201-7-qianweili@huawei.com>
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

If the hardware reports the 'CQ' overflow or 'CQE' error by the abnormal
interrupt, disable the queue and stop tasks send to hardware.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 6c61f9d25f75..b1fe9c7b8cc8 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -89,7 +89,10 @@
 
 #define QM_AEQE_PHASE(aeqe)		((le32_to_cpu((aeqe)->dw0) >> 16) & 0x1)
 #define QM_AEQE_TYPE_SHIFT		17
+#define QM_AEQE_CQN_MASK		GENMASK(15, 0)
+#define QM_CQ_OVERFLOW			0
 #define QM_EQ_OVERFLOW			1
+#define QM_CQE_ERROR			2
 
 #define QM_DOORBELL_CMD_SQ		0
 #define QM_DOORBELL_CMD_CQ		1
@@ -989,6 +992,15 @@ static void qm_set_qp_disable(struct hisi_qp *qp, int offset)
 	mb();
 }
 
+static void qm_disable_qp(struct hisi_qm *qm, u32 qp_id)
+{
+	struct hisi_qp *qp = &qm->qp_array[qp_id];
+
+	qm_set_qp_disable(qp, QM_RESET_STOP_TX_OFFSET);
+	hisi_qm_stop_qp(qp);
+	qm_set_qp_disable(qp, QM_RESET_STOP_RX_OFFSET);
+}
+
 static void qm_reset_function(struct hisi_qm *qm)
 {
 	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
@@ -1022,16 +1034,24 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
 	struct qm_aeqe *aeqe = qm->aeqe + qm->status.aeq_head;
-	u32 type;
+	u32 type, qp_id;
 
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
 		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
+		qp_id = le32_to_cpu(aeqe->dw0) & QM_AEQE_CQN_MASK;
 
 		switch (type) {
 		case QM_EQ_OVERFLOW:
 			dev_err(&qm->pdev->dev, "eq overflow, reset function\n");
 			qm_reset_function(qm);
 			return IRQ_HANDLED;
+		case QM_CQ_OVERFLOW:
+			dev_err(&qm->pdev->dev, "cq overflow, stop qp(%u)\n",
+				qp_id);
+			fallthrough;
+		case QM_CQE_ERROR:
+			qm_disable_qp(qm, qp_id);
+			break;
 		default:
 			dev_err(&qm->pdev->dev, "unknown error type %u\n",
 				type);
-- 
2.33.0

