Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3A47D1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbhLVMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhLVMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:35:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17BC061574;
        Wed, 22 Dec 2021 04:35:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so8058935edd.8;
        Wed, 22 Dec 2021 04:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37cmTFk9Mn8yVGgefCEUxfQ2BLBsyDY2ddr/2hwTMYw=;
        b=JbOxgJ6PwvF9yR5ROx3FQOEe59iEZ+CPCdSM1KbFs9aMkGYSXxrOTspeMC2qNGkD3p
         qkluDU3s0Nous9hAxBz1WvHInu6CX/+xeKdYyO8S9Toij+CZX0rrCTh6jGJxJN7RkkXB
         0q7bdnwsX/nmWJwOPsfN4gN8soWj/X0BFPDm2z+5TnCsntHKi2QJg19XHyy9pykx9riy
         YrU90ogM3MjA8OC/Z7TlbWw7DKw/WFA1tjb6o5peonMv5wTDiegzTo55C3P9LEa4L8z2
         kifZ9angmc83TjHMoQ6V4QDnAEdNipqAwh2RYNrpKwWeJ0HJNSn0Zr9Q5Y22DL7pihm/
         Cleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37cmTFk9Mn8yVGgefCEUxfQ2BLBsyDY2ddr/2hwTMYw=;
        b=ZMXMu0q+XDvf4/hUuSUP756XqLE36uXeQA/MChb5rIFjlX9AalO00tjqPIoD4vzsfg
         eh0MkJ/+DtjT1AWMIut6BDavzYqrvQJlBFO4LTY3aVWWCZgQQodNz6dCv6p7wIUHixas
         pGM1pCIukd3EpFfg9SL7aLXo6LC6j8nTdH/KkrL0s9UnWhVg4gsNxwwiN2VsCg+7fdQ3
         NSoziBL0EQr3vc6gdWv/e8U7MvnaWrP/9xrHwn0nzbVPh+SIkgDawQ8QjN9uVawxh611
         GFrLZflTzs54JnmPLlqRqt/9gnWKdZHReld/hdCRhOak9TZ3Ux5zc5ywH4dIo2zuoYbe
         BsAA==
X-Gm-Message-State: AOAM530rp2tE515UOQWOLe9kJX435+l3rG2aA7FcWkgO/M/OkpZanxSc
        OE1AKYzcpFGp+cJfzkHINRNV6odmxMNqWbSHX3U=
X-Google-Smtp-Source: ABdhPJw7SOX9VoeJ9Bjbc8AgEbKpVhvXD6YzEfF4kpqtRjMx1JNkxfKzHIMsglslxNYX1VzIsNpRZLAt8ba7dmiLJBw=
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr1283557edz.258.1640176551197;
 Wed, 22 Dec 2021 04:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-11-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-11-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:33:52 +0200
Message-ID: <CAHp75VeGNuYiqqHzv9cAbHKy-h3dnazf2YEvgJ4fwb88wgY48w@mail.gmail.com>
Subject: Re: [PATCH v11 10/15] iio: afe: rescale: make use of units.h
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

On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> Make use of well-defined SI metric prefixes to improve code readability.

...

>         case IIO_VAL_FRACTIONAL_LOG2:
> -               tmp = (s64)*val * 1000000000LL;
> +               tmp = (s64)*val * NANO;
>                 tmp = div_s64(tmp, rescale->denominator);
>                 tmp *= rescale->numerator;
>
> -               tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> +               tmp = div_s64_rem(tmp, NANO, &rem);
>                 *val = tmp;

Thanks! The important part of this conversion is to get one trick,
i.e. NANO and GIGA are both represented by 10^9. We need to be sure
that here we use the proper sign of the power of these numbers. So
please double check in all cases that the chosen SI prefixes are
correct from the power sign point of view, e.g. it is 10^-9 and not
10^9 or otherwise.

...

>                 *val2 = rem / (int)tmp;
>                 if (rem2)
> -                       *val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> +                       *val2 += div_s64((s64)rem2 * NANO, tmp);

Ditto here and for the rest

-- 
With Best Regards,
Andy Shevchenko
