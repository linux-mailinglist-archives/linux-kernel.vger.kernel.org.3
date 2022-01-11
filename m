Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3A48AF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbiAKOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiAKOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:33:43 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEDEC06173F;
        Tue, 11 Jan 2022 06:33:43 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id fo11so18469066qvb.4;
        Tue, 11 Jan 2022 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qB2djtGD1hxaP7G4jORmDPeGTXVhGoKRKBRlWclrIhQ=;
        b=Te3hb8DmPGiSA2KdYMWN/gzL6+L5ZjxcE+Nc1AjO8Xt8pliJOMUugiSLC146zLEFH9
         n34fRaesqq8N3VVRRUdyHSV3bply69Ytsdb66QFJvhV7kfPm+KZenM4ugLQuA2X8nogs
         d/Kn1nlUrCEqDUXYBCrYKzq7ScY5A6wRq1B/Y7wxxCjc8719zTHXzy1oK9VZHXcY/Dew
         ixKwcYlhFfL+aJoS5baGhVhkBJZarB5ey97T1qU0dgHRum+gs2FLCRvC/9BiO9SIhvA+
         5Um2OIUJbZqnJk4p2OW7Py83ZMZl4xlZhncSKGNUqGyEpl41XqNh5JOGSWGD27sXu9Cz
         eC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qB2djtGD1hxaP7G4jORmDPeGTXVhGoKRKBRlWclrIhQ=;
        b=zeE2WGenLsU5B03z/DPSMvfyxaLSasjTvjWGR5wU4azGT0x3UYSG0zV2quYtCcXpxG
         TOk6N+TtIKqlsgH+KQ0rXogIS5G+8QK1XicWwtIKcYOhzmYCcHzPlYKBkOd1+K+d3abd
         9kWJaoRLs79Jdj0g/XqT9IHf8TeRRzyykRMr7eBYaz2aT+3lpAxixHIIUAczkMyEMJTG
         pu4SURc+zyidZmJFLRYXwcjS47R8emdRp2amNSzm0L22sc2V5+7tB93DZIdHMCw0Sj5N
         hW5WCBq4UGTDMS1zNTNewdhxPBQJxP/UoNcJ44AH3WHHG7DxLokuo8tRDfxItreuw21p
         TtMQ==
X-Gm-Message-State: AOAM532EC9cCx0ImIa6fWNyjsgWcEBNSm8jbJmr3u0jLfTVb6byloONz
        capW8i3kOU5aBoQwKqmuyyA=
X-Google-Smtp-Source: ABdhPJwRDT+thhWsUzuSkCSHEmm6JDp8W5FFjDjHhHYNgAuu1e39JzqEStoEo1vuy0yxBb51btAd2A==
X-Received: by 2002:ad4:596b:: with SMTP id eq11mr3867618qvb.16.1641911622049;
        Tue, 11 Jan 2022 06:33:42 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id s21sm4768339qta.11.2022.01.11.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:33:41 -0800 (PST)
Date:   Tue, 11 Jan 2022 09:33:38 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v12 07/16] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <Yd2VQkwle2+IiEAZ@shaak>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <20220108205319.2046348-8-liambeguin@gmail.com>
 <CAHp75Vdi2bvCEtxpezt5L5JhO=8D+Za++CbQ8AximFaLnxnqyg@mail.gmail.com>
 <8046b39f-28c1-7e46-e27c-6b9bc8824e21@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8046b39f-28c1-7e46-e27c-6b9bc8824e21@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 09:20:09PM +0100, Peter Rosin wrote:
> Hi!
> 
> On 2022-01-09 13:48, Andy Shevchenko wrote:
> > On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
> >>
> >> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> >> Add support for these to allow using the iio-rescaler with them.
> > 
> > ...
> > 
> >> +               mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
> >> +
> >> +               /*
> >> +                * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
> >> +                * OR *val2 is negative the schan scale is negative, i.e.
> >> +                * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
> >> +                */
> >> +               neg = *val < 0 || *val2 < 0;
> >> +
> >> +               tmp = (s64)abs(*val) * abs(rescale->numerator);
> >> +               *val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
> >> +
> >> +               tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
> >> +               tmp = div_s64(tmp, abs(rescale->denominator));
> > 
> > Isn't it too many repetitive abs() calls?
> > 
> > What about
> > 
> > // Create a macro and use for u16 (struct rn5t618_channel_ratios), s16
> > (struct twl4030_prescale_divider_ratios), s32 (can be reused in struct
> > rescale)
> > struct u32_fract {
> >   u32 numerator;
> >   u32 denominator;
> > };
> > // (potential reuse in struct hclge_ptp_cycle) and so on...
> > 
> >   struct u32_fract fract = {
> >     .numerator = abs(rescale->numerator),
> >     .denominator = abs(rescale->denominator),
> >   };
> > 
> > // obviously we can add a macro/inliner to abs() the fract struct and
> > return original sign
> > 
> > and reuse fract.numerator, fract.denominator?
> 
> This feels a bit excessive when the "problem" is two extra abs calls.
> I don't think the code will get any easier to read by changing
> abs(rescale->denominator) into fract.denominator and with my maintainer
> hat on, I vote for just letting the compiler exercise its CSE engine.

I agree with Peter here, and would rather keep it as is.

Liam

> Cheers,
> Peter
