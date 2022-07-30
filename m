Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055A3585B81
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiG3SIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3SID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 14:08:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736E15739
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:08:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a11so3949721wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DEFqBxpGYalSFZL6OyvPXVJgfc+DfLkkt00YWVhvQvA=;
        b=qs5oQJumRaRtz8lFgAlzeo/WdCMLpZRexyaOC9me35nCrjMyQQXoOSYHCod1Tz1QuZ
         WXkFCx2sOvZJTnLD8wwQcTdyaEwOLyE+ouAIdWkXYSH0FovvG80z3At9m7o6mEp436ZI
         F+vQbpoIjno8ZU7isqApAgB0bxLwgGATfrgYllwYQksROAriG7+vdzH+XoSO9nAGrEHS
         +I1mm/WwGWo2hzlKqakTzvxKF666dn7rm+5/yGLynyJVW0mfKoY5qqfpvWXhCoo/9thY
         nEjxDKMuxIV7i/vqoYr1drhbuez5auYEXErbv4KagE3P8IpKLuf+SURoQKHMttnh8Dps
         aRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DEFqBxpGYalSFZL6OyvPXVJgfc+DfLkkt00YWVhvQvA=;
        b=B51SZTheA4gmwz0J6yykphOKYHczmIUzg6x4TK2jKpnlzMdKzxCB0EIU/VJT8f6aqY
         JE6gA7eLSqHDSE+fiU2XilOdG5Ur09bytZ+fHhgi08k/DVV4l0J88/FBEmsK+YgE3BF4
         d5SsDep3F76xjiriJoWReUya549vSayZR2xkQQPT5mIQFoQTW5E9UXxMn7div+tOSnqn
         aassvWvlDwAMf9j3vBv8u/TW9ArT8DYgAbJC4SxBL6j/6YuvKDRCnUQTkTLX8Run17We
         Ygg9w5YUVfMfchDaZ1zdRELeVChlKtwlIHPbff2foC2tZ9H+rxlAyFskafDHeNbdRNMK
         BiEw==
X-Gm-Message-State: AJIora8iJR3wHjT9xhnFDFiVF3zwLX1cCeg8sNBJS6qrn4rxjRb3zbVg
        fYgZr4mpd3sCEmwQ1VmEqEs2yA==
X-Google-Smtp-Source: AGRyM1sdWlbCPaVwiL5pfzStXWu0cIr1reMTk3zcFDoEg0LbWe4fifB89JMFMP8qG8R5r5nNikijxA==
X-Received: by 2002:a05:600c:798:b0:3a3:f03:f80e with SMTP id z24-20020a05600c079800b003a30f03f80emr6504503wmo.33.1659204480128;
        Sat, 30 Jul 2022 11:08:00 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b003a31ca9dfb6sm10442420wmp.32.2022.07.30.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 11:07:59 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:07:58 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: Do not fail if regulators are
 not found
Message-ID: <20220730180758.tzgfchqhkqldtm6b@linaro.org>
References: <20220730062834.12780-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730062834.12780-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-30 11:58:34, Manivannan Sadhasivam wrote:
> devm_regulator_get_optional() API will return -ENODEV if the regulator was
> not found. For the optional supplies CX, PX we should not fail in that case
> but rather continue. So let's catch that error and continue silently if
> those regulators are not found.
>
> The commit 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with
> optional px and cx regulators") was supposed to do the same but it missed
> the fact that devm_regulator_get_optional() API returns -ENODEV when the
> regulator was not found.
>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Fixes: 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators")
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Yep, makes sense.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 98f133f9bb60..5bf69ef53819 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -362,12 +362,24 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
>  static int adsp_init_regulator(struct qcom_adsp *adsp)
>  {
>  	adsp->cx_supply = devm_regulator_get_optional(adsp->dev, "cx");
> -	if (IS_ERR(adsp->cx_supply))
> -		return PTR_ERR(adsp->cx_supply);
> +	if (IS_ERR(adsp->cx_supply)) {
> +		/* Do not fail if the regulator is not found */

Maybe this comment is redundant.

> +		if (PTR_ERR(adsp->cx_supply) == -ENODEV)
> +			adsp->cx_supply = NULL;
> +		else
> +			return PTR_ERR(adsp->cx_supply);
> +	}
>
> -	regulator_set_load(adsp->cx_supply, 100000);
> +	if (adsp->cx_supply)
> +		regulator_set_load(adsp->cx_supply, 100000);
>
>  	adsp->px_supply = devm_regulator_get_optional(adsp->dev, "px");
> +	if (IS_ERR(adsp->px_supply)) {
> +		/* Do not fail if the regulator is not found */

Same here.

> +		if (PTR_ERR(adsp->px_supply) == -ENODEV)
> +			adsp->px_supply = NULL;
> +	}
> +
>  	return PTR_ERR_OR_ZERO(adsp->px_supply);
>  }
>
> --
> 2.25.1
>
