Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23065919E2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiHMKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiHMKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:37:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF1237D4;
        Sat, 13 Aug 2022 03:37:13 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M4cN30D1nz1M8hy;
        Sat, 13 Aug 2022 18:33:55 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 18:37:10 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 18:37:10 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - remove unneeded data storage
Date:   Sat, 13 Aug 2022 18:35:15 +0800
Message-ID: <20220813103515.26851-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junchong Pan <panjunchong@hisilicon.com>

The dump_show() is used to output hardware information for error locating.
It is not need to apply for memory to temporarily store the converted data.
It can directly output the data. Therefore, remove some unnecessary code.

Signed-off-by: Junchong Pan <panjunchong@hisilicon.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 80 +++++++++--------------------------
 1 file changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 5bf17dcbc170..a2d33d732708 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1867,39 +1867,19 @@ static void qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
 	kfree(ctx_addr);
 }

-static int dump_show(struct hisi_qm *qm, void *info,
+static void dump_show(struct hisi_qm *qm, void *info,
 		     unsigned int info_size, char *info_name)
 {
 	struct device *dev = &qm->pdev->dev;
-	u8 *info_buf, *info_curr = info;
+	u8 *info_curr = info;
 	u32 i;
 #define BYTE_PER_DW	4

-	info_buf = kzalloc(info_size, GFP_KERNEL);
-	if (!info_buf)
-		return -ENOMEM;
-
-	for (i = 0; i < info_size; i++, info_curr++) {
-		if (i % BYTE_PER_DW == 0)
-			info_buf[i + 3UL] = *info_curr;
-		else if (i % BYTE_PER_DW == 1)
-			info_buf[i + 1UL] = *info_curr;
-		else if (i % BYTE_PER_DW == 2)
-			info_buf[i - 1] = *info_curr;
-		else if (i % BYTE_PER_DW == 3)
-			info_buf[i - 3] = *info_curr;
-	}
-
 	dev_info(dev, "%s DUMP\n", info_name);
-	for (i = 0; i < info_size; i += BYTE_PER_DW) {
+	for (i = 0; i < info_size; i += BYTE_PER_DW, info_curr += BYTE_PER_DW) {
 		pr_info("DW%u: %02X%02X %02X%02X\n", i / BYTE_PER_DW,
-			info_buf[i], info_buf[i + 1UL],
-			info_buf[i + 2UL], info_buf[i + 3UL]);
+			*(info_curr + 3), *(info_curr + 2), *(info_curr + 1), *(info_curr));
 	}
-
-	kfree(info_buf);
-
-	return 0;
 }

 static int qm_dump_sqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
@@ -1939,23 +1919,18 @@ static int qm_sqc_dump(struct hisi_qm *qm, const char *s)
 		if (qm->sqc) {
 			sqc_curr = qm->sqc + qp_id;

-			ret = dump_show(qm, sqc_curr, sizeof(*sqc),
-					"SOFT SQC");
-			if (ret)
-				dev_info(dev, "Show soft sqc failed!\n");
+			dump_show(qm, sqc_curr, sizeof(*sqc), "SOFT SQC");
 		}
 		up_read(&qm->qps_lock);

-		goto err_free_ctx;
+		goto free_ctx;
 	}

-	ret = dump_show(qm, sqc, sizeof(*sqc), "SQC");
-	if (ret)
-		dev_info(dev, "Show hw sqc failed!\n");
+	dump_show(qm, sqc, sizeof(*sqc), "SQC");

-err_free_ctx:
+free_ctx:
 	qm_ctx_free(qm, sizeof(*sqc), sqc, &sqc_dma);
-	return ret;
+	return 0;
 }

 static int qm_cqc_dump(struct hisi_qm *qm, const char *s)
@@ -1985,23 +1960,18 @@ static int qm_cqc_dump(struct hisi_qm *qm, const char *s)
 		if (qm->cqc) {
 			cqc_curr = qm->cqc + qp_id;

-			ret = dump_show(qm, cqc_curr, sizeof(*cqc),
-					"SOFT CQC");
-			if (ret)
-				dev_info(dev, "Show soft cqc failed!\n");
+			dump_show(qm, cqc_curr, sizeof(*cqc), "SOFT CQC");
 		}
 		up_read(&qm->qps_lock);

-		goto err_free_ctx;
+		goto free_ctx;
 	}

-	ret = dump_show(qm, cqc, sizeof(*cqc), "CQC");
-	if (ret)
-		dev_info(dev, "Show hw cqc failed!\n");
+	dump_show(qm, cqc, sizeof(*cqc), "CQC");

-err_free_ctx:
+free_ctx:
 	qm_ctx_free(qm, sizeof(*cqc), cqc, &cqc_dma);
-	return ret;
+	return 0;
 }

 static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, size_t size,
@@ -2025,9 +1995,7 @@ static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, size_t size,
 	if (ret)
 		goto err_free_ctx;

-	ret = dump_show(qm, xeqc, size, name);
-	if (ret)
-		dev_info(dev, "Show hw %s failed!\n", name);
+	dump_show(qm, xeqc, size, name);

 err_free_ctx:
 	qm_ctx_free(qm, size, xeqc, &xeqc_dma);
@@ -2076,7 +2044,6 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,

 static int qm_sq_dump(struct hisi_qm *qm, char *s)
 {
-	struct device *dev = &qm->pdev->dev;
 	void *sqe, *sqe_curr;
 	struct hisi_qp *qp;
 	u32 qp_id, sqe_id;
@@ -2096,18 +2063,15 @@ static int qm_sq_dump(struct hisi_qm *qm, char *s)
 	memset(sqe_curr + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
 	       qm->debug.sqe_mask_len);

-	ret = dump_show(qm, sqe_curr, qm->sqe_size, "SQE");
-	if (ret)
-		dev_info(dev, "Show sqe failed!\n");
+	dump_show(qm, sqe_curr, qm->sqe_size, "SQE");

 	kfree(sqe);

-	return ret;
+	return 0;
 }

 static int qm_cq_dump(struct hisi_qm *qm, char *s)
 {
-	struct device *dev = &qm->pdev->dev;
 	struct qm_cqe *cqe_curr;
 	struct hisi_qp *qp;
 	u32 qp_id, cqe_id;
@@ -2119,11 +2083,9 @@ static int qm_cq_dump(struct hisi_qm *qm, char *s)

 	qp = &qm->qp_array[qp_id];
 	cqe_curr = qp->cqe + cqe_id;
-	ret = dump_show(qm, cqe_curr, sizeof(struct qm_cqe), "CQE");
-	if (ret)
-		dev_info(dev, "Show cqe failed!\n");
+	dump_show(qm, cqe_curr, sizeof(struct qm_cqe), "CQE");

-	return ret;
+	return 0;
 }

 static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
@@ -2160,9 +2122,7 @@ static int qm_eq_aeq_dump(struct hisi_qm *qm, const char *s,
 		goto err_unlock;
 	}

-	ret = dump_show(qm, xeqe, size, name);
-	if (ret)
-		dev_info(dev, "Show %s failed!\n", name);
+	dump_show(qm, xeqe, size, name);

 err_unlock:
 	up_read(&qm->qps_lock);
--
2.33.0
