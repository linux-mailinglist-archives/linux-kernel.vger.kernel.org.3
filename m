Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6953CBD9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiFCO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiFCO4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:56:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EC039140
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:56:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so10475988edm.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4a6KGVhjH6y6xz434jAPlzbw5+tQRvsZavD2ogDpA40=;
        b=ZN3iQHwhLE5qo3rpIL9Vu2Mv6k9taHjnyCkzFkyAhP4P7SnJwDM7bilg9UU1yypXH6
         RfcQ1ogSV7zl6uyFog1yuB3eOMNolwbpUyMFaE7GJxP81N7/S8fMUQJ/4QfAoKIFpoZs
         PQEi07K/NfJ7a7p7Y/j2BZ1ueqkgKprsgDVZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4a6KGVhjH6y6xz434jAPlzbw5+tQRvsZavD2ogDpA40=;
        b=wwh83j1fdCLA+fXi0Sxzam5kj2QKhr87D1bbZGHkrgFAL4moQP6Ma+K2XpeDGgtIEa
         rnST5ZDql50C/z1VIQ4zCv/eaKD30mz2Bxy0wx8wloR/4YrU83e54k4O9+4lYCwoWQnG
         T0rtW4gMeqxBHh2Q/UYNVn33MwBzsJWYOlKyE9NYHBt+vQq+NsH+mBeKRC3hCaR9Ki8S
         lbi1yCwYZp396fSkqA7szy+qDos+afeAjKvOpE9BoxN8kNNbS+EF5ww9aptnP/JNZ1Ud
         y9VkyzhdUf6oEz/sHTwmkB0ObeAV5oLtEgSGtdrMsK01ahLjuwdxNQdaKCVzL4aO/jfh
         0Xbw==
X-Gm-Message-State: AOAM530N4vq6aG/W9TZAAUuO7DpsSaUPPm1Kc3mDR7cb//4GjQC9ZKMR
        xZbrZa3nXAG2s5/9NS2F0LBNugVAl0FAsDK+kg0=
X-Google-Smtp-Source: ABdhPJyJgDS4jQkoNxTwdLjw/xc6P6VznOPJAdLRnbLi+qFmZ6I2VaFvci++W1rYtwtGFrn2nIwgZQ==
X-Received: by 2002:a05:6402:2926:b0:42e:1f3c:d041 with SMTP id ee38-20020a056402292600b0042e1f3cd041mr7097563edb.240.1654268196191;
        Fri, 03 Jun 2022 07:56:36 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id f24-20020a05640214d800b0042617ba63basm4038476edx.68.2022.06.03.07.56.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 07:56:33 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id t6so10738910wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 07:56:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr8307872wry.513.1654268189313; Fri, 03 Jun
 2022 07:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
 <20220521091751.opeiqbmc5c2okdq6@houat> <CAD=FV=Wea0LT5umK4Xg87cDikim+dSuyLndfydO3_DnTujZr9Q@mail.gmail.com>
 <CAD=FV=XqJuPHxm7HYMvyHBL_zC-BBA_f0MBsZX-jHt7Pk9ngsQ@mail.gmail.com>
 <20220603082139.sfdxb5ndwpvlhklh@penduick> <CAA8EJpqrw63K_xxJjawLjEqP-05eUD-k6dy21162hcq7q07jgQ@mail.gmail.com>
 <20220603141405.dybjn3blifau6662@penduick>
In-Reply-To: <20220603141405.dybjn3blifau6662@penduick>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Jun 2022 07:56:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wy_HnshYRcLFRddo0-w=v6sfnzhRYJd+eH0S7uMPxqaQ@mail.gmail.com>
Message-ID: <CAD=FV=Wy_HnshYRcLFRddo0-w=v6sfnzhRYJd+eH0S7uMPxqaQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 3, 2022 at 7:14 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Fri, Jun 03, 2022 at 01:19:16PM +0300, Dmitry Baryshkov wrote:
> > On Fri, 3 Jun 2022 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Tue, May 31, 2022 at 02:06:34PM -0700, Doug Anderson wrote:
> > > > On Mon, May 23, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > > On Sat, May 21, 2022 at 2:17 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > On Tue, May 10, 2022 at 12:29:43PM -0700, Douglas Anderson wrote:
> > > > > > > This adds a devm managed version of drm_bridge_add(). Like other
> > > > > > > "devm" function listed in drm_bridge.h, this function takes an
> > > > > > > explicit "dev" to use for the lifetime management. A few notes:
> > > > > > > * In general we have a "struct device" for bridges that makes a good
> > > > > > >   candidate for where the lifetime matches exactly what we want.
> > > > > > > * The "bridge->dev->dev" device appears to be the encoder
> > > > > > >   device. That's not the right device to use for lifetime management.
> > > > > > >
> > > > > > > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > >
> > > > > > If we are to introduce more managed helpers, I think it'd be wiser to
> > > > > > introduce them as DRM-managed, and not device managed.
> > > > > >
> > > > > > Otherwise, you'll end up in a weird state when a device has been removed
> > > > > > but the DRM device is still around.
> > > > >
> > > > > I'm kinda confused. In this case there is no DRM device for the bridge
> > > > > and, as per my CL description, "bridge-dev->dev" appears to be the
> > > > > encoder device. I wasn't personally involved in discussions about it,
> > > > > but I was under the impression that this was expected / normal. Thus
> > > > > we can't make this DRM-managed.
> > > >
> > > > Since I didn't hear a reply,
> > >
> > > Gah, I replied but it looks like somehow it never reached the ML...
> > >
> > > Here was my original reply:
> > >
> > > > > > This adds a devm managed version of drm_bridge_add(). Like other
> > > > > > "devm" function listed in drm_bridge.h, this function takes an
> > > > > > explicit "dev" to use for the lifetime management. A few notes:
> > > > > > * In general we have a "struct device" for bridges that makes a good
> > > > > >   candidate for where the lifetime matches exactly what we want.
> > > > > > * The "bridge->dev->dev" device appears to be the encoder
> > > > > >   device. That's not the right device to use for lifetime management.
> > > > > >
> > > > > > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > >
> > > > > If we are to introduce more managed helpers, I think it'd be wiser to
> > > > > introduce them as DRM-managed, and not device managed.
> > > > >
> > > > > Otherwise, you'll end up in a weird state when a device has been removed
> > > > > but the DRM device is still around.
> > > >=20
> > > > I'm kinda confused. In this case there is no DRM device for the bridge
> > > > and, as per my CL description, "bridge-dev->dev" appears to be the
> > > > encoder device.
> > >
> > > bridge->dev seems right though?
> > >
> > > > I wasn't personally involved in discussions about it, but I was under
> > > > the impression that this was expected / normal. Thus we can't make
> > > > this DRM-managed.
> > >
> > > Still, I don't think devm is the right solution to this either.
> > >
> > > The underlying issue is two-fold:
> > >
> > >   - Encoders can have a pointer to a bridge through of_drm_find_bridge
> > >     or similar. However, bridges are traditionally tied to their device
> > >     lifetime (by calling drm_bridge_add in probe, and drm_bridge_remove
> > >     in remove). Encoders will typically be tied to the DRM device
> > >     however, and that one sticks around until the last application
> > >     closes it. We can thus very easily end up with a dangling pointer,
> > >     and a use-after-free.
> > >
> > >   - It's not the case yet, but it doesn't seem far fetch to expose
> > >     properties of bridges to the userspace. In that case, the userspace
> > >     would be likely to still hold references to objects that aren't
> > >     there anymore when the bridge is gone.
> > >
> > > The first is obviously a larger concern, but if we can find a solution
> > > that would accomodate the second it would be great.
> > >
> > > As far as I can see, we should fix in two steps:
> > >
> > >   - in drm_bridge_attach, we should add a device-managed call that will
> > >     unregister the main DRM device. We don't allow to probe the main DRM
> > >     device when the bridge isn't there yet in most case, so it makes
> > >     sense to remove it once the bridge is no longer there as well.
> >
> > The problem is that I do not see a good way to unregister the main DRM
> > device outside of it's driver code.
>
> That's what drmm helpers are doing though: they'll defer the cleanup
> until the last user has closed its fd.

I'm a bit confused here. I'll take the concrete example of ps8640
since that's what I was working on here.

...right now the fact that we're using devm means that
drm_bridge_remove() will get called when a ps8640 device is unbound,
right? I guess you're saying that the "drm_bridge" memory needs to
outlast this, right? That being said, even if the actual memory for
drm_bridge outlasts the ps8640 driver lifetime, much of the data would
need to be marked invalid I think. If nothing else all function
pointers that point into the driver would have to be made NULL, right?
Once the device has been unbound it's possible that the underlying
module might be removed. I suspect that we'd need to do more than just
bogus-up the function pointers, though.

...so it feels like any solution here needs to take into account
_both_ the lifetime of the "struct device" and the "struct
drm_device". If the "struct device" goes away but the "struct
drm_device" is still around then we need to essentially transition the
"struct drm_device" over to a dummy, right? In my perhaps naive view
that means that a dmm_bridge_add() wouldn't be enough because it
wouldn't know when the "struct device" went away.


> > >   - When the DRM device is removed, have the core cleanup any bridge
> > >     registered. That will remove the need to have drm_bridge_remove in
> > >     the first place.
> > >
> > > > I'll assume that my response addressed your concerns. Assuming I get
> > > > reviews for the other two patches in this series I'll plan to land
> > > > this with Dmitry's review.
> > >
> > > I still don't think it's a good idea to merge it. It gives an illusion
> > > of being safe, but it's really far from it.
> >
> > It is more of removing the boilerplate code spread over all the
> > drivers rather than about particular safety.
> >
> > I'd propose to land devm_drm_bridge_add (and deprecate calling
> > drm_bridge_remove from the bridge driver at some point) and work on
> > the whole drm_device <-> drm_bridge problem in the meantime.
>
> Do you really expect that to happen? :)
>
> Anyway, it's been merged, it's too late now anyway. I don't really feel
> like it's a good thing, but it doesn't really make the situation worse
> either.

A revert is really not that hard to do if the consensus is that we
really don't want this.


-Doug
