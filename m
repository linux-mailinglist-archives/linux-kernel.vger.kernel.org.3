Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096574C2281
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiBXDm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBXDmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:42:54 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F9D18DABD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:42:25 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id i5so1242163oih.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYEd8EVkw1Of7ux/hDsjw4yyVRiR+H8vii8P99UTPSo=;
        b=qYYHNGdj0OGW+DoiNMj5TSPsqzS0nhW9AFWqfZ5LAC+fWH14e4A7bR8z/eo5CZRSNz
         531GhWFYtmBU8Tksk+mRweKMC4DYDdOMGqkOBzITefA5fNo4CaXX3h8XwLkhGD9nKhox
         uaMtfzzoM7u5JO7wdSn6VxIGZVligBjKwUqdyUKDPOaDGoI7xRPIx+xt4Bj/t70cop4Y
         kXoXrCkDG14YThrMovsfy6lOktQDpiKmStorFtnT9677iVsEspBFJaRhlJwekfMjqqGh
         /a6aWId+qlr+Vs/rWKGvpeO0Kc409Lg7WU3e1UmKK4+N5CQ9dUyJkIiifddj7/ZhFosi
         63Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYEd8EVkw1Of7ux/hDsjw4yyVRiR+H8vii8P99UTPSo=;
        b=GkStYud5pilgEoWlvSlhBMp+42NTafYAhjNHTkyjZuSMiQh3vmwVTyrdvYzqFzCLbI
         MgHEgEVSBG8IEcslqmvEZBTFFxB7+hSCDK9ZEkjW3OFoB56fJ3BqlCWt2hBooysos8vh
         B3F4i/M5vLJ72T9lgyg7RKC30s1be+Uqdnwayqhsz9jSB02HtOyxSQZGeptE2cTEov+Q
         TTCYH8ZyuIECq7ua5Lilm7FqnJBr8b7FmUCJgd/DukrNS74r95lb+ULAYxGCa3GQVGws
         YxrYhBaw1+U4t4BUF3ZzFtIhiWbSGcaa2LPzC3MELB6MBM7YmVLkc/Zmk5Jph5YT1RDQ
         2SkQ==
X-Gm-Message-State: AOAM533QT1335azG6mA0oz6QeVz/TMusbyTNTIH+I0d9VseT08z2X7gt
        QhSQ3uNFmi167equmjJdH7MASg==
X-Google-Smtp-Source: ABdhPJx0Jgm2U6EctFF6MAgBPWG5I6BPExSTNKqhp/DFGzq7u89s8Eak3+Tlinuq5rW9Rolb6LoGIg==
X-Received: by 2002:a05:6808:168d:b0:2d4:6444:1ddd with SMTP id bb13-20020a056808168d00b002d464441dddmr364883oib.62.1645674144305;
        Wed, 23 Feb 2022 19:42:24 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id m5sm589952oov.16.2022.02.23.19.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 19:42:23 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:42:22 -0600
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
Subject: Re: [PATCH v4 03/16] dt-bindings: clock: Document qcom,gcc-ipq8064
 binding
Message-ID: <Yhb+nuE0L0Rppmms@builder.lan>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217235703.26641-4-ansuelsmth@gmail.com>
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

> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already documented,
> to get the calib nvmem cells and the base reg from gcc. Use
> qcom,gcc-common.yaml as a template and remove the compatible from

Again, drop "-common".

Apart form that, this looks really good.

Regards,
Bjorn

> generic qcom,gcc.yaml
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 76 +++++++++++++++++++
>  .../bindings/clock/qcom,gcc-other.yaml        |  3 -
>  2 files changed, 76 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> new file mode 100644
> index 000000000000..9eb91dd22557
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on IPQ8064.
> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> +  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,gcc-ipq8064
> +      - const: syscon
> +
> +  clocks:
> +    items:
> +      - description: PXO source
> +      - description: CXO source
> +
> +  clock-names:
> +    items:
> +      - const: pxo
> +      - const: cxo
> +
> +  thermal-sensor:
> +    type: object
> +
> +    allOf:
> +      - $ref: /schemas/thermal/qcom-tsens.yaml#
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gcc: clock-controller@900000 {
> +      compatible = "qcom,gcc-ipq8064", "syscon";
> +      reg = <0x00900000 0x4000>;
> +      clocks = <&pxo_board>, <&cxo_board>;
> +      clock-names = "pxo", "cxo";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +
> +      tsens: thermal-sensor {
> +        compatible = "qcom,ipq8064-tsens";
> +
> +        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
> +        nvmem-cell-names = "calib", "calib_backup";
> +        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "uplow";
> +
> +        #qcom,sensors = <11>;
> +        #thermal-sensor-cells = <1>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> index 2703b53150d8..ebafdef71766 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> @@ -18,8 +18,6 @@ description:
>    - dt-bindings/clock/qcom,gcc-ipq4019.h
>    - dt-bindings/clock/qcom,gcc-ipq6018.h
>    - dt-bindings/reset/qcom,gcc-ipq6018.h
> -  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
> -  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
>    - dt-bindings/clock/qcom,gcc-msm8939.h
>    - dt-bindings/clock/qcom,gcc-msm8953.h
>    - dt-bindings/reset/qcom,gcc-msm8939.h
> @@ -40,7 +38,6 @@ properties:
>      enum:
>        - qcom,gcc-ipq4019
>        - qcom,gcc-ipq6018
> -      - qcom,gcc-ipq8064
>        - qcom,gcc-mdm9607
>        - qcom,gcc-msm8226
>        - qcom,gcc-msm8660
> -- 
> 2.34.1
> 
