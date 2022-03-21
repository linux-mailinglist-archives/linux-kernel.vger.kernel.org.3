Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C44E3172
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353124AbiCUUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353008AbiCUUJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19E154059
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so4254082wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHOz18mOxmFMMtKt0o540U9gTFJ/b9JmGBo5H/9UdMU=;
        b=LuQPUBXWZOpDbwZ1YCfAxxpQxme/kyvgeHyDE6wAI/F/xnR+RYEq8VxTfwjtEisP2U
         rVg/dYRMQvZrnb5zBZ2zrV0Y732DEIY0ElGsLCJkKglNA9j7LeUp2b2IZ9PeMKnaHfUt
         wy/mtADbyocrOUmyADeh7AEHQpKZwAWl0gKh7zwIJKzoBn80jphLCrsDTV8hYLwoigpS
         N2f0E5qfLUeXb/F5iQqH3TIbbjlKEYfMrQhZQZwqkf7wg41WaNLNJ0Xk4uSZPGSMru68
         wnHbXtx7j0gqtpnDU+X3KU0t4XneYjAr3eFiSLnsrz/o6GByEHpbTQ/A1lTtGfieuuxH
         zUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHOz18mOxmFMMtKt0o540U9gTFJ/b9JmGBo5H/9UdMU=;
        b=VFCKD3TVLZ4Nvjaa2zAu9TgSIyypZZ4Uj0thEk0XkS+yUhQrAAZS7c3+Rc4DE3DTbw
         poHD52uztXsfWPEN5PpUF5s+0ckoHwPZAYok2/wzmxywckcH+MCLJzKXGootgJvCwF1g
         9Ox7e9qvWF14Y2nuaOwDKoF2ZSBJZ9gePCmF01tAEGEFGbRSPlmoEHhghRT3ucBWqDwM
         9FGEdUY3/93B4lahd99dx+dXLLsp2h/LQxWxu/X+MSYpnJJoTM5NDC/5DxVzfIQfbCkE
         I74vzzz7QVc7eYlSNRvadPTs7L3g6zXASTbxfLEPHnhVURvGWzfK+n1WSfKHGC2FFEXT
         I2Zw==
X-Gm-Message-State: AOAM531gGgv7JJVdkr2TVtBDRYvTmzpbpr3lYXxnLvf6MSiGjK5PEdLE
        W4z99hnC6psdUJAfUmSk9tmp5A==
X-Google-Smtp-Source: ABdhPJx25lCFurNfXtsAe8CjsnIdG4+jKGImGSESGACBQRcR501itJtp9xA6jYnooZhZBlTUIDkaOw==
X-Received: by 2002:a5d:4441:0:b0:1f0:882d:77e9 with SMTP id x1-20020a5d4441000000b001f0882d77e9mr18936245wrr.718.1647893281879;
        Mon, 21 Mar 2022 13:08:01 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:08:01 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 16/26] crypto: rockchip: add support for r3399
Date:   Mon, 21 Mar 2022 20:07:29 +0000
Message-Id: <20220321200739.3572792-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321200739.3572792-1-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
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

The RK3399 has 2 crypto identical IP, so let's add support for both.
We need also to handle all rk3399-cryto's resets.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c       | 111 +++++++++++-------
 drivers/crypto/rockchip/rk3288_crypto.h       |  32 +++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c |  65 +++++-----
 .../crypto/rockchip/rk3288_crypto_skcipher.c  |  51 ++++----
 4 files changed, 160 insertions(+), 99 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 97ef59a36be6..5f1422094a7f 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -14,10 +14,19 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
 #include <linux/reset.h>
 
+static const struct rk_variant rk3288_variant = {
+	.num_instance = 1
+};
+
+static const struct rk_variant rk3399_variant = {
+	.num_instance = 2
+};
+
 static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 {
 	int err;
@@ -82,19 +91,25 @@ static void rk_crypto_pm_exit(struct rk_crypto_info *rkdev)
 
 static irqreturn_t rk_crypto_irq_handle(int irq, void *dev_id)
 {
-	struct rk_crypto_info *dev  = platform_get_drvdata(dev_id);
+	struct rk_crypto_info *dev = platform_get_drvdata(dev_id);
+	void __iomem *reg;
 	u32 interrupt_status;
+	int i;
 
-	interrupt_status = CRYPTO_READ(dev, RK_CRYPTO_INTSTS);
-	CRYPTO_WRITE(dev, RK_CRYPTO_INTSTS, interrupt_status);
+	for (i = 0; i < dev->variant->num_instance; i++) {
+		if (dev->rki[i].irq != irq)
+			continue;
+		reg = dev->rki[i].reg;
+		interrupt_status = readl(reg + RK_CRYPTO_INTSTS);
+		writel(interrupt_status, reg + RK_CRYPTO_INTSTS);
 
-	dev->status = 1;
-	if (interrupt_status & 0x0a) {
-		dev_warn(dev->dev, "DMA Error\n");
-		dev->status = 0;
+		dev->rki[i].status = 1;
+		if (interrupt_status & 0x0a) {
+			dev->rki[i].status = 0;
+		}
+		complete(&dev->rki[i].complete);
+		return IRQ_HANDLED;
 	}
-	complete(&dev->complete);
-
 	return IRQ_HANDLED;
 }
 
@@ -152,6 +167,7 @@ static int rk_crypto_register(struct rk_crypto_info *crypto_info)
 
 	for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
 		rk_cipher_algs[i]->dev = crypto_info;
+
 		switch (rk_cipher_algs[i]->type) {
 		case CRYPTO_ALG_TYPE_SKCIPHER:
 			dev_info(crypto_info->dev, "Register %s as %s\n",
@@ -196,7 +212,12 @@ static void rk_crypto_unregister(void)
 }
 
 static const struct of_device_id crypto_of_id_table[] = {
-	{ .compatible = "rockchip,rk3288-crypto" },
+	{ .compatible = "rockchip,rk3288-crypto",
+	  .data = &rk3288_variant,
+	},
+	{ .compatible = "rockchip,rk3399-crypto",
+	  .data = &rk3399_variant,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, crypto_of_id_table);
@@ -206,6 +227,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rk_crypto_info *crypto_info;
 	int err = 0;
+	int i;
 
 	crypto_info = devm_kzalloc(&pdev->dev,
 				   sizeof(*crypto_info), GFP_KERNEL);
@@ -214,48 +236,54 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->rst = devm_reset_control_get(dev, "crypto-rst");
-	if (IS_ERR(crypto_info->rst)) {
-		err = PTR_ERR(crypto_info->rst);
-		goto err_crypto;
+	crypto_info->variant = of_device_get_match_data(&pdev->dev);
+	if (!crypto_info->variant) {
+		dev_err(&pdev->dev, "Missing variant\n");
+		return -EINVAL;
 	}
 
-	crypto_info->reg = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(crypto_info->reg)) {
-		err = PTR_ERR(crypto_info->reg);
-		goto err_crypto;
-	}
+	for (i = 0; i < crypto_info->variant->num_instance; i++) {
+		crypto_info->rki[i].reg = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(crypto_info->rki[i].reg)) {
+			err = PTR_ERR(crypto_info->rki[i].reg);
+			goto err_crypto;
+		}
+		crypto_info->rki[i].irq = platform_get_irq(pdev, i);
+		if (crypto_info->rki[i].irq < 0) {
+			dev_err(&pdev->dev, "control Interrupt is not available.\n");
+			err = crypto_info->rki[i].irq;
+			goto err_crypto;
+		}
 
-	crypto_info->num_clks = devm_clk_bulk_get_all(&pdev->dev,
-						      &crypto_info->clks);
-	if (crypto_info->num_clks < 3) {
-		err = -EINVAL;
-		goto err_crypto;
+		err = devm_request_irq(&pdev->dev, crypto_info->rki[i].irq,
+				       rk_crypto_irq_handle, IRQF_SHARED,
+				       "rk-crypto", pdev);
+
+		if (err) {
+			dev_err(&pdev->dev, "irq request failed.\n");
+			goto err_crypto;
+		}
+		init_completion(&crypto_info->rki[i].complete);
+		crypto_info->rki[i].engine = crypto_engine_alloc_init(&pdev->dev, true);
+		crypto_engine_start(crypto_info->rki[i].engine);
 	}
 
-	crypto_info->irq = platform_get_irq(pdev, 0);
-	if (crypto_info->irq < 0) {
-		dev_err(&pdev->dev, "control Interrupt is not available.\n");
-		err = crypto_info->irq;
+	crypto_info->rst = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(crypto_info->rst)) {
+		err = PTR_ERR(crypto_info->rst);
 		goto err_crypto;
 	}
 
-	err = devm_request_irq(&pdev->dev, crypto_info->irq,
-			       rk_crypto_irq_handle, IRQF_SHARED,
-			       "rk-crypto", pdev);
-
-	if (err) {
-		dev_err(&pdev->dev, "irq request failed.\n");
+	crypto_info->num_clks = devm_clk_bulk_get_all(&pdev->dev,
+			&crypto_info->clks);
+	if (crypto_info->num_clks < 3) {
+		err = -EINVAL;
 		goto err_crypto;
 	}
 
 	crypto_info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, crypto_info);
 
-	crypto_info->engine = crypto_engine_alloc_init(&pdev->dev, true);
-	crypto_engine_start(crypto_info->engine);
-	init_completion(&crypto_info->complete);
-
 	err = rk_crypto_pm_init(crypto_info);
 	if (err)
 		goto err_pm;
@@ -281,7 +309,8 @@ static int rk_crypto_probe(struct platform_device *pdev)
 err_register_alg:
 	rk_crypto_pm_exit(crypto_info);
 err_pm:
-	crypto_engine_exit(crypto_info->engine);
+	for (i = 0; i < crypto_info->variant->num_instance; i++)
+		crypto_engine_exit(crypto_info->rki[i].engine);
 err_crypto:
 	dev_err(dev, "Crypto Accelerator not successfully registered\n");
 	return err;
@@ -290,13 +319,15 @@ static int rk_crypto_probe(struct platform_device *pdev)
 static int rk_crypto_remove(struct platform_device *pdev)
 {
 	struct rk_crypto_info *crypto_tmp = platform_get_drvdata(pdev);
+	int i;
 
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
 	debugfs_remove_recursive(crypto_tmp->dbgfs_dir);
 #endif
 	rk_crypto_unregister();
 	rk_crypto_pm_exit(crypto_tmp);
-	crypto_engine_exit(crypto_tmp->engine);
+	for (i = 0; i < crypto_tmp->variant->num_instance; i++)
+		crypto_engine_exit(crypto_tmp->rki[i].engine);
 	return 0;
 }
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index b6cd67d1d0cb..e1dac351bc64 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -183,28 +183,38 @@
 #define RK_CRYPTO_HASH_DOUT_6		0x01a4
 #define RK_CRYPTO_HASH_DOUT_7		0x01a8
 
-#define CRYPTO_READ(dev, offset)		  \
-		readl_relaxed(((dev)->reg + (offset)))
-#define CRYPTO_WRITE(dev, offset, val)	  \
-		writel_relaxed((val), ((dev)->reg + (offset)))
+struct rk_variant {
+	int num_instance;
+};
+
+struct rk_instance {
+	void __iomem			*reg;
+	int				irq;
+	struct completion complete;
+	struct crypto_engine *engine;
+	int status;
+};
 
 struct rk_crypto_info {
 	struct device			*dev;
 	struct clk_bulk_data		*clks;
 	int num_clks;
 	struct reset_control		*rst;
-	void __iomem			*reg;
-	int				irq;
-
-	struct crypto_engine *engine;
-	struct completion complete;
-	int status;
+	struct rk_instance rki[2];
+	int numinst;
+	const struct rk_variant *variant;
+	atomic_t flow;
 #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
 	struct dentry *dbgfs_dir;
 	struct dentry *dbgfs_stats;
 #endif
 };
 
+static inline int rk_get_engine_number(struct rk_crypto_info *rk)
+{
+	return atomic_inc_return(&rk->flow) % rk->variant->num_instance;
+}
+
 /* the private variable of hash */
 struct rk_ahash_ctx {
 	struct crypto_engine_ctx enginectx;
@@ -218,6 +228,7 @@ struct rk_ahash_rctx {
 	struct ahash_request		fallback_req;
 	u32				mode;
 	int nrsg;
+	int ninst;
 };
 
 /* the private variable of cipher */
@@ -233,6 +244,7 @@ struct rk_cipher_ctx {
 struct rk_cipher_rctx {
 	u8 backup_iv[AES_BLOCK_SIZE];
 	u32				mode;
+	int ninst;
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index 137013bd4410..28f4a7124683 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -83,33 +83,33 @@ static void rk_ahash_reg_init(struct ahash_request *req)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
 	struct rk_crypto_info *dev = tctx->dev;
+	void __iomem *reg = dev->rki[rctx->ninst].reg;
 	int reg_status;
 
-	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
+	reg_status = readl(reg + RK_CRYPTO_CTRL) |
 		     RK_CRYPTO_HASH_FLUSH | _SBF(0xffff, 16);
-	CRYPTO_WRITE(dev, RK_CRYPTO_CTRL, reg_status);
+	writel(reg_status, reg + RK_CRYPTO_CTRL);
 
-	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL);
+	reg_status = readl(reg + RK_CRYPTO_CTRL);
 	reg_status &= (~RK_CRYPTO_HASH_FLUSH);
 	reg_status |= _SBF(0xffff, 16);
-	CRYPTO_WRITE(dev, RK_CRYPTO_CTRL, reg_status);
+	writel(reg_status, reg + RK_CRYPTO_CTRL);
 
-	memset_io(dev->reg + RK_CRYPTO_HASH_DOUT_0, 0, 32);
+	memset_io(reg + RK_CRYPTO_HASH_DOUT_0, 0, 32);
 
-	CRYPTO_WRITE(dev, RK_CRYPTO_INTENA, RK_CRYPTO_HRDMA_ERR_ENA |
-					    RK_CRYPTO_HRDMA_DONE_ENA);
+	writel(RK_CRYPTO_HRDMA_ERR_ENA | RK_CRYPTO_HRDMA_DONE_ENA,
+	       reg + RK_CRYPTO_INTENA);
 
-	CRYPTO_WRITE(dev, RK_CRYPTO_INTSTS, RK_CRYPTO_HRDMA_ERR_INT |
-					    RK_CRYPTO_HRDMA_DONE_INT);
+	writel(RK_CRYPTO_HRDMA_ERR_INT | RK_CRYPTO_HRDMA_DONE_INT,
+	       reg + RK_CRYPTO_INTSTS);
 
-	CRYPTO_WRITE(dev, RK_CRYPTO_HASH_CTRL, rctx->mode |
-					       RK_CRYPTO_HASH_SWAP_DO);
+	writel(rctx->mode | RK_CRYPTO_HASH_SWAP_DO,
+	       reg + RK_CRYPTO_HASH_CTRL);
 
-	CRYPTO_WRITE(dev, RK_CRYPTO_CONF, RK_CRYPTO_BYTESWAP_HRFIFO |
-					  RK_CRYPTO_BYTESWAP_BRFIFO |
-					  RK_CRYPTO_BYTESWAP_BTFIFO);
+	writel(RK_CRYPTO_BYTESWAP_HRFIFO | RK_CRYPTO_BYTESWAP_BRFIFO |
+	       RK_CRYPTO_BYTESWAP_BTFIFO, reg + RK_CRYPTO_CONF);
 
-	CRYPTO_WRITE(dev, RK_CRYPTO_HASH_MSG_LEN, req->nbytes);
+	writel(req->nbytes, reg + RK_CRYPTO_HASH_MSG_LEN);
 }
 
 static int rk_ahash_init(struct ahash_request *req)
@@ -200,7 +200,9 @@ static int rk_ahash_export(struct ahash_request *req, void *out)
 static int rk_ahash_digest(struct ahash_request *req)
 {
 	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
+	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
 	struct rk_crypto_info *dev = tctx->dev;
+	struct crypto_engine *engine;
 
 	if (rk_ahash_need_fallback(req))
 		return rk_ahash_digest_fb(req);
@@ -208,15 +210,20 @@ static int rk_ahash_digest(struct ahash_request *req)
 	if (!req->nbytes)
 		return zero_message_process(req);
 
-	return crypto_transfer_hash_request_to_engine(dev->engine, req);
+	rctx->ninst = rk_get_engine_number(dev);
+	engine = dev->rki[rctx->ninst].engine;
+	return crypto_transfer_hash_request_to_engine(engine, req);
 }
 
-static void crypto_ahash_dma_start(struct rk_crypto_info *dev, struct scatterlist *sg)
+static void crypto_ahash_dma_start(struct rk_crypto_info *dev, int ninst,
+				   struct scatterlist *sg)
 {
-	CRYPTO_WRITE(dev, RK_CRYPTO_HRDMAS, sg_dma_address(sg));
-	CRYPTO_WRITE(dev, RK_CRYPTO_HRDMAL, sg_dma_len(sg) / 4);
-	CRYPTO_WRITE(dev, RK_CRYPTO_CTRL, RK_CRYPTO_HASH_START |
-					  (RK_CRYPTO_HASH_START << 16));
+	void __iomem *reg = dev->rki[ninst].reg;
+
+	writel(sg_dma_address(sg), reg + RK_CRYPTO_HRDMAS);
+	writel(sg_dma_len(sg) / 4, reg + RK_CRYPTO_HRDMAL);
+	writel(RK_CRYPTO_HASH_START | (RK_CRYPTO_HASH_START << 16),
+	       reg + RK_CRYPTO_CTRL);
 }
 
 static int rk_hash_prepare(struct crypto_engine *engine, void *breq)
@@ -255,6 +262,8 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
 	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
+	struct rk_instance *rki = &tctx->dev->rki[rctx->ninst];
+	void __iomem *reg = tctx->dev->rki[rctx->ninst].reg;
 	struct scatterlist *sg = areq->src;
 	int err = 0;
 	int i;
@@ -282,12 +291,12 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 	rk_ahash_reg_init(areq);
 
 	while (sg) {
-		reinit_completion(&tctx->dev->complete);
-		tctx->dev->status = 0;
-		crypto_ahash_dma_start(tctx->dev, sg);
-		wait_for_completion_interruptible_timeout(&tctx->dev->complete,
+		reinit_completion(&rki->complete);
+		rki->status = 0;
+		crypto_ahash_dma_start(tctx->dev, rctx->ninst, sg);
+		wait_for_completion_interruptible_timeout(&rki->complete,
 							  msecs_to_jiffies(2000));
-		if (!tctx->dev->status) {
+		if (!rki->status) {
 			dev_err(tctx->dev->dev, "DMA timeout\n");
 			err = -EFAULT;
 			goto theend;
@@ -305,11 +314,11 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		 * efficiency, and make it response quickly when dma
 		 * complete.
 		 */
-	while (!CRYPTO_READ(tctx->dev, RK_CRYPTO_HASH_STS))
+	while (!readl(reg + RK_CRYPTO_HASH_STS))
 		udelay(10);
 
 	for (i = 0; i < crypto_ahash_digestsize(tfm) / 4; i++) {
-		v = readl(tctx->dev->reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
+		v = readl(reg + RK_CRYPTO_HASH_DOUT_0 + i * 4);
 		put_unaligned_le32(v, areq->result + i * 4);
 	}
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 8d3a60db0cf6..f386ebb32e7c 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -95,11 +95,15 @@ static int rk_cipher_fallback(struct skcipher_request *areq)
 static int rk_handle_req(struct rk_crypto_info *dev,
 			 struct skcipher_request *req)
 {
-	struct crypto_engine *engine = dev->engine;
+	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
+	struct crypto_engine *engine;
 
 	if (rk_cipher_need_fallback(req))
 		return rk_cipher_fallback(req);
 
+	rctx->ninst = rk_get_engine_number(dev);
+	engine = dev->rki[rctx->ninst].engine;
+
 	return crypto_transfer_skcipher_request_to_engine(engine, req);
 }
 
@@ -290,6 +294,7 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev, struct skcipher_request
 	struct rk_cipher_rctx *rctx = skcipher_request_ctx(req);
 	struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(cipher);
 	u32 block, conf_reg = 0;
+	void __iomem *reg = dev->rki[rctx->ninst].reg;
 
 	block = crypto_tfm_alg_blocksize(tfm);
 
@@ -297,8 +302,8 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev, struct skcipher_request
 		rctx->mode |= RK_CRYPTO_TDES_FIFO_MODE |
 			     RK_CRYPTO_TDES_BYTESWAP_KEY |
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
-		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
+		writel(rctx->mode, reg + RK_CRYPTO_TDES_CTRL);
+		memcpy_toio(reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -309,25 +314,27 @@ static void rk_ablk_hw_init(struct rk_crypto_info *dev, struct skcipher_request
 			rctx->mode |= RK_CRYPTO_AES_192BIT_key;
 		else if (ctx->keylen == AES_KEYSIZE_256)
 			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
-		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
+		writel(rctx->mode, reg + RK_CRYPTO_AES_CTRL);
+		memcpy_toio(reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
 		    RK_CRYPTO_BYTESWAP_BRFIFO;
-	CRYPTO_WRITE(dev, RK_CRYPTO_CONF, conf_reg);
-	CRYPTO_WRITE(dev, RK_CRYPTO_INTENA,
-		     RK_CRYPTO_BCDMA_ERR_ENA | RK_CRYPTO_BCDMA_DONE_ENA);
+	writel(conf_reg, reg + RK_CRYPTO_CONF);
+	writel(RK_CRYPTO_BCDMA_ERR_ENA | RK_CRYPTO_BCDMA_DONE_ENA,
+	       reg + RK_CRYPTO_INTENA);
 }
 
-static void crypto_dma_start(struct rk_crypto_info *dev,
+static void crypto_dma_start(struct rk_crypto_info *dev, int ninst,
 			     struct scatterlist *sgs,
 			     struct scatterlist *sgd, unsigned int todo)
 {
-	CRYPTO_WRITE(dev, RK_CRYPTO_BRDMAS, sg_dma_address(sgs));
-	CRYPTO_WRITE(dev, RK_CRYPTO_BRDMAL, todo);
-	CRYPTO_WRITE(dev, RK_CRYPTO_BTDMAS, sg_dma_address(sgd));
-	CRYPTO_WRITE(dev, RK_CRYPTO_CTRL, RK_CRYPTO_BLOCK_START |
-		     _SBF(RK_CRYPTO_BLOCK_START, 16));
+	void __iomem *reg = dev->rki[ninst].reg;
+
+	writel(sg_dma_address(sgs), reg + RK_CRYPTO_BRDMAS);
+	writel(todo, reg + RK_CRYPTO_BRDMAL);
+	writel(sg_dma_address(sgd), reg + RK_CRYPTO_BTDMAS);
+	writel(RK_CRYPTO_BLOCK_START | _SBF(RK_CRYPTO_BLOCK_START, 16),
+	       reg + RK_CRYPTO_CTRL);
 }
 
 static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
@@ -348,6 +355,8 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 	unsigned int todo;
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct rk_crypto_tmp *algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
+	struct rk_instance *rki = &ctx->dev->rki[rctx->ninst];
+	void __iomem *reg = ctx->dev->rki[rctx->ninst].reg;
 
 	algt->stat_req++;
 
@@ -396,19 +405,19 @@ static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
 		rk_ablk_hw_init(ctx->dev, areq);
 		if (ivsize) {
 			if (ivsize == DES_BLOCK_SIZE)
-				memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
+				memcpy_toio(reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
 			else
-				memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_IV_0, ivtouse, ivsize);
+				memcpy_toio(reg + RK_CRYPTO_AES_IV_0, ivtouse, ivsize);
 		}
-		reinit_completion(&ctx->dev->complete);
-		ctx->dev->status = 0;
+		reinit_completion(&rki->complete);
+		rki->status = 0;
 
 		todo = min(sg_dma_len(sgs), len);
 		len -= todo;
-		crypto_dma_start(ctx->dev, sgs, sgd, todo / 4);
-		wait_for_completion_interruptible_timeout(&ctx->dev->complete,
+		crypto_dma_start(ctx->dev, rctx->ninst, sgs, sgd, todo / 4);
+		wait_for_completion_interruptible_timeout(&rki->complete,
 							  msecs_to_jiffies(2000));
-		if (!ctx->dev->status) {
+		if (!rki->status) {
 			dev_err(ctx->dev->dev, "DMA timeout\n");
 			err = -EFAULT;
 			goto theend;
-- 
2.34.1

