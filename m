Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D36F57FAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiGYIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiGYIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B8A13CE5;
        Mon, 25 Jul 2022 01:00:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b11so19028327eju.10;
        Mon, 25 Jul 2022 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cFBmHW3aWYSVzhv+dCF1Vjg7vV6HTDbULFzKNdh7eA=;
        b=D59brI8ncH+WCdwU0Nfnk9ctLnRDZ3UUdc+xeXG2BjO1rrMZJ0I+JhW0C2WVRsU6I7
         ahgas2HVf3s+Q1M1+toqG4BgdFjA14FX2WipfWZqqPlpU/p57MdP2KZYLh9lAwA5I3P2
         78VXDrlkxZllvMa8g5WSechgcttVRJFweVlLmJ6o0bSzPej2NwYO4DbX/BcfTjOk0y/T
         XpvbkQ4bjio6MMumjuisV+WVTBnLQJzUwpW1vfpHFzzVndm/NE5Ss1d3hZjedpOJXc7m
         LuSKiZVCLZQUmdrfrVkrncRSqXCACm1BmRyqtDh1etSR8scG0DGif8X1+PGv78ob7tYR
         qx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cFBmHW3aWYSVzhv+dCF1Vjg7vV6HTDbULFzKNdh7eA=;
        b=Hjh5zul4oRbNWzqIzxAErdO3BqwqTfX34vdWQs3YlOo7b4Q94WDl5e1KsSjPXuCIxB
         Erlww9mGep7LmlS2hS2VIy2HY7bRsWPTOWJehw9pTO2MJawzhRM4sYQcA98q6vppLqd5
         GfWy46N5YErNcnYf300N5/67ayuZzrl510Oxau4x+bFtn2UL1ctUlu5arPBbj2xgcKLY
         CPPj/RMnk6Cz0/A0nBdAZt6T9yCn3yNttKP2kLg/4pIaIf1OOT40noQjBPf1YgmfGy4h
         Uun4c7ulHdRUxFbTMw/ppNWJcY5cZblw4UtfPIfptdAbr5D+pch7P+ZQcfV7ZtmSKrSB
         e/pA==
X-Gm-Message-State: AJIora+0LwDGmFynA3TgdUbOyp3bOhBAJV/UfsWCwi8L6PpVpyUYyQDO
        M8bU7saQSzIyfef2wQrSzpUHuQV7hp24J7qw2RI=
X-Google-Smtp-Source: AGRyM1unetnhWIzb3en09GsAOIg0xuhKBXgSQV7z/NkK9g6NHIamuCgYKepx6i2vYNKCBrnrnWiAXWzNdcPwAolpJPg=
X-Received: by 2002:a17:907:75da:b0:72b:3ce0:2524 with SMTP id
 jl26-20020a17090775da00b0072b3ce02524mr9140700ejc.394.1658735999558; Mon, 25
 Jul 2022 00:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-8-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-8-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 09:59:23 +0200
Message-ID: <CAHp75VfiKMROzxeEaCH6qCthK9qanJPqbjADLMVH-V0upKf+9Q@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] mfd: mt6370: Add MediaTek MT6370 support
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

On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This adds support for the MediaTek MT6370 SubPMIC. MediaTek MT6370 is a
> SubPMIC consisting of a single cell battery charger with ADC monitoring,
> RGB LEDs, dual channel flashlight, WLED backlight driver, display bias
> voltage supply, one general purpose LDO, and the USB Type-C & PD controller
> complies with the latest USB Type-C and PD standards.

...

> +#define MT6370_REG_DEV_INFO    0x100
> +#define MT6370_REG_CHG_IRQ1    0x1C0
> +#define MT6370_REG_CHG_MASK1   0x1E0
> +
> +#define MT6370_VENID_MASK      GENMASK(7, 4)
> +
> +#define MT6370_NUM_IRQREGS     16
> +#define MT6370_USBC_I2CADDR    0x4E

> +#define MT6370_REG_ADDRLEN     2
> +#define MT6370_REG_MAXADDR     0x1FF

These two more logically to have near to other _REG_* definitions above.

-- 
With Best Regards,
Andy Shevchenko
