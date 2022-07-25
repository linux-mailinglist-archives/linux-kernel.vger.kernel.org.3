Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5057FAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiGYIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGYIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:10:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810C12AEE;
        Mon, 25 Jul 2022 01:10:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so19046220ejc.11;
        Mon, 25 Jul 2022 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXb71uFWhSg39Viv30HgP3y8LahJOu5TtvkjW1YFFmA=;
        b=gcXWANYd95QqpDZNjT80H5El43Dovr5S0wOb+dj41WF0UAkuUiJDW2NAi4iQ305XFQ
         lVVKY0C+iGL0p5tVBSniVcX6zLS8O0o42jiM3VHbf3P2PJwPJY9pNrOD5I3tyZyDgnJy
         d6DIH0u/YAoFuSujbvAgci/gyOOkxjcOa7FgLYcccmWOMRReiJpRQvj8oeNjtzasRz45
         5wI5mC7zC/KC/unitlCB9w7h7MNbq7bWUvDLO3UqaeZF52Xc40wDLTHrTN6lnrUtKqrq
         8MOcmmfgBfz1xp4MxADiih/qQe4qXT1ndVyvX9sozOvgmH8wWtATEk7QsOTuHRb8u2m9
         CtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXb71uFWhSg39Viv30HgP3y8LahJOu5TtvkjW1YFFmA=;
        b=uWgH9ODpJl474r6KXjDEVNXMUIHKloUQesa+lpBvT9gfOrkrn0B+T3Q27vJlXtAp6n
         BPfGm52m+sV1famrqspkfZ7wrm4qb/4sKirOIRDddEA8QS/xQVQpYlGa89BlTHd1uKMD
         Ck59W7FY5dNqH6PdXqV3HwVF/PUZ3yzQQieTe49Qgp9zXGMdn9Sm66PCxdFxD3R/R/im
         JScxwgVaEUwGKIZSnhKJnKNP77YBL34/WNvYTpc9Gjpdy7MGJF+1rqWs5oaF6AARAIJg
         qZmXxWh8VOYsaA4GXxStws3zYP/Kup9GHQEuD0Og3t0rkF9Y+4wcrAJhv/a1Hnxf+n0Z
         rTJQ==
X-Gm-Message-State: AJIora+PUM1iINCw3DM2vR7Zb7pJqaBygXJVElTCUVE8D8BtT0aI3K+k
        jJIFfO0a5yc/OUllci9531HytHQLoWAUEgtAr8Q=
X-Google-Smtp-Source: AGRyM1vadWdzYb+xBUWIOSQf30AXu6Fkj1TEEjh0wt407LPyY4IeBvhlCzY8/E5xfgCj1T+lP6Op+S0BRvRPn0GRG+I=
X-Received: by 2002:a17:906:9b09:b0:72b:9612:d373 with SMTP id
 eo9-20020a1709069b0900b0072b9612d373mr8927348ejc.606.1658736649264; Mon, 25
 Jul 2022 01:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-10-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-10-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:10:12 +0200
Message-ID: <CAHp75VfRZvYA3HJg=LAxXxu26aLSwRGQaED19Bg2d+dZw3RPfw@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] iio: adc: mt6370: Add MediaTek MT6370 support
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
        szuni chen <szunichen@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> Add a support the MT6370 ADC driver for system monitoring, including

support for the

> charger current, voltage, and temperature.

...

> +#define MT6370_AICR_400_mA             0x6
> +#define MT6370_ICHG_500_mA             0x4
> +#define MT6370_ICHG_900_mA             0x8

^^^^ (Note this and read below)

...

> +               reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
> +               if (reg_val < MT6370_AICR_400_mA)
> +                       *val1 = 3350;
> +               else
> +                       *val1 = 5000;

Here...

...

> +               if (reg_val < MT6370_ICHG_500_mA)
> +                       *val1 = 2375;
> +               else if (reg_val >= MT6370_ICHG_500_mA &&
> +                        reg_val < MT6370_ICHG_900_mA)
> +                       *val1 = 2680;
> +               else
> +                       *val1 = 5000;

...and especially here it is so counterintuitive to have an if-else
chain because the values are not ordered by semantic meaning.

What if the new standard/hardware decides to use 0x7 for 100mA (hypothetically)?

So, please use switch cases or other robust methods.

-- 
With Best Regards,
Andy Shevchenko
