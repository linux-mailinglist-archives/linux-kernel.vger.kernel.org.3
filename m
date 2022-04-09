Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4D4FA5BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiDIILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E11B7BB;
        Sat,  9 Apr 2022 01:09:11 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kb72H6yLJzBrgq;
        Sat,  9 Apr 2022 16:04:55 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
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
Subject: [PATCH 02/11] crypto: hisilicon/hpre - support register checking
Date:   Sat, 9 Apr 2022 16:03:19 +0800
Message-ID: <20220409080328.15783-3-yekai13@huawei.com>
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

The value of the register is changed after the task running. A debugfs
file node is added to help users to check the change of register values.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 90 ++++++++++++++++++-----
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 36ab30e9e654..d3f73e38709a 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -107,6 +107,15 @@
 #define HPRE_SQE_MASK_OFFSET		8
 #define HPRE_SQE_MASK_LEN		24
 
+#define HPRE_DFX_BASE		0x301000
+#define HPRE_DFX_COMMON1		0x301400
+#define HPRE_DFX_COMMON2		0x301A00
+#define HPRE_DFX_CORE		0x302000
+#define HPRE_DFX_BASE_LEN		0x55
+#define HPRE_DFX_COMMON1_LEN		0x41
+#define HPRE_DFX_COMMON2_LEN		0xE
+#define HPRE_DFX_CORE_LEN		0x43
+
 static const char hpre_name[] = "hisi_hpre";
 static struct dentry *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
@@ -226,6 +235,53 @@ static const char *hpre_dfx_files[HPRE_DFX_FILE_NUM] = {
 	"invalid_req_cnt"
 };
 
+/* define the HPRE's dfx regs region and region length */
+static struct dfx_diff_registers hpre_diff_regs[] = {
+	{
+		.reg_offset = HPRE_DFX_BASE,
+		.reg_len = HPRE_DFX_BASE_LEN,
+	}, {
+		.reg_offset = HPRE_DFX_COMMON1,
+		.reg_len = HPRE_DFX_COMMON1_LEN,
+	}, {
+		.reg_offset = HPRE_DFX_COMMON2,
+		.reg_len = HPRE_DFX_COMMON2_LEN,
+	}, {
+		.reg_offset = HPRE_DFX_CORE,
+		.reg_len = HPRE_DFX_CORE_LEN,
+	},
+};
+
+static int hpre_diff_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+
+	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.acc_diff_regs,
+					ARRAY_SIZE(hpre_diff_regs));
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(hpre_diff_regs);
+
+static int hpre_com_regs_show(struct seq_file *s, void *unused)
+{
+	hisi_qm_regs_dump(s, s->private);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(hpre_com_regs);
+
+static int hpre_cluster_regs_show(struct seq_file *s, void *unused)
+{
+	hisi_qm_regs_dump(s, s->private);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(hpre_cluster_regs);
+
 static const struct kernel_param_ops hpre_uacce_mode_ops = {
 	.set = uacce_mode_set,
 	.get = param_get_int,
@@ -779,24 +835,6 @@ static int hpre_debugfs_atomic64_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hpre_atomic64_ops, hpre_debugfs_atomic64_get,
 			 hpre_debugfs_atomic64_set, "%llu\n");
 
-static int hpre_com_regs_show(struct seq_file *s, void *unused)
-{
-	hisi_qm_regs_dump(s, s->private);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(hpre_com_regs);
-
-static int hpre_cluster_regs_show(struct seq_file *s, void *unused)
-{
-	hisi_qm_regs_dump(s, s->private);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(hpre_cluster_regs);
-
 static int hpre_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
 				    enum hpre_ctrl_dbgfs_file type, int indx)
 {
@@ -895,6 +933,7 @@ static int hpre_ctrl_debug_init(struct hisi_qm *qm)
 
 static void hpre_dfx_debug_init(struct hisi_qm *qm)
 {
+	struct dfx_diff_registers *hpre_regs = qm->debug.acc_diff_regs;
 	struct hpre *hpre = container_of(qm, struct hpre, qm);
 	struct hpre_dfx *dfx = hpre->debug.dfx;
 	struct dentry *parent;
@@ -906,6 +945,10 @@ static void hpre_dfx_debug_init(struct hisi_qm *qm)
 		debugfs_create_file(hpre_dfx_files[i], 0644, parent, &dfx[i],
 				    &hpre_atomic64_ops);
 	}
+
+	if (qm->fun_type == QM_HW_PF && hpre_regs)
+		debugfs_create_file("diff_regs", 0444, parent,
+				      qm, &hpre_diff_regs_fops);
 }
 
 static int hpre_debugfs_init(struct hisi_qm *qm)
@@ -918,6 +961,13 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 
 	qm->debug.sqe_mask_offset = HPRE_SQE_MASK_OFFSET;
 	qm->debug.sqe_mask_len = HPRE_SQE_MASK_LEN;
+	ret = hisi_qm_diff_regs_init(qm, hpre_diff_regs,
+				ARRAY_SIZE(hpre_diff_regs));
+	if (ret) {
+		dev_warn(dev, "Failed to init HPRE diff regs!\n");
+		goto debugfs_remove;
+	}
+
 	hisi_qm_debug_init(qm);
 
 	if (qm->pdev->device == PCI_DEVICE_ID_HUAWEI_HPRE_PF) {
@@ -931,12 +981,16 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 	return 0;
 
 failed_to_create:
+	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
+debugfs_remove:
 	debugfs_remove_recursive(qm->debug.debug_root);
 	return ret;
 }
 
 static void hpre_debugfs_exit(struct hisi_qm *qm)
 {
+	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
+
 	debugfs_remove_recursive(qm->debug.debug_root);
 }
 
-- 
2.33.0

