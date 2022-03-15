Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23694DA34C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351379AbiCOTca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCOTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:32:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F94A50E3C;
        Tue, 15 Mar 2022 12:31:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qt6so43678171ejb.11;
        Tue, 15 Mar 2022 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SF7IgGhp+9o85mKWfP8kscVz0pSLrrsqPcAQ8jalhmo=;
        b=WRpYLEGOnlkzefN2BJ6kRoYK5vLtDps1w7cAmdnQ2XhNc+I/yb6PAibQfQxE3nYR2C
         Xet5ex/Qp06CJoetB4NueLsEvLG7AIfT+T7tyifST8gPlBgixp5z1pO7ComuN7gMd6Vq
         7YbPFkTYKDTmav4ThAte4typ32UhuO7TNUEYbUURaaT4ZYl2ghkGCzDUJE6q+s9n2I9m
         VynNMZcKhSL8rHhIMqPWbENJvY/8mDo1MGjE6g1cZMSwISbmX2CaJBndMLO3uc5c+iYf
         BaEoSruOBBGawn+H6iTUjXgArp8pkhWGRlKGeWryMXEawZOOp8Xsn5U9jGiP945nwuXN
         jRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SF7IgGhp+9o85mKWfP8kscVz0pSLrrsqPcAQ8jalhmo=;
        b=kqNhhcFSzuN+15RyUnDbNJmho9ovdLH38LN7eGrqsdrVTXwol8v/EYm4AuQs2Fcd51
         cQlN7+MKHSuOhA2jM6Ta/yUOVITWqDFDzQkuQ7RIYWtmN30OLcIrvA8gFzDbh8mLRSSZ
         DgAaJ43L/vMxJrFTpLVGPe+TPcZpwXH4/Uqez5t+c4585pBRJvWlu581X/Ns42A3AYzX
         3Rw/KE9/KJlGBc8weV8Vfe/kw/kWc3WxfjMN18k6xdsn2ByCA2SMws63/CpjC54tHo8O
         zwPdwxr+5B5VfwunEg/yxhubNjDYpsUrLJndubLYy/hpg0/yzxvvubDfX1S5jVYfWNrq
         q2mg==
X-Gm-Message-State: AOAM532X5Pg3Q+ZPRZ0RgMw0q0k8FdD3abKB2g6//st/aYATVWAhf2HT
        TPjggmz40hgIngwQ05DbFpwEacPlYChRyQ==
X-Google-Smtp-Source: ABdhPJxNjnwRnV6JCivFveTPgjxD+iRyjMCErU60znyaQ6x5BHWiiYu3hDzvwmfqsCb7mT4kodKOBQ==
X-Received: by 2002:a17:906:3ec9:b0:6bb:2eb9:84f with SMTP id d9-20020a1709063ec900b006bb2eb9084fmr23892050ejj.86.1647372674681;
        Tue, 15 Mar 2022 12:31:14 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906145000b006bdaf981589sm8507976ejc.81.2022.03.15.12.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:31:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 06/46] media: sun6i-csi: Define and use variant to get module clock rate
Date:   Tue, 15 Mar 2022 20:31:13 +0100
Message-ID: <2060330.OBFZWjSADL@kista>
In-Reply-To: <20220311143532.265091-7-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com> <20220311143532.265091-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 11. marec 2022 ob 15:34:52 CET je Paul Kocialkowski napisal(a):
> Introduce a proper variant structure with the module clock rate
> instead of hardcoding it with a manual check on the compatible.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 48 ++++++++++++++-----
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  4 ++
>  2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/
media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 2355088fdc37..4a0d08e0ac25 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -811,11 +811,17 @@ static int sun6i_csi_resources_setup(struct 
sun6i_csi_device *csi_dev,
>  				     struct platform_device 
*platform_dev)
>  {
>  	struct device *dev = csi_dev->dev;
> -	unsigned long clk_mod_rate;
> +	const struct sun6i_csi_variant *variant;

Ideally, this should be sorted from longest to shortest.

>  	void __iomem *io_base;
>  	int ret;
>  	int irq;
>  
> +	/* Variant */

I don't think this comment is very useful (nor one below for that matter.) 
Please remove it.

With that:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +
> +	variant = of_device_get_match_data(dev);
> +	if (!variant)
> +		return -EINVAL;
> +
>  	/* Registers */
>  
>  	io_base = devm_platform_ioremap_resource(platform_dev, 0);
> @@ -849,12 +855,7 @@ static int sun6i_csi_resources_setup(struct 
sun6i_csi_device *csi_dev,
>  		return PTR_ERR(csi_dev->clk_ram);
>  	}
>  
> -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-
csi"))
> -		clk_mod_rate = 300000000;
> -	else
> -		clk_mod_rate = 297000000;
> -
> -	ret = clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
> +	ret = clk_set_rate_exclusive(csi_dev->clk_mod, variant-
>clk_mod_rate);
>  	if (ret) {
>  		dev_err(dev, "failed to set mod clock rate\n");
>  		return ret;
> @@ -937,12 +938,35 @@ static int sun6i_csi_remove(struct platform_device 
*pdev)
>  	return 0;
>  }
>  
> +static const struct sun6i_csi_variant sun6i_a31_csi_variant = {
> +	.clk_mod_rate	= 297000000,
> +};
> +
> +static const struct sun6i_csi_variant sun50i_a64_csi_variant = {
> +	.clk_mod_rate	= 300000000,
> +};
> +
>  static const struct of_device_id sun6i_csi_of_match[] = {
> -	{ .compatible = "allwinner,sun6i-a31-csi", },
> -	{ .compatible = "allwinner,sun8i-a83t-csi", },
> -	{ .compatible = "allwinner,sun8i-h3-csi", },
> -	{ .compatible = "allwinner,sun8i-v3s-csi", },
> -	{ .compatible = "allwinner,sun50i-a64-csi", },
> +	{
> +		.compatible	= "allwinner,sun6i-a31-csi",
> +		.data		= &sun6i_a31_csi_variant,
> +	},
> +	{
> +		.compatible	= "allwinner,sun8i-a83t-csi",
> +		.data		= &sun6i_a31_csi_variant,
> +	},
> +	{
> +		.compatible	= "allwinner,sun8i-h3-csi",
> +		.data		= &sun6i_a31_csi_variant,
> +	},
> +	{
> +		.compatible	= "allwinner,sun8i-v3s-csi",
> +		.data		= &sun6i_a31_csi_variant,
> +	},
> +	{
> +		.compatible	= "allwinner,sun50i-a64-csi",
> +		.data		= &sun50i_a64_csi_variant,
> +	},
>  	{},
>  };
>  
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/
media/platform/sunxi/sun6i-csi/sun6i_csi.h
> index 356661b413f8..3c4a3af6b897 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -59,6 +59,10 @@ struct sun6i_csi_device {
>  	int				planar_offset[3];
>  };
>  
> +struct sun6i_csi_variant {
> +	unsigned long	clk_mod_rate;
> +};
> +
>  /**
>   * sun6i_csi_is_format_supported() - check if the format supported by csi
>   * @csi:	pointer to the csi
> -- 
> 2.35.1
> 
> 


