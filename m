Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4153A139
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbiFAJtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351500AbiFAJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:49:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE55FF2D;
        Wed,  1 Jun 2022 02:49:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so2589267eja.8;
        Wed, 01 Jun 2022 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27PUTNb2UH1CaFlaB6o+qtISHhMqVYpnRcYCFuMiVv4=;
        b=RLZe4nVv/Ic2Sv7cEK7VnKNh8dqoPXLpxnLc7UHjGVmmaOPOdprU9K/lDH3Kr6SBBs
         6QDIiqyi6WSTTNbbOkaJZQxy8YW00WXStF0ZngoQO8N9wcquuUTE85nb3APbRA0XivHe
         pRiLCDAis4jbIvybxugAxhkZlTL8NK/7VRcrLnDf0uEQG2evVEh8fmhzHI46goYAy/Rj
         q8Bbbjx+gKvOdjejX68tjSajQP70rVeZpFFv49Ib8lN+kErMrJya6+9vsV7cGjxOYuDc
         3XgnvxTdqukRyUlMaSwf9b5Yn8Xatlmpk1zSwUk3glp21S87SI0Q0DdcTQbIgVdEgv4s
         sXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27PUTNb2UH1CaFlaB6o+qtISHhMqVYpnRcYCFuMiVv4=;
        b=1C2x9Xdwy4Bs1peBFTJh47LRDOmAW7RdTOTF00nUKHQHyTwO2x1ywzNNOfLt35eSZp
         QjoGnRBdlIxHJvXGYdTl5RayGjXsne7RthNEYtPlHcVwc82/A+0VsdlZH5Osof6jly0b
         CJ1vqbEZOZ2EG4BzVgsxQuJDGkmn9b42Q0xZuAXT5T0Pw50ZY1PpQBy0qdvM2oK3jtTA
         MV2LxuAne6Ws5zObDmjeR5oGQRFlzPch9Npm5Mv+9ew/XiEA62UDnFyEXZxZbDHUL4o1
         fSyQRxnr49TGwVGaHuLJ0EcDMD31HJpeSfyV3ikbKuZAfbIUXTNO2UgBYszmYwBEsvLo
         V9Qw==
X-Gm-Message-State: AOAM530s4pfkYNdTuSt7i4dm/7TsXS8Np5KB77YWsPGd90gYbwrgweoA
        A0hGavHcYgZGCWDAVAOQYZU9aZKWYrHn2/mNXFM=
X-Google-Smtp-Source: ABdhPJyRwbLQFMmfl3jzbmPNjvUrFSOgiS+i5wMk8MNJphpsSnNZ8UtMTX/OTZ0ronnNTUPtL2vf7d9XmnEYugvrfuk=
X-Received: by 2002:a17:907:6e1a:b0:6fe:f357:3837 with SMTP id
 sd26-20020a1709076e1a00b006fef3573837mr40896205ejc.44.1654076974098; Wed, 01
 Jun 2022 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-7-peterwu.pub@gmail.com>
In-Reply-To: <20220531102809.11976-7-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 11:48:58 +0200
Message-ID: <CAHp75Vd8taco19vsDmBcCv8euV1SvwSiY5=P9oMkA6zWsjwXxg@mail.gmail.com>
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

On Tue, May 31, 2022 at 1:16 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: Alice Chen <alice_chen@richtek.com>

All below comments are applicable to the rest of the series as well
(one way or another), so please fix all your patches where it's
appropriate.

>
> Add Mediatek MT6370 Indicator support

What indicator?
Please also keep attention on English punctuation (missed period).

...

> +       help
> +         Support 4 channels and reg/pwm/breath mode.
> +         Isink4 can also use as a CHG_VIN power good Indicator.

be used

> +         Say Y here to enable support for
> +         MT6370_RGB_LED device.

...

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>

> +#include <linux/of.h>

Are you sure this is the correct header? Seems you need
mod_devicetable.h instead.

> +#include <linux/property.h>
> +#include <linux/regmap.h>

...

> +struct mt6370_priv {
> +       struct mutex lock;

Do you use regmap locking?

> +       struct device *dev;

> +       struct regmap *regmap;

> +       struct regmap_field *fields[F_MAX_FIELDS];
> +       const struct reg_field *reg_fields;
> +       const struct linear_range *ranges;
> +       struct reg_cfg *reg_cfgs;
> +       unsigned int leds_count;
> +       unsigned int leds_active;
> +       bool is_mt6372;
> +       struct mt6370_led leds[];
> +};

...

> +static const unsigned int common_tfreqs[] = {
> +       10000, 5000, 2000, 1000, 500, 200, 5, 1

Leave a comma at the end.

> +};
> +
> +static const unsigned int mt6372_tfreqs[] = {
> +       8000, 4000, 2000, 1000, 500, 250, 8, 4

Ditto.

> +};


-- 
With Best Regards,
Andy Shevchenko
