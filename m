Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2194251EF77
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiEHTKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiEHTEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC3DF8A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c11so16688955wrn.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJnJqffMjaG0ri/QRclvSYw2aUWdoPTVCuwI5Qrju5o=;
        b=ztecDkEDQVW9swES33Zxkc/6I7g49BkwMRZt1vJ2U8CBwU3r4/F5eQrdiCkF6NQfyu
         R998MS22VyQO4ysK0xmUiq9seVX5qL2fu0xQjfZ25Izze7I86bvU/AOwDz+TA2MmKoZb
         q7UowxhniykSRFgRZZDqd1QzRULYxuYwCC06aqZOeSDHrR/tbMtJUVNPoOAePOiDnx6/
         zpeZmPRXOew4eZoVcSje9VjPILN27vZDAzIpbXAPgy7wnvDDZ506jTLMIogcS661bZRD
         oiT96O9zFwe93/9kZbgBJ3+tSinlwAcE5/KLKqSOgzudRluFO8QPqyF7Er2EsgAkVba9
         uVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJnJqffMjaG0ri/QRclvSYw2aUWdoPTVCuwI5Qrju5o=;
        b=t0L9lrcIKAQkHqLZy6BBOjea2TbvCuPPEbTDo6YTesOODKVv1unrZMw8ITZOPrRTVO
         T+bpqErx+qo0nTGD5O7vC68a4exXIX0HiAJhldrB1evsY5TF44sVS7mQYSTSjrYbp78g
         hKa6LCxeZ+Vv8uZBV6s04gjozj39NEdQAZJIbwLtDKOPOUiGGmbkKzGuv5vQrJmOTgE2
         ZfqpfGvKSoGTKokyG8CxIJQzPm1oeLx64hxdcVMbUgTxtdDZuhRzU8ONQ36ObcXZhqXy
         azALAnofGZChQiFxSdeyEUkO5U3+boibvUNuMoBIpt2qdYlogwNjqoh3jAHu/qjNteqa
         R4jQ==
X-Gm-Message-State: AOAM532sJ3jTtPUSZ8XtpOwrylIWCqoZapGYezuIfnO8FmX2XL4e/OZC
        HBL8xFa08t1uf9GChbbzHN8Xrw==
X-Google-Smtp-Source: ABdhPJx+JNv8DfbZ2BRIoYIJtdjbW2M+/Bvf8yPSGmakXX185iu1+7758i5488WdgyYd5CSOEm+30g==
X-Received: by 2002:a5d:4307:0:b0:207:8e25:6cfa with SMTP id h7-20020a5d4307000000b002078e256cfamr10994967wrq.434.1652036414420;
        Sun, 08 May 2022 12:00:14 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:13 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 09/33] crypto: rockchip: remove non-aligned handling
Date:   Sun,  8 May 2022 18:59:33 +0000
Message-Id: <20220508185957.3629088-10-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

Now driver have fallback for un-aligned cases, remove all code handling
those cases.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c       | 69 +++++--------------
 drivers/crypto/rockchip/rk3288_crypto.h       |  4 --
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 22 ++----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 39 +++--------
 4 files changed, 31 insertions(+), 103 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 4cff49b82983..b3db096e2ec2 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -88,63 +88,26 @@ static int rk_load_data(struct rk_crypto_info *dev,
 {
 	unsigned int count;
 
-	dev->aligned = dev->aligned ?
-		check_alignment(sg_src, sg_dst, dev->align_size) :
-		dev->aligned;
-	if (dev->aligned) {
-		count = min(dev->left_bytes, sg_src->length);
-		dev->left_bytes -= count;
-
-		if (!dma_map_sg(dev->dev, sg_src, 1, DMA_TO_DEVICE)) {
-			dev_err(dev->dev, "[%s:%d] dma_map_sg(src)  error\n",
+	count = min(dev->left_bytes, sg_src->length);
+	dev->left_bytes -= count;
+
+	if (!dma_map_sg(dev->dev, sg_src, 1, DMA_TO_DEVICE)) {
+		dev_err(dev->dev, "[%s:%d] dma_map_sg(src)  error\n",
 				__func__, __LINE__);
-			return -EINVAL;
-		}
-		dev->addr_in = sg_dma_address(sg_src);
+		return -EINVAL;
+	}
+	dev->addr_in = sg_dma_address(sg_src);
 
-		if (sg_dst) {
-			if (!dma_map_sg(dev->dev, sg_dst, 1, DMA_FROM_DEVICE)) {
-				dev_err(dev->dev,
+	if (sg_dst) {
+		if (!dma_map_sg(dev->dev, sg_dst, 1, DMA_FROM_DEVICE)) {
+			dev_err(dev->dev,
 					"[%s:%d] dma_map_sg(dst)  error\n",
 					__func__, __LINE__);
-				dma_unmap_sg(dev->dev, sg_src, 1,
-					     DMA_TO_DEVICE);
-				return -EINVAL;
-			}
-			dev->addr_out = sg_dma_address(sg_dst);
-		}
-	} else {
-		count = (dev->left_bytes > PAGE_SIZE) ?
-			PAGE_SIZE : dev->left_bytes;
-
-		if (!sg_pcopy_to_buffer(dev->first, dev->src_nents,
-					dev->addr_vir, count,
-					dev->total - dev->left_bytes)) {
-			dev_err(dev->dev, "[%s:%d] pcopy err\n",
-				__func__, __LINE__);
+			dma_unmap_sg(dev->dev, sg_src, 1,
+					DMA_TO_DEVICE);
 			return -EINVAL;
 		}
-		dev->left_bytes -= count;
-		sg_init_one(&dev->sg_tmp, dev->addr_vir, count);
-		if (!dma_map_sg(dev->dev, &dev->sg_tmp, 1, DMA_TO_DEVICE)) {
-			dev_err(dev->dev, "[%s:%d] dma_map_sg(sg_tmp)  error\n",
-				__func__, __LINE__);
-			return -ENOMEM;
-		}
-		dev->addr_in = sg_dma_address(&dev->sg_tmp);
-
-		if (sg_dst) {
-			if (!dma_map_sg(dev->dev, &dev->sg_tmp, 1,
-					DMA_FROM_DEVICE)) {
-				dev_err(dev->dev,
-					"[%s:%d] dma_map_sg(sg_tmp)  error\n",
-					__func__, __LINE__);
-				dma_unmap_sg(dev->dev, &dev->sg_tmp, 1,
-					     DMA_TO_DEVICE);
-				return -ENOMEM;
-			}
-			dev->addr_out = sg_dma_address(&dev->sg_tmp);
-		}
+		dev->addr_out = sg_dma_address(sg_dst);
 	}
 	dev->count = count;
 	return 0;
@@ -154,11 +117,11 @@ static void rk_unload_data(struct rk_crypto_info *dev)
 {
 	struct scatterlist *sg_in, *sg_out;
 
-	sg_in = dev->aligned ? dev->sg_src : &dev->sg_tmp;
+	sg_in = dev->sg_src;
 	dma_unmap_sg(dev->dev, sg_in, 1, DMA_TO_DEVICE);
 
 	if (dev->sg_dst) {
-		sg_out = dev->aligned ? dev->sg_dst : &dev->sg_tmp;
+		sg_out = dev->sg_dst;
 		dma_unmap_sg(dev->dev, sg_out, 1, DMA_FROM_DEVICE);
 	}
 }
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 540b81a14b9b..a7de5738f6dc 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -204,12 +204,8 @@ struct rk_crypto_info {
 	/* the public variable */
 	struct scatterlist		*sg_src;
 	struct scatterlist		*sg_dst;
-	struct scatterlist		sg_tmp;
 	struct scatterlist		*first;
 	unsigned int			left_bytes;
-	void				*addr_vir;
-	int				aligned;
-	int				align_size;
 	size_t				src_nents;
 	size_t				dst_nents;
 	unsigned int			total;
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 16009bb0bf16..c762e462eb57 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -236,8 +236,6 @@ static int rk_ahash_start(struct rk_crypto_info *dev)
 
 	dev->total = req->nbytes;
 	dev->left_bytes = req->nbytes;
-	dev->aligned = 0;
-	dev->align_size = 4;
 	dev->sg_dst = NULL;
 	dev->sg_src = req->src;
 	dev->first = req->src;
@@ -272,15 +270,13 @@ static int rk_ahash_crypto_rx(struct rk_crypto_info *dev)
 
 	dev->unload_data(dev);
 	if (dev->left_bytes) {
-		if (dev->aligned) {
-			if (sg_is_last(dev->sg_src)) {
-				dev_warn(dev->dev, "[%s:%d], Lack of data\n",
-					 __func__, __LINE__);
-				err = -ENOMEM;
-				goto out_rx;
-			}
-			dev->sg_src = sg_next(dev->sg_src);
+		if (sg_is_last(dev->sg_src)) {
+			dev_warn(dev->dev, "[%s:%d], Lack of data\n",
+					__func__, __LINE__);
+			err = -ENOMEM;
+			goto out_rx;
 		}
+		dev->sg_src = sg_next(dev->sg_src);
 		err = rk_ahash_set_data_start(dev);
 	} else {
 		/*
@@ -318,11 +314,6 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 	algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
 
 	tctx->dev = algt->dev;
-	tctx->dev->addr_vir = (void *)__get_free_page(GFP_KERNEL);
-	if (!tctx->dev->addr_vir) {
-		dev_err(tctx->dev->dev, "failed to kmalloc for addr_vir\n");
-		return -ENOMEM;
-	}
 	tctx->dev->start = rk_ahash_start;
 	tctx->dev->update = rk_ahash_crypto_rx;
 	tctx->dev->complete = rk_ahash_crypto_complete;
@@ -345,7 +336,6 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 {
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
 
-	free_page((unsigned long)tctx->dev->addr_vir);
 	crypto_free_ahash(tctx->fallback_tfm);
 }
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 1ef94f8db2c5..d067b7f09165 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -356,7 +356,6 @@ static int rk_ablk_start(struct rk_crypto_info *dev)
 	dev->src_nents = sg_nents(req->src);
 	dev->sg_dst = req->dst;
 	dev->dst_nents = sg_nents(req->dst);
-	dev->aligned = 1;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	rk_ablk_hw_init(dev);
@@ -376,13 +375,9 @@ static void rk_iv_copyback(struct rk_crypto_info *dev)
 
 	/* Update the IV buffer to contain the next IV for encryption mode. */
 	if (!(rctx->mode & RK_CRYPTO_DEC)) {
-		if (dev->aligned) {
-			memcpy(req->iv, sg_virt(dev->sg_dst) +
-				dev->sg_dst->length - ivsize, ivsize);
-		} else {
-			memcpy(req->iv, dev->addr_vir +
-				dev->count - ivsize, ivsize);
-		}
+		memcpy(req->iv,
+		       sg_virt(dev->sg_dst) + dev->sg_dst->length - ivsize,
+		       ivsize);
 	}
 }
 
@@ -420,27 +415,16 @@ static int rk_ablk_rx(struct rk_crypto_info *dev)
 		skcipher_request_cast(dev->async_req);
 
 	dev->unload_data(dev);
-	if (!dev->aligned) {
-		if (!sg_pcopy_from_buffer(req->dst, dev->dst_nents,
-					  dev->addr_vir, dev->count,
-					  dev->total - dev->left_bytes -
-					  dev->count)) {
-			err = -EINVAL;
-			goto out_rx;
-		}
-	}
 	if (dev->left_bytes) {
 		rk_update_iv(dev);
-		if (dev->aligned) {
-			if (sg_is_last(dev->sg_src)) {
-				dev_err(dev->dev, "[%s:%d] Lack of data\n",
+		if (sg_is_last(dev->sg_src)) {
+			dev_err(dev->dev, "[%s:%d] Lack of data\n",
 					__func__, __LINE__);
-				err = -ENOMEM;
-				goto out_rx;
-			}
-			dev->sg_src = sg_next(dev->sg_src);
-			dev->sg_dst = sg_next(dev->sg_dst);
+			err = -ENOMEM;
+			goto out_rx;
 		}
+		dev->sg_src = sg_next(dev->sg_src);
+		dev->sg_dst = sg_next(dev->sg_dst);
 		err = rk_set_data_start(dev);
 	} else {
 		rk_iv_copyback(dev);
@@ -462,13 +446,9 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
 	algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
 
 	ctx->dev = algt->dev;
-	ctx->dev->align_size = crypto_tfm_alg_alignmask(crypto_skcipher_tfm(tfm)) + 1;
 	ctx->dev->start = rk_ablk_start;
 	ctx->dev->update = rk_ablk_rx;
 	ctx->dev->complete = rk_crypto_complete;
-	ctx->dev->addr_vir = (char *)__get_free_page(GFP_KERNEL);
-	if (!ctx->dev->addr_vir)
-		return -ENOMEM;
 
 	ctx->fallback_tfm = crypto_alloc_skcipher(name, 0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ctx->fallback_tfm)) {
@@ -488,7 +468,6 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	memzero_explicit(ctx->key, ctx->keylen);
-	free_page((unsigned long)ctx->dev->addr_vir);
 	crypto_free_skcipher(ctx->fallback_tfm);
 }
 
-- 
2.35.1

