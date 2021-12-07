Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9AE46C1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhLGR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLGR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:26:02 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:22:31 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id de30so15432621qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKXAfXf4jawMz0DDlq0/fhYvrtfDoveHg4joGIV1tHc=;
        b=HHBRg//NtTWRHhc7T2JTj+UEO6h8PdNWedTWAD4U85T0W79dQF95pQPl+9SD824n9D
         v6GQDFcSUs2t91zLJpA4vMlg4JnH0NXEeYEHBqmL9jd5COtKdvzZoxu8ht1tXMiGdP/q
         rQktpiAq8aSBhBZzc1+zVqmnx+ymGtMv0eDmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKXAfXf4jawMz0DDlq0/fhYvrtfDoveHg4joGIV1tHc=;
        b=hxLYry1oisbJyKPq42geI4Tq09t1GSs73syt4qgEqYCpQLILDbaKyEWJVGWXdi0jCR
         AakrhQbq3v2gLItOxK6w0GjnyVU+YBYdFzCXMEe8jaJqSqCX/NP0cFmh7jAJdHk5++iA
         zzR+kx4bBMCUDsXmIu4kUMsFYx/9k7XdtZKJuHWB/+CsbpGQqXr08jefUwJJckJD1bPh
         m8Kc6LOW8LDxkfknEUjeAKy239E0YAJWRaXK2TiaVXHoYPMkfdSkrOdpEas8wSNEln6F
         Z8U4cihCCGsgBAxOSdBVO80B5Rg6AgGq6t7WK9n8vbEvPdfKen4rF7frs0kD6Hr/R5na
         zVvg==
X-Gm-Message-State: AOAM533mD08iTp8PxSp+g9jphDi49n+ue5kosDFoTsrp2zxtZt9Kp+74
        mUNwdjp6sF6uHWzwIWFoGEudOSs7qKpQWA==
X-Google-Smtp-Source: ABdhPJyEykdMRM8yy2FBwIn+8yTZnpF8Va8vYVfj/oSx4jm9bcxN5qtYMzRFPOwIGnsXsnVGGDd4jg==
X-Received: by 2002:a37:a714:: with SMTP id q20mr471953qke.688.1638897744868;
        Tue, 07 Dec 2021 09:22:24 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id f34sm262250qtb.7.2021.12.07.09.22.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:22:24 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id l8so14976485qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:22:24 -0800 (PST)
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr52681316jal.82.1638897244878;
 Tue, 07 Dec 2021 09:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20211206162907.1.I1f5d1eba741e4663050ec1b8e39a753f6e42e38b@changeid>
 <CA+cxXhkmsUMCCJrvbz76nx-ctzSZhg0BFb50qD3nzUon3-Gp+w@mail.gmail.com>
 <CAD=FV=Wr1oai4-oBSJDiuMEV=KYZjW815jL1kh+yuiGdkK3ZbQ@mail.gmail.com> <CA+cxXhmFp31g+_hqj12FVy8Qu7xgssw3aA23OyEBrmTEys9B_w@mail.gmail.com>
In-Reply-To: <CA+cxXhmFp31g+_hqj12FVy8Qu7xgssw3aA23OyEBrmTEys9B_w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Dec 2021 09:13:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wu6ouGBrjVRqLY42RxrAxMPWZuyY7PZuSAE3VoVM92Rg@mail.gmail.com>
Message-ID: <CAD=FV=Wu6ouGBrjVRqLY42RxrAxMPWZuyY7PZuSAE3VoVM92Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Add backpointer to drm_device
 in drm_dp_aux
To:     Philip Chen <philipchen@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 7, 2021 at 8:52 AM Philip Chen <philipchen@chromium.org> wrote:
>
> Hi
>
> On Tue, Dec 7, 2021 at 8:13 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Dec 6, 2021 at 5:44 PM Philip Chen <philipchen@chromium.org> wrote:
> > >
> > > Hi
> > >
> > > On Mon, Dec 6, 2021 at 4:29 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > When we added the support for the AUX channel in commit 13afcdd7277e
> > > > ("drm/bridge: parade-ps8640: Add support for AUX channel") we forgot
> > > > to set "drm_dev" to avoid the warning splat at the beginning of
> > > > drm_dp_aux_register(). Since everything was working I guess I never
> > > > noticed the splat when testing against mainline. In any case, it's
> > > > easy to fix. This is basically just like commit 6cba3fe43341 ("drm/dp:
> > > > Add backpointer to drm_device in drm_dp_aux") but just for the
> > > > parade-ps8640.
> > > >
> > > > Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > index 26898042ba3d..818704bf5e86 100644
> > > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > @@ -449,6 +449,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
> > > >         if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> > > >                 return -EINVAL;
> > > >
> > > > +       ps_bridge->aux.drm_dev = bridge->dev;
> > > >         ret = drm_dp_aux_register(&ps_bridge->aux);
> > > >         if (ret) {
> > > >                 dev_err(dev, "failed to register DP AUX channel: %d\n", ret);
> > > > --
> > > > 2.34.1.400.ga245620fadb-goog
> > > >
> > >
> > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> >
> > That's probably not quite the right tag. I'm going to assume you meant
> > Reviewed-by? Usually Signed-off-by is added if you were one of the
> > authors of the patch or you were a maintainer that "touched" the patch
> > on its way to landing upstream...
> >
> > -Doug
>
> Sorry for the mistake.
> You're right - I meant to:
>
> Reviewed-by: Philip Chen <philipchen@chromium.org>

Thanks! Since this is pretty trivial/straightforward, I've pushed it.
I ended up pushing it to drm-misc-next instead of drm-misc-fixes to
avoid a merge conflict and because this doesn't seem urgent enough to
justify having to deal with the merge conflict. Please yell if I
should make a different choice in instances like this in the future.

f8378c040381 drm/bridge: parade-ps8640: Add backpointer to drm_device
in drm_dp_aux

-Doug
