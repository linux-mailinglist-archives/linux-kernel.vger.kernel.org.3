Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D84A79A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347235AbiBBUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiBBUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:40:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236EFC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:40:10 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id e81so619472oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BYQWgp0LuHkxGrn3i2T0CbLt7kajoO8Blp/PDwFkjzs=;
        b=L312VT0lsElBJuXLS51O3LMB2RCKk36C4DMxjq5cvBuRqD10r3jNJptwS4uulOGUgE
         eQVPXWO5EMDo0swUt81rQ3aRufHM6H9Mkzejuek7amfY3Fb1puYDUAff2Cewcf0SmEFD
         ZNVYpcleYKQr0QHZ2v3Cs/bCqSZOIM0XJRIGpqo7SQgsSOMVIl2eT0Gi1JgKyxWgaqmz
         /tn/8FFHGI3fojTEwx0qT2Xr91XuS6gJviPVAGXm3xYCOjguUv3zVwf6AsNLL5/XmmnF
         lUr6eb5/xIn1AvqTjnEYB2qIS1ZcZcfggM1rdDlCCGbDwNU2KIGICDd23hAMGZgRoEiN
         ekLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYQWgp0LuHkxGrn3i2T0CbLt7kajoO8Blp/PDwFkjzs=;
        b=CgbPWqi9D1cD8NdOaPHo2lpsHiqmVgyJ7s/RePjmbqrqfI0wTfykC8stoJX+a2bzfc
         h3GGuqtyE3UBPbrnPcDJJ3F7tAVDq23WEYh5mXbJhue7N2SvG0n1C3s+I9IPk2iggFM5
         5eN3O4cFu0uawaBqjcF/sac0rzN5feKr5uDpMV2egXACiYjMiRL6AOx1BYU3aRX3dcDt
         ZMDXMhKhBpnhPPWK6Zn6xILBPjAd3n2iofr7Cf4i//3dmy4LBWDeD1E6gWtEEHpULi/2
         dvQhjDs38mPYbqWFSLxnpQCLsUQy9BrBmFhi1ekTnLiIDjUQ4IJmrbU8Se6YQG6QD6wy
         6XAw==
X-Gm-Message-State: AOAM530rVBByc8oGqtB+POLJmH/n7z0bnaRk3pcLVrdPB4nq5LsnAKEN
        N/wWI26staI+SOd6YwHU+BFe/fPGBHuo0w==
X-Google-Smtp-Source: ABdhPJwyJI/9mH0LobX5MAg6faJtYp+YgoH6czTmjafk24j1IYwWD4LJrBNk6TLmtSt0HmXWUZ9lKA==
X-Received: by 2002:a05:6808:1149:: with SMTP id u9mr5385909oiu.68.1643834409364;
        Wed, 02 Feb 2022 12:40:09 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w7sm17424378oou.13.2022.02.02.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:40:08 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:40:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v11 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YfrsOqL4au5tBm8N@ripper>
References: <20220129005429.754727-1-bjorn.andersson@linaro.org>
 <20220129005429.754727-2-bjorn.andersson@linaro.org>
 <CAHp75VfgouJuF4zOM=FRg2itCgj1GN6hvSy6FuV2E5wo6gjtbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfgouJuF4zOM=FRg2itCgj1GN6hvSy6FuV2E5wo6gjtbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Feb 06:56 PST 2022, Andy Shevchenko wrote:

> On Tue, Feb 1, 2022 at 12:31 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> > with their output being routed to various other components, such as
> > current sinks or GPIOs.
> >
> > Each LPG instance can operate on fixed parameters or based on a shared
> > lookup-table, altering the duty cycle over time. This provides the means
> > for hardware assisted transitions of LED brightness.
> >
> > A typical use case for the fixed parameter mode is to drive a PWM
> > backlight control signal, the driver therefor allows each LPG instance
> > to be exposed to the kernel either through the LED framework or the PWM
> > framework.
> >
> > A typical use case for the LED configuration is to drive RGB LEDs in
> > smartphones etc, for which the driver support multiple channels to be
> 
> supports
> 
> > ganged up to a MULTICOLOR LED. In this configuration the pattern
> > generators will be synchronized, to allow for multi-color patterns.
> 
> ...
> 
> > +config LEDS_QCOM_LPG
> > +       tristate "LED support for Qualcomm LPG"
> 
> > +       depends on OF
> 
> || COMPILE_TEST
> 
> > +       depends on SPMI
> > +       help
> > +         This option enables support for the Light Pulse Generator found in a
> > +         wide variety of Qualcomm PMICs.
> 
> Module name?
> 
> ...
> 
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> 
> Wondering if these can be changed to mod_devicetable.h + property.,h.
> 
> ...
> 
> > + * @dev:       struct device for LPG device
> 
> Description without value and actually wrong. it's a pointer to, and
> not a struct device.
> 
> ...
> 
> > +       /* Hardware does not behave when LO_IDX == HI_IDX */
> 
> Any clue /. elaboration why?
> 

As the two indices are inclusive I was expecting to just get a
single-value pattern (i.e. static configuration), but instead it just
keeps looping through the entire pattern memory.

> ...
> 
> > +static void lpg_lut_free(struct lpg *lpg, unsigned int lo_idx, unsigned int hi_idx)
> > +{
> > +       int len;
> > +
> > +       if (lo_idx == hi_idx)
> > +               return;
> > +
> > +       len = hi_idx - lo_idx + 1;
> 
> Perhaps swap above and add the similar comment:
> 

Sounds reasonable.

> /* We never do a single item because ... */
> len =
> if (len == 1)
> 
> > +       bitmap_clear(lpg->lut_bitmap, lo_idx, len);
> 
> Who protects this bitmap from simultaneous access by different users?
> 

It's protected per LED, but apparently not cross LEDs. Will fix.

> > +}
> 
> ...
> 
> > +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> > +{
> > +       unsigned int clk, best_clk = 0;
> > +       unsigned int div, best_div = 0;
> > +       unsigned int m, best_m = 0;
> > +       unsigned int error;
> > +       unsigned int best_err = UINT_MAX;
> > +       u64 best_period = 0;
> > +
> > +       /*
> > +        * The PWM period is determined by:
> > +        *
> > +        *          resolution * pre_div * 2^M
> > +        * period = --------------------------
> > +        *                   refclk
> > +        *
> > +        * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
> > +        * M = [0..7].
> > +        *
> > +        * This allows for periods between 27uS and 384s, as the PWM framework
> > +        * wants a period of equal or lower length than requested, reject
> > +        * anything below 27uS.
> > +        */
> 
> > +       if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> > +               return -EINVAL;
> 
> > +       /* Limit period to largest possible value, to avoid overflows */
> > +       if (period > (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024)
> > +               period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 2014;
> 
> 2014?!
> 

I thought I fixed that...

> And if it's incorrect, it seems like a good example to avoid
> repetition of the long equations.
> 
> What about
> 
>   best_period = clamp_val(period, ...);
>   if (best_period >= period)
>     return -EINVAL;
> 
>   period = best_period;
> 
> ?

Sounds reasonable.

> 
> > +       /*
> > +        * Search for the pre_div, clk and M by solving the rewritten formula
> > +        * for each clk and pre_div value:
> > +        *
> > +        *                       period * clk
> > +        * M = log2 -------------------------------------
> > +        *           NSEC_PER_SEC * pre_div * resolution
> > +        */
> > +       for (clk = 0; clk < ARRAY_SIZE(lpg_clk_rates); clk++) {
> > +               u64 nom = period * lpg_clk_rates[clk];
> 
> Can we spell fully nunerator, denominator?
> 

Sure.

> > +               for (div = 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
> > +                       u64 denom = (u64)NSEC_PER_SEC * lpg_pre_divs[div] * (1 << 9);
> 
> " * (1 " part is redundant, you may shift left by 9, but see below.
> 

I could, but as written now it matches the formula as written in the
comment above. With (1 << 9) being the resolution part.

That said, I think I introduced the LPG_RESOLUTION constant after
writing this, would be reasonable to reuse that here.

> > +                       u64 actual;
> > +                       u64 ratio;
> > +
> > +                       if (nom < denom)
> > +                               continue;
> > +
> > +                       ratio = div64_u64(nom, denom);
> 
> Instead of shifting left by 9, you may optimize below to count that in
> the equations...
> 
> > +                       m = ilog2(ratio);
> > +                       if (m > LPG_MAX_M)
> > +                               m = LPG_MAX_M;
> 
> > +                       actual = DIV_ROUND_UP_ULL(denom * (1 << m), lpg_clk_rates[clk]);
> 
> ...including this one.
> 
> So, I see room for improvement in the calculations.
> 

So you're saying that I should remove the resolution from the
denominator and then just subtract 9 from M?

I presume it improves things by replacing one bitshift with a
subtraction, but afaict it wouldn't improve the readability of the code.

> > +                       error = period - actual;
> > +                       if (error < best_err) {
> > +                               best_err = error;
> > +
> > +                               best_div = div;
> > +                               best_m = m;
> > +                               best_clk = clk;
> > +                               best_period = actual;
> > +                       }
> > +               }
> > +       }
> > +
> > +       chan->clk = best_clk;
> > +       chan->pre_div = best_div;
> > +       chan->pre_div_exp = best_m;
> > +       chan->period = best_period;
> > +
> > +       return 0;
> > +}
> 
> ...
> 
> > +       val = div64_u64(duty * lpg_clk_rates[chan->clk],
> > +                       (u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div] * (1 << chan->pre_div_exp));
> 
> For all code, just shift right directly, it makes code easier to read.
> 

Code might be easier to read, but as written now it matches the formula
described above.

You're right that we should get the same result if I replace the
multiplication from the denominator to be a shift in the numerator, but
at least for me that require me to think 1-2 extra steps when reading
this to convince myself that below is the same as the formula described
in the comments:

val = div64_u64((duty * lpg_clk_rates[chan->clk]) >> chan->pre_div_exp,
                (u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div]);

> ...
> 
> > +       regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, &val, sizeof(val));
> 
> In some cases the error is handled from regmap calls, in many it's not. Why?
> 

The brightness_set() in struct led_classdev is a void function, so I
have to throw away the very unlikely error at some point...

> ...
> 
> > +       count = of_property_count_u32_elems(np, "qcom,dtest");
> > +       if (count == -EINVAL) {
> > +               return 0;
> 
> > +       } else if (count < 0) {
> 
> Redundant 'else'
> 
> > +               ret = count;
> 
> Do it other way around, i.e.
> 
>   ret = ...
>   ...
>   count = ret;
> 
> > +               goto err_malformed;
> > +       } else if (count != lpg->data->num_channels * 2) {
> 
> Redundant 'else'.
> 

So you're saying that this form is preferable?

if (a) {
	return 0;
}
if (b) {
	goto err_malformed:
}
if (c) {
	return -EINVAL;
}

The else has absolutely no meaning to the compiler, but it immediately
tells me as a human that we will enter only one of these branches.

> > +               dev_err(lpg->dev, "qcom,dtest needs to be %d items\n",
> > +                       lpg->data->num_channels * 2);
> > +               return -EINVAL;
> > +       }
> 
> ...
> 
> > +       /* Only support oneshot or indefinite loops, due to limited pattern space */
> 
> one shot
> 
> > +       if (repeat != -1 && repeat != 1)
> 
> abs(repeat) != 1 ?
> 

While equivalent, I'm not checking to see if the absolute value of
repeat is 1, I'm checking that repeat is either -1 and 1.

Again, same outcome but different meaning to a human reading the code.

> > +               return -EINVAL;
> 
> ...
> 
> > +       /* LPG_RAMP_DURATION_REG is 9 bit */
> > +       if (pattern[0].delta_t >= 512)
> 
> Then compare with bit value? BIT(9)?
> 
> > +               return -EINVAL;
> 
> ...
> 
> > +       lpg_brightness_single_set(cdev, LED_FULL);
> 
> Isn't LED_FULL deprecated?
> 

I had missed that the LED framework now supports variable
max_brightness. Will update accordingly throughout the driver.

> ...
> 
> > +       ret = of_property_read_u32(np, "reg", &reg);
> > +       if (ret || !reg || reg > lpg->num_channels) {
> 
> > +               dev_err(lpg->dev, "invalid \"reg\" of %pOFn\n", np);
> 
> Confusing message for some of the error conditions.
> 
> > +               return -EINVAL;
> 
> Shadowed error code.
> 
> > +       }
> 
> ...
> 
> > +       ret = of_property_read_u32(np, "color", &color);
> > +       if (ret < 0 && ret != -EINVAL) {
> 
> Why the specific error code check?
> 

Because color is an optional property, so -EINVAL would imply that we
didn't find the property and color was left untouched.

> > +               dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
> > +               return ret;
> > +       }
> 
> ...
> 
> > +       if (!of_property_read_string(np, "default-state", &state) &&
> > +           !strcmp(state, "on"))
> 
> of_property_match_string()?
> 

Neat.

Regards,
Bjorn

> ...
> 
> > +       bitmap_size = BITS_TO_BYTES(lpg->lut_size);
> > +       lpg->lut_bitmap = devm_kzalloc(lpg->dev, bitmap_size, GFP_KERNEL);
> 
> devm_bitmap_zalloc()
> 
> > +       if (!lpg->lut_bitmap)
> > +               return -ENOMEM;
> 
> ...
> 
> > +               dev_err(&pdev->dev, "parent regmap unavailable\n");
> > +               return -ENXIO;
> 
> return dev_err_probe(...);
> 
> ...
> 
> > +       .pwm_9bit_mask = 3 << 4,
> 
> GENMASK()
> 
> ...
> 
> > +       .pwm_9bit_mask = 3 << 4,
> 
> Ditto.
> 
> --
> With Best Regards,
> Andy Shevchenko
