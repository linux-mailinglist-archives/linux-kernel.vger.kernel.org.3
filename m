Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8560C4CB0F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbiCBVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiCBVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5162DD97E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p9so4705253wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQNU+zESf8LDh+yao8Oc3gO6dXSE2ne6kHnyQ9VdhdQ=;
        b=XyO28tj3TU+B+3XLenZaHOAECDjiZQCjIzHC4Ys3oYIiUR3pcp4sGFhwBnqSZYe4a/
         Da4DZewdoOXXZsf7fHZ2CDBO7vZpEMLu7+MFtZ+1KtavfBY8GjwyAskpIwUzQwK6ljj0
         iBb5t+bvXd8ECvZiv1r3CVxPuDBRgQvDoLXehvLYbVLDLlXsl55m9+e4lu0Wy2eqmlfG
         2bTXSNOsVygIv+VFIb0s0XKSDfZYL8jEp7bZLuBCNTw7cZUtMYvZJycY0CZ3528KrFpO
         p8ScGO0EqTtUH8sUqks6Iy3zVymRj3cd5UnmueOGlON7/Qh8aPBdRcu8oUq9ELxHOR/C
         cDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQNU+zESf8LDh+yao8Oc3gO6dXSE2ne6kHnyQ9VdhdQ=;
        b=sRKizd/gWBcF6fSOOo7Hgmlbhhb9/p1tpW76f7FzRQbSnj253OIbd7+SGXj9es3nIJ
         XakKXa0caol63nKcmIqg81Bx9z2Ww8GIdf5RGsZ2K9OwkWXJ8e9dyrZOByLmLoXrG3EK
         su9ueEzjraa7XTkYPxLg1ybyrBikUdnJF+ks+cUHIm/um/U8rX0nI/EdUFd1oR+Xf4EJ
         Vi3HaX0j4y/g+dJA9/WIvb4DjVS4R4qrKFeZhDPQEANPCTRwMkMvDB6Zz+cbr4QrerwX
         WpI6dY2Fi10FtrTorzjAL5yEXErwAc/QMPD8XvYjZfsnGc2c2pVeZ0K9MrYAMrBJaz1g
         d4Sg==
X-Gm-Message-State: AOAM530qzV2yhHx5IK9EbvAcjuxLS8D1r6UpIuGp/4JDhrOhguBsIPRb
        4Vu1tfn/PIxASpJLdwBfysLcPA==
X-Google-Smtp-Source: ABdhPJzfWDf+uImBTOrxpwmcexKER/HJdZYcXbT6y4/9uwZp7eE8txba43Evn6iHNknG/kRArRh8fw==
X-Received: by 2002:a5d:59ae:0:b0:1f0:474c:d995 with SMTP id p14-20020a5d59ae000000b001f0474cd995mr2125020wrr.217.1646255488302;
        Wed, 02 Mar 2022 13:11:28 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:27 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 07/18] crypto: rockchip: add fallback for ahash
Date:   Wed,  2 Mar 2022 21:11:02 +0000
Message-Id: <20220302211113.4003816-8-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302211113.4003816-1-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
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

Adds a fallback for all case hardware cannot handle.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 49017d1fb510..16009bb0bf16 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -16,6 +16,40 @@
  * so we put the fixed hash out when met zero message.
  */
 
+static bool rk_ahash_need_fallback(struct ahash_request *req)
+{
+	struct scatterlist *sg;
+
+	sg = req->src;
+	while (sg) {
+		if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
+			return true;
+		}
+		if (sg->length % 4) {
+			return true;
+		}
+		sg = sg_next(sg);
+	}
+	return false;
+}
+
+static int rk_ahash_digest_fb(struct ahash_request *areq)
+{
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct rk_ahash_ctx *tfmctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->fallback_req, tfmctx->fallback_tfm);
+	rctx->fallback_req.base.flags = areq->base.flags &
+					CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	rctx->fallback_req.nbytes = areq->nbytes;
+	rctx->fallback_req.src = areq->src;
+	rctx->fallback_req.result = areq->result;
+
+	return crypto_ahash_digest(&rctx->fallback_req);
+}
+
 static int zero_message_process(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
@@ -167,6 +201,9 @@ static int rk_ahash_digest(struct ahash_request *req)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
 	struct rk_crypto_info *dev = tctx->dev;
 
+	if (rk_ahash_need_fallback(req))
+		return rk_ahash_digest_fb(req);
+
 	if (!req->nbytes)
 		return zero_message_process(req);
 	else
@@ -309,6 +346,7 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	free_page((unsigned long)tctx->dev->addr_vir);
+	crypto_free_ahash(tctx->fallback_tfm);
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
-- 
2.34.1

