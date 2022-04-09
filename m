Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B01D4FA5C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiDIIMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB738199;
        Sat,  9 Apr 2022 01:09:12 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb76c5Hpxz1HBbZ;
        Sat,  9 Apr 2022 16:08:40 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:09:11 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 9 Apr
 2022 16:09:10 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 11/11] crypto: hisilicon/zip - support last word dumping
Date:   Sat, 9 Apr 2022 16:03:28 +0800
Message-ID: <20220409080328.15783-12-yekai13@huawei.com>
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

1. Add some debugging registers.
2. Add last word dumping function during zip engine controller reset.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 107 +++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 2d5663d8d87f..9c925e9c0a2d 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -234,6 +234,22 @@ static const struct debugfs_reg32 hzip_dfx_regs[] = {
 	{"HZIP_DECOMP_LZ77_CURR_ST       ",  0x9cull},
 };
 
+static const struct debugfs_reg32 hzip_com_dfx_regs[] = {
+	{"HZIP_CLOCK_GATE_CTRL           ",  0x301004},
+	{"HZIP_CORE_INT_RAS_CE_ENB       ",  0x301160},
+	{"HZIP_CORE_INT_RAS_NFE_ENB      ",  0x301164},
+	{"HZIP_CORE_INT_RAS_FE_ENB       ",  0x301168},
+	{"HZIP_UNCOM_ERR_RAS_CTRL        ",  0x30116C},
+};
+
+static const struct debugfs_reg32 hzip_dump_dfx_regs[] = {
+	{"HZIP_GET_BD_NUM                ",  0x00ull},
+	{"HZIP_GET_RIGHT_BD              ",  0x04ull},
+	{"HZIP_GET_ERROR_BD              ",  0x08ull},
+	{"HZIP_DONE_BD_NUM               ",  0x0cull},
+	{"HZIP_MAX_DELAY                 ",  0x20ull},
+};
+
 /* define the ZIP's dfx regs region and region length */
 static struct dfx_diff_registers hzip_diff_regs[] = {
 	{
@@ -773,6 +789,87 @@ static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
 	}
 }
 
+static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
+{
+	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
+	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
+	struct qm_debug *debug = &qm->debug;
+	void __iomem *io_base;
+	int i, j, idx;
+
+	debug->last_words = kcalloc(core_dfx_regs_num * HZIP_CORE_NUM +
+			com_dfx_regs_num, sizeof(unsigned int), GFP_KERNEL);
+	if (!debug->last_words)
+		return -ENOMEM;
+
+	for (i = 0; i < com_dfx_regs_num; i++) {
+		io_base = qm->io_base + hzip_com_dfx_regs[i].offset;
+		debug->last_words[i] = readl_relaxed(io_base);
+	}
+
+	for (i = 0; i < HZIP_CORE_NUM; i++) {
+		io_base = qm->io_base + core_offsets[i];
+		for (j = 0; j < core_dfx_regs_num; j++) {
+			idx = com_dfx_regs_num + i * core_dfx_regs_num + j;
+			debug->last_words[idx] = readl_relaxed(
+				io_base + hzip_dump_dfx_regs[j].offset);
+		}
+	}
+
+	return 0;
+}
+
+static void hisi_zip_show_last_regs_uninit(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+
+	if (qm->fun_type == QM_HW_VF || !debug->last_words)
+		return;
+
+	kfree(debug->last_words);
+	debug->last_words = NULL;
+}
+
+static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
+{
+	int core_dfx_regs_num =  ARRAY_SIZE(hzip_dump_dfx_regs);
+	int com_dfx_regs_num = ARRAY_SIZE(hzip_com_dfx_regs);
+	struct qm_debug *debug = &qm->debug;
+	char buf[HZIP_BUF_SIZE];
+	void __iomem *base;
+	int i, j, idx;
+	u32 val;
+
+	if (qm->fun_type == QM_HW_VF || !debug->last_words)
+		return;
+
+	for (i = 0; i < com_dfx_regs_num; i++) {
+		val = readl_relaxed(qm->io_base + hzip_com_dfx_regs[i].offset);
+		if (debug->last_words[i] != val)
+			pci_info(qm->pdev, "com_dfx: %s \t= 0x%08x => 0x%08x\n",
+				hzip_com_dfx_regs[i].name, debug->last_words[i], val);
+	}
+
+	for (i = 0; i < HZIP_CORE_NUM; i++) {
+		if (i < HZIP_COMP_CORE_NUM)
+			scnprintf(buf, sizeof(buf), "Comp_core-%d", i);
+		else
+			scnprintf(buf, sizeof(buf), "Decomp_core-%d",
+				  i - HZIP_COMP_CORE_NUM);
+		base = qm->io_base + core_offsets[i];
+
+		pci_info(qm->pdev, "==>%s:\n", buf);
+		/* dump last word for dfx regs during control resetting */
+		for (j = 0; j < core_dfx_regs_num; j++) {
+			idx = com_dfx_regs_num + i * core_dfx_regs_num + j;
+			val = readl_relaxed(base + hzip_dump_dfx_regs[j].offset);
+			if (debug->last_words[idx] != val)
+				pci_info(qm->pdev, "%s \t= 0x%08x => 0x%08x\n",
+					hzip_dump_dfx_regs[j].name, debug->last_words[idx], val);
+		}
+	}
+}
+
 static void hisi_zip_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 {
 	const struct hisi_zip_hw_error *err = zip_hw_error;
@@ -860,6 +957,7 @@ static const struct hisi_qm_err_ini hisi_zip_err_ini = {
 	.close_axi_master_ooo	= hisi_zip_close_axi_master_ooo,
 	.open_sva_prefetch	= hisi_zip_open_sva_prefetch,
 	.close_sva_prefetch	= hisi_zip_close_sva_prefetch,
+	.show_last_dfx_regs	= hisi_zip_show_last_dfx_regs,
 	.err_info_init		= hisi_zip_err_info_init,
 };
 
@@ -867,6 +965,7 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 {
 	struct hisi_qm *qm = &hisi_zip->qm;
 	struct hisi_zip_ctrl *ctrl;
+	int ret;
 
 	ctrl = devm_kzalloc(&qm->pdev->dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -882,7 +981,11 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
 
-	return 0;
+	ret = hisi_zip_show_last_regs_init(qm);
+	if (ret)
+		pci_err(qm->pdev, "Failed to init last word regs!\n");
+
+	return ret;
 }
 
 static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
@@ -1026,6 +1129,7 @@ static int hisi_zip_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hisi_qm_stop(qm, QM_NORMAL);
 
 err_dev_err_uninit:
+	hisi_zip_show_last_regs_uninit(qm);
 	hisi_qm_dev_err_uninit(qm);
 
 err_qm_uninit:
@@ -1047,6 +1151,7 @@ static void hisi_zip_remove(struct pci_dev *pdev)
 
 	hisi_zip_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
+	hisi_zip_show_last_regs_uninit(qm);
 	hisi_qm_dev_err_uninit(qm);
 	hisi_zip_qm_uninit(qm);
 }
-- 
2.33.0

