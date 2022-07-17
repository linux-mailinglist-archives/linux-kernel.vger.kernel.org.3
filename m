Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C85773FE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 06:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGQEWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 00:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 00:21:58 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE9620189
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 21:21:57 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10cf9f5b500so14723639fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mbkGo6dIU+6JizS/LMQKqNHdhjR1NYxgpojkIHzM3/I=;
        b=wc4RvCjMQ//ADy8CdSvfCkTGkoqlMX67ESkQun7lswtrvxwftYseljH5n/Lai966yH
         hAh8l9gfW+zduy3yERfocA1q7KHJ3/73KMEmzNQ07pVScHbnmKy65jpd7y9zq3Innzkx
         QasRgok/GBzDyQ/2PzwIsEzoRt8k+wcXfpYlQjoueszG/0nN0OW1EEiLUOiEEF1Y6eiH
         bK5ZE72ztSolaglfpNKHImxFxy3bm3t7in6DmauZcR8PsVtVuH4y6Fld5hOWDRq+xXNs
         ngXHTZNx+Gmb5eTQaqYyS7oIJQOT5R+VM46eN0B20ZdDdvuTf1k7lDb+48kMO/xEdNes
         m+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbkGo6dIU+6JizS/LMQKqNHdhjR1NYxgpojkIHzM3/I=;
        b=AIjQBi4uySAiU77CD12g43anFa7r63hzVyQ/N3VKen3NaORvjVd/swdMXZz8Tjg78C
         p4WJ9leWnXacjXoNDR8ZSwvoqxZfAo3XpxxSJzW/hY8mAUOhqJdNA2aJMDYafvd0rA65
         vW42V7kQeVc/ZZsbcCXPG4SMuds9iDDSSAd28MeHT7trgpKDVhcEIdwzWhzXZrVFZMRw
         HT6TmZLmTuCCYIPayl1e26ajda2eApnGJkIpM2jT4LAIjix3yR4ECojQKTofdox2C/1Q
         oHmSQIAo/8wtah9jRLKq4R0tRuHhaNvAqfr/jtjxwMeT8o9TFx0B6/UocdlmlRRK4kB5
         FBvA==
X-Gm-Message-State: AJIora80ELbmXgcCa9hi9tvFo8F0Wp+cy8oKJ4wZ9aFP3siWesYZt+nM
        qdab3/rlFk6Jbs6BdHQfNR3M/Q==
X-Google-Smtp-Source: AGRyM1ucLkz2KJ66sQM7quJWp24YqVAxDsCpWFcWV/Ff/w1BOHmeZACg+ZpKvY2eA76oE7R3/ucCZg==
X-Received: by 2002:a05:6808:2215:b0:33a:3acb:ef78 with SMTP id bd21-20020a056808221500b0033a3acbef78mr7929603oib.177.1658031716983;
        Sat, 16 Jul 2022 21:21:56 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u15-20020a056870304f00b0010be09dc797sm4432333oau.18.2022.07.16.21.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 21:21:56 -0700 (PDT)
Date:   Sat, 16 Jul 2022 23:21:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: qcom: Drop mmcx gdsc supply for dispcc and videocc
Message-ID: <YtOOYryxh9oEJXyg@builder.lan>
References: <20220713143200.3686765-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713143200.3686765-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jul 09:32 CDT 2022, Abel Vesa wrote:

> Both dispcc and videocc use mmcx power domain now.
> Lets drop the supply mmcx from every gdsc.
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 266e5cf39a0f ("arm64: dts: qcom: sm8250: remove mmcx regulator")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

This would break backwards compatibility with dtbs that used
mmcx-supply. We only ever used mmcx-supply in sm8250.dtsi upstream and
given that we only boot sm8250 off Android boot images it's unlikely
that anyone would use a new kernel with that old of a dtb...

So:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Dmitry, what do you think?

Regards,
Bjorn

> ---
>  drivers/clk/qcom/dispcc-sm8250.c  | 1 -
>  drivers/clk/qcom/videocc-sm8250.c | 4 ----
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> index 39b344ebb049..709076f0f9d7 100644
> --- a/drivers/clk/qcom/dispcc-sm8250.c
> +++ b/drivers/clk/qcom/dispcc-sm8250.c
> @@ -1138,7 +1138,6 @@ static struct gdsc mdss_gdsc = {
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
>  	.flags = HW_CTRL,
> -	.supply = "mmcx",
>  };
>  
>  static struct clk_regmap *disp_cc_sm8250_clocks[] = {
> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> index 8617454e4a77..f28f2cb051d7 100644
> --- a/drivers/clk/qcom/videocc-sm8250.c
> +++ b/drivers/clk/qcom/videocc-sm8250.c
> @@ -277,7 +277,6 @@ static struct gdsc mvs0c_gdsc = {
>  	},
>  	.flags = 0,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs1c_gdsc = {
> @@ -287,7 +286,6 @@ static struct gdsc mvs1c_gdsc = {
>  	},
>  	.flags = 0,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs0_gdsc = {
> @@ -297,7 +295,6 @@ static struct gdsc mvs0_gdsc = {
>  	},
>  	.flags = HW_CTRL,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs1_gdsc = {
> @@ -307,7 +304,6 @@ static struct gdsc mvs1_gdsc = {
>  	},
>  	.flags = HW_CTRL,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct clk_regmap *video_cc_sm8250_clocks[] = {
> -- 
> 2.34.3
> 
