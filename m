Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2477532022
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 03:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiEXBHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 21:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiEXBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 21:07:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DC941F81
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:07:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l13so21680172lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OFIx7s/L3YnWfFaGk/Iok1k3YIHu8uSKhlMvRjqHwqQ=;
        b=KSe/i6TaqXpR9n9Kj7do5tEUVCruj9NeCfJis7lHPt4XCGpfoUSsdoXddyYwkGuok5
         3r/Zv3GeYnYa3EkuzsUa+waSAnvXSIr8oza+OoPRxZNq0zKswJLBHr1tZeo9hc1oY5l1
         INhxu0T4ehuftGE/tXzigmaJGDdwu9VGppBZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OFIx7s/L3YnWfFaGk/Iok1k3YIHu8uSKhlMvRjqHwqQ=;
        b=sQUKgCojMQuSfWfiQ4eMYf8yGk50xmakzLS+NHKnWwZ8lGTgrZ9s/kkhZ/n2/7hCxS
         Z+q7OJGbWUWW94cDoNFPKIZ7TkWhbpJ01YkfnYGQ53HOB9PbU9oLO3aZRpvWyiAZtufi
         w9V3oPjtPa6ubRUqImaPjvEEsB0tlW2dUCiKc6XqWGv0j/5pEpkJLWP8jfK+0nxvQPGM
         ZAxhKAXLhhj/DlE4PijikawbGf0sbtvT5iBiOtu6iOZGe9NaenlnAT+XmrU9BIlweiJb
         XIDoMY3+yqmc1Id9UvHId+MWX6XTt0j53ySTMIabZl10y3MZdGM2QOm45dz0WhBZ9KAj
         V6KQ==
X-Gm-Message-State: AOAM532hS5QjJ2GVTbb0AdaMKlqOhSJfZiC1thkf3yHBVNEWuS7DbsOE
        JFrv3cJCjzQks6E5SzWlhL2skhmVuaEHkeXANXU=
X-Google-Smtp-Source: ABdhPJzySlTtr+NCKyx1kHA4dOgVRbr30gtOprKFeqit3Jd2UsGce5Ny+dq2tmbxFjWmx+6MvVGyhg==
X-Received: by 2002:ac2:5bc4:0:b0:478:5e54:fdaa with SMTP id u4-20020ac25bc4000000b004785e54fdaamr9728497lfn.148.1653354422789;
        Mon, 23 May 2022 18:07:02 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512324500b00477b6ffffa6sm2240332lfr.65.2022.05.23.18.07.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 18:07:02 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w14so28294297lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:07:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr11832701wry.513.1653353955258; Mon, 23
 May 2022 17:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220513130533.v3.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
 <5857c510-9783-a483-8414-65d7350618d6@suse.de> <CAD=FV=X99EWmRk82ako7cL7BWPEsTG=L7VVBVDFX5qKc1MifSA@mail.gmail.com>
In-Reply-To: <CAD=FV=X99EWmRk82ako7cL7BWPEsTG=L7VVBVDFX5qKc1MifSA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 May 2022 17:59:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3Wywjev9tEhkL_zE1cV5NwEknH2YwHqyhd5TQtiJ=AQ@mail.gmail.com>
Message-ID: <CAD=FV=U3Wywjev9tEhkL_zE1cV5NwEknH2YwHqyhd5TQtiJ=AQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/probe-helper: Make 640x480 first if no EDID
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
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

Hi,

On Fri, May 20, 2022 at 5:01 PM Doug Anderson <dianders@chromium.org> wrote=
:
>
> Hi,
>
> On Mon, May 16, 2022 at 3:28 AM Thomas Zimmermann <tzimmermann@suse.de> w=
rote:
> >
> > Hi Douglas,
> >
> > I understand that you're trying to tell userspace that the modelist has
> > been made up, but it's not something that should be done via fragile
> > heuristics IMHO.
> >
> > I looked at the Chromium source code that you linked, but I cannot say
> > whether it's doing the correct thing. It all depends on what your
> > program needs.
> >
> > In that function, you could also search for 'DRM_MODE_TYPE_USERDEF'.
> > It's the mode that the user specified on the kernel command line. If
> > Chromium's automatic mode selection fails, you'd give your users direct
> > control over it.
>
> That doesn't really work for Chrome OS. Certainly a kernel hacker
> could do this, but it's not something I could imagine us exposing to
> an average user of a Chromebook.
>
>
> > When there's no flagged mode or if
> > /sys/class/drm/card<...>/status contains "unconnected", you can assume
> > that the modelist is artificial and try the modes in an appropriate ord=
er.
>
> So "no flagged" means that nothing is marked as preferred, correct?
>
> ...so I guess what you're suggesting is that the order that the kernel
> is presenting the modes to userspace is not ABI. If there are no
> preferred modes then userspace shouldn't necessarily assume that the
> first mode returned is the best mode. Instead it should assume that if
> there is no preferred mode then the mode list is made up and it should
> make its own decisions about the best mode to start with. If this is
> the ABI from the kernel then plausibly I could convince people to
> change userspace to pick 640x480 first in this case.
>
> > If we really want the kernel to give additional guarantees, we should
> > have a broader discussion about this topic IMHO.
>
> Sure. I've added St=C3=A9phane Marchesin to this thread in case he wants =
to
> chime in about anything.
>
> Overall, my take on the matter:
>
> * Mostly I got involved because, apparently, a DP compliance test was
> failing. The compliance test was upset that when it presented us with
> no EDID that we didn't default to 640x480. There was a push to make a
> fix for this in the Qualcomm specific driver but that didn't sit right
> with me.
>
> * On all devices I'm currently working with (laptops), the DP is a
> secondary display. If a user was trying to plug in a display with a
> bad EDID and the max mode (1024x768) didn't work, they could just use
> the primary display to choose a different resolution. It seems
> unlikely a user would truly be upset and would probably be happy they
> could get their broken display to work at all. Even if this is a
> primary display, I believe there are documented key combos to change
> the resolution of the primary display even if you can't see anything.
>
> * That all being said, defaulting to 640x480 when there's no EDID made
> sense to me, especially since it's actually defined in the DP spec. So
> I'm trying to do the right thing and solve this corner case. That
> being said, if it's truly controversial I can just drop it.
>
>
> So I guess my plan will be to give St=C3=A9phane a little while in case h=
e
> wants to chime in. If not then I guess I'll try a Chrome patch...
> ...and if that doesn't work, I'll just drop it.

OK, this userspace code seems to work:

https://crrev.com/c/3662501 - ozone/drm: Try 640x480 before picking
the first mode if no EDID

...so we'll see how review of that goes. :-)
