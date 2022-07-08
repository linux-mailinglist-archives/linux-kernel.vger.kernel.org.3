Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB99756C37E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiGHV66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiGHV6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:58:55 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDE083F2A;
        Fri,  8 Jul 2022 14:58:54 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ef5380669cso822317b3.9;
        Fri, 08 Jul 2022 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcIFKf7bOOx+mUBC0KpignSQRFrA0hcG12j1sFhX+t0=;
        b=W8uPaklZvQ3bukLnBTN3S6Ew4/U4OZaUQuLD2WYfEreEfd7Pk11dzS4SDlTkV3V2r2
         jNz936jT/ukpQM2GmftDOkWh18wCZ4tDJLHVPM/nD7uvjzxt0ae5OgK9pvIlztw7z/0Y
         9a0tShegjjxTvEhJbfCh75iwHpywUYlz3l6fkJ+0sQqcCGr2i9DKxrlnbc0i84JzSCqe
         fxMwX0XOnZ6NA4PMaK4LYFGmDCC5n7Q9HpQO7d42gV0FN5mHtw3pWnOesDUxw1aVieMO
         vEfbMNCcyDV6+ojq2IjE9jxQ6+GVaY3/ByY0figdbK2JAyvNQtzJAFNeus0evDGRtI+0
         v4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcIFKf7bOOx+mUBC0KpignSQRFrA0hcG12j1sFhX+t0=;
        b=tVnhlwBuoswkDsqNyz3H5jI8+y56AekvJ+B0lsdAApp7BMj6GonXxu9qCgwEpqhKnA
         gsFas2Z4QdfwmijnV4L0Kihvaj2vRl6tsK4MDsUNXSn5fK7vmKw1MU+oWKtaLHTG8izY
         qQ5Y2gGsE71EodxONgK8LAX65imMtVBtIWNDGBg2oSRN1yMzToz8MCyeAqqfXr+7JFSu
         SE+16nKj/cVH6MIalIN0vwEh4TxmgdhNaZseIY9j5hRYo/pNg7H7JEycg9Hu2CtgMTlH
         GwWdTYtsIrfhxhLcLvKEfdjfQ10u5rG3blWofORTh8C0sgBTtLJIBAtLFPBaZ/b0t+UZ
         id/w==
X-Gm-Message-State: AJIora8fAv0njy2yk6Vc97JtS74DCgnVrDd7Oq8Op5kuWSTZn0mBeCLq
        XZUNToAnODuytOkRa84VZjH7wC0XmTxWxcoP/OE=
X-Google-Smtp-Source: AGRyM1tVeXi6GZYH/Bk0++Ct746gudsbDP6YSoe8uT+Jl7b5ezmsuWM1Oak5RmOZWuCwX4JjuDrR0OB7iVxiTaV+twY=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr6404186ywq.18.1657317534133; Fri, 08
 Jul 2022 14:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com> <20220708195510.2951661-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220708195510.2951661-2-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 23:58:17 +0200
Message-ID: <CAHp75VdPi8rT_EJd8L8-waAkH_Lm947WVKMLHjjW5MpFW9A06Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix pincfg for lan966x
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

On Fri, Jul 8, 2022 at 10:10 PM Horatiu Vultur
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

...

> +struct ocelot_pincfg_data {
> +       bool has_schmitt;
> +       u8 schmitt_bit;
> +       u8 pd_bit;
> +       u8 pu_bit;
> +       u8 drive_bits;

I would go with mandatory fields first and leave optional (that is
with boolean flag) at last.

> +};

...

>  struct ocelot_pinctrl {
>         struct device *dev;
>         struct pinctrl_dev *pctl;
> @@ -330,6 +331,12 @@ struct ocelot_pinctrl {
>         struct pinctrl_desc *desc;
>         struct ocelot_pmx_func func[FUNC_MAX];
>         u8 stride;
> +       struct ocelot_pincfg_data *pincfg_data;

It might waste too many bytes in some cases. I would recommend moving
it somewhere above, definitely before the u8 member.

> +};

Yes, I understand that for a certain architecture it might be the same
result in sizeof(), the rationale is to make code better in case
somebody copies'n'pastes pieces or ideas from it.

...

>                 if (param == PIN_CONFIG_BIAS_DISABLE)>                         val = (val == 0);
>                 else if (param == PIN_CONFIG_BIAS_PULL_DOWN)
> -                       val = (val & BIAS_PD_BIT ? true : false);
> +                       val = (val & info->pincfg_data->pd_bit ? true : false);
>                 else    /* PIN_CONFIG_BIAS_PULL_UP */
> -                       val = (val & BIAS_PU_BIT ? true : false);
> +                       val = (val & info->pincfg_data->pu_bit ? true : false);
>                 break;

> +               val = (val & info->pincfg_data->schmitt_bit ? true : false);


!!(val & ...) will be a much shorter equivalent to ternary.

>                 break;

...

> +static struct ocelot_match_data ocelot_desc = {
> +       .desc = {
> +               .name = "ocelot-pinctrl",
> +               .pins = ocelot_pins,
> +               .npins = ARRAY_SIZE(ocelot_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .owner = THIS_MODULE,
> +       }

Please, keep a comma here. It's definitely not a terminating entry, so
it might help in the future.

Ditto for all cases like this.

>  };

...

> +       struct ocelot_match_data *data;

Any specific reason why this is not const?

...

> +       data = (struct ocelot_match_data *)device_get_match_data(dev);

And here you drop the qualifier...

I would recommend making it const and dropping the cast completely.

> +       if (!data)
> +               return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko
