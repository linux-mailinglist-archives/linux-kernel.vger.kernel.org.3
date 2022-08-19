Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D0599CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349340AbiHSNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349349AbiHSNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:13:22 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A0D8B3D;
        Fri, 19 Aug 2022 06:13:09 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id s5so1760576uar.1;
        Fri, 19 Aug 2022 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=hUDdWXxm7BsuydsAQtCOOvlHqEqkIuN6xiZIae2gIqY=;
        b=kHdaSIXI/tyWxSuuzmByH9Y7W+5ewFJ5CYAel9EU17+WmgnA+ujfgRTEGh5Tap0oKc
         o7Bu/SOXmroG6hmAt1M/i1MfdDH3FDlu0iPD6iYjtKtm9IcFnVptoxOlaxBiGXvYAFCn
         6cxSD+WxaVDUAJGHfbmvpZcVpBQlzU7yTbeWWHWVm8YsPadjG7K1OXYuYW2kPwBMoaKq
         15ez9Dy6uf0BOZUVItq5860hQ25Kp8YvYTY4SGBEukDH8VpQq5GKIMP5CEJiyOiYqtnW
         nvoyCSf1uhM76oNwPuOsrFsJBr4RjRCZYYiEI62JD6lZi8GUwraUl/znqertYTAGSYCx
         RtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=hUDdWXxm7BsuydsAQtCOOvlHqEqkIuN6xiZIae2gIqY=;
        b=Gan05Yi8MKPxqjM7xBXYDI/4CZjR4FdoB6V2ozPwxZ4KQZSIoxQu+5JlhcZ5Wm7ELR
         GclbzFgCKbFxRxnNfY73ZJWMOzcRKgpP6iYaKUwDV839Wh4PZTp5v7d4Su9066s2dJqN
         A/YfmIE+HNyZ0EY9uTvTWtcg50vzaVeSRlN/1yzx5jBEdVtgvgYtU0bJ3nzuGhGYEWaR
         ukxAHRIa/4XUH78Jgmtbo38LgxJiWTM1ECk/QJjkOm9SmYGdBLHXE2Gh37whzkRdp914
         TKceUr9LM0sGRxfvKXKObgaR3QfFIlFmZe0EoEFSO3HHjvFoT0AJe0BDmUX2BzlbM1Bk
         M2Iw==
X-Gm-Message-State: ACgBeo27qH/qUWv29OmON4uxFlFQJ8UkqaI7YhMoQM8jtZ9wgsDe14Gs
        qsPOwxTYYh7JtDdSTtChVrkiaMq2rEZNg/C/QNeWYSwreK8=
X-Google-Smtp-Source: AA6agR7XK2z3N9Sy6KDGYmuv5Myk29eJEv/u19msKcOzxYfJCdewiDQPTwLFjYtq6CzjtUa0Sb++efnLAiUx/194cDo=
X-Received: by 2002:ab0:6dcb:0:b0:395:e519:9f70 with SMTP id
 r11-20020ab06dcb000000b00395e5199f70mr2925027uaf.120.1660914787563; Fri, 19
 Aug 2022 06:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220615070813.7720-1-romain.perier@gmail.com>
 <20220615070813.7720-3-romain.perier@gmail.com> <20220619213520.qonqdv4e7zkvpeo7@pengutronix.de>
In-Reply-To: <20220619213520.qonqdv4e7zkvpeo7@pengutronix.de>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Fri, 19 Aug 2022 15:12:56 +0200
Message-ID: <CABgxDo+_uZyO2vV4QxmVLTo2ohpAxzC89jcGJ3oksT6XxEBCmA@mail.gmail.com>
Subject: Re: [PATCH 2/5] pwm: Add support for the MSTAR MSC313 PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dim. 19 juin 2022 =C3=A0 23:35, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > diff --git a/drivers/pwm/pwm-msc313e.c b/drivers/pwm/pwm-msc313e.c
> > new file mode 100644
> > index 000000000000..f20419c6b9be
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-msc313e.c
> > @@ -0,0 +1,242 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Daniel Palmer <daniel@thingy.jp>
> > + * Copyright (C) 2022 Romain Perier <romain.perier@gmail.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define DRIVER_NAME "msc313e-pwm"
> > +
> > +#define CHANNEL_OFFSET       0x80
> > +#define REG_DUTY     0x8
> > +#define REG_PERIOD   0x10
> > +#define REG_DIV              0x18
> > +#define REG_CTRL     0x1c
> > +#define REG_SWRST    0x1fc
> > +
> > +struct msc313e_pwm_channel {
> > +     struct regmap_field *clkdiv;
> > +     struct regmap_field *polarity;
> > +     struct regmap_field *dutyl;
> > +     struct regmap_field *dutyh;
> > +     struct regmap_field *periodl;
> > +     struct regmap_field *periodh;
> > +     struct regmap_field *swrst;
> > +};
> > +
> > +struct msc313e_pwm {
> > +     struct regmap *regmap;
> > +     struct pwm_chip pwmchip;
> > +     struct clk *clk;
> > +     struct msc313e_pwm_channel channels[];
> > +};
> > +
> > +struct msc313e_pwm_info {
> > +     unsigned int channels;
> > +};
> > +
> > +#define to_msc313e_pwm(ptr) container_of(ptr, struct msc313e_pwm, pwmc=
hip)
> > +
> > +static const struct regmap_config msc313e_pwm_regmap_config =3D {
> > +     .reg_bits =3D 16,
> > +     .val_bits =3D 16,
> > +     .reg_stride =3D 4,
> > +};
> > +
> > +static const struct msc313e_pwm_info msc313e_data =3D {
> > +     .channels =3D 8,
> > +};
> > +
> > +static const struct msc313e_pwm_info ssd20xd_data =3D {
> > +     .channels =3D 4,
> > +};
> > +
> > +static void msc313e_pwm_writecounter(struct regmap_field *low, struct =
regmap_field *high, u32 value)
> > +{
> > +     regmap_field_write(low, value);
> > +     regmap_field_write(high, value >> 16);
>
> Is this racy? E.g. if the hw is running and the low register overflows
> before the high register is updated?
>

Ack, I am re-working most of the stuff you noticed. The problem with
this IP blocks (and others...) is we have close registers
but we only need to write or read 16 bits in each of these (it is
mainly reverse engineered from vendor source or runtime most of the
time) . You cannot really do a single read (except by doing an obscur
thing via readq ? ...)

. We had exactly the same issue with the rtc driver see [1]

1. https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree=
/drivers/rtc/rtc-msc313.c#n50
.

Regards,
Romain
