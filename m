Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7333C49CA93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiAZNSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:18:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:26123 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238386AbiAZNSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:18:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307261092"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="307261092"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:18:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="581101464"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:18:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nCiAx-00Ebfj-Q9;
        Wed, 26 Jan 2022 15:17:27 +0200
Date:   Wed, 26 Jan 2022 15:17:27 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfFJ5ykgMi+wBc2f@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
 <20220126102858.GX1951@kadam>
 <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:37:00PM +0100, Javier Martinez Canillas wrote:
> On 1/26/22 11:28, Dan Carpenter wrote:
> > On Wed, Jan 26, 2022 at 12:04:26PM +0200, Andy Shevchenko wrote:
> >> On Wed, Jan 26, 2022 at 12:02 PM Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> >>> On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>>> Am 25.01.22 um 21:21 schrieb Andy Shevchenko:
> >>
> >> ...
> >>
> >>>> But why? We already have DRM drivers for some of these devices.
> >>>
> >>> No, we do not (only a few are available).
> >>
> >> Sorry, I missed your word 'some'. Some == almost none from the list (I
> >> don't remember exact numbers but something like 2 out of 10 are
> >> supported by tiny DRM and see about interfaces).
> > 
> > Could we get an exact list?
> > 
> 
> The list AFAICT is the following. I'm not familiar with these so please
> feel free to correct anything I got wrong here.
> 
> I've marked with '?' if found references to the device supported by the
> fbdev driver in a DRM driver, but it's not clear if support the same HW.
> 
> Drivers in drivers/staging/fbtft:

Thanks!

Note, there is no support for the devices with parallel interface in the DRM.
So, basically we can't kill even a single one from fbtft if there is a user
for it.

>    fb_agm1264k-fl.c
>    fb_bd663474.c
>    fb_hx8340bn.c
>    fb_hx8347d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
>    fb_hx8353d.c
>    fb_hx8357d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
>    fb_ili9163.c (DRM driver in drivers/gpu/drm/tiny/ili9163.c)
>    fb_ili9320.c
>    fb_ili9325.c

>    fb_ili9340.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)

Not sure.

>    fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)

Yes and for the fact there are two drivers for the same chip in the DRM.
Overall there are three different drivers for Ilitek 9341.

>    fb_ili9481.c
>    fb_ili9486.c (DRM driver in drivers/gpu/drm/tiny/ili9486.c)
>    fb_pcd8544.c
>    fb_ra8875.c
>    fb_s6d02a1.c
>    fb_s6d1121.c
>    fb_seps525.c
>    fb_sh1106.c
>    fb_ssd1289.c
>    fb_ssd1305.c
>    fb_ssd1306.c
>    fb_ssd1325.c
>    fb_ssd1331.c
>    fb_ssd1351.c
>    fb_st7735r.c (DRM driver in drivers/gpu/drm/tiny/st7735r.c)
>    fb_st7789v.c (DRM driver in drivers/gpu/drm/panel/panel-sitronix-st7789v.c)
>    fb_tinylcd.c
>    fb_tls8204.c
>    fb_uc1611.c
>    fb_uc1701.c
>    fb_upd161704.c
>    fb_watterott.c

-- 
With Best Regards,
Andy Shevchenko


