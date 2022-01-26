Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62B349CA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiAZNOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:14:11 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:43771 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiAZNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:14:07 -0500
Received: by mail-ej1-f47.google.com with SMTP id d10so38964127eje.10;
        Wed, 26 Jan 2022 05:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NBdQ/uQ+VlQz/s6B9TiQ8bFThsL41hKw9IyHdeDpgD4=;
        b=2hYzm/xSvzF4cZOyfidmevTlaJwCMzYAmhPHeJKxRWOZY9OoYkIUoQMcQDyGExYsi7
         6qhMk0EYqeAB663Ig3hCiBN/4APqBzq9hi2LPVPS49dPWeg7oCNfyx7XD/M9sptBeMjW
         iwMMBVTJZihy1kRaOiIwXEMwqYLiY0uZs8u4peIXhbAG9E/6Z5TQLyTqh/cPaddJK5Wu
         z9a/xz2k0tBkm8th1VZLn6dKcJL7oILRAJVOYZWdJJt4rTZy58o7waQcFlb9nrW3eRoF
         z+zlvqEZldUpk3UyNDO1QcgBEAvLN83YjdSN6luhKDoTHvJ8aYTyzdI7hBf+CVHxN3QY
         XzdA==
X-Gm-Message-State: AOAM531Kn7qvumPZ8NQS37G4IJJjASaMyj5/BsafxJhXvNK4dn8Loglc
        jwSj36/wzTukh+OquqGZeKw=
X-Google-Smtp-Source: ABdhPJypN0UAeeiGOnmKd5k24fcLAzTBl8OwGasQRAAEB8fDWDUT4TXWF6NG0KGGepXClKmL7B4w/A==
X-Received: by 2002:a17:906:e0ca:: with SMTP id gl10mr20482575ejb.108.1643202846140;
        Wed, 26 Jan 2022 05:14:06 -0800 (PST)
Received: from [192.168.0.60] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id l2sm9700990eds.28.2022.01.26.05.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:14:04 -0800 (PST)
Message-ID: <48350476-605c-0775-7d18-2601d3360241@kernel.org>
Date:   Wed, 26 Jan 2022 14:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: Document clk based PWM
 controller
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        sean.anderson@seco.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220126125849.75572-1-nikita@trvn.ru>
 <20220126125849.75572-2-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220126125849.75572-2-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 13:58, Nikita Travkin wrote:
> Add YAML devicetree binding for clk based PWM controller
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> Changes in v2:
>  - fix the file name.
> Changes in v4:
>  - Use generic node name in the dt bindings example.
> ---
>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> new file mode 100644
> index 000000000000..d3416ba549b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock based PWM controller
> +
> +maintainers:
> +  - Nikita Travkin <nikita@trvn.ru>
> +
> +description: |
> +  Some systems have clocks that can be exposed to external devices.
> +  (e.g. by muxing them to GPIO pins)
> +  It's often possible to control duty-cycle of such clocks which makes them
> +  suitable for generating PWM signal.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: clk-pwm
> +
> +  clocks:
> +    description: Clock used to generate the signal.
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +unevaluatedProperties: false
> +
> +required:

You need a compatible. pwm-cells can be skipped as pwm.yaml will require
them.

> +  - clocks
> +
> +examples:
> +  - |
> +    pwm {
> +      compatible = "clk-pwm";
> +      #pwm-cells = <2>;
> +      clocks = <&gcc 0>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pwm_clk_flash_default>;
> +    };


Best regards,
Krzysztof
