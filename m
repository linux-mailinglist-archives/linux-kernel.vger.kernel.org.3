Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4894C5B53
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiB0N1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiB0N1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:27:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1357B3C;
        Sun, 27 Feb 2022 05:26:28 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s1so13843396edd.13;
        Sun, 27 Feb 2022 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBrVzJ9RNWnI4B6sopzRypLorlhMA3JejhjXEw8wiRM=;
        b=BrJ+UXE7YNgn3/+guNDpc0cZ/+0yN6s7GkZqJdF33vBGXiIJfXeMtNFGKy1iTvI+rj
         3eiirR32/WGVY2E/ZO0tc2+98Ane+PEEyirbJGD8s8Y019NA2phzLLvDKfRfrt4KUl7x
         ZRpWFSxADlT4wfcAqNzjrHrGqFY7GNT3eYGDmbrroRi4aJvTjnbNALYJLrTedX2Gq2iB
         IJWpoYKMbqwTT01v39DMuqx0J4uAmIc42sHoCon+z67k96Oztgz/s8P6seGgflDkq7G/
         lMwkhwJEPpUT1coX7x57gAYuXAWXCYRZQDffmCO++x0n18q9S3P6Z8tH6QlEJcPxqN4B
         xYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBrVzJ9RNWnI4B6sopzRypLorlhMA3JejhjXEw8wiRM=;
        b=gnOTCg5PZCTTxg2DUTZhfM3WEP0hwGbOiuE2EPaBpSdWaQpWBcx3stuAnPU4Ii0t0c
         PzViT5xF0dKZdVRSKG7/rG4Whl3/+E0gAxvnUmyNSw9tb3kwcuzAufmwUzWQeY57Nmcw
         +Guvh3SyFzIy4fmnDFqxMbDPUF6GzwPMX/KdICNCveRbdzIWTTQrQECzsCwas1n6cn5P
         cpj8rf1/LMfoMqqdjJ5DSvp27D/4ENpTNHZtMZytxY5IWJtxe8xJzRzSXD6Ik7WpvAf+
         XhfkhxWqnF9VnZWr6GuE9D6O/rJGcVjWjCBIMcbAssfwaA9XrMNrC9qbPa/G9qlTzvBF
         GZRg==
X-Gm-Message-State: AOAM532sUyw3xiQIVvkOs40ONr5YZFQU5cNjaWWcMmM9gG/9JmqH3leY
        HyqNC2g4z4eGFKdADY1A1HFvodXmGAF9BUlMO60=
X-Google-Smtp-Source: ABdhPJxCL/yjBNxfZ5dK/RXXsQehV7AjlpffnozroAcSGYE6XZ011tmcLEv7qApjN+prPC+W3vu3+twMY1fYmym+3Fg=
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id
 r24-20020a056402019800b0041083e321d7mr15410375edv.159.1645968386751; Sun, 27
 Feb 2022 05:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20220213025739.2561834-1-liambeguin@gmail.com>
 <20220227125559.72d5d79a@jic23-huawei> <20220227130546.5ed0bae1@jic23-huawei>
In-Reply-To: <20220227130546.5ed0bae1@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Feb 2022 15:25:50 +0200
Message-ID: <CAHp75VdNg--SAZ=8XqfZuhQ4iX3b9_O3psWHZZL8kO5hf7n14g@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] iio: afe: add temperature rescaling support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 2:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 27 Feb 2022 12:55:59 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat, 12 Feb 2022 21:57:29 -0500
> > Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > > Jonathan, Peter, Andy,
> > >
> > > This series focuses on adding temperature rescaling support to the IIO
> > > Analog Front End (AFE) driver.
> > >
> > > The main changes to the AFE driver include an initial Kunit test suite,
> > > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > > and temperature transducer sensors.

...

> > I was waiting for Andy to reply to this. Took a quick look back at
> > what was outstanding and realised he had given a
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > for v13.
>
> Actually given the units.h change is a perhaps non trivial perhaps that's
> why you dropped Andy's RB.  I'll still apply the series, but it Andy
> confirms his view on that tag before I push this out as something I can't
> rebase I'll add it if appropriate.

Since it was a separate patch, I'm fine with not including it due to
strong argument from Peter.

> > I'm assuming there wasn't a strong reason to drop that in the meantime
> > and it's a simple omission / crossed emails issue.
> >
> > As such,
> >
> > Series applied to the togreg branch of iio.git and pushed out
> > as testing to get some build coverage from 0-day.


-- 
With Best Regards,
Andy Shevchenko
