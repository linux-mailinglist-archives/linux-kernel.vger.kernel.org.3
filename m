Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D35613FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiF3IBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiF3IAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:00:30 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1804163F;
        Thu, 30 Jun 2022 01:00:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3176b6ed923so170860657b3.11;
        Thu, 30 Jun 2022 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYg/Wp4bT4dysW+fftXKNsqrJ8LDP2HiO/OhiEJYgwY=;
        b=bc0me7bZxE6sqbBQIqa8Lm0CwTH3ChwQx+vl92dAZ1YB8KQcyEbeUNWvtGPfaWrEn4
         SAICYfKoB3HR8nZ2GCIf/sQYJncOEenHqxy07Mr/fhbBs5+gwXG/rE2H1bUxf1923z4u
         bWsfyhqO4GhdEo3xexs6S3sWTpQ1SiiMmQM5ySY9aYztSvzLzanMhtlPerqiSLqBQ496
         4eg1tUg6xduIEX3rmnzrZrWF0fI1ll2y2ZtuAcHPdfm06Yj+Yapt9dzY3ohmm8cTcnXP
         B0aUGaOHP9bFII3K8YSa/xjqEOqAfUDBOx1XUZJpzYRCK94GC2Jj1/YnT99V8DniSG94
         HQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYg/Wp4bT4dysW+fftXKNsqrJ8LDP2HiO/OhiEJYgwY=;
        b=oOvRuwXf73cSQUyptN+Pwd7bB8iHUSH9YoyxdAxUQ/jEJVsSre0X7Sj86tu1e4rbJc
         HWBP2WVQMY2H92uwgBzVe3GHjyM/qyaIiJsBnwgeip1uyzPl0xcwBYUOa3tEjcSxEHQd
         J057EGOWq+gsYhMOHhHtrbZ7fxwe3YLkgBUKfkJ3k4j12LI9miEdEDAeCLA2pFclnHJj
         94VAiF3JksSyYP2YU7/PGUg+4lItcuRixQ/jnFlcZq0N6rMr+KVRnyJy4WaJtG+j18Bx
         6+GWcYK221gfJFMu0RQg9v+llsHLCPiYZxIEHSyHtB3AZ1csHrgecJxyEIGQN3la0q8c
         YKlQ==
X-Gm-Message-State: AJIora9oJZx1Bes4d28DKOjwjdtrc5CasSpxoIym/2UHNX8AJHv9rfGO
        ocz+bsoYtmh5dVuBEwXMEEAAztXiLIEB7xk/U4Y=
X-Google-Smtp-Source: AGRyM1sKHpDBBl+UVcZBP9FJ/U9eNhoLOC4sdX+8DdLhlzteYXI5xmafjkNRHeePyuijTxFbMGvWs296X58zC0GMQmg=
X-Received: by 2002:a81:cd3:0:b0:317:861c:ac07 with SMTP id
 202-20020a810cd3000000b00317861cac07mr9008772ywm.486.1656576020271; Thu, 30
 Jun 2022 01:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-14-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-14-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:59:41 +0200
Message-ID: <CAHp75VeZceiA9fUg2bT-wQz4U2sNjZa_xQmh6ALFx5BdmQK6Yg@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] power: axp20x_battery: Add constant charge
 current table
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Add a table-based lookup method for constant charge current,
> which is necessary when the setting cannot be represented as
> a linear range.
>
> This also replaces the hard-coded 300 mA default ccc setting
> if the DT-specified value is unsupported; the minimum value
> for the device is now set exactly instead of relying on the
> value being rounded down to a supported value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 59 +++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 9106077c0dbb..401779d84d2b 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -61,6 +61,14 @@ struct axp20x_batt_ps;
>  struct axp_data {
>         int     ccc_scale;
>         int     ccc_offset;
> +       /*
> +        * Lookup table for constant charge current, if provided this is used
> +        * instead of ccc_scale/ccc_offset.
> +        *
> +        * The table is indexed by the field AXP20X_CHRG_CTRL1_TGT_CURR so it
> +        * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
> +        */
> +       const int *ccc_table;
>         bool    has_fg_valid;
>         int     (*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>         int     (*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> @@ -176,7 +184,10 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>
>         *val &= AXP20X_CHRG_CTRL1_TGT_CURR;
>
> -       *val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
> +       if (axp->data->ccc_table)
> +               *val = axp->data->ccc_table[*val];
> +       else
> +               *val = *val * axp->data->ccc_scale + axp->data->ccc_offset;
>
>         return 0;
>  }
> @@ -389,16 +400,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
>                                   AXP20X_CHRG_CTRL1_TGT_VOLT, val);
>  }
>
> +static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps *axp_batt,
> +                                                 int charge_current)
> +{
> +       int i;
> +
> +       if (axp_batt->data->ccc_table) {
> +               for (i = AXP20X_CHRG_CTRL1_TGT_CURR; i >= 0; i--) {
> +                       if (axp_batt->data->ccc_table[i] <= charge_current)
> +                               return i;
> +               }
> +
> +               return -EINVAL;
> +       }
> +
> +       i = (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->ccc_scale;
> +       if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
> +               return -EINVAL;
> +
> +       return i;
> +}
> +
>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
>                                               int charge_current)
>  {
>         if (charge_current > axp_batt->max_ccc)
>                 return -EINVAL;
>
> -       charge_current = (charge_current - axp_batt->data->ccc_offset) /
> -               axp_batt->data->ccc_scale;
> -
> -       if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +       charge_current = axp20x_get_constant_charge_current_sel(axp_batt, charge_current);
> +       if (charge_current < 0)
>                 return -EINVAL;
>
>         return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
> @@ -410,14 +440,14 @@ static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
>  {
>         bool lower_max = false;
>
> -       charge_current = (charge_current - axp->data->ccc_offset) /
> -               axp->data->ccc_scale;
> -
> -       if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +       charge_current = axp20x_get_constant_charge_current_sel(axp, charge_current);
> +       if (charge_current < 0)
>                 return -EINVAL;
>
> -       charge_current = charge_current * axp->data->ccc_scale +
> -               axp->data->ccc_offset;
> +       if (axp->data->ccc_table)
> +               charge_current = axp->data->ccc_table[charge_current];
> +       else
> +               charge_current = charge_current * axp->data->ccc_scale + axp->data->ccc_offset;
>
>         if (charge_current > axp->max_ccc)
>                 dev_warn(axp->dev,
> @@ -629,7 +659,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
>                                                                    ccc)) {
>                         dev_err(&pdev->dev,
>                                 "couldn't set constant charge current from DT: fallback to minimum value\n");
> -                       ccc = 300000;
> +
> +                       if (axp20x_batt->data->ccc_table)
> +                               ccc = axp20x_batt->data->ccc_table[0];
> +                       else
> +                               ccc = axp20x_batt->data->ccc_offset;
> +
>                         axp20x_batt->max_ccc = ccc;
>                         axp20x_set_constant_charge_current(axp20x_batt, ccc);
>                 }
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
