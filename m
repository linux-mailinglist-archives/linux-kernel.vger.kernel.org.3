Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A388156342C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiGANNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiGANN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:13:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19CCC8;
        Fri,  1 Jul 2022 06:13:24 -0700 (PDT)
Received: from p508fd39e.dip0.t-ipconnect.de ([80.143.211.158] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o7GST-0001fu-9M; Fri, 01 Jul 2022 15:13:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 6/6] pinctrl: sunxi: Add driver for Allwinner D1/D1s
Date:   Fri, 01 Jul 2022 15:13:17 +0200
Message-ID: <17090319.JCcGWNJJiE@phil>
In-Reply-To: <20220626021148.56740-7-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org> <20220626021148.56740-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. Juni 2022, 04:11:47 CEST schrieb Samuel Holland:
> These SoCs contain a pinctrl with a new register layout. Use the variant
> parameter to set the right register offsets. This pinctrl also increases
> the number of functions per pin from 8 to 16, taking advantage of all 4
> bits in the mux config field (so far, only functions 0-8 and 14-15 are
> used). This increases the maximum possible number of functions.
> 
> D1s is a low pin count version of the D1 SoC, with some pins omitted.
> The remaining pins have the same function assignments as D1.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

On a D1-Nezha
Tested-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

with one remark below

> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index ec7daaa5666b..350044d4c1b5 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -1297,11 +1297,11 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
>  
>  	/*
>  	 * Find an upper bound for the maximum number of functions: in
> -	 * the worst case we have gpio_in, gpio_out, irq and up to four
> +	 * the worst case we have gpio_in, gpio_out, irq and up to seven
>  	 * special functions per pin, plus one entry for the sentinel.
>  	 * We'll reallocate that later anyway.
>  	 */
> -	pctl->functions = kcalloc(4 * pctl->ngroups + 4,
> +	pctl->functions = kcalloc(7 * pctl->ngroups + 4,
>  				  sizeof(*pctl->functions),
>  				  GFP_KERNEL);
>  	if (!pctl->functions)
> @@ -1494,9 +1494,15 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>  	pctl->dev = &pdev->dev;
>  	pctl->desc = desc;
>  	pctl->variant = variant;
> -	pctl->bank_mem_size = BANK_MEM_SIZE;
> -	pctl->pull_regs_offset = PULL_REGS_OFFSET;
> -	pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
> +	if (pctl->variant >= PINCTRL_SUN20I_D1) {
> +		pctl->bank_mem_size = D1_BANK_MEM_SIZE;
> +		pctl->pull_regs_offset = D1_PULL_REGS_OFFSET;
> +		pctl->dlevel_field_width = D1_DLEVEL_FIELD_WIDTH;
> +	} else {
> +		pctl->bank_mem_size = BANK_MEM_SIZE;
> +		pctl->pull_regs_offset = PULL_REGS_OFFSET;
> +		pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
> +	}

this is likely ok for _one_ variant (so for now this should be ok) but
will get ugly when there are more of them.

So in the long term it might make sense to pass these values in from
the soc-specific driver maybe?


Heiko


