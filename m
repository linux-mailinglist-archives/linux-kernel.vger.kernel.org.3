Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65548FE3C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 18:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiAPRwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 12:52:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52130 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiAPRwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 12:52:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5DBDB80D89
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2176C36AE9;
        Sun, 16 Jan 2022 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355518;
        bh=e196+80gZDFY6t38nfH8INeMt4XIIH4zE3u56D+0ETk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBZK89MD3fkHSnoBqePCmvh9XjBqaAo8v8fFwWAYKowaOMQMa9/l7IMebZ9BRMc5F
         I0HUJq5SMrhZGzA3YtUepSIJ7lAheItdpax5zyb/pOCo1N3poD7f+V4c0X5oz9OwTg
         g6+KAPNwz3eOdF1G3GDcxWtCz8V9bsUM/CGO3qXbkLRLYYE2sdhzc08YmleiuLKaGD
         nmf+Oq/BynP9Lg1ot9oGddsNF02SqGJPT4kEHnIu3Pqmyy4WGg7PgohUw0hi3xh/ak
         u0JUirbyMkBpT5fNufTQItJ8b3GhQTZgWMhOPyN7KoxzFsii0rm86JnsULxB4c2Bzy
         gJdclsJPxg3iA==
Date:   Sun, 16 Jan 2022 17:57:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        hverkuil-cisco@xs4all.nl, lee.jones@linaro.org,
        pmalani@chromium.org, sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Add export symbol namespace PL_CHROMEOS
Message-ID: <20220116175756.54919398@jic23-huawei>
In-Reply-To: <CAPUE2usF1m8rmE1_Nrdv_B5SfXExzKzGnhcZrmcSHFSMQzyjiw@mail.gmail.com>
References: <20220105220653.122451-1-gwendal@chromium.org>
        <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
        <CAPUE2uu3FPvxHHGYGbckxR=QmWt3=KwFk3DYoqBSmaQd+AO0QA@mail.gmail.com>
        <20220106110558.49dd6f26@coco.lan>
        <CAPUE2usF1m8rmE1_Nrdv_B5SfXExzKzGnhcZrmcSHFSMQzyjiw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 01:31:23 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Thu, Jan 6, 2022 at 2:06 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> >
> > Em Wed, 5 Jan 2022 20:26:36 -0800
> > Gwendal Grignou <gwendal@chromium.org> escreveu:
> >  
> > > On Wed, Jan 5, 2022 at 2:58 PM Dmitry Torokhov <dtor@chromium.org> wrote:  
> > > >
> > > > Hi Gwendal,
> > > >
> > > > On Wed, Jan 5, 2022 at 2:07 PM Gwendal Grignou <gwendal@chromium.org> wrote:  
> > > > >
> > > > > Add a symbol namespace for functions exported by the plaform chromeos
> > > > > subsystem.  
> > > >
> > > > It would be great to explain why this is needed/desirable. What are
> > > > the benefits of introducing this namespace? What problem are you
> > > > trying to solve?  
> > > The issue came when reviewing an iio sensor
> > > (https://www.spinics.net/lists/linux-iio/msg66280.html). I wanted to
> > > be ahead of the curve (for once).  
> >
> > Patch 01 should clearly document the reason why this is needed.
> > Yet, see below.
> >
> > While I see value on using namespaces, we should have extra care when
> > this is used for kAPIs designed for a product/system. I mean, what
> > prevents that the affected drivers won't support some day different
> > non-ChromeOS products? We have a media driver originally written to
> > work with the One Laptop Per Children hardware, that used some
> > product-specific kAPIs, that were extended a couple years later to
> > cover different types of hardware.
> >
> > What happens if some day, a driver introduced to be used on a ChromeOS
> > hardware would also be used by a non-ChromeOS hardware? This could
> > become messy as times goes by.
Hi Mauro,

I'm not sure I see why this case is a problem or any worse than the
namespacing that already exists in the function names.  We name a lot
of stuff after first device that used it and some of it lives for ever.
Sure, sometime it makes sense to rename when something becomes more
generic, but we can do that here as needed.

> >
> > Instead, IMO, it would make sense to have per-subsystem namespaces.
> > So, for instance, placing iio under an IIO-specific namespace
> > (and the same for other subsystems) makes more sense on my
> > eyes, as the namespace boundary will be clearer, and an IIO driver
> > will always be IIO, no matter on what hardware such driver would
> > be used.  
> I based this patchset on the current/future use in the IIO subsystem,
> where the namespaces are used for small subsystem like HID,
> IIO_HID_ATTRIBUTES, or code shared among sensors drivers of the same
> vendor (LTC2497, more to come).

Not particularly intended to be vendor based, more library module and client
of library cases.  Obviously it's relatively rare for multiple vendors
to produce IIO devices that are sufficiently compatible to share code
beyond the IIO core, but it does happen.  In that particular case the
library is called LTC2497 as it was the first part to use it it and
there wasn't a sensible generic name.  Vast majority of IIO cases will
be a core module exporting stuff to i2c and spi specific modules.

We have drivers named after a particular part that support parts from
multiple vendors of many different names.  So in a similar fashion
I'm not that worried about having some future driver have to include
one of the namespaces that is named after some other part. Perhaps
the issue here is that the chromeos platform stuff has a name tightly
coupled to a somewhat 'generic' but also somewhat closed hardware
ecosystem?

(Not really relevant here but I do longer term plan to move the main
IIO core into a namespace, but focusing on the smaller cases first as
I think both are valid).

So I'm in support of this series but maybe you are right in waiting for
the dust to settle :)  Note I'd also like to see an IIO_CHROMEOS or
similar NS for the symbols exported by cros_ec_sensors_core.c.

Eventually I'd expect some of the IIO chromeos modules to have
MODULE_IMPORT_NS(IIO);
MODULE_IMPORT_NS(IIO_CHROMEOS);
MODULE_IMPORT_NS(PL_CHROMEOS);

and probably some others...

Jonathan

> Since the usage of namespace in the kernel is not clearly defined yet,
> I wait for the dust to settle and more usage to emerge before tuning
> this patchset.
> 
> Thanks,
> Gwendal.
> >
> > Thanks,
> > Mauro  

