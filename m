Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A13518B10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiECRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiECRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:30:16 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24A3DA64
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:26:42 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d39f741ba0so17831529fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2k3cpfGt9JFegA6KgX3Wdyqcb/JfiOYe5mK4VUTGSr8=;
        b=D2X2A2LFnM50RSbYXgBOxQuOcQLyQWBAhPfbra7PKMuaJ0Ik18h1l3fe8Yb4L8Ob70
         rz0ztfn9A61oZ6abdBcPQq8Eo1ua/dKzdGVW+Z06MleIk0bKAErm4KEXbu2xq1/6733B
         qfkTLzqq4UZlValwttSSx01yqzWlooudhdBB27XHy9vSIZ2wGO1VZD5HHjWxI7Q6W1eY
         AvIpChgFEfliOaKoupcj15jelc+Ir1v7Z9LfG+mGNtGF6MW3XwfPKoHAB+Ogdq1GM8dG
         H7/N13dmB0si90m+84pJUul+yKUbW1PtSjq1pXUAEs03gz2y/K52zr0Buw/+LAMgPZl5
         Q88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2k3cpfGt9JFegA6KgX3Wdyqcb/JfiOYe5mK4VUTGSr8=;
        b=fjOcZL0HR1wSESr+UC7NAKwls8VQ7qFLbUS00RqjJAZEoSOLNFVfmRRI0WhaH/EejP
         c1MRM7aT/jGXkpg3yxvdIAJuSLc5kRVuqgyrcYaWVSZvC8x3CjWGtgx7+CF/RprvXt36
         0QV+8XyX3fZX6dT3xIeGc36dCfRYAbpt1NxJUlVPzNogEJKb0BIvUI4FWmn4lTnzoXOu
         acIZDW9TdjEmvwVFjTY7fgpRKac7bdxRQw3pCz0NA9Rcbmaqs/4v2KWlAFyk0NFUHv/e
         6GO9BEoV6PCXbOsAoLcPvxGn0r/bAMgfz0g53a2ZuSaet2upPQqf3IO0jaXZGJKDSVyJ
         JJZQ==
X-Gm-Message-State: AOAM531WDAACEEIMCn7f2RCH27x1BsK+DxINaSB0W8LIG7G3MMGFGZiB
        3TynGQUE2Lks1l51ghk6b910Tw==
X-Google-Smtp-Source: ABdhPJwmlkPfAFuNFoT8F1xGgn7IbCl9cF9x91o//UcNyy/Y0h3R1BVokCwzv7UQ4F3CpSmC0nze9w==
X-Received: by 2002:a05:6870:b401:b0:e9:9b18:667c with SMTP id x1-20020a056870b40100b000e99b18667cmr2237255oap.169.1651598802170;
        Tue, 03 May 2022 10:26:42 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c20-20020a05687093d400b000e686d13898sm7142824oal.50.2022.05.03.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:26:41 -0700 (PDT)
Date:   Tue, 3 May 2022 12:26:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: clock: Add Qcom SM8350 DISPCC
 bindings
Message-ID: <YnFlzOxrjrfBaaSs@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-7-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-7-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:

> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add sm8350 DISPCC bindings, which are simply a symlink to the sm8250
> bindings. Update the documentation with the new compatible.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This is missing your S-o-b as well.

Regards,
Bjorn

> ---
>  .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 6 ++++--
>  include/dt-bindings/clock/qcom,dispcc-sm8350.h              | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>  create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8350.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> index 31497677e8de..7a8d375e055e 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> @@ -4,18 +4,19 @@
>  $id: http://devicetree.org/schemas/clock/qcom,dispcc-sm8x50.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250
> +title: Qualcomm Display Clock & Reset Controller Binding for SM8150/SM8250/SM8350
>  
>  maintainers:
>    - Jonathan Marek <jonathan@marek.ca>
>  
>  description: |
>    Qualcomm display clock control module which supports the clocks, resets and
> -  power domains on SM8150 and SM8250.
> +  power domains on SM8150/SM8250/SM8350.
>  
>    See also:
>      dt-bindings/clock/qcom,dispcc-sm8150.h
>      dt-bindings/clock/qcom,dispcc-sm8250.h
> +    dt-bindings/clock/qcom,dispcc-sm8350.h
>  
>  properties:
>    compatible:
> @@ -23,6 +24,7 @@ properties:
>        - qcom,sc8180x-dispcc
>        - qcom,sm8150-dispcc
>        - qcom,sm8250-dispcc
> +      - qcom,sm8350-dispcc
>  
>    clocks:
>      items:
> diff --git a/include/dt-bindings/clock/qcom,dispcc-sm8350.h b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
> new file mode 120000
> index 000000000000..0312b4544acb
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,dispcc-sm8350.h
> @@ -0,0 +1 @@
> +qcom,dispcc-sm8250.h
> \ No newline at end of file
> -- 
> 2.34.1
> 
