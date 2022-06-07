Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE295402A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344252AbiFGPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiFGPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:40:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B19F748A;
        Tue,  7 Jun 2022 08:40:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w27so23495392edl.7;
        Tue, 07 Jun 2022 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=qfl+39j7R9xCzETisivNB5VMNUjHYeFqx6KugSE8DOs=;
        b=kc7RxpwnZjKOLy9IZK0kwjmON/0TUqFMCQwlz9VUZzYt3jUk8QuWBKUtQ7cNqFoXr8
         GvjZ6Ba+d/lPH9SAkvcyGbsEJC4iUKpei9tmVJO1DNXcP/tafbFrpY8/iiNPDEwyoSu8
         prpSLlPiTrvu/D5kmB31sLqF8uiP05H/UihF6vRcGqsyGGXryjaMMFOzrAYI34NHxjEX
         gKSE5OXaPc6fDCrb6eLWFpwJcAIu9H+HpnPGN7Tf0rVJ8dpwka+wsRqZiLlBAEeSRt67
         bhdmbjvMmrAZ09l1etJ4AravCXYUxwO46n5u+CfESH7vdF9MQk6yXsJtRm26DOEie/F5
         eeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=qfl+39j7R9xCzETisivNB5VMNUjHYeFqx6KugSE8DOs=;
        b=QkkbhoGnXXv72u9vNjRe2CU6FJPDszNjELNSGAC5zD3Ukq1H30/adCjCOVmHLb7j1F
         IvJjD0TfA+7b5fVNMiN1+Oy4+o4PaHvglvx4wCEM5q+nwFn/LF1YLJNx3KBqYQuamnR0
         tg/G/+Xj4DA+UHInPZgD3VSzbtYJM45Lwbta1NSpiFMa5yFUlfKNW4Gt/AMwDF1hd5mG
         mH4GZBw4jbVzv1XeCuuIJYLdadvIKHU0ahf0cnnOIXrBXitwYGPxQzCozQO7BQrs158G
         j71Wyz93hdGtj+B1nxX4AnqncLGS/zJDBTlNZFyzRLoVkm0LYPoSXNPeTxgpN3zp9T8R
         ZGuQ==
X-Gm-Message-State: AOAM5322tsXDt4iiKw7SwX1aHWK7Vnyx97t717E+IF+DalFXrjWKksLk
        zWGH2q5uW0qg5Z2AR92vwkRxch0YGQg=
X-Google-Smtp-Source: ABdhPJyYWc6ZRgkMjIKqAY+JFaE6DX/4W10Tdpre7XOec6MZZmgCyRojIINNJjyMyIsgQJ8EXHB5Yw==
X-Received: by 2002:aa7:d058:0:b0:42d:f33f:ad21 with SMTP id n24-20020aa7d058000000b0042df33fad21mr34135187edo.388.1654616440970;
        Tue, 07 Jun 2022 08:40:40 -0700 (PDT)
Received: from localhost (92.40.203.51.threembb.co.uk. [92.40.203.51])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090691c500b006feaa22e367sm7812132ejx.165.2022.06.07.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:40:40 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-6-aidanmacdonald.0x0@gmail.com>
 <20220605225504.GA3678983-robh@kernel.org>
 <7w5P7NKqcSgfwmILB1hRmmdtkmw7UXrH@localhost>
 <20220607151703.GB3254370-robh@kernel.org>
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
Date:   Tue, 07 Jun 2022 16:40:55 +0100
In-reply-to: <20220607151703.GB3254370-robh@kernel.org>
Message-ID: <8lfT6C6izbY9ig2LRhvIxKJtQT7kLKKD@localhost>
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

> On Tue, Jun 07, 2022 at 11:34:19AM +0100, Aidan MacDonald wrote:
>> 
>> Rob Herring <robh@kernel.org> writes:
>> 
>> > On Fri, Jun 03, 2022 at 02:57:09PM +0100, Aidan MacDonald wrote:
>> >> The AXP192 PMIC is different enough from the PMICs supported by
>> >> the AXP20x GPIO driver to warrant a separate driver. The AXP192
>> >> driver also supports interrupts and pinconf settings.
>> >> 
>> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> >> ---
>> >>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 59 +++++++++++++++++++
>> >>  1 file changed, 59 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> >> 
>> >> diff --git
>> >> a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> >> b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> >> new file mode 100644
>> >> index 000000000000..7a985640ade8
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> >> @@ -0,0 +1,59 @@
>> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: "http://devicetree.org/schemas/gpio/x-powers,axp192-gpio.yaml#"
>> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> >> +
>> >> +title: X-Powers AXP192 GPIO Device Tree Bindings
>> >> +
>> >> +maintainers:
>> >> +  - Chen-Yu Tsai <wens@csie.org>
>> >> +
>> >> +properties:
>> >> +  "#gpio-cells":
>> >> +    const: 2
>> >> +    description: >
>> >> +      The first cell is the pin number and the second is the GPIO flags.
>> >> +
>> >> +  compatible:
>> >> +    oneOf:
>> >> +      - enum:
>> >
>> > No need for 'oneOf' with only 1 entry.
>> >
>> 
>> Got it.
>> 
>> >> +          - x-powers,axp192-gpio
>> >> +
>> >> +  gpio-controller: true
>> >> +
>> >> +patternProperties:
>> >> +  "^.*-pins?$":
>> >
>> > You can omit '^.*'
>> >
>> > Why does 's' need to be optional?
>> >
>> 
>> TBH I just copied this from x-powers,axp209-gpio.yaml. A similar pattern
>> is used in a few other bindings, eg. allwinner,sun4i-a10-pinctrl.yaml.
>> I guess it's to allow the node names to sound more natural when there's
>> only one pin.
>
> Those cases were for compatibility with existing users. That shouldn't 
> be the case here.
>
> Rob

OK, thanks for the clarification. I will use '-pins$' then.
