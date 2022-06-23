Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD7558876
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiFWTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiFWTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:14:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CF12DFD0;
        Thu, 23 Jun 2022 11:19:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g4so356826lfv.9;
        Thu, 23 Jun 2022 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBMGPYDRnJPeUwS8rUCcWoIIaqQNv7Xsce74kY6zINI=;
        b=BJrh0YPvvBPOk2FgsQMFRa2Mypjcm71ylJrq31IKtpANvhN4g8KLB7ntFQNq9IZHVF
         l6ZhSU+TlBFMgNnWeh7Eoj5Ib1pOugR8/ndpuPy4VRRMJ6LnlT4CTMEzgfF4vBExrKon
         Wo9h20LnpfRWOTcCAHW7Udyx6kQ1lpY2Hv/XvCOnPkvGMJrQAMlcIYbPHW/+QvkLPw/v
         z1lAydtVEKdwcueGxWsSL7la7BCLCRYzBxgeXh32PNyM7jHQtn8jXHCrjG/yF8ym1dip
         s0nAMXw5V2WlQuo+mpIp+OLG/gu7Zn8xLGMejPmMkd4+e9tWrl/+j7x7jETixBbgqiPc
         vqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBMGPYDRnJPeUwS8rUCcWoIIaqQNv7Xsce74kY6zINI=;
        b=Ue2r3xF3o0KXHOfJTftBD4o3wQMBh8KkmBqL3wIkeaAYXm7ePIW+jvu1L9wq+gj1jl
         Dn5AFpw55KyoG45u6oJkoaD6VlvVJeiOoShtubQylAmTlHIeSl+gBO+4M11qg27o7gs0
         4VE8dgXPGA+RnbBYYp7tfrOkM5NU3uOlgGoXHBG6CNBEJCI4uGss++6e7gv12J+AA39W
         K4IMzZCl+mevraQzSQ0RX9unwRRdCVRTn4Secio5BlcCG6bBEq2By3ILsqMQ5WToQmSk
         U7RNcNkimIzONc0tlK3Gyd/H675C4XKK8Y72S2rg0yhLIVxjjkxUp8FzH6MMWecXcYLs
         Exzw==
X-Gm-Message-State: AJIora/r44fbBqK6qGkonXdGXuOx/sBd1qykvz8WWfFKy/QWrnzwsGAz
        A9jDcxZz+x2ispyKzheGT4UM2jhgv03a05t/Aew=
X-Google-Smtp-Source: AGRyM1sSt9RqJEWu2voYn8rYod2JWrA9S0VKzO5KainJy6NBR3RGPl9JAy9lFNfNLGcH9lioXFXtCJIfjWl2wSCUbcc=
X-Received: by 2002:a05:6512:151f:b0:47d:dd0c:1d1c with SMTP id
 bq31-20020a056512151f00b0047ddd0c1d1cmr6036883lfb.207.1656008372915; Thu, 23
 Jun 2022 11:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-10-peterwu.pub@gmail.com>
In-Reply-To: <20220623115631.22209-10-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 20:18:56 +0200
Message-ID: <CAHp75VdgxR9aFQmi_MPrX=t7RMnKDiLAwWMvxbpW9OoQMJkKyw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] regulator: mt6370: Add mt6370 DisplayBias and
 VibLDO support
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
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add mt6370 DisplayBias and VibLDO support.

...

> +#include <linux/bits.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Any users of this? (See below)

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>

...

> +#define MT6370_LDO_MINUV       1600000
> +#define MT6370_LDO_STPUV       200000
> +#define MT6370_LDO_N_VOLT      13
> +#define MT6370_DBVBOOST_MINUV  4000000
> +#define MT6370_DBVBOOST_STPUV  50000
> +#define MT6370_DBVBOOST_N_VOLT 45
> +#define MT6370_DBVOUT_MINUV    4000000
> +#define MT6370_DBVOUT_STPUV    50000
> +#define MT6370_DBVOUT_N_VOLT   41

If UV is a unit suffix, make it _UV.

...

> +               .of_match = of_match_ptr("dsvbst"),

Would it even be called / used if CONFIG_OF=n?

...

> +               .regulators_node = of_match_ptr("regulators"),

Ditto.

...

> +       for (i = 0; i < ARRAY_SIZE(mt6370_irqs); i++) {
> +               irq = platform_get_irq_byname(pdev, mt6370_irqs[i].name);
> +
> +               rdev = priv->rdev[mt6370_irqs[i].rid];
> +
> +               ret = devm_request_threaded_irq(priv->dev, irq, NULL,
> +                                               mt6370_irqs[i].handler, 0,
> +                                               mt6370_irqs[i].name, rdev);
> +               if (ret) {

> +                       dev_err(priv->dev,
> +                               "Failed to register (%d) interrupt\n", i);
> +                       return ret;

return dev_err_probe(...); ?

> +               }
> +       }

...

> +       for (i = 0; i < MT6370_MAX_IDX; i++) {
> +               rdev = devm_regulator_register(priv->dev,
> +                                              mt6370_regulator_descs + i,
> +                                              &cfg);
> +               if (IS_ERR(rdev)) {

> +                       dev_err(priv->dev,
> +                               "Failed to register (%d) regulator\n", i);
> +                       return PTR_ERR(rdev);

return dev_err_probe(...); ?

> +               }
> +
> +               priv->rdev[i] = rdev;
> +       }

...

> +       if (!priv->regmap) {
> +               dev_err(&pdev->dev, "Failed to init regmap\n");
> +               return -ENODEV;
> +       }

return dev_err_probe(...);

-- 
With Best Regards,
Andy Shevchenko
