Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563DD56140E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiF3IAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiF3IAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:00:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37441304;
        Thu, 30 Jun 2022 01:00:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3177f4ce3e2so171101327b3.5;
        Thu, 30 Jun 2022 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXJzLbog6MJ74pFBfsgk8qL8nqFotk4VAzV4IxDY2Z8=;
        b=CDVpU266vwg+nZGjOIqDIDXtqmdC30ZezHVdSz5okTFV6FQyV1OlKuD0XqUct0KgYt
         YEg1s2zo16B/1Wy8rPIFM/y1x3zp9p7if/ECsaEDeKkAlEsX+njd4b5yuRFJkne6v8Uv
         T/UJEbebioDSfjqJVtrvOQkbZBLVHvSfGlSKkkXp5owlLcy26T/3Q+VpszHeiFJ66bsc
         SMcb9aRmXR0nUtmVAtiCDwvJexLSTlqQnBOAud5B59AIZL5e/Y8SOG8LCeM8FsoCgfv/
         KFyWSeV13LQpYcpNKpnDun+1qcRkFFDOqgzlnLfKbG9wKtwpKHMsMhhpdU/dUxRS8s2W
         m3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXJzLbog6MJ74pFBfsgk8qL8nqFotk4VAzV4IxDY2Z8=;
        b=VjiV1B7KXpWSEHTr3col/8wIE2lTkW/DVoHNks9zPgPQfpubkhX/C2P6rKXWJ1VSh5
         4GI9abfyO5SAO4yoX7+H883JeYU7WQLfZIr435V4mTS8H8xFCZOlnyduNZemJHLbKKbB
         MGvbEHYlV7Pm89icdm1/5j0RI01fPYm1h0YyLPF3ZKhDO8f8kNTepNm132+PllY43Zuk
         RklicuKVKAkD4/MrarMwwj+Xh+jtEVmGIsOkfSdB2F/dEFv4YJH4XOfLpkoGoXb/5J6W
         wMbVENlT9KaJQKcxc0R0/eSoE7L5WiVRrnYacJYXlQt5Ih5QtsTy8b+AB3i8PchS6Ab/
         BHjw==
X-Gm-Message-State: AJIora9JniEcCj5v5QRLe1Eb5VWesn7c9YCoFgS/9CqXSEZfvN7ntH0G
        QgOpK9yRKPAytE1dPreaLMtq5pGSRImlSuFyasE=
X-Google-Smtp-Source: AGRyM1v4zwmzhbMhptAPn2N3SU98uSYBAsImAnNff2/xupAFRFXpuWYjRHqeRLK+eXYsjJZE9xZyaHAnQlxkK3KwkH4=
X-Received: by 2002:a81:1889:0:b0:317:987b:8e82 with SMTP id
 131-20020a811889000000b00317987b8e82mr8712949ywy.185.1656576001966; Thu, 30
 Jun 2022 01:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-12-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-12-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:59:23 +0200
Message-ID: <CAHp75VdReU+mJwf9ucE4GGfBhajf0AYq2tkcfWxWy0W2OESdJQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] power: supply: axp20x_usb_power: Add support for AXP192
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
> The AXP192's USB power supply is similar to the AXP202 but it has
> different USB current limits and a different offset for the VBUS
> status register.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 84 +++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index a1e6d1d44808..f83e2ed6d507 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -48,6 +48,9 @@
>  #define AXP813_VBUS_CLIMIT_2000mA      2
>  #define AXP813_VBUS_CLIMIT_2500mA      3
>
> +#define AXP192_VBUS_CLIMIT_EN          BIT(1)
> +#define AXP192_VBUS_CLIMIT_100mA       BIT(0)
> +
>  #define AXP20X_ADC_EN1_VBUS_CURR       BIT(2)
>  #define AXP20X_ADC_EN1_VBUS_VOLT       BIT(3)
>
> @@ -121,6 +124,25 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
>                 mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
>  }
>
> +static int axp192_get_current_max(struct axp20x_usb_power *power, int *val)
> +{
> +       unsigned int v;
> +       int ret;
> +
> +       ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
> +       if (ret)
> +               return ret;
> +
> +       if (!(v & AXP192_VBUS_CLIMIT_EN))
> +               *val = -1;
> +       else if (v & AXP192_VBUS_CLIMIT_100mA)
> +               *val = 100000;
> +       else
> +               *val = 500000;
> +
> +       return 0;
> +}
> +
>  static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
>  {
>         unsigned int v;
> @@ -179,7 +201,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>         enum power_supply_property psp, union power_supply_propval *val)
>  {
>         struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> -       unsigned int input, v;
> +       unsigned int input, v, reg;
>         int ret;
>
>         switch (psp) {
> @@ -215,6 +237,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_CURRENT_MAX:
>                 if (power->axp20x_id == AXP813_ID)
>                         return axp813_get_current_max(power, &val->intval);
> +               else if (power->axp20x_id == AXP192_ID)
> +                       return axp192_get_current_max(power, &val->intval);
>                 return axp20x_get_current_max(power, &val->intval);
>         case POWER_SUPPLY_PROP_CURRENT_NOW:
>                 if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
> @@ -256,16 +280,19 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>
>                 val->intval = POWER_SUPPLY_HEALTH_GOOD;
>
> -               if (power->axp20x_id == AXP202_ID) {
> -                       ret = regmap_read(power->regmap,
> -                                         AXP20X_USB_OTG_STATUS, &v);
> -                       if (ret)
> -                               return ret;
> +               if (power->axp20x_id == AXP192_ID)
> +                       reg = AXP192_USB_OTG_STATUS;
> +               else if (power->axp20x_id == AXP202_ID)
> +                       reg = AXP20X_USB_OTG_STATUS;
> +               else
> +                       break; /* Other chips lack the OTG status register */
>
> -                       if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
> -                               val->intval =
> -                                       POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> -               }
> +               ret = regmap_read(power->regmap, reg, &v);
> +               if (ret)
> +                       return ret;
> +
> +               if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
> +                       val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>                 break;
>         case POWER_SUPPLY_PROP_PRESENT:
>                 val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
> @@ -316,6 +343,28 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>         return -EINVAL;
>  }
>
> +static int axp192_usb_power_set_current_max(struct axp20x_usb_power *power,
> +                                           int intval)
> +{
> +       const unsigned int mask = AXP192_VBUS_CLIMIT_EN |
> +                                 AXP192_VBUS_CLIMIT_100mA;
> +       unsigned int val;
> +
> +       switch (intval) {
> +       case 100000:
> +               val = AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
> +               break;
> +       case 500000:
> +               val = AXP192_VBUS_CLIMIT_EN;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return regmap_update_bits(power->regmap,
> +                                 AXP20X_VBUS_IPSOUT_MGMT, mask, val);
> +}
> +
>  static int axp813_usb_power_set_current_max(struct axp20x_usb_power *power,
>                                             int intval)
>  {
> @@ -383,6 +432,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
>                 if (power->axp20x_id == AXP813_ID)
>                         return axp813_usb_power_set_current_max(power,
>                                                                 val->intval);
> +               else if (power->axp20x_id == AXP192_ID)
> +                       return axp192_usb_power_set_current_max(power,
> +                                                               val->intval);
>                 return axp20x_usb_power_set_current_max(power, val->intval);
>
>         default:
> @@ -468,6 +520,13 @@ struct axp_data {
>         enum axp20x_variants            axp20x_id;
>  };
>
> +static const struct axp_data axp192_data = {
> +       .power_desc     = &axp20x_usb_power_desc,
> +       .irq_names      = axp20x_irq_names,
> +       .num_irq_names  = ARRAY_SIZE(axp20x_irq_names),
> +       .axp20x_id      = AXP192_ID,
> +};
> +
>  static const struct axp_data axp202_data = {
>         .power_desc     = &axp20x_usb_power_desc,
>         .irq_names      = axp20x_irq_names,
> @@ -600,7 +659,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       if (power->axp20x_id == AXP202_ID) {
> +       if (power->axp20x_id == AXP192_ID || power->axp20x_id == AXP202_ID) {
>                 /* Enable vbus valid checking */
>                 ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
>                                          AXP20X_VBUS_MON_VBUS_VALID,
> @@ -659,6 +718,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>
>  static const struct of_device_id axp20x_usb_power_match[] = {
>         {
> +               .compatible = "x-powers,axp192-usb-power-supply",
> +               .data = &axp192_data,
> +       }, {
>                 .compatible = "x-powers,axp202-usb-power-supply",
>                 .data = &axp202_data,
>         }, {
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
