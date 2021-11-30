Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B985E463E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbhK3Sz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbhK3SzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:55:24 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2395C061574;
        Tue, 30 Nov 2021 10:52:04 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j9so18917481qvm.10;
        Tue, 30 Nov 2021 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HYgQcPIIPvgM39TNU0DivkMndXlTezB5uIXJqA5tLd8=;
        b=A5okFLpjQuq0KmkSffiRYdczNaMLRLiw4xkqtk/X12nOP79VjQj4LODamzir5ivihO
         fCA8pMC6tEijWYTXsmfGyinlqh5u3T4G9y69AC8S0IVzWqSqIuyiXtscyK64kQChMsR6
         OU9OFwwexCMTLU9B5XtrQdbISvhWaVD0shrdrYUvGHgThGmflPCvYXxPayrLyeSvwPVG
         3aopSX0FF1IX4fY1RBQIs7/Bfb3nzQbY/q7GUF5QPdJPKmlPRrkAG34TipreewHIt5eO
         +xro/dszTRCLNpXwFPs6jvrXVdcb+ItqtB8bywC121mThUnc/Vm4iTxOBt+Norl/kRU3
         Rfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYgQcPIIPvgM39TNU0DivkMndXlTezB5uIXJqA5tLd8=;
        b=KRER1RXVyHDmGstErgOBul4PMuBTLeGoqAsqVdUsu5HHymygKfZMvdyZSM0ZaieBWu
         6J1VaMHAVcVoXm/bkPRYC3X8tDt6Kg/TKFeo2Z7ymK23yO9/BMXS5IK7rayZRMTcRvG5
         W+HPld1y6YfzOfR6e/5bO79egx2EkqD1bcN7refZWkJIidcERzcFyiENO6x4Z5lA2P/e
         HFnVrUGlTnyWA8Ob6ke1CHJWU4AGHRYJKZ7hqDBw5c4+8KEXXvWRBwsKfpd19Pakdh8j
         rMKUsLVv7tDDhoiGrhY48UwlMWGwVXV5xqnJ4gjaaXPd836qlj2UQzYvHAa/fILgd7Il
         GYkg==
X-Gm-Message-State: AOAM533wPS97ABgqjECKkmWdLSC63oyMokhflcwD67gxotua6rKEzmxi
        Eyf3FsDdAhYN8XRQ7tuElk/omg82vTs=
X-Google-Smtp-Source: ABdhPJwp+bd+jO7MNGmPEsW94/xpc45CoZb+zOP+5/vzPsxmcVSt3EabGm+LV2pPqeCWtCaLpjeelg==
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr783291qvb.47.1638298323789;
        Tue, 30 Nov 2021 10:52:03 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t11sm10387838qkp.56.2021.11.30.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:52:03 -0800 (PST)
Date:   Tue, 30 Nov 2021 13:52:01 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v9 00/14] iio: afe: add temperature rescaling support
Message-ID: <YaZy0Wk4Kzptt0SX@shaak>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
 <156bc2fa-6754-2350-4a12-ff25b23ae8a2@axentia.se>
 <YaKUmha11ft6gip2@shaak>
 <b9e1e804-fb59-660f-a9b8-ad6e20dd41aa@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e1e804-fb59-660f-a9b8-ad6e20dd41aa@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sun, Nov 28, 2021 at 10:17:50AM +0100, Peter Rosin wrote:
> Hi!
> 
> On 2021-11-27 21:27, Liam Beguin wrote:
> > Hi Peter,
> > 
> > On Mon, Nov 22, 2021 at 01:53:44AM +0100, Peter Rosin wrote:
> >> Hi Liam!
> >>
> >> On 2021-11-15 04:43, Liam Beguin wrote:
> >>> Hi Jonathan, Peter,
> 
> snip
> 
> >>> - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
> >>>   point
> >>
> >> This is not what is going on. Patch 9/14 will convert all fractional
> >> scales to fixed point. But I would really like if you in the "reduce
> >> risk of integer overflow" patch (8/14) would hold true to the above
> >> and keep the fractional scale when possible and only fall back to
> >> the less precise fractional-log case if any of the multiplications
> >> needed for an exact fractional scale causes overflow.
> > 
> > Thanks for looking at these patches again.
> > 
> >> The v8 discussion concluded that this was a valid approach, right?
> > 
> > Yes, I remember you saying that you'd be more comfortable keeping the
> > IIO_VAL_FRACTIONAL.
> > 
> >> I know you also said that the core exposes the scale with nano
> >> precision in sysfs anyway, but that is not true for in-kernel
> >> consumers. They have an easier time reading the "real" scale value
> >> compared to going via the string representation of fixed point
> >> returned from iio_format_value. At least the rescaler itself does so,
> >> which means that chaining rescalers might suffer needless accuracy
> >> degradation.
> > 
> > Agreed, that makes total sense.
> > 
> > If I'm not mistaken, the first condition in the case, if (!rem), will
> > return IIO_VAL_FRACTIONAL if the division is exact, keeping all the
> > precision. No?
> 
> Only if the resulting scale fits in nine decimals. That's never the
> case if you have primes other than 2 and 5 in the denominator (after
> eliminating gcd of course). Which mean that if you chain one rescaler
> doing 1/3 and one doing 3/1, you would get a combined scale of
> 0.999999999 instead of 3/3 if we take the approach of these patches.
> 
> So, what I'm after is that - for IIO_VAL_FRACTIONAL - not take the
> multiply-by-1e9 code path /unless/ the existing fractional approach
> overflows in either numerator or denominator (or both).

Understood, I'll update based on this.

> Side note: The same could be done for IIO_VAL_INT when the numerator
> overflows (since the denominator cannot overflow), but I guess that
> can be done later.

Agreed, I don't mind working on this later but I'd like to focus on
getting the current changes in first.

Thanks,
Liam

> Cheers,
> Peter
