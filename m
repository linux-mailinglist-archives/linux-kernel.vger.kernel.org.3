Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF57B573395
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiGMJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiGMJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:55:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220E814AA;
        Wed, 13 Jul 2022 02:55:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31c8bb90d09so106884327b3.8;
        Wed, 13 Jul 2022 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mK30C12kzWgZOeaCtMpdRb4PfxIih9mHJc8r0tTk/s=;
        b=cHicjB7upzaw2IUfhKNmlKwjlNvYgN34lFE68OEHgN2QqZwJ12aSvKagS077XR11vK
         jL9vyGik77iQcv7fhR6E8/Yrg7mYHIbJi3hng08BMIphFykVwgSj8sSV0x0jEVW9qOUH
         e1b+pmtPIdlfa9E/Ge1XrJP+lK0ht+MNkyOMeX8w+JWFku89yZS/Tk2dYIZEpAhkoyze
         SkgWQI6rCekZqrFFYvtwdt40C2s6So78mEtv/y85+V7uae4yrUwiBNN2sGwd1k1FY8lb
         S1WhtfHmsRNxAVvoKDIXss/xEOd+hKByERW42xdDQOkOkJWwlQn9db+hecC+bsatsXep
         dv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mK30C12kzWgZOeaCtMpdRb4PfxIih9mHJc8r0tTk/s=;
        b=Y8LlfvIV9JOGDH/QQIo2X9JaJQ5gKMNJ2LA/cBrWfRrUAXLfWrvIfN8xsptvc8cXiO
         Tj9D3Pyg6zGGsB2i3oXF8eHKLRFiGQQHHTo25y/0U8vC4URFBIn2J6ZO1jR/F7XKPwfH
         DCeaYWLOy2U/8Fl3HF8GuyRWmpdlq/SJ78p4eUIFj5RocqBiuf2yT944k9gP0jLYi0O8
         BolM01IhRnzeHAn0hx4wnbLZjlrJF/5iLwFXuM1zGS4WhbTcj7g5+zMzkf0dyNGQYQ/1
         JMH4xyaQ7GUn/Xq/8L/2nNKj4Sls90l+uHqsnBDnzTl+q72YNr1hyWXSw1arKSeY92c7
         rTUQ==
X-Gm-Message-State: AJIora8xX5Z2Ykwwir6mAFtKHmhPGvf8LhCmTBtyoksrvDTvmt66FzLw
        prv3bQRekFNwMfQdkArayxpJA+UtD9PRa6Cq6t4=
X-Google-Smtp-Source: AGRyM1tIC292TkGgkFTxCTbeScoERtWB6qImXnbiVNqjEYv1PLFbfH3S7dlCy/ZYei2QtcGx07IUkngCJApiDIpfohU=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr3191115ywf.486.1657706127886; Wed, 13
 Jul 2022 02:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220712195043.3842081-1-horatiu.vultur@microchip.com> <20220712195043.3842081-3-horatiu.vultur@microchip.com>
In-Reply-To: <20220712195043.3842081-3-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 11:54:51 +0200
Message-ID: <CAHp75Ve9bhCMznLemFBc0K04S2vT8gv=aTkHZ6DVc9RZwsPVpw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: ocelot: Fix pincfg
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kavyasree.kotagiri@microchip.com,
        Colin Foster <colin.foster@in-advantage.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
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

On Tue, Jul 12, 2022 at 9:46 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The blamed commit changed to use regmaps instead of __iomem. But it
> didn't update the register offsets to be at word offset, so it uses byte
> offset.
> Another issue with the same commit is that it has a limit of 32 registers
> which is incorrect. The sparx5 has 64 while lan966x has 77.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 873bba245522..c5a9f87f0c49 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -1334,7 +1334,9 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
>                 const struct ocelot_pincfg_data *opd = info->pincfg_data;
>                 u32 regcfg;
>
> -               ret = regmap_read(info->pincfg, pin, &regcfg);
> +               ret = regmap_read(info->pincfg,
> +                                 pin * regmap_get_reg_stride(info->pincfg),
> +                                 &regcfg);
>                 if (ret)
>                         return ret;
>
> @@ -1366,14 +1368,18 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
>         u32 val;
>         int ret;
>
> -       ret = regmap_read(info->pincfg, regaddr, &val);
> +       ret = regmap_read(info->pincfg,
> +                         regaddr * regmap_get_reg_stride(info->pincfg),
> +                         &val);
>         if (ret)
>                 return ret;
>
>         val &= ~clrbits;
>         val |= setbits;
>
> -       ret = regmap_write(info->pincfg, regaddr, val);
> +       ret = regmap_write(info->pincfg,
> +                          regaddr * regmap_get_reg_stride(info->pincfg),
> +                          val);
>
>         return ret;
>  }
> @@ -1932,7 +1938,8 @@ static const struct of_device_id ocelot_pinctrl_of_match[] = {
>         {},
>  };
>
> -static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
> +static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev,
> +                                                  const struct ocelot_pinctrl *info)
>  {
>         void __iomem *base;
>
> @@ -1940,7 +1947,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>                 .reg_bits = 32,
>                 .val_bits = 32,
>                 .reg_stride = 4,
> -               .max_register = 32,
> +               .max_register = info->desc->npins * 4,
>                 .name = "pincfg",
>         };
>
> @@ -2008,7 +2015,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>
>         /* Pinconf registers */
>         if (info->desc->confops) {
> -               pincfg = ocelot_pinctrl_create_pincfg(pdev);
> +               pincfg = ocelot_pinctrl_create_pincfg(pdev, info);
>                 if (IS_ERR(pincfg))
>                         dev_dbg(dev, "Failed to create pincfg regmap\n");
>                 else
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
