Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549B51ACDA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377061AbiEDSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377094AbiEDSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A6A85159A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651687812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7hIAy3RxcqOtM7Yf90BC+sWNEC/sHJ+29FfPH3OpXA=;
        b=fZG5DAMUID6LRMpg0c0ZD/Nl7SFvrdvdZ71osOgcse1V2nAsDr9CJyPE8v//6JB50WTSfT
        Y3RunZLz9dNuIKqy+i7WUP7CdmPa9EoEi+q0y4G8h6sV3Uux/1f2R81E3CL6RegHUvWN/2
        hHZDtjhpCOm7QxZWkD5jOnd/AYZdBrA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-suoIw_a1NzSUumGlIiuSvg-1; Wed, 04 May 2022 14:10:11 -0400
X-MC-Unique: suoIw_a1NzSUumGlIiuSvg-1
Received: by mail-qv1-f71.google.com with SMTP id g10-20020a0562141cca00b00456332167ffso1440351qvd.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=t7hIAy3RxcqOtM7Yf90BC+sWNEC/sHJ+29FfPH3OpXA=;
        b=fokAwNxYnWYAqsmayFjgTvU/wnTkzpSQn16GMZW8ugMP18iFRBv2J+Q/TbdRikbISX
         rm6MiwS1i5jXedv1m+I3veOG4vLNomz201BA2e+xn/0+FJsU9xvyNs414Wr7QfwO16m7
         LKBBZWILLdxtFsTkm33m+ST7NzVVSjP1lRtOnmpWrONzSlRBALk5taKPc1eIxe/SYMmd
         OaDVNCBc4hkeuPvLrlAXvsJsHrkVpk9Vzqum6ICEaI1YNh9Z9fvhTcV2VHEYF4kokoeh
         TZyzk6txDLZh0PpM/Vbp8yOdvMruFsijGelApwWbVlgODwefXfaB3aT303WrqDlDfggH
         q/lg==
X-Gm-Message-State: AOAM532+FWMYXoO8fPBDMMesdecZSKVq9P7Hb8ffgn97vWxV3/+bn3sW
        /0Df5TUmLLcr+taeGLFy96JNxOOUFfBsIRrSvZ5ILwMiE62vwf9/RiW9y9NL6LuXRTAiPlKU22V
        wOpaWoXSSAWcgLwbGEqSKGOFQ
X-Received: by 2002:a37:8641:0:b0:67e:85d1:f5e9 with SMTP id i62-20020a378641000000b0067e85d1f5e9mr17179562qkd.128.1651687810827;
        Wed, 04 May 2022 11:10:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO7GIjDZ3nMFv/5xr7vzUdIYwV4LLtoe8PJ1zll9EeaciJXDt+o14bNRkod44VnjaoVQRryQ==
X-Received: by 2002:a37:8641:0:b0:67e:85d1:f5e9 with SMTP id i62-20020a378641000000b0067e85d1f5e9mr17179531qkd.128.1651687810478;
        Wed, 04 May 2022 11:10:10 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id m21-20020ac84455000000b002f39b99f674sm7757467qtn.14.2022.05.04.11.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 11:10:09 -0700 (PDT)
Message-ID: <1c6c9fde6e85f09cc89ea8dc6e8716fef58f3ee1.camel@redhat.com>
Subject: Re: [PATCH] drm: Document that power requirements for DP AUX
 transfers
From:   Lyude Paul <lyude@redhat.com>
To:     Doug Anderson <dianders@chromium.org>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 04 May 2022 14:10:08 -0400
In-Reply-To: <CAD=FV=WndmKuEB0=OVQP9YuJaSmD0uxkNs5LE0wWsFj7gBvhBA@mail.gmail.com>
References: <20220503162033.1.Ia8651894026707e4fa61267da944ff739610d180@changeid>
         <YnJv3B/85hTz54SC@intel.com>
         <CAD=FV=WndmKuEB0=OVQP9YuJaSmD0uxkNs5LE0wWsFj7gBvhBA@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 09:04 -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 4, 2022 at 5:21 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> > 
> > On Tue, May 03, 2022 at 04:21:08PM -0700, Douglas Anderson wrote:
> > > When doing DP AUX transfers there are two actors that need to be
> > > powered in order for the DP AUX transfer to work: the DP source and
> > > the DP sync. Commit bacbab58f09d ("drm: Mention the power state
> > > requirement on side-channel operations") added some documentation
> > > saying that the DP source is required to power itself up (if needed)
> > > to do AUX transfers. However, that commit doesn't talk anything about
> > > the DP sink.
> > > 
> > > For full fledged DP the sink isn't really a problem. It's expected
> > > that if an external DP monitor isn't plugged in that attempting to do
> > > AUX transfers won't work. It's also expected that if a DP monitor is
> > > plugged in (and thus asserting HPD) that it AUX transfers will work.
> > > 
> > > When we're looking at eDP, however, things are less obvious. Let's add
> > > some documentation about expectations. Here's what we'll say:
> > > 
> > > 1. We don't expect the DP AUX transfer function to power on an eDP
> > > panel. If an eDP panel is physically connected but powered off then it
> > > makes sense for the transfer to fail.
> > 
> > I don't agree with this. I think the panel should just get powred up
> > for AUX transfers.
> 
> That's definitely a fair thing to think about and I have at times
> thought about trying to make it work that way. It always ends up
> hitting a roadblock.
> 
> The biggest roadblock that I recall is that to make this work then
> you'd have to somehow ensure that the bridge chain's pre_enable() call
> was made as part of the AUX transfer, right? Since the transfer
> function can be called in any context at all, we have to coordinate
> this with DRM. If, for instance, DRM is mid way through powering the
> panel down then we need to wait for DRM to fully finish powering down,
> then we need to power the panel back up. I don't believe that we can
> just force the panel to stay on if DRM is turning it off because of
> panel power sequencing requirements. At least I know it would have the
> potential to break "samsung-atna33xc20.c" which absolutely needs to
> see the panel power off after it's been disabled.
> 
> We also, I believe, need to handle the fact that the bridge chain may
> not have even been created yet. We do AUX transfers to read the EDID
> and also to setup the backlight in the probe function of panel-edp. At
> that point the panel hasn't been linked into the chain. We had _long_
> discussions [1] about moving these out of probe and decided that we
> could move the EDID read to be later but that it was going to really
> ugly to move the AUX backlight later. The backlight would end up
> popping up at some point in time later (the first call to panel
> prepare() or maybe get_modes()) and that seemed weird.
> 
> [1]
> https://lore.kernel.org/lkml/CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com/
> 
> 
> > Otherwise you can't trust that eg. the /dev/aux
> > stuff is actually usable.
> 
> Yeah, it's been on my mind to talk more about /dev/aux. I think
> /dev/aux has some problems, at least with eDP. Specifically:
> 
> 1. Even if we somehow figure out how to power the panel on as part of
> the aux transfer, we actually _still_ not guaranteed to be able to
> talk to it as far as I understand. My colleague reported to me that on
> a system he was working with that had PSR (panel self refresh) that
> when the panel was powered on but in PSR mode that it wouldn't talk
> over AUX. Assuming that this is correct then I guess we'd also have to
> do even more coordination with DRM to exit PSR and block future
> transitions of PSR. (NOTE: it's always possible that my colleague ran
> into some other bug and that panels are _supposed_ to be able to talk
> in PSR. If you think this is the case, I can always try to dig more).

TBH - the coordination with drm I don't think would be the difficult part, as
we'd just need to add some sort of property (ideally invisible to userspace)
that can be used in an atomic commit to disable PSR - similar to how we enable
CRC readback from sysfs in the majority of DRM drivers. That being said
though, I think we can just leave the work of solving this problem up to
whoever ends up needing this to work.

> 
> 2. I'm not totally convinced that it's a great idea, at least for eDP,
> for userspace to be mucking with /dev/aux. For DP's case I guess
> /dev/aux is essentially enabling userspace drivers to do things like
> update firmware on DP monitors or play with the backlight. I guess we
> decided that we didn't want to add drivers in the kernel to handle
> this type of stuff so we left it for userspace? For eDP, though, there

The main reason DP AUX got exposed to userspace in the first place was for
usecases like fwupd, where some MST docks actually do their firmware updates
over DPCD. I don't know of any equivalent usecase for eDP at the moment, but I
can definitely try asking some of the OEM contacts I have whether this is/may
eventually be a thing or not.

> is a panel driver and we if we have an AUX backlight we create a real
> backlight device. If we needed to do a firmware update of an eDP panel
> it would make sense for the panel driver to present some interface for
> the firmware update so that the panel driver could make sure that the
> panel stayed powered for the duration of the firmware update, not just
> for the duration of a single AUX transfer.

Yeah, I tried adding this at one point actually but ran into some issues
finding a nice solution. It wasn't the most important thing at the time, so I
ended up shifting my attention to other things. Honestly the biggest
complicating factor of this is the fact that we can't synchronously wake up a
device from sysfs without introducing a deadlock due to lock order inversion
between DRM and sysfs. If this could be solved nicely, I think a lot of this
would become far easier.

> 
> 3. In general it feels a little awkward for userspace to be directly
> poking at the same set of registers that a kernel driver is also
> poking at.

We could always consider limiting the ranges that the DP AUX interface allows
userspace to read from, although I haven't thought too hard about that since I
don't know that would fix the issue entirely.

> 
> To me it feels like /dev/aux is much like the /dev/i2c interface. Yes,
> userspace can go talk to random i2c devices and can even talk to them
> after a kernel driver has "claimed" an i2c device, but:
> a) If an i2c device is powered off, then the i2c transfer won't work.
> b) If you set a register of a device managed by a kernel driver behind
> the back of the kernel driver, you're really asking for trouble.
> 
> 
> So I guess my proposals would be to pick one of:
> 
> a) Leave things they way they are as I've documented. NOTE that my
> documentation does document the way things are today. No aux transfer
> function that I'm aware of powers up an eDP panel. In this case if
> someone wants to use /dev/aux for an eDP panel it's really up to them
> not to shoot themselves in the foot.

To be honest, I do totally agree though that /dev/aux has very limited
usecases for eDP. I do think it's definitely a useful debugging tool, and it's
been a big help in figuring out how things like backlight interfaces work when
I'm otherwise lacking in docs (and sometimes it's still useful, since you can
test various subleties of panel controllers). So at a bare minimum, I'd very
much like it if we can at least keep it around in some form (perhaps hidden
behind a kernel config option). Although, that brings up the question of if
that makes it harder for someone without kernel debugging experience to get me
DPCD output from a panel outside of what got logged to the kernel…

> 
> b) Stop populating /dev/aux for eDP panels and only do it for DP and
> then if/when someone yells we figure out how they were using /dev/aux
> and why it was safe. This is definitely an ABI change but I have no
> idea if it would really break anyone. I suppose we could take a first
> step by spewing a WARN_ON if someone directly uses /dev/aux for eDP?
> 
> c) Somehow dynamically create / remove the /dev/aux device as the eDP
> panel turns off and on again. If /dev/aux is there then we know that
> the panel is on. NOTE: this ignores PSR. I don't think we'd want to
> delete / create the /dev/aux node that often. So we'd either have to
> still accept that the transfers will sometimes fail (c1) or make it a
> requirement that we bring the panel out of PSR for an AUX transfer
> (c2).
> 
> 
> Technically we could list option (d) to power the panel up, but as per
> above I think it's pretty awkward and doesn't feel like the right way
> to go. Obviously happy to hear other opinions, though.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

