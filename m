Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E958AB5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiHENK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHENKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:10:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF9F74;
        Fri,  5 Aug 2022 06:10:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 17so1779884qky.8;
        Fri, 05 Aug 2022 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9J24cDKKqsOduTS9UUyGj2I+dc2JXq9COm3ho1bp/NE=;
        b=NZ/lhCyR9M4uoWmE11gXdKIY5QHCgnKHevuKo4TMG1DjXmtxuHL9IGeJwZ4LfPJ5Sx
         An9X10WyEwlH6gobWrRkcQrihAvfFo/NEkJHppMNCjVysFpqBcUQppBPmmWv/gJlRwNJ
         AJ5R5hBz/6Z6zt3zcMCzNBlOWAFcgddiIbDO26176idaVxtdAeLEwOB83fyRhNgFshT0
         PgEvwdsJAJBc7N5GmC3tSOdTGVFK5PY33vJvxUo6aKPI13T8ZPWktLxzYyY8DyD7/CRd
         N6n68KF39/cpPvRO/LCj/Zk8AkuXDm7CeFfWTupOMgC5Oh24O5OoP7ydY1qxP317WUAG
         zV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9J24cDKKqsOduTS9UUyGj2I+dc2JXq9COm3ho1bp/NE=;
        b=imnwJFAhn0BzI6QmhPhz1U4EMSdkH2oU/MKgzSijN8NrAZvqPsT3SmYCIPaydWTw+W
         C+GMV4zm+HDbL8yAK3bSXfIH9oCI0N8yLoDGYmil4Wz8nyLAwgQdvPUp0jcy4bCGFVWn
         M/eCqLghhNqljBSHXy4itcoo9c0RP1CgGUlmLphYsDdQO4cXNKhwpaQGabHvlwHAeyBx
         nqUHJQV6SGlz35n7NIvlJDDRfxc7pUPy/trsCkmVsxROIUbJKLs1Ry6Rd7oQCbRkWj7I
         Sv5ATnTjtpPvfwg466Lk7ZGrOlpkE6+NswsjwEE5nYft3EmyxTiMBW2yWaYvaslAAtR2
         jlrw==
X-Gm-Message-State: ACgBeo0lApKLBx6Q3ehTsBJXbCCufPGZVxhm/wC5XpLUsJG5WoMhWrea
        UYfQFHa2ttEgoUSEE/4r8eEwjRgXfaslLWLEAcI=
X-Google-Smtp-Source: AA6agR6KCeqnEoqyKUTU9bwzHJxmJAXoC1uA/8jBqjS4KNKKgC3bBRK/UzGUzHpzrq29/PrSFNdU8y5czcT3jzWXnGE=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr5054205qko.383.1659705015729; Fri, 05
 Aug 2022 06:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220805070610.3516-1-peterwu.pub@gmail.com> <20220805070610.3516-13-peterwu.pub@gmail.com>
In-Reply-To: <20220805070610.3516-13-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 15:09:39 +0200
Message-ID: <CAHp75VcdU6AVdksuhsHkzvD6mOBJ6G=yrmuHA9zAXLroXDFAjg@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] leds: flash: mt6370: Add MediaTek MT6370
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

On Fri, Aug 5, 2022 at 9:07 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: Alice Chen <alice_chen@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> Add a support for the MT6370 Flash LED driver. Flash LED in MT6370
> has 2 channels and support torch/strobe mode.

Same comments as per previous LED related patch.

...

> +       /*
> +        * For the flash to turn on/off, we need to wait HW ramping up/down time
> +        * 5ms/500us to prevent the unexpected problem.
> +        */
> +       if (!priv->fled_strobe_used && curr)
> +               usleep_range(5000, 6000);
> +       else if (priv->fled_strobe_used && !curr)
> +               usleep_range(500, 600);

Now it's much better!

...

> +       /*
> +        * Always configure as min level when off to
> +        * prevent flash current spike

/*
 * You need to check the style
 * of multi-line comments like
 * this one.
 */

> +        */

-- 
With Best Regards,
Andy Shevchenko
