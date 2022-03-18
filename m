Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE554DE4BD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 01:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbiCSAF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiCSAFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 20:05:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EA2C2747
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:04:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h1so11944163edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXGJa6CFv1aUDS6a5HMhMzXGnOQH0YUOOBu2NLGR9Jo=;
        b=fEAnYQmMbqrWHduv7kT3sDO5GJe6qUfu3cBnBhRqDNfZ6+ilQyHkcYXGW5sOABXObp
         vIuyR2O41EAOzNfPBrDuqDabDSTvhVuluj3UqOrE9oPIiFcJzzSEILdzBrSFqAwOsvQE
         7GkJFdcQTpOtAKUQ/LX1gQzkTJXuYmS1x5fbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXGJa6CFv1aUDS6a5HMhMzXGnOQH0YUOOBu2NLGR9Jo=;
        b=mx+DEhcdacz33wMssDB36oJ/wGXRDQVUJKRVYqqmk6cdNpEn/RcatdrayPHTulCwK+
         tua/0lvbCP99WH+Hje83FnnOZaxWC8j5PY+jB3sweS/Cz2DVCGutvgZr0uA+NgoRqzdL
         iQm0icCAR7H5unYwCPoMRdoh7BzJI7U7k9deAIs5BBqc0PoB8mdQolp8Y8b0xd7qJVju
         XxosgULHQV4IE6yBl0yvSUUXPLGjiODjHIbeSKZ8MBOU3cwcibqP2knfSj/hYON4cOk+
         wOWHHDOrd85I2gq/SrGKp0JnfFz99wLYSbsc5YSQp2W0vKOSoN+0gL0eVLOdQ7joMDwK
         o8cw==
X-Gm-Message-State: AOAM530z/f3ZFAhZvYIKEQFdz6t7Xu9DlELH1LuZDZhjUYr1cQZIe77K
        24QoWA547CErlfX9t1/zBI2YX5db2iiYZyVi7AI=
X-Google-Smtp-Source: ABdhPJw7KzayqNzw5QbTPTtDVB32V7he4msnzDtqikLzEE9tb4s4qUxCiCFJQwdZNilOSDFB9YOiBA==
X-Received: by 2002:a05:6402:50cf:b0:418:ee57:ed9 with SMTP id h15-20020a05640250cf00b00418ee570ed9mr11902480edb.37.1647648273168;
        Fri, 18 Mar 2022 17:04:33 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id n25-20020aa7db59000000b00415965e9727sm4701484edt.18.2022.03.18.17.04.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 17:04:32 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id t24so3481708wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:04:32 -0700 (PDT)
X-Received: by 2002:a5d:4491:0:b0:203:f63a:e89b with SMTP id
 j17-20020a5d4491000000b00203f63ae89bmr4399095wrq.342.1647647801948; Fri, 18
 Mar 2022 16:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <1647452154-16361-1-git-send-email-quic_sbillaka@quicinc.com>
 <1647452154-16361-7-git-send-email-quic_sbillaka@quicinc.com>
 <CAE-0n520pQKM7mFSE_00ER+F9RKUPrN+y4U8fmsxi7FoFMyOrA@mail.gmail.com>
 <CAD=FV=UWF8K9JPJXFSGMRK-HmCi+2jM3aN6Uy7hyDSu1_azF+w@mail.gmail.com>
 <CAE-0n53U=bqPTGtPx2Ho5axtO6EL6WtOtmFisxSufC6OZERV1Q@mail.gmail.com>
 <CAD=FV=WaK8VFC-BvsFpnUv3mW4svGggQTw1hh+zRCEhGvbgYMQ@mail.gmail.com> <CAE-0n52v2m4U0wK6NYf4KBwXmp+TEVhjnGpW4rQHuZSf7TYfgA@mail.gmail.com>
In-Reply-To: <CAE-0n52v2m4U0wK6NYf4KBwXmp+TEVhjnGpW4rQHuZSf7TYfgA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Mar 2022 16:56:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFkXdXVdqhBcfa48JKcUcbUe2M0bW6-V8zjP8jgvjvHA@mail.gmail.com>
Message-ID: <CAD=FV=WFkXdXVdqhBcfa48JKcUcbUe2M0bW6-V8zjP8jgvjvHA@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] drm/msm/dp: wait for hpd high before any sink interaction
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 18, 2022 at 4:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > > Pushing hpd state checking into aux
> > > transactions looks like the wrong direction. Also, as I said up above I
> > > am concerned that even checking the GPIO won't work and we need some way
> > > to ask the bridge if HPD is asserted or not and then fallback to the
> > > GPIO method if the display phy/controller doesn't have support to check
> > > HPD internally. Something on top of DRM_BRIDGE_OP_HPD?
> >
> > If we could somehow get the HPD status from the bridge in the panel
> > driver it definitely would be convenient. It does feel like that's an
> > improvement that could be done later, though. We've already landed a
> > few instances of doing what's done here, like for parade-ps8640 and
> > analogix_dp. I suspect designing a new mechanism might not be the most
> > trivial.
>
> What is done in the bridge drivers is to wait for a fixed timeout and
> assume aux is ready? Or is it something else? If there's just a fixed
> timeout for the eDP case it sounds OK to do that for now and we can fine
> tune it later to actually check HPD status register before the panel
> tries to read EDID.

Right. For the parade chip (which is only used for eDP as far as I
know--never DP) waits for up to 200 ms. See ps8640_ensure_hpd().

So I guess tl;dr to Sankeerth that it's OK for his patch to have the
wait in the aux transfer function, but only for eDP. Other discussions
here are about how we could make it better in future patches.


> > I haven't actually tried it, but I suspect that to get something like
> > what you're talking about we'd have to get the rest of drm to know
> > that for eDP ports that it should assume something is connected
> > _regardless_ of what the "detect" / "HPD" options say. Then we'd have
> > to extend the edp-panel code to be able to be able to query the next
> > bridge in the chain if a GPIO wasn't provided.
>
> Can the panel interrogate the bridge chain somehow? It feels like either
> something in the chain should know the status of HPD (the case here
> where display controller in the SoC knows) or it should be a gpio to the
> panel (trogdor case). The bridge ops can implement DRM_BRIDGE_OP_HPD and
> the first bridge from the encoder that supports HPD can implement some
> sort of "wait for hpd asserted" function that the panel then uses once
> it powers up the panel during probe. If the panel has a gpio and nothing
> else in the chain can detect hpd then the panel polls the gpio, or it
> waits for the amount of time delay after powering on the panel if the
> panel's hpd function is called.

Yeah, there ought to be some way to make something like that work. I
don't think it's just DRM_BRIDGE_OP_HPD, though, for a few reasons:

1. That operation actually specifically means that HPD can cause an
interrupt and that the bridge promises to call drm_bridge_hpd_notify()
when the interrupt occurs. It seems to work hand-in-hand with
"DRM_BRIDGE_OP_DETECT". I know it's legit to advertise "detect"
without "HPD" (you have an HPD line that can be polled but not cause
interrupts) but I'd have to research whether it's legal to advertise
"HPD" without "detect".

2. If it were up to me, I'd rather avoid conflating what we need with
the existing "HPD" and "DETECT" ops. While the line is called "HPD" in
the eDP spec, what we're looking for here is really a different
concept. eDP panels are never hot plugged and are always present, so
I'd personally rather it be a new OP like "OP_PANEL_READY". Of course,
in whatever future patch we could always debate this.

3. The main reason I'd prefer a different op is that I think using the
existing ops will confuse DRM (not just because I'm being pedantic).
If DRM sees that the eDP controller driver advertises that it can
"detect" and support "hpd" then it will use these functions to decide
whether it should start turning on the panel. ...and it won't even try
using the panel until one is detected, right? ...but that means that
it won't be powered on and will never be detected. ;-) This is what
I'm trying to get at: it's a different concept. The panel is always
there and never hotplugged. The existing DRM ops (IMO) are for knowing
whether a panel is physically present. For eDP the answer is always a
resounding "yes", even if we have no actual evidence (because we can't
gather evidence for an "off" panel). On eDP the HPD line simply means
something different than on DP.


> > > > For the DP case this should not cause any significant overhead, right?
> > > > HPD should always be asserted so this is basically just one extra IO
> > > > read confirming that HPD is asserted which should be almost nothing...
> > > > You're just about to do a whole bunch of IO reads/writes in order to
> > > > program the AUX transaction anyway.
> > >
> > > In the DP case the dongle/cable can be disconnected in the middle of aux
> > > transactions. If that happens we could be waiting a while in this
> > > transfer function to timeout looking for the status bit. The driver
> > > already gets an "unplug" irq when the cable is disconnected though so it
> > > would be better to figure out a way to stop the aux transactions quickly
> > > when that happens without having to read the hardware and poll the bit
> > > that we already know is doomed to timeout. I think apple dongles throw
> > > this logic for a loop though because the HDMI cable can be disconnected
> > > from the dongle and then we don't see an "unplug" irq, just the number
> > > of sinks becomes 0. Maybe there's an irq_hpd event, not sure.
> >
> > Ah, interesting. Having a DP cable unplugged in the middle of an aux
> > transaction does seem like it could be a problem. What if we just wait
> > in the case our bridge.type is "DRM_MODE_CONNECTOR_eDP"? That should
> > be easy, right?
>
> Sounds like it would work. Is this supposed to fix some DP case as well
> though? There were some patches to speed up aux failures when the dongle
> was unplugged but I haven't checked after that. I guess this waiting is
> only important for eDP because the edp-panel code is trying to read EDID
> and it isn't waiting for HPD to be asserted before doing that.

Right, I think this is only important for eDP.


> > > That doesn't sound right.
> > > My understanding is that HPD will be asserted after the panel is powered
> > > up. Before that HPD is deasserted. Similarly, when we power down the
> > > panel, HPD will be deasserted. I guess DRM wants to assume that an eDP
> > > panel is always connected? That sounds like it might be OK as long as
> > > userspace doesn't use "connected" to know that it's OK to do things like
> > > read/write aux or push pixels to the panel when HPD is deasserted.
> >
> > IMO having userspace reading / writing aux directly and expecting it
> > to work is a terrible idea anyway. It's _maybe_ sorta OK in the DP
> > case, but it's really not good in the eDP case. To me it's sorta like
> > expecting things to be amazing and foolproof when you go behind the
> > kernel's back and write to an i2c device using `i2cset -f`. Sure, it
> > might work, but it can also confuse the heck out of things. It also
> > turns out to be a huge problem when you get to PSR because userspace
> > will get errors if it tries to write to the AUX channel and the panel
> > is in PSR mode. This came up in the context of Brian's analogix dp
> > patches [1]. The right answer, in my mind, is to treat userspace
> > accessing the AUX channel directly as more of a debug feature, at
> > least for eDP panels.
>
> If it's a debug feature then it should be removed from the system. The
> flow of data is passing through the kernel so if the kernel is getting
> confused about backdoor access over aux it should snoop the transactions
> and block things it doesn't like. I don't know the backstory on aux
> being exposed to userspace, but leaving it in a broken state isn't good.

Agreed, it's not a great situation. :(

-Doug
