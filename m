Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8D51C44D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380990AbiEEP5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiEEP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:57:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7A5A174
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:53:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so9558810ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I6cIbNa4oEeRqUVz8u+LR58F4AcYghHQTVEKZQzxsck=;
        b=EUxYcDNTrQitjHaZybYi0fMRzXe9xKHA0rm7k76hWX4nWiN/eO2J1ZR99ReQbmOCGw
         yLKz479TudlNK7peFdSLwUKHC5VPXuq5MI07+eqsjqLMxIAcueVnje7gLtu+q+dXRwE7
         VUOYUpLzQ5uNpXLbCxt3PN05w8HacqJ0DqWd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I6cIbNa4oEeRqUVz8u+LR58F4AcYghHQTVEKZQzxsck=;
        b=zaKOkyfq7M0nl2mnqa13qaQq/xVNPC/hwxsdfX3eYEZQLCdhgS1JoHiVB36butk6Wt
         OZnGx41g0a1U0pQiKHVom4pE24DYSP1akD2+cy8blSASIDzQ0c3S7zpb0fMdzg18tcGL
         j60K0cxXw+EmrQjwFXJz2ZOVyX2gjc/J6tamS5HAH3dPJhuFm1W9mrTYPXfJXFseAPvQ
         Id5XFeI3jsUM6Xc3THVGq/jbQAdZgCPljwiZ2ICNWR8VL+Q28YdOA97OjCh3hmXxflha
         2dCXzcPWq9E+8e2z0Di6h4w78SaUoBWNpktL61NYqCSNQnrx7MpHaOPHC4COT0nVndBg
         nIaQ==
X-Gm-Message-State: AOAM532ITuLepIjJ4ESWj60xf8LhvMRzyGeMA64ADdXN+niSPc0BbPcK
        mNIy410ZmAZ6ffliOd+mNUVuKbzidZKEz7PnTNY=
X-Google-Smtp-Source: ABdhPJyUaRqscCmEN1q168Bokt4EHi+3ygbQuEJDiXWySS0Y5E3e4T9Mrm5jlbNL26Dp8T4S4Dh2/Q==
X-Received: by 2002:a17:907:6e1c:b0:6f4:487c:5ec3 with SMTP id sd28-20020a1709076e1c00b006f4487c5ec3mr19753899ejc.210.1651766007635;
        Thu, 05 May 2022 08:53:27 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id j37-20020a05640223a500b0042617ba638bsm977371eda.21.2022.05.05.08.53.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 08:53:26 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id q20so2921785wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:53:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr5753125wmq.34.1651766004951; Thu, 05 May
 2022 08:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
 <YnJv3B/85hTz54SC@intel.com> <CAD=FV=WndmKuEB0=OVQP9YuJaSmD0uxkNs5LE0wWsFj7gBvhBA@mail.gmail.com>
 <1c6c9fde6e85f09cc89ea8dc6e8716fef58f3ee1.camel@redhat.com>
 <YnPjO4kbjezQl5Da@intel.com> <CAD=FV=XbZEagm5qR207mcVm1Ry=bGeuRAqTYx3SBoZfyo6fSkg@mail.gmail.com>
 <YnPoYsnx7IeBfJ5D@intel.com>
In-Reply-To: <YnPoYsnx7IeBfJ5D@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 08:53:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxxEGM4cLBHGMeRBFDAXGJJF105kLZ588JSFJRg8PM8A@mail.gmail.com>
Message-ID: <CAD=FV=WxxEGM4cLBHGMeRBFDAXGJJF105kLZ588JSFJRg8PM8A@mail.gmail.com>
Subject: Re: [PATCH] drm: Document that power requirements for DP AUX transfers
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Lyude Paul <lyude@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 5, 2022 at 8:29 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, May 05, 2022 at 08:00:20AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, May 5, 2022 at 7:46 AM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Wed, May 04, 2022 at 02:10:08PM -0400, Lyude Paul wrote:
> > > > On Wed, 2022-05-04 at 09:04 -0700, Doug Anderson wrote:
> > > > > Hi,
> > > > >
> > > > > On Wed, May 4, 2022 at 5:21 AM Ville Syrj=C3=A4l=C3=A4
> > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > >
> > > > > > On Tue, May 03, 2022 at 04:21:08PM -0700, Douglas Anderson wrot=
e:
> > > > > > > When doing DP AUX transfers there are two actors that need to=
 be
> > > > > > > powered in order for the DP AUX transfer to work: the DP sour=
ce and
> > > > > > > the DP sync. Commit bacbab58f09d ("drm: Mention the power sta=
te
> > > > > > > requirement on side-channel operations") added some documenta=
tion
> > > > > > > saying that the DP source is required to power itself up (if =
needed)
> > > > > > > to do AUX transfers. However, that commit doesn't talk anythi=
ng about
> > > > > > > the DP sink.
> > > > > > >
> > > > > > > For full fledged DP the sink isn't really a problem. It's exp=
ected
> > > > > > > that if an external DP monitor isn't plugged in that attempti=
ng to do
> > > > > > > AUX transfers won't work. It's also expected that if a DP mon=
itor is
> > > > > > > plugged in (and thus asserting HPD) that it AUX transfers wil=
l work.
> > > > > > >
> > > > > > > When we're looking at eDP, however, things are less obvious. =
Let's add
> > > > > > > some documentation about expectations. Here's what we'll say:
> > > > > > >
> > > > > > > 1. We don't expect the DP AUX transfer function to power on a=
n eDP
> > > > > > > panel. If an eDP panel is physically connected but powered of=
f then it
> > > > > > > makes sense for the transfer to fail.
> > > > > >
> > > > > > I don't agree with this. I think the panel should just get powr=
ed up
> > > > > > for AUX transfers.
> > > > >
> > > > > That's definitely a fair thing to think about and I have at times
> > > > > thought about trying to make it work that way. It always ends up
> > > > > hitting a roadblock.
> > >
> > > How do you even probe the panel initially if you can't power it on
> > > without doing some kind of full modeset/etc.?
> >
> > It's not that we can't power it on without a full modeset. It' that at
> > panel probe time all the DRM components haven't been hooked together
> > yet, so the bridge chain isn't available yet. The panel can power
> > itself on, though. This is why the documentation I added says: "if a
> > panel driver is initiating a DP AUX transfer it may power itself up
> > however it wants"
> >
> >
> > > > > The biggest roadblock that I recall is that to make this work the=
n
> > > > > you'd have to somehow ensure that the bridge chain's pre_enable()=
 call
> > > > > was made as part of the AUX transfer, right? Since the transfer
> > > > > function can be called in any context at all, we have to coordina=
te
> > > > > this with DRM. If, for instance, DRM is mid way through powering =
the
> > > > > panel down then we need to wait for DRM to fully finish powering =
down,
> > > > > then we need to power the panel back up. I don't believe that we =
can
> > > > > just force the panel to stay on if DRM is turning it off because =
of
> > > > > panel power sequencing requirements. At least I know it would hav=
e the
> > > > > potential to break "samsung-atna33xc20.c" which absolutely needs =
to
> > > > > see the panel power off after it's been disabled.
> > > > >
> > > > > We also, I believe, need to handle the fact that the bridge chain=
 may
> > > > > not have even been created yet. We do AUX transfers to read the E=
DID
> > > > > and also to setup the backlight in the probe function of panel-ed=
p. At
> > > > > that point the panel hasn't been linked into the chain. We had _l=
ong_
> > > > > discussions [1] about moving these out of probe and decided that =
we
> > > > > could move the EDID read to be later but that it was going to rea=
lly
> > > > > ugly to move the AUX backlight later. The backlight would end up
> > > > > popping up at some point in time later (the first call to panel
> > > > > prepare() or maybe get_modes()) and that seemed weird.
> > > > >
> > > > > [1]
> > > > > https://lore.kernel.org/lkml/CAD=3DFV=3DU5-sTDLYdkeJWLAOG-0wgxR49=
VxtwUyUO7z2PuibLGsg@mail.gmail.com/
> > > > >
> > > > >
> > > > > > Otherwise you can't trust that eg. the /dev/aux
> > > > > > stuff is actually usable.
> > > > >
> > > > > Yeah, it's been on my mind to talk more about /dev/aux. I think
> > > > > /dev/aux has some problems, at least with eDP. Specifically:
> > > > >
> > > > > 1. Even if we somehow figure out how to power the panel on as par=
t of
> > > > > the aux transfer, we actually _still_ not guaranteed to be able t=
o
> > > > > talk to it as far as I understand. My colleague reported to me th=
at on
> > > > > a system he was working with that had PSR (panel self refresh) th=
at
> > > > > when the panel was powered on but in PSR mode that it wouldn't ta=
lk
> > > > > over AUX. Assuming that this is correct then I guess we'd also ha=
ve to
> > > > > do even more coordination with DRM to exit PSR and block future
> > > > > transitions of PSR. (NOTE: it's always possible that my colleague=
 ran
> > > > > into some other bug and that panels are _supposed_ to be able to =
talk
> > > > > in PSR. If you think this is the case, I can always try to dig mo=
re).
> > > >
> > > > TBH - the coordination with drm I don't think would be the difficul=
t part, as
> > > > we'd just need to add some sort of property (ideally invisible to u=
serspace)
> > > > that can be used in an atomic commit to disable PSR - similar to ho=
w we enable
> > > > CRC readback from sysfs in the majority of DRM drivers. That being =
said
> > > > though, I think we can just leave the work of solving this problem =
up to
> > > > whoever ends up needing this to work.
> > >
> > > The driver should just disable/prevent PSR when doing AUX if the hard=
ware
> > > can't guarantee the PSR and AUX won't interfere with each other.
> >
> > OK, fair enough. If we can solve the PSR problem that would be great.
> >
> >
> > > For i915 we have no problems with powering the panel on for AUX, but
> > > there is still a race with PSR vs. AUX because both use the same hard=
ware
> > > internally. I've been nagging at people to fix this for i915 but I do=
n't
> > > think it still got done :( Originally we were supposed to get a hardw=
are
> > > mutex for this but that plan got scrapped for some reason.
> >
> > I haven't looked at the i915 DRM code much, but my understanding is
> > that it's more of an "all in one" approach. The one driver pretty much
> > handles everything itself. That means that powering the panel up isn't
> > too hard. Is that right?
>
> Yeah, we don't have too many "helpful" abstractions in the way ;)
>
> > > > > for userspace to be mucking with /dev/aux. For DP's case I guess
> > > > > /dev/aux is essentially enabling userspace drivers to do things l=
ike
> > > > > update firmware on DP monitors or play with the backlight. I gues=
s we
> > > > > decided that we didn't want to add drivers in the kernel to handl=
e
> > > > > this type of stuff so we left it for userspace? For eDP, though, =
there
> > > >
> > > > The main reason DP AUX got exposed to userspace in the first place =
was for
> > > > usecases like fwupd,
> > >
> > > My memory says the original reason was debugging. Or at least I had
> > > no idea fwupd had started to use this until I saw some weird looking
> > > DPCD addresses in some debug log.
> > >
> > > But I suppose it's possible there were already plans for firmware
> > > updates and whatnot and it just wasn't being discussed when this was
> > > being developed.
> >
> > If it's just for debugging, I'd argue that leaving it as-is should be
> > fine. Someone poking around with their system can find a way to make
> > sure that the panel stays on.
>
> That could require altering the state of the system quite a bit, which
> may defeat the purpose.

It does? In my experience you just need to make sure that the panel is
turned on. ...or are you saying that you'd use this for debugging a
case where the system isn't probing properly?

If things are truly in bad shape, at least on boards using device tree
it's easy to tweak the device tree to force a regulator to stay on. I
suppose we could also add a "debugfs" entry for the panel that also
forces it to be powered on.


>  At least I would not be willing to accept such
> a limitation.

Hmm, so where does that leave us? Are you against landing this patch?
I've done a lot of cleanups recently and I just don't think I have the
time to rework all the AUX transfer functions and figure out how to
power the panel. It also seems like a lot of added complexity for a
debug path.


> > This is similar to how if you're poking
> > around with /dev/i2c it's up to you to make sure that the i2c device
> > you're poking at stays powered.
> >
> > -Doug
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
