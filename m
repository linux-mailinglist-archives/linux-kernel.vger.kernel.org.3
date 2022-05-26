Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C132534818
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbiEZB2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiEZB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:28:46 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351849D070
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:28:45 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b81so142078vkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oiTRf6EF/H3TBNBVZIGNJm3A9cOgQLVm1U6yDTQ2d5I=;
        b=fs1lwK6/6kqEgmHrQX6rxnyuN1F3qSBt6oZlGY/IgJSpxNNazl86s15U+QVeAweXiR
         e6K+dANWBE/D616R5uaxSIyjtWKMeZSMe8xcAZDhDA5mUPTWA/yrOPlxhZN2BW62jzVY
         lNQQhdz4wtvTJNq/yaBpzqsMj5a9tBTTmHJsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oiTRf6EF/H3TBNBVZIGNJm3A9cOgQLVm1U6yDTQ2d5I=;
        b=ehFWHocDjc+wxpvUB7aUtWvqmVawQVQkGqSMMVkIaLMbVyD8tUamoXwvuq6q+4kS3O
         4QVSSvg6UhrS/EPWfASs7qkuH5FR3ycZTElhLfQIhHyPBD+C5sIuSO0oEgPKxVnouPCS
         PtYtzeNDLfJJ3LiiiCtJZZkNzjtzlOpYZtwc+SB9FZsyZORWHZ8zVidcbL/6MjcYSotL
         9RWKvOg0B9n6J5/Kw4MN3+G82bS4piRB34wDw6+OiniP5O0J73LpabXxDFbbk1YCDlDU
         BEZslDrBUBwwOm6FJjSxPZa22y3A9oE69F0ZoTkmmLuEG219JrkbdRm+tI0LOuavzUzQ
         NHCg==
X-Gm-Message-State: AOAM531QSRXQUZqBJgUxat3JHB9O8zPswp/tpAxE0c/FhBe4Sr1SPGW0
        YUOJd8gCxAPejML2XMYfhVLp/qPkLqUaZb4+
X-Google-Smtp-Source: ABdhPJyvtcnL/lvUXVH56xjM+mLTpfesPfhQ1PIA1lx1frPP0tHuWQEu98vmam46X8arKp0GR9oH9A==
X-Received: by 2002:a05:6122:d98:b0:331:47bf:b437 with SMTP id bc24-20020a0561220d9800b0033147bfb437mr13345642vkb.29.1653528524007;
        Wed, 25 May 2022 18:28:44 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id k23-20020a67e3d7000000b0032d275e6917sm12026vsm.23.2022.05.25.18.28.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 18:28:41 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id ay20so132734vkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:28:41 -0700 (PDT)
X-Received: by 2002:a05:6122:221f:b0:343:f3d4:87cb with SMTP id
 bb31-20020a056122221f00b00343f3d487cbmr12802200vkb.13.1653528520525; Wed, 25
 May 2022 18:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
 <5857c510-9783-a483-8414-65d7350618d6@suse.de> <CAD=FV=X99EWmRk82ako7cL7BWPEsTG=L7VVBVDFX5qKc1MifSA@mail.gmail.com>
 <CAD=FV=U3Wywjev9tEhkL_zE1cV5NwEknH2YwHqyhd5TQtiJ=AQ@mail.gmail.com> <Yo4ufWm5WiXsnRX8@phenom.ffwll.local>
In-Reply-To: <Yo4ufWm5WiXsnRX8@phenom.ffwll.local>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Wed, 25 May 2022 21:28:04 -0400
X-Gmail-Original-Message-ID: <CAOw6vbLu7TzTppUYv1cynMvn+ykTuGiYBCNhN7FO2kYqZj4DUg@mail.gmail.com>
Message-ID: <CAOw6vbLu7TzTppUYv1cynMvn+ykTuGiYBCNhN7FO2kYqZj4DUg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/probe-helper: Make 640x480 first if no EDID
To:     Doug Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sean Paul <seanpaul@google.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 9:26 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, May 23, 2022 at 05:59:02PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, May 20, 2022 at 5:01 PM Doug Anderson <dianders@chromium.org> w=
rote:
> > >
> > > Hi,
> > >
> > > On Mon, May 16, 2022 at 3:28 AM Thomas Zimmermann <tzimmermann@suse.d=
e> wrote:
> > > >
> > > > Hi Douglas,
> > > >
> > > > I understand that you're trying to tell userspace that the modelist=
 has
> > > > been made up, but it's not something that should be done via fragil=
e
> > > > heuristics IMHO.
> > > >
> > > > I looked at the Chromium source code that you linked, but I cannot =
say
> > > > whether it's doing the correct thing. It all depends on what your
> > > > program needs.
> > > >
> > > > In that function, you could also search for 'DRM_MODE_TYPE_USERDEF'=
.
> > > > It's the mode that the user specified on the kernel command line. I=
f
> > > > Chromium's automatic mode selection fails, you'd give your users di=
rect
> > > > control over it.
> > >
> > > That doesn't really work for Chrome OS. Certainly a kernel hacker
> > > could do this, but it's not something I could imagine us exposing to
> > > an average user of a Chromebook.
> > >
> > >
> > > > When there's no flagged mode or if
> > > > /sys/class/drm/card<...>/status contains "unconnected", you can ass=
ume
> > > > that the modelist is artificial and try the modes in an appropriate=
 order.
> > >
> > > So "no flagged" means that nothing is marked as preferred, correct?
> > >
> > > ...so I guess what you're suggesting is that the order that the kerne=
l
> > > is presenting the modes to userspace is not ABI. If there are no
> > > preferred modes then userspace shouldn't necessarily assume that the
> > > first mode returned is the best mode. Instead it should assume that i=
f
> > > there is no preferred mode then the mode list is made up and it shoul=
d
> > > make its own decisions about the best mode to start with. If this is
> > > the ABI from the kernel then plausibly I could convince people to
> > > change userspace to pick 640x480 first in this case.
> > >
> > > > If we really want the kernel to give additional guarantees, we shou=
ld
> > > > have a broader discussion about this topic IMHO.
> > >
> > > Sure. I've added St=C3=A9phane Marchesin to this thread in case he wa=
nts to
> > > chime in about anything.
> > >
> > > Overall, my take on the matter:
> > >
> > > * Mostly I got involved because, apparently, a DP compliance test was
> > > failing. The compliance test was upset that when it presented us with
> > > no EDID that we didn't default to 640x480. There was a push to make a
> > > fix for this in the Qualcomm specific driver but that didn't sit righ=
t
> > > with me.
> > >
> > > * On all devices I'm currently working with (laptops), the DP is a
> > > secondary display. If a user was trying to plug in a display with a
> > > bad EDID and the max mode (1024x768) didn't work, they could just use
> > > the primary display to choose a different resolution. It seems
> > > unlikely a user would truly be upset and would probably be happy they
> > > could get their broken display to work at all. Even if this is a
> > > primary display, I believe there are documented key combos to change
> > > the resolution of the primary display even if you can't see anything.
> > >
> > > * That all being said, defaulting to 640x480 when there's no EDID mad=
e
> > > sense to me, especially since it's actually defined in the DP spec. S=
o
> > > I'm trying to do the right thing and solve this corner case. That
> > > being said, if it's truly controversial I can just drop it.
> > >
> > >
> > > So I guess my plan will be to give St=C3=A9phane a little while in ca=
se he
> > > wants to chime in. If not then I guess I'll try a Chrome patch...
> > > ...and if that doesn't work, I'll just drop it.
> >
> > OK, this userspace code seems to work:
> >
> > https://crrev.com/c/3662501 - ozone/drm: Try 640x480 before picking
> > the first mode if no EDID
> >
> > ...so we'll see how review of that goes. :-)

Mirroring some of my comments on that review here :-)

IMO, this should be addressed in the kernel, or not at all. The kernel
ensures other aspects of DisplayPort implementation are compliant, so
I don't think this would be any exception. Further, the kernel is the
one creating the "safe" mode list, so it seems odd that userspace
would override that. Finally, relying on every userspace to do the
right thing is asking for trouble (we have 3 places which would need
this logic in CrOS).

>
> Yeah it sucks a bit but I'm mildly afraid that if we muck around with the
> absolute fallback mode list in upstream we get whacked by a regression
> report :-/

Yeah, this seems likely (unfortunately).

>
> There's the additional fun that on modern displays probably 720p (or mayb=
e
> 720i) is a lot more likely to work than anything else really, so best we
> can do here maybe is to make it an uapi guarantee that if there's no
> preferred mode, then most likely the kernel invent random noise out of
> thin air, and userspace has to be careful and do its own magic heuristics=
.
> Or maybe we should add a flag for "this stuff is invented, buyer beware".
>

This seems like a reasonable compromise. Perhaps marking 640x480 as
preferred would be a middle road?

> I think clarifying that would be good. Changing defaults feels a bit too
> risky, we had some really hilarious regression reports in the past along
> the lines of the infamous xkcd.

FWIW, I don't really have a strong opinion as to whether this should
be fixed or not. I have a hard time believing that either 1024x768 or
640x480 would result in a happy result for the user, so we're really
just choosing a mode which is bad enough for the user to
unplug/replug. If 640x480 makes the compliance machine happy, I
suppose that's a compelling reason, but I don't really feel like this
is worth special casing each userspace.

Sean

> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
