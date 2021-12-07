Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD746C107
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhLGQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhLGQ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:56:10 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C0BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:52:39 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e136so42536480ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LC8TQ58A6yrTmrin8RsMj+8+QtQUOswv6bH5qV0Utbo=;
        b=UZRValTXKR/oc2THTvTEl40AaZoZmmF1VJugCglgWkrEypPrLDI0WtDzKEuUloiA29
         puTXN4rluBzoT0/W3YiedwfQ2Gl7dhjeWPifCPF6TFLwnbc0enFpAyINl8ZPo6w5e0Va
         +7y/GVTWdHENc7oSdN5ODZNZrr22oq3zw4gzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LC8TQ58A6yrTmrin8RsMj+8+QtQUOswv6bH5qV0Utbo=;
        b=Hy5tJS4dPHbN9jkonjUbVm6O/srXF9JQbPJP4a7RkUvtGITNPr3CzwNYvuU8OngaUm
         XUDwKzN/m11oypa/B9YPN6VZBdm2kucM9AK5d57ZaueCALG8UbNFjsu8pujNGlRWhB1C
         8XPoh8estZb1FcJvfqhk4Hdn7m75YOdxczJRgBO0S1+v3WOqcm3FsIHGrIMzDEJp1E72
         bzE8anvRhfLuhEol3EeMeoincEc+M9PS8eKpoZ3c4izUjTsx8C4SFLGzxVGr+KSvwguq
         oBNozBg2Mk/36dwjNOZYRKkNBWeerI2gZlKI2t3J9lwv5i9O9B4U/Ke3J9fdzrSBUHsB
         0oMQ==
X-Gm-Message-State: AOAM533PKm3pGoVtDIMK/mMqus1ECc4rn9LsPVPieSXDclNF6txeAsXf
        VGNaeXHk9Bj+l4fWLCg7bnTq4YIA8gJdAd6sK/7Y2A==
X-Google-Smtp-Source: ABdhPJyEAPgMDBe6t6R0ogoPTPcmgRwjajGVsulJ6aI3aPgJSiokY9OsP1tpA3DsY3UKYVeJEf46azeAAOh7+sfnc/o=
X-Received: by 2002:a25:aea4:: with SMTP id b36mr54177634ybj.182.1638895958905;
 Tue, 07 Dec 2021 08:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20211206162907.1.I1f5d1eba741e4663050ec1b8e39a753f6e42e38b@changeid>
 <CA+cxXhkmsUMCCJrvbz76nx-ctzSZhg0BFb50qD3nzUon3-Gp+w@mail.gmail.com> <CAD=FV=Wr1oai4-oBSJDiuMEV=KYZjW815jL1kh+yuiGdkK3ZbQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wr1oai4-oBSJDiuMEV=KYZjW815jL1kh+yuiGdkK3ZbQ@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 7 Dec 2021 08:52:28 -0800
Message-ID: <CA+cxXhmFp31g+_hqj12FVy8Qu7xgssw3aA23OyEBrmTEys9B_w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Add backpointer to drm_device
 in drm_dp_aux
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Dec 7, 2021 at 8:13 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Dec 6, 2021 at 5:44 PM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Hi
> >
> > On Mon, Dec 6, 2021 at 4:29 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > When we added the support for the AUX channel in commit 13afcdd7277e
> > > ("drm/bridge: parade-ps8640: Add support for AUX channel") we forgot
> > > to set "drm_dev" to avoid the warning splat at the beginning of
> > > drm_dp_aux_register(). Since everything was working I guess I never
> > > noticed the splat when testing against mainline. In any case, it's
> > > easy to fix. This is basically just like commit 6cba3fe43341 ("drm/dp:
> > > Add backpointer to drm_device in drm_dp_aux") but just for the
> > > parade-ps8640.
> > >
> > > Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > index 26898042ba3d..818704bf5e86 100644
> > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > @@ -449,6 +449,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
> > >         if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> > >                 return -EINVAL;
> > >
> > > +       ps_bridge->aux.drm_dev = bridge->dev;
> > >         ret = drm_dp_aux_register(&ps_bridge->aux);
> > >         if (ret) {
> > >                 dev_err(dev, "failed to register DP AUX channel: %d\n", ret);
> > > --
> > > 2.34.1.400.ga245620fadb-goog
> > >
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
>
> That's probably not quite the right tag. I'm going to assume you meant
> Reviewed-by? Usually Signed-off-by is added if you were one of the
> authors of the patch or you were a maintainer that "touched" the patch
> on its way to landing upstream...
>
> -Doug

Sorry for the mistake.
You're right - I meant to:

Reviewed-by: Philip Chen <philipchen@chromium.org>
