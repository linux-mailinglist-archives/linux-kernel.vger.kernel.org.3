Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E94C78EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiB1Trx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiB1Tro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:47:44 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FCD2013FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:55 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso46682wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCxawyPN6KRYTDCClsWI1h6jdnBe5QeH3y4o4F1jrpo=;
        b=3IAAXcoMB/QWoNPp+N9bkTEFatjqZ+FxiKj9BAVrYt8LgdvWno/p1QehD/UBSMSjuV
         98O8OxoZd6+bNpZbykPbdt+ZENX7K8cFL56i/qmrA0p4P2jQHb9BSKs3BO7x1WU0Iyk0
         73vzMa8pTN+73Mm3gfrqJ3EdW8SzPwG+U9wIlgC3KA5qW8Bg6uUydpuHvQFTB87OTUPA
         hRTHlII00H/4/r4lhXe6coKagre4g6u+sKqNjOyq6rbyp6xC3WiEhoH/wjZcuRSI123x
         1RYwQHjCQRxW0ZsIFMxEAvHWfCEJ0D8rOd4aS0v2rcyAOljcqO3H9Qh/QkyBrjHP2mW8
         z4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCxawyPN6KRYTDCClsWI1h6jdnBe5QeH3y4o4F1jrpo=;
        b=GpSat6U7XuOuHGjFOz/HGMRMOUr0xlDwnynQdSbMKvJHOrmUL/o4j21sR63huyruKD
         9Pqwe28X7Ba+I7F1F/AlMSGuG+4zfPTsF9M7JDVZo2jNbnkWWWF2DjpdzFyIX8DCaban
         0sSdPWpv498KPpwgDJQR48XxO5K3EOymO+jJgQG6TLeAuJxFsasLK1ZHOjHiQfhuzeNX
         Bbm8az1E/G7KhgrpQwjlYlv0vdQahgG8yBXajWfsmY7mqrRZEz4uTrJxlK2cht+ce8AC
         s9ePaVWGGYCKc2SNoO/liolTodN8d8zFiYnW9W87BBlUkWRF8UeIjDB0lZ9PVVFxUV35
         5ZDw==
X-Gm-Message-State: AOAM532nvgZofn1O0T/ICvdGRYtfxnmiK3pZHdQaTeo5ldDcNQfe8d4K
        6aTWH7FdQVe7I1kBstOQ5lbhCA==
X-Google-Smtp-Source: ABdhPJzSnyPGk1bcVR3Uj3aicAkHUWmsSHM0wTSzjgYpQbnk/rQJotEYJBRraFHPWhRkjXg6nBqEGA==
X-Received: by 2002:a05:600c:35c2:b0:381:6cbc:7192 with SMTP id r2-20020a05600c35c200b003816cbc7192mr3955472wmq.146.1646077245906;
        Mon, 28 Feb 2022 11:40:45 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 03/16] crypto: rockchip: do not do custom power management
Date:   Mon, 28 Feb 2022 19:40:24 +0000
Message-Id: <20220228194037.1600509-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
2.34.1

