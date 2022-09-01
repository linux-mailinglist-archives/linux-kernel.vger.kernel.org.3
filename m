Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FC5A8F64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiIAHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiIAHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:09:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352C01243CC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:08:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qh18so12473704ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T1a2n0TNcrK8BG/SkAbOxT72skaz9m2THYBGPmVrqkw=;
        b=hnKeXWRs7+MUYSmsPy4UqpjsS42ETkbAratKcQZCLzvtCI9QigOVlPzGm7UlQvMheR
         DLWpprUoJK1JeArbPQsC0LzSfdnv0WGYJ+ZvFIWeY0K0/iQdH8pwCLg+VZtDwRZNzXPo
         SYs9vIf8hxuJ4NJbcl5cw/f5B4hYupasTRAeSm/NgH1pcC/dv2oBW8D87H4lw9BbZhDc
         EAfRLhTk2lq72fDYZt7eTrEa8qHVZTRTzK1v2Rpt8ABTN+Q9G2/iQzr0kJWXZ/yQPtP1
         YiuXdWhW5DGUAzOisxqVl13XHXVm0ZMTldz0QDgKsvDQvfoETIZOe0PsU1ix89NrFj5O
         L2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T1a2n0TNcrK8BG/SkAbOxT72skaz9m2THYBGPmVrqkw=;
        b=gK+K0MvD1nivjZgvZlZ0txgpPAOq8fCQBd/JcdKGHABs7R+Tz+4HhlIUF6pyBNBDHJ
         MNBsAl3TTMQhTcdNIyFNg9C0Yp40fmqwj+z6tdMpwAbncwKXX7j4trD4WhAd6Wpc+wiw
         3S8aUD5HAeu5vRjpNQ5sXp88OPHSmpU27IeJN+xBYmytjEZhemnZdj3iphgChSax+fao
         NNFgPgztEjC/JKzmZYjkcA1yPJpNMdH0mhfDzggnU4uULILEIKiVRMW9BPsCQarpG8sH
         bifWhG9RnKcOpf4Izozbm9NT2cznVrkU4v8BCAdJK/ZEUAFtB4UO8EWboIPSkn3DG2jm
         pLrw==
X-Gm-Message-State: ACgBeo3dAK3mdde+dSQEux8HHlN7vcSDAlTn4w+9VIaOu5eTmMp5LgSM
        bexNzcpB5w3zujfY30c/L8m5tsRXQAAzQd1MGolcQ2BkZ64=
X-Google-Smtp-Source: AA6agR6pWO4tm1B3xV/+1WwC/UgTI+pM0Sz8blfO7fCz7raFul87Ipx2LIG7Rkcc6bOZUHhhJ/DfIORZELtiTal/q6M=
X-Received: by 2002:a17:906:8a4e:b0:730:9fcd:d988 with SMTP id
 gx14-20020a1709068a4e00b007309fcdd988mr22695166ejc.636.1662016117115; Thu, 01
 Sep 2022 00:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220831134516.78108-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdQiBHr3cDPWN_PRj2nGVoG-GJJyRNrHNwTaAUvz=35ew@mail.gmail.com> <2022090109473952058033@rock-chips.com>
In-Reply-To: <2022090109473952058033@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 1 Sep 2022 09:08:26 +0200
Message-ID: <CAMRc=McXoBqm-SBJTWdULZGep98V5-z3O9Dygkd07H=Z2k0-HA@mail.gmail.com>
Subject: Re: Re: [PATCH v2 1/1] gpio: rockchip: Switch to use fwnode instead
 of of_node
To:     "jay.xu@rock-chips.com" <jay.xu@rock-chips.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 3:47 AM jay.xu@rock-chips.com
<jay.xu@rock-chips.com> wrote:
>
> Hi
>
> --------------
> jay.xu@rock-chips.com
> >On Wed, Aug 31, 2022 at 3:45 PM Andy Shevchenko
> ><andriy.shevchenko@linux.intel.com> wrote:
> >>
> >> GPIO library now accepts fwnode as a firmware node, so
> >> switch the driver to use it.
> >>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >> v2: fixed compilation errors (LKP), replace some OF calls (Bart)
> >>  drivers/gpio/gpio-rockchip.c       | 38 +++++++++++-------------------
> >>  drivers/pinctrl/pinctrl-rockchip.h |  2 --
> >>  2 files changed, 14 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> >> index bb50335239ac..e8fa99fd4c80 100644
> >> --- a/drivers/gpio/gpio-rockchip.c
> >> +++ b/drivers/gpio/gpio-rockchip.c
> >> @@ -14,12 +14,11 @@
> >>  #include <linux/init.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/io.h>
> >> +#include <linux/mod_devicetable.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >> -#include <linux/of_address.h>
> >> -#include <linux/of_device.h>
> >> -#include <linux/of_irq.h>
> >>  #include <linux/pinctrl/pinconf-generic.h>
> >> +#include <linux/property.h>
> >>  #include <linux/regmap.h>
> >>
> >>  #include "../pinctrl/core.h"
> >> @@ -518,7 +517,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
> >>         struct irq_chip_generic *gc;
> >>         int ret;
> >>
> >> -       bank->domain = irq_domain_add_linear(bank->of_node, 32,
> >> +       bank->domain = irq_domain_create_linear(dev_fwnode(bank->dev), 32,
> >>                                         &irq_generic_chip_ops, NULL);
> >>         if (!bank->domain) {
> >>                 dev_warn(bank->dev, "could not init irq domain for bank %s\n",
> >> @@ -606,14 +605,10 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
> >>          * files which don't set the "gpio-ranges" property or systems that
> >>          * utilize ACPI the driver has to call gpiochip_add_pin_range().
> >>          */
> >> -       if (!of_property_read_bool(bank->of_node, "gpio-ranges")) {
> >> -               struct device_node *pctlnp = of_get_parent(bank->of_node);
> >> +       if (!device_property_read_bool(bank->dev, "gpio-ranges")) {
> >>                 struct pinctrl_dev *pctldev = NULL;
> >>
> >> -               if (!pctlnp)
> >> -                       return -ENODATA;
> >> -
> >> -               pctldev = of_pinctrl_get(pctlnp);
> >> +               pctldev = pinctrl_get(bank->dev->parent);
> >>                 if (!pctldev)
> >>                         return -ENODEV;
> >>
> >> @@ -641,23 +636,20 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
> >>
> >>  static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
> >>  {
> >> +       struct platform_device *pdev = to_platform_device(bank->dev);
> >> +       struct device_node *np = bank->dev->of_node;
> >>         struct resource res;
> >>         int id = 0;
> >>
> >> -       if (of_address_to_resource(bank->of_node, 0, &res)) {
> >> -               dev_err(bank->dev, "cannot find IO resource for bank\n");
> >> -               return -ENOENT;
> >> -       }
> >> -
> >> -       bank->reg_base = devm_ioremap_resource(bank->dev, &res);
> >> +       bank->reg_base = devm_platform_ioremap_resource(pdev, 0);
> >>         if (IS_ERR(bank->reg_base))
> >>                 return PTR_ERR(bank->reg_base);
> >>
> >> -       bank->irq = irq_of_parse_and_map(bank->of_node, 0);
> >> +       bank->irq = platform_get_irq(pdev, 0);
> >>         if (!bank->irq)
> >>                 return -EINVAL;
> >>
> >> -       bank->clk = of_clk_get(bank->of_node, 0);
> >> +       bank->clk = of_clk_get(np, 0);
> >
> >Why did you stop above? Why not regular clk_get here?
> >
> >>         if (IS_ERR(bank->clk))
> >>                 return PTR_ERR(bank->clk);
> >>
> >> @@ -668,7 +660,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
> >>         if (id == GPIO_TYPE_V2 || id == GPIO_TYPE_V2_1) {
> >>                 bank->gpio_regs = &gpio_regs_v2;
> >>                 bank->gpio_type = GPIO_TYPE_V2;
> >> -               bank->db_clk = of_clk_get(bank->of_node, 1);
> >> +               bank->db_clk = of_clk_get(np, 1);
> >
> >Ah, the clocks don't have names in DT? That's unfortunate...
>
> The patch add 'clock-names' property for gpio dt node, after that, the driver can change to
> devm_clk_get(dev, "bus");
> devm_clk_get(dev, "db");
>

We can't unfortunately, we need to remain compatible with existing DTs.

Bart

> https://patchwork.kernel.org/project/linux-rockchip/patch/20220901013101.2634480-2-jay.xu@rock-chips.com
>
> >
> >Bart
> >
> >>                 if (IS_ERR(bank->db_clk)) {
> >>                         dev_err(bank->dev, "cannot find debounce clk\n");
> >>                         clk_disable_unprepare(bank->clk);
> >> @@ -705,17 +697,16 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
> >>  {
> >>         struct device *dev = &pdev->dev;
> >>         struct device_node *np = dev->of_node;
> >> -       struct device_node *pctlnp = of_get_parent(np);
> >>         struct pinctrl_dev *pctldev = NULL;
> >>         struct rockchip_pin_bank *bank = NULL;
> >>         struct rockchip_pin_deferred *cfg;
> >>         static int gpio;
> >>         int id, ret;
> >>
> >> -       if (!np || !pctlnp)
> >> +       if (!dev->parent)
> >>                 return -ENODEV;
> >>
> >> -       pctldev = of_pinctrl_get(pctlnp);
> >> +       pctldev = pinctrl_get(dev->parent);
> >>         if (!pctldev)
> >>                 return -EPROBE_DEFER;
> >>
> >> @@ -728,7 +719,6 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
> >>                 return -EINVAL;
> >>
> >>         bank->dev = dev;
> >> -       bank->of_node = np;
> >>
> >>         raw_spin_lock_init(&bank->slock);
> >>
> >> @@ -776,7 +766,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
> >>         mutex_unlock(&bank->deferred_lock);
> >>
> >>         platform_set_drvdata(pdev, bank);
> >> -       dev_info(dev, "probed %pOF\n", np);
> >> +       dev_info(dev, "probed %pfw\n", dev_fwnode(dev));
> >>
> >>         return 0;
> >>  }
> >> diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
> >> index 4759f336941e..37a0501bcc03 100644
> >> --- a/drivers/pinctrl/pinctrl-rockchip.h
> >> +++ b/drivers/pinctrl/pinctrl-rockchip.h
> >> @@ -299,7 +299,6 @@ struct rockchip_drv {
> >>   * @drv: array describing the 4 drive strength sources of the bank
> >>   * @pull_type: array describing the 4 pull type sources of the bank
> >>   * @valid: is all necessary information present
> >> - * @of_node: dt node of this bank
> >>   * @drvdata: common pinctrl basedata
> >>   * @domain: irqdomain of the gpio bank
> >>   * @gpio_chip: gpiolib chip
> >> @@ -327,7 +326,6 @@ struct rockchip_pin_bank {
> >>         struct rockchip_drv             drv[4];
> >>         enum rockchip_pin_pull_type     pull_type[4];
> >>         bool                            valid;
> >> -       struct device_node              *of_node;
> >>         struct rockchip_pinctrl         *drvdata;
> >>         struct irq_domain               *domain;
> >>         struct gpio_chip                gpio_chip;
> >> --
> >> 2.35.1
> >>
