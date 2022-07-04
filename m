Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB59565A93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiGDQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiGDQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:02:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF6422D;
        Mon,  4 Jul 2022 09:02:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so7831952wmc.1;
        Mon, 04 Jul 2022 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=G56nKI/O2hNdAH6LeBwH+SCn4OXisZtyAQoA0hUm9ms=;
        b=RfxlueZGqzLz9V4IpA0gOeFziZfUgz+gq+3PYW4JyFndv7bE8LEbW6v7NM68W4XD1G
         Avch0rCuaDgjUXHhuGWH6oH5clCFBy97hfnlcphtTBgB2OEmGwaf3I8X5hlfbHF7F4JR
         A3XcQO4FSAvoAb/0gymh7izDMG7KMj9WZT5w60Z3twYD6/ZYfo6ZEJkVWml8C2PpjXNK
         aFawPrY3wz2U6j+ESko0ECfN/ZXWsZkAPKQkV+5CY4oVbk5x/QgKbX3nc2BOpoQQB//9
         Qni147AUnmZxMuyAexnPMmjIIocdCKxSmxV36uxgIbLk1ssXUhR/8FHUkgSOjkbaMEXV
         ULoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=G56nKI/O2hNdAH6LeBwH+SCn4OXisZtyAQoA0hUm9ms=;
        b=YLLwEuF4IuaKvRqnL9vsQX34LE0LNeGy6jwB5jkwJhJBj7B4dwWvzHlYiwFbGtz0Ya
         gjcOD5d+MheJx19KTRbvFpKzBudZy4Ehy/gAndZsHEYRkWQNPjY/qhXIfwFT1xLCdww1
         VZG91nA//JDfZSfGi1gUbNViGxNkDcowY00slSDAzJNArK2HnK5Jn9Q6PIGdKsul7aJz
         KXO80wRMj/p/V+G1iuKMdZePMIN+FAdZMoQ70SE4XWxWspFGyx2gf2tTZkZJOQT1BNOx
         XA1BE3EJloYLZSkXStjZO4PoTiTGvEehAQDoSH8swexGLlmiAGQ6GSzpgxpVs/QLVIbt
         1fRw==
X-Gm-Message-State: AJIora9x9JZCYZOYvFAqDkAUK4X85kn+1+oiRngj6IZn9fWzIKBbaP56
        BZ22szdphBZc3vV7vIaNlcUhRIYN0+c=
X-Google-Smtp-Source: AGRyM1u3VmK34bN5YjRqMzmMGmRNnbDk4+6oKqnKCFgdo3aQhglfkJLZXnQ1WXsm4JUYyG+enBS/HA==
X-Received: by 2002:a05:600c:3d11:b0:3a1:8c05:6e75 with SMTP id bh17-20020a05600c3d1100b003a18c056e75mr19508943wmb.203.1656950555951;
        Mon, 04 Jul 2022 09:02:35 -0700 (PDT)
Received: from localhost (92.40.202.10.threembb.co.uk. [92.40.202.10])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm19868227wmi.29.2022.07.04.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:02:35 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
 <CAHp75VeosViEcLZ3LF92=_bpSmyGthh2j9V4xYtHTt0Z-fn3-Q@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-reply-to: <CAHp75VeosViEcLZ3LF92=_bpSmyGthh2j9V4xYtHTt0Z-fn3-Q@mail.gmail.com>
Date:   Mon, 04 Jul 2022 17:03:44 +0100
Message-ID: <vida3rYRhoYbLy6DJhvZgLhDgrHRy5mn@localhost>
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


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Sun, Jul 3, 2022 at 1:11 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>>
>> Some devices use a multi-bit register field to change the GPIO
>> input/output direction. Add the ->reg_field_xlate() callback to
>> support such devices in gpio-regmap.
>>
>> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
>> driver to return a mask and values to describe a register field.
>> gpio-regmap will use the mask to isolate the field and compare or
>> update it using the values to implement GPIO level and direction
>> get and set ops.
>
> Thanks for the proposal. My comments below.
>
> ...
>
>> +static void
>> +gpio_regmap_simple_field_xlate(struct gpio_regmap *gpio,
>> +                              unsigned int base, unsigned int offset,
>> +                              unsigned int *reg, unsigned int *mask,
>> +                              unsigned int *values)
>> +{
>> +       gpio->reg_mask_xlate(gpio, base, offset, reg, mask);
>> +       values[0] = 0;
>> +       values[1] = *mask;
>
> This is a fragile and less compile-check prone approach. If you know
> the amount of values, make a specific data type for that, or pass the
> length of the output buffer..
>
>> +}
>
> ...
>
>> +       unsigned int values[2];
>
>> +       return (val & mask) == values[1];
>
>> +       unsigned int values[2];
>
> How will the callee know that it's only 2 available?
>
>
>> +       regmap_update_bits(gpio->regmap, reg, mask, values[!!val]);
>
> If we have special meaning of the values, perhaps it needs to follow
> an enum of some definitions, so everybody will understand how indices
> are mapped to the actual data in the array.
>
>> +       unsigned int values[2];
>
>> +       regmap_update_bits(gpio->regmap, reg, mask, values[1]);
>
>> +       unsigned int values[2];
>
>> +       if ((val & mask) == values[invert])
>
> How do you guarantee this won't overflow? (see above comment about
> indices mapping)
>
>> +       unsigned int values[2];
>
> As per above comments.

The documentation states that ->reg_field_xlate returns values[0] and
values[1] for low/high level or input/output direction. IOW, 0 is low
level / input direction and 1 is high level / output direction.

Embedding the array in a struct seems like a better idea though, thanks.
