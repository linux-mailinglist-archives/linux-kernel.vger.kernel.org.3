Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C630C46C080
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhLGQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhLGQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:17:20 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E82C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:13:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p23so17773680iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzGboToRcV0ILOazZeGz7y2npnpA2DxrrdkkmwY41hM=;
        b=JriXVx9KiAH7TFoDJ2n7F6ZdaBtzxmBEHQ80eMzObRJ6M89o2rLqEBAs1WSa54Z0NW
         6JzbJjafp01F7Kmt+FE9HVqsjp5cyOTm0WDQgoFdt56u0/GKDol2IjWW/RPWXfMl2qAx
         uDP6L7d9bTe4VxDPPlvA3dZ7ltDLg4My5F4r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzGboToRcV0ILOazZeGz7y2npnpA2DxrrdkkmwY41hM=;
        b=aIY5KxAOnF+o789899YqiPxrfdtbW40zuGLGR1MRN9EBIgxP3RjXcZnNO87EmHDju2
         THIDhB2EkLYQv52K7Rdhw5utQP+KyHre9XcHLqrIpIjS7aIAovqFV3Do+zL/oJg38AX1
         r4/NLxssXx8JkjzJK7LcpXMcoNZzYSu1xD64E5yYDjvseCQWKacW6MhiOfCfRqVORxCL
         Rgri0HlxfXmyJ94w3qdhj4weEo5VdBdJzvkeO4t8/tjVYvrehhKteKtpwKHR8bkbaMYl
         9cHScNaOvrZAnf+p1lWk5zchneMK5gJauAcZnhYMg3KSia9RVpcMN73jbsZvHQX5sKg2
         Kavg==
X-Gm-Message-State: AOAM532SjxloBBEUWI+MjN1MyOQo5EtH42HByGXNZYUsZRj3PymxDjZR
        TbyMF6DppHotTYxpmxrJMN/QwMdU+5XdMg==
X-Google-Smtp-Source: ABdhPJzwL8kL7j0q3kjwGwDbAy8HeLaD6A5P69dyYBd8qe1KwCUF04WYNxjVKlDvRxuacORAf/SU3Q==
X-Received: by 2002:a05:6602:2f15:: with SMTP id q21mr296740iow.113.1638893629397;
        Tue, 07 Dec 2021 08:13:49 -0800 (PST)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id l17sm52739ilk.22.2021.12.07.08.13.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:13:48 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id s11so14367115ilv.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:13:48 -0800 (PST)
X-Received: by 2002:a05:6e02:144f:: with SMTP id p15mr329453ilo.180.1638893627637;
 Tue, 07 Dec 2021 08:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20211206162907.1.I1f5d1eba741e4663050ec1b8e39a753f6e42e38b@changeid>
 <CA+cxXhkmsUMCCJrvbz76nx-ctzSZhg0BFb50qD3nzUon3-Gp+w@mail.gmail.com>
In-Reply-To: <CA+cxXhkmsUMCCJrvbz76nx-ctzSZhg0BFb50qD3nzUon3-Gp+w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Dec 2021 08:13:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wr1oai4-oBSJDiuMEV=KYZjW815jL1kh+yuiGdkK3ZbQ@mail.gmail.com>
Message-ID: <CAD=FV=Wr1oai4-oBSJDiuMEV=KYZjW815jL1kh+yuiGdkK3ZbQ@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 5:44 PM Philip Chen <philipchen@chromium.org> wrote:
>
> Hi
>
> On Mon, Dec 6, 2021 at 4:29 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > When we added the support for the AUX channel in commit 13afcdd7277e
> > ("drm/bridge: parade-ps8640: Add support for AUX channel") we forgot
> > to set "drm_dev" to avoid the warning splat at the beginning of
> > drm_dp_aux_register(). Since everything was working I guess I never
> > noticed the splat when testing against mainline. In any case, it's
> > easy to fix. This is basically just like commit 6cba3fe43341 ("drm/dp:
> > Add backpointer to drm_device in drm_dp_aux") but just for the
> > parade-ps8640.
> >
> > Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 26898042ba3d..818704bf5e86 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -449,6 +449,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
> >         if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> >                 return -EINVAL;
> >
> > +       ps_bridge->aux.drm_dev = bridge->dev;
> >         ret = drm_dp_aux_register(&ps_bridge->aux);
> >         if (ret) {
> >                 dev_err(dev, "failed to register DP AUX channel: %d\n", ret);
> > --
> > 2.34.1.400.ga245620fadb-goog
> >
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>

That's probably not quite the right tag. I'm going to assume you meant
Reviewed-by? Usually Signed-off-by is added if you were one of the
authors of the patch or you were a maintainer that "touched" the patch
on its way to landing upstream...

-Doug
