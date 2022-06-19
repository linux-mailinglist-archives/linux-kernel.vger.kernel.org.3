Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9580C550815
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiFSDef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiFSDeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:34:31 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D989E0A9;
        Sat, 18 Jun 2022 20:34:28 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id f13so7590809vsp.1;
        Sat, 18 Jun 2022 20:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Kj9SPpug8cBKX+2BDdHQYhBwqfhkn6CkZ2XqJP7yndg=;
        b=nidaR0AdRMuMe9Dz9HbhxQh0sGZIcWG4MQFOUuoXR0d3uRWXRKM/DQRuLM1n/MskPX
         0z9rm3omaD51vdiTky0dysKixRwhMMxIMH8gm0tPQ89u9SRRuDxn9KHh0HkuBVSSk9Fb
         uj2uV4zaTrO1kGfhwCdGuEAu2UBJN3XDAfDElMK+RDO01h4qYAD/mL14jRWdzHHtaC3i
         N3x2toB73xXHfLYlVXiL5IwVmnTw3cgCmAjlA90dbOrMQIBog0mjPLVgS4YOE/DfQb7a
         rDYjtthgqu/SbyPzLyzUX6qMZr5xDmGvPgmL9SpmzyOU93QjChh7Zm8zjTtiiHanKCBt
         r73A==
X-Gm-Message-State: AJIora9UWoZANKriFnh7PioD+vR9poSYG0o80I8bMMfT0lTFz0M2hwJS
        qSYRsnEyfX50kN6xJe/kAqZja1829Mryrg==
X-Google-Smtp-Source: AGRyM1tu+9vPM7yvEVVAfewk4BP3Dx5byjjbG0CcO/SHyoglSze9Ihtm2YB29N5E94fOXh5cyui45w==
X-Received: by 2002:a67:c405:0:b0:34b:a23d:68ff with SMTP id c5-20020a67c405000000b0034ba23d68ffmr7254446vsk.80.1655609666902;
        Sat, 18 Jun 2022 20:34:26 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id s25-20020a67df19000000b003519349c5b8sm1522205vsk.32.2022.06.18.20.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 20:34:26 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id n4so7581531vsm.6;
        Sat, 18 Jun 2022 20:34:26 -0700 (PDT)
X-Received: by 2002:a05:6102:54ac:b0:34b:b502:f5e7 with SMTP id
 bk44-20020a05610254ac00b0034bb502f5e7mr7341066vsb.58.1655609665965; Sat, 18
 Jun 2022 20:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-13-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-13-aidanmacdonald.0x0@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 19 Jun 2022 11:34:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v65dhKvRGYwCa+s2h_T9WdfkfX1JJqJg1yTFJ2OZs7rtBQ@mail.gmail.com>
Message-ID: <CAGb2v65dhKvRGYwCa+s2h_T9WdfkfX1JJqJg1yTFJ2OZs7rtBQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] power: supply: axp20x_usb_power: Add support for AXP192
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, michael@walle.cc,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 5:40 AM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192 is mostly the same as the AXP202 but has a different
> current limit.
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 80 +++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index a1e6d1d44808..03145374ae72 100644
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
> @@ -121,6 +124,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
>                 mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
>  }
>
> +static int axp192_get_current_max(struct axp20x_usb_power *power, int *val)
> +{
> +       unsigned int v;
> +       int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
> +
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
> @@ -179,7 +200,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>         enum power_supply_property psp, union power_supply_propval *val)
>  {
>         struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> -       unsigned int input, v;
> +       unsigned int input, v, reg;
>         int ret;
>
>         switch (psp) {
> @@ -215,6 +236,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_CURRENT_MAX:
>                 if (power->axp20x_id == AXP813_ID)
>                         return axp813_get_current_max(power, &val->intval);
> +               else if (power->axp20x_id == AXP192_ID)
> +                       return axp192_get_current_max(power, &val->intval);
>                 return axp20x_get_current_max(power, &val->intval);
>         case POWER_SUPPLY_PROP_CURRENT_NOW:
>                 if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
> @@ -256,16 +279,20 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
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
> +                       /* Other chips do not have an OTG status register */
> +                       break;

Nit: put the comment on the same line as the break, trailing it.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
