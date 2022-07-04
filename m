Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B076B565E20
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiGDTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiGDTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:46:43 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC565E8;
        Mon,  4 Jul 2022 12:46:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2C4A222175;
        Mon,  4 Jul 2022 21:46:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656963999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5D6i1C5KDJO41Zs7OxjF8j52gWUYHbEcgRHRoHFZLs=;
        b=YDuBDPkQ7dovCxnP/R18hs8xS18+2bTT2zEeCtVZn9QJ8iEiQGziU+HHugm3stZBvQUc1+
        wyc/7EyuEWSVpqGDp5oHxbqAV1olriJ7si0fwWnK2F5pY3WG1YtfS4jqN4xOKfPB1w+hYt
        C60XSXjm7K2fBpusJgWkXYNphrNbvtI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Jul 2022 21:46:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-Reply-To: <R11Wg2gY4kEFeq6ZSy2mXbGejo7XRfjG@localhost>
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
 <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
 <R11Wg2gY4kEFeq6ZSy2mXbGejo7XRfjG@localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4ca4580a3f5157e3ac7a5c8943ef607b@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-04 18:01, schrieb Aidan MacDonald:
> Michael Walle <michael@walle.cc> writes:
> 
>> Am 2022-07-03 13:10, schrieb Aidan MacDonald:
>>> Some devices use a multi-bit register field to change the GPIO
>>> input/output direction. Add the ->reg_field_xlate() callback to
>>> support such devices in gpio-regmap.
>>> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
>>> driver to return a mask and values to describe a register field.
>>> gpio-regmap will use the mask to isolate the field and compare or
>>> update it using the values to implement GPIO level and direction
>>> get and set ops.
>> 
>> Thanks for working on this. Here are my thoughts on how to improve
>> it:
>>  - I'm wary on the value translation of the set and get, you
>>    don't need that at the moment, correct? I'd concentrate on
>>    the direction for now.
>>  - I'd add a xlate_direction(), see below for an example
> 
> Yeah, I only need direction, but there's no advantage to creating a
> specific mechanism. I'm not opposed to doing that but I don't see
> how it can be done cleanly. Being more general is more consistent
> for the API and implementation -- even if the extra flexibility
> probably won't be needed, it doesn't hurt.

I'd prefer to keep it to the current use case. I'm not sure if
there are many controllers which have more than one bit for
the input and output state. And if, we are still limited to
one register, what if the bits are distributed among multiple
registers..

>>  - because we can then handle the value too, we don't need the
>>    invert handling in the {set,get}_direction. drop it there
>>    and handle it in a simple_xlat. In gpio_regmap,
>>    store "reg_dir_base" and "invert_direction", derived from
>>    config->reg_dir_in_base and config->reg_dir_out_base.
>> 
> 
> I think this is more complicated and less consistent than handling
> reg_dir_in/out_base separately.

It is just an internal implementation detail; I'm not talking
about changing the configuration. And actually, there was
once confusion about the reg_dir_in_base and reg_dir_out_base, IIRC.
I'd need to find that thread again. But for now, I'd keep the
configuration anyway.

Think about it. If you already have the value translation (which you
  need), why would you still do the invert inside the
{set,get}_direction? It is just a use case of the translation
function actually. (Also, an invert only makes sense with a one
bit value).

You could do something like:
if (config->reg_dir_out_base) {
    gpio->xlat_direction = gpio_regmap_simple_xlat_direction;
    gpio->reg_dir_base = config->reg_dir_out_base;
}
if (config->reg_dir_in_base) {
    gpio->xlat_direction = gpio_regmap_simple_xlat_direction_inverted;
    gpio->reg_dir_base = config->reg_dir_in_base;
}

But both of these function would be almost the same, thus my
example below.

Mhh. Actually I just noticed while writing this.. we need a new
config->reg_dir_base anyway, otherwise you'd need to either pick
reg_dir_in_base or reg_dir_out_base to work with a custom
.xlat_direction callback.

if (config->xlat_direction) {
    gpio->xlat_direction = config->gpio_xlat_direction;
    gpio->reg_dir_base = config->reg_dir_base;
}

Since there are no users of config->reg_dir_in_base, we can just kill
that one. These were just added because it was based on bgpio. Then
it will just be:

gpio->reg_dir_base = config->reg_dir_base;
gpio->direction_xlat = config->direction_xlat;
if (!gpio->direction_xlat)
   gpio->direction_xlat = gpio_regmap_simple_direction_xlat;

If someone needs an inverted direction, he can either have a custom
direction_xlat or we'll introduce a config->invert_direction option.

>> static int gpio_regmap_simple_xlat_direction(struct gpio_regmap *gpio
>>                                              unsigend int base,
>>                                              unsigned int offset,
>>                                              unsigned int *dir_out,
>>                                              unsigned int *dir_in)
>> {
>>     unsigned int line = offset % gpio->ngpio_per_reg;
>>     unsigned int mask = BIT(line);
>> 
>>     if (!gpio->invert_direction) {
>>         *dir_out = mask;
>>         *dir_in = 0;
>>     } else {
>>         *dir_out = 0;
>>         *dir_in = mask;
>>     }
>> 
>>     return 0;
>> }
> 
> This isn't really an independent function: what do *dir_out and *dir_in
> mean on their own? You need use the matching mask from ->reg_mask_xlate
> for those values to be of any use. And those two functions have to 
> match
> up because they need to agree on the same mask.

Yes. I was thinking it isn't an issue because the driver implementing 
this
will need to know the mask anyway. But maybe it is better to also pass
the mask, which was obtained by the .reg_mask_xlat(). Or we could just
repeat the corresponding value within the value and the caller could
also apply the mask to this returned value.

I.e. if you have a two bit value 01 for output and 10 for input and
you have a 32bit register with 16 values, you can use
  *dir_out = 0x55555555;
  *dir_in = 0xaaaaaaaa;

Not that easy to understand. But maybe you find it easier than me
to write documentation ;)

-michael

>> 
>> And in the {set,get}_direction() you can then check both
>> values and convert it from or to GPIO_LINE_DIRECTION_{OUT,IN}.
> 
> Agreed, checking both values and erroring out if the register has an
> unexpected value is a good idea.
> 
>> 
>> Thoughts?
