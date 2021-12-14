Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF794741E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhLNL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhLNL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:58:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D269EC061574;
        Tue, 14 Dec 2021 03:58:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r11so61401987edd.9;
        Tue, 14 Dec 2021 03:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yz7eU35vqRDb2z6sN8MYznQDPOspquHEIsAYoRHMKo=;
        b=crUZ9vPwt6eX1JdysOVY5ooAd1RjhuZm8E1RTpcm6qUCJWz16hkXEznHIA1sGMi7Sb
         4K5IsW59L/sdKwK5GNA33DsQPilDyHTC7a0HYFiecf5fj0K0xPXnO/VA+70diYxna3/T
         yozXmg+GrB6pb2pyMS61LEGotetWw95G37HeGy+n/BHdBwmZH5gXJDa5oM0teKbJem1q
         sBQV8VrooDTadO0wbKnnpHZxWkkaxcj8jMY+yKGqEECPha6Pw3uCWJOWVAjO1KKC31/P
         KKOMSJ8AMjTB55JqekbQvfiRbZfu5E/sy4LY4RI29ClPetueHWkh7wmwxNVYpzInW6hd
         b+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yz7eU35vqRDb2z6sN8MYznQDPOspquHEIsAYoRHMKo=;
        b=uPMLCJvpDfn4hBOBflduHOUgqpTMbm4H8jK7ouvyuDwbnABHik80dMB7Tn42UbESru
         XJd2weqGlEEcAuaJSM4h08h715+oRfcGdcQM3RG+MtnbBZMaVZzq7mrDOEbS1Cx2AhYE
         7ejN37O0Bg1DsfjtelrVi38bOrApH6f+Se+frrZpwxUsAck1N5daiwchdazqPKEZa9Wj
         7eoox+qqrxiKYu/lNyuqXo7ZGLtnpW6GrqCQ+bwaEcHKtanm1XqEvINms0+12dZFqrl3
         GPn98uLWU33CN436xO1nZvVzGC82mwRdrNDXMsSqWBUwYW/JOdq2RcW2d3wj/OU8//Ci
         +AQA==
X-Gm-Message-State: AOAM5319XAggJqE2P53in5EBlZ7gaqn+VmDr9k/CrLH1zxGj6w97hGp6
        iq+YS0sCtknhsB1frc8zfqKw61h+3OoSt4WREq4RP4+wA5M=
X-Google-Smtp-Source: ABdhPJz1hiBiXGOUcreG+/Of5n2uneQz2aXfnvCnSmW7WT2ZBwmwo9wPrFJOwFncr/N/AwQQ+FfBPBaevPLiKUBiMl4=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr5581618ejc.77.1639483116361;
 Tue, 14 Dec 2021 03:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20211214022100.14841-1-qianggui.song@amlogic.com> <20211214022100.14841-4-qianggui.song@amlogic.com>
In-Reply-To: <20211214022100.14841-4-qianggui.song@amlogic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Dec 2021 13:57:06 +0200
Message-ID: <CAHp75VczRGaKY_O3SV9xx-G95Rk8uFPwNFuVE1iy+HAxgL+oVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: meson: add pinctrl driver support for
 Meson-S4 Soc
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 6:27 AM Qianggui Song <qianggui.song@amlogic.com> wrote:
>
> Add new pinctrl driver for Amlogic's Meson-S4 SoC which share the
> same register laytout as the previous Meson-A1.

layout

...

> +config PINCTRL_MESON_S4
> +       tristate "Meson s4 Soc pinctrl driver"
> +       depends on ARM64
> +       select PINCTRL_MESON_AXG_PMX

> +       default y

Why is it needed on other (non-MESON_S4) SoCs?

...

> +static const char * const i2c1_groups[] = {
> +       "i2c1_sda_c", "i2c1_scl_c",
> +       "i2c1_sda_d", "i2c1_scl_d",
> +       "i2c1_sda_h", "i2c1_scl_h",
> +       "i2c1_sda_x", "i2c1_scl_x"

In this and all the rest similar cases leave a comma.

> +};

...

> +static const struct of_device_id meson_s4_pinctrl_dt_match[] = {
> +       {
> +               .compatible = "amlogic,meson-s4-periphs-pinctrl",
> +               .data = &meson_s4_periphs_pinctrl_data,
> +       },

> +       { },

When it's a terminator entry, no comma is needed.

> +};

...

> +static struct platform_driver meson_s4_pinctrl_driver = {
> +       .probe  = meson_pinctrl_probe,
> +       .driver = {
> +               .name   = "meson-s4-pinctrl",
> +               .of_match_table = meson_s4_pinctrl_dt_match,
> +       },
> +};

> +
> +module_platform_driver(meson_s4_pinctrl_driver);

Swap above two lines, first module_...() followed by a blank line.

> +MODULE_LICENSE("Dual BSD/GPL");

-- 
With Best Regards,
Andy Shevchenko
