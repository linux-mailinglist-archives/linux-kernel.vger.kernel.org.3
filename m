Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357D34635A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbhK3NmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhK3NmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:42:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864BC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:39:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso19548984wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=E60T24zX7KDl2K2domt3cduRqwrjvQOEzfi54FXnknA=;
        b=qXuVrOAnZpxdW+1ahCDawZgNSsxKUWUqj8biapI3zv6U74/HuxE9qyaekQZ6QEq25L
         uax7Qs9lXyv6EoTVv9zRWmfpDPmooYcSLhBe7ajPH1uOYhSlquv1dCqVKe6XRJYS+Fr5
         FR+sVQINaW166CUnEfBbRvzcmdywwFcIO9YuRkRL0fNURqjRNQtfac9z2Obf1a/ZPpex
         puaY6914+XmRiONkZSZKBzgELb83OUJvfg1nFYPwSO6ixc/LnhXn2iCgCukMawYf8/Tu
         4nazkQZRBTXkgadZE0NHWoM0VAyRsSgI/j2y/CCdBIk/NF72C8FilOAxYatKoRbg6oyQ
         BJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=E60T24zX7KDl2K2domt3cduRqwrjvQOEzfi54FXnknA=;
        b=vNB1/FmFQq9UaLuq/dy3xO8nH7poBBIwjpLpL7J4yqj8g00OJ3mJZNzEvAubQNIlox
         diUHoeMkeDtMRX0a1SnZ8xs2gFI9A+eZz/EsUgqoOJQA8i6ABiJT4dm4F4gjEd8w7g6Z
         4h6wPPP5k6iCZYkaq/NJZKxSKHWsisWmTakgRPdhLiCl5KNTCOWj52ihJHk3ZbUs8CSF
         WgLMTN/dnSPhZSE4UzF4zae7gvagqvUE7GvhTc5g55N+gA83L/XFCx3PNcgLWCAcyI1d
         MhitzZAF1ecyzk00T1Ot/p7m/mCl0XzUtULnQeBPT48Sk1x/CZi5aSC2t/C9erzr62je
         PDcg==
X-Gm-Message-State: AOAM531h4l2K8yyVigofhlkwOIDmRbepdeNMyxx7k+tFmHAASWpvBXPS
        DDaX1H+55INB1wxKnAsKZRNGIw==
X-Google-Smtp-Source: ABdhPJytmq+IF9a3nBkaL5+8n7g/UkZ/XjK6IBbQPNyrRjBek1UNMG5XNvhwwWnYSJ6Bhn1h/8OJGA==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr5110876wmk.27.1638279542582;
        Tue, 30 Nov 2021 05:39:02 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g16sm3006844wmq.20.2021.11.30.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:39:01 -0800 (PST)
References: <20211031135006.1508796-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH v3] clk: meson: gxbb: Fix the SDM_EN bit for MPLL0 on GXBB
Date:   Tue, 30 Nov 2021 14:38:32 +0100
In-reply-to: <20211031135006.1508796-1-martin.blumenstingl@googlemail.com>
Message-ID: <1jilw9g3uz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 31 Oct 2021 at 14:50, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> There are reports that 48kHz audio does not work on the WeTek Play 2
> (which uses a GXBB SoC), while 44.1kHz audio works fine on the same
> board. There are also reports of 48kHz audio working fine on GXL and
> GXM SoCs, which are using an (almost) identical AIU (audio controller).
>
> Experimenting has shown that MPLL0 is causing this problem. In the .dts
> we have by default:
> 	assigned-clocks = <&clkc CLKID_MPLL0>,
> 			  <&clkc CLKID_MPLL1>,
> 			  <&clkc CLKID_MPLL2>;
> 	assigned-clock-rates = <294912000>,
> 			       <270950400>,
> 			       <393216000>;
> The MPLL0 rate is divisible by 48kHz without remainder and the MPLL1
> rate is divisible by 44.1kHz without remainder. Swapping these two clock
> rates "fixes" 48kHz audio but breaks 44.1kHz audio.
>
> Everything looks normal when looking at the info provided by the common
> clock framework while playing 48kHz audio (via I2S with mclk-fs = 256):
>         mpll_prediv                 1        1        0  2000000000
>            mpll0_div                1        1        0   294909641
>               mpll0                 1        1        0   294909641
>                  cts_amclk_sel       1        1        0   294909641
>                     cts_amclk_div       1        1        0    12287902
>                        cts_amclk       1        1        0    12287902
>
> meson-clk-msr however shows that the actual MPLL0 clock is off by more
> than 38MHz:
>         mp0_out               333322917    +/-10416Hz
>
> The rate seen by meson-clk-msr is very close to what we would get when
> SDM (the fractional part) was ignored:
>   (2000000000Hz * 16384) / ((16384 * 6) = 333.33MHz
> If SDM was considered the we should get close to:
>   (2000000000Hz * 16384) / ((16384 * 6) + 12808) = 294.9MHz
>
> Further experimenting shows that HHI_MPLL_CNTL7[15] does not have any
> effect on the rate of MPLL0 as seen my meson-clk-msr (regardless of
> whether that bit is zero or one the rate is always the same according to
> meson-clk-msr). Using HHI_MPLL_CNTL[25] on the other hand as SDM_EN
> results in SDM being considered for the rate output by the hardware. The
> rate - as seen by meson-clk-msr - matches with what we expect when
> SDM_EN is enabled (fractional part is being considered, resulting in a
> 294.9MHz output) or disable (fractional part being ignored, resulting in
> a 333.33MHz output).
>
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied. Thx

> ---
> changes since v2 at [1]:
> - add Christian's Tested-by (thank you!)
> - s/his/the/ to fix the grammar in the first sentence as spotted by
>   Christian (off-list)
>
> changes since v1 at [0]:
> - consider HHI_MPLL_CNTL[25] as SDM_EN bit after Jerome helped me
>   understand the purpose of SDM_EN and gave some explanation why this
>   can't be a spread spectrum bit
>
>
> [0] https://patchwork.kernel.org/project/linux-amlogic/patch/20211016145939.15643-1-martin.blumenstingl@googlemail.com/
> [1] https://patchwork.kernel.org/project/linux-amlogic/patch/20211027185326.1653827-1-martin.blumenstingl@googlemail.com/
>
>
>  drivers/clk/meson/gxbb.c | 44 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index d6eed760327d..608e0e8ca49a 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -713,6 +713,35 @@ static struct clk_regmap gxbb_mpll_prediv = {
>  };
>  
>  static struct clk_regmap gxbb_mpll0_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = HHI_MPLL_CNTL7,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = HHI_MPLL_CNTL,
> +			.shift   = 25,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = HHI_MPLL_CNTL7,
> +			.shift   = 16,
> +			.width   = 9,
> +		},
> +		.lock = &meson_clk_lock,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gxbb_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap gxl_mpll0_div = {
>  	.data = &(struct meson_clk_mpll_data){
>  		.sdm = {
>  			.reg_off = HHI_MPLL_CNTL7,
> @@ -749,7 +778,16 @@ static struct clk_regmap gxbb_mpll0 = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "mpll0",
>  		.ops = &clk_regmap_gate_ops,
> -		.parent_hws = (const struct clk_hw *[]) { &gxbb_mpll0_div.hw },
> +		.parent_data = &(const struct clk_parent_data) {
> +			/*
> +			 * Note:
> +			 * GXL and GXBB have different SDM_EN registers. We
> +			 * fallback to the global naming string mechanism so
> +			 * mpll0_div picks up the appropriate one.
> +			 */
> +			.name = "mpll0_div",
> +			.index = -1,
> +		},
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,
>  	},
> @@ -3044,7 +3082,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>  		[CLKID_VAPB_1]		    = &gxbb_vapb_1.hw,
>  		[CLKID_VAPB_SEL]	    = &gxbb_vapb_sel.hw,
>  		[CLKID_VAPB]		    = &gxbb_vapb.hw,
> -		[CLKID_MPLL0_DIV]	    = &gxbb_mpll0_div.hw,
> +		[CLKID_MPLL0_DIV]	    = &gxl_mpll0_div.hw,
>  		[CLKID_MPLL1_DIV]	    = &gxbb_mpll1_div.hw,
>  		[CLKID_MPLL2_DIV]	    = &gxbb_mpll2_div.hw,
>  		[CLKID_MPLL_PREDIV]	    = &gxbb_mpll_prediv.hw,
> @@ -3439,7 +3477,7 @@ static struct clk_regmap *const gxl_clk_regmaps[] = {
>  	&gxbb_mpll0,
>  	&gxbb_mpll1,
>  	&gxbb_mpll2,
> -	&gxbb_mpll0_div,
> +	&gxl_mpll0_div,
>  	&gxbb_mpll1_div,
>  	&gxbb_mpll2_div,
>  	&gxbb_cts_amclk_div,

