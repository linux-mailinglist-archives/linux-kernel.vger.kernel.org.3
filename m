Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2713E571B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiGLNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGLNdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:33:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB6B62A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:33:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so11213498wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1FNQrGGLfgdOgMRKiUwsbzE3SGEjtGBgzxsXljwQUHE=;
        b=hTDsqLoXRixjt/Sxz4pnsbxPZ2ChVkl5G3Efink/BugEruXacu1c14dFTFwKa0c3gY
         o/+eryoGjW9zyuyJ7wemDQirD4D04/nXfYPkHa1G3NtRldyCDQ/2zs/zyzMfMEI8HTWr
         iYlsUd6VZ1BdSYB6OpRejTRfbS/3+NfNcv56pt8/W3na5GXCHJ5oq4VO25FksgV9cQFP
         OOzwUmFoXuLhNwWST4eb5B14ImeEhE4+FdqOm1DF6nMbC5rCYGWDPXDwqd7SkScILR7N
         gec2/C7+2gfE3s/eAraUC8ItcbP1D33rLOfkl66gtcp/BtJDaEyGPr/I+63MxweebsQZ
         wKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1FNQrGGLfgdOgMRKiUwsbzE3SGEjtGBgzxsXljwQUHE=;
        b=LROqf3fHzzGcNN75y/lIteRMmEBJP5qHrUhsUlhwgKglAnx2oOV6/bsdS8Zp16WQ1p
         nj7BEfHkeXtGKbs1s1l1S/aIiVkFTpvQ6vb5hl/bOTWr7z4DooXKRF6yzW/CS8nYsRMN
         z39XaB5Hr5U63O1NoB6v6imDHTKsDNkmn+PSHOvywvXeN0CbQVMgRrM2C/B9iGdM6uto
         CFzrBnhbc5lP1z35zklGGARW0a78DGLkb0CC8RwvW8lPyi1EfWLOQjaFMYDiC4vvV80o
         NkVULTLNugRRsGTpGBjO1frGhdufqVf2Wha8FmgpUudU5gySNcrNHCvBRZ5kbkz97R0h
         GQWA==
X-Gm-Message-State: AJIora+C9QDz4+Y1gk3GvklvM5ZsTobstTKcSFadMsWpbOdTkCZaq0T1
        9Cz5HVQHCr5PDvekzXv5SWXwmA==
X-Google-Smtp-Source: AGRyM1tDxqUM6cVCSs98mVzMblL7DYw1ebw4b5m50i0FuBi3jTzjyS1F+201+kxSFQ4/IZUzwFtrpw==
X-Received: by 2002:a05:6000:178c:b0:21d:b6d0:11a8 with SMTP id e12-20020a056000178c00b0021db6d011a8mr1741057wrg.547.1657632795572;
        Tue, 12 Jul 2022 06:33:15 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g4-20020adff404000000b0021d87798237sm8320371wro.20.2022.07.12.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:33:14 -0700 (PDT)
Date:   Tue, 12 Jul 2022 14:33:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v1 1/4] mfd: stmpe: Probe sub-function by compatible
Message-ID: <Ys14GboRr4+GVMX1@google.com>
References: <20220712110232.329164-1-francesco.dolcini@toradex.com>
 <20220712110232.329164-2-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712110232.329164-2-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022, Francesco Dolcini wrote:

> Use sub-function of_compatible during probe, instead of using the node
> name. The code should not rely on the node names during probe, in
> addition to that the previously hard-coded node names are not compliant
> to the latest naming convention (they are not generic and they use
> underscores), and it was broken by mistake already once [1].
> 
> While doing this change `rotator` entry was removed, it is not
> used in any device tree file, there is no cell defined, it's just dead
> non-working code with no of_compatible for it.
> 
> [1] commit 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
> 
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/mfd/stmpe.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index aeb9ea55f97d..90a07a94455f 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -23,6 +23,12 @@
>  #include <linux/regulator/consumer.h>
>  #include "stmpe.h"
>  
> +#define STMPE_GPIO_COMPATIBLE   "st,stmpe-gpio"
> +#define STMPE_KEYPAD_COMPATIBLE "st,stmpe-keypad"
> +#define STMPE_PWM_COMPATIBLE    "st,stmpe-pwm"
> +#define STMPE_TS_COMPATIBLE     "st,stmpe-ts"
> +#define STMPE_ADC_COMPATIBLE    "st,stmpe-adc"

This is horrible.

Please refrain from defining device/compatible strings.

>  /**
>   * struct stmpe_platform_data - STMPE platform data
>   * @id: device id to distinguish between multiple STMPEs on the same board
> @@ -321,14 +327,14 @@ static struct resource stmpe_gpio_resources[] = {
>  
>  static const struct mfd_cell stmpe_gpio_cell = {
>  	.name		= "stmpe-gpio",
> -	.of_compatible	= "st,stmpe-gpio",
> +	.of_compatible	= STMPE_GPIO_COMPATIBLE,
>  	.resources	= stmpe_gpio_resources,
>  	.num_resources	= ARRAY_SIZE(stmpe_gpio_resources),
>  };
>  
>  static const struct mfd_cell stmpe_gpio_cell_noirq = {
>  	.name		= "stmpe-gpio",
> -	.of_compatible	= "st,stmpe-gpio",
> +	.of_compatible	= STMPE_GPIO_COMPATIBLE,
>  	/* gpio cell resources consist of an irq only so no resources here */
>  };
>  
> @@ -350,7 +356,7 @@ static struct resource stmpe_keypad_resources[] = {
>  
>  static const struct mfd_cell stmpe_keypad_cell = {
>  	.name		= "stmpe-keypad",
> -	.of_compatible  = "st,stmpe-keypad",
> +	.of_compatible  = STMPE_KEYPAD_COMPATIBLE,
>  	.resources	= stmpe_keypad_resources,
>  	.num_resources	= ARRAY_SIZE(stmpe_keypad_resources),
>  };
> @@ -376,7 +382,7 @@ static struct resource stmpe_pwm_resources[] = {
>  
>  static const struct mfd_cell stmpe_pwm_cell = {
>  	.name		= "stmpe-pwm",
> -	.of_compatible  = "st,stmpe-pwm",
> +	.of_compatible  = STMPE_PWM_COMPATIBLE,
>  	.resources	= stmpe_pwm_resources,
>  	.num_resources	= ARRAY_SIZE(stmpe_pwm_resources),
>  };
> @@ -461,7 +467,7 @@ static struct resource stmpe_ts_resources[] = {
>  
>  static const struct mfd_cell stmpe_ts_cell = {
>  	.name		= "stmpe-ts",
> -	.of_compatible	= "st,stmpe-ts",
> +	.of_compatible	= STMPE_TS_COMPATIBLE,
>  	.resources	= stmpe_ts_resources,
>  	.num_resources	= ARRAY_SIZE(stmpe_ts_resources),
>  };
> @@ -484,7 +490,7 @@ static struct resource stmpe_adc_resources[] = {
>  
>  static const struct mfd_cell stmpe_adc_cell = {
>  	.name		= "stmpe-adc",
> -	.of_compatible	= "st,stmpe-adc",
> +	.of_compatible	= STMPE_ADC_COMPATIBLE,
>  	.resources	= stmpe_adc_resources,
>  	.num_resources	= ARRAY_SIZE(stmpe_adc_resources),
>  };
> @@ -1362,19 +1368,16 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
>  	pdata->autosleep = (pdata->autosleep_timeout) ? true : false;
>  
>  	for_each_available_child_of_node(np, child) {
> -		if (of_node_name_eq(child, "stmpe_gpio")) {
> +		if (of_device_is_compatible(child, STMPE_GPIO_COMPATIBLE))
>  			pdata->blocks |= STMPE_BLOCK_GPIO;
> -		} else if (of_node_name_eq(child, "stmpe_keypad")) {
> +		else if (of_device_is_compatible(child, STMPE_KEYPAD_COMPATIBLE))
>  			pdata->blocks |= STMPE_BLOCK_KEYPAD;
> -		} else if (of_node_name_eq(child, "stmpe_touchscreen")) {
> +		else if (of_device_is_compatible(child, STMPE_TS_COMPATIBLE))
>  			pdata->blocks |= STMPE_BLOCK_TOUCHSCREEN;
> -		} else if (of_node_name_eq(child, "stmpe_adc")) {
> +		else if (of_device_is_compatible(child, STMPE_ADC_COMPATIBLE))
>  			pdata->blocks |= STMPE_BLOCK_ADC;
> -		} else if (of_node_name_eq(child, "stmpe_pwm")) {
> +		else if (of_device_is_compatible(child, STMPE_PWM_COMPATIBLE))
>  			pdata->blocks |= STMPE_BLOCK_PWM;
> -		} else if (of_node_name_eq(child, "stmpe_rotator")) {
> -			pdata->blocks |= STMPE_BLOCK_ROTATOR;
> -		}

This should be a separate patch.

>  	}
>  }
>  

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
