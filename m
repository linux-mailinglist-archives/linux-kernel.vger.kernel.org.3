Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF8561400
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiF3IBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiF3IA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:00:59 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EF41630;
        Thu, 30 Jun 2022 01:00:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so32374718ybr.6;
        Thu, 30 Jun 2022 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4VaG08RYManopuZpAGSTmqyNLUmKtObC9D7j1buosc=;
        b=kR7wcXI3ZkBnGgu38OPdD7Q/6eo1kxMRs1xbtDloKLyhkRsa/hcn5yGk53ePz+ItAD
         TyqtMUZsdjmFbDnmALeo6dJy4/7+KvkNmSN+216paSx4APdA6vQv571cHc5pwlkbA8tc
         HkVpUKcjaNnK6HWoZmftFYL95Omid416u4c3Z7583i2woIkU/zFZOD4CvZR93eU6Q1Z3
         y2cpETE06mn9VQZZ3QNIPVXUte+ggWmukX/CYwzja94R2MuV4oO0nhmKr3DdEEOs+V24
         e9hm/tX3ONyohQCW0D74wP6IxkuVKiOoiJpGZDBey2HvRxPqDqQ2LfNRFx3YDz79QpqT
         353A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4VaG08RYManopuZpAGSTmqyNLUmKtObC9D7j1buosc=;
        b=f+qUyiz6xFc0aoUhmoZKLNEtd87eJNFH3gyR+mBTsUoZxhRMSP3ZcLOz0i+/ByzHjS
         TxKSOT7GCyEspA5iSRZxpcINxzrkVfWYJ1URUpVBYgHjOr8pFNnH1T8pGD+RaB4cu0UN
         aqUrvwEat/9/mmMRKpFOq59gjr0moUZZrrB4s/OegfbCW2sGBePyFtrFalNY2eyQ0VfZ
         ++/J4tTx9jbCJR8ijwjgEcBybSpsHUe/DqQRvvLpOPRvyX3Ml+XSQ/fxLxmW6ryzwqgj
         xhgaq3B5+xnNGDqy3CoXY1zHR2Iw33/tHhcQ+6sfoLLlVL4fGvOSPkrMWVv2Ci8xqsjd
         KfFw==
X-Gm-Message-State: AJIora+srk/WEezJi9TAIvaRqiKV+Q680seAz2ouSLHYNOwmzKyPykE4
        ZFtuUlmiisZo4Z1H/wJ2+Mgix34HG75HIK1Ebko=
X-Google-Smtp-Source: AGRyM1tOkHckST+esMDNGkulQhtjI1csN1ZIVD3zn7rKujVWHzxaEq3fwCuqXRCu101gK1Wctd5PTtsXc9fPqrBWULc=
X-Received: by 2002:a05:6902:1142:b0:66d:999a:81a7 with SMTP id
 p2-20020a056902114200b0066d999a81a7mr3728559ybu.460.1656576056733; Thu, 30
 Jun 2022 01:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-16-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-16-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 10:00:15 +0200
Message-ID: <CAHp75Vd_U0wOcivr01b0P3k2M8AMdtsE2ODazR705-6PTisJ2g@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] power: axp20x_battery: Add support for AXP192
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
> The AXP192 has a battery charger similar to other X-Powers PMICs,
> but unlike the other supported devices, it does not have a fuel
> gauge and can't report battery capacity directly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 49 +++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 574c1d001556..1e84d26ce8e3 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -544,6 +544,19 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
>         }
>  }
>
> +static enum power_supply_property axp192_battery_props[] = {
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +       POWER_SUPPLY_PROP_CURRENT_NOW,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +       POWER_SUPPLY_PROP_HEALTH,
> +       POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +       POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +};
> +
>  static enum power_supply_property axp20x_battery_props[] = {
>         POWER_SUPPLY_PROP_PRESENT,
>         POWER_SUPPLY_PROP_ONLINE,
> @@ -568,6 +581,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
>                psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
>  }
>
> +static const struct power_supply_desc axp192_batt_ps_desc = {
> +       .name = "axp192-battery",
> +       .type = POWER_SUPPLY_TYPE_BATTERY,
> +       .properties = axp192_battery_props,
> +       .num_properties = ARRAY_SIZE(axp192_battery_props),
> +       .property_is_writeable = axp20x_battery_prop_writeable,
> +       .get_property = axp20x_battery_get_prop,
> +       .set_property = axp20x_battery_set_prop,
> +};
> +
>  static const struct power_supply_desc axp20x_batt_ps_desc = {
>         .name = "axp20x-battery",
>         .type = POWER_SUPPLY_TYPE_BATTERY,
> @@ -578,6 +601,19 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
>         .set_property = axp20x_battery_set_prop,
>  };
>
> +static const int axp192_ccc_table[AXP20X_CHRG_CTRL1_TGT_CURR+1] = {
> +       100000,  190000,  280000,  360000,
> +       450000,  550000,  630000,  700000,
> +       780000,  880000,  960000,  1000000,
> +       1080000, 1160000, 1240000, 1320000,
> +};
> +
> +static const struct axp_data axp192_data = {
> +       .ccc_table = axp192_ccc_table,
> +       .get_max_voltage = axp20x_battery_get_max_voltage,
> +       .set_max_voltage = axp20x_battery_set_max_voltage,
> +};
> +
>  static const struct axp_data axp209_data = {
>         .ccc_scale = 100000,
>         .ccc_offset = 300000,
> @@ -606,6 +642,9 @@ static const struct axp_data axp813_data = {
>
>  static const struct of_device_id axp20x_battery_ps_id[] = {
>         {
> +               .compatible = "x-powers,axp192-battery-power-supply",
> +               .data = (void *)&axp192_data,
> +       }, {
>                 .compatible = "x-powers,axp209-battery-power-supply",
>                 .data = (void *)&axp209_data,
>         }, {
> @@ -623,6 +662,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
>         struct axp20x_batt_ps *axp20x_batt;
>         struct power_supply_config psy_cfg = {};
>         struct power_supply_battery_info *info;
> +       const struct power_supply_desc *ps_desc;
>         struct device *dev = &pdev->dev;
>
>         if (!of_device_is_available(pdev->dev.of_node))
> @@ -666,9 +706,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
>
>         axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
>
> -       axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
> -                                                      &axp20x_batt_ps_desc,
> -                                                      &psy_cfg);
> +       if (!axp20x_batt->data->has_fg)
> +               ps_desc = &axp192_batt_ps_desc;
> +       else
> +               ps_desc = &axp20x_batt_ps_desc;
> +
> +       axp20x_batt->batt = devm_power_supply_register(&pdev->dev, ps_desc, &psy_cfg);
>         if (IS_ERR(axp20x_batt->batt)) {
>                 dev_err(&pdev->dev, "failed to register power supply: %ld\n",
>                         PTR_ERR(axp20x_batt->batt));
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
