Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4875D5A0A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiHYHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiHYHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:24:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E8A1D50
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h22so27551844ejk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0aI67loF6W941kI2a1qaBc4yuTiPkE24GFlkzf9zIho=;
        b=QPl4SOPBQw60gvX7h0UoMpZmM2OSEprGYploWhAzSt6mBzL2z9vEent7QQXZ3+1xmy
         HqF4UYz6+6fAECcM+STV+da9h/RiSSJAemL48vFgbR4BH9tbivSC34p+TwKS3B+w6SRq
         CsrZEyIDEgfFtpms63VWVs6r5+rjlLzeaPR8oVi2+TqIxZOQvCMNcddtRwAKlTbngzRl
         NVwWylsVqD8JgKPKNX2jO8LO44xYoAnredLcWMyvv3g/NzlsBpvR7dkXfQHuq64Q8OrU
         b/J/TxqeepLi7DQou6bSb2Ik7rViFBzCbIgqqngTw6KfCFJr6d7fbIlEZdqFy66dRDMR
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0aI67loF6W941kI2a1qaBc4yuTiPkE24GFlkzf9zIho=;
        b=O2u8B1PmsqyDLilEHM5UKC1T717xtaGUtF/Kw6H7sR4N3Ri5VqC5CM2GowQq6SQagN
         JAk1VY/KVjZrBYgA4crLL39wTg60rpOmgz1/J6WJDQ6l978M/OduOhY//J8Ot2BbWSy+
         s5QKM0Qa1N5l0OVHogNKggph4x3xp9riYI9uVyzCI0n98FZ9MYpPYehhvvs6+Y3Hnt6q
         U4qt0QLXXz0gR9e2yezhg/zIN7UAY2evmoXYUNL2Wxx6kfQfI9gOh2FDEAGY97XU6t+N
         tGU9KoYx3Ad/KDv4YBdR30+PAfOWp5z2pD+H48djmYuoG3+1m/3OxT5ENz2P4mdzb7Bn
         Iy3w==
X-Gm-Message-State: ACgBeo0+EjycJnwSVFa79WcixeLStl6VtcDUiCExBfU327Z0N6aBnlla
        7kOkZ5psWm3bZRgDJsyfOQUTWA==
X-Google-Smtp-Source: AA6agR7xq8lmYOHdm2trDOmp773MnIQKIRGV6RNdLdjKo1apjifY0yvtQQQxkInQ28TGgxYGLbf78w==
X-Received: by 2002:a17:907:b17:b0:72a:edb8:7529 with SMTP id h23-20020a1709070b1700b0072aedb87529mr1529339ejl.749.1661412266376;
        Thu, 25 Aug 2022 00:24:26 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0073ce4abf093sm2032281ejc.214.2022.08.25.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:24:26 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Peng Wu <wupeng58@huawei.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] crypto: allwinner: Fix dma_map_sg error check
Date:   Thu, 25 Aug 2022 09:24:20 +0200
Message-Id: <20220825072421.29020-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825072421.29020-1-jinpu.wang@ionos.com>
References: <20220825072421.29020-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Minghao Chi <chi.minghao@zte.com.cn>
Cc: Peng Wu <wupeng58@huawei.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Fixes: 06f751b61329 ("crypto: allwinner - Add sun8i-ce Crypto Engine")
Fixes: d9b45418a917 ("crypto: sun8i-ss - support hash algorithms")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 6 +++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 4 ++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 74b4e910a38d..be7f46faef7e 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -208,7 +208,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 
 	if (areq->src == areq->dst) {
 		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_BIDIRECTIONAL);
-		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+		if (!nr_sgs || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
@@ -216,13 +216,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 		nr_sgd = nr_sgs;
 	} else {
 		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
-		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+		if (!nr_sgs || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
 		nr_sgd = dma_map_sg(ce->dev, areq->dst, nd, DMA_FROM_DEVICE);
-		if (nr_sgd <= 0 || nr_sgd > MAX_SG) {
+		if (!nr_sgd || nr_sgd > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
 			goto theend_sgs;
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index 8b5b9b9d04c3..0e6843ec197f 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -389,7 +389,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	cet->t_asym_ctl = 0;
 
 	nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+	if (!nr_sgs || nr_sgs > MAX_SG) {
 		dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
 		goto theend;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 910d6751644c..fdcc98cdecaa 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -232,13 +232,13 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 		nr_sgd = nr_sgs;
 	} else {
 		nr_sgs = dma_map_sg(ss->dev, areq->src, nsgs, DMA_TO_DEVICE);
-		if (nr_sgs <= 0 || nr_sgs > 8) {
+		if (!nr_sgs || nr_sgs > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
 		nr_sgd = dma_map_sg(ss->dev, areq->dst, nsgd, DMA_FROM_DEVICE);
-		if (nr_sgd <= 0 || nr_sgd > 8) {
+		if (!nr_sgd || nr_sgd > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
 			goto theend_sgs;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 36a82b22953c..fcb8c41cc957 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -527,7 +527,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	rctx->method = ss->variant->alg_hash[algt->ss_algo_id];
 
 	nr_sgs = dma_map_sg(ss->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+	if (!nr_sgs || nr_sgs > MAX_SG) {
 		dev_err(ss->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
 		goto theend;
-- 
2.34.1

