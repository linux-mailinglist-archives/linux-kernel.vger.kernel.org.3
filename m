Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E15613FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiF3IBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiF3IAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:00:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4388240A11;
        Thu, 30 Jun 2022 01:00:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31bf3656517so80349277b3.12;
        Thu, 30 Jun 2022 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgHwl7lP0Pje/1oFOwB//0grAC9GnR7mcML9AHsfC2I=;
        b=BQF0EfehXCNzjbXoo4w28te8+5VjjrHq1TqK7P92fyqab5cQTLm1OuCcNpqzX2z2C0
         srYFMm3c3iDk+aI76DmUvij4v+8+tskF7VLDsH1d5mbZt/UYd4ebLrg1wXeoDbH7B3rb
         /xNA5lPpC102hJ9xUKRlt5E+yiZPl5UzAPGFQuy50zfUpw/ThNn/1s83c4hyawdcBfRG
         bsO9B/V4oouaFZiVnnt0LxEraXeFn1urCIVvXeMP/Rk5EsYWq2wDs9bAwFzia43rBSyR
         B03oq23onpgCZXPnMvDcKOi9yzaGQrk5S9GV/soAkRDrseEAmgdJ0SO/AdMJdU6L5krG
         FP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgHwl7lP0Pje/1oFOwB//0grAC9GnR7mcML9AHsfC2I=;
        b=V9rztE7M60F6DJHBZ2ctxxH3I0hEUfuRZDaB8KJKinbMr5CltPuFAy+DwF4sY5p+l7
         i8EQS9wg/xCf1ef+lZ7vP2q3oRGOLU1DAUU3zDKn/v6lrzQwzoTzaLyfRc5ZuUVK//NM
         QwQNnjtAgAiYQonGwYOABRuPcu6g6eMmGg+hAOKylYo/MuUg7DdMZ2px6FrazPBPdw+m
         Y1M5uD0mgXRTM4hUsujpDkPkPQN1JVyQFZQVcf4XIxb0O4nSFFkzMfQkcmrS3QfFmEjW
         KkFwT6DntHJWRYqYY3yQovxA55O5GVFYMkOH0HxTV0frE0mmojnh3mcr/V6GoUGh16lt
         mEyQ==
X-Gm-Message-State: AJIora9ahvjSjD65fMnR5Ygr7X8gK+7v3UfGfPxJGV3nXNkCzw9pGMX6
        q2IkXfi0ddSCQWvT+CtHJvbdhVEJ2t4gHfaPFeFZLAxgK26NmjLx
X-Google-Smtp-Source: AGRyM1vDh6JZcEnVOI+TrwfNxFsoJVaMxTHFk0dysBdJwNPMufgpUnNF1yzBf8YZBzFPK8WTRH12P2gWQCJmQfBNaq4=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr8605426ywa.277.1656576041340; Thu, 30
 Jun 2022 01:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-15-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-15-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 10:00:01 +0200
Message-ID: <CAHp75VdJ=FOhW5DBUZnt_sSBRLODGaz=tEAOjffyQ9i6CMg2JA@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] power: axp20x_battery: Support battery status
 without fuel gauge
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
> Add a "has_fg" flag to indicate that the chip has a fuel gauge.
> Report battery full status on chips with no fuel gauge using the
> battery voltage.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 34 ++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 401779d84d2b..574c1d001556 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -69,6 +69,7 @@ struct axp_data {
>          * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
>          */
>         const int *ccc_table;
> +       bool    has_fg;
>         bool    has_fg_valid;
>         int     (*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
>         int     (*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> @@ -197,7 +198,7 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>                                    union power_supply_propval *val)
>  {
>         struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> -       int ret = 0, reg, val1;
> +       int ret = 0, reg, val1, val2;
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_PRESENT:
> @@ -231,6 +232,34 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>                         return 0;
>                 }
>
> +               /*
> +                * If the chip does not have a fuel gauge, we check battery full status
> +                * using voltage instead.
> +                */
> +               if (!axp20x_batt->data->has_fg) {
> +                       ret = axp20x_batt->data->get_max_voltage(axp20x_batt, &val1);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret = iio_read_channel_processed(axp20x_batt->batt_v, &val2);
> +                       if (ret)
> +                               return ret;
> +
> +                       /* IIO subsystem reports voltage in mV but we need uV */
> +                       val2 *= 1000;
> +
> +                       /*
> +                        * According to the AXP192 datasheet, charging will restart if
> +                        * the battery voltage drops below V_rch = V_tgt - 0.1 V, so we
> +                        * report the battery is full if its voltage is at least V_rch.
> +                        */
> +                       if (val2 >= val1 - 100000)
> +                               val->intval = POWER_SUPPLY_STATUS_FULL;
> +                       else
> +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +                       break;
> +               }
> +
>                 ret = regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &val1);
>                 if (ret)
>                         return ret;
> @@ -552,6 +581,7 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
>  static const struct axp_data axp209_data = {
>         .ccc_scale = 100000,
>         .ccc_offset = 300000,
> +       .has_fg = true,
>         .get_max_voltage = axp20x_battery_get_max_voltage,
>         .set_max_voltage = axp20x_battery_set_max_voltage,
>  };
> @@ -559,6 +589,7 @@ static const struct axp_data axp209_data = {
>  static const struct axp_data axp221_data = {
>         .ccc_scale = 150000,
>         .ccc_offset = 300000,
> +       .has_fg = true,
>         .has_fg_valid = true,
>         .get_max_voltage = axp22x_battery_get_max_voltage,
>         .set_max_voltage = axp22x_battery_set_max_voltage,
> @@ -567,6 +598,7 @@ static const struct axp_data axp221_data = {
>  static const struct axp_data axp813_data = {
>         .ccc_scale = 200000,
>         .ccc_offset = 200000,
> +       .has_fg = true,
>         .has_fg_valid = true,
>         .get_max_voltage = axp813_battery_get_max_voltage,
>         .set_max_voltage = axp20x_battery_set_max_voltage,
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
