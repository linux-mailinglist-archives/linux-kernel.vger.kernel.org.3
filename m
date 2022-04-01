Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7134EFB24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiDAUUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352017AbiDAUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68611C09
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso4253406wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQ2+yGgyvZBIiO6naEaNtlbLp20pXxD4svKq6lnmovM=;
        b=4RcOmsWgrqYL/OJg6orY6y/iwQhV4yB1pBP9tHlp3gEJywDUI39FHbpEfPANOSmSsp
         Vfet2ap2qKbBCvKKyAHDj5OWBz4T1ne9YBaReLzmaPiYCEzfDIeFe4juQmH9L03Bmgoh
         XJ0+oaGPgtvK5y9VO+asYZd4tb2N58I6A1ha63hIIrIjgrUAke58DxXL9qIF5XHBCSlZ
         MHQOMvBSWmLdZ8nMOIOh0sJ6HqqyyXsAr9m60NazLlaKk5QmB+vrAqFMLY04F1YMd4xB
         fWtY0OxsIHTKWfINZmQUfqdzalRsxFyHqaUOE0SKIqcdo33Dt1mqL1Jc6ZngUjDqZMUR
         soMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQ2+yGgyvZBIiO6naEaNtlbLp20pXxD4svKq6lnmovM=;
        b=jWs7rUlW/qYYWR2KcJbsH9GwLZNEQtvZsz2FAx0OzbLTFaoraE35Q0fFABcMHhozYm
         k+gL/7XiinUWEVD2xLCu/wJhGgiG2TxOhJx5LNjruf2qPQ+hLouLrPjC+ltdoM1rraVg
         x8ZLgGE4ku6Gos/6zYBAraOq/UhPjUecw7icDnVmy/OwJfgpfSiiqId/ISztgHZKmM/8
         gfURbw6i7/rC84vS2NLReNq5E95Fj9sAn2htYkuEDVHEE4Hn/W91xIYIdzIUJGU9yHPZ
         hZzQwiKtx3JuOIOWUYD0EStq0cgurb087uXyyw5vCpM/Bhib32vzxG0XPrTO1FiSiYkT
         oV5A==
X-Gm-Message-State: AOAM532c6uy+C9Pw7BuBAJmdPcJ+89OavvCm2us10nj1KXgfz8PjyqII
        fnSsoLdvinokZWGN9QPh7V0L/g==
X-Google-Smtp-Source: ABdhPJxscQ3FCcbVoOZ8aoJ9A+wvHX59IktplBLF4JQPehb84KRGhYNBngdfT7YbG9ZSRXsSL6WFXA==
X-Received: by 2002:a05:600c:3d8d:b0:38c:82dc:cd58 with SMTP id bi13-20020a05600c3d8d00b0038c82dccd58mr9931973wmb.50.1648844297479;
        Fri, 01 Apr 2022 13:18:17 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:17 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 09/33] crypto: rockchip: remove non-aligned handling
Date:   Fri,  1 Apr 2022 20:17:40 +0000
Message-Id: <20220401201804.2867154-10-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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
index 826508e4a0c3..d35b84071935 100644
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
index 5a9ba7c0206d..1b449d8623c9 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -364,7 +364,6 @@ static int rk_ablk_start(struct rk_crypto_info *dev)
 	dev->src_nents = sg_nents(req->src);
 	dev->sg_dst = req->dst;
 	dev->dst_nents = sg_nents(req->dst);
-	dev->aligned = 1;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	rk_ablk_hw_init(dev);
@@ -384,13 +383,9 @@ static void rk_iv_copyback(struct rk_crypto_info *dev)
 
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
 
@@ -428,27 +423,16 @@ static int rk_ablk_rx(struct rk_crypto_info *dev)
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
@@ -470,13 +454,9 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
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
@@ -496,7 +476,6 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	memzero_explicit(ctx->key, ctx->keylen);
-	free_page((unsigned long)ctx->dev->addr_vir);
 	crypto_free_skcipher(ctx->fallback_tfm);
 }
 
-- 
2.35.1

