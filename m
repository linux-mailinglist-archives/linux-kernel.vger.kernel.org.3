Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC455177F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387356AbiEBUXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387298AbiEBUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A0DF2E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so20899109wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JELRq3WIzD/2Al+0unO0twKegBQk0dtbra5g2DiHmA8=;
        b=jZ9zEjpnNJpUrkFNzIF8fHW544R2fsU5GZOGzjVgtTiNXEK/50GEAIkpPkfEHA7D6x
         7sVLMbDUasymGIMNVLvHxC8w5otgxDVtOh9Qf5GOFJ+/zm60EMla8BkJkhXTIJ24kUll
         Y/HWy1J5w7yWa/iMIbXa1a6gVfLHNqsW47XWGM+sUt7Cmwrir1joZa+VLOarTYfcnMMN
         6w69Idrbu8et2GGrHbVgqfEKgfV6Ch+I5l3CzN8vUGH8ossVWijIOZ4H+2svdcysXNq1
         4O4tO7KTaolG/HAQV7cSb/pKgIgLMgXCC98ujz0+JqABt/wpEZHHI8TzLq46nYTGzvfT
         7Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JELRq3WIzD/2Al+0unO0twKegBQk0dtbra5g2DiHmA8=;
        b=Ow+yLDGSTJ0QJwI1xC0Zy+k/mNzK40YSl4bwi5FSxyJO61ZHa52mYYGLD/l1estL06
         1IlRbgOd7zPeJET66FRaV3Fj/tvvW+tHw3uJog7sd2VJ3uTgELKslRK1igShuC65BYB0
         aNg3CypS2AJTtDkUUXjvl+X+wE5UeMo+X/2hbARVAP2elgOFXZtETiOuSkBcNpER3ynd
         mJtAr8XQqStuTUgAHn9Ad7/Fr2nIT+hYBw4fTg8FxM2RMdCpc6biMxA7sOaH5os10sHo
         0fzrPmDu2fogz+/8pxb1cQp3IdW5eROIU+y5eUULL7WiA9RmeHUYbniMT954M3GZOlDi
         IBNA==
X-Gm-Message-State: AOAM532M+ilAi0hLimX7/cBEQuSqJa5Nh+wDneMtEuOhwlRAG6pk92gB
        7WOHeyLl+wgDk+xf6j9AnZYaPw==
X-Google-Smtp-Source: ABdhPJxUF4tt0QPpo0SzqYKZgfMV8xnAc5qgyddGFC9frGOUuzZSvi0ykBBkYbHfOrFzgJO+69kw8w==
X-Received: by 2002:a5d:4008:0:b0:20a:ea86:e101 with SMTP id n8-20020a5d4008000000b0020aea86e101mr10809038wrp.141.1651522784101;
        Mon, 02 May 2022 13:19:44 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 04/19] crypto: sun8i-ss: rework handling of IV
Date:   Mon,  2 May 2022 20:19:14 +0000
Message-Id: <20220502201929.843194-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502201929.843194-1-clabbe@baylibre.com>
References: <20220502201929.843194-1-clabbe@baylibre.com>
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

sun8i-ss fail handling IVs when doing decryption of multiple SGs in-place.
It should backup the last block of each SG source for using it later as
IVs.
In the same time remove allocation on requests path for storing all
IVs.

Fixes: f08fcced6d00 ("crypto: allwinner - Add sun8i-ss cryptographic offloader")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ss/sun8i-ss-cipher.c      | 115 ++++++++++++------
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  30 +++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  14 ++-
 3 files changed, 107 insertions(+), 52 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 554e400d41ca..70e2e6e37389 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -93,6 +93,68 @@ static int sun8i_ss_cipher_fallback(struct skcipher_request *areq)
 	return err;
 }
 
+static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct sun8i_ss_dev *ss = op->ss;
+	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
+	struct scatterlist *sg = areq->src;
+	unsigned int todo, offset;
+	unsigned int len = areq->cryptlen;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	struct sun8i_ss_flow *sf = &ss->flows[rctx->flow];
+	int i = 0;
+	u32 a;
+	int err;
+
+	rctx->ivlen = ivsize;
+	if (rctx->op_dir & SS_DECRYPTION) {
+		offset = areq->cryptlen - ivsize;
+		scatterwalk_map_and_copy(sf->biv, areq->src, offset,
+					 ivsize, 0);
+	}
+
+	/* we need to copy all IVs from source in case DMA is bi-directionnal */
+	while (sg && len) {
+		if (sg_dma_len(sg) == 0) {
+			sg = sg_next(sg);
+			continue;
+		}
+		if (i == 0)
+			memcpy(sf->iv[0], areq->iv, ivsize);
+		a = dma_map_single(ss->dev, sf->iv[i], ivsize, DMA_TO_DEVICE);
+		if (dma_mapping_error(ss->dev, a)) {
+			memzero_explicit(sf->iv[i], ivsize);
+			dev_err(ss->dev, "Cannot DMA MAP IV\n");
+			err = -EFAULT;
+			goto dma_iv_error;
+		}
+		rctx->p_iv[i] = a;
+		/* we need to setup all others IVs only in the decrypt way */
+		if (rctx->op_dir & SS_ENCRYPTION)
+			return 0;
+		todo = min(len, sg_dma_len(sg));
+		len -= todo;
+		i++;
+		if (i < MAX_SG) {
+			offset = sg->length - ivsize;
+			scatterwalk_map_and_copy(sf->iv[i], sg, offset, ivsize, 0);
+		}
+		rctx->niv = i;
+		sg = sg_next(sg);
+	}
+
+	return 0;
+dma_iv_error:
+	i--;
+	while (i >= 0) {
+		dma_unmap_single(ss->dev, rctx->p_iv[i], ivsize, DMA_TO_DEVICE);
+		memzero_explicit(sf->iv[i], ivsize);
+	}
+	return err;
+}
+
 static int sun8i_ss_cipher(struct skcipher_request *areq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
@@ -101,9 +163,9 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct sun8i_ss_alg_template *algt;
+	struct sun8i_ss_flow *sf = &ss->flows[rctx->flow];
 	struct scatterlist *sg;
 	unsigned int todo, len, offset, ivsize;
-	void *backup_iv = NULL;
 	int nr_sgs = 0;
 	int nr_sgd = 0;
 	int err = 0;
@@ -134,30 +196,9 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 
 	ivsize = crypto_skcipher_ivsize(tfm);
 	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
-		rctx->ivlen = ivsize;
-		rctx->biv = kzalloc(ivsize, GFP_KERNEL | GFP_DMA);
-		if (!rctx->biv) {
-			err = -ENOMEM;
+		err = sun8i_ss_setup_ivs(areq);
+		if (err)
 			goto theend_key;
-		}
-		if (rctx->op_dir & SS_DECRYPTION) {
-			backup_iv = kzalloc(ivsize, GFP_KERNEL);
-			if (!backup_iv) {
-				err = -ENOMEM;
-				goto theend_key;
-			}
-			offset = areq->cryptlen - ivsize;
-			scatterwalk_map_and_copy(backup_iv, areq->src, offset,
-						 ivsize, 0);
-		}
-		memcpy(rctx->biv, areq->iv, ivsize);
-		rctx->p_iv = dma_map_single(ss->dev, rctx->biv, rctx->ivlen,
-					    DMA_TO_DEVICE);
-		if (dma_mapping_error(ss->dev, rctx->p_iv)) {
-			dev_err(ss->dev, "Cannot DMA MAP IV\n");
-			err = -ENOMEM;
-			goto theend_iv;
-		}
 	}
 	if (areq->src == areq->dst) {
 		nr_sgs = dma_map_sg(ss->dev, areq->src, sg_nents(areq->src),
@@ -243,21 +284,19 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 	}
 
 theend_iv:
-	if (rctx->p_iv)
-		dma_unmap_single(ss->dev, rctx->p_iv, rctx->ivlen,
-				 DMA_TO_DEVICE);
-
 	if (areq->iv && ivsize > 0) {
-		if (rctx->biv) {
-			offset = areq->cryptlen - ivsize;
-			if (rctx->op_dir & SS_DECRYPTION) {
-				memcpy(areq->iv, backup_iv, ivsize);
-				kfree_sensitive(backup_iv);
-			} else {
-				scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
-							 ivsize, 0);
-			}
-			kfree(rctx->biv);
+		for (i = 0; i < rctx->niv; i++) {
+			dma_unmap_single(ss->dev, rctx->p_iv[i], ivsize, DMA_TO_DEVICE);
+			memzero_explicit(sf->iv[i], ivsize);
+		}
+
+		offset = areq->cryptlen - ivsize;
+		if (rctx->op_dir & SS_DECRYPTION) {
+			memcpy(areq->iv, sf->biv, ivsize);
+			memzero_explicit(sf->biv, ivsize);
+		} else {
+			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
+					ivsize, 0);
 		}
 	}
 
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 319fe3279a71..657530578643 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -66,6 +66,7 @@ int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx
 		      const char *name)
 {
 	int flow = rctx->flow;
+	unsigned int ivlen = rctx->ivlen;
 	u32 v = SS_START;
 	int i;
 
@@ -104,15 +105,14 @@ int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx
 		mutex_lock(&ss->mlock);
 		writel(rctx->p_key, ss->base + SS_KEY_ADR_REG);
 
-		if (i == 0) {
-			if (rctx->p_iv)
-				writel(rctx->p_iv, ss->base + SS_IV_ADR_REG);
-		} else {
-			if (rctx->biv) {
-				if (rctx->op_dir == SS_ENCRYPTION)
-					writel(rctx->t_dst[i - 1].addr + rctx->t_dst[i - 1].len * 4 - rctx->ivlen, ss->base + SS_IV_ADR_REG);
+		if (ivlen) {
+			if (rctx->op_dir == SS_ENCRYPTION) {
+				if (i == 0)
+					writel(rctx->p_iv[0], ss->base + SS_IV_ADR_REG);
 				else
-					writel(rctx->t_src[i - 1].addr + rctx->t_src[i - 1].len * 4 - rctx->ivlen, ss->base + SS_IV_ADR_REG);
+					writel(rctx->t_dst[i - 1].addr + rctx->t_dst[i - 1].len * 4 - ivlen, ss->base + SS_IV_ADR_REG);
+			} else {
+				writel(rctx->p_iv[i], ss->base + SS_IV_ADR_REG);
 			}
 		}
 
@@ -464,7 +464,7 @@ static void sun8i_ss_free_flows(struct sun8i_ss_dev *ss, int i)
  */
 static int allocate_flows(struct sun8i_ss_dev *ss)
 {
-	int i, err;
+	int i, j, err;
 
 	ss->flows = devm_kcalloc(ss->dev, MAXFLOW, sizeof(struct sun8i_ss_flow),
 				 GFP_KERNEL);
@@ -474,6 +474,18 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 	for (i = 0; i < MAXFLOW; i++) {
 		init_completion(&ss->flows[i].complete);
 
+		ss->flows[i].biv = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
+						GFP_KERNEL | GFP_DMA);
+		if (!ss->flows[i].biv)
+			goto error_engine;
+
+		for (j = 0; j < MAX_SG; j++) {
+			ss->flows[i].iv[j] = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
+							  GFP_KERNEL | GFP_DMA);
+			if (!ss->flows[i].iv[j])
+				goto error_engine;
+		}
+
 		ss->flows[i].engine = crypto_engine_alloc_init(ss->dev, true);
 		if (!ss->flows[i].engine) {
 			dev_err(ss->dev, "Cannot allocate engine\n");
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 28188685b910..57ada8653855 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -121,11 +121,15 @@ struct sginfo {
  * @complete:	completion for the current task on this flow
  * @status:	set to 1 by interrupt if task is done
  * @stat_req:	number of request done by this flow
+ * @iv:		list of IV to use for each step
+ * @biv:	buffer which contain the backuped IV
  */
 struct sun8i_ss_flow {
 	struct crypto_engine *engine;
 	struct completion complete;
 	int status;
+	u8 *iv[MAX_SG];
+	u8 *biv;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
 	unsigned long stat_req;
 #endif
@@ -164,28 +168,28 @@ struct sun8i_ss_dev {
  * @t_src:		list of mapped SGs with their size
  * @t_dst:		list of mapped SGs with their size
  * @p_key:		DMA address of the key
- * @p_iv:		DMA address of the IV
+ * @p_iv:		DMA address of the IVs
+ * @niv:		Number of IVs DMA mapped
  * @method:		current algorithm for this request
  * @op_mode:		op_mode for this request
  * @op_dir:		direction (encrypt vs decrypt) for this request
  * @flow:		the flow to use for this request
- * @ivlen:		size of biv
+ * @ivlen:		size of IVs
  * @keylen:		keylen for this request
- * @biv:		buffer which contain the IV
  * @fallback_req:	request struct for invoking the fallback skcipher TFM
  */
 struct sun8i_cipher_req_ctx {
 	struct sginfo t_src[MAX_SG];
 	struct sginfo t_dst[MAX_SG];
 	u32 p_key;
-	u32 p_iv;
+	u32 p_iv[MAX_SG];
+	int niv;
 	u32 method;
 	u32 op_mode;
 	u32 op_dir;
 	int flow;
 	unsigned int ivlen;
 	unsigned int keylen;
-	void *biv;
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
-- 
2.35.1

