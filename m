Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3899E471A60
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhLLNVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 08:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhLLNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 08:21:14 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A8C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 05:21:13 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bn20so20144083ljb.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OqbqU4KpmW/3a9GBJWdom5eobHCfr5y41fxq+2EJ74o=;
        b=FbCKqnEsfyakFxGNKJN3vDPQJyZz7PHJFIodMKcNY3Pdkgz7FXGzy0L7ocJr8COiWK
         MBmU/+89VqUS8h9PpPiRVMzqJjelW71Q2NYaiJFNG5GYdAIaq+273py08Q91+Svverty
         XPUIyiv41KHyqC4/mDtYdK3vVA3bq5A1QPph1wcgVybmiUXSWCJPMqMw72ipNLMUcoyP
         mwdeS0XnWgKi4u3TLeMTT5kqNpOKE+2Ndhl912oxMuEyxgXvKVSshHkqGJ8Z/ZkcJh9K
         myT62odNsUV0nn/h7yy/3p4UnYAYI2nvrvAqVqT0JS3DR0G3bKRkP2GkPEYHrmcAUOef
         Owrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqbqU4KpmW/3a9GBJWdom5eobHCfr5y41fxq+2EJ74o=;
        b=BTIQhzlcDWoaflmajuQEYtSeUYkIqIhb7kXCZrysp20bSBdzawo84Cwh89yrxBM+iP
         L1jO6Lt+gl12D86DZ4qWPZZ2TwRspCgpfzSNfelLNKrkTmDVxx/Y64z5l7gvzMH39b+Q
         ESvAWlJm30KaWhAocK+zUO4z4EpqgJj1DJSFvrsWyDWgSe0Qcli2L+HiiC9FzMezkPtD
         NQWdhy6EgfDKVWwLYb8IjiaxI6LmMzTPH0GFeiZtBQPGxRgi6TmJSr3q2e2JXyacmMwK
         d7TWKvhopqJ86uYTyB6JvhZUd6RVZsKJhJkTcf/HLPW6CCRk2gObBcsSwFgjZoqIFIdv
         xbFg==
X-Gm-Message-State: AOAM532epT6pnOOV0IHkD4Q3tehoOgK6mSf01w1VtPzQFfObh+Y4imVo
        HMS17NSGhBDN1i9K00iZPPt59osspqV87g==
X-Google-Smtp-Source: ABdhPJxyMcH3Sd75rK2a3m8f127DepuJ+gI6/b3Mxv85uX5aWMYqdyERzLWhjqz8aK60GNb8C9maDw==
X-Received: by 2002:a2e:9b17:: with SMTP id u23mr24197847lji.258.1639315271757;
        Sun, 12 Dec 2021 05:21:11 -0800 (PST)
Received: from rikard (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id s4sm1040386ljp.73.2021.12.12.05.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 05:21:11 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sun, 12 Dec 2021 14:21:08 +0100
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] drm/i915/gvt: Constify formats
Message-ID: <YbX3RPtqtGhoRSV1@rikard>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
 <20211204105527.15741-8-rikard.falkeborn@gmail.com>
 <6e73f014-730c-3334-c0e6-7e0665f47fec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e73f014-730c-3334-c0e6-7e0665f47fec@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 08:20:22AM +0000, Wang, Zhi A wrote:
> On 12/4/2021 12:55 PM, Rikard Falkeborn wrote:
> > These are never modified, so make them const to allow the compiler to
> > put them in read-only memory. WHile at it, make the description const
> > char* since it is never modified.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >   drivers/gpu/drm/i915/gvt/fb_decoder.c | 24 ++++++++++++------------
> >   1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/fb_decoder.c b/drivers/gpu/drm/i915/gvt/fb_decoder.c
> > index 11a8baba6822..3c8736ae8fed 100644
> > --- a/drivers/gpu/drm/i915/gvt/fb_decoder.c
> > +++ b/drivers/gpu/drm/i915/gvt/fb_decoder.c
> > @@ -40,12 +40,12 @@
> >   
> >   #define PRIMARY_FORMAT_NUM	16
> >   struct pixel_format {
> > -	int	drm_format;	/* Pixel format in DRM definition */
> > -	int	bpp;		/* Bits per pixel, 0 indicates invalid */
> > -	char	*desc;		/* The description */
> > +	int		drm_format;	/* Pixel format in DRM definition */
> > +	int		bpp;		/* Bits per pixel, 0 indicates invalid */
> > +	const char	*desc;		/* The description */
> >   };
> Thanks so much for this. According to the code of i915, we prefer using 
> one space as seperator.
> >   

Thanks for reviewing. Just to clarify, is this how you want it to look:

struct pixel_format {
	int drm_format;     /* Pixel format in DRM definition */
	int bpp;            /* Bits per pixel, 0 indicates invalid */
	char *desc;         /* The description */
};

Rikard
