Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935C53A166
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbiFAJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350616AbiFAJ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:58:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B9633BF;
        Wed,  1 Jun 2022 02:57:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er5so1403784edb.12;
        Wed, 01 Jun 2022 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PCo0X+pMIpsY2Uf1dnrZhLPPiwDltwA+NDnzoDspis=;
        b=XhPAQhUfhBI91dCm0a95O3zad9USLtdiUcVt34raOi5ptwRCbqGza/NaTDd4EyaLX1
         v+lU4+0Cpv23sZE0fOO2N2HTBcIFXG/TrXkhJtsD7CDwNqGJypEeR7+wpAAfxQ1X488D
         dE+CRh6Hkq089m6paqTZCvDHckNRC4IMxltEdMIcZKV16VY0YAbxtda5vGAtZ+29jWIB
         wsP4WOukuw86fxqUt+VuAO/be5ZLtm8pPCExUs4n6YACXBrBBZ59DeQ84G1qh+H99nN5
         aOtK25kj0UzNDeF/Trja2mohLceUsbRjs3gvT+99D2KTbrfsm8sfvH805b8ESjdWyxOW
         REyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PCo0X+pMIpsY2Uf1dnrZhLPPiwDltwA+NDnzoDspis=;
        b=nedvMP7lRmLvzsUGnhIHa6lMA5bto4zrjOR/bSeb84Esg+BLzRRUolET/e/RR5yaDo
         HuBYJSLQEvhhb8gp3us5esp97OctNQKEYI5cps7I+n2+HIbAWiExOp/RMdKStHqrsKan
         3TiVlvRRdYqA4YrAhvley4Y8ysTK6L1MBrseWbg8orSqJ6J/2YHsq0dBh6gkfzyX+X6X
         uzNwsjniWWVGlFd/VpH99ZAgLBM/3B+D4Ojp3JeAoHDBKZl/eAsTs2ldsIjv+qqDuaV8
         X+5/39RgMip5NG5Ov6FcE1j/lvJlmKSFjqEfxu2uPuF1Tw6WiynijxTwsAzfRQw65lG8
         lUhQ==
X-Gm-Message-State: AOAM533QKdC+SAeD8xjd0XhUBjvJWMW/noXSpdFx3aKvNGehvSSBWPfj
        Rv+kh7EkkyUklihV6CfG1A7A1tXbjqA3gSwczNY=
X-Google-Smtp-Source: ABdhPJx5UwB9OK6uoDWwzcHechvusyUFa0L+DRuEojeZ5rXjdN4Kqx2DmQl8OM9CHARC3CjwaOQOEOHl8iMseiJla1c=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr21507509eda.141.1654077471168; Wed, 01
 Jun 2022 02:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-8-peterwu.pub@gmail.com>
In-Reply-To: <20220531102809.11976-8-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 11:57:15 +0200
Message-ID: <CAHp75VdUQqihr=AX-wEUD05jY1ReL63hMCL+eaqmjkN8CsS_Vg@mail.gmail.com>
Subject: Re: [PATCH 07/14] leds: flashlight: mt6370: Add Mediatek MT6370
 flashlight support
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

On Tue, May 31, 2022 at 1:32 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: Alice Chen <alice_chen@richtek.com>
>
> Add Mediatek MT6370 flashlight support

Same comments about the commit message.

...

> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

+ blank line?

> +#include <media/v4l2-flash-led-class.h>

+ blank line

> +enum {
> +       MT6370_LED_FLASH1,
> +       MT6370_LED_FLASH2,
> +       MT6370_MAX_LEDS
> +};

...

> +       struct mt6370_led *led = container_of(fl_cdev, struct mt6370_led,
> +                                             flash);

> +       struct mt6370_led *led = container_of(fl_cdev, struct mt6370_led,
> +                                             flash);

Make a helper out of this

  #define to_mt637_led()  container_of()

and reuse.

...

> +       /*
> +        * For the flash turn on/off, HW rampping up/down time is 5ms/500us,

ramping

> +        * respectively

Period!

> +        */

...

> +       const char * const states[] = { "off", "keep", "on" };
> +       const char *str;
> +       int ret;
> +
> +       if (!fwnode_property_read_string(init_data->fwnode,
> +                                        "default-state", &str)) {
> +               ret = match_string(states, ARRAY_SIZE(states), str);
> +               if (ret < 0)
> +                       ret = STATE_OFF;
> +
> +               led->default_state = ret;
> +       }

fwnode_property_match_string()?

...

> +       if (!count || count > MT6370_MAX_LEDS) {
> +               dev_err(&pdev->dev,
> +               "No child node or node count over max led number %lu\n", count);
> +               return -EINVAL;

return dev_err_probe(...);

> +       }


--
With Best Regards,
Andy Shevchenko
