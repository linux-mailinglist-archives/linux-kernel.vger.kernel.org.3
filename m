Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517D488968
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiAIMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAIMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:49:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E2C06173F;
        Sun,  9 Jan 2022 04:49:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q25so33843301edb.2;
        Sun, 09 Jan 2022 04:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+VgcE+lDBp+wrrlQ0BCzedCg9IsERBX8d3mn74brQs=;
        b=afgvj/jpRhULyCa346Lzdz/a2PEdwaKR5kA5jsPkwvKhKFxM+HaOdY7P52rvan0K+0
         VdcBZ5Lr5lTobpWhuYNMJyVDOy48TiS6K7sWR0lrCslcLcdvqMXjZrvwTnODAAXta5uE
         cLC2fvZTOjfoJ05BGk/DYaecA5/0elmUBlGImfmiWVQv01W7k1GOLJQ5lPZ/HNyly9Ym
         qjahsqLMMXzcyPGqo+MI8wINQ/f8aQB0bqH6eQhnWrK/jkPjw/bkHNTC80cM8EtPjm1M
         lwf4IXvvFgF3qSBnDdp06oHB9QWVoHI7UOOCmzNZGsAY7xqkIecxZ4beSlvVKhLsQQED
         rmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+VgcE+lDBp+wrrlQ0BCzedCg9IsERBX8d3mn74brQs=;
        b=Jddp0eKaqHp9eLwHO73QrvVETd5Kdyb0GR3WT6iil7OcuzMUMf+WNuHBjpgLdf9Pf9
         mZ1DdHADKJVv1oaMrkVK7LnCqFhxKyWwFc4WgmDOjKOFHw6XHkQegFptS7RL8IuFMhYe
         oYPlEiSeErAD1PycRpp6dF13NBhvCES6ICPkOx6bgqu5VE7Q4js8ksKqi8RvmK4HKpgH
         cVee8ZF07OIaTW+bRpKEpCAk5FQErKigh5DPtZJMq2Q+58ESaROpFHkOR/V/jUe2orLD
         OS3x1fEyZd+FTnsHnCdiUnwI6o3FBRPyC0BH1Tzc7Eb8a6Y4CDzEf5llMNRbpVcKIcat
         st+A==
X-Gm-Message-State: AOAM5316zSnLiv8uvKZ4zro+fu6tbmQsA++ogSfFVDfRSB1HWmL6sSqI
        d+VAgLfirTjrHNY3+jnLPM/DeMQb8UoO8nkIU40=
X-Google-Smtp-Source: ABdhPJyv0U5ccDuT0P2gFdz+TXJGTt+sROnAbKodDYCIEAEKWVxjYNrb65tcy7o3nYP9nshNmVrycrCb5fGMu/+H6pE=
X-Received: by 2002:a17:907:a0c7:: with SMTP id hw7mr3074143ejc.579.1641732562173;
 Sun, 09 Jan 2022 04:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20220108205319.2046348-1-liambeguin@gmail.com> <20220108205319.2046348-8-liambeguin@gmail.com>
In-Reply-To: <20220108205319.2046348-8-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 14:48:46 +0200
Message-ID: <CAHp75Vdi2bvCEtxpezt5L5JhO=8D+Za++CbQ8AximFaLnxnqyg@mail.gmail.com>
Subject: Re: [PATCH v12 07/16] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.

...

> +               mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
> +
> +               /*
> +                * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
> +                * OR *val2 is negative the schan scale is negative, i.e.
> +                * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
> +                */
> +               neg = *val < 0 || *val2 < 0;
> +
> +               tmp = (s64)abs(*val) * abs(rescale->numerator);
> +               *val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
> +
> +               tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
> +               tmp = div_s64(tmp, abs(rescale->denominator));

Isn't it too many repetitive abs() calls?

What about

// Create a macro and use for u16 (struct rn5t618_channel_ratios), s16
(struct twl4030_prescale_divider_ratios), s32 (can be reused in struct
rescale)
struct u32_fract {
  u32 numerator;
  u32 denominator;
};
// (potential reuse in struct hclge_ptp_cycle) and so on...

  struct u32_fract fract = {
    .numerator = abs(rescale->numerator),
    .denominator = abs(rescale->denominator),
  };

// obviously we can add a macro/inliner to abs() the fract struct and
return original sign

and reuse fract.numerator, fract.denominator?

> +               *val += div_s64_rem(tmp, mult, val2);
> +
> +               /*
> +                * If only one of the rescaler elements or the schan scale is
> +                * negative, the combined scale is negative.
> +                */
> +               if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> +                       if (*val)
> +                               *val = -*val;
> +                       else
> +                               *val2 = -*val2;
> +               }


--
With Best Regards,
Andy Shevchenko
