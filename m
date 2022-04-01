Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9694EFB5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbiDAUWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiDAUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF386275449
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r13so5761221wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsAFcZDZETs5qOmN3SfIYbz4kYTDF6aAmdpWZE7nWYc=;
        b=xGI3qTCIByL7ZJcKjd9BbkZTaaapPqCRCJsMxR1II2Ahg8Bylafilvgqw893oks17f
         TXyuRhNxNjLb+GwmwulDBiLGST0vliQ1ZjQUrHFvXD9z0OX32V0amlJkQJ/9Rlc5S47F
         Yv8tGNfnfYeHwIBN1GyQSwsSOFm4A64QAgkGmG7MmvmurSSzu1cTPCY/BYsbSwzFusA+
         wZbkWAuEiwVlLPeVo2UBNWbUbhWn8qDycHCnfwTxOBMTkyF8QkbO37fDVf2/+THxCI66
         FDEFd8QdEyBoete5SQ44CNJyhgAcybFXZKDbW16hQOxwgLE3vjSI14+6TtPI9ID1PJzW
         IDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsAFcZDZETs5qOmN3SfIYbz4kYTDF6aAmdpWZE7nWYc=;
        b=FvmJBhYgUklxSfM2eJrXw7W0JMcWjkp2mAUvoWbFeqzfhungabVlD0uSwislC1GiAm
         tP4EbQQyeKicK28cCg8KrNN9p1MlFnjIhLul7nl+CfHBRracQdp3aPgcRP0Mj5OCVJPO
         zf0dvdnshJzSdb9d5SKbed19SE6Z6BzhAGQDopaRkLp737XCQuIgrqP/7jxW9GPeT1Rn
         1w84dKrZshYXZ/yDBaYljtMxOgBpTZ/vx8qLjXGGQmtzywMeo/r+zuAhXPlFf7VmYKy8
         O931RmUJ4mT9umlmximnAKJQjvucg77rMdzv9JihE6AgNc28tYKLdFrve8aPPOSTrddS
         gyug==
X-Gm-Message-State: AOAM531TVMWzHF/jLMnZEEtIlDhcXsUpEbAIipFPbaEBf6d3nn3w1oJj
        VGoh6WDEqecYPLjlehW2FAIaYA==
X-Google-Smtp-Source: ABdhPJzHnTHxBlF+AV9khVVPkqkmBcnyzZWYtk+tappRm7Vmnb9Al/pur9JBsJTdLF8wYuYLv0tS5g==
X-Received: by 2002:a5d:6f09:0:b0:205:bfdd:4a87 with SMTP id ay9-20020a5d6f09000000b00205bfdd4a87mr8963066wrb.131.1648844306905;
        Fri, 01 Apr 2022 13:18:26 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:26 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 22/33] crypto: rockchip: use a rk_crypto_info variable instead of lot of indirection
Date:   Fri,  1 Apr 2022 20:17:53 +0000
Message-Id: <20220401201804.2867154-23-clabbe@baylibre.com>
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

Instead of using lot of ctx->dev->xx indirections, use an intermediate
variable for rk_crypto_info.
This will help later, when 2 different rk_crypto_info would be used.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 23 +++++++-----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 37 ++++++++++---------
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 58acea29bed6..1f72ded24920 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -226,9 +226,10 @@ static int rk_hash_prepare(struct crypto_engine *engine, void *breq)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct rk_crypto_info *rkc = tctx->dev;
 	int ret;
 
-	ret = dma_map_sg(tctx->dev->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+	ret = dma_map_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 	if (ret <= 0)
 		return -EINVAL;
 
@@ -243,8 +244,9 @@ static int rk_hash_unprepare(struct crypto_engine *engine, void *breq)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct rk_crypto_info *rkc = tctx->dev;
 
-	dma_unmap_sg(tctx->dev->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
+	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
 	return 0;
 }
 
@@ -257,6 +259,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
 	struct scatterlist *sg = areq->src;
+	struct rk_crypto_info *rkc = tctx->dev;
 	int err = 0;
 	int i;
 	u32 v;
@@ -283,13 +286,13 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	rk_ahash_reg_init(areq);
 
 	while (sg) {
-		reinit_completion(&tctx->dev->complete);
-		tctx->dev->status = 0;
-		crypto_ahash_dma_start(tctx->dev, sg);
-		wait_for_completion_interruptible_timeout(&tctx->dev->complete,
+		reinit_completion(&rkc->complete);
+		rkc->status = 0;
+		crypto_ahash_dma_start(rkc, sg);
+		wait_for_completion_interruptible_timeout(&rkc->complete,
 							  msecs_to_jiffies(2000));
-		if (!tctx->dev->status) {
-			dev_err(tctx->dev->dev, "DMA timeout\n");
+		if (!rkc->status) {
+			dev_err(rkc->dev, "DMA timeout\n");
 			err = -EFAULT;
 			goto theend;
 		}
@@ -307,10 +310,10 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		 * complete.
 		 */
 	read_poll_timeout(readl, v, v == 0, 10, 1000, false,
-			  tctx->dev->dev + RK_CRYPTO_HASH_STS);
+			  rkc->dev + RK_CRYPTO_HASH_STS);
 
 	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
-		v = readl(tctx->dev->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
+		v = readl(rkc->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
 		put_unaligned_le32(v, areq->result + i * 4);
 	}
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 0920b1ae3862..9e2935716840 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -314,6 +314,7 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	unsigned int todo;
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
+	struct rk_crypto_info *rkc = ctx->dev;
 
 	algt->stat_req++;
 
@@ -341,49 +342,49 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 			scatterwalk_map_and_copy(biv, sgs, offset, ivsize, 0);
 		}
 		if (sgs == sgd) {
-			err = dma_map_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
+			err = dma_map_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
 			if (err <= 0) {
 				err = -EINVAL;
 				goto theend_iv;
 			}
 		} else {
-			err = dma_map_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
+			err = dma_map_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
 			if (err <= 0) {
 				err = -EINVAL;
 				goto theend_iv;
 			}
-			err = dma_map_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
+			err = dma_map_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
 			if (err <= 0) {
 				err = -EINVAL;
 				goto theend_sgs;
 			}
 		}
 		err = 0;
-		rk_cipher_hw_init(ctx->dev, areq);
+		rk_cipher_hw_init(rkc, areq);
 		if (ivsize) {
 			if (ivsize == DES_BLOCK_SIZE)
-				memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
+				memcpy_toio(rkc->reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
 			else
-				memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_IV_0, ivtouse, ivsize);
+				memcpy_toio(rkc->reg + RK_CRYPTO_AES_IV_0, ivtouse, ivsize);
 		}
-		reinit_completion(&ctx->dev->complete);
-		ctx->dev->status = 0;
+		reinit_completion(&rkc->complete);
+		rkc->status = 0;
 
 		todo = min(sg_dma_len(sgs), len);
 		len -= todo;
-		crypto_dma_start(ctx->dev, sgs, sgd, todo / 4);
-		wait_for_completion_interruptible_timeout(&ctx->dev->complete,
+		crypto_dma_start(rkc, sgs, sgd, todo / 4);
+		wait_for_completion_interruptible_timeout(&rkc->complete,
 							  msecs_to_jiffies(2000));
-		if (!ctx->dev->status) {
-			dev_err(ctx->dev->dev, "DMA timeout\n");
+		if (!rkc->status) {
+			dev_err(rkc->dev, "DMA timeout\n");
 			err = -EFAULT;
 			goto theend;
 		}
 		if (sgs == sgd) {
-			dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
+			dma_unmap_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
 		} else {
-			dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
-			dma_unmap_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
+			dma_unmap_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+			dma_unmap_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
 		}
 		if (rctx->mode & RK_CRYPTO_DEC) {
 			memcpy(iv, biv, ivsize);
@@ -417,10 +418,10 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 
 theend_sgs:
 	if (sgs == sgd) {
-		dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(rkc->dev, sgs, 1, DMA_BIDIRECTIONAL);
 	} else {
-		dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
-		dma_unmap_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
+		dma_unmap_sg(rkc->dev, sgs, 1, DMA_TO_DEVICE);
+		dma_unmap_sg(rkc->dev, sgd, 1, DMA_FROM_DEVICE);
 	}
 theend_iv:
 	return err;
-- 
2.35.1

