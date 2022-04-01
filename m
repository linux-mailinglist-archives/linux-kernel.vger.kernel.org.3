Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275AE4EFB5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352471AbiDAUW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352269AbiDAUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:21:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC571275479
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i4so5804852wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmMWIduWjCG75dbMfIh377U57jp9KQ+fJ8N7ShE43i0=;
        b=iCOb7xcGmiDJGZEEwmOwRSgZmAeEqCofZBLz9uORgcAKd1JW3eQbctersVRWo85McY
         rIe1s5nrkEkko2Yzu74tK23nOMku457cE5Yik0t9DWWX0/ZKXEjbCe6xWW+0+xrCgVvB
         5ZDVMuJarY4MdNhONNwvDiXsD2UI3tonzd21e+lS8He8Du3C9AwFNOXp2/7fjPR6JiaK
         jVzX4f4bEccxEkEoxc4GF/AKp142ei/ewbyOqrkEObNC/hAXlGUefCevRdaLZ6DgQwqG
         /j9Qas4qsvNrTRzXqBqsxt+Zqce0dd4t1NB4+TYaSW+Ycd3I+Cysmr1fnslxJmKlogPe
         urwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmMWIduWjCG75dbMfIh377U57jp9KQ+fJ8N7ShE43i0=;
        b=0s8TtcYoUHwvf9fIjSyH3f+zJ7IPhyYE5W9FCmallfRL0o8u0lKpuY8y0kny1Gvgwm
         uPBUUDlsEAaFftyIRdX6kctQH8VlNRc1jSXfTATxULR8+J4hxTdgK7de/kcijSGtOLCM
         s/0gFraMduObF9NlFM+zTwyn3P/azmQwMC7+xy9eHKP/5h4zPPqGewra+65TE2YrSlW+
         luMHBhwRzdehYVEZL2yEX3kijqHlpWEZlpyg58x52u/MRoDDFU3dNyFsqVY6HI7vsdVV
         VNi4H3rxBcOad6z6IqP7r9oKTdUMVyqkUssDkQGiU967nrY5kS5/M1cwSd0rN1Uknb+1
         ZJnQ==
X-Gm-Message-State: AOAM531lN67oJJEdYv6hjlTdbueF+hhD7a9ewVVuIImFqO1JKRzEzVPg
        rTfFT5QmdzTpl/Bc28IDfWXImA==
X-Google-Smtp-Source: ABdhPJxC2je769eC2muQ9PYHUKYXzUhLQ7XENmM5w1C5aNMM6oH3VYBGe7cmrBo+ni6IwQn9i6ygaw==
X-Received: by 2002:adf:eb88:0:b0:205:e113:dcb5 with SMTP id t8-20020adfeb88000000b00205e113dcb5mr8748233wrn.598.1648844309956;
        Fri, 01 Apr 2022 13:18:29 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:29 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>, Igor Velkov <iav@iav.lv>
Subject: [PATCH v4 26/33] crypto: rockchip: Add support for rk3399
Date:   Fri,  1 Apr 2022 20:17:57 +0000
Message-Id: <20220401201804.2867154-27-clabbe@baylibre.com>
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

The rk3399 has 2 rk3288 compatible crypto device named crypto0 and
crypto1. The only difference is lack of RSA in crypto1.
For using both, crypto0 will be the main device (owning crypto algos)
and crypto1 will register itself against crypto0.
Then the driver will round robin each request on each device.

Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
Tested-by: Igor Velkov <iav@iav.lv>

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c       | 95 ++++++++++++++++---
 drivers/crypto/rockchip/rk3288_crypto.h       | 10 +-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 22 +++--
 .../crypto/rockchip/rk3288_crypto_skcipher.c  | 13 ++-
 4 files changed, 120 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 6147ce44f757..89a6aa65d2c1 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -14,10 +14,35 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
 #include <linux/reset.h>
 
+/*
+ * RK339 has 2 crypto IP named crypto0/crypto1
+ * crypto0 is the main crypto instance, it registers crypto algorithm and debugfs
+ * crypto1 will wait that crypto0 finish to initialize (waiting the main
+ * variable below is set) and then will register as a subdevice
+ */
+static struct rk_crypto_info *main;
+
+static const struct rk_variant rk3288_variant = {
+	.main = true,
+};
+
+static const struct rk_variant rk3328_variant = {
+	.main = true,
+};
+
+static const struct rk_variant rk3399_variant0 = {
+	.main = true,
+};
+
+static const struct rk_variant rk3399_variant1 = {
+	.sub = true,
+};
+
 static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 {
 	int err;
@@ -113,8 +138,14 @@ static struct rk_crypto_tmp *rk_cipher_algs[] = {
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
 static int rk_crypto_debugfs_show(struct seq_file *seq, void *v)
 {
+	struct rk_crypto_info *rk = seq->private;
 	unsigned int i;
 
+	if (rk->sub) {
+		seq_printf(seq, "Main device requests: %lu\n", rk->nreq);
+		seq_printf(seq, "Sub-device requests: %lu\n", rk->sub->nreq);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		if (!rk_cipher_algs[i]->dev)
 			continue;
@@ -150,6 +181,11 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 	unsigned int i, k;
 	int err = 0;
 
+	if (!crypto_info->variant->main) {
+		dev_info(crypto_info->dev, "We are not main, do not register algos\n");
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		rk_cipher_algs[i]->dev = crypto_info;
 		switch (rk_cipher_algs[i]->type) {
@@ -183,10 +219,15 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 	return err;
 }
 
-static void rk_crypto_unregister(void)
+static void rk_crypto_unregister(struct rk_crypto_info *crypto_info)
 {
 	unsigned int i;
 
+	if (!crypto_info->variant->main) {
+		dev_info(crypto_info->dev, "We are not main, do not unregister algos\n");
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		if (rk_cipher_algs[i]->type == CRYPTO_ALG_TYPE_SKCIPHER)
 			crypto_unregister_skcipher(&rk_cipher_algs[i]->alg.skcipher);
@@ -196,8 +237,18 @@ static void rk_crypto_unregister(void)
 }
 
 static const struct of_device_id crypto_of_id_table[] = {
-	{ .compatible = "rockchip,rk3288-crypto" },
-	{ .compatible = "rockchip,rk3328-crypto" },
+	{ .compatible = "rockchip,rk3288-crypto",
+	  .data = &rk3288_variant,
+	},
+	{ .compatible = "rockchip,rk3328-crypto",
+	  .data = &rk3328_variant,
+	},
+	{ .compatible = "rockchip,rk3399-crypto0",
+	  .data = &rk3399_variant0,
+	},
+	{ .compatible = "rockchip,rk3399-crypto1",
+	  .data = &rk3399_variant1,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, crypto_of_id_table);
@@ -215,7 +266,18 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->rst = devm_reset_control_get(dev, "crypto-rst");
+	crypto_info->variant = of_device_get_match_data(&pdev->dev);
+	if (!crypto_info->variant) {
+		dev_err(&pdev->dev, "Missing variant\n");
+		return -EINVAL;
+	}
+
+	if (crypto_info->variant->sub && !main) {
+		dev_info(&pdev->dev, "Main is not here yet\n");
+		return -EPROBE_DEFER;
+	}
+
+	crypto_info->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(crypto_info->rst)) {
 		err = PTR_ERR(crypto_info->rst);
 		goto err_crypto;
@@ -268,15 +330,24 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
-	/* Ignore error of debugfs */
-	crypto_info->dbgfs_dir = debugfs_create_dir("rk3288_crypto", NULL);
-	crypto_info->dbgfs_stats = debugfs_create_file("stats", 0444,
-						       crypto_info->dbgfs_dir,
-						       crypto_info,
-						       &rk_crypto_debugfs_fops);
+	if (crypto_info->variant->main) {
+		/* Ignore error of debugfs */
+		crypto_info->dbgfs_dir = debugfs_create_dir("rk3288_crypto", NULL);
+		crypto_info->dbgfs_stats = debugfs_create_file("stats", 0444,
+							       crypto_info->dbgfs_dir,
+							       crypto_info,
+							       &rk_crypto_debugfs_fops);
+	}
 #endif
 
-	dev_info(dev, "Crypto Accelerator successfully registered\n");
+	if (crypto_info->variant->main) {
+		dev_info(dev, "Crypto Accelerator main successfully registered\n");
+		main = crypto_info;
+	} else {
+		dev_info(dev, "Crypto Accelerator sub successfully registered\n");
+		main->sub = crypto_info;
+	}
+
 	return 0;
 
 err_register_alg:
@@ -295,7 +366,7 @@ static int rk_crypto_remove(struct platform_device *pdev)
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
 	debugfs_remove_recursive(crypto_tmp->dbgfs_dir);
 #endif
-	rk_crypto_unregister();
+	rk_crypto_unregister(crypto_tmp);
 	rk_crypto_pm_exit(crypto_tmp);
 	crypto_engine_exit(crypto_tmp->engine);
 	return 0;
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 8cd753085128..5662a1491a9e 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -188,6 +188,11 @@
 #define CRYPTO_WRITE(dev, offset, val)	  \
 		writel_relaxed((val), ((dev)->reg + (offset)))
 
+struct rk_variant {
+	bool main;
+	bool sub;
+};
+
 struct rk_crypto_info {
 	struct device			*dev;
 	struct clk_bulk_data		*clks;
@@ -195,7 +200,10 @@ struct rk_crypto_info {
 	struct reset_control		*rst;
 	void __iomem			*reg;
 	int				irq;
-
+	const struct rk_variant *variant;
+	struct rk_crypto_info *sub;
+	atomic_t flow;
+	unsigned long nreq;
 	struct crypto_engine *engine;
 	struct completion complete;
 	int status;
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 0372b0f7a558..3a2a939a3f2b 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -78,12 +78,10 @@ static int zero_message_process(struct ahash_request *req)
 	return 0;
 }
 
-static void rk_ahash_reg_init(struct ahash_request *req)
+static void rk_ahash_reg_init(struct ahash_request *req,
+			      struct rk_crypto_info *dev)
 {
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *dev = tctx->main;
 	int reg_status;
 
 	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
@@ -203,6 +201,7 @@ static int rk_ahash_digest(struct ahash_request *req)
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
 	struct rk_crypto_info *dev = tctx->main;
+	struct crypto_engine *engine;
 
 	if (rk_ahash_need_fallback(req))
 		return rk_ahash_digest_fb(req);
@@ -210,9 +209,13 @@ static int rk_ahash_digest(struct ahash_request *req)
 	if (!req->nbytes)
 		return zero_message_process(req);
 
+	if (dev->sub && atomic_inc_return(&dev->flow) % 2)
+		dev = dev->sub;
+
 	rctx->dev = dev;
+	engine = dev->engine;
 
-	return crypto_transfer_hash_request_to_engine(dev->engine, req);
+	return crypto_transfer_hash_request_to_engine(engine, req);
 }
 
 static void crypto_ahash_dma_start(struct rk_crypto_info *dev, struct scatterlist *sg)
@@ -270,6 +273,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	rctx->mode = 0;
 
 	algt->stat_req++;
+	rkc->nreq++;
 
 	switch (crypto_ahash_digestsize(tfm)) {
 	case SHA1_DIGEST_SIZE:
@@ -286,7 +290,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		goto theend;
 	}
 
-	rk_ahash_reg_init(areq);
+	rk_ahash_reg_init(areq, rkc);
 
 	while (sg) {
 		reinit_completion(&rkc->complete);
@@ -360,6 +364,10 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
 	err = pm_runtime_resume_and_get(tctx->main->dev);
 	if (err < 0)
 		goto error_pm;
+	if (tctx->main->sub)
+		err = pm_runtime_resume_and_get(tctx->main->sub->dev);
+	if (err < 0)
+		goto error_pm;
 
 	return 0;
 error_pm:
@@ -374,6 +382,8 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
 
 	crypto_free_ahash(tctx->fallback_tfm);
 	pm_runtime_put_autosuspend(tctx->main->dev);
+	if (tctx->main->sub)
+		pm_runtime_put_autosuspend(tctx->main->sub->dev);
 }
 
 struct rk_crypto_tmp rk_ahash_sha1 = {
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index d0bc8b4fb277..08e4db83f7da 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -98,11 +98,15 @@ static int rk_cipher_handle_req(struct skcipher_request *req)
 	struct rk_cipher_ctx *tctx = crypto_skcipher_ctx(tfm);
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_crypto_info *rkc = tctx->main;
-	struct crypto_engine *engine = rkc->engine;
+	struct crypto_engine *engine;
 
 	if (rk_cipher_need_fallback(req))
 		return rk_cipher_fallback(req);
 
+	if (rkc->sub && atomic_inc_return(&rkc->flow) % 2)
+		rkc = rkc->sub;
+
+	engine = rkc->engine;
 	rctx->dev = rkc;
 
 	return crypto_transfer_skcipher_request_to_engine(engine, req);
@@ -319,6 +323,7 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	struct rk_crypto_info *rkc = rctx->dev;
 
 	algt->stat_req++;
+	rkc->nreq++;
 
 	ivsize = crypto_skcipher_ivsize(tfm);
 	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
@@ -456,6 +461,10 @@ static int rk_cipher_tfm_init(struct crypto_skcipher *tfm)
 	err = pm_runtime_resume_and_get(ctx->main->dev);
 	if (err < 0)
 		goto error_pm;
+	if (ctx->main->sub)
+		err = pm_runtime_resume_and_get(ctx->main->sub->dev);
+	if (err < 0)
+		goto error_pm;
 
 	return 0;
 error_pm:
@@ -470,6 +479,8 @@ static void rk_cipher_tfm_exit(struct crypto_skcipher *tfm)
 	memzero_explicit(ctx->key, ctx->keylen);
 	crypto_free_skcipher(ctx->fallback_tfm);
 	pm_runtime_put_autosuspend(ctx->main->dev);
+	if (ctx->main->sub)
+		pm_runtime_put_autosuspend(ctx->main->sub->dev);
 }
 
 struct rk_crypto_tmp rk_ecb_aes_alg = {
-- 
2.35.1

