Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6F49CA24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiAZM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbiAZM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:56:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC81C06173B;
        Wed, 26 Jan 2022 04:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2203B61A3D;
        Wed, 26 Jan 2022 12:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2038C340E3;
        Wed, 26 Jan 2022 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643201774;
        bh=+uQzWCy3goF3RaLFGLDlYtTmhbKDwJ9mmroAyGz68E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktW4xyvmOe9ChP6gtf/lRqUThgjRVhgORLSFiSKHpg9Fbg9q4ywvt2V1Pk8495zsw
         r0w87+hKzyOlWngV8M6cW9TWY/lkNKTY/XQLPzdt14VKcfO/tmcAp5MDWkISDu6lnK
         IFuDvJw5FKnkgMv1YCYDD83d1UYwrRLMZxge6nvc=
Date:   Wed, 26 Jan 2022 13:56:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfFE61IQus3SMQRZ@kroah.com>
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
> 
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
>    fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)
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

I'll gladly take a patch that deletes the fb_* files that are already
handled by a DRM driver like you list here.

thanks,

greg k-h
