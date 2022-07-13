Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA8573D62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiGMTzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGMTy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:54:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C70220EB;
        Wed, 13 Jul 2022 12:54:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31c8a1e9e33so123974377b3.5;
        Wed, 13 Jul 2022 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feHmrhqGDVWnymiQN9BM3ZtEMWc17TVj98ORaz35UUM=;
        b=Ym0qV/N6r1/gnSSKaPgEYbxaZDDN8ww3yy7njcFtoWn8Z6p3vlQ9WdJ0Lmo2qqTFEk
         GY0gkxyq5YFdZP828uoJYSbeVaGwYKY18gECuefX/uYA9qdiYSE7ehLhoMMEK881jrTN
         6ILSlQzFfCsdxJ6016OjoS2nm2yfR8gpFlt5akjsIIJCYvXPzoVqetou7rx9NLmiy0Bb
         qnUobyjfJxytxrBLiGYiQMM47y4u6q+ZuUKACiwVWbLh/T0jbRAidZpWLbmV3LjetRVu
         EKZk/jpttFB9vMGTELT/uYiY0Lv1wW26omxxr0keyQ7fm1VDkAt1mM/21/nusRm5xbY2
         ZFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feHmrhqGDVWnymiQN9BM3ZtEMWc17TVj98ORaz35UUM=;
        b=1hDKSgC6uM2TSoPYO0BGmlYPuvuthgpwaQrqpVfYC4UGgGApQAOmDEBd0kK1+mTU1q
         JlfP96nBf9uamJKL+6//S/vO7jpY2VFGXaUxf5fAzfEpLopt2Zdyf8fE2r1hfCvc5Eg6
         2w//zzDcuUnWe6+ElFuu4y5RT1Q4eiFHibm1dZMHzoqlSOP7EuKNJrul1o6Hz9O2dY1s
         VuNrk5nW8PrcLlhluQc35kFI7totrEHS7tr4HCyMOUgbMjJMUYSXggUatZkIuaKDNgX1
         QHAGwBgH6EHlHVUzbKxc/6LzHk0JuKT3o/4N2lz0hS22SfJc26vUy2qAKbUvqofQa05R
         1mpg==
X-Gm-Message-State: AJIora971Ptv7fE33gJrlUvhZCIMtosGLDExbC685HGR9TWD6gsg4ZX0
        81fbaBrihgxt8gzZine++lTGD9PdrKQ6dAnt0/o=
X-Google-Smtp-Source: AGRyM1sFzI6B60+IcxgI/nIHExUDHzhWoiXeXJi7pwBjD2qVIjm98kxKw8fj6tPyzavTJABaJdDjlxnLWlYYLLBImTI=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr5972765ywa.277.1657742096505; Wed, 13
 Jul 2022 12:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220713193750.4079621-1-horatiu.vultur@microchip.com> <20220713193750.4079621-2-horatiu.vultur@microchip.com>
In-Reply-To: <20220713193750.4079621-2-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 21:54:19 +0200
Message-ID: <CAHp75Vd0UmKud5TyXki8OYZFGYh1fSauwDyKRap-N5V+jEOkEQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pinctrl: ocelot: Fix pincfg for lan966x
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

On Wed, Jul 13, 2022 at 9:34 PM Horatiu Vultur
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

I think there is still room for improvement (like refactoring all this
->get() and ->set() to avoid multiple parameter check, etc), but it is
out of scope and can be done later on. That said,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 531d6ab36571 ("pinctrl: ocelot: Extend support for lan966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-ocelot.c | 195 ++++++++++++++++++++-----------
>  1 file changed, 124 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> index 5f4a8c5c6650..c6e0232770b7 100644
> --- a/drivers/pinctrl/pinctrl-ocelot.c
> +++ b/drivers/pinctrl/pinctrl-ocelot.c
> @@ -29,19 +29,12 @@
>  #define ocelot_clrsetbits(addr, clear, set) \
>         writel((readl(addr) & ~(clear)) | (set), (addr))
>
> -/* PINCONFIG bits (sparx5 only) */
>  enum {
>         PINCONF_BIAS,
>         PINCONF_SCHMITT,
>         PINCONF_DRIVE_STRENGTH,
>  };
>
> -#define BIAS_PD_BIT BIT(4)
> -#define BIAS_PU_BIT BIT(3)
> -#define BIAS_BITS   (BIAS_PD_BIT|BIAS_PU_BIT)
> -#define SCHMITT_BIT BIT(2)
> -#define DRIVE_BITS  GENMASK(1, 0)
> -
>  /* GPIO standard registers */
>  #define OCELOT_GPIO_OUT_SET    0x0
>  #define OCELOT_GPIO_OUT_CLR    0x4
> @@ -321,6 +314,13 @@ struct ocelot_pin_caps {
>         unsigned char a_functions[OCELOT_FUNC_PER_PIN]; /* Additional functions */
>  };
>
> +struct ocelot_pincfg_data {
> +       u8 pd_bit;
> +       u8 pu_bit;
> +       u8 drive_bits;
> +       u8 schmitt_bit;
> +};
> +
>  struct ocelot_pinctrl {
>         struct device *dev;
>         struct pinctrl_dev *pctl;
> @@ -328,10 +328,16 @@ struct ocelot_pinctrl {
>         struct regmap *map;
>         struct regmap *pincfg;
>         struct pinctrl_desc *desc;
> +       const struct ocelot_pincfg_data *pincfg_data;
>         struct ocelot_pmx_func func[FUNC_MAX];
>         u8 stride;
>  };
>
> +struct ocelot_match_data {
> +       struct pinctrl_desc desc;
> +       struct ocelot_pincfg_data pincfg_data;
> +};
> +
>  #define LUTON_P(p, f0, f1)                                             \
>  static struct ocelot_pin_caps luton_pin_##p = {                                \
>         .pin = p,                                                       \
> @@ -1325,6 +1331,7 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
>         int ret = -EOPNOTSUPP;
>
>         if (info->pincfg) {
> +               const struct ocelot_pincfg_data *opd = info->pincfg_data;
>                 u32 regcfg;
>
>                 ret = regmap_read(info->pincfg, pin, &regcfg);
> @@ -1334,15 +1341,15 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
>                 ret = 0;
>                 switch (reg) {
>                 case PINCONF_BIAS:
> -                       *val = regcfg & BIAS_BITS;
> +                       *val = regcfg & (opd->pd_bit | opd->pu_bit);
>                         break;
>
>                 case PINCONF_SCHMITT:
> -                       *val = regcfg & SCHMITT_BIT;
> +                       *val = regcfg & opd->schmitt_bit;
>                         break;
>
>                 case PINCONF_DRIVE_STRENGTH:
> -                       *val = regcfg & DRIVE_BITS;
> +                       *val = regcfg & opd->drive_bits;
>                         break;
>
>                 default:
> @@ -1379,23 +1386,27 @@ static int ocelot_hw_set_value(struct ocelot_pinctrl *info,
>         int ret = -EOPNOTSUPP;
>
>         if (info->pincfg) {
> +               const struct ocelot_pincfg_data *opd = info->pincfg_data;
>
>                 ret = 0;
>                 switch (reg) {
>                 case PINCONF_BIAS:
> -                       ret = ocelot_pincfg_clrsetbits(info, pin, BIAS_BITS,
> +                       ret = ocelot_pincfg_clrsetbits(info, pin,
> +                                                      opd->pd_bit | opd->pu_bit,
>                                                        val);
>                         break;
>
>                 case PINCONF_SCHMITT:
> -                       ret = ocelot_pincfg_clrsetbits(info, pin, SCHMITT_BIT,
> +                       ret = ocelot_pincfg_clrsetbits(info, pin,
> +                                                      opd->schmitt_bit,
>                                                        val);
>                         break;
>
>                 case PINCONF_DRIVE_STRENGTH:
>                         if (val <= 3)
>                                 ret = ocelot_pincfg_clrsetbits(info, pin,
> -                                                              DRIVE_BITS, val);
> +                                                              opd->drive_bits,
> +                                                              val);
>                         else
>                                 ret = -EINVAL;
>                         break;
> @@ -1425,17 +1436,20 @@ static int ocelot_pinconf_get(struct pinctrl_dev *pctldev,
>                 if (param == PIN_CONFIG_BIAS_DISABLE)
>                         val = (val == 0);
>                 else if (param == PIN_CONFIG_BIAS_PULL_DOWN)
> -                       val = (val & BIAS_PD_BIT ? true : false);
> +                       val = !!(val & info->pincfg_data->pd_bit);
>                 else    /* PIN_CONFIG_BIAS_PULL_UP */
> -                       val = (val & BIAS_PU_BIT ? true : false);
> +                       val = !!(val & info->pincfg_data->pu_bit);
>                 break;
>
>         case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +               if (!info->pincfg_data->schmitt_bit)
> +                       return -EOPNOTSUPP;
> +
>                 err = ocelot_hw_get_value(info, pin, PINCONF_SCHMITT, &val);
>                 if (err)
>                         return err;
>
> -               val = (val & SCHMITT_BIT ? true : false);
> +               val = !!(val & info->pincfg_data->schmitt_bit);
>                 break;
>
>         case PIN_CONFIG_DRIVE_STRENGTH:
> @@ -1479,6 +1493,7 @@ static int ocelot_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                               unsigned long *configs, unsigned int num_configs)
>  {
>         struct ocelot_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
> +       const struct ocelot_pincfg_data *opd = info->pincfg_data;
>         u32 param, arg, p;
>         int cfg, err = 0;
>
> @@ -1491,8 +1506,8 @@ static int ocelot_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                 case PIN_CONFIG_BIAS_PULL_UP:
>                 case PIN_CONFIG_BIAS_PULL_DOWN:
>                         arg = (param == PIN_CONFIG_BIAS_DISABLE) ? 0 :
> -                       (param == PIN_CONFIG_BIAS_PULL_UP) ? BIAS_PU_BIT :
> -                       BIAS_PD_BIT;
> +                             (param == PIN_CONFIG_BIAS_PULL_UP) ?
> +                               opd->pu_bit : opd->pd_bit;
>
>                         err = ocelot_hw_set_value(info, pin, PINCONF_BIAS, arg);
>                         if (err)
> @@ -1501,7 +1516,10 @@ static int ocelot_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                         break;
>
>                 case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -                       arg = arg ? SCHMITT_BIT : 0;
> +                       if (!opd->schmitt_bit)
> +                               return -EOPNOTSUPP;
> +
> +                       arg = arg ? opd->schmitt_bit : 0;
>                         err = ocelot_hw_set_value(info, pin, PINCONF_SCHMITT,
>                                                   arg);
>                         if (err)
> @@ -1562,69 +1580,94 @@ static const struct pinctrl_ops ocelot_pctl_ops = {
>         .dt_free_map = pinconf_generic_dt_free_map,
>  };
>
> -static struct pinctrl_desc luton_desc = {
> -       .name = "luton-pinctrl",
> -       .pins = luton_pins,
> -       .npins = ARRAY_SIZE(luton_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &ocelot_pmx_ops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data luton_desc = {
> +       .desc = {
> +               .name = "luton-pinctrl",
> +               .pins = luton_pins,
> +               .npins = ARRAY_SIZE(luton_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .owner = THIS_MODULE,
> +       },
>  };
>
> -static struct pinctrl_desc serval_desc = {
> -       .name = "serval-pinctrl",
> -       .pins = serval_pins,
> -       .npins = ARRAY_SIZE(serval_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &ocelot_pmx_ops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data serval_desc = {
> +       .desc = {
> +               .name = "serval-pinctrl",
> +               .pins = serval_pins,
> +               .npins = ARRAY_SIZE(serval_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .owner = THIS_MODULE,
> +       },
>  };
>
> -static struct pinctrl_desc ocelot_desc = {
> -       .name = "ocelot-pinctrl",
> -       .pins = ocelot_pins,
> -       .npins = ARRAY_SIZE(ocelot_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &ocelot_pmx_ops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data ocelot_desc = {
> +       .desc = {
> +               .name = "ocelot-pinctrl",
> +               .pins = ocelot_pins,
> +               .npins = ARRAY_SIZE(ocelot_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .owner = THIS_MODULE,
> +       },
>  };
>
> -static struct pinctrl_desc jaguar2_desc = {
> -       .name = "jaguar2-pinctrl",
> -       .pins = jaguar2_pins,
> -       .npins = ARRAY_SIZE(jaguar2_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &ocelot_pmx_ops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data jaguar2_desc = {
> +       .desc = {
> +               .name = "jaguar2-pinctrl",
> +               .pins = jaguar2_pins,
> +               .npins = ARRAY_SIZE(jaguar2_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .owner = THIS_MODULE,
> +       },
>  };
>
> -static struct pinctrl_desc servalt_desc = {
> -       .name = "servalt-pinctrl",
> -       .pins = servalt_pins,
> -       .npins = ARRAY_SIZE(servalt_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &ocelot_pmx_ops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data servalt_desc = {
> +       .desc = {
> +               .name = "servalt-pinctrl",
> +               .pins = servalt_pins,
> +               .npins = ARRAY_SIZE(servalt_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .owner = THIS_MODULE,
> +       },
>  };
>
> -static struct pinctrl_desc sparx5_desc = {
> -       .name = "sparx5-pinctrl",
> -       .pins = sparx5_pins,
> -       .npins = ARRAY_SIZE(sparx5_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &ocelot_pmx_ops,
> -       .confops = &ocelot_confops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data sparx5_desc = {
> +       .desc = {
> +               .name = "sparx5-pinctrl",
> +               .pins = sparx5_pins,
> +               .npins = ARRAY_SIZE(sparx5_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &ocelot_pmx_ops,
> +               .confops = &ocelot_confops,
> +               .owner = THIS_MODULE,
> +       },
> +       .pincfg_data = {
> +               .pd_bit = BIT(4),
> +               .pu_bit = BIT(3),
> +               .drive_bits = GENMASK(1, 0),
> +               .schmitt_bit = BIT(2),
> +       },
>  };
>
> -static struct pinctrl_desc lan966x_desc = {
> -       .name = "lan966x-pinctrl",
> -       .pins = lan966x_pins,
> -       .npins = ARRAY_SIZE(lan966x_pins),
> -       .pctlops = &ocelot_pctl_ops,
> -       .pmxops = &lan966x_pmx_ops,
> -       .confops = &ocelot_confops,
> -       .owner = THIS_MODULE,
> +static struct ocelot_match_data lan966x_desc = {
> +       .desc = {
> +               .name = "lan966x-pinctrl",
> +               .pins = lan966x_pins,
> +               .npins = ARRAY_SIZE(lan966x_pins),
> +               .pctlops = &ocelot_pctl_ops,
> +               .pmxops = &lan966x_pmx_ops,
> +               .confops = &ocelot_confops,
> +               .owner = THIS_MODULE,
> +       },
> +       .pincfg_data = {
> +               .pd_bit = BIT(3),
> +               .pu_bit = BIT(2),
> +               .drive_bits = GENMASK(1, 0),
> +       },
>  };
>
>  static int ocelot_create_group_func_map(struct device *dev,
> @@ -1913,6 +1956,7 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
>
>  static int ocelot_pinctrl_probe(struct platform_device *pdev)
>  {
> +       const struct ocelot_match_data *data;
>         struct device *dev = &pdev->dev;
>         struct ocelot_pinctrl *info;
>         struct reset_control *reset;
> @@ -1929,7 +1973,16 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
>         if (!info)
>                 return -ENOMEM;
>
> -       info->desc = (struct pinctrl_desc *)device_get_match_data(dev);
> +       data = device_get_match_data(dev);
> +       if (!data)
> +               return -EINVAL;
> +
> +       info->desc = devm_kmemdup(dev, &data->desc, sizeof(*info->desc),
> +                                 GFP_KERNEL);
> +       if (!info->desc)
> +               return -ENOMEM;
> +
> +       info->pincfg_data = &data->pincfg_data;
>
>         reset = devm_reset_control_get_optional_shared(dev, "switch");
>         if (IS_ERR(reset))
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
