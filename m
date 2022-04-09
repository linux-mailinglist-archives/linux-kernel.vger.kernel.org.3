Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA004FA5C4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiDIIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20373AA76;
        Sat,  9 Apr 2022 01:09:12 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb7582HmrzgYCr;
        Sat,  9 Apr 2022 16:07:24 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
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
Subject: [PATCH 10/11] crypto: hisilicon/hpre - support last word dumping
Date:   Sat, 9 Apr 2022 16:03:27 +0800
Message-ID: <20220409080328.15783-11-yekai13@huawei.com>
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
2. Add last word dumping function during hpre engine controller reset.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 132 ++++++++++++++++++----
 1 file changed, 112 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index d3f73e38709a..9d529df0eab9 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -36,6 +36,12 @@
 #define HPRE_DATA_WUSER_CFG		0x301040
 #define HPRE_INT_MASK			0x301400
 #define HPRE_INT_STATUS			0x301800
+#define HPRE_HAC_INT_MSK		0x301400
+#define HPRE_HAC_RAS_CE_ENB		0x301410
+#define HPRE_HAC_RAS_NFE_ENB		0x301414
+#define HPRE_HAC_RAS_FE_ENB		0x301418
+#define HPRE_HAC_INT_SET		0x301500
+#define HPRE_RNG_TIMEOUT_NUM		0x301A34
 #define HPRE_CORE_INT_ENABLE		0
 #define HPRE_CORE_INT_DISABLE		GENMASK(21, 0)
 #define HPRE_RDCHN_INI_ST		0x301a00
@@ -201,28 +207,32 @@ static const u64 hpre_cluster_offsets[] = {
 };
 
 static const struct debugfs_reg32 hpre_cluster_dfx_regs[] = {
-	{"CORES_EN_STATUS          ",  HPRE_CORE_EN_OFFSET},
-	{"CORES_INI_CFG              ",  HPRE_CORE_INI_CFG_OFFSET},
-	{"CORES_INI_STATUS         ",  HPRE_CORE_INI_STATUS_OFFSET},
-	{"CORES_HTBT_WARN         ",  HPRE_CORE_HTBT_WARN_OFFSET},
-	{"CORES_IS_SCHD               ",  HPRE_CORE_IS_SCHD_OFFSET},
+	{"CORES_EN_STATUS     ",  HPRE_CORE_EN_OFFSET},
+	{"CORES_INI_CFG       ",  HPRE_CORE_INI_CFG_OFFSET},
+	{"CORES_INI_STATUS    ",  HPRE_CORE_INI_STATUS_OFFSET},
+	{"CORES_HTBT_WARN     ",  HPRE_CORE_HTBT_WARN_OFFSET},
+	{"CORES_IS_SCHD       ",  HPRE_CORE_IS_SCHD_OFFSET},
 };
 
 static const struct debugfs_reg32 hpre_com_dfx_regs[] = {
-	{"READ_CLR_EN          ",  HPRE_CTRL_CNT_CLR_CE},
-	{"AXQOS                   ",  HPRE_VFG_AXQOS},
-	{"AWUSR_CFG              ",  HPRE_AWUSR_FP_CFG},
-	{"QM_ARUSR_MCFG1           ",  QM_ARUSER_M_CFG_1},
-	{"QM_AWUSR_MCFG1           ",  QM_AWUSER_M_CFG_1},
-	{"BD_ENDIAN               ",  HPRE_BD_ENDIAN},
-	{"ECC_CHECK_CTRL       ",  HPRE_ECC_BYPASS},
-	{"RAS_INT_WIDTH       ",  HPRE_RAS_WIDTH_CFG},
-	{"POISON_BYPASS       ",  HPRE_POISON_BYPASS},
-	{"BD_ARUSER               ",  HPRE_BD_ARUSR_CFG},
-	{"BD_AWUSER               ",  HPRE_BD_AWUSR_CFG},
-	{"DATA_ARUSER            ",  HPRE_DATA_RUSER_CFG},
-	{"DATA_AWUSER           ",  HPRE_DATA_WUSER_CFG},
-	{"INT_STATUS               ",  HPRE_INT_STATUS},
+	{"READ_CLR_EN     ",  HPRE_CTRL_CNT_CLR_CE},
+	{"AXQOS           ",  HPRE_VFG_AXQOS},
+	{"AWUSR_CFG       ",  HPRE_AWUSR_FP_CFG},
+	{"BD_ENDIAN       ",  HPRE_BD_ENDIAN},
+	{"ECC_CHECK_CTRL  ",  HPRE_ECC_BYPASS},
+	{"RAS_INT_WIDTH   ",  HPRE_RAS_WIDTH_CFG},
+	{"POISON_BYPASS   ",  HPRE_POISON_BYPASS},
+	{"BD_ARUSER       ",  HPRE_BD_ARUSR_CFG},
+	{"BD_AWUSER       ",  HPRE_BD_AWUSR_CFG},
+	{"DATA_ARUSER     ",  HPRE_DATA_RUSER_CFG},
+	{"DATA_AWUSER     ",  HPRE_DATA_WUSER_CFG},
+	{"INT_STATUS      ",  HPRE_INT_STATUS},
+	{"INT_MASK        ",  HPRE_HAC_INT_MSK},
+	{"RAS_CE_ENB      ",  HPRE_HAC_RAS_CE_ENB},
+	{"RAS_NFE_ENB     ",  HPRE_HAC_RAS_NFE_ENB},
+	{"RAS_FE_ENB      ",  HPRE_HAC_RAS_FE_ENB},
+	{"INT_SET         ",  HPRE_HAC_INT_SET},
+	{"RNG_TIMEOUT_NUM ",  HPRE_RNG_TIMEOUT_NUM},
 };
 
 static const char *hpre_dfx_files[HPRE_DFX_FILE_NUM] = {
@@ -1023,6 +1033,82 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 	return hisi_qm_init(qm);
 }
 
+static int hpre_show_last_regs_init(struct hisi_qm *qm)
+{
+	int cluster_dfx_regs_num =  ARRAY_SIZE(hpre_cluster_dfx_regs);
+	int com_dfx_regs_num = ARRAY_SIZE(hpre_com_dfx_regs);
+	u8 clusters_num = hpre_cluster_num(qm);
+	struct qm_debug *debug = &qm->debug;
+	void __iomem *io_base;
+	int i, j, idx;
+
+	debug->last_words = kcalloc(cluster_dfx_regs_num * clusters_num +
+			com_dfx_regs_num, sizeof(unsigned int), GFP_KERNEL);
+	if (!debug->last_words)
+		return -ENOMEM;
+
+	for (i = 0; i < com_dfx_regs_num; i++)
+		debug->last_words[i] = readl_relaxed(qm->io_base +
+						hpre_com_dfx_regs[i].offset);
+
+	for (i = 0; i < clusters_num; i++) {
+		io_base = qm->io_base + hpre_cluster_offsets[i];
+		for (j = 0; j < cluster_dfx_regs_num; j++) {
+			idx = com_dfx_regs_num + i * cluster_dfx_regs_num + j;
+			debug->last_words[idx] = readl_relaxed(
+				io_base + hpre_cluster_dfx_regs[j].offset);
+		}
+	}
+
+	return 0;
+}
+
+static void hpre_show_last_regs_uninit(struct hisi_qm *qm)
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
+static void hpre_show_last_dfx_regs(struct hisi_qm *qm)
+{
+	int cluster_dfx_regs_num =  ARRAY_SIZE(hpre_cluster_dfx_regs);
+	int com_dfx_regs_num = ARRAY_SIZE(hpre_com_dfx_regs);
+	u8 clusters_num = hpre_cluster_num(qm);
+	struct qm_debug *debug = &qm->debug;
+	struct pci_dev *pdev = qm->pdev;
+	void __iomem *io_base;
+	int i, j, idx;
+	u32 val;
+
+	if (qm->fun_type == QM_HW_VF || !debug->last_words)
+		return;
+
+	/* dumps last word of the debugging registers during controller reset */
+	for (i = 0; i < com_dfx_regs_num; i++) {
+		val = readl_relaxed(qm->io_base + hpre_com_dfx_regs[i].offset);
+		if (debug->last_words[i] != val)
+			pci_info(pdev, "Common_core:%s \t= 0x%08x => 0x%08x\n",
+			  hpre_com_dfx_regs[i].name, debug->last_words[i], val);
+	}
+
+	for (i = 0; i < clusters_num; i++) {
+		io_base = qm->io_base + hpre_cluster_offsets[i];
+		for (j = 0; j <  cluster_dfx_regs_num; j++) {
+			val = readl_relaxed(io_base +
+					     hpre_cluster_dfx_regs[j].offset);
+			idx = com_dfx_regs_num + i * cluster_dfx_regs_num + j;
+			if (debug->last_words[idx] != val)
+				pci_info(pdev, "cluster-%d:%s \t= 0x%08x => 0x%08x\n",
+				i, hpre_cluster_dfx_regs[j].name, debug->last_words[idx], val);
+		}
+	}
+}
+
 static void hpre_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 {
 	const struct hpre_hw_error *err = hpre_hw_errors;
@@ -1081,6 +1167,7 @@ static const struct hisi_qm_err_ini hpre_err_ini = {
 	.open_axi_master_ooo	= hpre_open_axi_master_ooo,
 	.open_sva_prefetch	= hpre_open_sva_prefetch,
 	.close_sva_prefetch	= hpre_close_sva_prefetch,
+	.show_last_dfx_regs	= hpre_show_last_dfx_regs,
 	.err_info_init		= hpre_err_info_init,
 };
 
@@ -1098,8 +1185,11 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 	qm->err_ini = &hpre_err_ini;
 	qm->err_ini->err_info_init(qm);
 	hisi_qm_dev_err_init(qm);
+	ret = hpre_show_last_regs_init(qm);
+	if (ret)
+		pci_err(qm->pdev, "Failed to init last word regs!\n");
 
-	return 0;
+	return ret;
 }
 
 static int hpre_probe_init(struct hpre *hpre)
@@ -1185,6 +1275,7 @@ static int hpre_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hisi_qm_stop(qm, QM_NORMAL);
 
 err_with_err_init:
+	hpre_show_last_regs_uninit(qm);
 	hisi_qm_dev_err_uninit(qm);
 
 err_with_qm_init:
@@ -1215,6 +1306,7 @@ static void hpre_remove(struct pci_dev *pdev)
 	if (qm->fun_type == QM_HW_PF) {
 		hpre_cnt_regs_clear(qm);
 		qm->debug.curr_qm_qp_num = 0;
+		hpre_show_last_regs_uninit(qm);
 		hisi_qm_dev_err_uninit(qm);
 	}
 
-- 
2.33.0

