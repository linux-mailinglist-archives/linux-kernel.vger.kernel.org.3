Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BD047139D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhLKLaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:30:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15727 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhLKLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:30:08 -0500
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JB58b52mHzZdXl;
        Sat, 11 Dec 2021 19:27:11 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:06 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 19:30:05 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 1/6] crypto: hisilicon/qm - remove unnecessary device memory reset
Date:   Sat, 11 Dec 2021 19:25:14 +0800
Message-ID: <20211211112519.21201-2-qianweili@huawei.com>
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

The internal memory of the device needs to be reset only when
the device is globally initialized. Other scenarios, such as
function reset, do not need to perform reset.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index bea8622d80e6..fba6a26089aa 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3581,10 +3581,6 @@ static int __hisi_qm_start(struct hisi_qm *qm)
 	WARN_ON(!qm->qdma.va);
 
 	if (qm->fun_type == QM_HW_PF) {
-		ret = qm_dev_mem_reset(qm);
-		if (ret)
-			return ret;
-
 		ret = hisi_qm_set_vft(qm, 0, qm->qp_base, qm->qp_num);
 		if (ret)
 			return ret;
@@ -5083,6 +5079,12 @@ static int qm_controller_reset_done(struct hisi_qm *qm)
 	if (qm->err_ini->open_axi_master_ooo)
 		qm->err_ini->open_axi_master_ooo(qm);
 
+	ret = qm_dev_mem_reset(qm);
+	if (ret) {
+		pci_err(pdev, "failed to reset device memory\n");
+		return ret;
+	}
+
 	ret = qm_restart(qm);
 	if (ret) {
 		pci_err(pdev, "Failed to start QM!\n");
@@ -5857,6 +5859,14 @@ int hisi_qm_init(struct hisi_qm *qm)
 			goto err_irq_register;
 	}
 
+	if (qm->fun_type == QM_HW_PF) {
+		ret = qm_dev_mem_reset(qm);
+		if (ret) {
+			dev_err(dev, "failed to reset device memory\n");
+			goto err_irq_register;
+		}
+	}
+
 	if (qm->mode == UACCE_MODE_SVA) {
 		ret = qm_alloc_uacce(qm);
 		if (ret < 0)
@@ -6014,8 +6024,11 @@ static int qm_rebuild_for_resume(struct hisi_qm *qm)
 
 	qm_cmd_init(qm);
 	hisi_qm_dev_err_init(qm);
+	ret = qm_dev_mem_reset(qm);
+	if (ret)
+		pci_err(pdev, "failed to reset device memory\n");
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.33.0

