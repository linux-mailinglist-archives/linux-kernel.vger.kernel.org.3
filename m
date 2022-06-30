Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE45613E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiF3H7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiF3H6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:58:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40A1BE94;
        Thu, 30 Jun 2022 00:58:53 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o19so25792487ybg.2;
        Thu, 30 Jun 2022 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfxRQmWn6E5iGhcVqpo6ukaIRHZyh8KWaltMzz1QUAk=;
        b=MIprXsiaD6r0sdwwxHZnvGH3llQmDlTN9/9PqQ5GhKYSTAl2kQsYfNk6ZtPxPXDWd5
         1qS6z1rrKB9KoT95soWkompRONzWM3eCUpfPh+1BdElNd6FWyvSSVpfz8rm86XtzcSbk
         v14u5uDlxPNZS81cEl5PAnodvQ/w+az6B3gCB3oOOxmXJcBeBWIKrwB2xJVLYGuG2hFQ
         QML1J/+XWO0aLae2BgtORqEZCr6kaioqZy7Pu95UatncwWYMpGvC3/amPgaIHBJw3LaV
         JpHXMChuWGklJUHcdqqaN1ZQNbCLiDeDg03hidIz3iv9w0woRlChOdNYaA+6S6dkOz5C
         CEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfxRQmWn6E5iGhcVqpo6ukaIRHZyh8KWaltMzz1QUAk=;
        b=y5pJEdPLlyu8n0A5vnPO+1aSds9SbhKAWhgSoBrIiRhGTqX1n+hnm2rNuH8Ji2xS0b
         RB+iOWN9WdH2k5gf950vTnunp8heR+sIawI+X65eViQ2reWbTOcgNpbFocC2lmatHXOp
         Ee8RgSMGvttR69R7nZF9JkOGPqjperZ7Ggxrxl88DpY0vQHwSS431jzzShpB+wjWwkDH
         fLosELU98JaoSuEpPQDWR5E0wX6au5P2J9caBbJCC+TGkULqPMxn+aWO/8W9lgibbzvO
         GBiYTpFHoWnd9ktkq67+/32+qCBs1RxL3mknpk/vlF43fDQb1x5vo3vzr2ZbdlbSYYpY
         lSYA==
X-Gm-Message-State: AJIora+GXs+0nWvz/Rr7RjVRb6aCUAECZPxkSknRkYdYpQAWa7qP2O+Z
        aV8O8t35hG4KRc3SZVdoxyH5B3zLCm+Mcuhsx1w=
X-Google-Smtp-Source: AGRyM1uCRBwK4qEpvEe/oIY+2LOYXQuJFVwmbnYdYbTn+6Nb2y028jRiAxdCOSTtMueV28MbjKD6VW6kwM9l8yoPRhU=
X-Received: by 2002:a05:6902:1549:b0:66d:5f76:27ba with SMTP id
 r9-20020a056902154900b0066d5f7627bamr7696874ybu.385.1656575932662; Thu, 30
 Jun 2022 00:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-8-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-8-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:58:12 +0200
Message-ID: <CAHp75VeHeiqAM_2+91dMz2fDUqYiod8HnZobobe6FXgoYiJj6Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] regulator: axp20x: Add support for AXP192
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

On Wed, Jun 29, 2022 at 4:29 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Add support for the AXP192 PMIC.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 100 ++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index d260c442b788..ee79a9ed0249 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -27,6 +27,29 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
>
> +#define AXP192_GPIO0_FUNC_MASK         GENMASK(2, 0)
> +
> +#define AXP192_IO_ENABLED              0x02
> +#define AXP192_IO_DISABLED             0x06
> +
> +#define AXP192_WORKMODE_DCDC1_MASK     BIT_MASK(3)
> +#define AXP192_WORKMODE_DCDC2_MASK     BIT_MASK(2)
> +#define AXP192_WORKMODE_DCDC3_MASK     BIT_MASK(1)
> +
> +#define AXP192_DCDC1_V_OUT_MASK                GENMASK(6, 0)
> +#define AXP192_DCDC2_V_OUT_MASK                GENMASK(5, 0)
> +#define AXP192_DCDC3_V_OUT_MASK                GENMASK(6, 0)
> +#define AXP192_LDO2_V_OUT_MASK         GENMASK(7, 4)
> +#define AXP192_LDO3_V_OUT_MASK         GENMASK(3, 0)
> +#define AXP192_LDO_IO0_V_OUT_MASK      GENMASK(7, 4)
> +
> +#define AXP192_PWR_OUT_EXTEN_MASK      BIT_MASK(6)
> +#define AXP192_PWR_OUT_DCDC2_MASK      BIT_MASK(4)
> +#define AXP192_PWR_OUT_LDO3_MASK       BIT_MASK(3)
> +#define AXP192_PWR_OUT_LDO2_MASK       BIT_MASK(2)
> +#define AXP192_PWR_OUT_DCDC3_MASK      BIT_MASK(1)
> +#define AXP192_PWR_OUT_DCDC1_MASK      BIT_MASK(0)
> +
>  #define AXP20X_GPIO0_FUNC_MASK         GENMASK(3, 0)
>  #define AXP20X_GPIO1_FUNC_MASK         GENMASK(3, 0)
>
> @@ -375,25 +398,32 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
>
>         switch (axp20x->variant) {
>         case AXP209_ID:
> -               if (id == AXP20X_DCDC2) {
> +               if (id == AXP20X_LDO3) {
>                         slew_rates = axp209_dcdc2_ldo3_slew_rates;
>                         rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
>                         reg = AXP20X_DCDC2_LDO3_V_RAMP;
> -                       mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
> -                              AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
> +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
> +                              AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
>                         enable = (ramp > 0) ?
> -                                AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
> +                                AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
>                         break;
>                 }
>
> -               if (id == AXP20X_LDO3) {
> +               fallthrough;
> +
> +       case AXP192_ID:
> +               /*
> +                * AXP192 and AXP209 share the same DCDC2 ramp configuration
> +                */
> +               if ((axp20x->variant == AXP209_ID && id == AXP20X_DCDC2) ||
> +                   (axp20x->variant == AXP192_ID && id == AXP192_DCDC2)) {
>                         slew_rates = axp209_dcdc2_ldo3_slew_rates;
>                         rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
>                         reg = AXP20X_DCDC2_LDO3_V_RAMP;
> -                       mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
> -                              AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
> +                       mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
> +                              AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
>                         enable = (ramp > 0) ?
> -                                AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
> +                                AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
>                         break;
>                 }
>
> @@ -415,7 +445,8 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
>                         if (ramp > slew_rates[i])
>                                 break;
>
> -                       if (id == AXP20X_DCDC2)
> +                       if ((axp20x->variant == AXP209_ID && id == AXP20X_DCDC2) ||
> +                           (axp20x->variant == AXP192_ID && id == AXP192_DCDC2))
>                                 cfg = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(i);
>                         else
>                                 cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
> @@ -511,6 +542,29 @@ static const struct regulator_ops axp20x_ops_sw = {
>         .is_enabled             = regulator_is_enabled_regmap,
>  };
>
> +static const struct regulator_desc axp192_regulators[] = {
> +       AXP_DESC(AXP192, DCDC1, "dcdc1", "vin1", 700, 3500, 25,
> +                AXP192_DCDC1_V_OUT, AXP192_DCDC1_V_OUT_MASK,
> +                AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC1_MASK),
> +       AXP_DESC(AXP192, DCDC2, "dcdc2", "vin2", 700, 2275, 25,
> +                AXP192_DCDC2_V_OUT, AXP192_DCDC2_V_OUT_MASK,
> +                AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC2_MASK),
> +       AXP_DESC(AXP192, DCDC3, "dcdc3", "vin3", 700, 3500, 25,
> +                AXP192_DCDC3_V_OUT, AXP192_DCDC3_V_OUT_MASK,
> +                AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC3_MASK),
> +       AXP_DESC_FIXED(AXP192, LDO1, "ldo1", "acin", 1250),
> +       AXP_DESC(AXP192, LDO2, "ldo2", "ldoin", 1800, 3300, 100,
> +                AXP192_LDO2_3_V_OUT, AXP192_LDO2_V_OUT_MASK,
> +                AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_LDO2_MASK),
> +       AXP_DESC(AXP192, LDO3, "ldo3", "ldoin", 1800, 3300, 100,
> +                AXP192_LDO2_3_V_OUT, AXP192_LDO3_V_OUT_MASK,
> +                AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_LDO3_MASK),
> +       AXP_DESC_IO(AXP192, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
> +                   AXP192_LDO_IO0_V_OUT, AXP192_LDO_IO0_V_OUT_MASK,
> +                   AXP192_GPIO0_CTRL, AXP192_GPIO0_FUNC_MASK,
> +                   AXP192_IO_ENABLED, AXP192_IO_DISABLED),
> +};
> +
>  static const struct linear_range axp20x_ldo4_ranges[] = {
>         REGULATOR_LINEAR_RANGE(1250000,
>                                AXP20X_LDO4_V_OUT_1250mV_START,
> @@ -1008,6 +1062,12 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
>         u32 min, max, def, step;
>
>         switch (axp20x->variant) {
> +       case AXP192_ID:
> +               min = 900;
> +               max = 2025;
> +               def = 1500;
> +               step = 75;
> +               break;
>         case AXP202_ID:
>         case AXP209_ID:
>                 min = 750;
> @@ -1100,6 +1160,24 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
>         unsigned int mask;
>
>         switch (axp20x->variant) {
> +       case AXP192_ID:
> +               switch (id) {
> +               case AXP192_DCDC1:
> +                       mask = AXP192_WORKMODE_DCDC1_MASK;
> +                       break;
> +               case AXP192_DCDC2:
> +                       mask = AXP192_WORKMODE_DCDC2_MASK;
> +                       break;
> +               case AXP192_DCDC3:
> +                       mask = AXP192_WORKMODE_DCDC3_MASK;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +               workmode <<= ffs(mask) - 1;
> +               break;
> +
>         case AXP202_ID:
>         case AXP209_ID:
>                 if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
> @@ -1220,6 +1298,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
>         bool drivevbus = false;
>
>         switch (axp20x->variant) {
> +       case AXP192_ID:
> +               regulators = axp192_regulators;
> +               nregulators = AXP192_REG_ID_MAX;
> +               break;
>         case AXP202_ID:
>         case AXP209_ID:
>                 regulators = axp20x_regulators;
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
