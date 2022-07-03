Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41156472A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiGCLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiGCLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:30:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336D9A196;
        Sun,  3 Jul 2022 04:30:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3886039wme.0;
        Sun, 03 Jul 2022 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=HhNrqokBiomVIzoEr5AmnzWfBeMWKGdIZTVz3IEoXng=;
        b=UnW9iuGJiH4+wcmSQv/2EpJeoffrvnC9tP6Q9oTC3RWU61Tiw9Ip3dHeZoCwpCtVVx
         rNAZkcpyWPrufejdIpzHZ9atpRvvB17H2DEnBAanyKAPpUG9pFtDPNN0IgRC9NdDB7tL
         f8UNdt3cOhpxm3DW8j85KIvkwaj9SiN3zNOQVmSC8zdqtwFIRnKdo3n+u5md0ogAuLqR
         MjXWcJZz1OFGV+DOpN8iRUwukFWnrNocijj1HrBdl4iLZPmwBs364TQXweKlkecG0yJs
         vhZ7pyUv3cxVh1HD31Uo4UWIGQL7vOpzC2a07bn53z6ho+KxIt6UAIR1KeHTbugJ2pmt
         n/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HhNrqokBiomVIzoEr5AmnzWfBeMWKGdIZTVz3IEoXng=;
        b=dB+qdJomACe405FzBjLPZjyTI2MFx/ToJSD0XiHPUr4sVI+NTbw0XDWb/elT1tWHuo
         wquxJxVIHv2YqUY3qqAF1BydVIrR+w+JUgKZCnBBH9N17A762CFzAeUuBp0y1YKA8HtR
         Qzu0jqY2/1CAs2GSMBco7W8KJUzCjUurzqboeGy6uhHjUkwQW9OrCEZGicicZBfNYs7S
         cOloN08347/YMmnT92Dt2okBM43nSLSKCwEEzHRfpWEaE+ahN0RS0eQIEovPhI+yo7um
         Br33Jmotq/x16xoujqmqllD/wbHu13pXTQl2Rn8dYo0a0+ynTAWVss+a96YcvVsWvcTv
         SmmQ==
X-Gm-Message-State: AJIora9oSp1ICJhjAGL072nk0nc1qpRzQhZThYM2xZ4Qr1drnUF90bHc
        4mokW5hIES82pJw585ZMvJU=
X-Google-Smtp-Source: AGRyM1vGTp4tUllczcZIJO8vch792PAdlkdP7YNmgvkwJ2Ld2MAAdv9HiJkPKGRvpdViE3A4I2/8wA==
X-Received: by 2002:a1c:ed08:0:b0:39c:80b1:b0b3 with SMTP id l8-20020a1ced08000000b0039c80b1b0b3mr26399757wmh.134.1656847807831;
        Sun, 03 Jul 2022 04:30:07 -0700 (PDT)
Received: from localhost (92.40.202.1.threembb.co.uk. [92.40.202.1])
        by smtp.gmail.com with ESMTPSA id bg39-20020a05600c3ca700b003a18de85a64sm8278839wmb.24.2022.07.03.04.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:30:07 -0700 (PDT)
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-5-aidanmacdonald.0x0@gmail.com>
 <d024858b-a461-2cbc-48fa-a13cf3be0cb4@sholland.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     wens@csie.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, sre@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, lars@metafoo.de,
        quic_gurus@quicinc.com, sebastian.reichel@collabora.com,
        andy.shevchenko@gmail.com, michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 04/15] dt-bindings: gpio: Add AXP192 GPIO bindings
In-reply-to: <d024858b-a461-2cbc-48fa-a13cf3be0cb4@sholland.org>
Date:   Sun, 03 Jul 2022 12:31:16 +0100
Message-ID: <44jAwCl9UWFrACJoTf15VMnUXSmNBQO9@localhost>
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


Samuel Holland <samuel@sholland.org> writes:

> On 6/29/22 9:30 AM, Aidan MacDonald wrote:
>> The AXP192 PMIC is different enough from the PMICs supported by
>> the AXP20x GPIO driver to warrant a separate driver. The AXP192
>> driver also supports interrupts and pinconf settings.
>> 
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 68 +++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> new file mode 100644
>> index 000000000000..ceb94aa2bc97
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
>> [...]
>> +
>> +required:
>> +  - compatible
>> +  - "#gpio-cells"
>> +  - gpio-controller
>> +  - gpio-ranges
>
> By requiring the gpio-ranges property, you will not be able to convert the
> existing driver, as existing devicetrees do not have it.
>
> If you instead call pinctrl_add_gpio_range() from the driver, you can maintain
> compatibility with the existing binding.
>
> Regards,
> Samuel

Originally I did use pinctrl_add_gpio_range(), but calling that from
a pin control driver is apparently deprecated. It can be done from
->of_gpio_ranges_fallback to deal with old device trees, though.
