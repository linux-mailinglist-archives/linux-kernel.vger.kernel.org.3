Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF747B59C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhLTWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhLTWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:00:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0B8C061746
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:00:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so506791pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YFHQWppCbOEAFqrREcsgFmxNS+L3tGaGeD2fMDLbOQs=;
        b=Ooq5mtLbhHBGvrLO9N3S8DKVBu4TyC/0xH2U+HDtDjdxlgSelm9jw/ydcATf3RXlQP
         CfsR7D5NHa6uRY7xW7BpPUI5+zMENwBv4cgOFAMdIf1GgaAN7R0B6F89lLkLve554xs1
         /RGW6xm5kAzxntrHEmCa3m3PmpcjBik7p894+XCyH0RcbPLofRl/HBrhF1DvycTgntCw
         OLjmviW7arzpICMT8NIxpXdjfVLdzOzWWwLl0qljCVOXkYGBWsXVbjp5BII36UcnoCWf
         36mvnuSFus05DnP/5p1eze1ViCYgAdTZIJVXAHT7PSkcjGRMWWF4yRUdnwoZvZRhCCdJ
         OZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YFHQWppCbOEAFqrREcsgFmxNS+L3tGaGeD2fMDLbOQs=;
        b=UOMifdaybGKEq3SGl9efDrg9rztPB7WRFfZTHgu//8fM9A6niU8UL7mh5c9sJCqQdc
         YuN+QIN9ykLuFH+0dF+pK6P4iEHxhWdrFFVQewJevXoCI1YkRMH96xlIFepvFLKGQ+M1
         LbuxeZNYVTMZXx8PL5jfdinzAUAS9h/G6aD3riF3Y5abTcvy2PuWtX2ahi5bkF7vsBsp
         hbMKh213rd/kG4GxqR8orBTdvEU5xeYcNPrqkjpOyLPx4MOWKtUl13MPW0g1sImjUTj9
         w2S9+/e8OmjmNz+sroqOBdjYtKNBF/Nu/t6v8f2enUT0fJn8+6pyB59+srDsa/ofYlwq
         uHwQ==
X-Gm-Message-State: AOAM533cXXM1TKILYPX073Aw+AU5hWuL8t7CMiLyFtS4kHSYKi9EH+yb
        owbA5TmOmgI4op/tKbg9PL4=
X-Google-Smtp-Source: ABdhPJzfKbh00OOS2Ax3BYY7qkAjc5pZuaFM4J70J2a7kJRPCEM8RhMHTBoI3ntM0Oh5V8ddiStFyw==
X-Received: by 2002:a17:902:a601:b0:148:adf2:9725 with SMTP id u1-20020a170902a60100b00148adf29725mr142062plq.136.1640037651105;
        Mon, 20 Dec 2021 14:00:51 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9632:a1c4:968a:6f66])
        by smtp.gmail.com with ESMTPSA id d1sm16593583pfj.90.2021.12.20.14.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 14:00:49 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:00:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        rajatxjain@gmail.com
Subject: Re: [PATCH v2 2/2] drm/privacy_screen_x86: Add entry for ChromeOS
 privacy-screen
Message-ID: <YcD9DkYLrdexyP0p@google.com>
References: <20211217202850.1967594-1-rajatja@google.com>
 <20211217202850.1967594-2-rajatja@google.com>
 <YcDegV8wqljpU3J0@google.com>
 <CACK8Z6FyvpjhHqh3PRfRFYAhVaxgkxBT_1SnYH0PkvNv5qwOvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6FyvpjhHqh3PRfRFYAhVaxgkxBT_1SnYH0PkvNv5qwOvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:29:18PM -0800, Rajat Jain wrote:
> Hello,
> 
> On Mon, Dec 20, 2021 at 11:50 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Dec 17, 2021 at 12:28:50PM -0800, Rajat Jain wrote:
> > > Add a static entry in the x86 table, to detect and wait for
> > > privacy-screen on some ChromeOS platforms.
> > >
> > > Please note that this means that if CONFIG_CHROMEOS_PRIVACY_SCREEN is
> > > enabled, and if "GOOG0010" device is found in ACPI, then the i915 probe
> > > shall return EPROBE_DEFER until a platform driver actually registers the
> > > privacy-screen: https://hansdegoede.livejournal.com/25948.html
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > > v2: * Use #if instead of #elif
> > >     * Reorder the patches in the series.
> > >     * Rebased on drm-tip
> > >
> > >  drivers/gpu/drm/drm_privacy_screen_x86.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_privacy_screen_x86.c b/drivers/gpu/drm/drm_privacy_screen_x86.c
> > > index a2cafb294ca6..0c5699ad70a3 100644
> > > --- a/drivers/gpu/drm/drm_privacy_screen_x86.c
> > > +++ b/drivers/gpu/drm/drm_privacy_screen_x86.c
> > > @@ -47,6 +47,18 @@ static bool __init detect_thinkpad_privacy_screen(void)
> > >  }
> > >  #endif
> > >
> > > +#if IS_ENABLED(CONFIG_CHROMEOS_PRIVACY_SCREEN)
> > > +static bool __init detect_chromeos_privacy_screen(void)
> >
> > Does marking this __init work in case there is a deferral?
> 
> Yes, I have verified that for Chromeos case, it is a deferral.
> 
> > Can it happen
> > that privacy screen is a module and so will get loaded only after we
> > discarded __init sections.
> 
> Perhaps. But I do not think that  is a problem. All the functions and
> data in this file are in __init sections, and this entry is here to
> ensure that the drm probe will wait for the privacy screen driver
> (whenever it is loaded).

Ah, OK, we are not leaking detect() pointers outside this module. 

> That is the reason, ideally we  would want to
> somehow restrict the privacy screen to be built into the kernel so as
> to minimize the delay if any.

I understand, but we can not code to the config we expect to use on
Chrome OS, we need to make sure we cover all possibilities.

Thanks.
-- 
Dmitry
