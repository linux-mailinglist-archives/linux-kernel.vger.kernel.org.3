Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89853FBC9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiFGKqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbiFGKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0B61E3E7;
        Tue,  7 Jun 2022 03:45:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v1so23651420ejg.13;
        Tue, 07 Jun 2022 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=5iMSi5NreryGR8izdeYc2rW3YzGt+AHDIAmvUOT38HA=;
        b=mUGaFDf9Gq0PSdRL0ePEpqPTGkc1KrPolQlTAYyeymOzOnlEIgzV3lIifZX+vORBp4
         aPyi3xOaoTHuTDpvRYxKep8i1RKNnJYRIgY5tBNcScV9B7KDzNgI90XHeDYh39IVbeOm
         16vSzWm/lkp6CP+owW9BVb6RLwQzLyt8C3F2yEumydUgagXiWzN9PVOyHBdcnrfVOn1O
         bP7ZQOiYH9lJ5HYmQwV0OEfZ3ofCnzj5ei0Bbgw0TNWlmb6yeFsGHiqK/jvz+JeQ/++R
         oOKpuNnTlQmbT0RrXb3m6K0MJDn0oDuHvSeYPrPle0WJmKDTGM3bmwvA6DW28RkBRquX
         lbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=5iMSi5NreryGR8izdeYc2rW3YzGt+AHDIAmvUOT38HA=;
        b=MUO3LlOndnL+/OWB0NnHXS1pW2x9/C30lrB7SXlOen6nTsA3pSuNBXP2xT14se8ZD2
         loFv00cBfZEqcCOI0E1E8gNPjZzBqlePs+v28e09v6GQedB16RgkKtEh0l8mHWfIcwj6
         S9Od37U+9rPfXRKiIlAUxfUBCQ2r+qMgl3TgCgSvNtqOc9sUqNPoVnwY7bp8XNOoVk3j
         YqwoiQHtIggpGJnLfdjRb0BBTu84+qov3MB4jLCxj7yo6aqE6AqpgmROI2CVRiy3wv0o
         2gjHKQybw0VQ1NMIgm/2aPq/jgV6cJUn2HtLxgVbJ1MHFPYEb2X1D6zyw/AExsiDTLHr
         CnGg==
X-Gm-Message-State: AOAM5303tLabLlVHJ4R0GEmgB/tIZFHJMgZ2gpQ6pY4Jt8S2mOuTNr/F
        eVAvbdROVHIw+E9uPDI3FeQ=
X-Google-Smtp-Source: ABdhPJyC3axRmTgpQLe92bAYa+ea9uBIxBbgw9QtK8HQMRAK5klP6mYvkHGZslsJ56KeVDZNNFEhww==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr25471613ejc.5.1654598726651;
        Tue, 07 Jun 2022 03:45:26 -0700 (PDT)
Received: from localhost (92.40.203.111.threembb.co.uk. [92.40.203.111])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906784400b00702d8b43df3sm7369536ejm.167.2022.06.07.03.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:45:25 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-6-aidanmacdonald.0x0@gmail.com>
 <20220605225504.GA3678983-robh@kernel.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: gpio: Add AXP192 GPIO bindings
Date:   Tue, 07 Jun 2022 11:34:19 +0100
In-reply-to: <20220605225504.GA3678983-robh@kernel.org>
Message-ID: <7w5P7NKqcSgfwmILB1hRmmdtkmw7UXrH@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Herring <robh@kernel.org> writes:

> On Fri, Jun 03, 2022 at 02:57:09PM +0100, Aidan MacDonald wrote:
>> The AXP192 PMIC is different enough from the PMICs supported by
>> the AXP20x GPIO driver to warrant a separate driver. The AXP192
>> driver also supports interrupts and pinconf settings.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 59 +++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> new file mode 100644
>> index 000000000000..7a985640ade8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/gpio/x-powers,axp192-gpio.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: X-Powers AXP192 GPIO Device Tree Bindings
>> +
>> +maintainers:
>> +  - Chen-Yu Tsai <wens@csie.org>
>> +
>> +properties:
>> +  "#gpio-cells":
>> +    const: 2
>> +    description: >
>> +      The first cell is the pin number and the second is the GPIO flags.
>> +
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>
> No need for 'oneOf' with only 1 entry.
>

Got it.

>> +          - x-powers,axp192-gpio
>> +
>> +  gpio-controller: true
>> +
>> +patternProperties:
>> +  "^.*-pins?$":
>
> You can omit '^.*'
>
> Why does 's' need to be optional?
>

TBH I just copied this from x-powers,axp209-gpio.yaml. A similar pattern
is used in a few other bindings, eg. allwinner,sun4i-a10-pinctrl.yaml.
I guess it's to allow the node names to sound more natural when there's
only one pin.

I am going to send a v2 with '-pins?$' but if you would prefer to have
'-pins$' that's fine. I don't mind either way.

Regards,
Aidan

>> +    $ref: /schemas/pinctrl/pinmux-node.yaml#
>> +
>> +    properties:
>> +      pins:
>> +        items:
>> +          enum:
>> +            - GPIO0
>> +            - GPIO1
>> +            - GPIO2
>> +            - GPIO3
>> +            - GPIO4
>> +            - N_RSTO
>> +
>> +      function:
>> +        enum:
>> +          - output
>> +          - input
>> +          - ldo
>> +          - pwm
>> +          - adc
>> +          - low_output
>> +          - floating
>> +          - ext_chg_ctl
>> +          - ldo_status
>> +
>> +required:
>> +  - compatible
>> +  - "#gpio-cells"
>> +  - gpio-controller
>> +
>> +additionalProperties: false
>> +
>> +...
>> -- 
>> 2.35.1
>> 
>> 

