Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8958A9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbiHELH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiHELH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:07:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7278606A1;
        Fri,  5 Aug 2022 04:07:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h22so1772775qta.3;
        Fri, 05 Aug 2022 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xevi7s0+mr+ptfy7uVrWQvtAVkuN9tBhA8DON7VF3hc=;
        b=a9+SkJgUlA0b0/BHR/ZnCRMvTgWWiTfbn+7hCLvZBsaMMCRDTPxUJBAC7vZNjxq/vo
         k8OLi0uQ406lmhmpDT6bTA8Ln7hcqHBvrfJ6793g1OGhONtOUz8WZFu//S4D+ajPvm+/
         HiavKm1cieEdFkxt1ha+nayBdzC2mzMdgbZG3PWagP1NkKBygX5opsEMSZg7lLxmqjo8
         LBS37LwpObC3ROrIeGlDwWsw0zgdY3DWHlzFAJgr2ZjpMu5E7HGDXRWesXtLS8v9Z+Us
         O4BT37Ii/msU+LJssnGZn5Y8/ZMnoo5h2TyNnno4biJLWE9r//68n4cVGwG19hhQqWRQ
         N3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xevi7s0+mr+ptfy7uVrWQvtAVkuN9tBhA8DON7VF3hc=;
        b=sm5JrA6bYdtj87Ckqd8aZ8RxoIv3GyG38CZ8N7UmJFNpjIxZb3FmKdl8gfzW4nn6k3
         7KcSZsLfpo1+dYFn639RMKnLI8QdjTDqAaRgsAfY/f4HBpBIF4MPMNRzzlo2276KReGz
         AN/CO/oeQ+/v4mSeO1eB9t7O2Mk7K1hsy609OzmMw48+q2L6LjzmZe5cPbymL/w6Mc4+
         uqJ/0Gjr8QOCn5t83Pi0pEsdIlyK7pekwFNUUQPchH0UvEUIVfHDE+DLYE2hAaPZTdej
         WzR97EgX9aCPpQ6IwprcjHUViM/laq8Mpt7KhXp3+ATbTRnqObe2PhfFrBSyMLDoS8Ar
         /XFw==
X-Gm-Message-State: ACgBeo3JmxB5VDOC+Ob7cqtgv1SMy0kEQ3LHNtUg3UipsyiY3U6uID0i
        kGhvFFg7x7va8tgDO+dNqSfAD8aoOxTwMJe/wt4=
X-Google-Smtp-Source: AA6agR616g5NuJiBX7N2EN5Udk4icnJWQWfoN9qnVhTU27eNGicOdpHWiuxBhRNAeZcqXVc1r4KkqHm9jBQr5PV+ypI=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr5286928qta.429.1659697674792; Fri, 05
 Aug 2022 04:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220805070610.3516-1-peterwu.pub@gmail.com> <20220805070610.3516-12-peterwu.pub@gmail.com>
In-Reply-To: <20220805070610.3516-12-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 13:07:18 +0200
Message-ID: <CAHp75VeL=GVMSQaxePwc47FsQczs10m0ZFc-Y3Z2rGx45vLnuQ@mail.gmail.com>
Subject: Re: [PATCH v7 11/13] leds: rgb: mt6370: Add MediaTek MT6370 current
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
        szuni chen <szunichen@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> Add a support for the MediaTek MT6370 Current Sink Type LED Indicator

Add support

(This is also for all other commit messages)

> driver. It can control four channels current-sink RGB LEDs with 3 modes,

3 modes:

> constant current, PWM, and breath mode.

...

> +static int mt6370_gen_breath_pattern(struct mt6370_priv *priv,
> +                                    struct led_pattern *pattern, u32 len,
> +                                    u8 *pattern_val, u32 val_len)
> +{
> +       enum mt6370_led_ranges sel_range;
> +       struct led_pattern *curr;
> +       unsigned int sel;
> +       u32 val = 0;
> +       int i;
> +
> +       if (len < P_MAX_PATTERNS && val_len < P_MAX_PATTERNS / 2)
> +               return -EINVAL;
> +
> +       /*
> +        * Pattern list
> +        * tr1:  byte 0, b'[7: 4]
> +        * tr2:  byte 0, b'[3: 0]
> +        * tf1:  byte 1, b'[7: 4]
> +        * tf2:  byte 1, b'[3: 0]
> +        * ton:  byte 2, b'[7: 4]
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
> +               val <<= i % 2 == 0 ? 8 : 0;
> +               val |= sel << (i % 2 == 0 ? 4 : 0);

It's too cryptic, why not simply:

  if (i % 2) {
    val |= sel;
  } else {
    val <<= 8;
    val |= sel << 4;
  }

?

> +       }
> +
> +       put_unaligned_be24(val, pattern_val);
> +
> +       return 0;
> +}

...

> +       const char * const states[] = { "off", "keep", "on" };

> +       ret = fwnode_property_read_string(init_data->fwnode, "default-state",
> +                                         &stat_str);
> +       if (!ret) {
> +               ret = match_string(states, ARRAY_SIZE(states), stat_str);
> +               if (ret < 0)
> +                       ret = STATE_OFF;
> +
> +               led->default_state = ret;
> +       }

Replace this by using led_init_default_state_get().

-- 
With Best Regards,
Andy Shevchenko
