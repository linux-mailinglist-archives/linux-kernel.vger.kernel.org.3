Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9757FB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiGYIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:25:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1E13E9B;
        Mon, 25 Jul 2022 01:25:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tk8so19173658ejc.7;
        Mon, 25 Jul 2022 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5rSRKJzZCEe75lE89H4BacTqhlHPMQzJe7RV2ORfWI=;
        b=BNlVjsxRro5TG97838xZbVcQ/pG/LD+g/7G/AjwrIrlPvPS37j9HRk59ZPvQZFMbo9
         MnOMniee2k168J7vlVevltwedsYw1fwJcNYMweUNuLPFL7JEp9m9CEssAgQLNBEXPpLX
         65np3ghAZ/JI0ou7IY+VAdXdeEM9Dx5l6K3VMtdxVw5MaZ+JcN9Mz6qTKX+a72GlbThf
         YgqMy4pPKGjxlN3v8ojq6p7cX1h0ysW9lnKZ5pLCEPb56UCWlozkB+OoACaoaIIUBRbZ
         /V/wW4p+YYsXXLnpTvXofuXoBPwxmOEVHWVRTZH6OK6PGjSYJaBn82vKtB7a1B3eaVvy
         gAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5rSRKJzZCEe75lE89H4BacTqhlHPMQzJe7RV2ORfWI=;
        b=KmLawa8UXbcqBjf0QeFvLCZ0gZkepy9msxh2TcI45J0/AKstyDM2vjS0jhEAhMMHcC
         XINhzzdIYVcgr/l48JvCkbsxVjj7kCBVvm8pju+RoZsEEyuUtcuCpYdfwDZcQigmYPRI
         7cflqhlNiNtCzGshQnufoaJoVY8PeAQr/5sonhpTcD4hCt8GwwjsLrZbP5Es3OdbsNqR
         BEyW4qunCBOr9c4YGiDmIRuC8Metmp/9wifmWsDyLzBeg781ZGF7VSTjkC3i4CE6kj35
         S5I0eRZsw2MAO2G+FinrnraRM0k1vuHs0IDIIfWGgq55Z5a4+4yqqfkGD4YEkTrIjMJT
         QC1w==
X-Gm-Message-State: AJIora+hU7VC0LcDSE7wGV5cpWcVpLHCTv4zPhAEsYsFqMl0u7nfMIIr
        BawBilq4Fe/pPdBgumbhzhronxEJSql//Xjj4ks=
X-Google-Smtp-Source: AGRyM1tb8lf0258KwCgCSc1j2TNtucrsLChWD53/F5ZAYHmenBBMp0FJqJ/Hs5trX2iqStdOTyF6IVkbw5ytFnaOucM=
X-Received: by 2002:a17:906:8a4a:b0:72b:5b23:3065 with SMTP id
 gx10-20020a1709068a4a00b0072b5b233065mr9396194ejc.557.1658737543426; Mon, 25
 Jul 2022 01:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-11-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-11-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:25:06 +0200
Message-ID: <CAHp75VeafmppD=Ge-kGZ7ab8=P9p5wmZXi_1fKFf+1uVA-SNog@mail.gmail.com>
Subject: Re: [PATCH v6 10/13] power: supply: mt6370: Add MediaTek MT6370
 charger driver
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
> This adds MediaTek MT6370 Charger driver support. The charger module
> of MT6370 supports High-Accuracy Voltage/Current Regulation,
> Average Input Current Regulation, Battery Temperature Sensing,
> Over-Temperature Protection, DPDM Detection for BC1.2.

...

> +static inline void mt6370_chg_enable_irq(struct mt6370_priv *priv,
> +                                        const char *irq_name, bool en)
> +{
> +       int irq_num;
> +       struct platform_device *pdev = to_platform_device(priv->dev);
> +
> +       irq_num = platform_get_irq_byname(pdev, irq_name);

Every time the IRQ is not found you will get an error message printed here.
1) Is IRQ optional?
2) If not, can't you do validation only once?

> +       if (irq_num < 0)
> +               return;
> +
> +       if (en)
> +               enable_irq(irq_num);
> +       else
> +               disable_irq_nosync(irq_num);
> +}


...

> +       ret = mt6370_chg_field_set(priv, F_USBCHGEN, 0);
> +       if (ret < 0) {

> +       ret = mt6370_chg_field_set(priv, F_ICHG, 900000);
> +       if (ret < 0) {

> +       ret = mt6370_chg_field_set(priv, F_IINLMTSEL, 3);
> +       if (ret < 0) {

Do all these ' < 0' parts make sense?
(Not only these cases, but in many in the entire driver)

...

> +       /* Check in otg mode or not */

OTG

...

> +               ret = devm_request_threaded_irq(priv->dev, ret, NULL,
> +                                               mt6370_chg_irqs[i].handler,
> +                                               IRQF_TRIGGER_FALLING,
> +                                               dev_name(priv->dev), priv);

> +

Redundant blank line.

> +               if (ret < 0)
> +                       return dev_err_probe(priv->dev, ret,
> +                                            "Failed to request irq %s\n",
> +                                            mt6370_chg_irqs[i].name);
> +       }

-- 
With Best Regards,
Andy Shevchenko
