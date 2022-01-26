Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7749CA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiAZNID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:08:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:42168 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbiAZNIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202482; x=1674738482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ufV8tnp4+s0eKaTq+EbumSk5nBwGFfL7ygpVjn/q6M8=;
  b=XW8EqB9705Brt0muiI9bsFX5yR0+zL+dc0c5NqXPjTqdjlFv1Wsrv8/1
   Z6WfjGqEU8lZV6TBOF9cCdbe1DzqoQ5bmntGFVVDH91m1U8M1l5vUMw0e
   h+drQ/sdSuOYWwA7lBcCgTsEUZO7+qCOiczdWh1gcbktej8R7BLaZs1Dp
   +mVgvCbkdbXTrlZXhR2fVgCB+ObCdh5kHfCT4v0oc94Z7X7BsH1VfVsyY
   CttIH1TUaMTA+CQYFuGjl53sAmWgPtKN5Iz+FYKYsLlgmjvHD4PhxR3W1
   1JgzHkWvNGrkRfZZWCqFtVdDrAa5nAytXYXsqorRWP9KAKOjNTcncXjZm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309858908"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="309858908"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:08:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="581098861"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:07:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCi0h-00EbS3-GQ;
        Wed, 26 Jan 2022 15:06:51 +0200
Date:   Wed, 26 Jan 2022 15:06:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <YfFHa3ayE9wtil9Q@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:31:45AM +0100, Daniel Vetter wrote:
> On Wed, Jan 26, 2022 at 9:31 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jan 25, 2022 at 10:21:14PM +0200, Andy Shevchenko wrote:

...

> > I'm ok with the files moving if the dri developers agree with it.  It's
> > up to them, not me.
> 
> On one hand I'm happy anytime someone volunteers to help out.
> 
> On the other hand ... why does it have to be resurrecting fbdev?
> There's an entire community of people who really know graphics and
> display and spent considerable amount of effort on creating useful and
> documented helpers for pretty much anything you might ever want to do.

Why nobody has converted these drivers to be DRM based?

For all these years no new conversion happens except couple, which
I don't even have a hardware to see. But I have the hardware that
is supported exclusively by fbtft driver.

> And somehow we have to go back to typing out things the hard way, with
> full verbosity, for an uapi that distros are abandoning (e.g. even for
> sdl the direction is to run it on top of drm with a compat layer,
> afaiui fedora is completely ditching any userspace that still even
> uses /dev/fb/0). And yes I know there's still some gaps in drm,
> largely for display features which were really en vogue about 20 years
> ago. And we're happy to add that support, if someone who still has
> such hardware can put in the little bit of work needed ...
> 
> I don't get this.

I don't get how Fedora is related here.

It's not useful to bury the /dev/fbX out for the devices that
the use of are black-and-white output on small embedded systems.


-- 
With Best Regards,
Andy Shevchenko


