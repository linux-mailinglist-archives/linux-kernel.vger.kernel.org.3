Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F451CAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385800AbiEEV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245352AbiEEV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:28:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D04532DD
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:24:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so11058751ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UoWwNXyAcsb+nskmf/A6YNX12MmyJFejUDpF9wkByVk=;
        b=KC+zMxymUEgwVGln9aogKSC0k9P6L6P5SI8acWLWDyutliIZLJesRPDW/I/2z0zfEa
         Gyhb5aOoC6Hlkjwt47NL+IcgnBVcp8CMZtJbFJsyCveShhBneBwiMw1yfLVNq1eOB+Os
         grdDWJQh+Z5AD7qWxmcBIupPAKJVrZGl50EDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UoWwNXyAcsb+nskmf/A6YNX12MmyJFejUDpF9wkByVk=;
        b=1CU5FLBuW8C0Jcm7lTu0/KTsaNL+6S/LmcnBCBTYAHIzVtMpS94+W/bmWFM3MCqS3O
         zi34eXmd0cLiLJqNPrFr2xb4TjBmQVgQKdQz0hVl22/BF43KRaLg0LxLZXC2RQFyLFJF
         hRCuaMlWw9sL5DaM6DY3QdMZ1AvxXgGxRLM2LlAz7vIY2HvT1JGWRbWqxfvOqXqySfil
         m9surRPhP7cQyWdyDYKmP7LrET/E7RhaSKBk/qnqDvkQDGL50n80CQHFrni7VZ6al0mZ
         3i37xiTQRhDISzaoZHHc/jgZKOOhwZcGE4SnkKSN4PWQ837YY1n+8Hqlhq8T5sXSq5+P
         J+6Q==
X-Gm-Message-State: AOAM532KfT2Q/ZB78BrPm9L1Y8/MPiIb11PQyHPwD+Py3s9E6fpOZj2v
        W0iri0ljFbfu+YGoio8nuy9eIYSdQtOtnBmnizQ=
X-Google-Smtp-Source: ABdhPJxvC3UWEodGXIRSEjXv+YBIcTpfHwELjRdSKxjHcNOlxd9anQk74sSmbvF6SWmI9rflgwCRyw==
X-Received: by 2002:a17:906:c284:b0:6f4:dcc3:7939 with SMTP id r4-20020a170906c28400b006f4dcc37939mr138497ejz.444.1651785885689;
        Thu, 05 May 2022 14:24:45 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7ca0b000000b00427ae00972dsm1314803eds.12.2022.05.05.14.24.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 14:24:44 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u3so7672498wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:24:44 -0700 (PDT)
X-Received: by 2002:adf:f50d:0:b0:20a:e096:ef with SMTP id q13-20020adff50d000000b0020ae09600efmr43895wro.679.1651785884165;
 Thu, 05 May 2022 14:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
 <YnJv3B/85hTz54SC@intel.com> <CAD=FV=WndmKuEB0=OVQP9YuJaSmD0uxkNs5LE0wWsFj7gBvhBA@mail.gmail.com>
 <1c6c9fde6e85f09cc89ea8dc6e8716fef58f3ee1.camel@redhat.com>
 <YnPjO4kbjezQl5Da@intel.com> <CAD=FV=XbZEagm5qR207mcVm1Ry=bGeuRAqTYx3SBoZfyo6fSkg@mail.gmail.com>
 <YnPoYsnx7IeBfJ5D@intel.com> <CAD=FV=WxxEGM4cLBHGMeRBFDAXGJJF105kLZ588JSFJRg8PM8A@mail.gmail.com>
 <CAA8EJppSof0wZ9nph8v_2pgRZj2BJiZ1hTBfLgQ+CFsT+h_dyQ@mail.gmail.com>
 <CAD=FV=WuAV-mrm0Bokqyyn7UgP5-jyNdhh8e4rqJibJ0Kutp_Q@mail.gmail.com> <CAA8EJpq=u0FF7wJ0hJv=Q-NhpUU_pnQxy5PX06DZUq5v5evydg@mail.gmail.com>
In-Reply-To: <CAA8EJpq=u0FF7wJ0hJv=Q-NhpUU_pnQxy5PX06DZUq5v5evydg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 May 2022 14:24:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXLB90KOMvnWTTPyNNcCCVo+gja+2_iSGPnfu77wzknA@mail.gmail.com>
Message-ID: <CAD=FV=XXLB90KOMvnWTTPyNNcCCVo+gja+2_iSGPnfu77wzknA@mail.gmail.com>
Subject: Re: [PATCH] drm: Document that power requirements for DP AUX transfers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
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

On Thu, May 5, 2022 at 1:56 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 5 May 2022 at 23:21, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, May 5, 2022 at 1:10 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, 5 May 2022 at 18:53, Doug Anderson <dianders@chromium.org> wr=
ote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, May 5, 2022 at 8:29 AM Ville Syrj=C3=A4l=C3=A4
> > > > <ville.syrjala@linux.intel.com> wrote:
> > > > >
> > > > > On Thu, May 05, 2022 at 08:00:20AM -0700, Doug Anderson wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, May 5, 2022 at 7:46 AM Ville Syrj=C3=A4l=C3=A4
> > > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 04, 2022 at 02:10:08PM -0400, Lyude Paul wrote:
> > > > > > > > On Wed, 2022-05-04 at 09:04 -0700, Doug Anderson wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Wed, May 4, 2022 at 5:21 AM Ville Syrj=C3=A4l=C3=A4
> > > > > > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, May 03, 2022 at 04:21:08PM -0700, Douglas Ander=
son wrote:
> > > > > > > > > > > When doing DP AUX transfers there are two actors that=
 need to be
> > > > > > > > > > > powered in order for the DP AUX transfer to work: the=
 DP source and
> > > > > > > > > > > the DP sync. Commit bacbab58f09d ("drm: Mention the p=
ower state
> > > > > > > > > > > requirement on side-channel operations") added some d=
ocumentation
> > > > > > > > > > > saying that the DP source is required to power itself=
 up (if needed)
> > > > > > > > > > > to do AUX transfers. However, that commit doesn't tal=
k anything about
> > > > > > > > > > > the DP sink.
> > > > > > > > > > >
> > > > > > > > > > > For full fledged DP the sink isn't really a problem. =
It's expected
> > > > > > > > > > > that if an external DP monitor isn't plugged in that =
attempting to do
> > > > > > > > > > > AUX transfers won't work. It's also expected that if =
a DP monitor is
> > > > > > > > > > > plugged in (and thus asserting HPD) that it AUX trans=
fers will work.
> > > > > > > > > > >
> > > > > > > > > > > When we're looking at eDP, however, things are less o=
bvious. Let's add
> > > > > > > > > > > some documentation about expectations. Here's what we=
'll say:
> > > > > > > > > > >
> > > > > > > > > > > 1. We don't expect the DP AUX transfer function to po=
wer on an eDP
> > > > > > > > > > > panel. If an eDP panel is physically connected but po=
wered off then it
> > > > > > > > > > > makes sense for the transfer to fail.
> > > > > > > > > >
> > > > > > > > > > I don't agree with this. I think the panel should just =
get powred up
> > > > > > > > > > for AUX transfers.
> > > > > > > > >
> > > > > > > > > That's definitely a fair thing to think about and I have =
at times
> > > > > > > > > thought about trying to make it work that way. It always =
ends up
> > > > > > > > > hitting a roadblock.
> > > > > > >
> > > > > > > How do you even probe the panel initially if you can't power =
it on
> > > > > > > without doing some kind of full modeset/etc.?
> > > > > >
> > > > > > It's not that we can't power it on without a full modeset. It' =
that at
> > > > > > panel probe time all the DRM components haven't been hooked tog=
ether
> > > > > > yet, so the bridge chain isn't available yet. The panel can pow=
er
> > > > > > itself on, though. This is why the documentation I added says: =
"if a
> > > > > > panel driver is initiating a DP AUX transfer it may power itsel=
f up
> > > > > > however it wants"
> > > > > >
> > > > > >
> > > > > > > > > The biggest roadblock that I recall is that to make this =
work then
> > > > > > > > > you'd have to somehow ensure that the bridge chain's pre_=
enable() call
> > > > > > > > > was made as part of the AUX transfer, right? Since the tr=
ansfer
> > > > > > > > > function can be called in any context at all, we have to =
coordinate
> > > > > > > > > this with DRM. If, for instance, DRM is mid way through p=
owering the
> > > > > > > > > panel down then we need to wait for DRM to fully finish p=
owering down,
> > > > > > > > > then we need to power the panel back up. I don't believe =
that we can
> > > > > > > > > just force the panel to stay on if DRM is turning it off =
because of
> > > > > > > > > panel power sequencing requirements. At least I know it w=
ould have the
> > > > > > > > > potential to break "samsung-atna33xc20.c" which absolutel=
y needs to
> > > > > > > > > see the panel power off after it's been disabled.
> > > > > > > > >
> > > > > > > > > We also, I believe, need to handle the fact that the brid=
ge chain may
> > > > > > > > > not have even been created yet. We do AUX transfers to re=
ad the EDID
> > > > > > > > > and also to setup the backlight in the probe function of =
panel-edp. At
> > > > > > > > > that point the panel hasn't been linked into the chain. W=
e had _long_
> > > > > > > > > discussions [1] about moving these out of probe and decid=
ed that we
> > > > > > > > > could move the EDID read to be later but that it was goin=
g to really
> > > > > > > > > ugly to move the AUX backlight later. The backlight would=
 end up
> > > > > > > > > popping up at some point in time later (the first call to=
 panel
> > > > > > > > > prepare() or maybe get_modes()) and that seemed weird.
> > > > > > > > >
> > > > > > > > > [1]
> > > > > > > > > https://lore.kernel.org/lkml/CAD=3DFV=3DU5-sTDLYdkeJWLAOG=
-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com/
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Otherwise you can't trust that eg. the /dev/aux
> > > > > > > > > > stuff is actually usable.
> > > > > > > > >
> > > > > > > > > Yeah, it's been on my mind to talk more about /dev/aux. I=
 think
> > > > > > > > > /dev/aux has some problems, at least with eDP. Specifical=
ly:
> > > > > > > > >
> > > > > > > > > 1. Even if we somehow figure out how to power the panel o=
n as part of
> > > > > > > > > the aux transfer, we actually _still_ not guaranteed to b=
e able to
> > > > > > > > > talk to it as far as I understand. My colleague reported =
to me that on
> > > > > > > > > a system he was working with that had PSR (panel self ref=
resh) that
> > > > > > > > > when the panel was powered on but in PSR mode that it wou=
ldn't talk
> > > > > > > > > over AUX. Assuming that this is correct then I guess we'd=
 also have to
> > > > > > > > > do even more coordination with DRM to exit PSR and block =
future
> > > > > > > > > transitions of PSR. (NOTE: it's always possible that my c=
olleague ran
> > > > > > > > > into some other bug and that panels are _supposed_ to be =
able to talk
> > > > > > > > > in PSR. If you think this is the case, I can always try t=
o dig more).
> > > > > > > >
> > > > > > > > TBH - the coordination with drm I don't think would be the =
difficult part, as
> > > > > > > > we'd just need to add some sort of property (ideally invisi=
ble to userspace)
> > > > > > > > that can be used in an atomic commit to disable PSR - simil=
ar to how we enable
> > > > > > > > CRC readback from sysfs in the majority of DRM drivers. Tha=
t being said
> > > > > > > > though, I think we can just leave the work of solving this =
problem up to
> > > > > > > > whoever ends up needing this to work.
> > > > > > >
> > > > > > > The driver should just disable/prevent PSR when doing AUX if =
the hardware
> > > > > > > can't guarantee the PSR and AUX won't interfere with each oth=
er.
> > > > > >
> > > > > > OK, fair enough. If we can solve the PSR problem that would be =
great.
> > > > > >
> > > > > >
> > > > > > > For i915 we have no problems with powering the panel on for A=
UX, but
> > > > > > > there is still a race with PSR vs. AUX because both use the s=
ame hardware
> > > > > > > internally. I've been nagging at people to fix this for i915 =
but I don't
> > > > > > > think it still got done :( Originally we were supposed to get=
 a hardware
> > > > > > > mutex for this but that plan got scrapped for some reason.
> > > > > >
> > > > > > I haven't looked at the i915 DRM code much, but my understandin=
g is
> > > > > > that it's more of an "all in one" approach. The one driver pret=
ty much
> > > > > > handles everything itself. That means that powering the panel u=
p isn't
> > > > > > too hard. Is that right?
> > > > >
> > > > > Yeah, we don't have too many "helpful" abstractions in the way ;)
> > > > >
> > > > > > > > > for userspace to be mucking with /dev/aux. For DP's case =
I guess
> > > > > > > > > /dev/aux is essentially enabling userspace drivers to do =
things like
> > > > > > > > > update firmware on DP monitors or play with the backlight=
. I guess we
> > > > > > > > > decided that we didn't want to add drivers in the kernel =
to handle
> > > > > > > > > this type of stuff so we left it for userspace? For eDP, =
though, there
> > > > > > > >
> > > > > > > > The main reason DP AUX got exposed to userspace in the firs=
t place was for
> > > > > > > > usecases like fwupd,
> > > > > > >
> > > > > > > My memory says the original reason was debugging. Or at least=
 I had
> > > > > > > no idea fwupd had started to use this until I saw some weird =
looking
> > > > > > > DPCD addresses in some debug log.
> > > > > > >
> > > > > > > But I suppose it's possible there were already plans for firm=
ware
> > > > > > > updates and whatnot and it just wasn't being discussed when t=
his was
> > > > > > > being developed.
> > > > > >
> > > > > > If it's just for debugging, I'd argue that leaving it as-is sho=
uld be
> > > > > > fine. Someone poking around with their system can find a way to=
 make
> > > > > > sure that the panel stays on.
> > > > >
> > > > > That could require altering the state of the system quite a bit, =
which
> > > > > may defeat the purpose.
> > > >
> > > > It does? In my experience you just need to make sure that the panel=
 is
> > > > turned on. ...or are you saying that you'd use this for debugging a
> > > > case where the system isn't probing properly?
> > > >
> > > > If things are truly in bad shape, at least on boards using device t=
ree
> > > > it's easy to tweak the device tree to force a regulator to stay on.=
 I
> > > > suppose we could also add a "debugfs" entry for the panel that also
> > > > forces it to be powered on.
> > > >
> > > >
> > > > >  At least I would not be willing to accept such
> > > > > a limitation.
> > > >
> > > > Hmm, so where does that leave us? Are you against landing this patc=
h?
> > > > I've done a lot of cleanups recently and I just don't think I have =
the
> > > > time to rework all the AUX transfer functions and figure out how to
> > > > power the panel. It also seems like a lot of added complexity for a
> > > > debug path.
> > >
> > > If my 2c counts, I support landing this patch. It clearly documents
> > > current behaviour and expectations.
> > >
> > > If that helps,
> > > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > As for the /dev/aux, question, I think we can make the following plan=
 work:
> > > - Document that eDP panel power up can be handled by using the
> > > pm_runtime API (which is the case for both panel-edp and atna33xc20))=
.
> > > I think this is a sensible requirement anyway. And both panels show
> > > how to handle different poweron/poweroff timings.
> > > - Make drm_dp_aux_dev_get_by_minor() pm_runtime_get() the attached pa=
nel.
> >
> > This matches what you suggested previously, but I still think it has a
> > potential problem as I talked about in the my previous (very long)
> > reply [1]. The relevant part was:
> >
> > > Now, despite the fact that the generic eDP panel code doesn't follow
> > > the "strict"ness I just described, the _other_ DP panel I worked on
> > > recently (samsung-atna33xc20) does. In testing we found that this
> > > panel would sometimes (like 1 in 20 times?) crash if you ever stopped
> > > outputting data to the display and then started again. You absolutely
> > > needed to fully power cycle the display each time. I tried to documen=
t
> > > this to the best of my ability in atana33xc20_unprepare(). There's
> > > also a WARN_ON() in atana33xc20_enable() trying to detect if someone
> > > is doing something the panel driver doesn't expect.
> >
> > Specifically, I think you could get in trouble if you did:
> >
> > a) drm wants to power down the panel.
> >
> > b) drm calls the panel's disable() function
> >
> > c) we start an aux transfer and grab a runtime pm reference
> >
> > d) drm calls the panel's unprepare() function =3D> atana33xc20_unprepar=
e()
> >
> > e) atana33xc20_unprepare()'s pm_runtime_put_sync_suspend() _won't_
> > power off the panel (we still have the reference from step c), even
> > though it needs to.
> >
> > f) we'll finish an aux transfer and, presumably, call
> > pm_runtime_put_autosuspend()
> >
> > g) drm wants to power the panel back up
> >
> > h) drm calls the panel's prepare() function, but power wasn't properly =
cycled
>
> Why? We'd need to extend the prepare() function with the flag
> data_was_on, which is set in the enable() and cleared in the suspend
> path. If we see this flag in the prepare() callback, we should
> forcibly power cycle the panel by toggling the regulator. Yes, this
> will cause additional wait.
>
> Another option might be to toggle the autosuspend support. Let the
> disable() call pm_runtime_dont_autosuspend() (which would turn all
> autosuspend calls into plain pm_runtime_put()) and allow it again in
> the resume(). I'm not 100% sure that this will work, but it looks like
> it should.

It turns out, though, that we _want_ autosuspend sometimes, even when
the panel is disabled. Specifically, if the panel is disabled and then
atana33xc20_get_modes() gets called then we _don't_ want to fully
power the panel off. It's expected that there will be a future call to
prepare() soon after the get_modes() and we don't want a full power
cycle (500 ms) there. This mechanism is also fully allowed by the eDP
spec. The only time we _need_ a full power cycle is after disable().

In any case, we can come up with complex ways to solve this, but I'm
still just not convinced that it's worth it. There's no valid use case
other than debugging. IMO if we're poking around and want to read DP
registers while the panel is on then it works just fine. A user doing
this can ensure that the panel is on while poking. Certainly I've done
that and it wasn't a big imposition.

If someone wants to submit patches to attempt this then I'm happy to
test them, but I feel like it's adding complexity for very little
value. The way it works now is simple / understandable and mathes my
intuition from other busses, like i2c. The bus is just responsible for
powering itself, not the devices on the bus. It has also long been
documented since commit 83127f67e450 ("drm/panel: Flesh out
kerneldoc") in 2016 that the way to turn on a panel for communication
over the command bus is via drm_panel_prepare(). I don't think we need
to change this.


> The second option leaves a possible window for the panel issues if the
> userspace AUX transfer is ongoing while the panel is being unprepared
> and then prepared again. In this case it will never be power cycled.
> However after some thought I think this is correct. You wouldn't like
> to power cycle a panel while you are e.g. updating the firmware.

As per my earlier responses, nothing we are doing here solves the
firmware update anyway. Even if we automatically power the panel for
the duration of a single aux transfer, nothing prevents the panel from
turning off between transfers. There's no API to "keep the power on
until I say stop". You certainly wouldn't want a panel to turn off
midway through a firmware update. IMO if we want to use this for
firmware update, we either need an special way to force the panel on
(in which case, we don't need to worry about it in the aux transfer
function) or (better IMO) we need to manage the firmware update in the
panel driver and prevent some type of sysfs interface to provide the
new firmware and kick off the update. Presumably having this managed
by the panel driver would be best because the panel driver could know
to, for instance, re-read the EDID after the firmware update took
place.

-Doug
