Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8A4EFB5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352227AbiDAUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352185AbiDAUUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F87727428B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r7so2426821wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41WwiG2hYkDaYUoIBM78RppkWLusFi33pXJ3vgOX1eE=;
        b=qr2WEj9Dfo8e9NtBEKIRGcGk73EWWGgZ90jeHiKN3JkYWiwWZwAAAzAxmv1RiCHzrL
         Ju6pH1iRGV2okJzmVM/I+69zWCNKvxdTdJ4MmSZt+bxNaEOF+Sfmyem70XdJ9V7DqqBs
         Hn4xMzhBXpdQqLZjEBivKM07eWZyw+haedhVQdKYw1uOgE/y7M8cPOokdPRrqDJN+zHv
         yv66xMp4ij3qmxWccD8KwE7Llh8MYYLIDhGnNV5X/Ep3cGhUPyQGGiJ8WWUxoQn2Sv4A
         doy8neLSm1AvrlvWp0KwsFKQPXc15wOmRB32RU6PkjbaB6LyQ3CzygzFniEoha442+RY
         rSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41WwiG2hYkDaYUoIBM78RppkWLusFi33pXJ3vgOX1eE=;
        b=6YLVL0qdGtwNiSYJtDWETTyChta3SlrjTCN1jaLw79STe8+2SpWDATRCW2MznfIUKM
         4i8u5vSQcVQeSnVLNMDO8E5KTgB8Dks5mUGP5j8DMRgSIb19IBNO14USXUMFn8OgUW2/
         j0Jl2g+aLmSPrjHAXGZKcHCKTOYuUGQwpoYIXxdX1oXbNVnHIszVEHJc+p2dLYbgPcm0
         rH6vpdobpEQFyTKgTJ/dMyx7lIB8uIKSl1GXfEpNpHtjuR8NK/wY6uq/FYxmVM5C0SPj
         2YTl8Kxn5nZEtZqnkC3SfxLGPBYHwzyO/9JS8eL1rOV3o6V2tLhq9UkXvLhluva5x4QL
         71VQ==
X-Gm-Message-State: AOAM533ZMB9f19TR+7HsSZRcKIr0HN4k3gELC8RK2Kyb3t13DHwa+tXE
        sd5ZpRnJZH/3pKHF8GN+j6CgRQ==
X-Google-Smtp-Source: ABdhPJzh2Vzk0MHEcuRtsDCDPIG0Mq+XxJ7O8oYzcB4AtYRfnWj4tETVXls/Ga34y2blhNKbLGD9xA==
X-Received: by 2002:a05:600c:154d:b0:38c:e9b8:d13f with SMTP id f13-20020a05600c154d00b0038ce9b8d13fmr10060817wmg.183.1648844305577;
        Fri, 01 Apr 2022 13:18:25 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:25 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 20/33] crypto: rockchip: rename ablk functions to cipher
Date:   Fri,  1 Apr 2022 20:17:51 +0000
Message-Id: <20220401201804.2867154-21-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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

Some functions have still ablk in their name even if there are
not handling ablk_cipher anymore.
So let's rename them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 8d3a60db0cf6..c5e7090c77c8 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -283,7 +283,7 @@ static int rk_des3_ede_cbc_decrypt(struct skcipher_request *req)
 	return rk_handle_req(dev, req);
 }
 
-static void rk_ablk_hw_init(struct rk_crypto_info *dev, struct skcipher_request *req)
+static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_request *req)
 {
 	struct crypto_skcipher *cipher = crypto_skcipher_reqtfm(req);
 	struct crypto_tfm *tfm = crypto_skcipher_tfm(cipher);
@@ -393,7 +393,7 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 			}
 		}
 		err = 0;
-		rk_ablk_hw_init(ctx->dev, areq);
+		rk_cipher_hw_init(ctx->dev, areq);
 		if (ivsize) {
 			if (ivsize == DES_BLOCK_SIZE)
 				memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
@@ -460,7 +460,7 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	return err;
 }
 
-static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
+static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 {
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
@@ -494,7 +494,7 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
 	return err;
 }
 
-static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
+static void rk_cipher_tfm_exit(struct crypto_skcipher *tfm)
 {
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
@@ -515,8 +515,8 @@ struct rk_crypto_tmp rk_ecb_aes_alg = {
 		.base.cra_alignmask	= 0x0f,
 		.base.cra_module	= THIS_MODULE,
 
-		.init			= rk_ablk_init_tfm,
-		.exit			= rk_ablk_exit_tfm,
+		.init			= rk_cipher_tfm_init,
+		.exit			= rk_cipher_tfm_exit,
 		.min_keysize		= AES_MIN_KEY_SIZE,
 		.max_keysize		= AES_MAX_KEY_SIZE,
 		.setkey			= rk_aes_setkey,
@@ -537,8 +537,8 @@ struct rk_crypto_tmp rk_cbc_aes_alg = {
 		.base.cra_alignmask	= 0x0f,
 		.base.cra_module	= THIS_MODULE,
 
-		.init			= rk_ablk_init_tfm,
-		.exit			= rk_ablk_exit_tfm,
+		.init			= rk_cipher_tfm_init,
+		.exit			= rk_cipher_tfm_exit,
 		.min_keysize		= AES_MIN_KEY_SIZE,
 		.max_keysize		= AES_MAX_KEY_SIZE,
 		.ivsize			= AES_BLOCK_SIZE,
@@ -560,8 +560,8 @@ struct rk_crypto_tmp rk_ecb_des_alg = {
 		.base.cra_alignmask	= 0x07,
 		.base.cra_module	= THIS_MODULE,
 
-		.init			= rk_ablk_init_tfm,
-		.exit			= rk_ablk_exit_tfm,
+		.init			= rk_cipher_tfm_init,
+		.exit			= rk_cipher_tfm_exit,
 		.min_keysize		= DES_KEY_SIZE,
 		.max_keysize		= DES_KEY_SIZE,
 		.setkey			= rk_des_setkey,
@@ -582,8 +582,8 @@ struct rk_crypto_tmp rk_cbc_des_alg = {
 		.base.cra_alignmask	= 0x07,
 		.base.cra_module	= THIS_MODULE,
 
-		.init			= rk_ablk_init_tfm,
-		.exit			= rk_ablk_exit_tfm,
+		.init			= rk_cipher_tfm_init,
+		.exit			= rk_cipher_tfm_exit,
 		.min_keysize		= DES_KEY_SIZE,
 		.max_keysize		= DES_KEY_SIZE,
 		.ivsize			= DES_BLOCK_SIZE,
@@ -605,8 +605,8 @@ struct rk_crypto_tmp rk_ecb_des3_ede_alg = {
 		.base.cra_alignmask	= 0x07,
 		.base.cra_module	= THIS_MODULE,
 
-		.init			= rk_ablk_init_tfm,
-		.exit			= rk_ablk_exit_tfm,
+		.init			= rk_cipher_tfm_init,
+		.exit			= rk_cipher_tfm_exit,
 		.min_keysize		= DES3_EDE_KEY_SIZE,
 		.max_keysize		= DES3_EDE_KEY_SIZE,
 		.setkey			= rk_tdes_setkey,
@@ -627,8 +627,8 @@ struct rk_crypto_tmp rk_cbc_des3_ede_alg = {
 		.base.cra_alignmask	= 0x07,
 		.base.cra_module	= THIS_MODULE,
 
-		.init			= rk_ablk_init_tfm,
-		.exit			= rk_ablk_exit_tfm,
+		.init			= rk_cipher_tfm_init,
+		.exit			= rk_cipher_tfm_exit,
 		.min_keysize		= DES3_EDE_KEY_SIZE,
 		.max_keysize		= DES3_EDE_KEY_SIZE,
 		.ivsize			= DES_BLOCK_SIZE,
-- 
2.35.1

