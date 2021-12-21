Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BEA47C566
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbhLURuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbhLURuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:50:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42253C061574;
        Tue, 21 Dec 2021 09:50:24 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a1so13547729qtx.11;
        Tue, 21 Dec 2021 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XXCtO0JFViUQ4+LHr/arkANJI9x3qLGM5DbuHmIW9MU=;
        b=cqdR1FXALBsdAIeIV8vtSvxZ70JS3zhSNmmMXFZ+JH/4m2aL7sBmKnqBDR+urVXOb8
         q4R8Uksz5dAgQ4gfrUnGf3gpmHO7hsN8EE+//PW30tBu2+5JIDFz3oC4re/lO0Ml18Ot
         A8ujRtbPFwddS5kFLaNldkEN+N09qZydmxaUmZysCFtyrZGRW8BbfuwiVZRxjeYph0vU
         MM24J1HKxS8jMYboQAtW7osZFku7lSxThL5i9dcc0jBo2f5lm0HQweVqfdd7W7icoJC9
         NQU+8bOAMS1rhI3wRj9XTMclESA369bYgx3FL8SODJBwYCnlr4zcK7R+RQcjfRhWxKUb
         JQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXCtO0JFViUQ4+LHr/arkANJI9x3qLGM5DbuHmIW9MU=;
        b=5nGgZG2Zin3/qWjT3mSsDC651aclN87h32OhBPg1Z2T7rz+f90rYo3NtXHrAFmlOP3
         s/AKXiA2qACUyGY+HgL3cA275MhrvDUKJ2Rjh7P0UYSS7BJDNYBLm18CGczlsveci7fw
         KxfpwEqsvOdNiJY49QBo1aH7Si4x13INygahH/7aqYjfxsfMWMNH/A3uQUmK5tcVOTAy
         rSXWT6+ZD3Icu5fNlS9df2pdZxfecqmsHQmY+S3vJgahAD3X4pQqJn1sITWyj/SC4Ox5
         QTsJ8aH/fQK2uz9bpqKvSzNk0/ewubjRqbq/KpdrgqjuqIolcnxL0/5OJ0HnofgRqprb
         gE2g==
X-Gm-Message-State: AOAM532aaudu2Ar3ITaGQzZKNzRBz85QAxliIfKlUvjzEqpgGB3QqXGa
        QF6sRyYWgYXTM2gdU+Kob1w=
X-Google-Smtp-Source: ABdhPJyeulBwLEh9V+XaacXqpvSjj6KHvXBaAAnnedu0bOYFuAneCqi9bMrqxJk9NI3BIhYZGBLMaw==
X-Received: by 2002:ac8:4459:: with SMTP id m25mr3185735qtn.659.1640109023435;
        Tue, 21 Dec 2021 09:50:23 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id t3sm782344qtc.7.2021.12.21.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 09:50:22 -0800 (PST)
Date:   Tue, 21 Dec 2021 12:50:20 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v10 03/14] iio: inkern: make a best effort on offset
 calculation
Message-ID: <YcIT3BSIKJKVWAgN@shaak>
References: <20211219223953.16074-1-liambeguin@gmail.com>
 <20211219223953.16074-4-liambeguin@gmail.com>
 <CAHp75Ve_vv619-UxdBN+xhWGm32tCJkkN3epVRgCiLF7p6xMOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve_vv619-UxdBN+xhWGm32tCJkkN3epVRgCiLF7p6xMOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Dec 21, 2021 at 07:42:31AM +0200, Andy Shevchenko wrote:
> On Mon, Dec 20, 2021 at 11:17 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > iio_convert_raw_to_processed_unlocked() assumes the offset is an
> > integer. Make a best effort to get a valid offset value for fractional
> > cases without breaking implicit truncations.
> 
> ...
> 
> > +                       offset_val /= (1 << offset_val2);
> 
> Besides potentially being problematic (if arg is 31 for the left
> shift) why not simply
> 
> _val >>= _val2;

That is safer, and more elegant! I'll update.

Thanks,
Liam

> --
> With Best Regards,
> Andy Shevchenko
