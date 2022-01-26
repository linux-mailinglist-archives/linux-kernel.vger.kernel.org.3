Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05E49D405
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiAZVE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiAZVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E8C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r7so502895wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWL8x42G4N1mlzu+WAhCp4FrFZgbOxSegmwVdqQbXCc=;
        b=c9QwSRmxbkHtqyg3Uh1XyeWdr/bT2I/i1Hji99sMoRdk7hEvZYnwb3+zsdZBEjgTsD
         jMKZBuZqN31tOjUY8FtDuMKFvr3PdPRk2D3bIkcAcHKdVM1DMKJGLGoD2Z5+3gEPeWNx
         d3nnBGkxqeEnRyepp8lggh0qWR/VvdVo6jW4CbpFNbN8L/3drOzJNsUd4ASyuiMip7F2
         yHqE7+7K5Fg249794TBd2CYythGOb4m8Vus9fok28hpCNTk7qj7zjOEa9G0Sml9mda0I
         DazCF0Xe+FvCDxD23jQnrW6QDjgRIjZwWPm1twk/D3cBt+beDfgSMUMF7tp56MT8G34c
         6QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWL8x42G4N1mlzu+WAhCp4FrFZgbOxSegmwVdqQbXCc=;
        b=ipNPEYGnftlws8ZzJ6bHoynB501zLJ7vgVNZpzNFugVCzTbg2STcP6Poigb7PZg611
         +1p1Gjm5QbgRw8lyEjZccyoJnHsBm0PcpzMZEUOGxskT+LcnQkyDf6RBem1sI0XydIuu
         5DATdMnKDIveTwy6PRY1zoZtdFZXIjXFRJGiqCiFUMtVeVrf6MnFvkyHbJXqOuL8WHfh
         0KnIBxJUjP9nim6R2+O7FY7fKuPJCEMKg6oyFYGH4lS0BSE6xlm89jDEfgXETlw1U/gV
         ey6ubi0WVDuSndc8JulxhVLRXk5rKlxBUSd5rAfH+GTGHDAx5xmgMr/VdaZSB2G4SsC+
         xb3g==
X-Gm-Message-State: AOAM5327SZ84lI5StiRXCL3MfVSxb6emWUz85nIURRKU7xiCbdOvBBjJ
        X52maATZWimRwxxXCZglUy8O4g==
X-Google-Smtp-Source: ABdhPJymHTxLjf2FgxbjiTu/XUpjTu+pXwe1QOMFEwpsZ+dU33AWK0VJw4YCcEvVi4G9m7gVdpSZpA==
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr8804315wmb.43.1643231090439;
        Wed, 26 Jan 2022 13:04:50 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:49 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/8] crypto: sun8i-ce: do not allocate memory when handling requests
Date:   Wed, 26 Jan 2022 21:04:34 +0000
Message-Id: <20220126210441.3661782-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126210441.3661782-1-clabbe@baylibre.com>
References: <20220126210441.3661782-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocate memory on each requests, it is easier to
pre-allocate buffer for IV.
This made error path easier.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 28 ++++++-------------
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 20 ++++++++++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  8 +++---
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 8f0031e45a03..f4221025d651 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -151,23 +151,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
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
@@ -256,13 +246,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
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
 
 theend_key:
@@ -319,13 +309,13 @@ static int sun8i_ce_cipher_unprepare(struct crypto_engine *engine, void *async_r
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
index ea2c655e4ff1..b57aed120d33 100644
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

