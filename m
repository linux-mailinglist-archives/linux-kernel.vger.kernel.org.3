Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391CE4FFEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiDMTQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiDMTPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:15:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854872E19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:12:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i20so3966391wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RZL0XXsytYy5ZJKTr3LlYWtv8RryIBpNJlnFGby0uU=;
        b=HxfpaGzEwtyGNC6inuNuf2hnna9AB7qyJmL0p/4brkAA7e2J8t/VvBO14rZjQ5d/0r
         3SqWWbPXYn+IZbUe3c2YnxcuwCAc5KvyZ3K4vqcW9faBZv8nb1pYIzBicqt5rpGt4qSS
         aA//A+FVr+5BEd8Tom/MkRim9AqNga/np+xHO+AlQ6ziAdk+wK85OHnH7UgPy615MjLN
         7eEjXUHnY1tuDuKweiBnJsQvERoFBhVRWBoJjRMPZ1erYVJ8oJSWPCW3hBEzZ+1CqJxi
         KdULBdTPsyeSDbPmK3azJRr04ClKZ2x0ych9NUPYYaraRdqQOtVhRsS+wCvjudmiVXJn
         bHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RZL0XXsytYy5ZJKTr3LlYWtv8RryIBpNJlnFGby0uU=;
        b=X1ND8TtpA+1zDgRuvL2C831uOEFidNWRVLhiAP1NPGUlDcKXbdziapAzAWFMWfjtkU
         3UJtqUCqi4FspZUQ5e3lx7IzpZNchLumus1m4z/eGHv4gzJI4aJt7Fp8ZONyGdz08Mlq
         20yUD1tZ+jzt46wc1nSf4ycoaFZWZZiiFoXbSOGXGjwbr1PW4Fzoqz+a1WQtWqwabIeL
         kHvuz3yL/En73We0CbI46dfNET8IKor7t8kZ6ED2439+tZXe1B+2vnKXbHA5WmmYAWD0
         E/VDGSBkS4Bt+4QjrbDo+31ECxvd4wFk/ez6QqPzlfnyNPm7Yi1rVClaj7ad+8Fmht1S
         bE5A==
X-Gm-Message-State: AOAM530+Uyro9PQLlnWVwV5wtd/DNQYIJgAvfmhNm4x3dkfvpyl7v0uZ
        CkrAmAxfgWL3L+4TofCyUkklvA==
X-Google-Smtp-Source: ABdhPJzJMqQd4xcwB9Lk7IfWdm9xKXg5H4d0S7MZmu1Y6Rm8a0gSOFAhFfoRw3mVE0d5nEvCY8aePg==
X-Received: by 2002:a5d:4cc8:0:b0:207:b601:3137 with SMTP id c8-20020a5d4cc8000000b00207b6013137mr245720wrt.652.1649877122170;
        Wed, 13 Apr 2022 12:12:02 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o6-20020a05600002c600b00207a389117csm11963336wry.53.2022.04.13.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:12:01 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arno@natisbad.org, bbrezillon@kernel.org,
        herbert@gondor.apana.org.au, schalla@marvell.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] crypto: marvell: cesa: Add fallback for handling empty length case
Date:   Wed, 13 Apr 2022 19:11:55 +0000
Message-Id: <20220413191155.1429137-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413191155.1429137-1-clabbe@baylibre.com>
References: <20220413191155.1429137-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not handle case where cryptlen is zero and fail crypto selftests.
So let's add a fallback for this case.

Fixes: f63601fd616ab ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/marvell/Kconfig       |  4 ++
 drivers/crypto/marvell/cesa/cesa.h   | 12 +++--
 drivers/crypto/marvell/cesa/cipher.c | 69 ++++++++++++++++++++++++----
 3 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/marvell/Kconfig b/drivers/crypto/marvell/Kconfig
index a48591af12d0..6d8a625e2208 100644
--- a/drivers/crypto/marvell/Kconfig
+++ b/drivers/crypto/marvell/Kconfig
@@ -13,6 +13,10 @@ config CRYPTO_DEV_MARVELL_CESA
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	select SRAM
+	select CRYPTO_ECB
+	select CRYPTO_CBC
+	select CRYPTO_DES
+	select CRYPTO_AES
 	select CRYPTO_DEV_MARVELL
 	help
 	  This driver allows you to utilize the Cryptographic Engines and
diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index d215a6bed6bc..93736eed19f1 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -487,12 +487,14 @@ struct mv_cesa_req_ops {
 
 /**
  * struct mv_cesa_ctx - CESA operation context
- * @ops:	crypto operations
+ * @ops:		crypto operations
+ * @fallback_tfm:	pointer to the fallback TFM
  *
  * Base context structure inherited by operation specific ones.
  */
 struct mv_cesa_ctx {
 	const struct mv_cesa_req_ops *ops;
+	struct crypto_skcipher *fallback_tfm;
 };
 
 /**
@@ -563,15 +565,17 @@ struct mv_cesa_skcipher_std_req {
 
 /**
  * struct mv_cesa_skcipher_req - cipher request
- * @req:	type specific request information
- * @src_nents:	number of entries in the src sg list
- * @dst_nents:	number of entries in the dest sg list
+ * @req:		type specific request information
+ * @src_nents:		number of entries in the src sg list
+ * @dst_nents:		number of entries in the dest sg list
+ * @fallback_req:	request struct for invoking the fallback skcipher TFM
  */
 struct mv_cesa_skcipher_req {
 	struct mv_cesa_req base;
 	struct mv_cesa_skcipher_std_req std;
 	int src_nents;
 	int dst_nents;
+	struct skcipher_request fallback_req;   // keep at the end
 };
 
 /**
diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index c6f2fa753b7c..6da44651635f 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -37,6 +37,26 @@ struct mv_cesa_skcipher_dma_iter {
 	struct mv_cesa_sg_dma_iter dst;
 };
 
+static int cesa_skcipher_fallback(struct skcipher_request *areq,
+				  struct mv_cesa_op_ctx *tmpl)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct mv_cesa_ctx *op = crypto_skcipher_ctx(tfm);
+	struct mv_cesa_skcipher_req *rctx = skcipher_request_ctx(areq);
+	int err;
+
+	skcipher_request_set_tfm(&rctx->fallback_req, op->fallback_tfm);
+	skcipher_request_set_callback(&rctx->fallback_req, areq->base.flags,
+				      areq->base.complete, areq->base.data);
+	skcipher_request_set_crypt(&rctx->fallback_req, areq->src, areq->dst,
+				   areq->cryptlen, areq->iv);
+	if (mv_cesa_get_op_cfg(tmpl) & CESA_SA_DESC_CFG_DIR_DEC)
+		err = crypto_skcipher_decrypt(&rctx->fallback_req);
+	else
+		err = crypto_skcipher_encrypt(&rctx->fallback_req);
+	return err;
+}
+
 static inline void
 mv_cesa_skcipher_req_iter_init(struct mv_cesa_skcipher_dma_iter *iter,
 			       struct skcipher_request *req)
@@ -240,15 +260,25 @@ static const struct mv_cesa_req_ops mv_cesa_skcipher_req_ops = {
 
 static void mv_cesa_skcipher_cra_exit(struct crypto_tfm *tfm)
 {
-	void *ctx = crypto_tfm_ctx(tfm);
+	struct mv_cesa_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	memzero_explicit(ctx, tfm->__crt_alg->cra_ctxsize);
+	crypto_free_skcipher(ctx->fallback_tfm);
 }
 
 static int mv_cesa_skcipher_cra_init(struct crypto_tfm *tfm)
 {
 	struct mv_cesa_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct crypto_skcipher *sktfm = __crypto_skcipher_cast(tfm);
+	const char *name = crypto_tfm_alg_name(tfm);
+
+	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(ctx->fallback_tfm)) {
+		return PTR_ERR(ctx->fallback_tfm);
+	}
 
+	sktfm->reqsize = sizeof(struct mv_cesa_ctx) +
+		crypto_skcipher_reqsize(ctx->fallback_tfm);
 	ctx->ops = &mv_cesa_skcipher_req_ops;
 
 	crypto_skcipher_set_reqsize(__crypto_skcipher_cast(tfm),
@@ -276,7 +306,10 @@ static int mv_cesa_aes_setkey(struct crypto_skcipher *cipher, const u8 *key,
 	for (i = 0; i < remaining; i++)
 		ctx->aes.key_dec[4 + i] = ctx->aes.key_enc[offset + i];
 
-	return 0;
+	crypto_skcipher_clear_flags(ctx->base.fallback_tfm, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(ctx->base.fallback_tfm, cipher->base.crt_flags & CRYPTO_TFM_REQ_MASK);
+
+	return crypto_skcipher_setkey(ctx->base.fallback_tfm, key, len);
 }
 
 static int mv_cesa_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
@@ -291,7 +324,10 @@ static int mv_cesa_des_setkey(struct crypto_skcipher *cipher, const u8 *key,
 
 	memcpy(ctx->key, key, DES_KEY_SIZE);
 
-	return 0;
+	crypto_skcipher_clear_flags(ctx->base.fallback_tfm, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(ctx->base.fallback_tfm, cipher->base.crt_flags & CRYPTO_TFM_REQ_MASK);
+
+	return crypto_skcipher_setkey(ctx->base.fallback_tfm, key, len);
 }
 
 static int mv_cesa_des3_ede_setkey(struct crypto_skcipher *cipher,
@@ -306,7 +342,10 @@ static int mv_cesa_des3_ede_setkey(struct crypto_skcipher *cipher,
 
 	memcpy(ctx->key, key, DES3_EDE_KEY_SIZE);
 
-	return 0;
+	crypto_skcipher_clear_flags(ctx->base.fallback_tfm, CRYPTO_TFM_REQ_MASK);
+	crypto_skcipher_set_flags(ctx->base.fallback_tfm, cipher->base.crt_flags & CRYPTO_TFM_REQ_MASK);
+
+	return crypto_skcipher_setkey(ctx->base.fallback_tfm, key, len);
 }
 
 static int mv_cesa_skcipher_dma_req_init(struct skcipher_request *req,
@@ -458,6 +497,13 @@ static int mv_cesa_skcipher_queue_req(struct skcipher_request *req,
 	int ret;
 	struct mv_cesa_skcipher_req *creq = skcipher_request_ctx(req);
 	struct mv_cesa_engine *engine;
+	bool need_fallback = false;
+
+	if (!req->cryptlen)
+		need_fallback = true;
+
+	if (need_fallback)
+		return cesa_skcipher_fallback(req, tmpl);
 
 	ret = mv_cesa_skcipher_req_init(req, tmpl);
 	if (ret)
@@ -520,7 +566,8 @@ struct skcipher_alg mv_cesa_ecb_des_alg = {
 		.cra_driver_name = "mv-ecb-des",
 		.cra_priority = 300,
 		.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC |
-			     CRYPTO_ALG_ALLOCATES_MEMORY,
+			     CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize = DES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct mv_cesa_des_ctx),
 		.cra_alignmask = 0,
@@ -571,7 +618,8 @@ struct skcipher_alg mv_cesa_cbc_des_alg = {
 		.cra_driver_name = "mv-cbc-des",
 		.cra_priority = 300,
 		.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC |
-			     CRYPTO_ALG_ALLOCATES_MEMORY,
+			     CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize = DES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct mv_cesa_des_ctx),
 		.cra_alignmask = 0,
@@ -629,7 +677,8 @@ struct skcipher_alg mv_cesa_ecb_des3_ede_alg = {
 		.cra_driver_name = "mv-ecb-des3-ede",
 		.cra_priority = 300,
 		.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC |
-			     CRYPTO_ALG_ALLOCATES_MEMORY,
+			     CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct mv_cesa_des3_ctx),
 		.cra_alignmask = 0,
@@ -683,7 +732,8 @@ struct skcipher_alg mv_cesa_cbc_des3_ede_alg = {
 		.cra_driver_name = "mv-cbc-des3-ede",
 		.cra_priority = 300,
 		.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC |
-			     CRYPTO_ALG_ALLOCATES_MEMORY,
+			     CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct mv_cesa_des3_ctx),
 		.cra_alignmask = 0,
@@ -756,7 +806,8 @@ struct skcipher_alg mv_cesa_ecb_aes_alg = {
 		.cra_driver_name = "mv-ecb-aes",
 		.cra_priority = 300,
 		.cra_flags = CRYPTO_ALG_KERN_DRIVER_ONLY | CRYPTO_ALG_ASYNC |
-			     CRYPTO_ALG_ALLOCATES_MEMORY,
+			     CRYPTO_ALG_ALLOCATES_MEMORY |
+			     CRYPTO_ALG_NEED_FALLBACK,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct mv_cesa_aes_ctx),
 		.cra_alignmask = 0,
-- 
2.35.1

