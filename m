Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0244D1FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbiCHSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349430AbiCHSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:12:50 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66156C08
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:11:53 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w17-20020a056830111100b005b22c584b93so5991504otq.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCjdrkWFXlI2z3fvVt8j+mPo6k+YDOLeGzfqyXA7qwI=;
        b=Rt7ZP4DLJ8Wvx6/WSEzVQ+9M9PDDM1AMWmX47E+JoHJJLzlhu1GZ6UBtDpeWJlmCis
         JElGAotsUYcn60aAgpObiD+qgQ7vWebEub1OIMH1Yt+WOhiFkZlu6nKcvXcA5xMQUexW
         bQ75EJDkJdHW7EPeiKBCVxbEfvsLdMupm+RRCyoPAWndKIGFS20MAr5SaTQweE8fL7cK
         rdpxJUO1sxQN4H0yp6pCT4pg+GMD92K7cunI9n1yfLMXAy+OwhlEJZrrPjc646j6VCHp
         qPXIQ5zK4FLN3mOYJrBjLT4NVSHKN/ng/zOCIyHqQl0iQC0tDnQe6cAweP7FFc3p/ksz
         Ioww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCjdrkWFXlI2z3fvVt8j+mPo6k+YDOLeGzfqyXA7qwI=;
        b=tWcwBzn39/u9wD+mrqA4ERRnEnweeEuJGyLDN/G8fmwXG5kAGbwCBTalF0nNfdCiFH
         N0WFcZpbdXSws8UVIyaVobYGq+y4S0hi0yrqoiECzyPZFNsGh4SXt28R8g+WBVBLkQcg
         oE9yCinB9G3b07OD1fnphZYuiJCxwfaqDOJlLsa+bbN8QmSUkxh/ppJOUro9WFuhIXw5
         q82gnNYDmsuMF5AQRyl16ys9SON60L83bgJUwzWzLySUdVN6WYcB7S2Kti0gS2BaLfSm
         kraEg4vyTcV5Kr+i/L1u7hd1gRQhJpRHfquT9cMcY/LGzYzKKRrUywfw4TnBWyePK0rb
         DeFg==
X-Gm-Message-State: AOAM532kPHkfRaFvh2irWE84v0ZbGpOEd6Pq6U/+q9gboC7/z+jalaMa
        iv11IEtG/mXbOGCsEUe3PNAZzg==
X-Google-Smtp-Source: ABdhPJxvEGLL54Z+BCjwAaRSpUbf47FFGDFMMrjqGpR5+XILsKSYph+QmQPxjTwKOFmXTYhdaeb/wQ==
X-Received: by 2002:a9d:4e99:0:b0:5b2:54f4:75e7 with SMTP id v25-20020a9d4e99000000b005b254f475e7mr1433951otk.94.1646763112445;
        Tue, 08 Mar 2022 10:11:52 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b000da4bcdae42sm3072206oak.13.2022.03.08.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:11:52 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:13:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 7/7] pinctrl: qcom: Update clock voting as optional
Message-ID: <Yieczzo96xSaA7jp@ripper>
References: <1646737394-4740-1-git-send-email-quic_srivasam@quicinc.com>
 <1646737394-4740-8-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646737394-4740-8-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Mar 03:03 PST 2022, Srinivasa Rao Mandadapu wrote:

> Update bulk clock voting to optional voting as ADSP bypass platform doesn't
> need macro and decodec clocks,

Even I am not sure what "ADSP bypass platform" means, so please express
this better.

Are they optional because sc7280 typically come with ADSP based audio,
but it might not and if not then we shouldn't control those clocks?

> these are maintained as power domains and
> operated from lpass audio core cc.
> 

So there are clocks, but they are exposed as power-domains? Or are you
just trying to say that the LPASS LPI pinctrl block is always in a
power-domain controlled by the audio clock-controller?

Regards,
Bjorn

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 12 +++++++++---
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  1 +
>  drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c |  1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 1ab572f..c618b74 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -407,9 +407,15 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
>  				     "Slew resource not provided\n");
>  
> -	ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Can't get clocks\n");
> +	if (data->is_clk_optional) {
> +		ret = devm_clk_bulk_get_optional(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Can't get clocks\n");
> +	} else {
> +		ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Can't get clocks\n");
> +	}
>  
>  	ret = clk_bulk_prepare_enable(MAX_LPI_NUM_CLKS, pctrl->clks);
>  	if (ret)
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> index afbac2a..3bcede6 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> @@ -77,6 +77,7 @@ struct lpi_pinctrl_variant_data {
>  	int ngroups;
>  	const struct lpi_function *functions;
>  	int nfunctions;
> +	int is_clk_optional;
>  };
>  
>  int lpi_pinctrl_probe(struct platform_device *pdev);
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> index d67ff25..304d8a2 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> @@ -142,6 +142,7 @@ static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>  	.ngroups = ARRAY_SIZE(sc7280_groups),
>  	.functions = sc7280_functions,
>  	.nfunctions = ARRAY_SIZE(sc7280_functions),
> +	.is_clk_optional = 1,
>  };
>  
>  static const struct of_device_id lpi_pinctrl_of_match[] = {
> -- 
> 2.7.4
> 
