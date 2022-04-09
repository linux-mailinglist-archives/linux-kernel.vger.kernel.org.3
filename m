Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5D4FA5C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiDIIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiDIILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE23AA42;
        Sat,  9 Apr 2022 01:09:12 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb76c2y9sz1HBbS;
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
Subject: [PATCH 09/11] crypto: hisilicon/sec - support last word dumping
Date:   Sat, 9 Apr 2022 16:03:26 +0800
Message-ID: <20220409080328.15783-10-yekai13@huawei.com>
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

Add last word dumping function during sec engine controller reset.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 55 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 93ef0e3b5b16..4d85d2cbf376 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -861,6 +861,53 @@ static void sec_debugfs_exit(struct hisi_qm *qm)
 	debugfs_remove_recursive(qm->debug.debug_root);
 }
 
+static int sec_show_last_regs_init(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+	int i;
+
+	debug->last_words = kcalloc(ARRAY_SIZE(sec_dfx_regs),
+					sizeof(unsigned int), GFP_KERNEL);
+	if (!debug->last_words)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(sec_dfx_regs); i++)
+		debug->last_words[i] = readl_relaxed(qm->io_base +
+							sec_dfx_regs[i].offset);
+
+	return 0;
+}
+
+static void sec_show_last_regs_uninit(struct hisi_qm *qm)
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
+static void sec_show_last_dfx_regs(struct hisi_qm *qm)
+{
+	struct qm_debug *debug = &qm->debug;
+	struct pci_dev *pdev = qm->pdev;
+	u32 val;
+	int i;
+
+	if (qm->fun_type == QM_HW_VF || !debug->last_words)
+		return;
+
+	/* dumps last word of the debugging registers during controller reset */
+	for (i = 0; i < ARRAY_SIZE(sec_dfx_regs); i++) {
+		val = readl_relaxed(qm->io_base + sec_dfx_regs[i].offset);
+		if (val != debug->last_words[i])
+			pci_info(pdev, "%s \t= 0x%08x => 0x%08x\n",
+				sec_dfx_regs[i].name, debug->last_words[i], val);
+	}
+}
+
 static void sec_log_hw_error(struct hisi_qm *qm, u32 err_sts)
 {
 	const struct sec_hw_error *errs = sec_hw_errors;
@@ -927,6 +974,7 @@ static const struct hisi_qm_err_ini sec_err_ini = {
 	.open_axi_master_ooo	= sec_open_axi_master_ooo,
 	.open_sva_prefetch	= sec_open_sva_prefetch,
 	.close_sva_prefetch	= sec_close_sva_prefetch,
+	.show_last_dfx_regs	= sec_show_last_dfx_regs,
 	.err_info_init		= sec_err_info_init,
 };
 
@@ -945,8 +993,11 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	sec_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	sec_debug_regs_clear(qm);
+	ret = sec_show_last_regs_init(qm);
+	if (ret)
+		pci_err(qm->pdev, "Failed to init last word regs!\n");
 
-	return 0;
+	return ret;
 }
 
 static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
@@ -1120,6 +1171,7 @@ static int sec_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sec_debugfs_exit(qm);
 	hisi_qm_stop(qm, QM_NORMAL);
 err_probe_uninit:
+	sec_show_last_regs_uninit(qm);
 	sec_probe_uninit(qm);
 err_qm_uninit:
 	sec_qm_uninit(qm);
@@ -1144,6 +1196,7 @@ static void sec_remove(struct pci_dev *pdev)
 
 	if (qm->fun_type == QM_HW_PF)
 		sec_debug_regs_clear(qm);
+	sec_show_last_regs_uninit(qm);
 
 	sec_probe_uninit(qm);
 
-- 
2.33.0

