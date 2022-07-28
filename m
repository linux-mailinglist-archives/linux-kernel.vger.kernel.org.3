Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5B4584797
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiG1VTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiG1VS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:18:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE214F1A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:18:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v17so3721262edc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iyWCACEtC3V1/iSrvN7QORzRaYA0n5oxtpPIEK5JvoY=;
        b=hojvuCIi/iO1jzC4b5F+GmGDTGC2yye7iwBOOzqvwXV5B9awqbtFx+l5y9sEpVYvVb
         MKTJQFlSC6egSjsxyBPPsUi8SXkfkGpO7D0i0SG6bCx2pjNO7p+/kbAYFHVuceQ4QrRV
         eOzWRd2+QQ/db5vE+TUfBHOTFgrYR/+XBFm/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iyWCACEtC3V1/iSrvN7QORzRaYA0n5oxtpPIEK5JvoY=;
        b=xqkawXbH/tkiPns6Xz/UoeZIk7zTJ+MZXsk5v/8xO0EV9RtX4znRf+BvWqn/W4i01j
         isA4cvD3hTd5KEYSgEGnG348KpdhHVy3MWRelm2bbG9dJGMMwOrUE6+8Doxl1/agw5bE
         6YD9DIfqzMzMpSh59N0zg69S2Jwbt0G10QkOmkJpgsJfYHXr5jMINM7esOaC1VdbUPS7
         KPLQN4MACrmRIbzFqMV99mV6F8HGCNCwbIXR6kT8BikqBssVGxbRpGBvlGpN844vi5KL
         yu/tRCIauSGGezvGByfgVxTRrrNZVFesQK+JC5M/gVZLHM3wfIrj3fLyRTsYxpqd1jY1
         N9kw==
X-Gm-Message-State: AJIora/WzcA4Oc8xYy+ewMgglfFmDl33nhphkdlZqKs4+qe4j7Okxv3S
        Qoeo+GNW8eji/5YG2L1Z494v9eErzrNZQK9o
X-Google-Smtp-Source: AGRyM1sktl0v3OfWeM5DHPMZPsK8Q6DVhT+tSWMy4U/iLbMSy2o3hI6eg4LLKmRvU9UDznbVYO0hcA==
X-Received: by 2002:a05:6402:5412:b0:435:5997:ccb5 with SMTP id ev18-20020a056402541200b004355997ccb5mr758195edb.167.1659043133368;
        Thu, 28 Jul 2022 14:18:53 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d986000000b0043bb8023caesm1292124eds.62.2022.07.28.14.18.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 14:18:52 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id a18-20020a05600c349200b003a30de68697so3828539wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:18:51 -0700 (PDT)
X-Received: by 2002:a05:600c:5114:b0:3a3:3f7f:27ec with SMTP id
 o20-20020a05600c511400b003a33f7f27ecmr406453wms.93.1659043131573; Thu, 28 Jul
 2022 14:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220721152314.RFC.1.Ie333b3e4aff6e4a5b58c4aa805e030e561be8773@changeid>
 <269f2610-425b-f296-dcfc-89bdc2e1d587@quicinc.com> <CAD=FV=XSVXasU5PMR2kL0WQjQ458xDePuTGd1m14_v9JO5B6oA@mail.gmail.com>
 <CAF6AEGv_Vikf80v-7ccz90fvGPrk5pV1tOxRoWKxKHYuEW8=aA@mail.gmail.com> <5c8ca71c-5f0b-d5f5-9f16-e312dec0d01b@quicinc.com>
In-Reply-To: <5c8ca71c-5f0b-d5f5-9f16-e312dec0d01b@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 14:18:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGYV1mZenDCRrbpC+gpE12-Uis7fm_=H3PeEjK=t36yA@mail.gmail.com>
Message-ID: <CAD=FV=UGYV1mZenDCRrbpC+gpE12-Uis7fm_=H3PeEjK=t36yA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/edid: Make 144 Hz not preferred on Sharp LQ140M1JW46
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 10:34 AM Abhinav Kumar
<quic_abhinavk@quicinc.com> wrote:
>
> Hi Rob and Doug
>
> On 7/22/2022 10:36 AM, Rob Clark wrote:
> > On Fri, Jul 22, 2022 at 9:48 AM Doug Anderson <dianders@chromium.org> wrote:
> >>
> >> Hi,
> >>
> >> On Fri, Jul 22, 2022 at 9:37 AM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>
> >>> + sankeerth
> >>>
> >>> Hi Doug
> >>>
> >>> On 7/21/2022 3:23 PM, Douglas Anderson wrote:
> >>>> The Sharp LQ140M1JW46 panel is on the Qualcomm sc7280 CRD reference
> >>>> board. This panel supports 144 Hz and 60 Hz. In the EDID, the 144 Hz
> >>>> mode is listed first and thus is marked preferred. The EDID decode I
> >>>> ran says:
> >>>>
> >>>>     First detailed timing includes the native pixel format and preferred
> >>>>     refresh rate.
> >>>>
> >>>>     ...
> >>>>
> >>>>     Detailed Timing Descriptors:
> >>>>       DTD 1:  1920x1080  143.981 Hz  16:9   166.587 kHz  346.500 MHz
> >>>>                    Hfront   48 Hsync  32 Hback  80 Hpol N
> >>>>                    Vfront    3 Vsync   5 Vback  69 Vpol N
> >>>>       DTD 2:  1920x1080   59.990 Hz  16:9    69.409 kHz  144.370 MHz
> >>>>                    Hfront   48 Hsync  32 Hback  80 Hpol N
> >>>>                    Vfront    3 Vsync   5 Vback  69 Vpol N
> >>>>
> >>>> I'm proposing here that the above is actually a bug and that the 60 Hz
> >>>> mode really should be considered preferred by Linux.
>
> Its a bit tricky to say that this is a bug but I think we can certainly
> add here that for an internal display we would have ideally had the
> lower resolution first to indicate it as default.

Yeah, it gets into the vagueness of the EDID spec in general. As far
as I can find it's really up to the monitor to decide by what means it
chooses the "preferred" refresh rate if the monitor can support many.
Some displays may decide that the normal rate is "preferred" and some
may decide that the high refresh rate is "preferred". Neither display
is "wrong" per say, but it's nice to have some consistency here and to
make it so that otherwise "dumb" userspace will get something
reasonable by default. I'll change it to say:

While the EDID spec appears to allow a display to use any criteria for
picking which refresh mode is "preferred" or "optimal", that vagueness
is a bit annoying. From Linux's point of view let's choose the 60 Hz
one as the default.


> >>>> The argument here is that this is a laptop panel and on a laptop we
> >>>> know power will always be a concern. Presumably even if someone using
> >>>> this panel wanted to use 144 Hz for some use cases they would only do
> >>>> so dynamically and would still want the default to be 60 Hz.
> >>>>
> >>>> Let's change the default to 60 Hz using a standard quirk.
> >>>>
> >>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>
> >>> Yes, we were aware that 144Hz was getting picked. We found that while
> >>> debugging the screen corruption issue.
> >>>
> >>> Well, yes power would be less with 60Hz but so will be the performance.
> >>
> >> What performance specifically will be less with 60 Hz? In general the
> >> sc7280 CPU is a bit memory-bandwidth constrained and the LCD refresh
> >> from memory is a non-trivial part of that. Reducing to 60 Hz will
> >> relieve some of the memory bandwidth pressure and will actually allow
> >> tasks on the CPU to run _faster_. I guess the downside is that some
> >> animations might be a little less smooth...
> >
> > I guess he is referring to something that is vblank sync'd running
> > faster than 60fps.
> >
> > but OTOH it is a bit of a waste for fbcon to be using 144Hz.  And
> > there are enough android games that limit themselves to 30fps to save
> > your "phone" battery.  So it seems a lot more sane to default to 60Hz
> > and let userspace that knows it wants more pick the 144Hz rate when
> > needed.
> >
> > BR,
> > -R
>
> Yes i was referring to vblank synced apps.
>
> >
> >>
> >>
> >>> The test teams have been validating with 144Hz so far so we are checking
> >>> internally with the team whether its OKAY to goto 60Hz now since that
> >>> kind of invalidates the testing they have been doing.
> >>
> >> You're worried that the panel itself won't work well at 60 Hz, or
> >> something else about the system won't? The whole system in general
> >> needs to work well with 60 Hz displays and I expect them to be much
> >> more common than 144 Hz displays. Quite honestly if switching to 60 Hz
> >> uncovers a problem that would be a huge benefit of landing this patch
> >> because it would mean we'd find it now rather than down the road when
> >> someone hooks up a different panel.
>
> I was worried that it will invalidate the testing they did so far but
> since you have confirmed that you would prefer 60Hz to be more
> thoroughly tested than 144Hz, I have informed the internal teams of this
> change and given the heads up.
>
> You can have my R-b for this change,
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
> I would also wait to see if others have different thought about this.

Thanks! I'll probably wait another week or so then I'll land in
drm-misc-next with your tag.

-Doug
