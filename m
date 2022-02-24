Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3084C22B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiBXDzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiBXDzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:55:49 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430525A973
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:55:20 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so1693534oob.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ajP0nNbv/lY2RjaMzeZma7fHPb0CL6iW0Eaau4Kq0yc=;
        b=mYpgMlnXgiymLh+rrNxgaVG4lEFGLxJy9cg5bKJhj926cDrGiHcLxfHC2fFLtKYN5J
         JNxR2IGJdIRv0DUCsmciRUD3/WuZacEPBHw/k+k3DJ1xKUdxJ3bvGrh+6r2nKcRAqkEf
         rHz4LGxi8yAry8msa9geOq8x1CVa7jG/wl54DZLcKWDgT4oaqMh7R2+yde1aw4jWWOqq
         bYFxRu2/BZAYZqtqarh0+/40AJ7lUDmAHn2BeGbUU0ek1jXTwxTVhhCFq6zTTc/9cUUB
         AQmTmXyfpdlXKGkHyjmU/tMgXzviJUIz4B0yKySg4q1Ki48xp/BG+A/cSy4CNqOZK/kl
         woCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajP0nNbv/lY2RjaMzeZma7fHPb0CL6iW0Eaau4Kq0yc=;
        b=Ng0Lg28LdU6zM4dePpM3V00D2O7Ur48YqRwKj2Fj4C6R29WdTOT6gn0f3H2G5IDUTn
         qAbjiDGJCW1gwtlxFJgXryDGqSmQWcMm8lL4Ay6LTpUCqGLP/rqFfZqd9kvdW7pe3URd
         Z3XUnzVaS9IIsF8bnhNLwl6nkHAXI/3dy+1uqE+DZegQNPHgVm+jOekOA2wcQbC5V7Gv
         UjhJJLoStDBoQtqliBK0oAP2B5W4nedTVKMPucJlt/pUbJLeNJ1pyxVUdfLYRIxvIJS9
         W+OUcLGubewhlSssOkuK3kFnndtO/9fufZuHzB+XLCFYpXLpgcYJa/5o1Nm4H+V7dwN0
         N65A==
X-Gm-Message-State: AOAM532xhwi45IeGAYKg52FNbbhNkvHFAdDKvnr54MplmGfQhIiE1GdG
        EeJjANf/HUz4ZKXJOhnwoKjjyw==
X-Google-Smtp-Source: ABdhPJzUBXDkQzu1i/26Sjhn+mnlOEBwWEXhUKalWDKyryJROBtbxATXkrjyCP+SUh5VmMhs5flAWQ==
X-Received: by 2002:a4a:3545:0:b0:2c5:e0f2:53b7 with SMTP id w5-20020a4a3545000000b002c5e0f253b7mr277036oog.27.1645674919211;
        Wed, 23 Feb 2022 19:55:19 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id d18sm792721oiw.18.2022.02.23.19.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:55:18 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:55:16 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] clk: qcom: gcc-ipq806x: add additional freq nss
 cores
Message-ID: <YhcBpBflfTd5/BNF@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-9-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:

> Ipq8065 SoC (an evolution of ipq8064 SoC) contains nss cores that can be
> clocked to 800MHz. Add these missing freq to the gcc driver.
> 

Do we somehow need to ensure that these new frequencies are only
available on 8065?

Regards,
Bjorn

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq806x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> index a4bf78fe8678..53a61860063d 100644
> --- a/drivers/clk/qcom/gcc-ipq806x.c
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -232,7 +232,9 @@ static struct clk_regmap pll14_vote = {
>  
>  static struct pll_freq_tbl pll18_freq_tbl[] = {
>  	NSS_PLL_RATE(550000000, 44, 0, 1, 0x01495625),
> +	NSS_PLL_RATE(600000000, 48, 0, 1, 0x01495625),
>  	NSS_PLL_RATE(733000000, 58, 16, 25, 0x014b5625),
> +	NSS_PLL_RATE(800000000, 64, 0, 1, 0x01495625),
>  };
>  
>  static struct clk_pll pll18 = {
> @@ -2702,7 +2704,9 @@ static const struct freq_tbl clk_tbl_nss[] = {
>  	{ 110000000, P_PLL18, 1, 1, 5 },
>  	{ 275000000, P_PLL18, 2, 0, 0 },
>  	{ 550000000, P_PLL18, 1, 0, 0 },
> +	{ 600000000, P_PLL18, 1, 0, 0 },
>  	{ 733000000, P_PLL18, 1, 0, 0 },
> +	{ 800000000, P_PLL18, 1, 0, 0 },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 
