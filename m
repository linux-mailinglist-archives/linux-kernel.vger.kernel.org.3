Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9624DCFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiCQU5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiCQU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51815679E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5652258wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0d4XxPdz36ohTVp39HrUVlEmSJzRArixg/2LMa5A5c=;
        b=nPreDq2KvByB2eJ8eK1Dw6N9nhnzEHzOsA2dNpgtu9HCK+VYCt6RwN5qm1StKnadda
         1Cq5VbLfwMPwec4iNFlVKfQcnhQZrJ4t+MTmefzcDjT01aliAblPTjt3myN8RyyjQZHz
         r+BwNubk5ndYHiCL53UTfPn2VIa8zqE4ttcFtOttO+qDbIi/nuUXgKu9DtmHjZy+yDvg
         bp+sgahSdwGh/JdtcqUfTExoRJMa0xupM5OJMDgyEqJVpewKxLBZyG6iQlI7ww0Zr4PJ
         gwO8W9aoH1Bg8fC+GcGbmZgLwKK0gpHFpoi0QKCeGZXJlkDWYRY+7DsaTpzdAcwuihOC
         WZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0d4XxPdz36ohTVp39HrUVlEmSJzRArixg/2LMa5A5c=;
        b=fScVF5DSxd4QepSP0P4m8HSc+nYeX8TWH8pZZ0ts9xQ+XuuT72euecnq+LDXSXmcSZ
         zkjsmBtAzhk0+A3XbqIf2N11eNrq3RamKVouRxfyckw6iqqR1PgwMlKBiB50tR4tLP3r
         0FHR/pKXn6iQtVJOGjA1NQnMSTKvbJbiO6HrApekgs8xQvZWLlqRBfvrwa+Q5vE4CFnP
         o6ppuE9ou5xUlKuvvY0jZLfsGxLG5cicWrAS/Dw3IJ6IXMBqs8tObg9LHNctQbrhoeOy
         JS8Emelp1A+LE8vZayDs9ktMc8kcFWytoMdr5TgbnYNgjNGvsrrgE37oG+wsEIf/7ROm
         W8xw==
X-Gm-Message-State: AOAM532Qcr14QyRxrWfJA/zZv9LatTARSKlqSi7RSNfhTBuwpdOG/0j9
        K2qi5MCZgEkKieRyGLgHNqMmygEI6iWgcA==
X-Google-Smtp-Source: ABdhPJwqvc9JTOe1IAi9A07n1LaKS4kWJRbtjDjyaXrhoAiLICSGd3pa3vHfqpxG2jSuWSITX6T4fw==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr5617713wmc.5.1647550572934;
        Thu, 17 Mar 2022 13:56:12 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:12 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 02/19] crypto: sun8i-ce: do not allocate memory when handling requests
Date:   Thu, 17 Mar 2022 20:55:48 +0000
Message-Id: <20220317205605.3924836-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317205605.3924836-1-clabbe@baylibre.com>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocate memory on each requests, it is easier to
pre-allocate buffer for IV.
This made error path easier.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 29 ++++++-------------
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 20 ++++++++++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  8 ++---
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 01d032e08825..0b1ce58bdeb9 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -152,23 +152,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	ivsize = crypto_skcipher_ivsize(tfm);
 	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
 		rctx->ivlen = ivsize;
-		rctx->bounce_iv = kzalloc(ivsize, GFP_KERNEL | GFP_DMA);
-		if (!rctx->bounce_iv) {
-			err = -ENOMEM;
-			goto theend_key;
-		}
 		if (rctx->op_dir & CE_DECRYPTION) {
-			rctx->backup_iv = kzalloc(ivsize, GFP_KERNEL);
-			if (!rctx->backup_iv) {
-				err = -ENOMEM;
-				goto theend_key;
-			}
 			offset = areq->cryptlen - ivsize;
-			scatterwalk_map_and_copy(rctx->backup_iv, areq->src,
+			scatterwalk_map_and_copy(chan->backup_iv, areq->src,
 						 offset, ivsize, 0);
 		}
-		memcpy(rctx->bounce_iv, areq->iv, ivsize);
-		rctx->addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen,
+		memcpy(chan->bounce_iv, areq->iv, ivsize);
+		rctx->addr_iv = dma_map_single(ce->dev, chan->bounce_iv, rctx->ivlen,
 					       DMA_TO_DEVICE);
 		if (dma_mapping_error(ce->dev, rctx->addr_iv)) {
 			dev_err(ce->dev, "Cannot DMA MAP IV\n");
@@ -257,16 +247,15 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 			dma_unmap_single(ce->dev, rctx->addr_iv, rctx->ivlen, DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
-			memcpy(areq->iv, rctx->backup_iv, ivsize);
-			kfree_sensitive(rctx->backup_iv);
+			memcpy(areq->iv, chan->backup_iv, ivsize);
+			memzero_explicit(chan->backup_iv, ivsize);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
 						 ivsize, 0);
 		}
-		kfree(rctx->bounce_iv);
+		memzero_explicit(chan->bounce_iv, ivsize);
 	}
 
-theend_key:
 	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
 
 theend:
@@ -322,13 +311,13 @@ static int sun8i_ce_cipher_unprepare(struct crypto_engine *engine, void *async_r
 			dma_unmap_single(ce->dev, rctx->addr_iv, rctx->ivlen, DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
-			memcpy(areq->iv, rctx->backup_iv, ivsize);
-			kfree_sensitive(rctx->backup_iv);
+			memcpy(areq->iv, chan->backup_iv, ivsize);
+			memzero_explicit(chan->backup_iv, ivsize);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
 						 ivsize, 0);
 		}
-		kfree(rctx->bounce_iv);
+		memzero_explicit(chan->bounce_iv, ivsize);
 	}
 
 	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 8be27a462784..8f902607af68 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -305,7 +305,7 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 			.cra_priority = 400,
 			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+				CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_NEED_FALLBACK,
 			.cra_ctxsize = sizeof(struct sun8i_cipher_tfm_ctx),
 			.cra_module = THIS_MODULE,
@@ -332,7 +332,7 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 			.cra_priority = 400,
 			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+				CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_NEED_FALLBACK,
 			.cra_ctxsize = sizeof(struct sun8i_cipher_tfm_ctx),
 			.cra_module = THIS_MODULE,
@@ -358,7 +358,7 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 			.cra_priority = 400,
 			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+				CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_NEED_FALLBACK,
 			.cra_ctxsize = sizeof(struct sun8i_cipher_tfm_ctx),
 			.cra_module = THIS_MODULE,
@@ -385,7 +385,7 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 			.cra_priority = 400,
 			.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+				CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_NEED_FALLBACK,
 			.cra_ctxsize = sizeof(struct sun8i_cipher_tfm_ctx),
 			.cra_module = THIS_MODULE,
@@ -728,6 +728,18 @@ static int sun8i_ce_allocate_chanlist(struct sun8i_ce_dev *ce)
 			err = -ENOMEM;
 			goto error_engine;
 		}
+		ce->chanlist[i].bounce_iv = devm_kmalloc(ce->dev, AES_BLOCK_SIZE,
+							 GFP_KERNEL | GFP_DMA);
+		if (!ce->chanlist[i].bounce_iv) {
+			err = -ENOMEM;
+			goto error_engine;
+		}
+		ce->chanlist[i].backup_iv = devm_kmalloc(ce->dev, AES_BLOCK_SIZE,
+							 GFP_KERNEL);
+		if (!ce->chanlist[i].backup_iv) {
+			err = -ENOMEM;
+			goto error_engine;
+		}
 	}
 	return 0;
 error_engine:
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 719f9a730857..229b696d5a2c 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -213,6 +213,8 @@ struct ce_task {
  * @status:	set to 1 by interrupt if task is done
  * @t_phy:	Physical address of task
  * @tl:		pointer to the current ce_task for this flow
+ * @backup_iv:		buffer which contain the next IV to store
+ * @bounce_iv:		buffer which contain the IV
  * @stat_req:	number of request done by this flow
  */
 struct sun8i_ce_flow {
@@ -222,6 +224,8 @@ struct sun8i_ce_flow {
 	dma_addr_t t_phy;
 	int timeout;
 	struct ce_task *tl;
+	void *backup_iv;
+	void *bounce_iv;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
 #endif
@@ -268,8 +272,6 @@ struct sun8i_ce_dev {
  * struct sun8i_cipher_req_ctx - context for a skcipher request
  * @op_dir:		direction (encrypt vs decrypt) for this request
  * @flow:		the flow to use for this request
- * @backup_iv:		buffer which contain the next IV to store
- * @bounce_iv:		buffer which contain the IV
  * @ivlen:		size of bounce_iv
  * @nr_sgs:		The number of source SG (as given by dma_map_sg())
  * @nr_sgd:		The number of destination SG (as given by dma_map_sg())
@@ -280,8 +282,6 @@ struct sun8i_ce_dev {
 struct sun8i_cipher_req_ctx {
 	u32 op_dir;
 	int flow;
-	void *backup_iv;
-	void *bounce_iv;
 	unsigned int ivlen;
 	int nr_sgs;
 	int nr_sgd;
-- 
2.34.1

