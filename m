Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB9563A99
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiGAUGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGAUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:06:41 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2B45505;
        Fri,  1 Jul 2022 13:06:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v185so5811463ybe.8;
        Fri, 01 Jul 2022 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmR8iUUwPvvGa3qQx8YQJ+SVKO3sq39Az7PLcxuZz3A=;
        b=oY05/wttYxGli/gCgXA2u18vdKojjR8sSMqUIKrFDsJQgTnMZb9ZFCjIOov+/xPw0O
         BLvk2Hw/Rf0aJ6CLpX3SEDQojPG1VYqPBHhY6HvlaWxBUgDdXUry2qapteRg/HmeU5+u
         0Cnz8nfclK+NSm0dRaDw8e7crDQ8vVyw9Tpyu9w+KKKVx8Ymyrns1nhxdn05lEMZK2MA
         XPvhCY7flL6vF3yDEtS6D8o5lHExK6dl3rOLds+EPVY3Gf2jsrV6MygdgQp8/N/DWJq9
         Ro5jJOw2jB+oRxI+VLfC47JIZhDlrNmC3nyQF0P1nF3aCT2sFy4orCjsxxqDfBoOogJz
         ccCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmR8iUUwPvvGa3qQx8YQJ+SVKO3sq39Az7PLcxuZz3A=;
        b=lFLEoHeSbkUp4MHbN7O7WNnDzWSYNsS6ex3sTZuEHut/EPvMzyxiCMEvk6bHNbE6QY
         UgNeh6VbbOa07aa0aLHy61SxFWIvfzhbkpS3SiL+/hh+iLabRsxDz5y9ZQOTab+C0HSm
         cWiEHJq4u/sUwR82UsYIvnGFaaf51EwNy4SZE7tkU5RELD3ScHZVlZ/bbwBFP1dXYRDK
         vAfHkuFPswE0Tt8vY54BNl+TDHSTUUi+Z0Vr4fcB7MgpH8jPDvG2PC07rtbmiJRXSDQC
         Xh0ThQSc5nrJ90cPWJtZYM6oXQzUG8cD2hIXcGaQx9EuNkqwRO1ad8S4j85y9yqWloD9
         xD5A==
X-Gm-Message-State: AJIora+gI/Rnkwg4ZNTqCMmt2zNm0RSXKXjhJP0bab9ETAA4pNQsTHa0
        hdPHe2nNBQPhpIWgKtYZH9RWMfUzcLZE0AHNIvEObir7DXr9dhCn
X-Google-Smtp-Source: AGRyM1tmbSsGff7AGFP4d/BpQmef7a+vmYTOkolqSckN06zSGysXK009G4NGKGvyDgzwacFwpWobPEEG40Gs13Q4h+4=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr18394272ybg.296.1656706000179; Fri, 01
 Jul 2022 13:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com> <CAHp75Vduv_fN=2DKbOwReRoPeAYjGqSANT7UhDaRifUJ4zf5XQ@mail.gmail.com>
 <oMIjFujkw4ZeuMGoTkWq64BbfEejJF12@localhost>
In-Reply-To: <oMIjFujkw4ZeuMGoTkWq64BbfEejJF12@localhost>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 22:06:03 +0200
Message-ID: <CAHp75VdVyJyOZCkLQgbDNC9bSWwF0ksLOvMG=96fH8dzmukE5g@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Fri, Jul 1, 2022 at 5:36 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
> > <aidanmacdonald.0x0@gmail.com> wrote:

...

> >> +struct axp192_pctl_function {
> >> +       const char              *name;
> >> +       /* Mux value written to the control register to select the function (-1 if unsupported) */
> >> +       const u8                *muxvals;
> >> +       const char * const      *groups;
> >> +       unsigned int            ngroups;
> >> +};
> >
> > Can it be replaced by struct function_desc?
> > https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinmux.h#L130
>
> That'd work, but using the generic infrastructure doesn't allow me to
> simplify anything -- I can eliminate three trivial functions, but the
> generic code is higher overhead (extra allocations, radix trees, ...)

I really don't see how it gets into extra allocations. Either way you
have a pointer to opaque data or in your current code it's called
muxvals. Other fields seem 1:1 what is in struct function_desc. The
code will be probably the same.

I.o.w. I'm talking of eliminating data type, and not about simplifying
the code by fully switching to generic infrastructure.

> so I'd prefer to stick with the current approach.


-- 
With Best Regards,
Andy Shevchenko
