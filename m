Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D305312A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiEWOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEWOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:52:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9256427C6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:52:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u27so20920725wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WM2w2iSrfnCpI7JacIA3BcUph/2ijVWcwtEgBCcbpIc=;
        b=r7xEqlLCksQ1soquqg6YMFdzig2CSZJJ1ZRaPdQchwXYnn4/u92ZxMh2tX3eTolH+q
         1bm4OVGSNSyKP0xWNjtUUNO3BvDCCjxhoDGj3/lo2vkzrUD4ymuu9l9s3M/r+3M8cG25
         oof5UFhLCXyem8IV14F126PePSViDheuZ5U4iveFPIRfvwVa38CkpgHlw5371o++fVk6
         k6GUYWa3/z0YAXUH/07TG6G7HCR0OxWjQlTerJ4VYF8gc/Ia3lnIZDNVgp2NfyYKY6pI
         AvkA5sauIbX+omqXhaeSv7+9U52ciaa4xutw4PmMl62qN4OKihtCHnexWHgbnh4UGKmH
         Ep2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WM2w2iSrfnCpI7JacIA3BcUph/2ijVWcwtEgBCcbpIc=;
        b=eKrKGD0xLK12/dKNUliEfaPzEpNT9QGXtxhCpSgwbhy+fIRjQy3MwyEWYjBnuBUHGy
         K25l1wPR0zPE9utr0M7lOSKt4PUoKc9KSLZRmUtasIz1fApLQUhN26eJea0QnQ9Zxmau
         Y+M5RNDmvb/wJOYc7X8OulwwCpThTc0yJf46AWXR9sAu2WrRWK9DtZHx3L0unAyyg+0c
         hGGpKzfBmiGIc7XFvpxNtRz0h2YNPDy2x6RXsL1QReYvYtjvVm4Wbf01Nts2sgcXOewd
         ibDQ/aBKK8co2AlK1PFR91Lv+b7UKAiT9mEmgaXsbG8kV2TZsodzwJQy3Ik3AOs3rqwD
         Wz8g==
X-Gm-Message-State: AOAM531utKsB/+ucJMxezSCimNe9bf7tZsSu811suBhA1jcz2cjnGovX
        k0U4F64KxfRWSyLwO6kyB18aLCuYIarf2g==
X-Google-Smtp-Source: ABdhPJx8g7hX75odBmTIOpI6lWQKWgpFUQOsgvhtxc8fxWoHcWpwS5f35ULO7SpybNMKCN12jx3Kqw==
X-Received: by 2002:a05:6000:1a88:b0:20e:6eb4:124e with SMTP id f8-20020a0560001a8800b0020e6eb4124emr18015038wry.8.1653317545273;
        Mon, 23 May 2022 07:52:25 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c149500b0039750c29cf7sm1758385wmh.40.2022.05.23.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:52:24 -0700 (PDT)
Date:   Mon, 23 May 2022 15:52:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Message-ID: <YoufpkeLTgchjESL@google.com>
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
 <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 May 2022, Kavyasree Kotagiri wrote:

> LAN966 SoC have 5 flexcoms. Each flexcom has 2 chip-selects.
> For each chip select of each flexcom there is a configuration
> register FLEXCOM_SHARED[0-4]:SS_MASK[0-1]. The width of
> configuration register is 21 because there are 21 shared pins
> on each of which the chip select can be mapped. Each bit of the
> register represents a different FLEXCOM_SHARED pin.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/mach-at91/Kconfig  |   2 +

>  drivers/mfd/atmel-flexcom.c |  55 +++++++++++++++-

Can this be separated into its own patch?

>  drivers/mux/Kconfig         |  12 ++++
>  drivers/mux/Makefile        |   2 +
>  drivers/mux/lan966-flx.c    | 121 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mux/lan966-flx.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 279810381256..26fb0f4e1b79 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -74,6 +74,8 @@ config SOC_LAN966
>  	select DW_APB_TIMER_OF
>  	select ARM_GIC
>  	select MEMORY
> +	select MULTIPLEXER
> +	select MUX_LAN966
>  	help
>  	  This enables support for ARMv7 based Microchip LAN966 SoC family.
>  
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 559eb4d352b6..7cfd0fc3f4f0 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <linux/mux/consumer.h>
>  
>  /* I/O register offsets */
>  #define FLEX_MR		0x0	/* Mode Register */
> @@ -28,6 +29,10 @@
>  #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
>  				 FLEX_MR_OPMODE_MASK)
>  
> +struct atmel_flex_caps {
> +	bool has_flx_mux;

Why does this need it's own struct?

> +};
> +
>  struct atmel_flexcom {
>  	void __iomem *base;
>  	u32 opmode;
> @@ -37,6 +42,7 @@ struct atmel_flexcom {
>  static int atmel_flexcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	const struct atmel_flex_caps *caps;
>  	struct resource *res;
>  	struct atmel_flexcom *ddata;
>  	int err;
> @@ -76,13 +82,60 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
>  	 */
>  	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
>  
> +	caps = of_device_get_match_data(&pdev->dev);
> +	if (!caps) {
> +		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");

dev_err() already prints out the device name, so you can drop the
"flexcom" part.  Also, please expand 'caps'.  I'm assuming that's
capabilities?

> +		return -EINVAL;
> +	}
> +
> +	/* Flexcom Mux */
> +	if (caps->has_flx_mux && of_property_read_bool(np, "mux-controls")) {
> +		struct mux_control *flx_mux;

What is 'flx'?

> +		struct of_phandle_args args;
> +		int i, count;
> +
> +		flx_mux = devm_mux_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(flx_mux))
> +			return PTR_ERR(flx_mux);
> +
> +		count = of_property_count_strings(np, "mux-control-names");
> +		for (i = 0; i < count; i++) {
> +			err = of_parse_phandle_with_fixed_args(np, "mux-controls", 1, i, &args);
> +			if (err)
> +				break;

No mux_control_deselect() for previous iterations?

> +			err = mux_control_select(flx_mux, args.args[0]);
> +			if (!err) {
> +				mux_control_deselect(flx_mux);

Not sure I see the point in selecting then deselecting.

Is it just a test?

If so, why don't you wait until you need to select it, then apply
normal error handling protocols there instead?

> +			} else {
> +				dev_err(&pdev->dev, "Failed to select FLEXCOM mux\n");
> +				return err;
> +			}
> +		}
> +	}
> +
>  	clk_disable_unprepare(ddata->clk);
>  
>  	return devm_of_platform_populate(&pdev->dev);
>  }
>  
> +static const struct atmel_flex_caps atmel_flexcom_caps = {};

Why not just leave .data as NULL?

> +static const struct atmel_flex_caps lan966x_flexcom_caps = {
> +	.has_flx_mux = true,
> +};
> +
>  static const struct of_device_id atmel_flexcom_of_match[] = {
> -	{ .compatible = "atmel,sama5d2-flexcom" },
> +	{
> +		.compatible = "atmel,sama5d2-flexcom",
> +		.data = &atmel_flexcom_caps,

And this can't be a DT property?

> +	},
> +
> +	{
> +		.compatible = "microchip,lan966-flexcom",
> +		.data = &lan966x_flexcom_caps,
> +	},

This all seems like a lot of hoop-jumping.

Why not just do:

  if (of_device_is_compatible(np, "lan966x_flexcom_caps"))

> +
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
