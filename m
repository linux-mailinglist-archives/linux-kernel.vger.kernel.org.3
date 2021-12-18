Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031D0479A37
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhLRKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:22:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33865 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhLRKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:22:10 -0500
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JGMMw319XzcbcT;
        Sat, 18 Dec 2021 18:21:48 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 18 Dec 2021 18:22:08 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 18 Dec 2021 18:22:07 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - disable qm clock-gating
Date:   Sat, 18 Dec 2021 18:17:20 +0800
Message-ID: <20211218101720.18665-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Kunpeng930, if qm clock-gating is enabled, rate limiter
will be inaccurate. Therefore, disable clock-gating before doing task.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b1fe9c7b8cc8..b731cb4ec294 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -126,6 +126,8 @@
 #define QM_CQC_VFT			0x1
 #define QM_VFT_CFG			0x100060
 #define QM_VFT_CFG_OP_ENABLE		0x100054
+#define QM_PM_CTRL			0x100148
+#define QM_IDLE_DISABLE			BIT(9)
 
 #define QM_VFT_CFG_DATA_L		0x100064
 #define QM_VFT_CFG_DATA_H		0x100068
@@ -800,6 +802,19 @@ static void qm_db(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
 	qm->ops->qm_db(qm, qn, cmd, index, priority);
 }
 
+static void qm_disable_clock_gate(struct hisi_qm *qm)
+{
+	u32 val;
+
+	/* if qm enables clock gating in Kunpeng930, qos will be inaccurate. */
+	if (qm->ver < QM_HW_V3)
+		return;
+
+	val = readl(qm->io_base + QM_PM_CTRL);
+	val |= QM_IDLE_DISABLE;
+	writel(val, qm->io_base +  QM_PM_CTRL);
+}
+
 static int qm_dev_mem_reset(struct hisi_qm *qm)
 {
 	u32 val;
@@ -5935,6 +5950,7 @@ int hisi_qm_init(struct hisi_qm *qm)
 	}
 
 	if (qm->fun_type == QM_HW_PF) {
+		qm_disable_clock_gate(qm);
 		ret = qm_dev_mem_reset(qm);
 		if (ret) {
 			dev_err(dev, "failed to reset device memory\n");
@@ -6099,6 +6115,7 @@ static int qm_rebuild_for_resume(struct hisi_qm *qm)
 
 	qm_cmd_init(qm);
 	hisi_qm_dev_err_init(qm);
+	qm_disable_clock_gate(qm);
 	ret = qm_dev_mem_reset(qm);
 	if (ret)
 		pci_err(pdev, "failed to reset device memory\n");
-- 
2.33.0

