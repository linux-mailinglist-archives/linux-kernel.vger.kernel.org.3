Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899E84CBE42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiCCM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiCCM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:58:03 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEABF186218;
        Thu,  3 Mar 2022 04:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=Ui7Wx3HT5wFF2lD9OqwpaMhrO7qy33DzT68PqCTpFeA=; b=t2ko4
        NFlATGyheALC9w+H68/z3RvSSOEB6BrmYEzUF5r8KqMq1m06wmG4/48fY/k1SirfLL8ebbuWySbK+
        yAIBOZP7CNmNQwuVEQFAyP6sY3UK1LSpXV+t+8dZS/gAeJjam7Eu7BQ1fmtksh1ecMYZM7QJCHYtn
        kBW0GuvUjAebv5yS+bC5ZA0izcBIu8XwZBDNE8aadZPiBBeTFnvKy1vu7Nb0iW8b60M7xMAX9fUIL
        kVAxrsn/p2QVIA4oUW3Ety5Agn002vZfP/aTWFOu8FDRIHiBKgqt4I8XPykJQCQ8JszenDrhULJNU
        z9o0dmnVkLuKL3W7mSH/OAvSeAIsQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nPl0y-0004oa-Jj; Thu, 03 Mar 2022 12:57:04 +0000
Date:   Thu, 3 Mar 2022 12:57:03 +0000
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 15/18] crypto: rockchip: introduce PM
Message-ID: <YiC7Hxm0epcAcHen@donbot>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
 <20220302211113.4003816-16-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302211113.4003816-16-clabbe@baylibre.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:11:10PM +0000, Corentin Labbe wrote:
> Add runtime PM support for rockchip crypto.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/Kconfig                        |  1 +
>  drivers/crypto/rockchip/rk3288_crypto.c       | 50 ++++++++++++++++++-
>  drivers/crypto/rockchip/rk3288_crypto.h       |  1 +
>  drivers/crypto/rockchip/rk3288_crypto_ahash.c | 11 ++++
>  .../crypto/rockchip/rk3288_crypto_skcipher.c  | 10 ++++
>  5 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 04c8e332c5a1..685631a5cbea 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -784,6 +784,7 @@ config CRYPTO_DEV_IMGTEC_HASH
>  config CRYPTO_DEV_ROCKCHIP
>  	tristate "Rockchip's Cryptographic Engine driver"
>  	depends on OF && ARCH_ROCKCHIP
> +	depends on PM

Does this need to depend on PM?  If you enable the clock in _probe then
use pm_runtime_put_autosuspend() the no-op helpers when !PM will mean
this works whether PM is enabled or not.

>  	select CRYPTO_AES
>  	select CRYPTO_ENGINE
>  	select CRYPTO_LIB_DES
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
> index cd0755731cf7..ba56f8ff97c3 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
> @@ -57,6 +57,48 @@ static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
>  	clk_disable_unprepare(dev->sclk);
>  }
>  
> +/*
> + * Power management strategy: The device is suspended unless a TFM exists for
> + * one of the algorithms proposed by this driver.
> + */
> +static int rk_crypto_pm_suspend(struct device *dev)
> +{
> +	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
> +
> +	rk_crypto_disable_clk(rkdev);
> +	return 0;
> +}
> +
> +static int rk_crypto_pm_resume(struct device *dev)
> +{
> +	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
> +
> +	return rk_crypto_enable_clk(rkdev);
> +}
> +
> +static const struct dev_pm_ops rk_crypto_pm_ops = {
> +	SET_RUNTIME_PM_OPS(rk_crypto_pm_suspend, rk_crypto_pm_resume, NULL)
> +};
> +
> +static int rk_crypto_pm_init(struct rk_crypto_info *rkdev)
> +{
> +	int err;
> +
> +	pm_runtime_use_autosuspend(rkdev->dev);
> +	pm_runtime_set_autosuspend_delay(rkdev->dev, 2000);
> +
> +	err = pm_runtime_set_suspended(rkdev->dev);
> +	if (err)
> +		return err;
> +	pm_runtime_enable(rkdev->dev);
> +	return err;
> +}
> +
> +static void rk_crypto_pm_exit(struct rk_crypto_info *rkdev)
> +{
> +	pm_runtime_disable(rkdev->dev);
> +}
> +
>  static irqreturn_t rk_crypto_irq_handle(int irq, void *dev_id)
>  {
>  	struct rk_crypto_info *dev  = platform_get_drvdata(dev_id);
> @@ -259,7 +301,9 @@ static int rk_crypto_probe(struct platform_device *pdev)
>  	crypto_engine_start(crypto_info->engine);
>  	init_completion(&crypto_info->complete);
>  
> -	rk_crypto_enable_clk(crypto_info);
> +	err = rk_crypto_pm_init(crypto_info);
> +	if (err)
> +		goto err_crypto;
>  
>  	err = rk_crypto_register(crypto_info);
>  	if (err) {
> @@ -280,6 +324,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_register_alg:
> +	rk_crypto_pm_exit(crypto_info);
>  err_crypto:
>  	dev_err(dev, "Crypto Accelerator not successfully registered\n");
>  	return err;
> @@ -293,7 +338,7 @@ static int rk_crypto_remove(struct platform_device *pdev)
>  	debugfs_remove_recursive(crypto_tmp->dbgfs_dir);
>  #endif
>  	rk_crypto_unregister();
> -	rk_crypto_disable_clk(crypto_tmp);
> +	rk_crypto_pm_exit(crypto_tmp);
>  	return 0;
>  }
>  
> @@ -302,6 +347,7 @@ static struct platform_driver crypto_driver = {
>  	.remove		= rk_crypto_remove,
>  	.driver		= {
>  		.name	= "rk3288-crypto",
> +		.pm		= &rk_crypto_pm_ops,
>  		.of_match_table	= crypto_of_id_table,
>  	},
>  };
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
> index e2a6d735f2e2..06b2d9f52a80 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.h
> +++ b/drivers/crypto/rockchip/rk3288_crypto.h
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
>  #include <crypto/engine.h>
>  #include <crypto/internal/hash.h>
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> index 8856c6226be6..a41e21c7141b 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> @@ -328,6 +328,7 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
>  	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
>  
>  	const char *alg_name = crypto_tfm_alg_name(tfm);
> +	int err;
>  
>  	algt = container_of(alg, struct rk_crypto_tmp, alg.hash);
>  
> @@ -349,7 +350,16 @@ static int rk_cra_hash_init(struct crypto_tfm *tfm)
>  	tctx->enginectx.op.prepare_request = rk_hash_prepare;
>  	tctx->enginectx.op.unprepare_request = rk_hash_unprepare;
>  
> +	err = pm_runtime_get_sync(tctx->dev->dev);

pm_runtime_resume_and_get() ?  The error handling is nicer with that.

> +	if (err < 0)
> +		goto error_pm;
> +
>  	return 0;
> +error_pm:
> +	pm_runtime_put_noidle(tctx->dev->dev);
> +	crypto_free_ahash(tctx->fallback_tfm);
> +
> +	return err;
>  }
>  
>  static void rk_cra_hash_exit(struct crypto_tfm *tfm)
> @@ -357,6 +367,7 @@ static void rk_cra_hash_exit(struct crypto_tfm *tfm)
>  	struct rk_ahash_ctx *tctx = crypto_tfm_ctx(tfm);
>  
>  	crypto_free_ahash(tctx->fallback_tfm);
> +	pm_runtime_put_sync_suspend(tctx->dev->dev);

Why use sync_suspend here?  Could this be pm_runtime_put_autosuspend()?

>  }
>  
>  struct rk_crypto_tmp rk_ahash_sha1 = {
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> index a8cfb520eaf8..55efda6ea3e7 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> @@ -458,6 +458,7 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
>  	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
>  	const char *name = crypto_tfm_alg_name(&tfm->base);
>  	struct rk_crypto_tmp *algt;
> +	int err;
>  
>  	algt = container_of(alg, struct rk_crypto_tmp, alg.skcipher);
>  
> @@ -475,7 +476,15 @@ static int rk_ablk_init_tfm(struct crypto_skcipher *tfm)
>  
>  	ctx->enginectx.op.do_one_request = rk_cipher_run;
>  
> +	err = pm_runtime_get_sync(ctx->dev->dev);

Another place for pm_runtime_resume_and_get() ?

> +	if (err < 0)
> +		goto error_pm;
> +
>  	return 0;
> +error_pm:
> +	pm_runtime_put_noidle(ctx->dev->dev);
> +	crypto_free_skcipher(ctx->fallback_tfm);
> +	return err;
>  }
>  
>  static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
> @@ -484,6 +493,7 @@ static void rk_ablk_exit_tfm(struct crypto_skcipher *tfm)
>  
>  	memzero_explicit(ctx->key, ctx->keylen);
>  	crypto_free_skcipher(ctx->fallback_tfm);
> +	pm_runtime_put_sync_suspend(ctx->dev->dev);

Again, can this be pm_runtime_put_autosuspend() ?
