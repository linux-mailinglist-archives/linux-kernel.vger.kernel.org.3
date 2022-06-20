Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0454A551688
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiFTLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbiFTLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:05:04 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A1F12AA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=JtWYZV1ZUB9zWxnOO4bgicY4RQzn+QgQFFTY9VvrXQw=; b=n8sIg
        XF3SiOc5XAmJlqEPRH9w4T59X6m+7fZ5y/F/Qb6F7qWo0h1ajoVkArF7YcYfpp+TZQF4c7i1aJubw
        LqhGrGilz8QDOo/hoZUC2DO0heXPlc3eC+RbrCVvOVaoxDNANduUUyMy/t1a12wzWtcnFs6yOoh9J
        DUlSHMLnjeqXeunHjxFjtL0izeiyMyfr3Q6f0h0RhFGWSHaQJhd+dVwtpGX31R6WM1ybVzm32DjMG
        DzNcZLqUbbMtWjdn57XS9KRslbU+ZvrvpAPiA9ibsWTccyd4rYC0Ukwo6Um+iP77+PCsyopPTGamH
        vxvHbVfim8mrn9zqJS5N+kBJZKQhA==;
Received: from 92.40.170.2.threembb.co.uk ([92.40.170.2] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1o3FCk-0002O9-Hw; Mon, 20 Jun 2022 12:04:26 +0100
Date:   Mon, 20 Jun 2022 12:04:24 +0100
From:   John Keeping <john@metanate.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 14/33] crypto: rockchip: handle reset also in PM
Message-ID: <YrBUODGF51oUsF1f@donbot>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
 <20220508185957.3629088-15-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508185957.3629088-15-clabbe@baylibre.com>
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

On Sun, May 08, 2022 at 06:59:38PM +0000, Corentin Labbe wrote:
> reset could be handled by PM functions.

Is there any further rationale for this?

After this change there is no longer a guaranteed reset pulse on probe
since the reset control may already be de-asserted.  This is normally
the most important case for a reset as it's the only time when the state
of the hardware is unknown.

The original use of devm_add_action_or_reset() seems a bit weird already
since there doesn't seem to be any need to assert reset when the driver
is unloaded.

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/rockchip/rk3288_crypto.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
> index d9258b9e71b3..a11a92e1f3fd 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
> @@ -73,6 +73,8 @@ static int rk_crypto_pm_suspend(struct device *dev)
>  {
>  	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
>  
> +	reset_control_assert(rkdev->rst);
> +
>  	rk_crypto_disable_clk(rkdev);
>  	return 0;
>  }
> @@ -81,6 +83,8 @@ static int rk_crypto_pm_resume(struct device *dev)
>  {
>  	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
>  
> +	reset_control_deassert(rkdev->rst);
> +
>  	return rk_crypto_enable_clk(rkdev);
>  }
>  
> @@ -222,13 +226,6 @@ static void rk_crypto_unregister(void)
>  	}
>  }
>  
> -static void rk_crypto_action(void *data)
> -{
> -	struct rk_crypto_info *crypto_info = data;
> -
> -	reset_control_assert(crypto_info->rst);
> -}
> -
>  static const struct of_device_id crypto_of_id_table[] = {
>  	{ .compatible = "rockchip,rk3288-crypto" },
>  	{}
> @@ -254,14 +251,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
>  		goto err_crypto;
>  	}
>  
> -	reset_control_assert(crypto_info->rst);
> -	usleep_range(10, 20);
> -	reset_control_deassert(crypto_info->rst);
> -
> -	err = devm_add_action_or_reset(dev, rk_crypto_action, crypto_info);
> -	if (err)
> -		goto err_crypto;
> -
>  	crypto_info->reg = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(crypto_info->reg)) {
>  		err = PTR_ERR(crypto_info->reg);
> -- 
> 2.35.1
