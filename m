Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7344B1646
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiBJT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:28:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbiBJT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:28:15 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51012D5B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:28:15 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so7578498oor.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=930D25X04cls2iefsnzWxuxmTzXtcDAW/bM9OqaMjEA=;
        b=BLXOiLlcd94cXNUI9tLNT5nu82g6d0e2d9uHrjUvhuxu2Rcgl9v8bzKfU+Qw4LxJIc
         nIVVswvxMq9Mnscy2DbpXvD8rd3Vu/jaT15CRCuEgt6SLD0ARECopjZANsVuZaCjUOc3
         zHRt5wtmSlI99gqHRfhtJ+fSH0UkZCju2qH8mkjMulfWYnskxOdr6N9EV58PJXzJTVn7
         VCpsqW3vG5mYmK8V8y8UO2665XFsBoausGbUg9LuUk+GSFrA2ILpdah32G2Q200s1ETE
         GUMV+dnA61FFLsx2DgYrilOuOXF8X4NH0u6dYQlura2Or2HMksoTPpRkJ2cuNezpzpQQ
         pw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=930D25X04cls2iefsnzWxuxmTzXtcDAW/bM9OqaMjEA=;
        b=E0X/04YmWvhX5osnzTV1A/4yknXwnbLyCBYsU6oqxpYBY3BgpGO+r1e9867B37kDOZ
         ss4rf1rWpZ9w3MIqzKhaY8WmqVwJRZotAGCaZmO7/e3MFHVXy6oxdkv+mysTBQB8QkWi
         qGpa13e7WutAVnpeiAyhG3YZx98/UM7Vp4JPH9Gr95sWiA1bhZjI9ndbVQsP4KlhdwXG
         xC3ckt+UO0bVSwR25eekUyBdMyLcxOd0sLJBUA5XCGfYOaGt0ONI/viFj8A91oMyG/tO
         iXkH0E/WTpMTeNGCogF3zqJ5AH44M5lgoxzjg0+5XZRxTBh3JHW3Fey4efFq15dSVx9r
         2l2w==
X-Gm-Message-State: AOAM530baMDqw5Q9ejrQbIVoM7JN2zf5EBVjtPOAvG6kE9/GrVsWZKsX
        r/Froq4/1gmKXiJ2d4GC8mzkJg==
X-Google-Smtp-Source: ABdhPJy8koDFl1OaFEQRTBRYLvOnNs2S1GQYo5qnHkTPB2EgbYUGL4lu2a6RQU2DcuCpTQu/g3MuBg==
X-Received: by 2002:a05:6870:d2a5:: with SMTP id d37mr1265185oae.75.1644521294612;
        Thu, 10 Feb 2022 11:28:14 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id ge13sm4788677oab.4.2022.02.10.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:28:14 -0800 (PST)
Date:   Thu, 10 Feb 2022 13:28:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette ? <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v1 1/2] clk: qcom: gdsc: Use the default transition delay for
 GDSCs
Message-ID: <YgVnSy7hjak9aS2T@builder.lan>
References: <20220209172513.17873-1-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209172513.17873-1-tdas@codeaurora.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Feb 11:25 CST 2022, Taniya Das wrote:

> Do not update the transition delay and use the default reset values.
> 
> Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/gdsc.c | 6 +++++-
>  drivers/clk/qcom/gdsc.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 7e1dd8ccfa38..e7b213450640 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -380,7 +380,11 @@ static int gdsc_init(struct gdsc *sc)
>  	 */
>  	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
>  	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
> -	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
> +
> +	regmap_read(sc->regmap, sc->gdscr, &val);
> +
> +	if (!(sc->flags & DEFAULT_TRANSITION_DELAY))
> +		val |= EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;

Forgot to point out this yesterday, but these are multi-bit values, so
you need to mask out whatever bits are already set before filling in the
new ones.

Regards,
Bjorn

>  	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index d7cc4c21a9d4..1bd3ecdd0b0a 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -53,6 +53,7 @@ struct gdsc {
>  #define ALWAYS_ON	BIT(6)
>  #define RETAIN_FF_ENABLE	BIT(7)
>  #define NO_RET_PERIPH	BIT(8)
> +#define DEFAULT_TRANSITION_DELAY	BIT(9)
>  	struct reset_controller_dev	*rcdev;
>  	unsigned int			*resets;
>  	unsigned int			reset_count;
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
