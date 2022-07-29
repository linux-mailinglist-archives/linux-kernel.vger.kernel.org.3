Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EB75851CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiG2Ouk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiG2Oui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:50:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C9550A5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:50:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z23so8940146eju.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g357UGRf0Iful4TOzguMzCzIJcq6XgTINqo6kA79z4o=;
        b=APHHgWYL3tgaUeSKYYhNcmwEqqgGv9WmoGy/seJ3KbfcSysjrKeQ7jz9d/y7CZxIzr
         KhHjx20mL8cZKbWP2mZjLD3QTqnnAeR7aOTWv0EZwaYVPOIVZT6fyxk3v2DryVWXoYJD
         hgOZY6cjz5nz2PmjMwGfgOJxaxyP0kNcvsQV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g357UGRf0Iful4TOzguMzCzIJcq6XgTINqo6kA79z4o=;
        b=rrFodwC2f+ewQOrsl1UXTQpJKkIwvybmzE2PRMUi/YDSn7YCY9XdjswOmfVXqu2D4D
         HCZHA9wK2wIr/MVYnS0CYwdmq7sapDU//wGYl7UNUJByMJg0rxL8hx0b6Hm7nixXqikf
         qVEiBlbz0mMakj6lKk9RLvBNlur9sX3NAcAmvadjufX0RvOTQvz7eCw2R6Gdzm8yHJ3T
         1AU+Gt/I0l3XlLUrrzjdiblBmP4GNIzsAdWusxo/AAR5sWx49GwamdUuTo36j3x2jaRr
         X6jmY5Oh+qMNa7IGyZT5iq7VgEUl6DaRznz4gNLJB6lM5n0ol1fI1hXSju/gxl5mYUBZ
         ktkw==
X-Gm-Message-State: AJIora9f8RNDzv8wuwAoPklzs2GmTyHqKk9QDiFfaWpeSmKSEaV5hJOQ
        Vg8aSA2WvsNVJau5ICnQJOzlA0M6Lu+Mwhstl00=
X-Google-Smtp-Source: AGRyM1tFNXkmlZ0b9YXNOBJ3TqOHOQxo0a5VwE37nWc4B4f34Ksc90IeiyWuNU2cix2oSeBHgFGVmw==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr3205925ejc.762.1659106235509;
        Fri, 29 Jul 2022 07:50:35 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id f5-20020a056402160500b0043cd06bef33sm2418344edv.97.2022.07.29.07.50.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 07:50:34 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id b26so6316877wrc.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:50:34 -0700 (PDT)
X-Received: by 2002:a05:6000:178f:b0:21e:98ee:f1e6 with SMTP id
 e15-20020a056000178f00b0021e98eef1e6mr2691892wrg.405.1659106233759; Fri, 29
 Jul 2022 07:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220721152314.RFC.1.Ie333b3e4aff6e4a5b58c4aa805e030e561be8773@changeid>
 <269f2610-425b-f296-dcfc-89bdc2e1d587@quicinc.com> <CAD=FV=XSVXasU5PMR2kL0WQjQ458xDePuTGd1m14_v9JO5B6oA@mail.gmail.com>
 <CAF6AEGv_Vikf80v-7ccz90fvGPrk5pV1tOxRoWKxKHYuEW8=aA@mail.gmail.com>
 <5c8ca71c-5f0b-d5f5-9f16-e312dec0d01b@quicinc.com> <CAD=FV=UGYV1mZenDCRrbpC+gpE12-Uis7fm_=H3PeEjK=t36yA@mail.gmail.com>
 <20220729075118.ofnpk52tk4usm3n3@penduick>
In-Reply-To: <20220729075118.ofnpk52tk4usm3n3@penduick>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Jul 2022 07:50:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUB68-DQ-pAFjGaG-kid33ve4Qc3iqb8OUh61xTBohmg@mail.gmail.com>
Message-ID: <CAD=FV=WUB68-DQ-pAFjGaG-kid33ve4Qc3iqb8OUh61xTBohmg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/edid: Make 144 Hz not preferred on Sharp LQ140M1JW46
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 29, 2022 at 12:51 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Thu, Jul 28, 2022 at 02:18:38PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jul 28, 2022 at 10:34 AM Abhinav Kumar
> > <quic_abhinavk@quicinc.com> wrote:
> > >
> > > Hi Rob and Doug
> > >
> > > On 7/22/2022 10:36 AM, Rob Clark wrote:
> > > > On Fri, Jul 22, 2022 at 9:48 AM Doug Anderson <dianders@chromium.org> wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> On Fri, Jul 22, 2022 at 9:37 AM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > > >>>
> > > >>> + sankeerth
> > > >>>
> > > >>> Hi Doug
> > > >>>
> > > >>> On 7/21/2022 3:23 PM, Douglas Anderson wrote:
> > > >>>> The Sharp LQ140M1JW46 panel is on the Qualcomm sc7280 CRD reference
> > > >>>> board. This panel supports 144 Hz and 60 Hz. In the EDID, the 144 Hz
> > > >>>> mode is listed first and thus is marked preferred. The EDID decode I
> > > >>>> ran says:
> > > >>>>
> > > >>>>     First detailed timing includes the native pixel format and preferred
> > > >>>>     refresh rate.
> > > >>>>
> > > >>>>     ...
> > > >>>>
> > > >>>>     Detailed Timing Descriptors:
> > > >>>>       DTD 1:  1920x1080  143.981 Hz  16:9   166.587 kHz  346.500 MHz
> > > >>>>                    Hfront   48 Hsync  32 Hback  80 Hpol N
> > > >>>>                    Vfront    3 Vsync   5 Vback  69 Vpol N
> > > >>>>       DTD 2:  1920x1080   59.990 Hz  16:9    69.409 kHz  144.370 MHz
> > > >>>>                    Hfront   48 Hsync  32 Hback  80 Hpol N
> > > >>>>                    Vfront    3 Vsync   5 Vback  69 Vpol N
> > > >>>>
> > > >>>> I'm proposing here that the above is actually a bug and that the 60 Hz
> > > >>>> mode really should be considered preferred by Linux.
> > >
> > > Its a bit tricky to say that this is a bug but I think we can certainly
> > > add here that for an internal display we would have ideally had the
> > > lower resolution first to indicate it as default.
> >
> > Yeah, it gets into the vagueness of the EDID spec in general. As far
> > as I can find it's really up to the monitor to decide by what means it
> > chooses the "preferred" refresh rate if the monitor can support many.
> > Some displays may decide that the normal rate is "preferred" and some
> > may decide that the high refresh rate is "preferred". Neither display
> > is "wrong" per say, but it's nice to have some consistency here and to
> > make it so that otherwise "dumb" userspace will get something
> > reasonable by default. I'll change it to say:
> >
> > While the EDID spec appears to allow a display to use any criteria for
> > picking which refresh mode is "preferred" or "optimal", that vagueness
> > is a bit annoying. From Linux's point of view let's choose the 60 Hz
> > one as the default.
>
> And if we start making that decision, it should be for all panels with a
> similar constraint, so most likely handled by the core, and the new
> policy properly documented.
>
> Doing that just for a single panel is weird.

Yeah, though having a "general policy" in the core can be problematic.

In general I think panel EDIDs are only trustworthy as far as you can
throw them. They are notorious for having wrong and incorrect
information, which is why the EDID quirk list exists to begin with.
Trying to change how we're going to interpret all EDIDs, even all
EDIDs for eDP panels, seems like it will break someone somewhere.
Maybe there are EDIDs out there that were only ever validated at the
higher refresh rate and they don't work / flicker / cause digitizer
noise at the lower refresh rate. Heck, we've seen eDP panel vendors
that can't even get their checksum correct, so I'm not sure I want to
make a global assertion that all panels validated their "secondary"
display mode.

In this particular case, we have validated that this particular Sharp
panel works fine at the lower refresh rate.

I would also note that, as far as I understand it, ODMs actually can
request different EDIDs from the panel vendors. In the past we have
been able to get panel vendors to change EDIDs. Thus for most panels
I'd expect that we would discover this early, change the EDID default,
and be done with it. The case here is a little unusual in that by the
time we got involved and started digging into this panel too many were
created and nobody wants to throw away those old panels. This is why
I'm treating it as a quirk/bug. Really: we should have updated the
EDID of the panel but we're unable to in this case.

-Doug
