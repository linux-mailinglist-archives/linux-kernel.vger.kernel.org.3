Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510B550A1F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiFSLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFSLU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:20:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F969617A;
        Sun, 19 Jun 2022 04:20:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hj18so15592545ejb.0;
        Sun, 19 Jun 2022 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btc6MXZhlyojWTDihSijhm+Q441CgyvD6fYM+EfFunw=;
        b=GXdMSKnOw/4FAHb0hst8jYeTTuAkof8mytDAKFlhezLILOMSfr9uKo7/Misws4eDfn
         YS9UgOCqIjtp0qOzjfB0aRkl3/7KvTbvwC3YWpgaRE15ga0Gm5se518RJSswCWeI5Yq1
         NLnGjTNRi3PMCA9OcN2H27et3yUm7HIMGI4nIMzLu33F9NH9WQHjd8XaHAc+J9FpY2So
         cXBuCVneChgUstg8Tiz2AHucS4a2JmNMn7iaMPrh5IpMceJT7RAEzo3U7jLkgHlYRS8B
         cgLum/j9xftxpNs7KwjDGemB7urx3cMNj/KdFx5WcVzb2Y8SvETlWRwbptGMyER48XbK
         IjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btc6MXZhlyojWTDihSijhm+Q441CgyvD6fYM+EfFunw=;
        b=30idxoMCCLTDuGdzyf16AT0lqYqHf4ngjuPkjmyE54He8PW9/3KheNWvUNJExfWFfR
         t/ir1z6UQA9gy9e3dfbb+ODMXepk4gfSUwdp0UkP2F+5BL1rG0sTCWDlZeBg6kImcJl5
         nTxNYi3HZxfoRizEFaOkeHURiSI0c9Ok/+wwD4BV6Pteunmw9mxFSsCOLu1YKiyLPWWQ
         5ijbSvGO+yD88Sr4XYNpuNwqjfv2iRTQHQjHc8wruKLVbYbw3h+/6J8Auo1nUA0lMGnC
         F5eJcvkpgOCQ34cC18bZi5oEGfYnKC+4PoTtoB2lTrM9yDHHSv9WeKPid3beNlp4z3nj
         f6qw==
X-Gm-Message-State: AJIora8GvscGnrnHAa+FipGievCj58oIUaOt3pMp9khVRhxFcd64kOah
        fQB5+2zLd4vejz/A1kOnX1fuN3WcsTzgHPhtMdY=
X-Google-Smtp-Source: AGRyM1vRDs4b0DmyMmlI7Kp5Hnc/HCHpZMI8j/okNewGXTikOc7OES4Dg2/VBxDVS18rUgEWBv0KD0aBAs7YqcNIAnA=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr16805100eja.44.1655637653799; Sun, 19
 Jun 2022 04:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:20:17 +0200
Message-ID: <CAHp75Vev77nG-Ui9cp9Bz8KPcq67E3htCTYnu4NNMV0_UP9=rw@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
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

On Sat, Jun 18, 2022 at 11:40 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192 PMIC's GPIO registers are much different from the GPIO
> registers of the AXP20x and AXP813 PMICs supported by the existing
> pinctrl-axp209 driver. It makes more sense to add a new driver for
> the AXP192, rather than add support in the existing axp20x driver.
>
> The pinctrl-axp192 driver is considerably more flexible in terms of
> register layout and should be able to support other X-Powers PMICs.
> Interrupts and pull down resistor configuration are supported too.

...

> +config PINCTRL_AXP192
> +       tristate "X-Powers AXP192 PMIC pinctrl and GPIO Support"
> +       depends on MFD_AXP20X


> +       depends on OF

Why?

> +       select PINMUX
> +       select GENERIC_PINCONF
> +       select GPIOLIB

...

> +#include <linux/of.h>
> +#include <linux/of_device.h>

Why?

...

> +struct axp192_pctl_function {
> +       const char              *name;
> +       /* Mux value written to the control register to select the function (-1 if unsupported) */

Comment is misleading. -1 can't be a value of unsigned type.

> +       const u8                *muxvals;
> +       const char * const      *groups;
> +       unsigned int            ngroups;
> +};

...

> +struct axp192_pctl_desc {
> +       unsigned int                            npins;
> +       const struct pinctrl_pin_desc           *pins;
> +       /* Description of the function control register for each pin */
> +       const struct axp192_pctl_reg_info       *ctrl_regs;
> +       /* Description of the output signal register for each pin */
> +       const struct axp192_pctl_reg_info       *out_regs;
> +       /* Description of the input signal register for each pin */
> +       const struct axp192_pctl_reg_info       *in_regs;
> +       /* Description of the pull down resistor config register for each pin */

Can you just convert these comments to a kernel-doc?

> +       const struct axp192_pctl_reg_info       *pull_down_regs;
> +
> +       unsigned int                            nfunctions;
> +       const struct axp192_pctl_function       *functions;
> +};

...

> +
> +

One blank line is enough.

...

> +       switch (param) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +               ret = axp192_pinconf_get_pull_down(pctldev, pin);
> +               if (ret < 0)
> +                       return ret;

> +               else if (ret != 0)

1. Redundant 'else'
2. if (ret > 0)

> +                       return -EINVAL;
> +               break;
> +
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +               ret = axp192_pinconf_get_pull_down(pctldev, pin);
> +               if (ret < 0)
> +                       return ret;
> +               else if (ret == 0)

Ditto.

Looking at this I would rather expect the function to return something
defined, than 0, non-0.

> +                       return -EINVAL;
> +               break;

> +       default:
> +               return -ENOTSUPP;
> +       }

...

> +       for (cfg = 0; cfg < num_configs; ++cfg) {

cfg++ will work the same way and easier to read.

> +               switch (pinconf_to_config_param(configs[cfg])) {
> +               case PIN_CONFIG_BIAS_DISABLE:
> +                       ret = axp192_pinconf_set_pull_down(pctldev, pin, 0);
> +                       if (ret)
> +                               return ret;
> +                       break;
> +
> +               case PIN_CONFIG_BIAS_PULL_DOWN:
> +                       ret = axp192_pinconf_set_pull_down(pctldev, pin, 1);
> +                       if (ret)
> +                               return ret;
> +                       break;
> +
> +               default:
> +                       return -ENOTSUPP;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct pinconf_ops axp192_conf_ops = {
> +       .is_generic = true,
> +       .pin_config_get = axp192_pinconf_get,
> +       .pin_config_set = axp192_pinconf_set,
> +       .pin_config_group_get = axp192_pinconf_get,
> +       .pin_config_group_set = axp192_pinconf_set,
> +};
> +
> +static int axp192_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset, u8 config)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct axp192_pctl_reg_info *reginfo = &pctl->desc->ctrl_regs[offset];
> +       unsigned int regval = config << (ffs(reginfo->mask) - 1);
> +
> +       return regmap_update_bits(pctl->regmap, reginfo->reg, reginfo->mask, regval);
> +}
> +
> +static int axp192_pmx_func_cnt(struct pinctrl_dev *pctldev)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->desc->nfunctions;
> +}
> +
> +static const char *axp192_pmx_func_name(struct pinctrl_dev *pctldev, unsigned int selector)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->desc->functions[selector].name;
> +}
> +
> +static int axp192_pmx_func_groups(struct pinctrl_dev *pctldev, unsigned int selector,
> +                                 const char * const **groups, unsigned int *num_groups)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       *groups = pctl->desc->functions[selector].groups;
> +       *num_groups = pctl->desc->functions[selector].ngroups;
> +
> +       return 0;
> +}
> +
> +static int axp192_pmx_set_mux(struct pinctrl_dev *pctldev,
> +                             unsigned int function, unsigned int group)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       const u8 *muxvals = pctl->desc->functions[function].muxvals;
> +
> +       if (muxvals[group] == U8_MAX)
> +               return -EINVAL;
> +
> +       /*
> +        * Switching to LDO or PWM function will enable LDO/PWM output, so it's
> +        * better to ignore these requests and let the regulator or PWM drivers
> +        * handle muxing to avoid interfering with them.
> +        */
> +       if (function == AXP192_FUNC_LDO || function == AXP192_FUNC_PWM)
> +               return 0;
> +
> +       return axp192_pmx_set(pctldev, group, muxvals[group]);
> +}
> +
> +static int axp192_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> +                                        struct pinctrl_gpio_range *range,
> +                                        unsigned int offset, bool input)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       const u8 *muxvals = input ? pctl->desc->functions[AXP192_FUNC_INPUT].muxvals
> +                                 : pctl->desc->functions[AXP192_FUNC_OUTPUT].muxvals;
> +
> +       return axp192_pmx_set(pctldev, offset, muxvals[offset]);
> +}
> +
> +static const struct pinmux_ops axp192_pmx_ops = {
> +       .get_functions_count    = axp192_pmx_func_cnt,
> +       .get_function_name      = axp192_pmx_func_name,
> +       .get_function_groups    = axp192_pmx_func_groups,
> +       .set_mux                = axp192_pmx_set_mux,
> +       .gpio_set_direction     = axp192_pmx_gpio_set_direction,
> +       .strict                 = true,
> +};
> +
> +static int axp192_groups_cnt(struct pinctrl_dev *pctldev)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->desc->npins;
> +}
> +
> +static const char *axp192_group_name(struct pinctrl_dev *pctldev, unsigned int selector)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       return pctl->desc->pins[selector].name;
> +}
> +
> +static int axp192_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
> +                            const unsigned int **pins, unsigned int *num_pins)
> +{
> +       struct axp192_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +       *pins = &pctl->desc->pins[selector].number;
> +       *num_pins = 1;
> +
> +       return 0;
> +}
> +
> +static const struct pinctrl_ops axp192_pctrl_ops = {
> +       .dt_node_to_map         = pinconf_generic_dt_node_to_map_group,
> +       .dt_free_map            = pinconf_generic_dt_free_map,
> +       .get_groups_count       = axp192_groups_cnt,
> +       .get_group_name         = axp192_group_name,
> +       .get_group_pins         = axp192_group_pins,
> +};
> +
> +static int axp192_pctl_probe(struct platform_device *pdev)
> +{
> +       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +       struct axp192_pctl *pctl;
> +       struct pinctrl_desc *pctrl_desc;
> +       int ret, i;
> +
> +       pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
> +       if (!pctl)
> +               return -ENOMEM;
> +
> +       pctl->desc = device_get_match_data(&pdev->dev);
> +       pctl->regmap = axp20x->regmap;
> +       pctl->regmap_irqc = axp20x->regmap_irqc;
> +       pctl->dev = &pdev->dev;
> +
> +       pctl->chip.base                 = -1;
> +       pctl->chip.can_sleep            = true;
> +       pctl->chip.request              = gpiochip_generic_request;
> +       pctl->chip.free                 = gpiochip_generic_free;
> +       pctl->chip.parent               = &pdev->dev;
> +       pctl->chip.label                = dev_name(&pdev->dev);
> +       pctl->chip.owner                = THIS_MODULE;
> +       pctl->chip.get                  = axp192_gpio_get;
> +       pctl->chip.get_direction        = axp192_gpio_get_direction;
> +       pctl->chip.set                  = axp192_gpio_set;
> +       pctl->chip.direction_input      = axp192_gpio_direction_input;
> +       pctl->chip.direction_output     = axp192_gpio_direction_output;
> +       pctl->chip.to_irq               = axp192_gpio_to_irq;
> +       pctl->chip.ngpio                = pctl->desc->npins;
> +
> +       pctl->irqs = devm_kcalloc(&pdev->dev, pctl->desc->npins, sizeof(int), GFP_KERNEL);
> +       if (!pctl->irqs)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < pctl->desc->npins; ++i) {
> +               ret = platform_get_irq_byname_optional(pdev, pctl->desc->pins[i].name);
> +               if (ret > 0)
> +                       pctl->irqs[i] = ret;
> +       }
> +
> +       platform_set_drvdata(pdev, pctl);
> +
> +       pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
> +       if (!pctrl_desc)
> +               return -ENOMEM;
> +
> +       pctrl_desc->name = dev_name(&pdev->dev);
> +       pctrl_desc->owner = THIS_MODULE;
> +       pctrl_desc->pins = pctl->desc->pins;
> +       pctrl_desc->npins = pctl->desc->npins;
> +       pctrl_desc->pctlops = &axp192_pctrl_ops;
> +       pctrl_desc->pmxops = &axp192_pmx_ops;
> +       pctrl_desc->confops = &axp192_conf_ops;
> +
> +       pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
> +       if (IS_ERR(pctl->pctl_dev))
> +               dev_err_probe(&pdev->dev, PTR_ERR(pctl->pctl_dev),
> +                             "couldn't register pinctrl driver\n");
> +
> +       ret = devm_gpiochip_add_data(&pdev->dev, &pctl->chip, pctl);
> +       if (ret)
> +               dev_err_probe(&pdev->dev, ret, "Failed to register GPIO chip\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id axp192_pctl_match[] = {
> +       { .compatible = "x-powers,axp192-gpio", .data = &axp192_data, },
> +       { }
> +};

-- 
With Best Regards,
Andy Shevchenko
