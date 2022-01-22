Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9D3496AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiAVISe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:18:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16730 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiAVISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:18:24 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jgptw6VbPzZf8Q;
        Sat, 22 Jan 2022 16:14:32 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 16:18:22 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 22 Jan
 2022 16:18:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v3 2/5] crypto: hisilicon/sec - add some comments for soft fallback
Date:   Sat, 22 Jan 2022 16:13:09 +0800
Message-ID: <20220122081312.29121-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220122081312.29121-1-yekai13@huawei.com>
References: <20220122081312.29121-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the print of information that might lead to user misunderstanding.
Currently only XTS mode need the fallback tfm when using 192bit key.
Others algs not need soft fallback tfm. So others algs can return
directly.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index bf93c9847365..48abd3871c0e 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -641,13 +641,15 @@ static int sec_skcipher_fbtfm_init(struct crypto_skcipher *tfm)
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
 
 	c_ctx->fallback = false;
+
+	/* Currently, only XTS mode need fallback tfm when using 192bit key */
 	if (likely(strncmp(alg, "xts", SEC_XTS_NAME_SZ)))
 		return 0;
 
 	c_ctx->fbtfm = crypto_alloc_sync_skcipher(alg, 0,
 						  CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(c_ctx->fbtfm)) {
-		pr_err("failed to alloc fallback tfm!\n");
+		pr_err("failed to alloc xts mode fallback tfm!\n");
 		return PTR_ERR(c_ctx->fbtfm);
 	}
 
@@ -808,7 +810,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	}
 
 	memcpy(c_ctx->c_key, key, keylen);
-	if (c_ctx->fallback) {
+	if (c_ctx->fallback && c_ctx->fbtfm) {
 		ret = crypto_sync_skcipher_setkey(c_ctx->fbtfm, key, keylen);
 		if (ret) {
 			dev_err(dev, "failed to set fallback skcipher key!\n");
@@ -2032,13 +2034,12 @@ static int sec_skcipher_soft_crypto(struct sec_ctx *ctx,
 				    struct skcipher_request *sreq, bool encrypt)
 {
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, c_ctx->fbtfm);
 	struct device *dev = ctx->dev;
 	int ret;
 
-	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, c_ctx->fbtfm);
-
 	if (!c_ctx->fbtfm) {
-		dev_err(dev, "failed to check fallback tfm\n");
+		dev_err_ratelimited(dev, "the soft tfm isn't supported in the current system.\n");
 		return -EINVAL;
 	}
 
@@ -2256,7 +2257,6 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	if (ctx->sec->qm.ver == QM_HW_V2) {
 		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
 		    req->cryptlen <= authsize))) {
-			dev_err(dev, "Kunpeng920 not support 0 length!\n");
 			ctx->a_ctx.fallback = true;
 			return -EINVAL;
 		}
-- 
2.33.0

