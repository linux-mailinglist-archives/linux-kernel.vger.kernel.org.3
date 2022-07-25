Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92C57FC05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiGYJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiGYJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:08:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB310555;
        Mon, 25 Jul 2022 02:08:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z22so13034036edd.6;
        Mon, 25 Jul 2022 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKEZcZKyJPxnUIHg9vM+IkXxZdZ8ejobr3a6ltkwgqg=;
        b=SF+aqs+EVnbsbKQkA/8xNH4ehlnunss9fmN5U1pnRWAD2EMIQ+vnoZbzG36K5peZlX
         CXhER1ViMJa80xFPZtY843nWQs5F1BNT454kUiXwBosjz4IYFjnLaJailn/bPKEmOYYj
         OQZu//AWglB0ze0HUO1SQYsIXOFhVkCy9Y+HPByleJg8LXsl2myXUq38a43P555UG4Bx
         W4w40So2uuPYw5I5cWqSTLAX8vR149Ik4ff+qJQus9SdkPcCLkZ3D5xoOpeLQVKUQZ8Y
         zppNE2E5jRpSRhv5vq/EJEOVqtSyTp9xfxGx+C2GzeLpQ8Hqwv5+/dQLpC89uzdBr14a
         kbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKEZcZKyJPxnUIHg9vM+IkXxZdZ8ejobr3a6ltkwgqg=;
        b=WMP0r+Teh2HRAGcBZqzf9+ZXiWOTXBwm4NQZLWVE/qZNeqLyBOMCWslXcLHqQgjG7/
         UYvUr5X0LE+IYvOlM74OSmJiPwCqzJiEUEybDBZlRCmJm8pN1uvWyzZABrYrRxq72GJd
         nqyifhDDvTZJA/aBy4bAVnLS4/GzviEh5ImuG6oOh7Rl25vZm9c76T9h6juw9CqE74Fl
         s6Ze30Wwgwp0Bwr30LaA/wTAy9JkgtChBqEY04VJMxupeb+DDOQkikZimfho2d0giW4N
         wzEYPG3KWCFrREVI/4QSH9Jv6hYQ9jiP+Wat2B7DesHKKdoDSfqGxR/Mx7W3H27LHQJr
         8SVg==
X-Gm-Message-State: AJIora/LO3rc3m1iZ8cuNX07+tV846xIITdFMWo11PwhtbavJrStdhUL
        RVnzydnp8AC0eBmvnAN8/hg3bX8HS0G9Iei7Hag=
X-Google-Smtp-Source: AGRyM1v5JqoLA7zG3OW50lchaZUo0NzhFJOo3SiC7x0i5Bb09pqP2OvkrfyBcnIJEGb6N4UIi+1F3CYnjToz5WfvfBA=
X-Received: by 2002:a05:6402:50c9:b0:43c:163a:4d5f with SMTP id
 h9-20020a05640250c900b0043c163a4d5fmr1821081edb.386.1658740092120; Mon, 25
 Jul 2022 02:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-14-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-14-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 11:07:35 +0200
Message-ID: <CAHp75VfxeRR7BzOWwfNSo+x3JZcH37ogR+ZbapTAWrCYkr+FUg@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] video: backlight: mt6370: Add MediaTek MT6370 support
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
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> This adds support for MediaTek MT6370 Backlight driver. It's commonly used

Read Submitting Patches, please!

(In this case, find "This patch" in the above mentioned document, read
and act accordingly)

> to drive the display WLED. There are 4 channels inside, and each channel
> supports up to 30mA of current capability with 2048 current steps in
> exponential or linear mapping curves.

...

> +               brightness_val[1] = (brightness - 1) >> fls(MT6370_BL_DIM2_MASK);


(see below)

...

> +               /*
> +                * To make MT6372 using 14 bits to control the brightness
> +                * backward compatible with 11 bits brightness control
> +                * (like MT6370 and MT6371 do), we left shift the value
> +                * and pad with 1 to remaining bits. Hence, the MT6372's

to the remaining

> +                * backlight brightness will be almost the same as MT6370's
> +                * and MT6371's.
> +                */
> +               if (priv->vid_type == MT6370_VID_6372) {
> +                       brightness_val[0] <<= MT6370_BL_DIM2_6372_SHIFT;
> +                       brightness_val[0] |= MT6370_BL_DUMMY_6372_MASK;
> +               }

Nice! Why not...

...

> +       gpiod_set_value(priv->enable_gpio, brightness ? 1 : 0);

!!brightness will do as well.

...

> +       brightness = brightness_val[1] << fls(MT6370_BL_DIM2_MASK);

> +               val |= prop_val << (ffs(MT6370_BL_PWM_HYS_SEL_MASK) - 1);

> +               val |= ovp_uV << (ffs(MT6370_BL_OVP_SEL_MASK) - 1);

> +               val |= ocp_uA << (ffs(MT6370_BL_OC_SEL_MASK) - 1);

> +       val = prop_val << (ffs(MT6370_BL_CH_MASK) - 1);

...to use respective _SHIFTs in all these?

...

> +       priv->enable_gpio = devm_gpiod_get_optional(dev, "enable",
> +                                                   GPIOD_OUT_HIGH);
> +       if (IS_ERR(priv->enable_gpio))
> +               dev_err(dev, "Failed to get 'enable' gpio\n");

What does this mean? Shouldn't be

  return dev_err_probe()?

-- 
With Best Regards,
Andy Shevchenko
