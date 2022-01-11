Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91F748B138
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349663AbiAKPrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiAKPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:47:41 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FEEC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:47:41 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so4536499ooj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMG0vbtEa+ML1xi6XUQirSdL6PThzAhk+T7wuKwADzk=;
        b=IuJx7n/w/EvIJQvmXmZO6O68L8pxYvFez3pzSAdz2MJ/yFaM4s0AHZJCXozWW8YLDV
         Zud7SIrTb8/P1VUt0l4alz3sJcK6oXN/UgOwPHivTzm7Rc6UgZyxYUM1t9IyLz4/4w3Y
         18NPuxOY2vOX1beWvFcYVtaZ6ZzchwB45XdaFYa5Amv5Hjim8fd0H5oT2TLRCeOOcG1l
         F7tPt2TDCDF36M5O76bLQDdViOXQWvm2VXy0/HCas2dNSW71QCbp3lUmMgGifX2STRgn
         5kVgzAuDbsGras11M+eyxJcfkHqUmKzBMB6osLdmGODvH/IxfhzAF5mXsqf8RXM4s+9A
         tTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMG0vbtEa+ML1xi6XUQirSdL6PThzAhk+T7wuKwADzk=;
        b=7q7qy3PcYDsEpk+mQG+HmjthnWuzMriX/EQUY7nLlFN5VrC91OgMTP0evNzOgXocH3
         DMPg85g3N0wvL2ZkxvSZLtn2IZA7G9ExfOnoLks60yAzcOuOUETuvXkFpPn78fnLmelq
         U2sVVaH8Jad851JbOzgvvjjktG7b0mPcP4z2gbKQufiIaNOvgHlVr7d25Of6gZQgOCAK
         o8WElLiqPEg+V6YbeTl7lNli5dsmEworKfGh2pG3siqi9xiFKrfYK3LRG2FmdrM1Iu11
         rWBp1n+NjQvVF0qVkn9RFZoZE7Som7a8F7rY4kvQRBC+AibSlpGSOC8i9f+sCP1d12vd
         OtZA==
X-Gm-Message-State: AOAM531NAnbsR/CzdA83xPgOfBxz3XxrURTh6mbYh/oJLthQ8mBQsD6E
        rI7g4J+H8TcriqGJZ4BfBOzt3sw1FXkpK+TPx0E=
X-Google-Smtp-Source: ABdhPJznbu977mBLf8BFtnM4LnUCv4oN39tXDyA0UffhTak52PzKEZ7+ARl+Gh74qb/NmSkFDVimWK15hH2MtsVMmY8=
X-Received: by 2002:a4a:9568:: with SMTP id n37mr3492430ooi.73.1641916061107;
 Tue, 11 Jan 2022 07:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20211230040626.646807-1-victor.liu@nxp.com> <CADnq5_PsxrYeZ+p5NbXRks3EaJrYNMN+vbUJkiKHZ4cf=x=dsg@mail.gmail.com>
 <d4ae974f38d96bc02db6c137e622315388a99ba0.camel@nxp.com>
In-Reply-To: <d4ae974f38d96bc02db6c137e622315388a99ba0.camel@nxp.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 11 Jan 2022 10:47:29 -0500
Message-ID: <CADnq5_OxdYK9E8NRk2ExRdwgKdO0L431MaP8TOqvDMcrt61zcw@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic: Check new_crtc_state->active to determine if
 CRTC needs disable in self refresh mode
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed out to drm-misc-next-fixes.

Alex

On Fri, Jan 7, 2022 at 9:07 PM Liu Ying <victor.liu@nxp.com> wrote:
>
> On Fri, 2022-01-07 at 14:53 -0500, Alex Deucher wrote:
> > On Wed, Dec 29, 2021 at 11:07 PM Liu Ying <victor.liu@nxp.com> wrote:
> > >
> > > Actual hardware state of CRTC is controlled by the member 'active'
> > > in
> > > struct drm_crtc_state instead of the member 'enable', according to
> > > the
> > > kernel doc of the member 'enable'.  In fact, the drm client modeset
> > > and atomic helpers are using the member 'active' to do the control.
> > >
> > > Referencing the member 'enable' of new_crtc_state, the function
> > > crtc_needs_disable() may fail to reflect if CRTC needs disable in
> > > self refresh mode, e.g., when the framebuffer emulation will be
> > > blanked
> > > through the client modeset helper with the next commit, the member
> > > 'enable' of new_crtc_state is still true while the member 'active'
> > > is
> > > false, hence the relevant potential encoder and bridges won't be
> > > disabled.
> > >
> > > So, let's check new_crtc_state->active to determine if CRTC needs
> > > disable
> > > in self refresh mode instead of new_crtc_state->enable.
> > >
> > > Fixes: 1452c25b0e60 ("drm: Add helpers to kick off self refresh
> > > mode in drivers")
> > > Cc: Sean Paul <seanpaul@chromium.org>
> > > Cc: Rob Clark <robdclark@chromium.org>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Do you need someone to push this for you?
>
> Yes, please.  Thanks.
>
> Liu Ying
>
> >
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> > > b/drivers/gpu/drm/drm_atomic_helper.c
> > > index a7a05e1e26bb..9603193d2fa1 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -1016,7 +1016,7 @@ crtc_needs_disable(struct drm_crtc_state
> > > *old_state,
> > >          * it's in self refresh mode and needs to be fully
> > > disabled.
> > >          */
> > >         return old_state->active ||
> > > -              (old_state->self_refresh_active && !new_state-
> > > >enable) ||
> > > +              (old_state->self_refresh_active && !new_state-
> > > >active) ||
> > >                new_state->self_refresh_active;
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
>
