Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE04DCFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiCQU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiCQU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECC1B7570
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so9048785wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DXXuSXEFAamNiNk9tlzIIQ+W6KiuVow1yPGhXr2jxk=;
        b=JhIOx4uvCGp8S6N/MjBn4M9mFZ19QZ8yBDUlagVA3j70J22g8LELTP9cIrQWGqzlZ0
         88Xeq37jtdCEfU9na5x8vpfmPrB/t6WxfQXM/BOMtKAyxXr83jBcnOnHdlbEDBonjlTI
         1L1KXifrmxhyZ1EYbGOIv0ta91PCj7zgMrLpcH/8t/OM1SpVhfi8wR0oPpgd0HcBoPlf
         dwtcED607b7BAyHKdvHLxMNBNj/xE6chj8/erESNgVfOcsTB5LkMidq3T+lzubLH4CkA
         67RmGTjm0hYWJem5yFIIGm2/+DDIGzlt7/tCxlGUadkZwIpDjGFbh4PVxP2QdqbsUMSz
         Asbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DXXuSXEFAamNiNk9tlzIIQ+W6KiuVow1yPGhXr2jxk=;
        b=k7v2qqcwmvTVqDDUzxgAZ8A3m0hAyyFWD5Xqq5OO6WXnAViQOEY4IWYr4QWTezvwBU
         rL3makxr/ffcSWrseTuUkr6gn+BTTIMkW1MSgVLWrND/0OM+6M0IAXIgaYY8cMd5/3tt
         HsLZoM0urAd/8rtQKc0baZZPtRGDE5zYugmkfTrY1zhzTvXO9SPTt4okftZLsZK1oq6R
         yo5BmBeNoSy2Je/mt5wlKenErQMOPLIiV7IxwhlZrBDOXYXuKC6KEmn4g2LV8idpnegu
         RPF5TABHG/A33bRBYCaOiGTBOFT03QnyZp31mIWw8hO4ucXPva/nr0xM1OcRV3yyHCp7
         iBDw==
X-Gm-Message-State: AOAM531kXPkEbuK58QRD9n4ZI8WiFYSdpNZspYSW6ECnu1hQLramfiRO
        Zfejks3sWKo0ZJMDysN5EWbXfg==
X-Google-Smtp-Source: ABdhPJxwFLw6lmsOT4ZnkVZU7khEHYYxxkIzaGKeG6Ht9IYqDKKMLCgawu6JWEmdYcF1XeQs27uIvA==
X-Received: by 2002:a5d:6d05:0:b0:203:781d:3f7b with SMTP id e5-20020a5d6d05000000b00203781d3f7bmr5491693wrq.442.1647550583502;
        Thu, 17 Mar 2022 13:56:23 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:23 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 17/19] crypto: sun8i-ce: use sg_nents_for_len
Date:   Thu, 17 Mar 2022 20:56:03 +0000
Message-Id: <20220317205605.3924836-18-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317205605.3924836-1-clabbe@baylibre.com>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
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

When testing with some large SG list, the sun8i-ce drivers always
fallback even if it can handle it.
So use sg_nents_for_len() which permits to see less SGs than needed.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 23 ++++++++-----------
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 10 ++++----
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 0b1ce58bdeb9..35ab71d3a82d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -26,7 +26,8 @@ static int sun8i_ce_cipher_need_fallback(struct skcipher_request *areq)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
 	struct scatterlist *sg;
 
-	if (sg_nents(areq->src) > MAX_SG || sg_nents(areq->dst) > MAX_SG)
+	if (sg_nents_for_len(areq->src, areq->cryptlen) > MAX_SG ||
+	    sg_nents_for_len(areq->dst, areq->cryptlen) > MAX_SG)
 		return true;
 
 	if (areq->cryptlen < crypto_skcipher_ivsize(tfm))
@@ -94,6 +95,8 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	int nr_sgs = 0;
 	int nr_sgd = 0;
 	int err = 0;
+	int ns = sg_nents_for_len(areq->src, areq->cryptlen);
+	int nd = sg_nents_for_len(areq->dst, areq->cryptlen);
 
 	algt = container_of(alg, struct sun8i_ce_alg_template, alg.skcipher);
 
@@ -169,8 +172,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	}
 
 	if (areq->src == areq->dst) {
-		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
-				    DMA_BIDIRECTIONAL);
+		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_BIDIRECTIONAL);
 		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
@@ -178,15 +180,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 		}
 		nr_sgd = nr_sgs;
 	} else {
-		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
-				    DMA_TO_DEVICE);
+		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
 		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
-		nr_sgd = dma_map_sg(ce->dev, areq->dst, sg_nents(areq->dst),
-				    DMA_FROM_DEVICE);
+		nr_sgd = dma_map_sg(ce->dev, areq->dst, nd, DMA_FROM_DEVICE);
 		if (nr_sgd <= 0 || nr_sgd > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
@@ -231,14 +231,11 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 
 theend_sgs:
 	if (areq->src == areq->dst) {
-		dma_unmap_sg(ce->dev, areq->src, sg_nents(areq->src),
-			     DMA_BIDIRECTIONAL);
+		dma_unmap_sg(ce->dev, areq->src, ns, DMA_BIDIRECTIONAL);
 	} else {
 		if (nr_sgs > 0)
-			dma_unmap_sg(ce->dev, areq->src, sg_nents(areq->src),
-				     DMA_TO_DEVICE);
-		dma_unmap_sg(ce->dev, areq->dst, sg_nents(areq->dst),
-			     DMA_FROM_DEVICE);
+			dma_unmap_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
+		dma_unmap_sg(ce->dev, areq->dst, nd, DMA_FROM_DEVICE);
 	}
 
 theend_iv:
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index 820651f0387f..17f6885dbe35 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -204,7 +204,7 @@ static bool sun8i_ce_hash_need_fallback(struct ahash_request *areq)
 	if (areq->nbytes == 0)
 		return true;
 	/* we need to reserve one SG for padding one */
-	if (sg_nents(areq->src) > MAX_SG - 1)
+	if (sg_nents_for_len(areq->src, areq->nbytes) > MAX_SG - 1)
 		return true;
 	sg = areq->src;
 	while (sg) {
@@ -229,7 +229,7 @@ int sun8i_ce_hash_digest(struct ahash_request *areq)
 	if (sun8i_ce_hash_need_fallback(areq))
 		return sun8i_ce_hash_digest_fb(areq);
 
-	nr_sgs = sg_nents(areq->src);
+	nr_sgs = sg_nents_for_len(areq->src, areq->nbytes);
 	if (nr_sgs > MAX_SG - 1)
 		return sun8i_ce_hash_digest_fb(areq);
 
@@ -328,6 +328,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	u64 bs;
 	int digestsize;
 	dma_addr_t addr_res, addr_pad;
+	int ns = sg_nents_for_len(areq->src, areq->nbytes);
 
 	algt = container_of(alg, struct sun8i_ce_alg_template, alg.hash);
 	ce = algt->ce;
@@ -372,7 +373,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	cet->t_sym_ctl = 0;
 	cet->t_asym_ctl = 0;
 
-	nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+	nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
 	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
 		dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
@@ -441,8 +442,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(areq->base.tfm));
 
 	dma_unmap_single(ce->dev, addr_pad, j * 4, DMA_TO_DEVICE);
-	dma_unmap_sg(ce->dev, areq->src, sg_nents(areq->src),
-		     DMA_TO_DEVICE);
+	dma_unmap_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
 	dma_unmap_single(ce->dev, addr_res, digestsize, DMA_FROM_DEVICE);
 
 
-- 
2.34.1

