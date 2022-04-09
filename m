Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34584FA5BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiDIILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiDIILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E66DE89;
        Sat,  9 Apr 2022 01:09:11 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kb76Z6X2nzdZMh;
        Sat,  9 Apr 2022 16:08:38 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:09:09 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 9 Apr
 2022 16:09:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 01/11] crypto: hisilicon/qm - add register checking for ACC
Date:   Sat, 9 Apr 2022 16:03:18 +0800
Message-ID: <20220409080328.15783-2-yekai13@huawei.com>
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

Add register detection function to accelerator. Provided a tool that
user can checking differential register through Debugfs.
e.g.
    cd /sys/kernel/debug/hisi_zip/<bdf>/zip_dfx
    cat diff_regs

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 182 +++++++++++++++++++++++++++++++++-
 include/linux/hisi_acc_qm.h   |  14 +++
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c5c507f2d779..5e0695a8900c 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -253,7 +253,15 @@
 #define QM_QOS_MAX_CIR_U		6
 #define QM_QOS_MAX_CIR_S		11
 #define QM_QOS_VAL_MAX_LEN		32
-
+#define QM_DFX_BASE		0x0100000
+#define QM_DFX_STATE1		0x0104000
+#define QM_DFX_STATE2		0x01040C8
+#define QM_DFX_COMMON		0x0000
+#define QM_DFX_BASE_LEN		0x5A
+#define QM_DFX_STATE1_LEN		0x2E
+#define QM_DFX_STATE2_LEN		0x11
+#define QM_DFX_COMMON_LEN		0xC3
+#define QM_DFX_REGS_LEN		4UL
 #define QM_AUTOSUSPEND_DELAY		3000
 
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
@@ -467,6 +475,23 @@ static const struct hisi_qm_hw_error qm_hw_error[] = {
 	{ /* sentinel */ }
 };
 
+/* define the QM's dfx regs region and region length */
+static struct dfx_diff_registers qm_diff_regs[] = {
+	{
+		.reg_offset = QM_DFX_BASE,
+		.reg_len = QM_DFX_BASE_LEN,
+	}, {
+		.reg_offset = QM_DFX_STATE1,
+		.reg_len = QM_DFX_STATE1_LEN,
+	}, {
+		.reg_offset = QM_DFX_STATE2,
+		.reg_len = QM_DFX_STATE2_LEN,
+	}, {
+		.reg_offset = QM_DFX_COMMON,
+		.reg_len = QM_DFX_COMMON_LEN,
+	},
+};
+
 static const char * const qm_db_timeout[] = {
 	"sq", "cq", "eq", "aeq",
 };
@@ -1625,6 +1650,156 @@ static int qm_regs_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(qm_regs);
 
+static struct dfx_diff_registers *dfx_regs_init(struct hisi_qm *qm,
+	const struct dfx_diff_registers *cregs, int reg_len)
+{
+	struct dfx_diff_registers *diff_regs;
+	u32 j, base_offset;
+	int i;
+
+	diff_regs = kcalloc(reg_len, sizeof(*diff_regs), GFP_KERNEL);
+	if (!diff_regs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < reg_len; i++) {
+		if (!cregs[i].reg_len)
+			continue;
+
+		diff_regs[i].reg_offset = cregs[i].reg_offset;
+		diff_regs[i].reg_len = cregs[i].reg_len;
+		diff_regs[i].regs = kcalloc(QM_DFX_REGS_LEN, cregs[i].reg_len,
+					 GFP_KERNEL);
+		if (!diff_regs[i].regs)
+			goto alloc_error;
+
+		for (j = 0; j < diff_regs[i].reg_len; j++) {
+			base_offset = diff_regs[i].reg_offset +
+					j * QM_DFX_REGS_LEN;
+			diff_regs[i].regs[j] = readl(qm->io_base + base_offset);
+		}
+	}
+
+	return diff_regs;
+
+alloc_error:
+	while (i > 0) {
+		i--;
+		kfree(diff_regs[i].regs);
+	}
+	kfree(diff_regs);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void dfx_regs_uninit(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, int reg_len)
+{
+	int i;
+
+	/* Setting the pointer is NULL to prevent double free */
+	for (i = 0; i < reg_len; i++) {
+		kfree(dregs[i].regs);
+		dregs[i].regs = NULL;
+	}
+	kfree(dregs);
+	dregs = NULL;
+}
+
+/**
+ * hisi_qm_diff_regs_init() - Allocate memory for registers.
+ * @qm: device qm handle.
+ * @dregs: diff registers handle.
+ * @reg_len: diff registers region length.
+ */
+int hisi_qm_diff_regs_init(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, int reg_len)
+{
+	if (!qm || !dregs || reg_len <= 0)
+		return -EINVAL;
+
+	if (qm->fun_type != QM_HW_PF)
+		return 0;
+
+	qm->debug.qm_diff_regs = dfx_regs_init(qm, qm_diff_regs,
+						ARRAY_SIZE(qm_diff_regs));
+	if (IS_ERR(qm->debug.qm_diff_regs))
+		return PTR_ERR(qm->debug.qm_diff_regs);
+
+	qm->debug.acc_diff_regs = dfx_regs_init(qm, dregs, reg_len);
+	if (IS_ERR(qm->debug.acc_diff_regs)) {
+		dfx_regs_uninit(qm, qm->debug.qm_diff_regs,
+				ARRAY_SIZE(qm_diff_regs));
+		return PTR_ERR(qm->debug.acc_diff_regs);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_diff_regs_init);
+
+/**
+ * hisi_qm_diff_regs_uninit() - Free memory for registers.
+ * @qm: device qm handle.
+ * @reg_len: diff registers region length.
+ */
+void hisi_qm_diff_regs_uninit(struct hisi_qm *qm, int reg_len)
+{
+	if (!qm  || reg_len <= 0 || qm->fun_type != QM_HW_PF)
+		return;
+
+	dfx_regs_uninit(qm, qm->debug.acc_diff_regs, reg_len);
+	dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
+}
+EXPORT_SYMBOL_GPL(hisi_qm_diff_regs_uninit);
+
+/**
+ * hisi_qm_acc_diff_regs_dump() - Dump registers's value.
+ * @qm: device qm handle.
+ * @s: Debugfs file handle.
+ * @dregs: diff registers handle.
+ * @regs_len: diff registers region length.
+ */
+void hisi_qm_acc_diff_regs_dump(struct hisi_qm *qm, struct seq_file *s,
+	struct dfx_diff_registers *dregs, int regs_len)
+{
+	u32 j, val, base_offset;
+	int i, ret;
+
+	if (!qm || !s || !dregs || regs_len <= 0)
+		return;
+
+	ret = hisi_qm_get_dfx_access(qm);
+	if (ret)
+		return;
+
+	down_read(&qm->qps_lock);
+	for (i = 0; i < regs_len; i++) {
+		if (!dregs[i].reg_len)
+			continue;
+
+		for (j = 0; j < dregs[i].reg_len; j++) {
+			base_offset = dregs[i].reg_offset + j * QM_DFX_REGS_LEN;
+			val = readl(qm->io_base + base_offset);
+			if (val != dregs[i].regs[j])
+				seq_printf(s, "0x%08x = 0x%08x ---> 0x%08x\n",
+					   base_offset, dregs[i].regs[j], val);
+		}
+	}
+	up_read(&qm->qps_lock);
+
+	hisi_qm_put_dfx_access(qm);
+}
+EXPORT_SYMBOL_GPL(hisi_qm_acc_diff_regs_dump);
+
+static int qm_diff_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+
+	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.qm_diff_regs,
+					ARRAY_SIZE(qm_diff_regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(qm_diff_regs);
+
 static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
 			   size_t count, loff_t *pos)
 {
@@ -4484,6 +4659,7 @@ static void hisi_qm_set_algqos_init(struct hisi_qm *qm)
  */
 void hisi_qm_debug_init(struct hisi_qm *qm)
 {
+	struct dfx_diff_registers *qm_regs = qm->debug.qm_diff_regs;
 	struct qm_dfx *dfx = &qm->debug.dfx;
 	struct dentry *qm_d;
 	void *data;
@@ -4499,6 +4675,10 @@ void hisi_qm_debug_init(struct hisi_qm *qm)
 			qm_create_debugfs_file(qm, qm->debug.qm_d, i);
 	}
 
+	if (qm_regs)
+		debugfs_create_file("diff_regs", 0444, qm->debug.qm_d,
+					qm, &qm_diff_regs_fops);
+
 	debugfs_create_file("regs", 0444, qm->debug.qm_d, qm, &qm_regs_fops);
 
 	debugfs_create_file("cmd", 0600, qm->debug.qm_d, qm, &qm_cmd_fops);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 177f7b7cd414..39acc0316a60 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -168,6 +168,12 @@ enum qm_vf_state {
 	QM_NOT_READY,
 };
 
+struct dfx_diff_registers {
+	u32 *regs;
+	u32 reg_offset;
+	u32 reg_len;
+};
+
 struct qm_dfx {
 	atomic64_t err_irq_cnt;
 	atomic64_t aeq_irq_cnt;
@@ -190,6 +196,8 @@ struct qm_debug {
 	struct dentry *debug_root;
 	struct dentry *qm_d;
 	struct debugfs_file files[DEBUG_FILE_NUM];
+	struct dfx_diff_registers *qm_diff_regs;
+	struct dfx_diff_registers *acc_diff_regs;
 };
 
 struct qm_shaper_factor {
@@ -448,6 +456,12 @@ int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen);
 int hisi_qm_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void hisi_qm_dev_err_init(struct hisi_qm *qm);
 void hisi_qm_dev_err_uninit(struct hisi_qm *qm);
+int hisi_qm_diff_regs_init(struct hisi_qm *qm,
+		struct dfx_diff_registers *dregs, int reg_len);
+void hisi_qm_diff_regs_uninit(struct hisi_qm *qm, int reg_len);
+void hisi_qm_acc_diff_regs_dump(struct hisi_qm *qm, struct seq_file *s,
+		struct dfx_diff_registers *dregs, int regs_len);
+
 pci_ers_result_t hisi_qm_dev_err_detected(struct pci_dev *pdev,
 					  pci_channel_state_t state);
 pci_ers_result_t hisi_qm_dev_slot_reset(struct pci_dev *pdev);
-- 
2.33.0

