Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E7544C45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245607AbiFIMho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbiFIMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:37:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4781C22BCF;
        Thu,  9 Jun 2022 05:37:34 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJk8Z2vztz1GCSf;
        Thu,  9 Jun 2022 20:35:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:37:32 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 20:37:32 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH 1/3] crypto: hisilicon/qm - add functions for releasing resources
Date:   Thu, 9 Jun 2022 20:31:17 +0800
Message-ID: <20220609123119.27252-2-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609123119.27252-1-qianweili@huawei.com>
References: <20220609123119.27252-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resources allocated by hisi_qm_memory_init() are released by
hisi_qm_uninit(). Add hisi_qm_memory_uninit() to release resources,
no functional change.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b4ca2eb034d7..903896ab5be5 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3672,6 +3672,21 @@ static void qm_last_regs_uninit(struct hisi_qm *qm)
 	debug->qm_last_words = NULL;
 }
 
+static void hisi_qm_memory_uninit(struct hisi_qm *qm)
+{
+	struct device *dev = &qm->pdev->dev;
+
+	hisi_qp_memory_uninit(qm, qm->qp_num);
+	if (qm->qdma.va) {
+		hisi_qm_cache_wb(qm);
+		dma_free_coherent(dev, qm->qdma.size,
+				  qm->qdma.va, qm->qdma.dma);
+	}
+
+	idr_destroy(&qm->qp_idr);
+	kfree(qm->factor);
+}
+
 /**
  * hisi_qm_uninit() - Uninitialize qm.
  * @qm: The qm needed uninit.
@@ -3680,13 +3695,9 @@ static void qm_last_regs_uninit(struct hisi_qm *qm)
  */
 void hisi_qm_uninit(struct hisi_qm *qm)
 {
-	struct pci_dev *pdev = qm->pdev;
-	struct device *dev = &pdev->dev;
-
 	qm_last_regs_uninit(qm);
 
 	qm_cmd_uninit(qm);
-	kfree(qm->factor);
 	down_write(&qm->qps_lock);
 
 	if (!qm_avail_state(qm, QM_CLOSE)) {
@@ -3694,14 +3705,7 @@ void hisi_qm_uninit(struct hisi_qm *qm)
 		return;
 	}
 
-	hisi_qp_memory_uninit(qm, qm->qp_num);
-	idr_destroy(&qm->qp_idr);
-
-	if (qm->qdma.va) {
-		hisi_qm_cache_wb(qm);
-		dma_free_coherent(dev, qm->qdma.size,
-				  qm->qdma.va, qm->qdma.dma);
-	}
+	hisi_qm_memory_uninit(qm);
 	hisi_qm_set_state(qm, QM_NOT_READY);
 	up_write(&qm->qps_lock);
 
-- 
2.33.0

