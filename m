Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ECD4C2276
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiBXDjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiBXDjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:39:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0C247757
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:38:52 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id l25so1160903oic.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BxZQsI9Ur9IiwZjtiMx8X36wZnIDnwb/WkHly+HDiJ0=;
        b=Rbt5kRB9jY34xgGOun2ec/5vxnlaxjSDv/VEnPbfJXnK23qcSZHzdzPKJ6bj7KYNjq
         agHsYvSPUYBTX4uU3LIsBm9GsUpdviPDbKjuxIylmDkG7c0aE+qwsL5GxJtJpL1Ipmnt
         ViRt5M5yr9aW02T81YhiJ4yZvevufWJ9TT2XPa0IMROh0GaqO0V3lyp1GmkQSSzgsw+t
         /nvW3mq1RiF3UdzoKzE8G9VIawHhYJQVBYHpaPUbk3k3YzvYuVvUzOqhrFwUqx48nHyz
         +BRlzQFPqVJvUMfC0pEgXPS9GCZN2JHXAFBQC01S8pFlxtFICxvUZP/68f1CzYNW7jcx
         ByCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BxZQsI9Ur9IiwZjtiMx8X36wZnIDnwb/WkHly+HDiJ0=;
        b=ymYifPJ2W++hzn1kjbnMIDUuLc6jCr2A2hP99ARItXU/jGHNO5SijnIdTF5uS4NlJ3
         EVI0+HUPi8DN1Zyi0DucyevYnDoNliwQd+zT8WS6VAFqjzQ8he4/3779kd+Y7ACpSy63
         tw541L70n6k13AiQWDwfQBp/fljcijh0WLUYxyhq4AQe4PH6rmqOVGawGVh0tVXCiWpS
         pDoA1Jy5Zbl/i4xKgLDlqrz1TsCVDGEI8CQ/vhX2I2PmKyRPxlAtnYVxkeHwzKNMC4iL
         IXYhTnMuZ9LB1HNmQAgbwzvFikkbStgZ/c3LH14ztgQ3CeDnWEcUxYpQrdGsMhRa0Jks
         8wlw==
X-Gm-Message-State: AOAM530U68jdP5twT/qkApgJmPkeWOMm2sSmW5QPUM2Quyr0FC1WRH7w
        HUL8oEXwdYrHCwibl2HiLfJb1w==
X-Google-Smtp-Source: ABdhPJx/a05kDy7ptP7NFqPsOLT7fdqL4YQxuTTF/e/43UwH3umPwSZ4jPFdksemYz4YuVIi15TVKA==
X-Received: by 2002:aca:aa07:0:b0:2d4:4386:a195 with SMTP id t7-20020acaaa07000000b002d44386a195mr6126653oie.107.1645673931738;
        Wed, 23 Feb 2022 19:38:51 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id q16sm779705oiv.16.2022.02.23.19.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:38:51 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:38:49 -0600
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
Subject: Re: [PATCH v4 01/16] dt-bindings: clock: split qcom,gcc.yaml to
 common and specific schema
Message-ID: <Yhb9yeQqTy6UVeiC@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-2-ansuelsmth@gmail.com>
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

> Split qcom,gcc.yaml to common and specific schema to use it as a
> template for schema that needs to use the gcc bindings and require
> to add additional bindings.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
>  .../devicetree/bindings/clock/qcom,gcc.yaml   | 63 ++-------------
>  2 files changed, 82 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> new file mode 100644
> index 000000000000..824d80530683
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

This work for me.

> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#

But shouldn't this be qcom,gcc-other.yaml then?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +  - Taniya Das <tdas@codeaurora.org>
> +
> +description:
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains.
> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-apq8084.h
> +  - dt-bindings/reset/qcom,gcc-apq8084.h
> +  - dt-bindings/clock/qcom,gcc-ipq4019.h
> +  - dt-bindings/clock/qcom,gcc-ipq6018.h
> +  - dt-bindings/reset/qcom,gcc-ipq6018.h
> +  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> +  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> +  - dt-bindings/clock/qcom,gcc-msm8939.h
> +  - dt-bindings/clock/qcom,gcc-msm8953.h
> +  - dt-bindings/reset/qcom,gcc-msm8939.h
> +  - dt-bindings/clock/qcom,gcc-msm8660.h
> +  - dt-bindings/reset/qcom,gcc-msm8660.h
> +  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> +  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> +  - dt-bindings/clock/qcom,gcc-mdm9607.h
> +  - dt-bindings/clock/qcom,gcc-mdm9615.h
> +  - dt-bindings/reset/qcom,gcc-mdm9615.h
> +  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
> +
> +allOf:
> +  - $ref: "qcom,gcc.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,gcc-apq8084
> +      - qcom,gcc-ipq4019
> +      - qcom,gcc-ipq6018
> +      - qcom,gcc-ipq8064
> +      - qcom,gcc-mdm9607
> +      - qcom,gcc-msm8226
> +      - qcom,gcc-msm8660
> +      - qcom,gcc-msm8916
> +      - qcom,gcc-msm8939
> +      - qcom,gcc-msm8953
> +      - qcom,gcc-msm8960
> +      - qcom,gcc-msm8974
> +      - qcom,gcc-msm8974pro
> +      - qcom,gcc-msm8974pro-ac
> +      - qcom,gcc-mdm9615
> +      - qcom,gcc-sdm630
> +      - qcom,gcc-sdm660
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  # Example for GCC for MSM8960:
> +  - |
> +    clock-controller@900000 {
> +      compatible = "qcom,gcc-msm8960";
> +      reg = <0x900000 0x4000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> index f66d703bd913..ea1dd94d8bf1 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> @@ -1,60 +1,20 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

We would need to double check with existing copyright holders. My
suggestion is that we change that separately.

>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-common.yaml#

You forgot to change this back to just gcc.yaml.

With those two things this looks good to me.

Regards,
Bjron

>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm Global Clock & Reset Controller Binding
> +title: Qualcomm Global Clock & Reset Controller Binding Common Bindings
>  
>  maintainers:
>    - Stephen Boyd <sboyd@kernel.org>
>    - Taniya Das <tdas@codeaurora.org>
>  
>  description: |
> -  Qualcomm global clock control module which supports the clocks, resets and
> -  power domains.
> -
> -  See also:
> -  - dt-bindings/clock/qcom,gcc-apq8084.h
> -  - dt-bindings/reset/qcom,gcc-apq8084.h
> -  - dt-bindings/clock/qcom,gcc-ipq4019.h
> -  - dt-bindings/clock/qcom,gcc-ipq6018.h
> -  - dt-bindings/reset/qcom,gcc-ipq6018.h
> -  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> -  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> -  - dt-bindings/clock/qcom,gcc-msm8939.h
> -  - dt-bindings/clock/qcom,gcc-msm8953.h
> -  - dt-bindings/reset/qcom,gcc-msm8939.h
> -  - dt-bindings/clock/qcom,gcc-msm8660.h
> -  - dt-bindings/reset/qcom,gcc-msm8660.h
> -  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> -  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
> -  - dt-bindings/clock/qcom,gcc-mdm9607.h
> -  - dt-bindings/clock/qcom,gcc-mdm9615.h
> -  - dt-bindings/reset/qcom,gcc-mdm9615.h
> -  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
> +  Common bindings for Qualcomm global clock control module which supports
> +  the clocks, resets and power domains.
>  
>  properties:
> -  compatible:
> -    enum:
> -      - qcom,gcc-apq8084
> -      - qcom,gcc-ipq4019
> -      - qcom,gcc-ipq6018
> -      - qcom,gcc-ipq8064
> -      - qcom,gcc-mdm9607
> -      - qcom,gcc-msm8226
> -      - qcom,gcc-msm8660
> -      - qcom,gcc-msm8916
> -      - qcom,gcc-msm8939
> -      - qcom,gcc-msm8953
> -      - qcom,gcc-msm8960
> -      - qcom,gcc-msm8974
> -      - qcom,gcc-msm8974pro
> -      - qcom,gcc-msm8974pro-ac
> -      - qcom,gcc-mdm9615
> -      - qcom,gcc-sdm630
> -      - qcom,gcc-sdm660
> -
>    '#clock-cells':
>      const: 1
>  
> @@ -72,22 +32,11 @@ properties:
>        Protected clock specifier list as per common clock binding.
>  
>  required:
> -  - compatible
>    - reg
>    - '#clock-cells'
>    - '#reset-cells'
>    - '#power-domain-cells'
>  
> -additionalProperties: false
> +additionalProperties: true
>  
> -examples:
> -  # Example for GCC for MSM8960:
> -  - |
> -    clock-controller@900000 {
> -      compatible = "qcom,gcc-msm8960";
> -      reg = <0x900000 0x4000>;
> -      #clock-cells = <1>;
> -      #reset-cells = <1>;
> -      #power-domain-cells = <1>;
> -    };
>  ...
> -- 
> 2.34.1
> 
