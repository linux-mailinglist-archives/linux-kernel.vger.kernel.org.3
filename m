Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55650EA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiDYUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiDYUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:24:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607B128CE4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso228227wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeUZDJTIsCts00Fep9NY/D3Rc1u7GLFRGKGWO5X+Gz0=;
        b=nAQmC7u+UldzYzzZ50Fy7PQerMveM73py3LRvoMHJSNup+HQDx1iLMjizbcVLRvlvW
         k89ex9vNe45ctnpIQb6m89ZgTxnhKaOxKNu5M+k3wvftmzVQW+IUQst0Aq/EQF/GHE0N
         aVa89Uwmyn7qEvCScHjiomWP0rByq70rvsdiqwBJkMN9ojC39pyhpTDlorVphzLCn0K+
         NZGePwGSeHy2j2UuPy5cRAlN6BPwR/tepZcfn9R+yUqML8c6SOqpjKnd2Ls7EeQiWi6b
         jVD6ZSbIzBX+PNHMTkYBxdtfCatVecVHnY20C2vlYUUTpg2aoTVzBMq+P2spQ+1Mwufs
         z+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeUZDJTIsCts00Fep9NY/D3Rc1u7GLFRGKGWO5X+Gz0=;
        b=AhFT7PJ6WazdpBO2KnZvupNZsA5CdCRfcAzFoYDbqd5PIb/IzGWhP1E9yV4X4uFyUo
         0K3GYzZI3qZw+JJMadJWY/XCrbofI0KcuySmd56Ug3NexNiUC4z1I5Fn/v1UdqOgUC+c
         e8uw1uEipo4bTalIvcM7nQ/I963jJUJ1PDEGtNWySNRO7tJ1MOMHFFgOmoWiVgVNZatw
         NjxH7LQ45tGeenN1ukig+dLYDYc84K6881X3U9Hu+jxaPZQwasY7WpwVvHxWcWcffA9t
         rus/uEIrVNEEBSuPWFiit7YH+IzVeacKKn0oB+GaUTFPBMURnj+4FKDirpZaKzXmCg5n
         UgpA==
X-Gm-Message-State: AOAM5337krxiuW3B7rbkeed83gQUkWW80BFV1qTAGP4WgZOZqiWjv/2Q
        iFa5HkD3766qVhzqUuwP9QMBZg==
X-Google-Smtp-Source: ABdhPJwH/jZysb7BFoCAlU8r3BdwsnEND3acQxX6+NhslEl8M6PBhRR2lr3Be3bAFnm/H5DwSvpapg==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr17897297wmk.118.1650918098168;
        Mon, 25 Apr 2022 13:21:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:37 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 11/33] crypto: rockchip: rewrite type
Date:   Mon, 25 Apr 2022 20:20:57 +0000
Message-Id: <20220425202119.3566743-12-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a custom type for classify algorithms, let's just use
already defined ones.
And let's made a bit more verbose about what is registered.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c       | 26 +++++++++++++------
 drivers/crypto/rockchip/rk3288_crypto.h       |  7 +----
 drivers/crypto/rockchip/rk3288_crypto_ahash.c |  6 ++---
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 12 ++++-----
 4 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 1afb65eee6c9..8f9664acc78d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -102,12 +102,22 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		rk_cipher_algs[i]->dev = crypto_info;
-		if (rk_cipher_algs[i]->type == ALG_TYPE_CIPHER)
-			err = crypto_register_skcipher(
-					&rk_cipher_algs[i]->alg.skcipher);
-		else
-			err = crypto_register_ahash(
-					&rk_cipher_algs[i]->alg.hash);
+		switch (rk_cipher_algs[i]->type) {
+		case CRYPTO_ALG_TYPE_SKCIPHER:
+			dev_info(crypto_info->dev, "Register %s as %s\n",
+				 rk_cipher_algs[i]->alg.skcipher.base.cra_name,
+				 rk_cipher_algs[i]->alg.skcipher.base.cra_driver_name);
+			err = crypto_register_skcipher(&rk_cipher_algs[i]->alg.skcipher);
+			break;
+		case CRYPTO_ALG_TYPE_AHASH:
+			dev_info(crypto_info->dev, "Register %s as %s\n",
+				 rk_cipher_algs[i]->alg.hash.halg.base.cra_name,
+				 rk_cipher_algs[i]->alg.hash.halg.base.cra_driver_name);
+			err = crypto_register_ahash(&rk_cipher_algs[i]->alg.hash);
+			break;
+		default:
+			dev_err(crypto_info->dev, "unknown algorithm\n");
+		}
 		if (err)
 			goto err_cipher_algs;
 	}
@@ -115,7 +125,7 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 
 err_cipher_algs:
 	for (k = 0; k < i; k++) {
-		if (rk_cipher_algs[i]->type == ALG_TYPE_CIPHER)
+		if (rk_cipher_algs[i]->type == CRYPTO_ALG_TYPE_SKCIPHER)
 			crypto_unregister_skcipher(&rk_cipher_algs[k]->alg.skcipher);
 		else
 			crypto_unregister_ahash(&rk_cipher_algs[i]->alg.hash);
@@ -128,7 +138,7 @@ static void rk_crypto_unregister(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
-		if (rk_cipher_algs[i]->type == ALG_TYPE_CIPHER)
+		if (rk_cipher_algs[i]->type == CRYPTO_ALG_TYPE_SKCIPHER)
 			crypto_unregister_skcipher(&rk_cipher_algs[i]->alg.skcipher);
 		else
 			crypto_unregister_ahash(&rk_cipher_algs[i]->alg.hash);
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 65ed645e0168..d924ea17402a 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -232,18 +232,13 @@ struct rk_cipher_rctx {
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
-enum alg_type {
-	ALG_TYPE_HASH,
-	ALG_TYPE_CIPHER,
-};
-
 struct rk_crypto_tmp {
+	u32 type;
 	struct rk_crypto_info		*dev;
 	union {
 		struct skcipher_alg	skcipher;
 		struct ahash_alg	hash;
 	} alg;
-	enum alg_type			type;
 };
 
 extern struct rk_crypto_tmp rk_ecb_aes_alg;
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index edd40e16a3f0..d08e2438d356 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -352,7 +352,7 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
-	.type = ALG_TYPE_HASH,
+	.type = CRYPTO_ALG_TYPE_AHASH,
 	.alg.hash = {
 		.init = rk_ahash_init,
 		.update = rk_ahash_update,
@@ -382,7 +382,7 @@ struct rk_crypto_tmp rk_ahash_sha1 = {
 };
 
 struct rk_crypto_tmp rk_ahash_sha256 = {
-	.type = ALG_TYPE_HASH,
+	.type = CRYPTO_ALG_TYPE_AHASH,
 	.alg.hash = {
 		.init = rk_ahash_init,
 		.update = rk_ahash_update,
@@ -412,7 +412,7 @@ struct rk_crypto_tmp rk_ahash_sha256 = {
 };
 
 struct rk_crypto_tmp rk_ahash_md5 = {
-	.type = ALG_TYPE_HASH,
+	.type = CRYPTO_ALG_TYPE_AHASH,
 	.alg.hash = {
 		.init = rk_ahash_init,
 		.update = rk_ahash_update,
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 67a7e05d5ae3..1ed297f5d809 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -468,7 +468,7 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 }
 
 struct rk_crypto_tmp rk_ecb_aes_alg = {
-	.type = ALG_TYPE_CIPHER,
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 	.alg.skcipher = {
 		.base.cra_name		= "ecb(aes)",
 		.base.cra_driver_name	= "ecb-aes-rk",
@@ -490,7 +490,7 @@ struct rk_crypto_tmp rk_ecb_aes_alg = {
 };
 
 struct rk_crypto_tmp rk_cbc_aes_alg = {
-	.type = ALG_TYPE_CIPHER,
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 	.alg.skcipher = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "cbc-aes-rk",
@@ -513,7 +513,7 @@ struct rk_crypto_tmp rk_cbc_aes_alg = {
 };
 
 struct rk_crypto_tmp rk_ecb_des_alg = {
-	.type = ALG_TYPE_CIPHER,
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 	.alg.skcipher = {
 		.base.cra_name		= "ecb(des)",
 		.base.cra_driver_name	= "ecb-des-rk",
@@ -535,7 +535,7 @@ struct rk_crypto_tmp rk_ecb_des_alg = {
 };
 
 struct rk_crypto_tmp rk_cbc_des_alg = {
-	.type = ALG_TYPE_CIPHER,
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 	.alg.skcipher = {
 		.base.cra_name		= "cbc(des)",
 		.base.cra_driver_name	= "cbc-des-rk",
@@ -558,7 +558,7 @@ struct rk_crypto_tmp rk_cbc_des_alg = {
 };
 
 struct rk_crypto_tmp rk_ecb_des3_ede_alg = {
-	.type = ALG_TYPE_CIPHER,
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 	.alg.skcipher = {
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "ecb-des3-ede-rk",
@@ -580,7 +580,7 @@ struct rk_crypto_tmp rk_ecb_des3_ede_alg = {
 };
 
 struct rk_crypto_tmp rk_cbc_des3_ede_alg = {
-	.type = ALG_TYPE_CIPHER,
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
 	.alg.skcipher = {
 		.base.cra_name		= "cbc(des3_ede)",
 		.base.cra_driver_name	= "cbc-des3-ede-rk",
-- 
2.35.1

