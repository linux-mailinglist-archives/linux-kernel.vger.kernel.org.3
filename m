Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07DD570AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiGKTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiGKTse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:48:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2726C;
        Mon, 11 Jul 2022 12:48:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f73so10423237yba.10;
        Mon, 11 Jul 2022 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkomuDQLIrGkpVVzmeFT3DYYD8yFSVIJULiDQqnLKDw=;
        b=o5Js5nG9JFrnJw8FTiNWMEV88/jxGJgvHjwEV4Gq4kBjLVyQPqioyP0vEKHho5OYsb
         nUrTreABi1P6j0Com5OJ+nHYveim720M8LxJjduQ1g4khIkBdWL4BiyUvtXhvgS4WJnY
         CdiJXESyLtomBUrhIafge6ECdQ02REUXb8nOMp5Kr0EXoLsPtBGdTxEVLtA+ujs/y3+x
         Q434BIhOY75cziF/DL4771iz4nr81QNA8KAIV6gtSaD+G5O3JWp3N4tJxdcLKeILEDyb
         oDTSIx9ShPXrcP+gU873yiLx3I+4nc5kSfa7tiUJham162qK0oF/NUsPfN83w7U4bL0i
         VZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkomuDQLIrGkpVVzmeFT3DYYD8yFSVIJULiDQqnLKDw=;
        b=cD4XzwpFz5RHKnZL88UNIGckBnUhn7Vo4MVmKiNi3XsdFhgLvOjAJwCg+v5TLgDa1g
         l5ltfBiwMAiVUBiaEBAWeVA7ieihEdzBr4vZZw2blYG7zDwvZ7jvBKiLn99sqSxnbUi6
         XpBoX8+9jnck45j8oZ1H5o42d9zbIHP0VGzS+y47gb5pg0Jt5AdI8bxhRHeGNJBWlKoB
         12zhgLuOUBj3MVm2M6JgpsH9yvndwqban/DfgBk6qslARu5jmJo5OOMZhKzUVdiyYBWP
         sE5XLtrIA5tpV9PbQIH0Wcfu744voex1pYvviDh624FAGUyOoasKyyP0tMXalG3/FQAT
         OSkQ==
X-Gm-Message-State: AJIora88TQgLcEa8Oum6SzqXkrdjFchjvsVnhwa00ZudGb1ShP9Wh6/d
        27Jo9i3wk7tXc2x0KG6VC2xvpQejLQU3M+cOmH4=
X-Google-Smtp-Source: AGRyM1uJ2YrRHaWNO/NcEhC1mvA+w9x+HZp1INbuCKtI+dHb6RiQx7Z9HGo20m4O7PWUREkPpZKWsxNuqM9JyhIqvps=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr18789665ybu.128.1657568910080; Mon, 11
 Jul 2022 12:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com> <20220711192113.3522664-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220711192113.3522664-2-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 21:47:53 +0200
Message-ID: <CAHp75Vfs8EH-rRn58cS692tZMRFmjFLv6=kB4oqVEGXi5R8BHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pinctrl: ocelot: Fix pincfg for lan966x
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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

On Mon, Jul 11, 2022 at 9:17 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The blamed commit introduce support for lan966x which use the same
> pinconf_ops as sparx5. The problem is that pinconf_ops is specific to
> sparx5. More precisely the offset of the bits in the pincfg register are
> different and also lan966x doesn't have support for
> PIN_CONFIG_INPUT_SCHMITT_ENABLE.
>
> Fix this by making pinconf_ops more generic such that it can be also
> used by lan966x. This is done by introducing 'ocelot_pincfg_data' which
> contains the offset and what is supported for each SOC.

Thanks for an update!
My comments below.

...

I believe introducing

  struct ocelot_pincfg_data *opd = info->pincfg_data;

may allow to reduce LoCs...

> +                       *val = regcfg &
> +                               (info->pincfg_data->pd_bit |
> +                                info->pincfg_data->pu_bit);

...like here:

 *val = regcfg & (opd->pd_bit | opd->pu_bit);

...

> +       info->desc = devm_kmemdup(dev, &data->desc,
> +                                 sizeof(struct pinctrl_desc), GFP_KERNEL);

sizeof(*info->desc)

and missed the NULL check.

...

> +       info->pincfg_data = devm_kmemdup(dev, &data->pincfg_data,
> +                                        sizeof(struct ocelot_match_data),

sizeof(*info->pincfg_data)
(isn't it a bug here?)

> +                                        GFP_KERNEL);

and missed the NULL check.

-- 
With Best Regards,
Andy Shevchenko
