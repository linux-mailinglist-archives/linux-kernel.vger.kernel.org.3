Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD551CA55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379928AbiEEUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385744AbiEEUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:15:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A335DC3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:12:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g6so10782808ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=me+tE+ajjXN7jKbMirABF1E0yU3Dmdz3jkwMg93JY5w=;
        b=CdRfmxK1OW3E36weXRO9akHkwOL8rwiAiv5Ei4yfNzWfc+CHohZkQ6asloIRwQle8g
         X8kP0uT8UV4kN1yD0SiBJvOOD0QQ8exTJhD/5r7ApZQ7uLTub7UjROd11VxxnrLvJXRB
         d6BjfE8PlBOxb8/40sf2EdB9xnoZtZsx1JLm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=me+tE+ajjXN7jKbMirABF1E0yU3Dmdz3jkwMg93JY5w=;
        b=65AI0uyXKsk6ibgRcKe2zifG00cg6tu8Cu0ehxbltFCvIJ33WObh8z0Q+EP2RtNnv/
         MrelVsTh8P111W0Jcf4ZZa2+NcmRws2ZSeLGt4+G/DkOkQYcK4lNfNMrTSsnLCWNMK3Q
         GdMsAhIgCenE5N4g6LmpWLGQtYXW0t8xy0u4Kf5aDRyLq3C5Y2y5pvwEowP8L13EyaQK
         T4Qf8C4q/TmxOhh48gOSTR055YPnosTOJWJ9mb37w4VbsOA8+ZWqzmy5QhTMTt3fgEHt
         WcEAhLOaNvUSSMVWXOIgveVZf4U8QdStiDZcArd/dWAO2jFHxl5s6h4jfXigm/MgxfM3
         h0gw==
X-Gm-Message-State: AOAM531mPeuXdAdO/DpS5GIig7gg18f4nqTf9mCUaQFRAE4i8ubliFmV
        lTluLEl0TYnxWJydYL6ep7Hwmm9VjJd/+dE87Oo=
X-Google-Smtp-Source: ABdhPJwO8FSmlruTntWgcTsKoV6qW3PnCqgEqEycLgUmW03hJd9WEO1EiEO3u7tbnytiMPpgjKUJBA==
X-Received: by 2002:a17:907:1623:b0:6e8:8678:640d with SMTP id hb35-20020a170907162300b006e88678640dmr27950103ejc.189.1651781535357;
        Thu, 05 May 2022 13:12:15 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id jl8-20020a17090775c800b006f3ef214e2dsm1061430ejc.147.2022.05.05.13.12.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 13:12:15 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so3270836wmz.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:12:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id
 bi12-20020a05600c3d8c00b0039460979994mr6427017wmb.29.1651781533945; Thu, 05
 May 2022 13:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
 <YnJv3B/85hTz54SC@intel.com> <CAD=FV=WndmKuEB0=OVQP9YuJaSmD0uxkNs5LE0wWsFj7gBvhBA@mail.gmail.com>
 <1c6c9fde6e85f09cc89ea8dc6e8716fef58f3ee1.camel@redhat.com>
 <YnPjO4kbjezQl5Da@intel.com> <CAD=FV=XbZEagm5qR207mcVm1Ry=bGeuRAqTYx3SBoZfyo6fSkg@mail.gmail.com>
 <YnPoYsnx7IeBfJ5D@intel.com> <CAD=FV=WxxEGM4cLBHGMeRBFDAXGJJF105kLZ588JSFJRg8PM8A@mail.gmail.com>
 <YnQjOuSh3TV+Zbgk@intel.com>
In-Reply-To: <YnQjOuSh3TV+Zbgk@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 13:12:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UcR7kODhRpf3iXrRa15WTV3tkOhipiLMto19ZUj424-A@mail.gmail.com>
Message-ID: <CAD=FV=UcR7kODhRpf3iXrRa15WTV3tkOhipiLMto19ZUj424-A@mail.gmail.com>
Subject: Re: [PATCH] drm: Document that power requirements for DP AUX transfers
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 5, 2022 at 12:19 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, May 05, 2022 at 08:53:12AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, May 5, 2022 at 8:29 AM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Thu, May 05, 2022 at 08:00:20AM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Thu, May 5, 2022 at 7:46 AM Ville Syrj=C3=A4l=C3=A4
> > > > <ville.syrjala@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, May 04, 2022 at 02:10:08PM -0400, Lyude Paul wrote:
> > > > > > On Wed, 2022-05-04 at 09:04 -0700, Doug Anderson wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Wed, May 4, 2022 at 5:21 AM Ville Syrj=C3=A4l=C3=A4
> > > > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 03, 2022 at 04:21:08PM -0700, Douglas Anderson =
wrote:
> > > > > > > > > When doing DP AUX transfers there are two actors that nee=
d to be
> > > > > > > > > powered in order for the DP AUX transfer to work: the DP =
source and
> > > > > > > > > the DP sync. Commit bacbab58f09d ("drm: Mention the power=
 state
> > > > > > > > > requirement on side-channel operations") added some docum=
entation
> > > > > > > > > saying that the DP source is required to power itself up =
(if needed)
> > > > > > > > > to do AUX transfers. However, that commit doesn't talk an=
ything about
> > > > > > > > > the DP sink.
> > > > > > > > >
> > > > > > > > > For full fledged DP the sink isn't really a problem. It's=
 expected
> > > > > > > > > that if an external DP monitor isn't plugged in that atte=
mpting to do
> > > > > > > > > AUX transfers won't work. It's also expected that if a DP=
 monitor is
> > > > > > > > > plugged in (and thus asserting HPD) that it AUX transfers=
 will work.
> > > > > > > > >
> > > > > > > > > When we're looking at eDP, however, things are less obvio=
us. Let's add
> > > > > > > > > some documentation about expectations. Here's what we'll =
say:
> > > > > > > > >
> > > > > > > > > 1. We don't expect the DP AUX transfer function to power =
on an eDP
> > > > > > > > > panel. If an eDP panel is physically connected but powere=
d off then it
> > > > > > > > > makes sense for the transfer to fail.
> > > > > > > >
> > > > > > > > I don't agree with this. I think the panel should just get =
powred up
> > > > > > > > for AUX transfers.
> > > > > > >
> > > > > > > That's definitely a fair thing to think about and I have at t=
imes
> > > > > > > thought about trying to make it work that way. It always ends=
 up
> > > > > > > hitting a roadblock.
> > > > >
> > > > > How do you even probe the panel initially if you can't power it o=
n
> > > > > without doing some kind of full modeset/etc.?
> > > >
> > > > It's not that we can't power it on without a full modeset. It' that=
 at
> > > > panel probe time all the DRM components haven't been hooked togethe=
r
> > > > yet, so the bridge chain isn't available yet. The panel can power
> > > > itself on, though. This is why the documentation I added says: "if =
a
> > > > panel driver is initiating a DP AUX transfer it may power itself up
> > > > however it wants"
> > > >
> > > >
> > > > > > > The biggest roadblock that I recall is that to make this work=
 then
> > > > > > > you'd have to somehow ensure that the bridge chain's pre_enab=
le() call
> > > > > > > was made as part of the AUX transfer, right? Since the transf=
er
> > > > > > > function can be called in any context at all, we have to coor=
dinate
> > > > > > > this with DRM. If, for instance, DRM is mid way through power=
ing the
> > > > > > > panel down then we need to wait for DRM to fully finish power=
ing down,
> > > > > > > then we need to power the panel back up. I don't believe that=
 we can
> > > > > > > just force the panel to stay on if DRM is turning it off beca=
use of
> > > > > > > panel power sequencing requirements. At least I know it would=
 have the
> > > > > > > potential to break "samsung-atna33xc20.c" which absolutely ne=
eds to
> > > > > > > see the panel power off after it's been disabled.
> > > > > > >
> > > > > > > We also, I believe, need to handle the fact that the bridge c=
hain may
> > > > > > > not have even been created yet. We do AUX transfers to read t=
he EDID
> > > > > > > and also to setup the backlight in the probe function of pane=
l-edp. At
> > > > > > > that point the panel hasn't been linked into the chain. We ha=
d _long_
> > > > > > > discussions [1] about moving these out of probe and decided t=
hat we
> > > > > > > could move the EDID read to be later but that it was going to=
 really
> > > > > > > ugly to move the AUX backlight later. The backlight would end=
 up
> > > > > > > popping up at some point in time later (the first call to pan=
el
> > > > > > > prepare() or maybe get_modes()) and that seemed weird.
> > > > > > >
> > > > > > > [1]
> > > > > > > https://lore.kernel.org/lkml/CAD=3DFV=3DU5-sTDLYdkeJWLAOG-0wg=
xR49VxtwUyUO7z2PuibLGsg@mail.gmail.com/
> > > > > > >
> > > > > > >
> > > > > > > > Otherwise you can't trust that eg. the /dev/aux
> > > > > > > > stuff is actually usable.
> > > > > > >
> > > > > > > Yeah, it's been on my mind to talk more about /dev/aux. I thi=
nk
> > > > > > > /dev/aux has some problems, at least with eDP. Specifically:
> > > > > > >
> > > > > > > 1. Even if we somehow figure out how to power the panel on as=
 part of
> > > > > > > the aux transfer, we actually _still_ not guaranteed to be ab=
le to
> > > > > > > talk to it as far as I understand. My colleague reported to m=
e that on
> > > > > > > a system he was working with that had PSR (panel self refresh=
) that
> > > > > > > when the panel was powered on but in PSR mode that it wouldn'=
t talk
> > > > > > > over AUX. Assuming that this is correct then I guess we'd als=
o have to
> > > > > > > do even more coordination with DRM to exit PSR and block futu=
re
> > > > > > > transitions of PSR. (NOTE: it's always possible that my colle=
ague ran
> > > > > > > into some other bug and that panels are _supposed_ to be able=
 to talk
> > > > > > > in PSR. If you think this is the case, I can always try to di=
g more).
> > > > > >
> > > > > > TBH - the coordination with drm I don't think would be the diff=
icult part, as
> > > > > > we'd just need to add some sort of property (ideally invisible =
to userspace)
> > > > > > that can be used in an atomic commit to disable PSR - similar t=
o how we enable
> > > > > > CRC readback from sysfs in the majority of DRM drivers. That be=
ing said
> > > > > > though, I think we can just leave the work of solving this prob=
lem up to
> > > > > > whoever ends up needing this to work.
> > > > >
> > > > > The driver should just disable/prevent PSR when doing AUX if the =
hardware
> > > > > can't guarantee the PSR and AUX won't interfere with each other.
> > > >
> > > > OK, fair enough. If we can solve the PSR problem that would be grea=
t.
> > > >
> > > >
> > > > > For i915 we have no problems with powering the panel on for AUX, =
but
> > > > > there is still a race with PSR vs. AUX because both use the same =
hardware
> > > > > internally. I've been nagging at people to fix this for i915 but =
I don't
> > > > > think it still got done :( Originally we were supposed to get a h=
ardware
> > > > > mutex for this but that plan got scrapped for some reason.
> > > >
> > > > I haven't looked at the i915 DRM code much, but my understanding is
> > > > that it's more of an "all in one" approach. The one driver pretty m=
uch
> > > > handles everything itself. That means that powering the panel up is=
n't
> > > > too hard. Is that right?
> > >
> > > Yeah, we don't have too many "helpful" abstractions in the way ;)
> > >
> > > > > > > for userspace to be mucking with /dev/aux. For DP's case I gu=
ess
> > > > > > > /dev/aux is essentially enabling userspace drivers to do thin=
gs like
> > > > > > > update firmware on DP monitors or play with the backlight. I =
guess we
> > > > > > > decided that we didn't want to add drivers in the kernel to h=
andle
> > > > > > > this type of stuff so we left it for userspace? For eDP, thou=
gh, there
> > > > > >
> > > > > > The main reason DP AUX got exposed to userspace in the first pl=
ace was for
> > > > > > usecases like fwupd,
> > > > >
> > > > > My memory says the original reason was debugging. Or at least I h=
ad
> > > > > no idea fwupd had started to use this until I saw some weird look=
ing
> > > > > DPCD addresses in some debug log.
> > > > >
> > > > > But I suppose it's possible there were already plans for firmware
> > > > > updates and whatnot and it just wasn't being discussed when this =
was
> > > > > being developed.
> > > >
> > > > If it's just for debugging, I'd argue that leaving it as-is should =
be
> > > > fine. Someone poking around with their system can find a way to mak=
e
> > > > sure that the panel stays on.
> > >
> > > That could require altering the state of the system quite a bit, whic=
h
> > > may defeat the purpose.
> >
> > It does? In my experience you just need to make sure that the panel is
> > turned on. ...or are you saying that you'd use this for debugging a
> > case where the system isn't probing properly?
>
> I don't want to have to eg. try to set a mode on the panel to get it
> to reply to AUX/DDC. I want to be able to talk to it in any situation.
> I don't need to jump through any extra hoops to talk to external DP
> panels, and don't really see why eDP should be any different.
>
> > If things are truly in bad shape, at least on boards using device tree
> > it's easy to tweak the device tree to force a regulator to stay on. I
> > suppose we could also add a "debugfs" entry for the panel that also
> > forces it to be powered on.
>
> Not really sure how adding a separate knob for it would be
> somehow easier than just turning on the power from the
> aux transfer hook.
>
> > >  At least I would not be willing to accept such
> > > a limitation.
> >
> > Hmm, so where does that leave us? Are you against landing this patch?
> > I've done a lot of cleanups recently and I just don't think I have the
> > time to rework all the AUX transfer functions and figure out how to
> > power the panel. It also seems like a lot of added complexity for a
> > debug path.
>
> If people don't feel like fixing this then I have no real
> objection to documenting the fact that *some* drivers can't
> power the panel on for AUX transfers for whatever random
> reason. But I disagree with claims that it is the only
> expected/desired behaviour.

OK. I'll spin the wording like this:

* - If the @dev providing the AUX bus is currently unpowered then
*   it will power itself up for the transfer.
* - If we're on eDP (using a drm_panel) and the panel is not in a
*   state where it can respond (it's not powered or it's in a
*   low power state) then this function may return an error, but
*   not crash. It's up to the caller of this code to make sure that
*   the panel is powered on if getting an error back is not OK. If a
*   drm_panel driver is initiating a DP AUX transfer it may power
*   itself up however it wants. All other code should ensure that
*   the pre_enable() bridge chain (which eventually calls the
*   drm_panel prepare function) has powered the panel.

I'll keep Lyude and Dmitry's R-b tags. I'll plan to spin with that in
a few days if I don't hear anything else.

-Doug
