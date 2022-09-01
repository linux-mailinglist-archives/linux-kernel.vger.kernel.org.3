Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682955A979E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiIAM5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiIAM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:57:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0F857EA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k17so8978572wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=859E0YEubESiyrb+oeUTAg5/XBxqc58UKlJ7e69ztp0=;
        b=gQW24ZZBY/n9hVZN4h1VoaLidzrVJzi2qTNz9efgPt2L5hBRxnm/BFl7MX9rwgHKTz
         lc3b/JKwG5VPyp7urYO0lzQPNczxuKOXhtzPbvrQOC9+CC4jSbMmuLvzjCppptHuwzaw
         WxbmwR5+amoW70MfzPhAXf0RqbfwedSWiBmG4kl9sOQdZGROwZIH1nhZm2ITOy6XZXud
         oLRWYMDQvtdBBZ+F+im/ZZLpKM5Uk1WadgWnmmEqw8337QcYbNHcACMoc4CTAAFdKR+m
         5Pp2IPteWEFZfBj8zs6o4AkIgr4vE+hxYOwHJGfwJoQz2tCSa2Dk3SwG5WY1UejTxkuf
         7i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=859E0YEubESiyrb+oeUTAg5/XBxqc58UKlJ7e69ztp0=;
        b=i6R7obNrZtH3xlKLXX2xCTrv/lkLid69FWhboA1eMyjMibToo3wrvayA9X9spSgsYu
         jODr2S6/xS4OqM9efatiZOp/N0hGnIjFu6MaoG9AR9nHRi41tsX3+Q1JvYg22SuvgyMh
         hf/kiMmAL3G/wTFybfr3Wf3UQo3UnN4Hn8mDXUpZ5nwL2pW0R3ZNXYu+Bzun9g4LIBFB
         V+Wfxrt3suu6r0zbx/xREJkQcELN0LSHGKiKLVmT6/eAobPLff3vklTDWlU2Y+fY8ZLC
         57rPKN5EInJPFHcCJu1p3HgSa2PCNTmIGLczzbLE9y5dAIWmBzwqrAO9T3EGefeAanOf
         z/CQ==
X-Gm-Message-State: ACgBeo0U3OHbFdg+7M0vS1p2j6weDW5BGXEpaubq2FG7h0ggHGkegFjD
        7n/E+l7K1BLPFQd0TPrVovvb/A==
X-Google-Smtp-Source: AA6agR6Nae+HpnChmEI8Os+s9n1ihbDr+z5KuZggYMuv35afWoficJpM+SyI3C9MLSWmyPMe4uOdCw==
X-Received: by 2002:a05:600c:4f53:b0:3a6:9d3c:47e9 with SMTP id m19-20020a05600c4f5300b003a69d3c47e9mr5266713wmq.116.1662037039998;
        Thu, 01 Sep 2022 05:57:19 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v9 03/33] crypto: rockchip: do not do custom power management
Date:   Thu,  1 Sep 2022 12:56:40 +0000
Message-Id: <20220901125710.3733083-4-clabbe@baylibre.com>
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

The clock enable/disable at tfm init/exit is fragile,
if 2 tfm are init in the same time and one is removed just after,
it will leave the hardware uncloked even if a user remains.

Instead simply enable clocks at probe time.
We will do PM later.

Fixes: ce0183cb6464b ("crypto: rockchip - switch to skcipher API")
Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c          | 4 ++--
 drivers/crypto/rockchip/rk3288_crypto.h          | 2 --
 drivers/crypto/rockchip/rk3288_crypto_ahash.c    | 3 +--
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 5 +++--
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 21d3f1458584..4cff49b82983 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -394,8 +394,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		     rk_crypto_done_task_cb, (unsigned long)crypto_info);
 	crypto_init_queue(&crypto_info->queue, 50);
 
-	crypto_info->enable_clk = rk_crypto_enable_clk;
-	crypto_info->disable_clk = rk_crypto_disable_clk;
+	rk_crypto_enable_clk(crypto_info);
 	crypto_info->load_data = rk_load_data;
 	crypto_info->unload_data = rk_unload_data;
 	crypto_info->enqueue = rk_crypto_enqueue;
@@ -422,6 +421,7 @@ static int rk_crypto_remove(struct platform_device *pdev)
 	struct rk_crypto_info *crypto_tmp = platform_get_drvdata(pdev);
 
 	rk_crypto_unregister();
+	rk_crypto_disable_clk(crypto_tmp);
 	tasklet_kill(&crypto_tmp->done_task);
 	tasklet_kill(&crypto_tmp->queue_task);
 	return 0;
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 97278c2574ff..2fa7131e4060 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -220,8 +220,6 @@ struct rk_crypto_info {
 	int (*start)(struct rk_crypto_info *dev);
 	int (*update)(struct rk_crypto_info *dev);
 	void (*complete)(struct crypto_async_request *base, int err);
-	int (*enable_clk)(struct rk_crypto_info *dev);
-	void (*disable_clk)(struct rk_crypto_info *dev);
 	int (*load_data)(struct rk_crypto_info *dev,
 			 struct scatterlist *sg_src,
 			 struct scatterlist *sg_dst);
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index ed03058497bc..49017d1fb510 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -301,7 +301,7 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 				 sizeof(struct rk_ahash_rctx) +
 				 crypto_ahash_reqsize(tctx->fallback_tfm));
 
-	return tctx->dev->enable_clk(tctx->dev);
+	return 0;
 }
 
 static void rk_cra_hash_exit(struct crypto_tfm *tfm)
@@ -309,7 +309,6 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	free_page((unsigned long)tctx->dev->addr_vir);
-	return tctx->dev->disable_clk(tctx->dev);
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 5bbf0d2722e1..8c44a19eab75 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -388,8 +388,10 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
 	ctx->dev->update = rk_ablk_rx;
 	ctx->dev->complete = rk_crypto_complete;
 	ctx->dev->addr_vir = (char *)__get_free_page(GFP_KERNEL);
+	if (!ctx->dev->addr_vir)
+		return -ENOMEM;
 
-	return ctx->dev->addr_vir ? ctx->dev->enable_clk(ctx->dev) : -ENOMEM;
+	return 0;
 }
 
 static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
@@ -397,7 +399,6 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	free_page((unsigned long)ctx->dev->addr_vir);
-	ctx->dev->disable_clk(ctx->dev);
 }
 
 struct rk_crypto_tmp rk_ecb_aes_alg = {
-- 
2.35.1

