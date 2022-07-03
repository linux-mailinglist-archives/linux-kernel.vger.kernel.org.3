Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92175647F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGCOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGCOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:10:05 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812492735;
        Sun,  3 Jul 2022 07:10:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l11so12384090ybu.13;
        Sun, 03 Jul 2022 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWbCu1r2xegPtorccEt93lf8b9HPFUvuS5WXxyAvzZQ=;
        b=nd43pgElSJxznZuuljhBywhGZV2EFwhHs4t51OLkV8D9qLOy62yz47dCk5TtTeoLOa
         UPNoBLynxOsCT8gE4obmMI7kOfn1RJI0gPMNbPFUx2AcVaEPzgzeLB0r9AtIcaczRYzw
         lxB/jGcTtZNFNBM+tbQPkt3QlgLjDl5osetZO321U0Xc05cRGqVmMFuCkPSUHR/py1pv
         3t8BncmykSin6VNPjB2qpP1Ik1R1LTCTH5YTWtfdAus4AmywgG03kQB7FKrVjDDcWNa1
         +fLzI6Cd/ShBu5mjmt66QINWNbQPpBiXiKZHFqOm+vejjvOy5ejtZB8GIaeCjKyhGYGz
         pidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWbCu1r2xegPtorccEt93lf8b9HPFUvuS5WXxyAvzZQ=;
        b=aPV6aqBplmiE5q0QB/2LKa0+dXe/JwGVCWL4r5qQpv7m+wOoPhLeyHmDqB72+MgMBr
         Pg16DA+/XakRasRsOKRsuURa0gssoEd4ea/VOIL0GI8kzwFPuGnkYiWLJwnruqgQCj5L
         6n6er8rdvQ4+YT8/MnsIKOw9c0OTNl+kh9LGi6wNMRnVRptMLafGXpUwePaXOPxs8nfH
         IlhUr0Au51oswHEXeaSak637czU5OcZhGbm2lR6IrDySCIntUxgYrRHatJsN04xYWy0+
         AEUW55JHGI1Hg0Pd71OY2kXbMvN3uaN9GCejXxBT0L8S0EkTx6Etm6M1zQNwcih2ouSt
         nvPQ==
X-Gm-Message-State: AJIora9B9C0kVBN+7vZ633m/N/DGI44BEkXkWx+zk3DbVRQrdYEAmWuO
        W8nwoQqCy90lF3m1c0zfKkHpdpmgdSiu3O76C8w=
X-Google-Smtp-Source: AGRyM1sJyi35oUDBpRXfGN1qX8qgyUHqqTcV5bdZJms/JB89iLsSnCKSuf66hbpRdBBp1oTYn7V/rM7dYi81N93Oolg=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr425468ybk.296.1656857403543; Sun, 03
 Jul 2022 07:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com> <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 16:09:26 +0200
Message-ID: <CAHp75VeosViEcLZ3LF92=_bpSmyGthh2j9V4xYtHTt0Z-fn3-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 1:11 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Some devices use a multi-bit register field to change the GPIO
> input/output direction. Add the ->reg_field_xlate() callback to
> support such devices in gpio-regmap.
>
> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
> driver to return a mask and values to describe a register field.
> gpio-regmap will use the mask to isolate the field and compare or
> update it using the values to implement GPIO level and direction
> get and set ops.

Thanks for the proposal. My comments below.

...

> +static void
> +gpio_regmap_simple_field_xlate(struct gpio_regmap *gpio,
> +                              unsigned int base, unsigned int offset,
> +                              unsigned int *reg, unsigned int *mask,
> +                              unsigned int *values)
> +{
> +       gpio->reg_mask_xlate(gpio, base, offset, reg, mask);
> +       values[0] = 0;
> +       values[1] = *mask;

This is a fragile and less compile-check prone approach. If you know
the amount of values, make a specific data type for that, or pass the
length of the output buffer..

> +}

...

> +       unsigned int values[2];

> +       return (val & mask) == values[1];

> +       unsigned int values[2];

How will the callee know that it's only 2 available?


> +       regmap_update_bits(gpio->regmap, reg, mask, values[!!val]);

If we have special meaning of the values, perhaps it needs to follow
an enum of some definitions, so everybody will understand how indices
are mapped to the actual data in the array.

> +       unsigned int values[2];

> +       regmap_update_bits(gpio->regmap, reg, mask, values[1]);

> +       unsigned int values[2];

> +       if ((val & mask) == values[invert])

How do you guarantee this won't overflow? (see above comment about
indices mapping)

> +       unsigned int values[2];

As per above comments.

-- 
With Best Regards,
Andy Shevchenko
