Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B78558893
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiFWTWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiFWTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:21:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258B6F7AA;
        Thu, 23 Jun 2022 11:26:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so411183lfa.6;
        Thu, 23 Jun 2022 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFXpnCRvpVBhsuNFE1ahfBGJsqNDQt8dQxVvfN6MrL0=;
        b=DalKGI6li9osCh4k7iO37g3v5OUCWoMlA9lcg8wxp3/qi5HIMenhTTdp7lkfmkxaFO
         5i56DaW7feuRINiq2kOC05AY8brpkmge87NEOdDGkcHQCABHBrM/lR06xLa/uYNXD2JN
         HByhcVabc+qx2jAze76QRQrmHqJQ43fznNb6YOxVQdupQu3sbTr5FFXwdhK74fJl0jvb
         eciLddbEjTkpfnvpSmNtkeUy899xl8kuFlza0mCjMLlY6mqMYFafWfL0HXdzY9mmrBbl
         tiYMDiQrKJpSB3DVDSB21zZOwwu+OGmacE6r0lbpRpEmfZUo1aV2LD7kFZYuIORe47QB
         7iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFXpnCRvpVBhsuNFE1ahfBGJsqNDQt8dQxVvfN6MrL0=;
        b=Pk4aFqbqHFxJM4s7fjWgDh/2A56Pbgd7uqPafsCkYc+YREYX+rofmacP899CZnHNpw
         tCavvCU03cURBjJ7shDSXIzbfVsY0L15A2kLBR8okQd141s8/Xyja+x3KgT2YAhOXC38
         q+6gjpJxRPL0DLxrBvwYufDhbGHapX/zcZ2lX9SCtFK1LvGxizGNaIGQ7N/Rvn52wCha
         417ZlrOfUKgDzsr7ZDOdh1eILtCGAevLaOyIK5t20z7k4lh0w4d44TcCJRbR8yXIno8R
         KUsfJCpd5ldiB13AGH1e/krhZcsmAIdjg9KDlr3DDTzke+djVtLIlXQSdDDs1ZxlZ39M
         a2Lg==
X-Gm-Message-State: AJIora+diopr+Nkvc+HhJFbovcYlqqVGen9hytmQZGqtbGeRdC8IqGpF
        yTIORdhemwgh7T2aCDG83IoaonO45W0rjyx5I4I=
X-Google-Smtp-Source: AGRyM1v7QBH+pV6lYrEVLjv5TY6/p8FX2jSroN/uPAnqjFf8QnXVnznfAY6JW5aADd3D+pMmLcYkM8NpE0OLf3DC0nc=
X-Received: by 2002:a05:6512:348f:b0:47f:8b25:e9f9 with SMTP id
 v15-20020a056512348f00b0047f8b25e9f9mr6543451lfr.512.1656008785046; Thu, 23
 Jun 2022 11:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-11-peterwu.pub@gmail.com>
In-Reply-To: <20220623115631.22209-11-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 20:25:48 +0200
Message-ID: <CAHp75VexwvAVeY4MtwKfpNY96eJ1C9eqadd-L+20O2sg2+gYNg@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] iio: adc: mt6370: Add Mediatek MT6370 support
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
        Helge Deller <deller@gmx.de>, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang <cy_huang@richtek.com>,
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
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
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

On Thu, Jun 23, 2022 at 2:00 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> Add Mediatek MT6370 ADC support.

...

> +config MEDIATEK_MT6370_ADC
> +       tristate "Mediatek MT6370 ADC driver"
> +       depends on MFD_MT6370
> +       help
> +         Say yes here to enable Mediatek MT6370 ADC support.
> +
> +         This ADC driver provides 9 channels for system monitoring (charger
> +         current, voltage, and temperature).

What will be the module name?

...

> +#include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>

Usually this goes after linux/* asm/* as it's not so generic.

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/mod_devicetable.h>

I believe the order should be otherwise, this is first followed by module.h.

> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

...

> +#define ADC_CONV_POLLING_TIME          1000

If it's time, add a unit suffix, if it's a counter, make it clear.

...

> +       msleep(ADC_CONV_TIME_US / 1000);

Why define microseconds if milliseconds are in use?

...

> +       ret = regmap_read_poll_timeout(priv->regmap,
> +                                      MT6370_REG_CHG_ADC, reg_val,
> +                                      !(reg_val & MT6370_ADC_START_MASK),
> +                                      ADC_CONV_POLLING_TIME,
> +                                      ADC_CONV_TIME_US * 3);
> +       if (ret) {
> +               if (ret == -ETIMEDOUT)
> +                       dev_err(priv->dev, "Failed to wait ADC conversion\n");

wait for

> +               else
> +                       dev_err(priv->dev,
> +                               "Failed to read ADC register (%d)\n", ret);

Do you really need to differentiate the errors here? I believe the
latter one covers all cases.

> +               goto adc_unlock;
> +       }

...

> +#define MT6370_ADC_CHAN(_idx, _type, _addr, _extra_info) {     \
> +       .type = _type,                                          \
> +       .channel = MT6370_CHAN_##_idx,                          \
> +       .address = _addr,                                       \
> +       .scan_index = MT6370_CHAN_##_idx,                       \
> +       .indexed = 1,                                           \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +                             BIT(IIO_CHAN_INFO_SCALE) |        \
> +                             _extra_info                       \

Leave a comma after the last member as well.

> +}

...

> +       regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!regmap) {

> +               dev_err(&pdev->dev, "Failed to get regmap\n");
> +               return -ENODEV;

return dev_err_probe(...);

> +       }

...

> +       ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to reset ADC\n");
> +               return ret;
> +       }

Ditto.

-- 
With Best Regards,
Andy Shevchenko
