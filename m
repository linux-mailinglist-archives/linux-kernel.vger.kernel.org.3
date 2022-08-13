Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485EA5919D0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiHMKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:21:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759FD13D7D;
        Sat, 13 Aug 2022 03:21:35 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M4c3L03tzzmVCK;
        Sat, 13 Aug 2022 18:19:26 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 18:21:33 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 18:21:33 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [RESEND PATCH] crypto: hisilicon/zip - some misc cleanup
Date:   Sat, 13 Aug 2022 18:19:39 +0800
Message-ID: <20220813101939.58778-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Some cleanup for code:
1. Change names for easy to understand.
2. Unify the variables type.
3. Use the right return value.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip.h        |  2 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c | 30 +++++++++++------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 10 +++++---
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip.h b/drivers/crypto/hisilicon/zip/zip.h
index 3dfd3bac5a33..f289656e9ac0 100644
--- a/drivers/crypto/hisilicon/zip/zip.h
+++ b/drivers/crypto/hisilicon/zip/zip.h
@@ -81,7 +81,7 @@ struct hisi_zip_sqe {
 	u32 rsvd1[4];
 };
 
-int zip_create_qps(struct hisi_qp **qps, int ctx_num, int node);
+int zip_create_qps(struct hisi_qp **qps, int qp_num, int node);
 int hisi_zip_register_to_crypto(struct hisi_qm *qm);
 void hisi_zip_unregister_from_crypto(struct hisi_qm *qm);
 #endif
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 12b6d86c54d7..dc271a8f6ac6 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -135,7 +135,7 @@ static u16 sgl_sge_nr = HZIP_SGL_SGE_NR;
 module_param_cb(sgl_sge_nr, &sgl_sge_nr_ops, &sgl_sge_nr, 0444);
 MODULE_PARM_DESC(sgl_sge_nr, "Number of sge in sgl(1-255)");
 
-static u16 get_extra_field_size(const u8 *start)
+static u32 get_extra_field_size(const u8 *start)
 {
 	return *((u16 *)start) + GZIP_HEAD_FEXTRA_XLEN;
 }
@@ -167,7 +167,7 @@ static u32 __get_gzip_head_size(const u8 *src)
 	return size;
 }
 
-static size_t __maybe_unused get_gzip_head_size(struct scatterlist *sgl)
+static u32 __maybe_unused get_gzip_head_size(struct scatterlist *sgl)
 {
 	char buf[HZIP_GZIP_HEAD_BUF];
 
@@ -497,7 +497,7 @@ static int hisi_zip_adecompress(struct acomp_req *acomp_req)
 	return ret;
 }
 
-static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *ctx,
+static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *qp_ctx,
 			     int alg_type, int req_type)
 {
 	struct device *dev = &qp->qm->pdev->dev;
@@ -505,7 +505,7 @@ static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *ctx,
 
 	qp->req_type = req_type;
 	qp->alg_type = alg_type;
-	qp->qp_ctx = ctx;
+	qp->qp_ctx = qp_ctx;
 
 	ret = hisi_qm_start_qp(qp, 0);
 	if (ret < 0) {
@@ -513,15 +513,15 @@ static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *ctx,
 		return ret;
 	}
 
-	ctx->qp = qp;
+	qp_ctx->qp = qp;
 
 	return 0;
 }
 
-static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *ctx)
+static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *qp_ctx)
 {
-	hisi_qm_stop_qp(ctx->qp);
-	hisi_qm_free_qps(&ctx->qp, 1);
+	hisi_qm_stop_qp(qp_ctx->qp);
+	hisi_qm_free_qps(&qp_ctx->qp, 1);
 }
 
 static const struct hisi_zip_sqe_ops hisi_zip_ops_v1 = {
@@ -593,7 +593,7 @@ static void hisi_zip_ctx_exit(struct hisi_zip_ctx *hisi_zip_ctx)
 {
 	int i;
 
-	for (i = 1; i >= 0; i--)
+	for (i = 0; i < HZIP_CTX_Q_NUM; i++)
 		hisi_zip_release_qp(&hisi_zip_ctx->qp_ctx[i]);
 }
 
@@ -612,7 +612,7 @@ static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
 			if (i == 0)
 				return ret;
 
-			goto err_free_loop0;
+			goto err_free_comp_q;
 		}
 		rwlock_init(&req_q->req_lock);
 
@@ -621,19 +621,19 @@ static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
 		if (!req_q->q) {
 			ret = -ENOMEM;
 			if (i == 0)
-				goto err_free_bitmap;
+				goto err_free_comp_bitmap;
 			else
-				goto err_free_loop1;
+				goto err_free_decomp_bitmap;
 		}
 	}
 
 	return 0;
 
-err_free_loop1:
+err_free_decomp_bitmap:
 	bitmap_free(ctx->qp_ctx[HZIP_QPC_DECOMP].req_q.req_bitmap);
-err_free_loop0:
+err_free_comp_q:
 	kfree(ctx->qp_ctx[HZIP_QPC_COMP].req_q.q);
-err_free_bitmap:
+err_free_comp_bitmap:
 	bitmap_free(ctx->qp_ctx[HZIP_QPC_COMP].req_q.req_bitmap);
 	return ret;
 }
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index c3303d99acac..04c8a4c65d77 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -586,8 +586,9 @@ static ssize_t hisi_zip_ctrl_debug_write(struct file *filp,
 		return len;
 
 	tbuf[len] = '\0';
-	if (kstrtoul(tbuf, 0, &val))
-		return -EFAULT;
+	ret = kstrtoul(tbuf, 0, &val);
+	if (ret)
+		return ret;
 
 	ret = hisi_qm_get_dfx_access(qm);
 	if (ret)
@@ -976,7 +977,10 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	qm->err_ini = &hisi_zip_err_ini;
 	qm->err_ini->err_info_init(qm);
 
-	hisi_zip_set_user_domain_and_cache(qm);
+	ret = hisi_zip_set_user_domain_and_cache(qm);
+	if (ret)
+		return ret;
+
 	hisi_zip_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
-- 
2.24.0

