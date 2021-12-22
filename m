Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF447D72A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbhLVSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbhLVSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:51:02 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC2C061574;
        Wed, 22 Dec 2021 10:51:02 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id j17so2816420qtx.2;
        Wed, 22 Dec 2021 10:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TOPXNxn1ZtQrXll8PkTIOOIN5IXFNZD4uJ0Nc4o/BwU=;
        b=lXNI0j1gopwX96HLRZ2tf1VDJI5hFCZn93xxAfXDfKpHOtu2bvGITNl3R9w7s+VnRa
         O6IyS6e1ztb32DvcvwOT7MKvbTLzZCu+OYJBWHuyazF6/lqChqUXEAUV6be+jawc3pdX
         gGRz6TN14F4CI39TX5i7AQX28Tl9hHu2eHR27jrnKMVRtWo5wcW1llXYj1o+OBo+w934
         yt3wVA2TgY/m/eCOwSYUCEaTt2k7wbqQ5G7/mND0IH8BRHV+FDyRFa/WfXPi4HmRjBLP
         MMa7CoG+Jip1MKhLHmK/uJ2AUlseNy1Drx+mfEVtWVacqxz9BisqudVneYMTUqf+trCo
         QJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOPXNxn1ZtQrXll8PkTIOOIN5IXFNZD4uJ0Nc4o/BwU=;
        b=F8ODVbQm4YZYME2s52jy1uP+L9bYlG/aRtCBz40DyD3TQr8Si+5nGfKj0nULuvj+Hj
         juFjlclZPUaB01GorqvZ5SajiMEMo03mFOdURq2NOZcfjZtGJvIFKDXpP6VvIvNWvatA
         rZQfetbzSRHOsECo9Ge9MtsW7J0AslMFrXoCxy8YIQ3O/M0HTvd0qVRgMo57ESGCRYO4
         Q96RgDcD0GmvaEvOkwDt/NvtaAUEHyCDq/p470Ntsx/MA6ZSGnCsIlQfVm2Rveeg/gWn
         mfw5ozGHGaaab6/qK+KK2qSyMfmEOcJuIx9Jb/7wvUY6KdP8SlQmOiN7gBn/NUvAxeHN
         ldig==
X-Gm-Message-State: AOAM531A1uYWHzWunfIiyyBIAz0nZgPUMChQHJEQFdrMlehRLUGo4qMl
        alXdxXCbUWLZxt9tyC3f6i4SWd6MlWI=
X-Google-Smtp-Source: ABdhPJzYpAm9FgoO+HqQLJg1R27FSEvsxZgxQJXY0VbYgsjiSNSAzWqslo23bAxl9lOHBFQyQRSYLA==
X-Received: by 2002:ac8:5894:: with SMTP id t20mr3213356qta.450.1640199061677;
        Wed, 22 Dec 2021 10:51:01 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id bl16sm2690830qkb.44.2021.12.22.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:51:01 -0800 (PST)
Date:   Wed, 22 Dec 2021 13:50:57 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v11 10/15] iio: afe: rescale: make use of units.h
Message-ID: <YcNzkbSsG1wyz2MV@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-11-liambeguin@gmail.com>
 <CAHp75VeGNuYiqqHzv9cAbHKy-h3dnazf2YEvgJ4fwb88wgY48w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeGNuYiqqHzv9cAbHKy-h3dnazf2YEvgJ4fwb88wgY48w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 02:33:52PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > Make use of well-defined SI metric prefixes to improve code readability.
> 
> ...
> 
> >         case IIO_VAL_FRACTIONAL_LOG2:
> > -               tmp = (s64)*val * 1000000000LL;
> > +               tmp = (s64)*val * NANO;
> >                 tmp = div_s64(tmp, rescale->denominator);
> >                 tmp *= rescale->numerator;
> >
> > -               tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> > +               tmp = div_s64_rem(tmp, NANO, &rem);
> >                 *val = tmp;
> 
> Thanks! The important part of this conversion is to get one trick,
> i.e. NANO and GIGA are both represented by 10^9. We need to be sure
> that here we use the proper sign of the power of these numbers. So
> please double check in all cases that the chosen SI prefixes are
> correct from the power sign point of view, e.g. it is 10^-9 and not
> 10^9 or otherwise.

I get the difference, but I guess I'm not sure I understand how you want me to
use them. I was using NANO here as that made most sense for me.

If we go by the positive vs. negative powers of ten, I should always use
GIGA as we're multiplying by 10^9 and dividing by 10^9. Is that what you
expected?

IMO, that wouldn't be as clear, but I believe you know better.

Cheers,
Liam

> ...
> 
> >                 *val2 = rem / (int)tmp;
> >                 if (rem2)
> > -                       *val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> > +                       *val2 += div_s64((s64)rem2 * NANO, tmp);
> 
> Ditto here and for the rest
> 
> -- 
> With Best Regards,
> Andy Shevchenko
