Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4058495023
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiATOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbiATOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:30:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B995C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:30:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l5so12421521edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCDpb+26SFz1wQvYU9DSOHXua0IKyerUiHHc0Cwap8E=;
        b=gfQd4+TvEmiS7NJiLo0g/BkOlizTO8gxf2GzXSbGpo1prZjzVybvWf1M5hWUn5D5yN
         YGmMY2GavTgDlVV1BFUJtZ7fGvzAIk8mPX/sAQzp7z1G2wl70nUSmbrlx3o6B2UBsEAx
         G3aPDDiDCk4/IZZeHhu8j62PfyWAGfRidHFqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SCDpb+26SFz1wQvYU9DSOHXua0IKyerUiHHc0Cwap8E=;
        b=bl+S5VHQHHUoThJaTDNtW5Mu2NgkdAfJzJ3KaQlXTFqw7wpaguBBlcSaC+Qq+i9q0P
         /CLZcW384Ma2c396iTOMJPqeuTlWde01KVR75kz7aC2VbUgxLcEsJriXOe99f4Hcw3ry
         oFyxvqgULZFaxVFNMImrVtmbF/3Qnc9VC1N8LgLaRmEITiCIOZAwlAGeEc8kndcaSI9k
         gEzLl+qWNAA4fxt9UnpKGox08UEbaOnU/dRMiY6KzFqDJvz+txRtEZpc1dNYitPEHP5m
         sVLmSaD2b5uFKba+lDHf0ugZMHSEHYOq7MO9ad2PuZBNAFGtD8doXWTIsxS8fe0ibTp1
         KjVw==
X-Gm-Message-State: AOAM533bvtqGSPSuHlNFQMtj6RxM92oUy4WT59BtwqkHT6PWJ8sHSpcI
        aGR+Jl/3UeDVfqlr53rrKxHzdg==
X-Google-Smtp-Source: ABdhPJxM9+iY32WnseakJpGa48pZv+dmbkVgLjm00azuMpDBLB/BXqsdyqEiyGJ1pFUzd4wpawDQsA==
X-Received: by 2002:a17:907:168d:: with SMTP id hc13mr18067115ejc.470.1642689051681;
        Thu, 20 Jan 2022 06:30:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id rl11sm1123297ejb.15.2022.01.20.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 06:30:50 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:30:48 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Message-ID: <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
Mail-Followup-To: Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>, Claudio Suarez <cssk@net-c.es>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119110839.33187-3-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:08:39PM +0100, Helge Deller wrote:
> This reverts commit 39aead8373b3c20bb5965c024dfb51a94e526151.
> 
> Revert this patch.  This patch started to introduce the regression that
> all hardware acceleration of more than 35 existing fbdev drivers were
> bypassed and thus fbcon console output for those was dramatically slowed
> down by factor of 10 and more.
> 
> Reverting this commit has no impact on DRM, since none of the DRM drivers are
> tagged with the acceleration flags FBINFO_HWACCEL_COPYAREA,
> FBINFO_HWACCEL_FILLRECT or others.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.16

So if this really has to come back then I think the pragmatic approach is
to do it behind a CONFIG_FBCON_ACCEL, default n, and with a huge warning
that enabling that shouldn't be done for any distro which only enables
firmware and drm fbdev drivers.

Plus adjusting the todo to limit it to drm drivers. Maybe also #ifdef out
the code that's then dead from fbcon.

Also in that case I guess it's ok to cc: stable, and really if you cc:
stable it needs to go down to 5.11, not 5.16.

And if we do that, I think that should go in through a -next cycle, or at
least quite some soaking before it's cherry-picked over. Enough to give
syzbot a chance to discover any path we've missed at least.
-Daniel

> ---
>  Documentation/gpu/todo.rst       | 21 ---------------
>  drivers/video/fbdev/core/fbcon.c | 45 ++++++++++++++++++++++++++------
>  2 files changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 29506815d24a..a1212b5b3026 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -300,27 +300,6 @@ Contact: Daniel Vetter, Noralf Tronnes
> 
>  Level: Advanced
> 
> -Garbage collect fbdev scrolling acceleration
> ---------------------------------------------
> -
> -Scroll acceleration is disabled in fbcon by hard-wiring p->scrollmode =
> -SCROLL_REDRAW. There's a ton of code this will allow us to remove:
> -
> -- lots of code in fbcon.c
> -
> -- a bunch of the hooks in fbcon_ops, maybe the remaining hooks could be called
> -  directly instead of the function table (with a switch on p->rotate)
> -
> -- fb_copyarea is unused after this, and can be deleted from all drivers
> -
> -Note that not all acceleration code can be deleted, since clearing and cursor
> -support is still accelerated, which might be good candidates for further
> -deletion projects.
> -
> -Contact: Daniel Vetter
> -
> -Level: Intermediate
> -
>  idr_init_base()
>  ---------------
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 22bb3892f6bd..b813985f1403 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1025,7 +1025,7 @@ static void fbcon_init(struct vc_data *vc, int init)
>  	struct vc_data *svc = *default_mode;
>  	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
>  	int logo = 1, new_rows, new_cols, rows, cols;
> -	int ret;
> +	int cap, ret;
> 
>  	if (WARN_ON(info_idx == -1))
>  	    return;
> @@ -1034,6 +1034,7 @@ static void fbcon_init(struct vc_data *vc, int init)
>  		con2fb_map[vc->vc_num] = info_idx;
> 
>  	info = registered_fb[con2fb_map[vc->vc_num]];
> +	cap = info->flags;
> 
>  	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
>  		logo_shown = FBCON_LOGO_DONTSHOW;
> @@ -1135,13 +1136,11 @@ static void fbcon_init(struct vc_data *vc, int init)
> 
>  	ops->graphics = 0;
> 
> -	/*
> -	 * No more hw acceleration for fbcon.
> -	 *
> -	 * FIXME: Garbage collect all the now dead code after sufficient time
> -	 * has passed.
> -	 */
> -	p->scrollmode = SCROLL_REDRAW;
> +	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
> +	    !(cap & FBINFO_HWACCEL_DISABLED))
> +		p->scrollmode = SCROLL_MOVE;
> +	else /* default to something safe */
> +		p->scrollmode = SCROLL_REDRAW;
> 
>  	/*
>  	 *  ++guenther: console.c:vc_allocate() relies on initializing
> @@ -1953,15 +1952,45 @@ static void updatescrollmode(struct fbcon_display *p,
>  {
>  	struct fbcon_ops *ops = info->fbcon_par;
>  	int fh = vc->vc_font.height;
> +	int cap = info->flags;
> +	u16 t = 0;
> +	int ypan = FBCON_SWAP(ops->rotate, info->fix.ypanstep,
> +				  info->fix.xpanstep);
> +	int ywrap = FBCON_SWAP(ops->rotate, info->fix.ywrapstep, t);
>  	int yres = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>  	int vyres = FBCON_SWAP(ops->rotate, info->var.yres_virtual,
>  				   info->var.xres_virtual);
> +	int good_pan = (cap & FBINFO_HWACCEL_YPAN) &&
> +		divides(ypan, vc->vc_font.height) && vyres > yres;
> +	int good_wrap = (cap & FBINFO_HWACCEL_YWRAP) &&
> +		divides(ywrap, vc->vc_font.height) &&
> +		divides(vc->vc_font.height, vyres) &&
> +		divides(vc->vc_font.height, yres);
> +	int reading_fast = cap & FBINFO_READS_FAST;
> +	int fast_copyarea = (cap & FBINFO_HWACCEL_COPYAREA) &&
> +		!(cap & FBINFO_HWACCEL_DISABLED);
> +	int fast_imageblit = (cap & FBINFO_HWACCEL_IMAGEBLIT) &&
> +		!(cap & FBINFO_HWACCEL_DISABLED);
> 
>  	p->vrows = vyres/fh;
>  	if (yres > (fh * (vc->vc_rows + 1)))
>  		p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
>  	if ((yres % fh) && (vyres % fh < yres % fh))
>  		p->vrows--;
> +
> +	if (good_wrap || good_pan) {
> +		if (reading_fast || fast_copyarea)
> +			p->scrollmode = good_wrap ?
> +				SCROLL_WRAP_MOVE : SCROLL_PAN_MOVE;
> +		else
> +			p->scrollmode = good_wrap ? SCROLL_REDRAW :
> +				SCROLL_PAN_REDRAW;
> +	} else {
> +		if (reading_fast || (fast_copyarea && !fast_imageblit))
> +			p->scrollmode = SCROLL_MOVE;
> +		else
> +			p->scrollmode = SCROLL_REDRAW;
> +	}
>  }
> 
>  #define PITCH(w) (((w) + 7) >> 3)
> --
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
