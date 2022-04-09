Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE04FA5BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiDIILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43308393F1;
        Sat,  9 Apr 2022 01:09:12 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb76c228Sz1HBbG;
        Sat,  9 Apr 2022 16:08:40 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:09:10 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 9 Apr
 2022 16:09:10 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 08/11] crypto: hisilicon/qm - add last word dumping for ACC
Date:   Sat, 9 Apr 2022 16:03:25 +0800
Message-ID: <20220409080328.15783-9-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220409080328.15783-1-yekai13@huawei.com>
References: <20220409080328.15783-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add last word dumping function during acc engines controller reset.
The last words are reported to the printed information during the
reset. The dmesg information included qm debugging registers and
engine debugging registers. It can help to improve debugging
capability.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 57 +++++++++++++++++++++++++++++++++++
 include/linux/hisi_acc_qm.h   |  4 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 5e0695a8900c..7f5c3186a895 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3673,6 +3673,17 @@ static void hisi_qm_set_state(struct hisi_qm *qm, u8 state)
 		writel(state, qm->io_base + QM_VF_STATE);
 }
 
+static void qm_last_regs_uninit(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+
+	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
+		return;
+
+	kfree(debug->qm_last_words);
+	debug->qm_last_words = NULL;
+}
+
 /**
  * hisi_qm_uninit() - Uninitialize qm.
  * @qm: The qm needed uninit.
@@ -3684,6 +3695,8 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 	struct pci_dev *pdev = qm->pdev;
 	struct device *dev = &pdev->dev;
 
+	qm_last_regs_uninit(qm);
+
 	qm_cmd_uninit(qm);
 	kfree(qm->factor);
 	down_write(&qm->qps_lock);
@@ -5361,6 +5374,24 @@ static int qm_controller_reset_done(struct hisi_qm *qm)
 	return 0;
 }
 
+static void qm_show_last_dfx_regs(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+	struct pci_dev *pdev = qm->pdev;
+	u32 val;
+	int i;
+
+	if (qm->fun_type == QM_HW_VF || !debug->qm_last_words)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(qm_dfx_regs); i++) {
+		val = readl_relaxed(qm->io_base + qm_dfx_regs[i].offset);
+		if (debug->qm_last_words[i] != val)
+			pci_info(pdev, "%s \t= 0x%08x => 0x%08x\n",
+			qm_dfx_regs[i].name, debug->qm_last_words[i], val);
+	}
+}
+
 static int qm_controller_reset(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -5376,6 +5407,10 @@ static int qm_controller_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
+	qm_show_last_dfx_regs(qm);
+	if (qm->err_ini->show_last_dfx_regs)
+		qm->err_ini->show_last_dfx_regs(qm);
+
 	ret = qm_soft_reset(qm);
 	if (ret) {
 		pci_err(pdev, "Controller reset failed (%d)\n", ret);
@@ -6086,6 +6121,26 @@ static int hisi_qm_memory_init(struct hisi_qm *qm)
 	return ret;
 }
 
+static void qm_last_regs_init(struct hisi_qm *qm)
+{
+	int dfx_regs_num = ARRAY_SIZE(qm_dfx_regs);
+	struct qm_debug *debug = &qm->debug;
+	int i;
+
+	if (qm->fun_type == QM_HW_VF)
+		return;
+
+	debug->qm_last_words = kcalloc(dfx_regs_num, sizeof(unsigned int),
+								GFP_KERNEL);
+	if (!debug->qm_last_words)
+		return;
+
+	for (i = 0; i < dfx_regs_num; i++) {
+		debug->qm_last_words[i] = readl_relaxed(qm->io_base +
+			qm_dfx_regs[i].offset);
+	}
+}
+
 /**
  * hisi_qm_init() - Initialize configures about qm.
  * @qm: The qm needing init.
@@ -6138,6 +6193,8 @@ int hisi_qm_init(struct hisi_qm *qm)
 	qm_cmd_init(qm);
 	atomic_set(&qm->status.flags, QM_INIT);
 
+	qm_last_regs_init(qm);
+
 	return 0;
 
 err_alloc_uacce:
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 39acc0316a60..e5522eaf88fd 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -196,6 +196,9 @@ struct qm_debug {
 	struct dentry *debug_root;
 	struct dentry *qm_d;
 	struct debugfs_file files[DEBUG_FILE_NUM];
+	unsigned int *qm_last_words;
+	/* ACC engines recoreding last regs */
+	unsigned int *last_words;
 	struct dfx_diff_registers *qm_diff_regs;
 	struct dfx_diff_registers *acc_diff_regs;
 };
@@ -251,6 +254,7 @@ struct hisi_qm_err_ini {
 	void (*open_sva_prefetch)(struct hisi_qm *qm);
 	void (*close_sva_prefetch)(struct hisi_qm *qm);
 	void (*log_dev_hw_err)(struct hisi_qm *qm, u32 err_sts);
+	void (*show_last_dfx_regs)(struct hisi_qm *qm);
 	void (*err_info_init)(struct hisi_qm *qm);
 };
 
-- 
2.33.0

