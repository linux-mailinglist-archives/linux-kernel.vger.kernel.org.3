Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D780E47BAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhLUHUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhLUHUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:20:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F2C061574;
        Mon, 20 Dec 2021 23:20:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v11so7734645pfu.2;
        Mon, 20 Dec 2021 23:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ObUPhqpWwTouNCuoLzA1KcgTG5hN6MdHJqs9Xl12/U=;
        b=FLehgk2fgy5t8oDoa+NTU0U/9b3q+mMJlEmBIn3P2WRJynT5Lu+FgBmN/9JXwuCna8
         m5wBppA6fXww04dLhcfqU+m3N/KUjCi+RBJ6YMq96lhEkaZt2L07+soglO/nbg/bGaJF
         DcZJPgjjFUHQwORLFtI4M6meOxIjyu//dVY2vrL2JhmpR7BR2vZrN072yxTkYZ/T/MO+
         os8zqMK1z+VVjA1qRH+6/uaecLAyXM1UQkDDRvlCq+Ws5r2ILgPfPcvTv236JXpfSKG+
         v6oeSKs4QNeEQLnMzhbcRHDDtyjPahOLiaW4blU5k0pJD0f+gtgcSsEa6zyz7IGVhPSx
         KbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ObUPhqpWwTouNCuoLzA1KcgTG5hN6MdHJqs9Xl12/U=;
        b=cp7MK7uhrxutxEH+rBRmPvEUPmcIJZ7fQB8azzVCLWACqJhPyEEgLrJKcCqIGljvYj
         h2L0FTUM+Sss1n/K33h4UHg6vYIBzUcRRD/nSVKOj2zI2TA1kAPFwJ9e7ITb0YMLgK2G
         PSyQIAUwAlepMOaQ/MrvUDa2SVdC6X4TWD1eIuUpl7X/CEKevtKJGbfQfDmHhW5QykAT
         6pFZoeEVECYIxUXV84i1XgExvrcT6GOEuQzxbXSVIIh+ctLz2ECzZNrIUQ5K9Co9O/HS
         bxpg6MprqRAJ+k0U+lcpNyFPvmvrLtlmteWcj4OGZIh040n3PeiTghhqebf4xqjkjlPA
         jzpQ==
X-Gm-Message-State: AOAM531JEpbnvkDPagB/15r2Jy1RRuH+HW1+a2mnFomsZYBpHH4cuG91
        kAyG8p/izaY1RM+XIrHPMosWcq0h/7JUmWXDXVg=
X-Google-Smtp-Source: ABdhPJxj4qcLMbJH0XTCwDNvca38wOyXZf6gdAib+OsebdFBRE5UXO0qSy3QuoXgNrCfje6YJS9NtrOqlBeDaEeBXM4=
X-Received: by 2002:a63:787:: with SMTP id 129mr1798472pgh.289.1640071245322;
 Mon, 20 Dec 2021 23:20:45 -0800 (PST)
MIME-Version: 1.0
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639741568-5846-3-git-send-email-hammer.hsieh@sunplus.com> <20211217152839.vjzgvpha2shcitdj@pengutronix.de>
In-Reply-To: <20211217152839.vjzgvpha2shcitdj@pengutronix.de>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Tue, 21 Dec 2021 15:20:50 +0800
Message-ID: <CAOX-t54zLwaL7=AGOS9zAdQVKbwBCu5ZyC5MDG0pUTj6UNFCyw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pwm:sunplus-pwm:Add Sunplus SoC PWM Driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi: Uwe:

Thanks for your review.
Please see my response below.

Regards,
Hammer Hsieh

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2021=E5=B9=
=B412=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:28=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Fri, Dec 17, 2021 at 07:46:08PM +0800, Hammer Hsieh wrote:
> > Add Sunplus SoC PWM Driver
> >
> > Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
> > ---
> >  MAINTAINERS               |   1 +
> >  drivers/pwm/Kconfig       |  11 +++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-sunplus.c | 192 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 205 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sunplus.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 721ed79..1c9e3c5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18246,6 +18246,7 @@ SUNPLUS PWM DRIVER
> >  M:   Hammer Hsieh <hammer.hsieh@sunplus.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> > +F:   drivers/pwm/pwm-sunplus.c
> >
> >  SUPERH
> >  M:   Yoshinori Sato <ysato@users.sourceforge.jp>
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 21e3b05..9df5d5f 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -526,6 +526,17 @@ config PWM_SPRD
> >         To compile this driver as a module, choose M here: the module
> >         will be called pwm-sprd.
> >
> > +config PWM_SUNPLUS
> > +     tristate "Sunplus PWM support"
> > +     depends on ARCH_SUNPLUS || COMPILE_TEST
> > +     depends on HAS_IOMEM && OF
> > +     help
> > +       Generic PWM framework driver for the PWM controller on
> > +       Sunplus SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called pwm-sunplus.
> > +
> >  config PWM_STI
> >       tristate "STiH4xx PWM support"
> >       depends on ARCH_STI || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 708840b..be58616 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_STM32)             +=3D pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)              +=3D pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)              +=3D pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUNPLUS)    +=3D pwm-sunplus.o
> >  obj-$(CONFIG_PWM_TEGRA)              +=3D pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)     +=3D pwm-tiecap.o
> >  obj-$(CONFIG_PWM_TIEHRPWM)   +=3D pwm-tiehrpwm.o
> > diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
> > new file mode 100644
> > index 0000000..0ae59fc
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sunplus.c
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PWM device driver for SUNPLUS SoCs
> > + *
> > + * Author: Hammer Hsieh <hammer.hsieh@sunplus.com>
> > + */
>
> Please add a section here about your hardware limitations. Please stick
> to the format used in e.g. pwm-sifive.c. That is a block starting with
>
>  * Limitations:
>
> and then a list of issues. One such item is: Only supports normal
> polarity.
>
ok, will modify it.

> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +
> > +#define PWM_SUP_CONTROL0     0x000
> > +#define PWM_SUP_CONTROL1     0x004
> > +#define PWM_SUP_FREQ_BASE    0x008
> > +#define PWM_SUP_DUTY_BASE    0x018
> > +#define PWM_SUP_FREQ(ch)     (PWM_SUP_FREQ_BASE + 4 * (ch))
> > +#define PWM_SUP_DUTY(ch)     (PWM_SUP_DUTY_BASE + 4 * (ch))
> > +#define PWM_SUP_FREQ_MAX     GENMASK(15, 0)
> > +#define PWM_SUP_DUTY_MAX     GENMASK(7, 0)
> > +
> > +#define PWM_SUP_NUM          4
> > +#define PWM_BYPASS_BIT_SHIFT 8
> > +#define PWM_DD_SEL_BIT_SHIFT 8
> > +#define PWM_SUP_FREQ_SCALER  256
> > +
> > +struct sunplus_pwm {
> > +     struct pwm_chip chip;
> > +     void __iomem *base;
> > +     struct clk *clk;
> > +};
> > +
> > +static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip=
)
> > +{
> > +     return container_of(chip, struct sunplus_pwm, chip);
> > +}
> > +
> > +static void sunplus_reg_init(void __iomem *base)
> > +{
> > +     u32 i, value;
> > +
> > +     /* turn off all pwm channel output */
> > +     value =3D readl(base + PWM_SUP_CONTROL0);
> > +     value &=3D ~GENMASK((PWM_SUP_NUM - 1), 0);
> > +     writel(value, base + PWM_SUP_CONTROL0);
> > +
> > +     /* init all pwm channel clock source */
> > +     value =3D readl(base + PWM_SUP_CONTROL1);
> > +     value |=3D GENMASK((PWM_SUP_NUM - 1), 0);
> > +     writel(value, base + PWM_SUP_CONTROL1);
> > +
> > +     /* init all freq and duty setting */
> > +     for (i =3D 0; i < PWM_SUP_NUM; i++) {
> > +             writel(0, base + PWM_SUP_FREQ(i));
> > +             writel(0, base + PWM_SUP_DUTY(i));
> > +     }
>
> Please keep the PWM in their boot-up state. That is, if the bootloader
> enabled a display with a bootsplash, don't disable the backlight when
> the PWM driver loads.
>

ok, will remove init reg code.

> > +}
> > +
> > +static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +                          const struct pwm_state *state)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 period_ns, duty_ns, value;
> > +     u32 dd_freq, duty;
> > +     u64 tmp;
> > +
>
>         if (state->polarity !=3D PWM_POLARITY_NORMAL)
>                 return -EINVAL;
>
> > +     if (!state->enabled) {
> > +             value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +             value &=3D ~BIT(pwm->hwpwm);
> > +             writel(value, priv->base + PWM_SUP_CONTROL0);
> > +             return 0;
> > +     }
> > +
> > +     period_ns =3D state->period;
>
> state->period is an u64, so you might loose precision here.
>
> > +     duty_ns =3D state->duty_cycle;
>
> ditto
>
> > +
> > +     /* cal pwm freq and check value under range */
> > +     tmp =3D clk_get_rate(priv->clk) * (u64)period_ns;
>
> This might overflow?
>
> > +     tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> > +     tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, PWM_SUP_FREQ_SCALER);
>
> In general you should pick the highest period that isn't bigger than the
> requested period. I didn't check in detail, but using round-closest is a
> strong hint that you get that wrong.
>
> > +     dd_freq =3D (u32)tmp;
> > +
> > +     if (dd_freq =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     if (dd_freq > PWM_SUP_FREQ_MAX)
> > +             dd_freq =3D PWM_SUP_FREQ_MAX;
> > +
> > +     writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));
> > +
> > +     /* cal and set pwm duty */
> > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +     value |=3D BIT(pwm->hwpwm);
> > +     if (duty_ns =3D=3D period_ns) {
> > +             value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > +             duty =3D PWM_SUP_DUTY_MAX;
> > +     } else {
> > +             value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
> > +             tmp =3D (u64)duty_ns * PWM_SUP_FREQ_SCALER + (period_ns >=
> 1);
> > +             tmp =3D DIV_ROUND_CLOSEST_ULL(tmp, (u64)period_ns);
> > +             duty =3D (u32)tmp;
> > +             duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
>
> This is also more inexact than necessary. In general don't use period_ns
> in the calculation of duty register settings. As with period you're
> supposed to pick the biggest possible dutycycle not bigger than the
> requested value.
>
> Consider a PWM that with register P =3D P and register D =3D D implements=
 a
> PWM output with period =3D 1000 * P ns and duty_cycle =3D 1000 * D ns
>
> For a request of period =3D 39900 and duty_cycle =3D 12100, you have to p=
ick
> P =3D 39 and D =3D 12. However P * duty_ns / period_ns =3D 11.82 ...
>

static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
     const struct pwm_state *state)
{
  struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
  u32 dd_freq, duty, value, value1;
  u64 period_ns, duty_ns, tmp;
  u64 period_ns_max;

  if (state->polarity !=3D pwm->state.polarity)
  return -EINVAL;

  if (!state->enabled) {
  /* disable pwm channel output */
  value =3D readl(priv->base + PWM_SUP_CONTROL0);
  value &=3D ~BIT(pwm->hwpwm);
  writel(value, priv->base + PWM_SUP_CONTROL0);
  /* disable pwm channel clk source */
  value =3D readl(priv->base + PWM_SUP_CONTROL1);
  value &=3D ~BIT(pwm->hwpwm);
  writel(value, priv->base + PWM_SUP_CONTROL1);
  return 0;
  }

  tmp =3D PWM_SUP_FREQ_SCALER * NSEC_PER_SEC;
  tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, clk_get_rate(priv->clk));
  period_ns_max =3D PWM_SUP_FREQ_MAX * tmp;

  if (state->period > period_ns_max)
    return -EINVAL;

  period_ns =3D state->period;
  duty_ns =3D state->duty_cycle;

  /* cal pwm freq and check value under range */
  tmp =3D DIV64_U64_ROUND_CLOSEST(clk_get_rate(priv->clk), PWM_SUP_FREQ_SCA=
LER);
  tmp =3D tmp * period_ns >> 10;
  tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, NSEC_PER_SEC >> 10);
  dd_freq =3D (u32)tmp;

  if (dd_freq =3D=3D 0)
    return -EINVAL;

  if (dd_freq > PWM_SUP_FREQ_MAX)
    dd_freq =3D PWM_SUP_FREQ_MAX;

  writel(dd_freq, priv->base + PWM_SUP_FREQ(pwm->hwpwm));

  /* cal and set pwm duty */
  value =3D readl(priv->base + PWM_SUP_CONTROL0);
  value |=3D BIT(pwm->hwpwm);
  value1 =3D readl(priv->base + PWM_SUP_CONTROL1);
  value1 |=3D BIT(pwm->hwpwm);
  if (duty_ns =3D=3D period_ns) {
  value |=3D BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
  duty =3D PWM_SUP_DUTY_MAX;
  } else {
  value &=3D ~BIT(pwm->hwpwm + PWM_BYPASS_BIT_SHIFT);
  tmp =3D (duty_ns >> 10) * PWM_SUP_FREQ_SCALER;
  tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, (period_ns >> 10));
  duty =3D (u32)tmp;
  duty |=3D (pwm->hwpwm << PWM_DD_SEL_BIT_SHIFT);
  }
  writel(value, priv->base + PWM_SUP_CONTROL0);
  writel(value1, priv->base + PWM_SUP_CONTROL1);
  writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));

  return 0;
}

While I turn on PWM_DEBUG.
I still can see the warning message.
"sunplus-pwm 9c007a00.pwm: .apply is not idempotent (ena=3D1 pol=3D0
9998240/19996480)->(ena=3D1 pol=3D0 9996976/19993952)
I'm not sure if it is an issue or not.
echo 20000000 > period
echo 10000000 > duty_cycle
echo 1 > enable
get_state: Calculate reg value to state->period and state->duty_cycle.
apply: Calculate state->period and state->duty_cycle to reg value.
Can't match always.

> > +     }
> > +     writel(value, priv->base + PWM_SUP_CONTROL0);
> > +     writel(duty, priv->base + PWM_SUP_DUTY(pwm->hwpwm));
> > +
> > +     return 0;
> > +}
> > +
> > +static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +                               struct pwm_state *state)
> > +{
> > +     struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
> > +     u32 value;
> > +
> > +     value =3D readl(priv->base + PWM_SUP_CONTROL0);
> > +
> > +     if (value & BIT(pwm->hwpwm))
> > +             state->enabled =3D true;
> > +     else
> > +             state->enabled =3D false;
>
> This looks incomplete. Please enable PWM_DEBUG during your tests and
> address all output generated by that.
>
> As the general idea is that passing the result from .get_state() to
> .apply shouldn't modify the output, you have (in general) round up
> divisions in .get_state().

static void sunplus_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
  struct pwm_state *state)
{
  struct sunplus_pwm *priv =3D to_sunplus_pwm(chip);
  u32 value, freq, duty;
  u64 tmp, rate;

  rate =3D clk_get_rate(priv->clk);
  value =3D readl(priv->base + PWM_SUP_CONTROL0);
  freq =3D readl(priv->base + PWM_SUP_FREQ(pwm->hwpwm));
  duty =3D readl(priv->base + PWM_SUP_DUTY(pwm->hwpwm));
  duty &=3D ~GENMASK(9,8);

  tmp =3D PWM_SUP_FREQ_SCALER * NSEC_PER_SEC;
  tmp =3D DIV64_U64_ROUND_CLOSEST(tmp, rate);
  state->period =3D (u64)freq * tmp;
  tmp =3D (u64)duty * state->period;
  state->duty_cycle =3D DIV64_U64_ROUND_CLOSEST(tmp, PWM_SUP_FREQ_SCALER);

  if (value & BIT(pwm->hwpwm))
    state->enabled =3D true;
  else
    state->enabled =3D false;

  state->polarity =3D PWM_POLARITY_NORMAL;
}

>
> > +}
> > +
> > +static const struct pwm_ops sunplus_pwm_ops =3D {
> > +     .apply =3D sunplus_pwm_apply,
> > +     .get_state =3D sunplus_pwm_get_state,
> > +     .owner =3D THIS_MODULE,
> > +};
> > +
> > +static int sunplus_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct sunplus_pwm *priv;
> > +     int ret;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(priv->base))
> > +             return PTR_ERR(priv->base);
> > +
> > +     priv->clk =3D devm_clk_get_optional(dev, NULL);
> > +     if (IS_ERR(priv->clk))
> > +             return dev_err_probe(dev, PTR_ERR(priv->clk),
> > +                                  "get pwm clock failed\n");
> > +
> > +     ret =3D clk_prepare_enable(priv->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_add_action_or_reset(dev,
> > +                                    (void(*)(void *))clk_disable_unpre=
pare,
> > +                                    priv->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     priv->chip.dev =3D dev;
> > +     priv->chip.ops =3D &sunplus_pwm_ops;
> > +     priv->chip.npwm =3D PWM_SUP_NUM;
> > +
> > +     sunplus_reg_init(priv->base);
> > +
> > +     platform_set_drvdata(pdev, priv);
>
> This is unused, so please drop this.
>

ok, will modify it.

> > +
> > +     ret =3D devm_pwmchip_add(dev, &priv->chip);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Cannot register sunplus P=
WM\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id sunplus_pwm_of_match[] =3D {
> > +     { .compatible =3D "sunplus,sp7021-pwm", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, sunplus_pwm_of_match);
> > +
> > +static struct platform_driver sunplus_pwm_driver =3D {
> > +     .probe          =3D sunplus_pwm_probe,
> > +     .driver         =3D {
> > +             .name   =3D "sunplus-pwm",
> > +             .of_match_table =3D sunplus_pwm_of_match,
> > +     },
> > +};
> > +module_platform_driver(sunplus_pwm_driver);
> > +
> > +MODULE_DESCRIPTION("Sunplus SoC PWM Driver");
> > +MODULE_AUTHOR("Hammer Hsieh <hammer.hsieh@sunplus.com>");
> > +MODULE_LICENSE("GPL v2");
>
> "GPL" has the same semantic and is the more usual, so I suggest to use
> that one.
>
ok, will modify it.


> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
