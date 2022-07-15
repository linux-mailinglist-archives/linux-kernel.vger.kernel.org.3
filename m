Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA25762A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiGONTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:18:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89EC10FE2;
        Fri, 15 Jul 2022 06:18:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f73so8362859yba.10;
        Fri, 15 Jul 2022 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIDFbj9Nm/Hc84YphLe1TSejCss5csMsL3XGmdeREuc=;
        b=LjTUeU/VvjExiFE7qVdoTT66INknzaksBvLAL0QX/hhMGm1S/DCmWjGAqEm1RDjTt0
         nrI4wHZo/WK5aG8U5fIPVbESm+g18hEELTujXpx69+Azj8qnUnYXhFafWvDdYrxJWF8Q
         n4alCS65LacwduwaUDBvHdbTO5eZ4k4tWaJ199RDLEdi+Nnbu8tJ4UTjcA2YPJBeHBKH
         hWc3HEBwkV0/ygom4+Ivyr3ViE5siRsP8CdzKAgWRXLBXaArht7DgMtJUJb/WrGYsYt8
         eWv+sETgNCGjxIJCtjEQJk1vVPGobtuRYELM3bihPsOKaqDcf5qzy1Ry+AVMll6TrQxi
         eYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIDFbj9Nm/Hc84YphLe1TSejCss5csMsL3XGmdeREuc=;
        b=VxgiEGoFQGUYqSko+lJKnHxVGH2zZsKKIQ9+fWl5TxvFC5y30oyYNFiJiWM7qvcf/8
         wgwp1K8xIJJaXJdX9tCKzsfm3phCcmJ8mn4KJgVmLKfgUaW8scedC4sDAnZLKvPa605J
         Xuf6pJD58ZF1Uq0SiLTwAMC41+W9qucdY3imNc1goVEWJk+yv7ELXTuqzLpXctX4h627
         6Lx5ATaLA/TKD/lMhN21bMGyH1IWyg+s8bol5BjNho6iSX3WeTGJRDKyemoCfAUju24d
         SL+yk0pm9MaL8GAym0K3eMQjngBLoyRpIHnFKRNOiBj0VfNEQ/UeeZcjFVYKEv9XfV9g
         UJGw==
X-Gm-Message-State: AJIora8ahXY1qyFHIc3AhbqzjH9ZZJ6SH3aoUgptYOIiV2Qf7yH0i2ZL
        +DxNEioZC3N5G67lqSRU5M1RnxHjoBI+bES87pM=
X-Google-Smtp-Source: AGRyM1tX0Yj4hhKwKn8Wh56LVxsUs+zEZtzzOqfyiqtoMPojzsjlQH4dKqby9pg3kc6AYzvHnWHIojiIQybijv0fZ+I=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr14089485ybg.460.1657891133149; Fri, 15
 Jul 2022 06:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-10-peterwu.pub@gmail.com>
In-Reply-To: <20220715112607.591-10-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 15:18:16 +0200
Message-ID: <CAHp75VfiBcaSbZy67Puwb2pBW2MHN8iQj3upA=h3VkKSFJbs0g@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] iio: adc: mt6370: Add MediaTek MT6370 support
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 1:28 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> This adds support the MT6370 ADC driver for system monitoring, including

This adds --> Add a

> charger current, voltage, and temperature.

...

> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>

...

> +#define MT6370_AICR_400MA              0x6
> +#define MT6370_ICHG_500MA              0x4
> +#define MT6370_ICHG_900MA              0x8

_mA ?

...

> +       ret = regmap_read_poll_timeout(priv->regmap,
> +                                      MT6370_REG_CHG_ADC, reg_val,
> +                                      !(reg_val & MT6370_ADC_START_MASK),
> +                                      ADC_CONV_POLLING_TIME_US,
> +                                      ADC_CONV_TIME_MS * 1000 * 3);

1000 --> MILLI ?

...

> +static int mt6370_adc_probe(struct platform_device *pdev)
> +{

Given comment in one place in the entire series would be good to use
in another where appropriate. For example, here it would also be nice
to have a temporary variable

  struct device *dev = &pdev->dev;

It will shorten some lines.

> +       struct mt6370_adc_data *priv;
> +       struct iio_dev *indio_dev;
> +       struct regmap *regmap;
> +       int ret;

> +}

-- 
With Best Regards,
Andy Shevchenko
