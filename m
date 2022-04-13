Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479E64FFEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiDMTL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiDMTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:11:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9A70F79
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso4613589wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsVyA7Q+L4jHZkBvcDuSCtuQQnBfkeU7fPbG/J4t/C0=;
        b=J4q0dwlAw6RZiF8L0oz3CoA75Q9PMcuP9wg0NuMoBpSGZx3k/NwXdVmJHSPDqdMXGO
         TRTtuU1wqCO28Ao2uGERIzmJDEWRXkGCTxUuPLeTFtVop8gpx9IhL//s2SnEM2eRoOV2
         suSvv1t2HUNiqd2Yx+BFYoqCxm8ateGZATR4jVm/l5klCeB3KdOa5RzBnXP1FDf6wKFd
         gJtT4lgMAO6H7CM0XmKWrsHBtJ2BC+NPMUJt8f8lIwgsd+dT+tlcygQVEYjaXpJyUAic
         z1KSPXpSMieq+SoxBC0b+8e1eM3U/39Tck0vkZDH3rN+it+H5pVQjMRsbod2cWuUj6IH
         2HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsVyA7Q+L4jHZkBvcDuSCtuQQnBfkeU7fPbG/J4t/C0=;
        b=LRWlraot+CpB7itjtrjE/H8RWP7iy+Ha20JRCYHA88aZtMf5S4e5cMaGhLGy4Qp8Cd
         0IRDt9WMQRhfrD2cy2aB5O5yMnjItEZ3gkEfhAU19LTpWeoaC2h6K5l4059kjxMBlDxc
         x8yFSRoQTdSNLaAlcdk4GN6VBIZztXitFBsHRDdo/d/J77FZoOFnoHlfyjNr1v6pEHkX
         bDMQb9ZcIj2BYrV1aPRVwjkwq4QXI7qcwgt5I2xEfAkBO504eMuxGSQTgQItAa/RrLbK
         2V6Cj6c5uuw2qDeU14T5+kqh6yjPspk4pDTKQnu5lRCwblOFYp7MkyiSFkbyJbbvFHEo
         E8zg==
X-Gm-Message-State: AOAM5325YOqJ7sF/6iFZVT/yUGlY6Pe8adR4EdQearRl71H88woYxyHs
        S8HTmsWHKsa9rKqqvoJEWX8DTA==
X-Google-Smtp-Source: ABdhPJyE7XNBwG72VWXYShLq5ZxLAt1cUP0nWjxBHx7sOX/jDlbUHoNSclLU568p2bw0Cnv18MBcyA==
X-Received: by 2002:a05:600c:3590:b0:38e:a6b1:1acb with SMTP id p16-20020a05600c359000b0038ea6b11acbmr144281wmq.93.1649876865617;
        Wed, 13 Apr 2022 12:07:45 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 22/33] crypto: rockchip: use a rk_crypto_info variable instead of lot of indirection
Date:   Wed, 13 Apr 2022 19:07:02 +0000
Message-Id: <20220413190713.1427956-23-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
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

Instead of using lot of ctx->dev->xx indirections, use an intermediate
variable for rk_crypto_info.
This will help later, when 2 different rk_crypto_info would be used.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 23 +++++++-----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 37 ++++++++++---------
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index fae779d73c84..636dbcde0ca3 100644
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
@@ -306,10 +309,10 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	 * efficiency, and make it response quickly when dma
 	 * complete.
 	 */
-	readl_poll_timeout(tctx->dev->reg + RK_CRYPTO_HASH_STS, v, v == 0, 10, 1000);
+	readl_poll_timeout(rkc->reg + RK_CRYPTO_HASH_STS, v, v == 0, 10, 1000);
 
 	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
-		v = readl(tctx->dev->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
+		v = readl(rkc->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
 		put_unaligned_le32(v, areq->result + i * 4);
 	}
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 3187869c4c68..6a1bea98fded 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -303,6 +303,7 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	unsigned int todo;
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
+	struct rk_crypto_info *rkc = ctx->dev;
 
 	algt->stat_req++;
 
@@ -330,49 +331,49 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
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
@@ -405,10 +406,10 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 
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

