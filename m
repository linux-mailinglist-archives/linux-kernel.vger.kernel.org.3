Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEA517807
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387332AbiEBU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387388AbiEBUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADFDF53
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so199618wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAlxpxtKQhhpisN+Py9FmMy6YuYBERKDhwqtKZhDyAo=;
        b=7CxxjDPMlkrl47HfZLfw+apLCpYM7mixUq10gF5lhfeVCZf15cvn3IeV8QRyP1PCNI
         7FQ/x9VR9CP27aGcvrFWNYWIRZZ0tJDx33/fCzhxZacBHsF7TGu52mxPKKyC6O5yPUcH
         T63N6eowyYpxt/O9gUU9I6YBNHQSO84vLlaAEWvwXi+QDgM09ETsFhiRfjVBegVuGCBc
         iU796qGpodTLwv4wBv+YVCLKGDZDBXcw9ChnCL09nMpItDya7obq0XaM5SdZgEiqyUEr
         paAP2RiaKK3hh8ZlJQTX7VrZ2Qd8LdrMHUVZfUd46WJA/jqBoxJdJKua2BefO5d+jDDm
         9paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAlxpxtKQhhpisN+Py9FmMy6YuYBERKDhwqtKZhDyAo=;
        b=2gQqiIYcnJAqR5HD/TzXoScyProCv16tx7Y8pjDS67fmPvajruJcrxZh1oDaX7cqeU
         PV/veZ/wQM4LrGclx/fanUIr1nHm6LZXoJqlRhlQ/ylvDO3BTiquPuhrXEDdXtNn+RUs
         Uq6TP4HjHeNbthaFJ96XqdDYCFFQZwDISsnVU00qxVXfkMKB+HQ4rER4T2nmYWm15wZK
         E4C/fOx6GkynaoMOBIwTbrAKj+pm1kd9KGuQNlYptjhrYm6ExawOjtKMpbgTM0VwI06a
         j1iJhoQ0cpaRQp1EnR1eyS//62LO+xyi8G7XsrtarG+kktsMY3jvDvF0nAapsuzvUrw1
         zIkw==
X-Gm-Message-State: AOAM530bP3mtrvf1zowgyjqDSnAF+F8+Ytu/u6i/GFKHNwYZ1lSsK02k
        gqvBqw7Ui3E/jMMU/JmrwdXrmQ==
X-Google-Smtp-Source: ABdhPJx/dcGNqbDujavfd8x+wU3TmwxeTY3wHMU8vzvobp3llcvksQL8P3JWf8YejFfl8OahCSnDOg==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr599919wma.108.1651522794849;
        Mon, 02 May 2022 13:19:54 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 14/19] crypto: sun8i-ss: add hmac(sha1)
Date:   Mon,  2 May 2022 20:19:24 +0000
Message-Id: <20220502201929.843194-15-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502201929.843194-1-clabbe@baylibre.com>
References: <20220502201929.843194-1-clabbe@baylibre.com>
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

Even if sun8i-ss does not handle hmac(sha1) directly, we can provide one
which use the already supported acceleration of sha1.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  31 +++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 200 +++++++++++++++++-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |   6 +
 3 files changed, 231 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index f09de5737e8b..98593a0cff69 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -409,6 +409,37 @@ static struct sun8i_ss_alg_template ss_algs[] = {
 		}
 	}
 },
+{	.type = CRYPTO_ALG_TYPE_AHASH,
+	.ss_algo_id = SS_ID_HASH_SHA1,
+	.alg.hash = {
+		.init = sun8i_ss_hash_init,
+		.update = sun8i_ss_hash_update,
+		.final = sun8i_ss_hash_final,
+		.finup = sun8i_ss_hash_finup,
+		.digest = sun8i_ss_hash_digest,
+		.export = sun8i_ss_hash_export,
+		.import = sun8i_ss_hash_import,
+		.setkey = sun8i_ss_hmac_setkey,
+		.halg = {
+			.digestsize = SHA1_DIGEST_SIZE,
+			.statesize = sizeof(struct sha1_state),
+			.base = {
+				.cra_name = "hmac(sha1)",
+				.cra_driver_name = "hmac-sha1-sun8i-ss",
+				.cra_priority = 300,
+				.cra_alignmask = 3,
+				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
+					CRYPTO_ALG_ASYNC |
+					CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize = SHA1_BLOCK_SIZE,
+				.cra_ctxsize = sizeof(struct sun8i_ss_hash_tfm_ctx),
+				.cra_module = THIS_MODULE,
+				.cra_init = sun8i_ss_hash_crainit,
+				.cra_exit = sun8i_ss_hash_craexit,
+			}
+		}
+	}
+},
 #endif
 };
 
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 0db1e8253667..ac417a6b39e5 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -14,12 +14,99 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <crypto/internal/hash.h>
+#include <crypto/hmac.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/sha1.h>
 #include <crypto/sha2.h>
 #include <crypto/md5.h>
 #include "sun8i-ss.h"
 
+static int sun8i_ss_hashkey(struct sun8i_ss_hash_tfm_ctx *tfmctx, const u8 *key,
+			    unsigned int keylen)
+{
+	struct crypto_shash *xtfm;
+	struct shash_desc *sdesc;
+	size_t len;
+	int ret = 0;
+
+	xtfm = crypto_alloc_shash("sha1", 0, CRYPTO_ALG_NEED_FALLBACK);
+	if (!xtfm)
+		return -ENOMEM;
+
+	len = sizeof(*sdesc) + crypto_shash_descsize(xtfm);
+	sdesc = kmalloc(len, GFP_KERNEL);
+	if (!sdesc) {
+		ret = -ENOMEM;
+		goto err_hashkey_sdesc;
+	}
+	sdesc->tfm = xtfm;
+
+	ret = crypto_shash_init(sdesc);
+	if (ret) {
+		dev_err(tfmctx->ss->dev, "shash init error ret=%d\n", ret);
+		goto err_hashkey;
+	}
+	ret = crypto_shash_finup(sdesc, key, keylen, tfmctx->key);
+	if (ret)
+		dev_err(tfmctx->ss->dev, "shash finup error\n");
+err_hashkey:
+	kfree(sdesc);
+err_hashkey_sdesc:
+	crypto_free_shash(xtfm);
+	return ret;
+}
+
+int sun8i_ss_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
+			 unsigned int keylen)
+{
+	struct sun8i_ss_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(ahash);
+	struct ahash_alg *alg = __crypto_ahash_alg(ahash->base.__crt_alg);
+	struct sun8i_ss_alg_template *algt;
+	int digestsize, i;
+	int bs = crypto_ahash_blocksize(ahash);
+	int ret;
+
+	algt = container_of(alg, struct sun8i_ss_alg_template, alg.hash);
+	digestsize = algt->alg.hash.halg.digestsize;
+
+	if (keylen > bs) {
+		ret = sun8i_ss_hashkey(tfmctx, key, keylen);
+		if (ret)
+			return ret;
+		tfmctx->keylen = digestsize;
+	} else {
+		tfmctx->keylen = keylen;
+		memcpy(tfmctx->key, key, keylen);
+	}
+
+	tfmctx->ipad = kzalloc(bs, GFP_KERNEL | GFP_DMA);
+	if (!tfmctx->ipad)
+		return -ENOMEM;
+	tfmctx->opad = kzalloc(bs, GFP_KERNEL | GFP_DMA);
+	if (!tfmctx->opad) {
+		ret = -ENOMEM;
+		goto err_opad;
+	}
+
+	memset(tfmctx->key + tfmctx->keylen, 0, bs - tfmctx->keylen);
+	memcpy(tfmctx->ipad, tfmctx->key, tfmctx->keylen);
+	memcpy(tfmctx->opad, tfmctx->key, tfmctx->keylen);
+	for (i = 0; i < bs; i++) {
+		tfmctx->ipad[i] ^= HMAC_IPAD_VALUE;
+		tfmctx->opad[i] ^= HMAC_OPAD_VALUE;
+	}
+
+	ret = crypto_ahash_setkey(tfmctx->fallback_tfm, key, keylen);
+	if (!ret)
+		return 0;
+
+	memzero_explicit(tfmctx->key, keylen);
+	kfree_sensitive(tfmctx->opad);
+err_opad:
+	kfree_sensitive(tfmctx->ipad);
+	return ret;
+}
+
 int sun8i_ss_hash_crainit(struct crypto_tfm *tfm)
 {
 	struct sun8i_ss_hash_tfm_ctx *op = crypto_tfm_ctx(tfm);
@@ -67,6 +154,9 @@ void sun8i_ss_hash_craexit(struct crypto_tfm *tfm)
 {
 	struct sun8i_ss_hash_tfm_ctx *tfmctx = crypto_tfm_ctx(tfm);
 
+	kfree_sensitive(tfmctx->ipad);
+	kfree_sensitive(tfmctx->opad);
+
 	crypto_free_ahash(tfmctx->fallback_tfm);
 	pm_runtime_put_sync_suspend(tfmctx->ss->dev);
 }
@@ -393,18 +483,26 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 {
 	struct ahash_request *areq = container_of(breq, struct ahash_request, base);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct sun8i_ss_hash_tfm_ctx *tfmctx = crypto_ahash_ctx(tfm);
 	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
 	struct sun8i_ss_hash_reqctx *rctx = ahash_request_ctx(areq);
 	struct sun8i_ss_alg_template *algt;
 	struct sun8i_ss_dev *ss;
 	struct scatterlist *sg;
+	int bs = crypto_ahash_blocksize(tfm);
 	int nr_sgs, err, digestsize;
 	unsigned int len;
 	u64 byte_count;
 	void *pad, *result;
 	int j, i, k, todo;
-	dma_addr_t addr_res, addr_pad;
+	dma_addr_t addr_res, addr_pad, addr_xpad;
 	__le32 *bf;
+	/* HMAC step:
+	 * 0: normal hashing
+	 * 1: IPAD
+	 * 2: OPAD
+	 */
+	int hmac = 0;
 
 	algt = container_of(alg, struct sun8i_ss_alg_template, alg.hash);
 	ss = algt->ss;
@@ -439,7 +537,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	if (dma_mapping_error(ss->dev, addr_res)) {
 		dev_err(ss->dev, "DMA map dest\n");
 		err = -EINVAL;
-		goto theend;
+		goto err_dma_result;
 	}
 
 	j = 0;
@@ -476,7 +574,60 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	if (j > 0)
 		i--;
 
+retry:
 	byte_count = areq->nbytes;
+	if (tfmctx->keylen && hmac == 0) {
+		hmac = 1;
+		/* shift all SG one slot up, to free slot 0 for IPAD */
+		for (k = 6; k >= 0; k--) {
+			rctx->t_src[k + 1].addr = rctx->t_src[k].addr;
+			rctx->t_src[k + 1].len = rctx->t_src[k].len;
+			rctx->t_dst[k + 1].addr = rctx->t_dst[k].addr;
+			rctx->t_dst[k + 1].len = rctx->t_dst[k].len;
+		}
+		addr_xpad = dma_map_single(ss->dev, tfmctx->ipad, bs, DMA_TO_DEVICE);
+		if (dma_mapping_error(ss->dev, addr_xpad)) {
+			dev_err(ss->dev, "Fail to create DMA mapping of ipad\n");
+			goto err_dma_xpad;
+		}
+		rctx->t_src[0].addr = addr_xpad;
+		rctx->t_src[0].len = bs / 4;
+		rctx->t_dst[0].addr = addr_res;
+		rctx->t_dst[0].len = digestsize / 4;
+		i++;
+		byte_count = areq->nbytes + bs;
+	}
+	if (tfmctx->keylen && hmac == 2) {
+		for (i = 0; i < MAX_SG; i++) {
+			rctx->t_src[i].addr = 0;
+			rctx->t_src[i].len = 0;
+			rctx->t_dst[i].addr = 0;
+			rctx->t_dst[i].len = 0;
+		}
+
+		addr_res = dma_map_single(ss->dev, result, digestsize, DMA_FROM_DEVICE);
+		if (dma_mapping_error(ss->dev, addr_res)) {
+			dev_err(ss->dev, "Fail to create DMA mapping of result\n");
+			err = -EINVAL;
+			goto err_dma_result;
+		}
+		addr_xpad = dma_map_single(ss->dev, tfmctx->opad, bs, DMA_TO_DEVICE);
+		if (dma_mapping_error(ss->dev, addr_xpad)) {
+			dev_err(ss->dev, "Fail to create DMA mapping of opad\n");
+			goto err_dma_xpad;
+		}
+		rctx->t_src[0].addr = addr_xpad;
+		rctx->t_src[0].len = bs / 4;
+
+		memcpy(bf, result, digestsize);
+		j = digestsize / 4;
+		i = 1;
+		byte_count = digestsize + bs;
+
+		rctx->t_dst[0].addr = addr_res;
+		rctx->t_dst[0].len = digestsize / 4;
+	}
+
 	switch (algt->ss_algo_id) {
 	case SS_ID_HASH_MD5:
 		j = hash_pad(bf, 4096, j, byte_count, true, bs);
@@ -496,7 +647,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	if (dma_mapping_error(ss->dev, addr_pad)) {
 		dev_err(ss->dev, "DMA error on padding SG\n");
 		err = -EINVAL;
-		goto theend;
+		goto err_dma_pad;
 	}
 	rctx->t_src[i].addr = addr_pad;
 	rctx->t_src[i].len = j;
@@ -505,12 +656,49 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 
 	err = sun8i_ss_run_hash_task(ss, rctx, crypto_tfm_alg_name(areq->base.tfm));
 
+	/*
+	 * mini helper for checking dma map/unmap
+	 * flow start for hmac = 0 (and HMAC = 1)
+	 * HMAC = 0
+	 * MAP src
+	 * MAP res
+	 *
+	 * retry:
+	 * if hmac then hmac = 1
+	 *	MAP xpad (ipad)
+	 * if hmac == 2
+	 *	MAP res
+	 *	MAP xpad (opad)
+	 * MAP pad
+	 * ACTION!
+	 * UNMAP pad
+	 * if hmac
+	 *	UNMAP xpad
+	 * UNMAP res
+	 * if hmac < 2
+	 *	UNMAP SRC
+	 *
+	 * if hmac = 1 then hmac = 2 goto retry
+	 */
+
 	dma_unmap_single(ss->dev, addr_pad, j * 4, DMA_TO_DEVICE);
-	dma_unmap_sg(ss->dev, areq->src, sg_nents(areq->src),
-		     DMA_TO_DEVICE);
+
+err_dma_pad:
+	if (hmac > 0)
+		dma_unmap_single(ss->dev, addr_xpad, bs, DMA_TO_DEVICE);
+err_dma_xpad:
 	dma_unmap_single(ss->dev, addr_res, digestsize, DMA_FROM_DEVICE);
+err_dma_result:
+	if (hmac < 2)
+		dma_unmap_sg(ss->dev, areq->src, sg_nents(areq->src),
+			     DMA_TO_DEVICE);
+	if (hmac == 1 && !err) {
+		hmac = 2;
+		goto retry;
+	}
 
-	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
+	if (!err)
+		memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
 theend:
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index b56038de333b..df6f08f6092f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -239,6 +239,10 @@ struct sun8i_ss_hash_tfm_ctx {
 	struct crypto_engine_ctx enginectx;
 	struct crypto_ahash *fallback_tfm;
 	struct sun8i_ss_dev *ss;
+	u8 *ipad;
+	u8 *opad;
+	u8 key[SHA256_BLOCK_SIZE];
+	int keylen;
 };
 
 /*
@@ -319,3 +323,5 @@ int sun8i_ss_hash_update(struct ahash_request *areq);
 int sun8i_ss_hash_finup(struct ahash_request *areq);
 int sun8i_ss_hash_digest(struct ahash_request *areq);
 int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq);
+int sun8i_ss_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
+			 unsigned int keylen);
-- 
2.35.1

