Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544EA4FA5C3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbiDIIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A055533E16;
        Sat,  9 Apr 2022 01:09:11 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kb7574d8hzgYPB;
        Sat,  9 Apr 2022 16:07:23 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
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
Subject: [PATCH 03/11] crypto: hisilicon/sec - support register checking
Date:   Sat, 9 Apr 2022 16:03:20 +0800
Message-ID: <20220409080328.15783-4-yekai13@huawei.com>
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
 drivers/crypto/hisilicon/sec2/sec_main.c | 53 ++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 92fae706bdb2..93ef0e3b5b16 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -110,6 +110,15 @@
 #define SEC_SQE_MASK_LEN		48
 #define SEC_SHAPER_TYPE_RATE		400
 
+#define SEC_DFX_BASE		0x301000
+#define SEC_DFX_CORE		0x302100
+#define SEC_DFX_COMMON1		0x301600
+#define SEC_DFX_COMMON2		0x301C00
+#define SEC_DFX_BASE_LEN		0x9D
+#define SEC_DFX_CORE_LEN		0x32B
+#define SEC_DFX_COMMON1_LEN		0x45
+#define SEC_DFX_COMMON2_LEN		0xBA
+
 struct sec_hw_error {
 	u32 int_msk;
 	const char *msg;
@@ -226,6 +235,34 @@ static const struct debugfs_reg32 sec_dfx_regs[] = {
 	{"SEC_BD_SAA8                   ",  0x301C40},
 };
 
+/* define the SEC's dfx regs region and region length */
+static struct dfx_diff_registers sec_diff_regs[] = {
+	{
+		.reg_offset = SEC_DFX_BASE,
+		.reg_len = SEC_DFX_BASE_LEN,
+	}, {
+		.reg_offset = SEC_DFX_COMMON1,
+		.reg_len = SEC_DFX_COMMON1_LEN,
+	}, {
+		.reg_offset = SEC_DFX_COMMON2,
+		.reg_len = SEC_DFX_COMMON2_LEN,
+	}, {
+		.reg_offset = SEC_DFX_CORE,
+		.reg_len = SEC_DFX_CORE_LEN,
+	},
+};
+
+static int sec_diff_regs_show(struct seq_file *s, void *unused)
+{
+	struct hisi_qm *qm = s->private;
+
+	hisi_qm_acc_diff_regs_dump(qm, s, qm->debug.acc_diff_regs,
+					ARRAY_SIZE(sec_diff_regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(sec_diff_regs);
+
 static int sec_pf_q_num_set(const char *val, const struct kernel_param *kp)
 {
 	return q_num_set(val, kp, PCI_DEVICE_ID_HUAWEI_SEC_PF);
@@ -729,6 +766,7 @@ DEFINE_SHOW_ATTRIBUTE(sec_regs);
 
 static int sec_core_debug_init(struct hisi_qm *qm)
 {
+	struct dfx_diff_registers *sec_regs = qm->debug.acc_diff_regs;
 	struct sec_dev *sec = container_of(qm, struct sec_dev, qm);
 	struct device *dev = &qm->pdev->dev;
 	struct sec_dfx *dfx = &sec->debug.dfx;
@@ -749,6 +787,9 @@ static int sec_core_debug_init(struct hisi_qm *qm)
 
 	if (qm->pdev->device == PCI_DEVICE_ID_HUAWEI_SEC_PF)
 		debugfs_create_file("regs", 0444, tmp_d, regset, &sec_regs_fops);
+	if (qm->fun_type == QM_HW_PF && sec_regs)
+		debugfs_create_file("diff_regs", 0444, tmp_d,
+				      qm, &sec_diff_regs_fops);
 
 	for (i = 0; i < ARRAY_SIZE(sec_dfx_labels); i++) {
 		atomic64_t *data = (atomic64_t *)((uintptr_t)dfx +
@@ -790,6 +831,14 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 						  sec_debugfs_root);
 	qm->debug.sqe_mask_offset = SEC_SQE_MASK_OFFSET;
 	qm->debug.sqe_mask_len = SEC_SQE_MASK_LEN;
+
+	ret = hisi_qm_diff_regs_init(qm, sec_diff_regs,
+				ARRAY_SIZE(sec_diff_regs));
+	if (ret) {
+		dev_warn(dev, "Failed to init SEC diff regs!\n");
+		goto debugfs_remove;
+	}
+
 	hisi_qm_debug_init(qm);
 
 	ret = sec_debug_init(qm);
@@ -799,12 +848,16 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 	return 0;
 
 failed_to_create:
+	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
+debugfs_remove:
 	debugfs_remove_recursive(sec_debugfs_root);
 	return ret;
 }
 
 static void sec_debugfs_exit(struct hisi_qm *qm)
 {
+	hisi_qm_diff_regs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
+
 	debugfs_remove_recursive(qm->debug.debug_root);
 }
 
-- 
2.33.0

