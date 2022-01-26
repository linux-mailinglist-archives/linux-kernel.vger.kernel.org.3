Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D679A49C86C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiAZLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:15:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47730 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiAZLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:15:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B263B81CAA;
        Wed, 26 Jan 2022 11:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4310DC340E3;
        Wed, 26 Jan 2022 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643195755;
        bh=+4rsfIJDJ4RCHu7OuW2tvtcRhL9lTvl+RI6cItq5TAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JnwDZ8qRomlPUQLgU6z2cI1tStqj3Y3wu5rQ8Kjah36iZ1b8Q5ggGif26ysmeLjiX
         sILKvqs4FtBU4K1nHotRLY8D2OnXaFv5J+gNeSmB4vmhkoZMpesOrBVYhVGqeiB1tI
         qN1adwtil5CgHJZrpxUhzI5D3UfGSXvpvb8sevvE=
Date:   Wed, 26 Jan 2022 12:15:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfEtZD0uYp9yngvq@kroah.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <YfEmuGVQ+IlhdQDh@kroah.com>
 <CAKMK7uEiUH8vD3jUCDPXFbF2YS5LygJLVOosbnUnvMP0MU2kTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEiUH8vD3jUCDPXFbF2YS5LygJLVOosbnUnvMP0MU2kTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:52:16AM +0100, Daniel Vetter wrote:
> On Wed, Jan 26, 2022 at 11:47 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 12:02:36PM +0200, Andy Shevchenko wrote:
> > > On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > >
> > > > Hi
> > > >
> > > > Am 25.01.22 um 21:21 schrieb Andy Shevchenko:
> > > > > Since we got a maintainer for fbdev, I would like to
> > > > > unorphan fbtft (with the idea of sending PRs to Helge)
> > > > > and move it out of staging since there is no more clean
> > > > > up work expected and no more drivers either.
> > > > >
> > > > > Thoughts?
> > >
> > > Thanks for sharing yours, my answers below.
> > >
> > > > But why? We already have DRM drivers for some of these devices.
> > >
> > > No, we do not (only a few are available).
> > >
> > > > Porting
> > > > the others to DRM is such a better long-term plan.  OTOH, as no one has
> > > > shown up and converted them, maybe they should be left dead or removed
> > > > entirely.
> > >
> > > As I mentioned above there are devices that nobody will take time to
> > > port to a way too complex DRM subsystem. But the devices are cheap and
> > > quite widespread in the embedded world. I'm in possession of 3 or 4
> > > different models and only 1 is supported by tiny DRM.
> >
> > Great, then let's just move the 2 models that you do not have support
> > for in DRM, not the whole lot.  When we have real users for the drivers,
> > we can move them out of staging, but until then, dragging all of them
> > out does not make sense.
> 
> Can't we create drm drivers for these 2-3 models? Like we have drivers
> which are below 300 lines with all the helpers taking care of
> everything, this shouldn't be too tricky.

Agreed, having the hardware to test this with is the hardest part.
Andy, this should be better to do in the longrun than trying to keep
these other drivers "alive".

thanks,

greg k-h
