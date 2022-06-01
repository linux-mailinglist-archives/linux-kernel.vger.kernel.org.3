Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0A53A14C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351626AbiFAJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349979AbiFAJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:52:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD55DE53;
        Wed,  1 Jun 2022 02:52:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so1129415ejc.7;
        Wed, 01 Jun 2022 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1mJGH5c1Uozsg7k4TIS92U6v6LjyV9oFoYVM0NRha8=;
        b=pDzLCrKYfqkJbuKWjOE7YKh1BjW8iuiBm1bkNBWCdyl6ZXoEh4vEn7DK+SXSpbB90U
         0mMySw+1KW+jWuSlprGFz1/ZihwNlBGfQoJ952/S65Zmwv3yE5hNf/jPQiWvymLTm2fF
         5PkFkXZAasgyv3D7SLAriP98k8PabcZr76rGv9IlXeRbm0xbiyv3vYnBL++vOmRc3YHf
         XDY8aMNfCeHWTJKIS7vTg70L9GewCHcK41H93Qqlgs6oPaArJ8adNouaJAAsPAr7X8F4
         inDdCJvjhmWW8uwlHRhS2KKJQUa9JGtgmNjDKfkuu2t5FghP5ZU/AhZiljZlz8vr07eB
         Bzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1mJGH5c1Uozsg7k4TIS92U6v6LjyV9oFoYVM0NRha8=;
        b=oUCrpTF45P2VHH050RTHHZ2ulrytmNIPVKrS+SdWkiwLP+KTtUxKX3CngaZEdZspq7
         ughpY0FpjN4UgbpkmQ+eLE76y5NDRTzV8x2fHVzhPG/NqnsaGpLvvA7epbkBvZ287FFm
         0f4P/pkY3IFXChroItUS6JPtYEUjsglh0R1mNL26jgGQClPGsS6z9N+rYbdjILlQ6dUI
         xGufeQSt5tLGAfAps8xuBC8TuW/3UEJFPrwbpj6fim74aan8excuvpVUDIhaRDNB0CnH
         ujIvZKqvv5tLLNmiI/dOKGs6Iepn+N3EK9qQD9TPNgnYFa0L3kRDlBHvLPzpACx+20/W
         TGRQ==
X-Gm-Message-State: AOAM533p4t6FsyTpeu5Tppqvach0oRCNFN07lzyWjiHAc128peo+r2Ii
        vvTJq67yuPM9Sx5NGwJlsWpY5WoZelX8UjfnhcA=
X-Google-Smtp-Source: ABdhPJyqf9ZHomloEdcRczicdqSM2R1J6YhdToJV6ojkEOXFybYoQ0iogidyjBJ4Et6n0VcyKxc+QBr3vsPZaac7yDU=
X-Received: by 2002:a17:906:2416:b0:6fe:a0be:91d5 with SMTP id
 z22-20020a170906241600b006fea0be91d5mr54057142eja.132.1654077125409; Wed, 01
 Jun 2022 02:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-7-peterwu.pub@gmail.com>
 <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com>
In-Reply-To: <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 11:51:30 +0200
Message-ID: <CAHp75Vf245Oo3wmx5rh_EkXZ4FL_nnehpfuaDAiEdG6BenXxhw@mail.gmail.com>
Subject: Re: [PATCH 06/14] leds: mt6370: Add Mediatek MT6370 Indicator support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>, cy_huang@richtek.com,
        alice_chen@richtek.com, chiaen_wu@richtek.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
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

On Wed, Jun 1, 2022 at 11:48 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 31, 2022 at 1:16 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> >
> > From: Alice Chen <alice_chen@richtek.com>
>
> All below comments are applicable to the rest of the series as well
> (one way or another), so please fix all your patches where it's
> appropriate.

Forgot to mention, please consider using

  return dev_err_probe();

pattern in the ->probe() and related funcitons. It will save a lot of LOCs.

> > Add Mediatek MT6370 Indicator support
>
> What indicator?
> Please also keep attention on English punctuation (missed period).
>
> ...
>
> > +       help
> > +         Support 4 channels and reg/pwm/breath mode.
> > +         Isink4 can also use as a CHG_VIN power good Indicator.
>
> be used
>
> > +         Say Y here to enable support for
> > +         MT6370_RGB_LED device.
>
> ...
>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
>
> > +#include <linux/of.h>
>
> Are you sure this is the correct header? Seems you need
> mod_devicetable.h instead.
>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
>
> ...
>
> > +struct mt6370_priv {
> > +       struct mutex lock;
>
> Do you use regmap locking?
>
> > +       struct device *dev;
>
> > +       struct regmap *regmap;
>
> > +       struct regmap_field *fields[F_MAX_FIELDS];
> > +       const struct reg_field *reg_fields;
> > +       const struct linear_range *ranges;
> > +       struct reg_cfg *reg_cfgs;
> > +       unsigned int leds_count;
> > +       unsigned int leds_active;
> > +       bool is_mt6372;
> > +       struct mt6370_led leds[];
> > +};
>
> ...
>
> > +static const unsigned int common_tfreqs[] = {
> > +       10000, 5000, 2000, 1000, 500, 200, 5, 1
>
> Leave a comma at the end.
>
> > +};
> > +
> > +static const unsigned int mt6372_tfreqs[] = {
> > +       8000, 4000, 2000, 1000, 500, 250, 8, 4
>
> Ditto.
>
> > +};
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
