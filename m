Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDA595955
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiHPLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiHPLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:03:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444FB9F0EA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:13:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v10so10025432ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=I5SqP35XC1263ityEmHuahEtnvYD9OPIC1kK87SGfRw=;
        b=GG76BEFFH8QopWBCiOBntKXwcAX7YWOUOgmNyASJ6GEoYLq58DYf15P+iP97FxOg4B
         KjDaJEUrkA70ApHUjT+FWRX9DVIm1N4FveTnXJsj1bwwKg9k/nWwYY4N2FBwYTs1pST7
         3snLlHdooPCoOILcUKxpsXT0nUuhOwVLBgLcwzaAMLwsqBwfwsUxFWrvl63bMa8wO6+b
         P/tlXSY/kMnb3qOxP/UoznLJeEBju5oWeVLMNlmxpnkaOeJKxiiiBYqeVsYoKc84HnBY
         7/U4xiutBBix58jCLqHm+QqRUeNvFfvsoqfQdQXr78xeD6wjWdbxc+OJkB4BuTKOZVqm
         fxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=I5SqP35XC1263ityEmHuahEtnvYD9OPIC1kK87SGfRw=;
        b=wkzMcan/UAT8E9qNaryr/5VhkP+9qDyz6a8Dejm5YArpD05hIWlhOu78iFzP2XMNXJ
         14H+EjB6e/+zwfaP3T+UycCxDlqfbcUL+7DtQNGcUPT8RQvdlAHdqq1uIeL6/CIcp/EB
         p3OTHiI4m3aWuhQbi9j5Erh84rwU9g+bshCxURlx7e8l2CrWnVKtQ0llXsD0103fGI7Z
         ZCPn5M2OKQD5LZiaMV1ElhOW3k/eG8lokOODdn4i30QW93/qle/ITh0IZJ5OzyLxvGke
         sdMbL3tVdFMJeUCSMlaDnGGXsm8pJB/jFO7NvIxzKeY4Cu2c1QvWoOlxjom7sZUSdPu2
         ZJ9w==
X-Gm-Message-State: ACgBeo3A8hvAi2hkf5SfLqHrmPMRlnQDSbzykcmqwCSpd1IpZ4ie5hU+
        EMdwL44qMPz+hB7XzZcwmSnhxQ==
X-Google-Smtp-Source: AA6agR5wmREWNPb3k9paLeHs0ydehrKgaXqxM99gOCR/RBa1rBjr/Xk5erS1nX4K3zaQu/5OsWNJBw==
X-Received: by 2002:a05:651c:244:b0:253:ecad:a4ee with SMTP id x4-20020a05651c024400b00253ecada4eemr5833229ljn.21.1660644802065;
        Tue, 16 Aug 2022 03:13:22 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id d21-20020ac244d5000000b0048afccdd6e8sm1339250lfm.105.2022.08.16.03.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:13:21 -0700 (PDT)
Message-ID: <488ccf2a-5058-d3c6-43ad-8ec2b541fb86@linaro.org>
Date:   Tue, 16 Aug 2022 13:13:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     alina_yu@richtek.com, cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1660548852-6222-1-git-send-email-u0084500@gmail.com>
 <1660548852-6222-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1660548852-6222-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 10:34, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for the Richtek RT9471 I2C controlled battery charger.
> 
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2
> - Remove the properties for interrupt controller things in the binding documentation.
> - Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
> - Add regulator min/max microamp to allow otg vbus current adjustable in example.
> - Specify the active-level for charge-enable-gpios in binding example.
> 
> ---
>  .../bindings/power/supply/richtek,rt9471.yaml      | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
> new file mode 100644
> index 00000000..9286b82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/richtek,rt9471.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT9471 3A Single Cell Switching Battery charger
> +
> +maintainers:
> +  - Alina Yu <alina_yu@richtek.com>
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  RT9471 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
> +  portable applications. It supports USB BC1.2 port detection, current and
> +  voltage regulations in both charging and boost mode.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT9471=RT9471D/DS9471D-02.pdf
> +
> +properties:
> +  compatible:
> +    const: richtek,rt9471
> +
> +  reg:
> +    maxItems: 1
> +
> +  charge-enable-gpios:
> +    description: GPIO used to turn on and off charging.
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  usb-otg-vbus-regulator:
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/regulator/regulator.yaml#

ref goes before unevaluatedProperties (so one line up)

with above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
