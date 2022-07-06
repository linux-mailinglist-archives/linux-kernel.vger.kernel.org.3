Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636FE569387
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiGFUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGFUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:45:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C93228722;
        Wed,  6 Jul 2022 13:45:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id k30so12602914edk.8;
        Wed, 06 Jul 2022 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=p5Y3W/tQDWHyEnQCsxi+bfhl3tfjXhD7avvenD4bCMY=;
        b=dIdk2NRzLMV2jvU6+mVJ8sO1Ahsq4BPs3KyRcXImquuSOCpOh2Iz3vJvwsVLdXCevu
         k2Dy/QHO6svF5j8rWEM9VH4lTiF9atBSzPwwsFnAUsfvdg10pPUekEmpVNzhm6RKzMCM
         +jJ7+lImr7UtMEe61hzdZQZrsyO9+iehmnzno5uyFDv7eF1PlggRfC96j9CRd2b6Dzr1
         J03O8aefWOWJ17FUgZJCjPz7vUxqzBSlcDpaT4LeWVYwE0pLQ2SHET6jjrmwSvPJd5ts
         1hqYRFnEJMBHBZM4JrnsBpEtqPnkqHPhAVYMMo4m89M/rwNhHkNdR7IRjeylU5BqNMn0
         Z6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=p5Y3W/tQDWHyEnQCsxi+bfhl3tfjXhD7avvenD4bCMY=;
        b=1A2j5og2Bq25LVX/2gemn7Yh9Qh9sRpGWVGS0LLy288YaPRFxTdbIQMuGlY2NgQEOA
         s5FU4uZjlgZVbv/nBW+Gnnl+FM3WgM8ok8Zait0LKKCAewm2nOOKnilNMnNgrEYDMAqE
         2L+G3T3mpmbh0AAF7wWrD83FKX4ceEQ+NkJ84MQFVXQqYPAplygRIok4x1/6qaM7eNDn
         LlGRXenhdH+oGL2PCWFqyjpKz2wJmMn/uQVlxxWxOwCajXAYqQE+prtotsUMwUGy2LsE
         Kyv9jI2tVUD2xlY43NC14o06BngJgMJC9Tz4I1xjIus2JvVctpEClK1rV0LlrU/FIEND
         scog==
X-Gm-Message-State: AJIora83FhXAjlD2T7B4ovYky3uMjsXLpNbN50wJ0hpJtlzvQhrfG3uu
        TgFp8SuZ9nH5QGPXgp2eaxU=
X-Google-Smtp-Source: AGRyM1uw/Czt6yAlsyO0mILs8jhoBIiYUY7Z8Ys95Pix0WzkWyEb4AaOVs+xWRZmgLl7i5kT1NyAdA==
X-Received: by 2002:a05:6402:2549:b0:437:788d:b363 with SMTP id l9-20020a056402254900b00437788db363mr55404355edb.406.1657140308585;
        Wed, 06 Jul 2022 13:45:08 -0700 (PDT)
Received: from localhost (92.40.202.5.threembb.co.uk. [92.40.202.5])
        by smtp.gmail.com with ESMTPSA id g15-20020a056402320f00b0043a85d7d15esm2723306eda.12.2022.07.06.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 13:45:07 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
 <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
 <R11Wg2gY4kEFeq6ZSy2mXbGejo7XRfjG@localhost>
 <4ca4580a3f5157e3ac7a5c8943ef607b@walle.cc>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-reply-to: <4ca4580a3f5157e3ac7a5c8943ef607b@walle.cc>
Date:   Wed, 06 Jul 2022 21:46:15 +0100
Message-ID: <DfKGwB5bggV3msX63bZrjjUX37ipAwv7@localhost>
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


Michael Walle <michael@walle.cc> writes:

> Am 2022-07-04 18:01, schrieb Aidan MacDonald:
>> Michael Walle <michael@walle.cc> writes:
>> 
>>> Am 2022-07-03 13:10, schrieb Aidan MacDonald:
>>>> Some devices use a multi-bit register field to change the GPIO
>>>> input/output direction. Add the ->reg_field_xlate() callback to
>>>> support such devices in gpio-regmap.
>>>> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
>>>> driver to return a mask and values to describe a register field.
>>>> gpio-regmap will use the mask to isolate the field and compare or
>>>> update it using the values to implement GPIO level and direction
>>>> get and set ops.
>>> Thanks for working on this. Here are my thoughts on how to improve
>>> it:
>>>  - I'm wary on the value translation of the set and get, you
>>>    don't need that at the moment, correct? I'd concentrate on
>>>    the direction for now.
>>>  - I'd add a xlate_direction(), see below for an example
>> Yeah, I only need direction, but there's no advantage to creating a
>> specific mechanism. I'm not opposed to doing that but I don't see
>> how it can be done cleanly. Being more general is more consistent
>> for the API and implementation -- even if the extra flexibility
>> probably won't be needed, it doesn't hurt.
>
> I'd prefer to keep it to the current use case. I'm not sure if
> there are many controllers which have more than one bit for
> the input and output state. And if, we are still limited to
> one register, what if the bits are distributed among multiple
> registers..
>

I found three drivers (not exhaustive) that have fields for setting the
output level: gpio-amd8111, gpio-creg-snps, and gpio-lp3943. Admittedly
that's more than I expected, so maybe we shouldn't dismiss the idea of
multi-bit output fields.

If you still think the API you're suggesting is better then I can go
with it, but IMHO it's more code and more special cases, even if only
a little bit.

>>>  - because we can then handle the value too, we don't need the
>>>    invert handling in the {set,get}_direction. drop it there
>>>    and handle it in a simple_xlat. In gpio_regmap,
>>>    store "reg_dir_base" and "invert_direction", derived from
>>>    config->reg_dir_in_base and config->reg_dir_out_base.
>>> 
>> I think this is more complicated and less consistent than handling
>> reg_dir_in/out_base separately.
>
> It is just an internal implementation detail; I'm not talking
> about changing the configuration. And actually, there was
> once confusion about the reg_dir_in_base and reg_dir_out_base, IIRC.
> I'd need to find that thread again. But for now, I'd keep the
> configuration anyway.
>
> Think about it. If you already have the value translation (which you
>  need), why would you still do the invert inside the
> {set,get}_direction? It is just a use case of the translation
> function actually. (Also, an invert only makes sense with a one
> bit value).
>
> You could do something like:
> if (config->reg_dir_out_base) {
>    gpio->xlat_direction = gpio_regmap_simple_xlat_direction;
>    gpio->reg_dir_base = config->reg_dir_out_base;
> }
> if (config->reg_dir_in_base) {
>    gpio->xlat_direction = gpio_regmap_simple_xlat_direction_inverted;
>    gpio->reg_dir_base = config->reg_dir_in_base;
> }
>
> But both of these function would be almost the same, thus my
> example below.
>
> Mhh. Actually I just noticed while writing this.. we need a new
> config->reg_dir_base anyway, otherwise you'd need to either pick
> reg_dir_in_base or reg_dir_out_base to work with a custom
> .xlat_direction callback.
>
> if (config->xlat_direction) {
>    gpio->xlat_direction = config->gpio_xlat_direction;
>    gpio->reg_dir_base = config->reg_dir_base;
> }
>
> Since there are no users of config->reg_dir_in_base, we can just kill
> that one. These were just added because it was based on bgpio. Then
> it will just be:
>
> gpio->reg_dir_base = config->reg_dir_base;
> gpio->direction_xlat = config->direction_xlat;
> if (!gpio->direction_xlat)
>   gpio->direction_xlat = gpio_regmap_simple_direction_xlat;
>
> If someone needs an inverted direction, he can either have a custom
> direction_xlat or we'll introduce a config->invert_direction option.
>
>>> static int gpio_regmap_simple_xlat_direction(struct gpio_regmap *gpio
>>>                                              unsigend int base,
>>>                                              unsigned int offset,
>>>                                              unsigned int *dir_out,
>>>                                              unsigned int *dir_in)
>>> {
>>>     unsigned int line = offset % gpio->ngpio_per_reg;
>>>     unsigned int mask = BIT(line);
>>>     if (!gpio->invert_direction) {
>>>         *dir_out = mask;
>>>         *dir_in = 0;
>>>     } else {
>>>         *dir_out = 0;
>>>         *dir_in = mask;
>>>     }
>>>     return 0;
>>> }
>> This isn't really an independent function: what do *dir_out and *dir_in
>> mean on their own? You need use the matching mask from ->reg_mask_xlate
>> for those values to be of any use. And those two functions have to match
>> up because they need to agree on the same mask.
>
> Yes. I was thinking it isn't an issue because the driver implementing this
> will need to know the mask anyway. But maybe it is better to also pass
> the mask, which was obtained by the .reg_mask_xlat(). Or we could just
> repeat the corresponding value within the value and the caller could
> also apply the mask to this returned value.
>
> I.e. if you have a two bit value 01 for output and 10 for input and
> you have a 32bit register with 16 values, you can use
>  *dir_out = 0x55555555;
>  *dir_in = 0xaaaaaaaa;
>
> Not that easy to understand. But maybe you find it easier than me
> to write documentation ;)
>
> -michael
>
>>> And in the {set,get}_direction() you can then check both
>>> values and convert it from or to GPIO_LINE_DIRECTION_{OUT,IN}.
>> Agreed, checking both values and erroring out if the register has an
>> unexpected value is a good idea.
>> 
>>> Thoughts?
