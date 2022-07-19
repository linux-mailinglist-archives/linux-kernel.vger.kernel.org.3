Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C9579072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiGSCGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiGSCGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:06:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F73C17B;
        Mon, 18 Jul 2022 19:06:35 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ln2Gp1T5jzFqBD;
        Tue, 19 Jul 2022 10:05:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 10:06:23 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <xuzaibo@huawei.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH] crypto: hisilicon/hpre - don't use GFP_KERNEL to alloc mem during softirq
Date:   Tue, 19 Jul 2022 10:10:42 +0800
Message-ID: <20220719021042.250882-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hpre encryption driver may be used to encrypt and decrypt packets
during the rx softirq, it is not allowed to use GFP_KERNEL.

Fixes: c8b4b477079d ("crypto: hisilicon - add HiSilicon HPRE accelerator")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

This patch is not tested, compiled only.
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 28 +++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index 97d54c1465c2..cf098fa673f4 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -241,7 +241,7 @@ static int hpre_get_data_dma_addr(struct hpre_asym_request *hpre_req,
 
 static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 				struct scatterlist *data, unsigned int len,
-				int is_src, dma_addr_t *tmp)
+				int is_src, dma_addr_t *tmp, gfp_t flags)
 {
 	struct hpre_ctx *ctx = hpre_req->ctx;
 	struct device *dev = ctx->dev;
@@ -252,7 +252,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 	if (unlikely(shift < 0))
 		return -EINVAL;
 
-	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, GFP_KERNEL);
+	ptr = dma_alloc_coherent(dev, ctx->key_sz, tmp, flags);
 	if (unlikely(!ptr))
 		return -ENOMEM;
 
@@ -268,7 +268,7 @@ static int hpre_prepare_dma_buf(struct hpre_asym_request *hpre_req,
 
 static int hpre_hw_data_init(struct hpre_asym_request *hpre_req,
 			     struct scatterlist *data, unsigned int len,
-			     int is_src, int is_dh)
+			     int is_src, int is_dh, u32 flags)
 {
 	struct hpre_sqe *msg = &hpre_req->req;
 	struct hpre_ctx *ctx = hpre_req->ctx;
@@ -280,7 +280,9 @@ static int hpre_hw_data_init(struct hpre_asym_request *hpre_req,
 	    ((is_dh && !is_src) || !is_dh))
 		ret = hpre_get_data_dma_addr(hpre_req, data, len, is_src, &tmp);
 	else
-		ret = hpre_prepare_dma_buf(hpre_req, data, len, is_src, &tmp);
+		ret = hpre_prepare_dma_buf(hpre_req, data, len, is_src, &tmp,
+					   (flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
+					   GFP_KERNEL : GFP_ATOMIC);
 
 	if (unlikely(ret))
 		return ret;
@@ -585,14 +587,16 @@ static int hpre_dh_compute_value(struct kpp_request *req)
 		return ret;
 
 	if (req->src) {
-		ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 1);
+		ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 1,
+					req->base.flags);
 		if (unlikely(ret))
 			goto clear_all;
 	} else {
 		msg->in = cpu_to_le64(ctx->dh.dma_g);
 	}
 
-	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 1);
+	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 1,
+				req->base.flags);
 	if (unlikely(ret))
 		goto clear_all;
 
@@ -800,11 +804,13 @@ static int hpre_rsa_enc(struct akcipher_request *req)
 	msg->dw0 |= cpu_to_le32(HPRE_ALG_NC_NCRT);
 	msg->key = cpu_to_le64(ctx->rsa.dma_pubkey);
 
-	ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 0);
+	ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 0,
+				req->base.flags);
 	if (unlikely(ret))
 		goto clear_all;
 
-	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 0);
+	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 0,
+				req->base.flags);
 	if (unlikely(ret))
 		goto clear_all;
 
@@ -855,11 +861,13 @@ static int hpre_rsa_dec(struct akcipher_request *req)
 				       HPRE_ALG_NC_NCRT);
 	}
 
-	ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 0);
+	ret = hpre_hw_data_init(hpre_req, req->src, req->src_len, 1, 0,
+				req->base.flags);
 	if (unlikely(ret))
 		goto clear_all;
 
-	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 0);
+	ret = hpre_hw_data_init(hpre_req, req->dst, req->dst_len, 0, 0,
+				req->base.flags);
 	if (unlikely(ret))
 		goto clear_all;
 
-- 
2.17.1

