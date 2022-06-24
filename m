Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A4558F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiFXEFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFXEFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:05:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD1563A0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:05:38 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id be10so2123544oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Jjrq7awYQaeFzIlST9+9YCiK3puRVXguo52HCZEX/o=;
        b=Jg2HxYha/NIZgJEWtC/HRXceJtHhMZJ1yOl23yPzbXLoV3kc+hbn3kalj7vjH7MEeO
         X1r5KUBpuZf+MJ05ptSbldK4EcmucQBgQKOiDVQE97ktDpdmRFTP/U+k1TETkoNaB3P6
         hZa36XQdTinfQ54HLNL5l+448dkt6dRoQzc/3ofXBFb09cMqV3woXsh6dp7cEiCZoC/G
         lRahLFQCIy2WLmOBj7wogMP+PAeFUuALqD9YqkC5YubrwI71wDJ9ytlZloBGYRMPClhB
         UT4ySd4lyfz4hVYYWwR1z2rfzQx0FIiG25vPy6+pjl6Yeux7xwtNz/YhqqqIq/F0U48/
         fE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Jjrq7awYQaeFzIlST9+9YCiK3puRVXguo52HCZEX/o=;
        b=phXDsp3j+OlftVhDWHE9rpSHxJGN4MezR3mVeaqOkkAV3ts7j524/sAokPFCcC4p7d
         6y9ENhR0UpneCbSJFf4/g973k6OepO3wEiF0n3ucoKrDavnc31IGuhIcySoahf42YUAy
         rG/h8Op1h6Ai4gjvRfSNMZP3Kx9e1fH4xsgzuW/Gc1iqKX8Ay7P53k/RJv7KakLFPTB4
         mxsvbxozfH7LNCnRKiYV3aNrYC6Z3hjfIjayTGsPJWmxEfyKGq6VbhXSrVa4rckG3RKP
         +hZrEj4FZ495i0Ri7Jsdw+tvFl7Bf0OfbdvPm5aFXwoXTYLdaHY08Gq5/qVPDdCiqDw+
         KmGg==
X-Gm-Message-State: AJIora/a96DWD4z32JMzqG00DSB7CXhWsOhCw+8Kvxc6D4aqQj326UJV
        aDVGz9TnsRFDpoptgHOOGtKJlQ==
X-Google-Smtp-Source: AGRyM1vDeI5MEyL2hISaemwrekGndBtHUjrULdlHJG/uc5iI8LR6oGhEiG9J6lfWw7kjbDqmUp1kDA==
X-Received: by 2002:a05:6808:20a8:b0:32e:d283:2dfa with SMTP id s40-20020a05680820a800b0032ed2832dfamr791710oiw.279.1656043538330;
        Thu, 23 Jun 2022 21:05:38 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s64-20020acaa943000000b0032f51af1999sm542996oie.42.2022.06.23.21.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:05:37 -0700 (PDT)
Date:   Thu, 23 Jun 2022 23:05:35 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sricharan R <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 3/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Message-ID: <YrU4D+eDBctFl0ZY@builder.lan>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-4-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621161126.15883-4-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Jun 11:11 CDT 2022, Sricharan R wrote:
> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
[..]
> +static const struct clk_parent_data gcc_xo_gpll0_gpll0_out_main_div2[] = {
> +	{ .fw_name = "xo", .name = "xo", },

Please replace .fw_name with .index based lookup, in line with what was
done in gcc-sc8280xp.c recently.

There's no reason to include global name lookup (.name) in new drivers,
so please omit this part.

> +	{ .fw_name = "gpll0", .name = "gpll0", },
> +	{ .fw_name = "gpll0_out_main_div2", .name = "gpll0_out_main_div2", },
> +};
> +
[..]
> +static struct clk_alpha_pll gpll0_main = {
> +	.offset = 0x21000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.clkr = {
> +		.enable_reg = 0x0b000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gpll0_main",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +				.name = "xo",

Are you referring to the board XO here, or the CXO pin on the SoC? On
many platforms these are not the same...

Please omit the .name here as well and as this is used a few times,
please create a struct clk_parent_data for this parent.

> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_stromer_ops,
> +			.flags = CLK_IS_CRITICAL,
> +		},
> +	},
> +};
> +
> +static struct clk_fixed_factor gpll0_out_main_div2 = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gpll0_out_main_div2",
> +		.parent_data = &(const struct clk_parent_data){

It would be nice to have a space inbetween ) and { in all these.

> +			.fw_name = "gpll0_main",
> +			.name = "gpll0_main",
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_fixed_factor_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
[..]
> +static struct clk_branch gcc_gephy_tx_clk = {
> +	.halt_reg = 0x56014,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x56014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gephy_tx_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "gmac0_tx_div_clk_src",
> +				.name = "gmac0_tx_div_clk_src",
> +			},

This parent_data is repeated multiple times, but more importantly it's
not an external clock, so you should use .parent_hw instead of
.parent_data.

Please review the parent for all your clocks.

Regards,
Bjorn
