Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8074A7406
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbiBBO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiBBO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:58:02 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDDBC061714;
        Wed,  2 Feb 2022 06:58:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m4so66577089ejb.9;
        Wed, 02 Feb 2022 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAfo6RJLPMEw2xPUasSxlVLvqVro/BXspZvwYSkJ2S4=;
        b=oIDLJVzqOMnaTSO8qoAjtEwisNlRDCx8NzufqYMSNmxmtMhMR7myI+a2ckqoX/PCL8
         DW6gxuCBeFXjUrozPtqv3xErBoAP18TyWindOpAQhIsHXpDXaDfJmJkLoI1s9SCQblOK
         eYv5pPvvkNMZLJ9OZJIHFuEKwKiZUa2oUqowG7X1fbLZZTWK47ix2JRabLXKFmE5+gqH
         KYP8khOEquYp2UdW03f5OIAlw6COZeRSZrsIVVn6fet4pqmH33UtoCL2ZCk5WihOPoTq
         IJ96qUv+5yppweR++2wGXuHNxCK9OVttjfZypzRTOxvX3oiXeaLfM8OLDU3N62SBuonW
         uwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAfo6RJLPMEw2xPUasSxlVLvqVro/BXspZvwYSkJ2S4=;
        b=va0wTfQAzq+ZGNZm2K7HXekwE9xDfg790Mv07yRKcauuiqgc+DXRkUhiwb4AWNHNrC
         GxAVWcUTVL0hlDL6cy6PYNArN0bT7ZP25rQb7QHZtPpaufbrZ7dJKalAvcBoTjU96DSL
         rXvdCKwjVAwgflaZRtkeOrqvcrYAFc9OZlVs+WCGjbnPH2x/poBzRdNW2eb+JLB44v07
         ZQTI14Iw2C0WdS5JwfFv83ze8PM7ALe7wkZc+OKCcOc1bZ+H3QlvPjsFNeUosovCT8ib
         zS2lOzR3mNhsD5M5U1UyYqPcnGX/KJqRqci0UFXKAYVwaIRrARLw+euTx8dQ26dIFXlQ
         P3SQ==
X-Gm-Message-State: AOAM531Dt+4Ctb8l3Vy5U7kp/8kC6p+hnuHkl7CRPnvGueJzRhMTkh7d
        YeS0NOAdwbn8lHxh50fyJhOld08iDv/9rJyQkJ0=
X-Google-Smtp-Source: ABdhPJy6cGrGdiIp+orrv9EOYNdtcCPa6CPpwOsSEaKr17Q9qmorlf5hvsRJNzAw3sIXY8fcQ93YlVh1WNvKPFRH8So=
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr25017174ejo.636.1643813880339;
 Wed, 02 Feb 2022 06:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20220129005429.754727-1-bjorn.andersson@linaro.org> <20220129005429.754727-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220129005429.754727-2-bjorn.andersson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Feb 2022 16:56:24 +0200
Message-ID: <CAHp75VfgouJuF4zOM=FRg2itCgj1GN6hvSy6FuV2E5wo6gjtbg@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:31 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> with their output being routed to various other components, such as
> current sinks or GPIOs.
>
> Each LPG instance can operate on fixed parameters or based on a shared
> lookup-table, altering the duty cycle over time. This provides the means
> for hardware assisted transitions of LED brightness.
>
> A typical use case for the fixed parameter mode is to drive a PWM
> backlight control signal, the driver therefor allows each LPG instance
> to be exposed to the kernel either through the LED framework or the PWM
> framework.
>
> A typical use case for the LED configuration is to drive RGB LEDs in
> smartphones etc, for which the driver support multiple channels to be

supports

> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.

...

> +config LEDS_QCOM_LPG
> +       tristate "LED support for Qualcomm LPG"

> +       depends on OF

|| COMPILE_TEST

> +       depends on SPMI
> +       help
> +         This option enables support for the Light Pulse Generator found in a
> +         wide variety of Qualcomm PMICs.

Module name?

...

> +#include <linux/of.h>
> +#include <linux/of_device.h>

Wondering if these can be changed to mod_devicetable.h + property.,h.

...

> + * @dev:       struct device for LPG device

Description without value and actually wrong. it's a pointer to, and
not a struct device.

...

> +       /* Hardware does not behave when LO_IDX == HI_IDX */

Any clue /. elaboration why?

...

> +static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned int hi_idx)
> +{
> +       int len;
> +
> +       if (lo_idx == hi_idx)
> +               return;
> +
> +       len = hi_idx - lo_idx + 1;

Perhaps swap above and add the similar comment:

/* We never do a single item because ... */
len =
if (len == 1)

> +       bitmap_clear(lpg->lut_bitmap, lo_idx, len);

Who protects this bitmap from simultaneous access by different users?

> +}

...

> +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> +{
> +       unsigned int clk, best_clk = 0;
> +       unsigned int div, best_div = 0;
> +       unsigned int m, best_m = 0;
> +       unsigned int error;
> +       unsigned int best_err = UINT_MAX;
> +       u64 best_period = 0;
> +
> +       /*
> +        * The PWM period is determined by:
> +        *
> +        *          resolution * pre_div * 2^M
> +        * period = --------------------------
> +        *                   refclk
> +        *
> +        * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
> +        * M = [0..7].
> +        *
> +        * This allows for periods between 27uS and 384s, as the PWM framework
> +        * wants a period of equal or lower length than requested, reject
> +        * anything below 27uS.
> +        */

> +       if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> +               return -EINVAL;

> +       /* Limit period to largest possible value, to avoid overflows */
> +       if (period > (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024)
> +               period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 2014;

2014?!

And if it's incorrect, it seems like a good example to avoid
repetition of the long equations.

What about

  best_period = clamp_val(period, ...);
  if (best_period >= period)
    return -EINVAL;

  period = best_period;

?

> +       /*
> +        * Search for the pre_div, clk and M by solving the rewritten formula
> +        * for each clk and pre_div value:
> +        *
> +        *                       period * clk
> +        * M = log2 -------------------------------------
> +        *           NSEC_PER_SEC * pre_div * resolution
> +        */
> +       for (clk = 0; clk < ARRAY_SIZE(lpg_clk_rates); clk++) {
> +               u64 nom = period * lpg_clk_rates[clk];

Can we spell fully nunerator, denominator?

> +               for (div = 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
> +                       u64 denom = (u64)NSEC_PER_SEC * lpg_pre_divs[div] * (1 << 9);

" * (1 " part is redundant, you may shift left by 9, but see below.

> +                       u64 actual;
> +                       u64 ratio;
> +
> +                       if (nom < denom)
> +                               continue;
> +
> +                       ratio = div64_u64(nom, denom);

Instead of shifting left by 9, you may optimize below to count that in
the equations...

> +                       m = ilog2(ratio);
> +                       if (m > LPG_MAX_M)
> +                               m = LPG_MAX_M;

> +                       actual = DIV_ROUND_UP_ULL(denom * (1 << m), lpg_clk_rates[clk]);

...including this one.

So, I see room for improvement in the calculations.

> +                       error = period - actual;
> +                       if (error < best_err) {
> +                               best_err = error;
> +
> +                               best_div = div;
> +                               best_m = m;
> +                               best_clk = clk;
> +                               best_period = actual;
> +                       }
> +               }
> +       }
> +
> +       chan->clk = best_clk;
> +       chan->pre_div = best_div;
> +       chan->pre_div_exp = best_m;
> +       chan->period = best_period;
> +
> +       return 0;
> +}

...

> +       val = div64_u64(duty * lpg_clk_rates[chan->clk],
> +                       (u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div] * (1 << chan->pre_div_exp));

For all code, just shift right directly, it makes code easier to read.

...

> +       regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, &val, sizeof(val));

In some cases the error is handled from regmap calls, in many it's not. Why?

...

> +       count = of_property_count_u32_elems(np, "qcom,dtest");
> +       if (count == -EINVAL) {
> +               return 0;

> +       } else if (count < 0) {

Redundant 'else'

> +               ret = count;

Do it other way around, i.e.

  ret = ...
  ...
  count = ret;

> +               goto err_malformed;
> +       } else if (count != lpg->data->num_channels * 2) {

Redundant 'else'.

> +               dev_err(lpg->dev, "qcom,dtest needs to be %d items\n",
> +                       lpg->data->num_channels * 2);
> +               return -EINVAL;
> +       }

...

> +       /* Only support oneshot or indefinite loops, due to limited pattern space */

one shot

> +       if (repeat != -1 && repeat != 1)

abs(repeat) != 1 ?

> +               return -EINVAL;

...

> +       /* LPG_RAMP_DURATION_REG is 9 bit */
> +       if (pattern[0].delta_t >= 512)

Then compare with bit value? BIT(9)?

> +               return -EINVAL;

...

> +       lpg_brightness_single_set(cdev, LED_FULL);

Isn't LED_FULL deprecated?

...

> +       ret = of_property_read_u32(np, "reg", &reg);
> +       if (ret || !reg || reg > lpg->num_channels) {

> +               dev_err(lpg->dev, "invalid \"reg\" of %pOFn\n", np);

Confusing message for some of the error conditions.

> +               return -EINVAL;

Shadowed error code.

> +       }

...

> +       ret = of_property_read_u32(np, "color", &color);
> +       if (ret < 0 && ret != -EINVAL) {

Why the specific error code check?

> +               dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
> +               return ret;
> +       }

...

> +       if (!of_property_read_string(np, "default-state", &state) &&
> +           !strcmp(state, "on"))

of_property_match_string()?

...

> +       bitmap_size = BITS_TO_BYTES(lpg->lut_size);
> +       lpg->lut_bitmap = devm_kzalloc(lpg->dev, bitmap_size, GFP_KERNEL);

devm_bitmap_zalloc()

> +       if (!lpg->lut_bitmap)
> +               return -ENOMEM;

...

> +               dev_err(&pdev->dev, "parent regmap unavailable\n");
> +               return -ENXIO;

return dev_err_probe(...);

...

> +       .pwm_9bit_mask = 3 << 4,

GENMASK()

...

> +       .pwm_9bit_mask = 3 << 4,

Ditto.

--
With Best Regards,
Andy Shevchenko
