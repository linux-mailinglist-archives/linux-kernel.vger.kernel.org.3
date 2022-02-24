Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E034C227C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiBXDlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiBXDlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:41:42 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF525457A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:41:14 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so1640839oot.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/RXdJI28RFFfrct1eEO2dTy0z09/hfX9S1ASQxzYlE=;
        b=U59eyb7C1/7TJGt/fALmeHrWycuoSh9IdVf81Lf84r0a9dSP1LT9IzBc9XpHaqaJvM
         9C6o5nfXnH60qNSq8x4bRnQN9lfmJucaEhs+qgstakq4XGFDtGYDvaCgRChJ7xSv7Y5J
         vBwfgATsq2g6wKR/ii+RQ6hwI3UXI5IjpU+JmwJ1dZJZ7ZY85bGr5dnpMFz2MGjdzAvA
         SVSRIFyPcALAqaCW/qBp+B94q79PDUkvZ0ApRt6G5Q8eOMpr668iytWcHpDo7VjJuTiB
         zg0aDFevfFt1EQCCkiM9ki5u4ojkENF1SDQSQLWsZaOluOjMQTGEFt/WX1GsMNYFQqW6
         fp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/RXdJI28RFFfrct1eEO2dTy0z09/hfX9S1ASQxzYlE=;
        b=oE1og9P+KImKA4aTbM2I60PR6PMFM2QqJyq8ASebue86jZ1/RP+dggT7s5NeLQSbWN
         A+WL5rBKlo7GRl/2Er3BhpssSmZc68r7bhrQHk8ONi4HAHuqjbvnb/DLpSx/45DrhqEN
         E+z67wLh138manlJrxNOyR8Wy2Epnyzm+jz5z5GlG6p9M+9TJPfl4bNb9xdgK45EDIu9
         0w31NeiZJIWm9rflORitS9LW0g3kHar4ek+QbNfHySP7hVZ9kFosVAvQg6I+NG7me4D3
         lgXHjP8YE+4M3XXiVMCI0nP223/q/XX9cExONkj6pkhqMXDcQ70sj3UAlRjxAy+uijuO
         ckOg==
X-Gm-Message-State: AOAM532kXyZ5LYSIjrTe7oT/O/mRVPynxqt40hWJN+TYQeecIrX6cLpw
        xXGZQm8guKv3tm7gGwWff8MbrQ==
X-Google-Smtp-Source: ABdhPJxKC57ZOtQmQu+EDBxTb6J5JEj+EL9JxS2Ju1nlaWdtq6zl//bjTlQXwau+ypkbGYEclJcFAg==
X-Received: by 2002:a05:6870:d3cc:b0:c4:7dc0:d72f with SMTP id l12-20020a056870d3cc00b000c47dc0d72fmr339660oag.258.1645674073556;
        Wed, 23 Feb 2022 19:41:13 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id d14sm604460ooh.44.2022.02.23.19.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:41:13 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:41:11 -0600
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
Subject: Re: [PATCH v4 02/16] dt-bindings: clock: simplify qcom,gcc-apq8064
 Documentation
Message-ID: <Yhb+V4ttu3jJwc55@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:

> Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc-common.yaml as a

Drop "-common" here.

Regards,
Bjorn

> template and remove the compatible from qcom,gcc.yaml
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
>  .../bindings/clock/qcom,gcc-other.yaml        |  3 --
>  2 files changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index 8e2eac6cbfb9..97936411b6b4 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
>  
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
>  maintainers:
>    - Stephen Boyd <sboyd@kernel.org>
>    - Taniya Das <tdas@codeaurora.org>
> @@ -17,22 +20,12 @@ description: |
>    See also:
>    - dt-bindings/clock/qcom,gcc-msm8960.h
>    - dt-bindings/reset/qcom,gcc-msm8960.h
> +  - dt-bindings/clock/qcom,gcc-apq8084.h
> +  - dt-bindings/reset/qcom,gcc-apq8084.h
>  
>  properties:
>    compatible:
> -    const: qcom,gcc-apq8064
> -
> -  '#clock-cells':
> -    const: 1
> -
> -  '#reset-cells':
> -    const: 1
> -
> -  '#power-domain-cells':
> -    const: 1
> -
> -  reg:
> -    maxItems: 1
> +    const: qcom,gcc-apq8084
>  
>    nvmem-cells:
>      minItems: 1
> @@ -53,21 +46,13 @@ properties:
>    '#thermal-sensor-cells':
>      const: 1
>  
> -  protected-clocks:
> -    description:
> -      Protected clock specifier list as per common clock binding.
> -
>  required:
>    - compatible
> -  - reg
> -  - '#clock-cells'
> -  - '#reset-cells'
> -  - '#power-domain-cells'
>    - nvmem-cells
>    - nvmem-cell-names
>    - '#thermal-sensor-cells'
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> index 824d80530683..2703b53150d8 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> @@ -15,8 +15,6 @@ description:
>    power domains.
>  
>    See also:
> -  - dt-bindings/clock/qcom,gcc-apq8084.h
> -  - dt-bindings/reset/qcom,gcc-apq8084.h
>    - dt-bindings/clock/qcom,gcc-ipq4019.h
>    - dt-bindings/clock/qcom,gcc-ipq6018.h
>    - dt-bindings/reset/qcom,gcc-ipq6018.h
> @@ -40,7 +38,6 @@ allOf:
>  properties:
>    compatible:
>      enum:
> -      - qcom,gcc-apq8084
>        - qcom,gcc-ipq4019
>        - qcom,gcc-ipq6018
>        - qcom,gcc-ipq8064
> -- 
> 2.34.1
> 
