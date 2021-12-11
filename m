Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987334713A6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhLKLaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:30:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32911 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhLKLaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:30:15 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JB5Cp27wgzcbl1;
        Sat, 11 Dec 2021 19:29:58 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:06 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 2/6] crypto: hisilicon/qm - code movement
Date:   Sat, 11 Dec 2021 19:25:15 +0800
Message-ID: <20211211112519.21201-3-qianweili@huawei.com>
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

This patch does not change any code, just code movement. Preparing for
next patch.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 138 +++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index fba6a26089aa..d124800b67e6 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -605,6 +605,75 @@ static bool qm_qp_avail_state(struct hisi_qm *qm, struct hisi_qp *qp,
 	return avail;
 }
 
+static u32 qm_get_hw_error_status(struct hisi_qm *qm)
+{
+	return readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
+}
+
+static u32 qm_get_dev_err_status(struct hisi_qm *qm)
+{
+	return qm->err_ini->get_dev_hw_err_status(qm);
+}
+
+/* Check if the error causes the master ooo block */
+static int qm_check_dev_error(struct hisi_qm *qm)
+{
+	u32 val, dev_val;
+
+	if (qm->fun_type == QM_HW_VF)
+		return 0;
+
+	val = qm_get_hw_error_status(qm);
+	dev_val = qm_get_dev_err_status(qm);
+
+	if (qm->ver < QM_HW_V3)
+		return (val & QM_ECC_MBIT) ||
+		       (dev_val & qm->err_info.ecc_2bits_mask);
+
+	return (val & readl(qm->io_base + QM_OOO_SHUTDOWN_SEL)) ||
+	       (dev_val & (~qm->err_info.dev_ce_mask));
+}
+
+static int qm_wait_reset_finish(struct hisi_qm *qm)
+{
+	int delay = 0;
+
+	/* All reset requests need to be queued for processing */
+	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
+		msleep(++delay);
+		if (delay > QM_RESET_WAIT_TIMEOUT)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int qm_reset_prepare_ready(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
+
+	/*
+	 * PF and VF on host doesnot support resetting at the
+	 * same time on Kunpeng920.
+	 */
+	if (qm->ver < QM_HW_V3)
+		return qm_wait_reset_finish(pf_qm);
+
+	return qm_wait_reset_finish(qm);
+}
+
+static void qm_reset_bit_clear(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
+
+	if (qm->ver < QM_HW_V3)
+		clear_bit(QM_RESETTING, &pf_qm->misc_ctl);
+
+	clear_bit(QM_RESETTING, &qm->misc_ctl);
+}
+
 static void qm_mb_pre_init(struct qm_mailbox *mailbox, u8 cmd,
 			   u64 base, u16 queue, bool op)
 {
@@ -2108,35 +2177,6 @@ static enum acc_err_result qm_hw_error_handle_v2(struct hisi_qm *qm)
 	return ACC_ERR_RECOVERED;
 }
 
-static u32 qm_get_hw_error_status(struct hisi_qm *qm)
-{
-	return readl(qm->io_base + QM_ABNORMAL_INT_STATUS);
-}
-
-static u32 qm_get_dev_err_status(struct hisi_qm *qm)
-{
-	return qm->err_ini->get_dev_hw_err_status(qm);
-}
-
-/* Check if the error causes the master ooo block */
-static int qm_check_dev_error(struct hisi_qm *qm)
-{
-	u32 val, dev_val;
-
-	if (qm->fun_type == QM_HW_VF)
-		return 0;
-
-	val = qm_get_hw_error_status(qm);
-	dev_val = qm_get_dev_err_status(qm);
-
-	if (qm->ver < QM_HW_V3)
-		return (val & QM_ECC_MBIT) ||
-		       (dev_val & qm->err_info.ecc_2bits_mask);
-
-	return (val & readl(qm->io_base + QM_OOO_SHUTDOWN_SEL)) ||
-	       (dev_val & (~qm->err_info.dev_ce_mask));
-}
-
 static int qm_get_mb_cmd(struct hisi_qm *qm, u64 *msg, u16 fun_num)
 {
 	struct qm_mailbox mailbox;
@@ -4754,46 +4794,6 @@ static int qm_try_stop_vfs(struct hisi_qm *qm, u64 cmd,
 	return ret;
 }
 
-static int qm_wait_reset_finish(struct hisi_qm *qm)
-{
-	int delay = 0;
-
-	/* All reset requests need to be queued for processing */
-	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
-		msleep(++delay);
-		if (delay > QM_RESET_WAIT_TIMEOUT)
-			return -EBUSY;
-	}
-
-	return 0;
-}
-
-static int qm_reset_prepare_ready(struct hisi_qm *qm)
-{
-	struct pci_dev *pdev = qm->pdev;
-	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
-
-	/*
-	 * PF and VF on host doesnot support resetting at the
-	 * same time on Kunpeng920.
-	 */
-	if (qm->ver < QM_HW_V3)
-		return qm_wait_reset_finish(pf_qm);
-
-	return qm_wait_reset_finish(qm);
-}
-
-static void qm_reset_bit_clear(struct hisi_qm *qm)
-{
-	struct pci_dev *pdev = qm->pdev;
-	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(pdev));
-
-	if (qm->ver < QM_HW_V3)
-		clear_bit(QM_RESETTING, &pf_qm->misc_ctl);
-
-	clear_bit(QM_RESETTING, &qm->misc_ctl);
-}
-
 static int qm_controller_reset_prepare(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
-- 
2.33.0

