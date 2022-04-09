Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753A34FA5C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiDIIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D22F02A;
        Sat,  9 Apr 2022 01:09:11 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kb76b2DdHzdZMl;
        Sat,  9 Apr 2022 16:08:39 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:09:10 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 9 Apr
 2022 16:09:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 04/11] crypto: hisilicon/zip - support register checking
Date:   Sat, 9 Apr 2022 16:03:21 +0800
Message-ID: <20220409080328.15783-5-yekai13@huawei.com>
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
 drivers/crypto/hisilicon/zip/zip_main.c | 78 ++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 4534e1e107d1..2d5663d8d87f 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -49,14 +49,18 @@
 
 #define HZIP_QM_IDEL_STATUS		0x3040e4
 
-#define HZIP_CORE_DEBUG_COMP_0		0x302000
-#define HZIP_CORE_DEBUG_COMP_1		0x303000
-#define HZIP_CORE_DEBUG_DECOMP_0	0x304000
-#define HZIP_CORE_DEBUG_DECOMP_1	0x305000
-#define HZIP_CORE_DEBUG_DECOMP_2	0x306000
-#define HZIP_CORE_DEBUG_DECOMP_3	0x307000
-#define HZIP_CORE_DEBUG_DECOMP_4	0x308000
-#define HZIP_CORE_DEBUG_DECOMP_5	0x309000
+#define HZIP_CORE_DFX_BASE		0x301000
+#define HZIP_CLOCK_GATED_CONTL		0X301004
+#define HZIP_CORE_DFX_COMP_0		0x302000
+#define HZIP_CORE_DFX_COMP_1		0x303000
+#define HZIP_CORE_DFX_DECOMP_0		0x304000
+#define HZIP_CORE_DFX_DECOMP_1		0x305000
+#define HZIP_CORE_DFX_DECOMP_2		0x306000
+#define HZIP_CORE_DFX_DECOMP_3		0x307000
+#define HZIP_CORE_DFX_DECOMP_4		0x308000
+#define HZIP_CORE_DFX_DECOMP_5		0x309000
+#define HZIP_CORE_REGS_BASE_LEN		0xB0
+#define HZIP_CORE_REGS_DFX_LEN		0x28
 
 #define HZIP_CORE_INT_SOURCE		0x3010A0
 #define HZIP_CORE_INT_MASK_REG		0x3010A4
@@ -230,6 +234,48 @@ static const struct debugfs_reg32 hzip_dfx_regs[] = {
 	{"HZIP_DECOMP_LZ77_CURR_ST       ",  0x9cull},
 };
 
+/* define the ZIP's dfx regs region and region length */
+static struct dfx_diff_registers hzip_diff_regs[] = {
+	{
+		.reg_offset = HZIP_CORE_DFX_BASE,
+		.reg_len = HZIP_CORE_REGS_BASE_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_COMP_0,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_COMP_1,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_DECOMP_0,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_DECOMP_1,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_DECOMP_2,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_DECOMP_3,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_DECOMP_4,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	}, {
+		.reg_offset = HZIP_CORE_DFX_DECOMP_5,
+		.reg_len = HZIP_CORE_REGS_DFX_LEN,
+	},
+};
+
+static int hzip_diff_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+
+	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.acc_diff_regs,
+					ARRAY_SIZE(hzip_diff_regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(hzip_diff_regs);
 static const struct kernel_param_ops zip_uacce_mode_ops = {
 	.set = uacce_mode_set,
 	.get = param_get_int,
@@ -621,6 +667,7 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 
 static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 {
+	struct dfx_diff_registers *hzip_regs = qm->debug.acc_diff_regs;
 	struct hisi_zip *zip = container_of(qm, struct hisi_zip, qm);
 	struct hisi_zip_dfx *dfx = &zip->dfx;
 	struct dentry *tmp_dir;
@@ -634,6 +681,10 @@ static void hisi_zip_dfx_debug_init(struct hisi_qm *qm)
 				    0644, tmp_dir, data,
 				    &zip_atomic64_ops);
 	}
+
+	if (qm->fun_type == QM_HW_PF && hzip_regs)
+		debugfs_create_file("diff_regs", 0444, tmp_dir,
+				      qm, &hzip_diff_regs_fops);
 }
 
 static int hisi_zip_ctrl_debug_init(struct hisi_qm *qm)
@@ -666,6 +717,13 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 	qm->debug.sqe_mask_offset = HZIP_SQE_MASK_OFFSET;
 	qm->debug.sqe_mask_len = HZIP_SQE_MASK_LEN;
 	qm->debug.debug_root = dev_d;
+	ret = hisi_qm_diff_regs_init(qm, hzip_diff_regs,
+				ARRAY_SIZE(hzip_diff_regs));
+	if (ret) {
+		dev_warn(dev, "Failed to init ZIP diff regs!\n");
+		goto debugfs_remove;
+	}
+
 	hisi_qm_debug_init(qm);
 
 	if (qm->fun_type == QM_HW_PF) {
@@ -679,6 +737,8 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 	return 0;
 
 failed_to_create:
+	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
+debugfs_remove:
 	debugfs_remove_recursive(hzip_debugfs_root);
 	return ret;
 }
@@ -703,6 +763,8 @@ static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 
 static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
 {
+	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
+
 	debugfs_remove_recursive(qm->debug.debug_root);
 
 	if (qm->fun_type == QM_HW_PF) {
-- 
2.33.0

