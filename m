Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B05A97E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiIAM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiIAM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:58:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810948E441
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so9578852wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cJjKlAvPGNgNOZFjIKeGYWIyXJ/4+hZsDzTA+cA/SLw=;
        b=wGdoG7WwD1DTQaxYvSjdyYTFhMM2DSiKk4dZIebMAPE4IDp9Pav0bUVx+8H0kQsjJ0
         Aw7ff4eRiO+5kUQ1UqDeAbhm3MBzkDQXVgSMyu3gpzApqjZfOezJIieK+UfmrFa/hoet
         3uwD376zi9IvoiWVYFZ5CEHilbqh3Yxf9DqrtsJjoNSRV+uO6Swod+Tmud7pP3ZuOiGO
         g2f7+cR+YL1lWRMbj6EOmhE652NTY1FOHIJb3fFzWBUpogn76HDgHLyFYz1t5CYYXQjp
         Y1CsWApH/OzKw8L3uojY2ivtWWlSy+M8liYRsaZ2RnLxL6ICmGq1J89pNg2Ah/oGN5qK
         sgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cJjKlAvPGNgNOZFjIKeGYWIyXJ/4+hZsDzTA+cA/SLw=;
        b=YuYWMuB85tbTD1/MCT2fcWav1DUPl7SF07TtMnPwbc6P/Dqz+N4AP4JSwRGY3QH0Th
         L0kRrYqjtawHTlZaUwJ9jriLyCJEgx2Eka3zXPdV1LFd1SLKDaZCXyVDzRoxlymuyv4F
         Yf4k6cJXWaLYdU/Bm7lEfuowr1YuhE3tdHVqpIh25fw/g8cWRP1F4ThZxe6rt0X3h8H+
         eG0bqDTpMgsEi0ZNgAjTliJ8bcDk45NCuqahInF6Ga4i6j+/YTXDFsx1oPV61zMHVIUr
         UgiPTxEkAhTS34Cop/0lbz4/CrOtFQDKwj+ebN/rs2FziWjiXiRDDSB3+gJgd/GJUPLY
         q9Zw==
X-Gm-Message-State: ACgBeo3yBHCksVja9+z5wALkI6KJvmVENeI2TpYfz6Pq4oyfsXJBMPRf
        +5Djl+e3Vabo5W3jceSlwVOxnA==
X-Google-Smtp-Source: AA6agR7KCPYby6UPwi1dWbs2Q0y2ejlUUF0cDhqpw9BUMMCz+elwE2E79rzF4vvlZWCFllMHU63Xow==
X-Received: by 2002:a05:6000:1684:b0:225:74d5:7b01 with SMTP id y4-20020a056000168400b0022574d57b01mr15177303wrd.410.1662037058536;
        Thu, 01 Sep 2022 05:57:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v9 21/33] crypto: rockchip: rework rk_handle_req function
Date:   Thu,  1 Sep 2022 12:56:58 +0000
Message-Id: <20220901125710.3733083-22-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901125710.3733083-1-clabbe@baylibre.com>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
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

This patch rework the rk_handle_req(), simply removing the
rk_crypto_info parameter.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 68 +++++--------------
 1 file changed, 17 insertions(+), 51 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index d60c206e717d..3187869c4c68 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -82,10 +82,12 @@ static int rk_cipher_fallback(struct skcipher_request *areq)
 	return err;
 }
 
-static int rk_handle_req(struct rk_crypto_info *dev,
-			 struct skcipher_request *req)
+static int rk_cipher_handle_req(struct skcipher_request *req)
 {
-	struct crypto_engine *engine = dev->engine;
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct rk_cipher_ctx *tctx = crypto_skcipher_ctx(tfm);
+	struct rk_crypto_info *rkc = tctx->dev;
+	struct crypto_engine *engine = rkc->engine;
 
 	if (rk_cipher_need_fallback(req))
 		return rk_cipher_fallback(req);
@@ -142,135 +144,99 @@ static int rk_tdes_setkey(struct crypto_skcipher *cipher,
 
 static int rk_aes_ecb_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_AES_ECB_MODE;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_aes_ecb_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_AES_ECB_MODE | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_aes_cbc_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_AES_CBC_MODE;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_aes_cbc_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_AES_CBC_MODE | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des_ecb_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = 0;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des_ecb_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des_cbc_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des_cbc_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_TDES_CHAINMODE_CBC | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des3_ede_ecb_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_TDES_SELECT;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des3_ede_ecb_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des3_ede_cbc_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static int rk_des3_ede_cbc_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
-	struct rk_crypto_info *dev = ctx->dev;
 
 	rctx->mode = RK_CRYPTO_TDES_SELECT | RK_CRYPTO_TDES_CHAINMODE_CBC |
 		    RK_CRYPTO_DEC;
-	return rk_handle_req(dev, req);
+	return rk_cipher_handle_req(req);
 }
 
 static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_request *req)
-- 
2.35.1

