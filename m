Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7E53CAEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiFCNw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiFCNwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:52:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D838BEF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:52:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so16085295ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gajDGmkvC2i3Ff4SviEDlcrNM6kzJNoz/iyt65+315Y=;
        b=eDSmHJzELH0S6QTvHboEKyR16A+cBjPfBvAYV78iQgUBNNHcaYPar8UZLVO/HJ0i09
         tW3fiKxZHCPvFZ86iaJyAw4k/YMoAX46+WSt0a3AOzX1T3a5SuX7q1wTGJSjYWuelllw
         eB80uxVO6jKFhXX+6HA5TbaapYdpRcmr+GPt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gajDGmkvC2i3Ff4SviEDlcrNM6kzJNoz/iyt65+315Y=;
        b=zHGtDppJzCZZEQRYHMa/cWzjhB5c2xOOEz80JucZRJwgmcbZQCyJz6hv4n/BI0gOqO
         J4DR1RitwKgQ/u/zdG+bIF2/ZpkhMRnGA5TAHO/98M+9c8uqXCAWeeiox2Za57SFsyFy
         qhbJMAQ24v1lox5kviJ0qboWS51OxOAiPIr4hXifWBINTk4ffNNanNcYRBNcn28xWHed
         qtLXHMrB2zYYiKeVj0MD5h984ezMr75IYuvI+Mxn9/SxCpkzJdI6LAnwapdQxbkHOqBn
         Xduc3XobjXKXt5SqvdV+TvR67yehzyFTTsiVspOdzr1SHWRR9KmxAWw6xcckeOAarscw
         lAXw==
X-Gm-Message-State: AOAM530PajjB5h80U9q15bn9dhFGnvKnqDpsACArgwXvreSdhyEtOlqe
        betxag/83uYuNhJ8ftRuNDQNJuqDNI/gLNGRdzI=
X-Google-Smtp-Source: ABdhPJzZKXPhNEwB5pxFPF3HRGHeuvNPE+kjG7SY9f2+mz0FEK6HvxvmFqC/qU7ARWg21Ytl/2vbOw==
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id e21-20020a170906505500b006ff1dfb1e2cmr8593792ejk.200.1654264341135;
        Fri, 03 Jun 2022 06:52:21 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c7c5000000b0042ad421574esm3970242eds.33.2022.06.03.06.52.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 06:52:19 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id l2-20020a05600c1d0200b0039c35ef94c4so2169995wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:52:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2e53:b0:397:4730:ee7a with SMTP id
 q19-20020a05600c2e5300b003974730ee7amr37492988wmf.118.1654264337977; Fri, 03
 Jun 2022 06:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.3.Iba4b9bf6c7a1ee5ea2835ad7bd5eaf84d7688520@changeid>
 <20220521091751.opeiqbmc5c2okdq6@houat> <CAD=FV=Wea0LT5umK4Xg87cDikim+dSuyLndfydO3_DnTujZr9Q@mail.gmail.com>
 <CAD=FV=XqJuPHxm7HYMvyHBL_zC-BBA_f0MBsZX-jHt7Pk9ngsQ@mail.gmail.com>
 <20220603082139.sfdxb5ndwpvlhklh@penduick> <CAA8EJpqrw63K_xxJjawLjEqP-05eUD-k6dy21162hcq7q07jgQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqrw63K_xxJjawLjEqP-05eUD-k6dy21162hcq7q07jgQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Jun 2022 06:52:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbNe+9Cf-jWwFPAR0a1qqjdKaQdtiREKLB8sHYTh_4OQ@mail.gmail.com>
Message-ID: <CAD=FV=XbNe+9Cf-jWwFPAR0a1qqjdKaQdtiREKLB8sHYTh_4OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: Add devm_drm_bridge_add()
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
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

On Fri, Jun 3, 2022 at 3:19 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 3 Jun 2022 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Tue, May 31, 2022 at 02:06:34PM -0700, Doug Anderson wrote:
> > > On Mon, May 23, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > On Sat, May 21, 2022 at 2:17 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > On Tue, May 10, 2022 at 12:29:43PM -0700, Douglas Anderson wrote:
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
> > > >
> > > > I'm kinda confused. In this case there is no DRM device for the bridge
> > > > and, as per my CL description, "bridge-dev->dev" appears to be the
> > > > encoder device. I wasn't personally involved in discussions about it,
> > > > but I was under the impression that this was expected / normal. Thus
> > > > we can't make this DRM-managed.
> > >
> > > Since I didn't hear a reply,
> >
> > Gah, I replied but it looks like somehow it never reached the ML...
> >
> > Here was my original reply:
> >
> > > > > This adds a devm managed version of drm_bridge_add(). Like other
> > > > > "devm" function listed in drm_bridge.h, this function takes an
> > > > > explicit "dev" to use for the lifetime management. A few notes:
> > > > > * In general we have a "struct device" for bridges that makes a good
> > > > >   candidate for where the lifetime matches exactly what we want.
> > > > > * The "bridge->dev->dev" device appears to be the encoder
> > > > >   device. That's not the right device to use for lifetime management.
> > > > >
> > > > > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > >
> > > > If we are to introduce more managed helpers, I think it'd be wiser to
> > > > introduce them as DRM-managed, and not device managed.
> > > >
> > > > Otherwise, you'll end up in a weird state when a device has been removed
> > > > but the DRM device is still around.
> > >=20
> > > I'm kinda confused. In this case there is no DRM device for the bridge
> > > and, as per my CL description, "bridge-dev->dev" appears to be the
> > > encoder device.
> >
> > bridge->dev seems right though?
> >
> > > I wasn't personally involved in discussions about it, but I was under
> > > the impression that this was expected / normal. Thus we can't make
> > > this DRM-managed.
> >
> > Still, I don't think devm is the right solution to this either.
> >
> > The underlying issue is two-fold:
> >
> >   - Encoders can have a pointer to a bridge through of_drm_find_bridge
> >     or similar. However, bridges are traditionally tied to their device
> >     lifetime (by calling drm_bridge_add in probe, and drm_bridge_remove
> >     in remove). Encoders will typically be tied to the DRM device
> >     however, and that one sticks around until the last application
> >     closes it. We can thus very easily end up with a dangling pointer,
> >     and a use-after-free.
> >
> >   - It's not the case yet, but it doesn't seem far fetch to expose
> >     properties of bridges to the userspace. In that case, the userspace
> >     would be likely to still hold references to objects that aren't
> >     there anymore when the bridge is gone.
> >
> > The first is obviously a larger concern, but if we can find a solution
> > that would accomodate the second it would be great.
> >
> > As far as I can see, we should fix in two steps:
> >
> >   - in drm_bridge_attach, we should add a device-managed call that will
> >     unregister the main DRM device. We don't allow to probe the main DRM
> >     device when the bridge isn't there yet in most case, so it makes
> >     sense to remove it once the bridge is no longer there as well.
>
> The problem is that I do not see a good way to unregister the main DRM
> device outside of it's driver code.
>
> >
> >   - When the DRM device is removed, have the core cleanup any bridge
> >     registered. That will remove the need to have drm_bridge_remove in
> >     the first place.
> >
> > > I'll assume that my response addressed your concerns. Assuming I get
> > > reviews for the other two patches in this series I'll plan to land
> > > this with Dmitry's review.
> >
> > I still don't think it's a good idea to merge it. It gives an illusion
> > of being safe, but it's really far from it.
>
> It is more of removing the boilerplate code spread over all the
> drivers rather than about particular safety.
>
> I'd propose to land devm_drm_bridge_add (and deprecate calling
> drm_bridge_remove from the bridge driver at some point) and work on
> the whole drm_device <-> drm_bridge problem in the meantime.

At this point it has been landed in drm-misc-next as per my response
to the cover letter. If need be we can revert it and rework the ps8640
driver to stop using it but it wouldn't change the lifetime of the
bridge. I'm not going to rework the bridge lifetime rules here. If
nothing else it seems like having the devm function at least would
make it obvious which drivers need to be fixed whenever the bridge
lifetime problem gets solved.

-Doug
