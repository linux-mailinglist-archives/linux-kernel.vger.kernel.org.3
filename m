Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEFC57FB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiGYIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiGYIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:41:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9E9FC2;
        Mon, 25 Jul 2022 01:41:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e15so12973863edj.2;
        Mon, 25 Jul 2022 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdipHJQcUj266PLPEbEmcprZ34Syq9EbeJ0nWcxYTz4=;
        b=ABfKDB+hF3n9Vc4uXcJH/wxowVuuZXANQHezQzdWr5Ngsh/idO85i0Q+mD/KzM+CSB
         JRG1GVu0xs6ZoCw7wBbOa5FdTc5eWvaqw+UVN9SHdJEHFfzbRmgkEdix6DCMyHAi1FCr
         JAr6axiQmtyvfzbVJQU1yILv+fNOSMc4pdNm12H0yVakxITFMYusQqnWis60Xho8AsGP
         L+ODp9hB0BQ9UuYk5DfBPx3HnH1fkimsB44PQM+VpR5aT9SXUllZ5JiUeNza+o1o5KiL
         NcV0q9dJ/h5dX9Q0H/4tQoS8YRcvn0AIT770BeqYm2Um/2gYOKrCHjcAMx/p6BEsJKeg
         en4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdipHJQcUj266PLPEbEmcprZ34Syq9EbeJ0nWcxYTz4=;
        b=ixh1b8iIDmOL4ouTOSiuJP8zgseJsF3SUOmBEzmwwM+ZhUBlJDSeQRzjiVxyuvoYLN
         CNE7xxwG4zMOI1GAPJMVE1RdGfFBy+0iBRQh+sDrAN4wslBlNVMUOxJAPd7Hr9s5FWwW
         Fj1ScAaJ1b1igAre5sSgUo11dNF/Jmt52Gf+ic/kGzp2u9Oh6/p8x8iHgXvs5v3HlXHx
         adYXASIoLtuVwyGcn9EolO2iODRYHFDPQeAnxdoWalQYkN/EgnL663uaO4DCz2hxZhcs
         5LzIHsC/xZrKUQZGCS4bR8jcqxtk+yzA3o9UcrFjd2UgPgLEaDpAxWw5IldPEDcQrKjp
         iRpQ==
X-Gm-Message-State: AJIora8nUJu4IFtQQ9/ihcPXFJWCBIRP/1w9p/GT8QfnnUKj/OHL8OaI
        97DFcM70TcjrPlgj53eN5p457QSMfGp/Ve9fbP0=
X-Google-Smtp-Source: AGRyM1uGDvTB0F/h0jI2/Ct5fK7yQVedUikOG6t/KbrLBDyp6j54RIAxbhLcpZDExQEJMEzhAem3RNohcfKc/MXfF0k=
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id
 w5-20020a05640234c500b0043a8f90e643mr11897371edc.88.1658738469088; Mon, 25
 Jul 2022 01:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-12-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-12-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:40:32 +0200
Message-ID: <CAHp75VewxvEDGoPdRBvLSLQOQ6OZzVft1ce3DkF7MK_O1VXZkQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
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

^^^^ (Note this and read below)

>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> In MediaTek MT6370, there are four channel current-sink RGB LEDs that
> support hardware pattern for constant current, PWM, and breath mode.
> Isink4 channel can also be used as a CHG_VIN power good indicator.

> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

In conjunction with above what SoB of Alice means?

You really need to take your time and (re-)read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.

...

> + * Author: Alice Chen <alice_chen@richtek.com>
> + * Author: ChiYuan Huang <cy_huang@richtek.com>

Would
 * Authors:
 *    Name_of_Author 1
 *    Name_of_Author 2

work for you?

...

> +struct mt6370_led {
> +       union {
> +               struct led_classdev isink;
> +               struct led_classdev_mc mc;
> +       };

Where is the field that makes union work?

> +       struct mt6370_priv *priv;
> +       u32 default_state;
> +       u32 index;
> +};

...

> +static int mt6370_gen_breath_pattern(struct mt6370_priv *priv,
> +                                    struct led_pattern *pattern, u32 len,
> +                                    u8 *pattern_val, u32 val_len)
> +{
> +       enum mt6370_led_ranges sel_range;
> +       struct led_pattern *curr;
> +       unsigned int sel;
> +       u8 val[P_MAX_PATTERNS / 2] = {};
> +       int i;
> +
> +       if (len < P_MAX_PATTERNS && val_len < P_MAX_PATTERNS / 2)
> +               return -EINVAL;
> +
> +       /*
> +        * Pattern list
> +        * tr1: byte 0, b'[7: 4]
> +        * tr2: byte 0, b'[3: 0]
> +        * tf1: byte 1, b'[7: 4]
> +        * tf2: byte 1, b'[3: 0]
> +        * ton: byte 2, b'[7: 4]
> +        * toff: byte 2, b'[3: 0]
> +        */
> +       for (i = 0; i < P_MAX_PATTERNS; i++) {
> +               curr = pattern + i;
> +
> +               sel_range = i == P_LED_TOFF ? R_LED_TOFF : R_LED_TRFON;
> +
> +               linear_range_get_selector_within(priv->ranges + sel_range,
> +                                                curr->delta_t, &sel);
> +
> +               val[i / 2] |= sel << (4 * ((i + 1) % 2));
> +       }
> +
> +       memcpy(pattern_val, val, 3);

Isn't it something like put_unaligned_be24()/put_unaligned_le24()?


> +       return 0;
> +}

...

> +static inline int mt6370_mc_pattern_clear(struct led_classdev *lcdev)
> +{
> +       struct led_classdev_mc *mccdev = lcdev_to_mccdev(lcdev);
> +       struct mt6370_led *led = container_of(mccdev, struct mt6370_led, mc);
> +       struct mt6370_priv *priv = led->priv;
> +       struct mc_subled *subled;

> +       int i, ret = 0;

Redundant assignment.

> +       mutex_lock(&led->priv->lock);
> +
> +       for (i = 0; i < mccdev->num_colors; i++) {
> +               subled = mccdev->subled_info + i;
> +
> +               ret = mt6370_set_led_mode(priv, subled->channel,
> +                                         MT6370_LED_REG_MODE);
> +               if (ret)
> +                       break;
> +       }
> +
> +       mutex_unlock(&led->priv->lock);
> +
> +       return ret;
> +}

...

> +       if (!fwnode_property_read_string(init_data->fwnode, "default-state",
> +                                        &stat_str)) {

ret = fwnode_...(...);
if (!ret)

> +               ret = match_string(states, ARRAY_SIZE(states), stat_str);
> +               if (ret < 0)
> +                       ret = STATE_OFF;
> +
> +               led->default_state = ret;
> +       }

...

> +       int i = 0, ret;

unsigned int i = 0;
int ret;

-- 
With Best Regards,
Andy Shevchenko
