Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F39347D738
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbhLVSyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbhLVSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:54:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE805C061574;
        Wed, 22 Dec 2021 10:54:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y22so12351222edq.2;
        Wed, 22 Dec 2021 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2jS399/It1fJ+Sb/NuhbTruLk9QV9W0IDo5OUKxHQ4=;
        b=quc6TH6kAsqvBlyeSfQvY+pgIS8cnQqk2L7/gS9HqKXcicJpJyyvszpr4JBEzuvttL
         94mR1Ilg8TkyFXHtNj5vb6DhjyBuVtlV2wCYyAjSiHTkjNqsWY4kDao4nVSD1OrU5/dX
         AbSYSy2v5Dwi4M962EvMoZbanfgrbdPkhDMZpnGkACm3mwgJw5Cx8h+XWXKsuwPTDbim
         FexfGncIb3SzTZnvnZ/wdJ+VOAh2ox1EO8ytQ9pkdI9qU+yqksekz0FcgYlLj+kp1JHZ
         ZuLfCQ+EEVmDdL2mGRNrj1cIC7nO6PiijFlMR8OToTrEBX6ZuVcHo/lxCMX4XXrYbkk2
         SafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2jS399/It1fJ+Sb/NuhbTruLk9QV9W0IDo5OUKxHQ4=;
        b=rNqe5YO00rct3OwPsooxIFdlJGIGVWmhhlBaOud7qv9ttsCZQDiPpT3JtQI+qCl6PK
         bGUNUa7YSkvMNqX9tHvPoyHSsYrG3SkxsfOzjqC5Pg+XhlC1DCkGFiTrPfWH86WYqVAY
         En0yi+J8mWrPPGJ6/rS6k36TfuBr7iwk9CqzB41SYJJiua4NBrr8Y46n4hofqhHUPsVZ
         aOAy3c567z9n44O3WCJuQ2wwSxr69mXekDLjp6OCnoH8XcO669PbJY5QvQ4K1o34ymbE
         0umrZ30mGbOqEezfycvUXD7ZbcXEFMbPSesLUw8MJIWryVBZXJYgKK2xPgJwDENQYYi8
         QH8w==
X-Gm-Message-State: AOAM531hS3n2dWaxquwAnAaiD7zwCU1tObmUAtBVjYLM+eSo/VIZx7ef
        YX4+5eog05VoKTZsY1+vh0bDZl0pG1sskxJ4z7K1gEfc+Gk=
X-Google-Smtp-Source: ABdhPJzKwc9fnChtXEWF+d2DdQwtLWvq8Wo1rOo3bA+Derw5cFqXnv01TCR2WoGenae340ckXOOUIGwFKWps9x5jrYg=
X-Received: by 2002:aa7:cd75:: with SMTP id ca21mr4026016edb.242.1640199268479;
 Wed, 22 Dec 2021 10:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-5-liambeguin@gmail.com>
 <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com> <YcNscJ/fQhI7h6Uq@shaak>
In-Reply-To: <YcNscJ/fQhI7h6Uq@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 20:52:30 +0200
Message-ID: <CAHp75Vf6iN7yEdubKFkf+fXupVTco-toZN=a5+KNXG4Yv6oT3Q@mail.gmail.com>
Subject: Re: [PATCH v11 04/15] iio: afe: rescale: expose scale processing function
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

On Wed, Dec 22, 2021 at 8:20 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 12:21:01PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 22, 2021 at 5:46 AM Liam Beguin <liambeguin@gmail.com> wrote:

...

> > >  #include <linux/iio/consumer.h>
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/iio/afe/rescale.h>
> >
> > It should go before the consumer.h, no?
>
> I don't mind making the change, but why should it go before consumer.h?

'a' is earlier than 'c' in the alphabet, no?

...

> > And I would rather move the entire IIO group of headers...
>
> I can do that too. Do we have a convention for the ordering of #includes?
> What's usually the rule/guideline for this?

Guidelines suggest sorting without clear instructions. But in IIO and
pin control I suggest people use this kind of grouping.

> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/property.h>
> >
> > ... somewhere here (with blank line above).
> >
> > > -struct rescale;

...

> > Missed types.h and forward declarations like
> > struct device;
>
> Okay. will add linux/types.h

What about forward declaration?

-- 
With Best Regards,
Andy Shevchenko
