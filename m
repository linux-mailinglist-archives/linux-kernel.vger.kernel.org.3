Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88B568C59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiGFPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiGFPIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:08:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2E2611C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:08:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so9163993wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TbP0pdHnPrM+ouGZkcA/VEgDW4UJQvTk7vLH9xNZObg=;
        b=IJq4gEtiTBgqd6KWJWBbKv2TPoHt99rC4NLQtdItczQ1y+MmeEP6fwS5Uh9l9JSj6a
         R11ojWCiVINF9F0Yl0FOpfLjwb4Bv59VT6JPM5er3Gq1jxsQ3zJ4G5BfjpXX4VO4SN5f
         +kK4xyhvnDfYmqv25lHwjKXKmPkd5q0b9RQZjfYoLXFIuAJm6YY9mGEhymiV7ioj/bD1
         dUo1G7Y8YJZQEYQ0xbMOUUbDnsirMAYLYT3DFU56Rc5w90XmF7+TfJTb609EKYhA+pm8
         e/giTKkwSjfSUT4bzyxhixfJyhFUe3bIvARGCEpme9s2lL2K9UdfdY7trfZK2DTpt8qt
         e6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TbP0pdHnPrM+ouGZkcA/VEgDW4UJQvTk7vLH9xNZObg=;
        b=gaKR8Vfhs+RLY5H79HyIQZsRBcQQ311IF9wIgbjYwpAujWKTkINkTuRG6az5VrBLjA
         8BEILLmNwxOV3LXzkNEFuA90x/rQAXE0vITwBddJaEZ0bwYe+4THMxwEVh7Dki7GBVgA
         22mWsmaJLNHjxxIGySAhZexmtn1PJwYYkvlb208mpNOSCKjpApy9oeiwWqMnmRFM5feT
         GujVsUjaZwhKHyDZPBnz90mK61XpNCwfBbMSxNHhTgv88qx+8I4t43OaOC/G4HMlC3pq
         ek0GfVEXdn151u//1mugjDvaHkvMTFLV24iO2VKm2JL4CWPGH7dC3T6IDYTNIMHkauQR
         TQVg==
X-Gm-Message-State: AJIora8Zm5/vepR9XeoFUnl1LnGVqOqMiDF7oz50UpEHJ2AEJBrFdNIs
        pv90TYimBVpE1w4lHjg97SMsqg==
X-Google-Smtp-Source: AGRyM1uGG0ewtPXWfcllw80dByjPMwdwNd8zLJCX7giMogiZUR7jCqN1Olu4VSXFEGiD3ycFpSGtmg==
X-Received: by 2002:a05:600c:3591:b0:3a0:563a:49d3 with SMTP id p17-20020a05600c359100b003a0563a49d3mr40932058wmq.60.1657120097258;
        Wed, 06 Jul 2022 08:08:17 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm35856542wrs.64.2022.07.06.08.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:08:16 -0700 (PDT)
Date:   Wed, 6 Jul 2022 18:08:15 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC] clk: Add clk_hw based provider enable/disable API
Message-ID: <YsWlX0YtKoMkd/Qw@linaro.org>
References: <20220704185733.1288578-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704185733.1288578-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-04 21:57:33, Abel Vesa wrote:
> Sometimes, a clock needs to be enabled or disabled by the provider,
> without actually touching the enable count. For example, a clock
> provider driver might choose to disable some unused clocks on sync state
> callback rather than on the default clk_disable_unused. Such clocks are
> usually enabled by bootloader and need to stay ungated until some driver
> built as module probes. So add clk_hw enable/disable to allow the clock
> provider drivers to disable such clocks on sync state callback.
>

Ignore this one please.

There is a new RFC here:
https://lore.kernel.org/lkml/20220706150411.708213-1-abel.vesa@linaro.org/

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
>  include/linux/clk-provider.h |  2 ++
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f00d4c1158d7..a727cffb6bba 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1011,6 +1011,17 @@ void clk_disable(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
>
> +void clk_hw_disable(const struct clk_hw *hw)
> +{
> +	struct clk_core *core = hw->core;
> +
> +	trace_clk_disable(core);
> +	if (core->ops->disable)
> +		core->ops->disable(core->hw);
> +	trace_clk_disable_complete(core);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_disable);
> +
>  static int clk_core_enable(struct clk_core *core)
>  {
>  	int ret = 0;
> @@ -1176,6 +1187,20 @@ int clk_enable(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);
>
> +int clk_hw_enable(const struct clk_hw *hw)
> +{
> +	struct clk_core *core = hw->core;
> +	int ret = 0;
> +
> +	trace_clk_enable(core);
> +	if (core->ops->enable)
> +		ret = core->ops->enable(core->hw);
> +	trace_clk_enable_complete(core);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_enable);
> +
>  /**
>   * clk_is_enabled_when_prepared - indicate if preparing a clock also enables it.
>   * @clk: clock source
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index c10dc4c659e2..0f9968a7a6d2 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1212,6 +1212,8 @@ unsigned long clk_hw_get_flags(const struct clk_hw *hw);
>  bool clk_hw_is_prepared(const struct clk_hw *hw);
>  bool clk_hw_rate_is_protected(const struct clk_hw *hw);
>  bool clk_hw_is_enabled(const struct clk_hw *hw);
> +int clk_hw_enable(const struct clk_hw *hw);
> +void clk_hw_disable(const struct clk_hw *hw);
>  bool __clk_is_enabled(struct clk *clk);
>  struct clk *__clk_lookup(const char *name);
>  int __clk_mux_determine_rate(struct clk_hw *hw,
> --
> 2.34.3
>
