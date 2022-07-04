Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55585565ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiGDVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:14:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343A62FA;
        Mon,  4 Jul 2022 14:14:41 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31c89653790so40660287b3.13;
        Mon, 04 Jul 2022 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpdquBLgwxS+q6MF90ETAqdi+gZ5jGI/bw3VMe7+rpM=;
        b=pisWhvytYZKcu+6yG4fRYH2VSnfWPvpTWA+gGM2H9VsDnz1Nib2CFiFmg3pHrwfMLA
         jDwEDffpRMjn8/A+wioAF9Cq2+qv8EhBQqcsEuO3EMmu14Zw8HGGpmsNHlSX+BjaPIYz
         v9swYPqNcfcEpwpvhj9RHrNU7Kr3NnRhPDvVKnrmzZYXLtriCDIeXN+U0W9ia0fF5mRC
         Fs4O7JBhbxC04sxj2Jq4uzhG+waPhMmluTQCcYWdp949oDqMk74B2o8JYRErDbJgojw7
         iC21Q1WweofBJD8188y54cG3nP/c8Wr4aV16mZq9v2Xdu0smJbbPholxpaf2ZKiPz9cp
         KVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpdquBLgwxS+q6MF90ETAqdi+gZ5jGI/bw3VMe7+rpM=;
        b=VOl4e269lOWlr8ReE/y+0/TNbofjzf/XbFLlXiaFvOh1IOv7iuq3dgBgJhHMN5mhp4
         o2Z9FDufcebfwGpLgySdDrNs19o55/aTgkUFEJaf/EtUdXF8lN+SDiG33s/g/nGxbpdA
         O5Dqkqs4QV4nCCyeENUrJEm7uh4sKQbCD2xIcgfaTrWbZHmXtP1fLL31YM4i1KVrKEWZ
         P3Lk6XZTkPzuxICIvOJtYxANy99YSgIFnRklAE7KHc/hRhcbXA5pstg1GGkvBb4+z91b
         AAuaaanuTqOdDZ8G0xzgnZqyeRCenzQ54XOuJyeSNfjMEPLVlKy4qryMN4OJTUkEwwkH
         ygWg==
X-Gm-Message-State: AJIora8LKbIj+8itcSIP4P+LD7CIA8BxDgqK2ryIaJaigHOh4P/yBwvZ
        xJqf13Amg6j7XxVeH3d5D9IeKtzAGO3CThyU2fo=
X-Google-Smtp-Source: AGRyM1vYxguLbsBOzRTVw1vvx756PgfmGkkRGrCT+1/7YzT9o6SbOC3eiybdUymDSM+qqhALtY73LfI5pY/jFLAqsJ8=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr34256097ywa.277.1656969280331; Mon, 04
 Jul 2022 14:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-14-peterwu.pub@gmail.com>
In-Reply-To: <20220704053901.728-14-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:14:03 +0200
Message-ID: <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] video: backlight: mt6370: Add Mediatek MT6370 support
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
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
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

On Mon, Jul 4, 2022 at 7:43 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> Add Mediatek MT6370 Backlight support.

...

> +         This driver can also be built as a module. If so the module

If so,

> +         will be called "mt6370-backlight.ko".

No ".ko" part.

...

> +#include <linux/gpio/driver.h>

Can you elaborate on this?

> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Can you elaborate on this?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

Missed mod_devicetable.h.

...

> +               brightness_val[0] = (brightness - 1) & MT6370_BL_DIM2_MASK;
> +               brightness_val[1] = (brightness - 1)
> +                                   >> fls(MT6370_BL_DIM2_MASK);

Bad indentation. One line?

...

> +       if (priv->enable_gpio)

Dup check.

> +               gpiod_set_value(priv->enable_gpio, brightness ? 1 : 0);

...

> +       brightness = brightness_val[1] << fls(MT6370_BL_DIM2_MASK);
> +       brightness += (brightness_val[0] & MT6370_BL_DIM2_MASK);

Too many parentheses.

...

> +               /*
> +                * prop_val =  1      -->  1 steps --> 0x00
> +                * prop_val =  2 ~  4 -->  4 steps --> 0x01
> +                * prop_val =  5 ~ 16 --> 16 steps --> 0x10
> +                * prop_val = 17 ~ 64 --> 64 steps --> 0x11
> +                */
> +               prop_val = (ilog2(roundup_pow_of_two(prop_val)) + 1) >> 1;

Isn't something closer to get_order() or fls()?

...

> +       props->max_brightness = min_t(u32, brightness,
> +                                     MT6370_BL_MAX_BRIGHTNESS);

One line?

...

> +       val = 0;

Do you need this here?

> +       prop_val = 0;

Useless.

> +       ret = device_property_read_u8(dev, "mediatek,bled-channel-use",
> +                                     &prop_val);
> +       if (ret) {
> +               dev_err(dev, "mediatek,bled-channel-use DT property missing\n");
> +               return ret;
> +       }
> +
> +       if (!prop_val || prop_val > MT6370_BL_MAX_CH) {
> +               dev_err(dev,
> +                       "No channel specified or over than upper bound (%d)\n",
> +                       prop_val);
> +               return -EINVAL;
> +       }

...

> +static int mt6370_bl_probe(struct platform_device *pdev)
> +{
> +       struct mt6370_priv *priv;
> +       struct backlight_properties props = {
> +               .type = BACKLIGHT_RAW,
> +               .scale = BACKLIGHT_SCALE_LINEAR,
> +       };
> +       int ret;

  struct device *dev = &pdev->dev;

will save you a few LoCs.

-- 
With Best Regards,
Andy Shevchenko
