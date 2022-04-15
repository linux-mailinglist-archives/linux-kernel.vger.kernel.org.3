Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69116503085
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiDOWrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDOWra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:47:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4290A3A5F5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:45:00 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id h8so16482027ybj.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1FL2N+vbxbnFM4V9Gp8h4r8ZEbQ6gNAmnc+BbEJA0M=;
        b=wQ6ryNU2t32Z7XVkKnortBSO1vhP4kNPzE0wqr1RTT36Eri4XnOpb/3V6ixh/8vGAs
         Z+nJYq1++Fh1TKaMJpA5wDoyoxeS5Rkn/VjHRPMPneKdBztWu9M+2YMaIMv/tsvX3CyF
         rHn3b8miFRaLQ7uHjvvU8P4Dd0l8whW3Ztz7odKEr7rXUovyybYAY6XgYaZX3wZN4iJ1
         pcRhHMwSRmTw9M2cFkAypPhNtMK9vG67z4EDS7Axx5q23QNG3WPbUpVQY5A4YWI3loUY
         lFD1LZ6dPA1G+Y8Twg+dr21cvKs/pm4X+vuxEh+9j10TDmCaeWYCM5yqjlj4dP8GyDXT
         dqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1FL2N+vbxbnFM4V9Gp8h4r8ZEbQ6gNAmnc+BbEJA0M=;
        b=5qshpnQ2jS+34gJ+kJRC7u5TiVvh1Jb86VK1iXyyDNtRoiG3taOLQoeHjuWPSWyOxZ
         +aEjh1ZloS1OMmyLq6tsxyozfORvj0p0sS62p7UEiSNNKJIkKoKuzjYi1x/NFaX/dSWO
         XFixh9mV0zA9hC0GC/7bL+8s7c6RqHucPg7qp7894bo7enBLOkViTitIRAN4C4mFSEs3
         1itzFr1oT/dsrNq3vP+tOaN2iCxxUAZQhWg7IZ0D5svY6/DVDbxA4VhVRrtyF3ZQXA3X
         6wp3UI59Fh+C6u1kV4B3vwTRzuJWIZCCbkrqwoGG1QPiZGhHO2U/+3fG7OamOp2nSGBW
         YXvQ==
X-Gm-Message-State: AOAM533eDOuk2zCtRZrRN1VmYX5sIgWMPam9B1o0GlFL/lewmVciIloO
        X9XlQkniWGc3A7iuurxyUB42eEH7HDGDP8ujFenpzA==
X-Google-Smtp-Source: ABdhPJy35MhSB4tYtvcOuTbUp29+uEFCnZ1T6ERCQSrsGRd9Y5mM+nyuh0bC2y9uq7UVSixNrsvJ7kZrYHNQDG0Qtjs=
X-Received: by 2002:a05:6902:d:b0:629:213c:4937 with SMTP id
 l13-20020a056902000d00b00629213c4937mr1204331ybh.66.1650062699443; Fri, 15
 Apr 2022 15:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.1.I4182ae27e00792842cb86f1433990a0ef9c0a073@changeid>
 <a9a5dfb7-819b-d3a2-2c47-d5b239d21ad3@linaro.org> <CAD=FV=WKwErpD7iCu+2jFvMutmmmgLUEhAnw8s=27wUxcpF-aQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WKwErpD7iCu+2jFvMutmmmgLUEhAnw8s=27wUxcpF-aQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Apr 2022 01:44:48 +0300
Message-ID: <CAA8EJppOVqaAEVeQY7p0EfCObJxfL591kbaYLYfbgOHHtmfhXw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] drm/dp: Helpers to make it easier for drivers to
 use DP AUX bus properly
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2022 at 00:13, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 14, 2022 at 5:47 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 09/04/2022 05:36, Douglas Anderson wrote:
> > > As talked about in the kerneldoc for "struct dp_aux_ep_client" in this
> > > patch and also in the past in commit a1e3667a9835 ("drm/bridge:
> > > ti-sn65dsi86: Promote the AUX channel to its own sub-dev"), to use the
> > > DP AUX bus properly we really need two "struct device"s. One "struct
> > > device" is in charge of providing the DP AUX bus and the other is
> > > where we'll try to get a reference to the newly probed endpoint
> > > devices.
> > >
> > > In ti-sn65dsi86 this wasn't too difficult to accomplish. That driver
> > > is already broken up into several "struct devices" anyway because it
> > > also provides a PWM and some GPIOs. Adding one more wasn't that
> > > difficult / ugly.
> > >
> > > When I tried to do the same solution in parade-ps8640, it felt like I
> > > was copying too much boilerplate code. I made the realization that I
> > > didn't _really_ need a separate "driver" for each person that wanted
> > > to do the same thing. By putting all the "driver" related code in a
> > > common place then we could save a bit of hassle. This change
> > > effectively adds a new "ep_client" driver that can be used by
> > > anyone. The devices instantiated by this driver will just call through
> > > to the probe/remove/shutdown calls provided.
> > >
> > > At the moment, the "ep_client" driver is backed by the Linux auxiliary
> > > bus (unfortunate naming--this has nothing to do with DP AUX). I didn't
> > > want to expose this to clients, though, so as far as clients are
> > > concerned they get a vanilla "struct device".
> >
> > I have been thinking about your approach for quite some time. I think
> > that enforcing a use of auxilliary device is an overkill. What do we
> > really need is the the set callbacks in the bus struct or a notifier. We
> > have to notify the aux_bus controller side that the client has been
> > probed successfully or that the client is going to be removed.
>
> It seems like these new callbacks would be nearly the same as the
> probe/remove callbacks in my proposal except:
>
> * They rely on there being exactly 1 AUX device, or we make it a rule
> that we wait for all AUX devices to probe (?)

Is the backlight a separate device on an AUX bus? Judging from
drm_panel_dp_aux_backlight(), it isn't. I assumed that aux bus is just
a point-to-point bus, so there is always a single client.

>
> * We need to come up with a system for detecting when everything
> probes or is going to be removed, though that's probably not too hard.
> I guess the DP AUX bus could just replace the panel's probe function
> with its own and essentially "tail patch" it. I guess it could "head
> patch" the remove call? ...or is there some better way you were
> thinking of knowing when all our children probed?
>
> * The callback on the aux bus controller side would not be able to
> DEFER. In other words trying to acquire a reference to the panel can
> always be the last thing we do so we know there can be no reasons to
> defer after. This should be doable, but at least in the ps8640 case it
> will require changing the code a bit. I notice that today it actually
> tries to get the panel side _before_ it gets the MIPI side and it
> potentially can return -EPROBE_DEFER if it can't find the MIPI side. I
> guess I have a niggling feeling that we'll find some reason in the
> future that we can't be last, but we can probably ignore that. ;-)
>
> I can switch this all to normal callbacks if that's what everyone
> wants, but it doesn't feel significantly cleaner to me and does seem
> to have some (small) downsides.
>
>
> > And this
> > approach would make driver's life easier, since e.g. the bus code can
> > pm_get the EP device before calling callbacks/notifiers and
> > pm_put_autosuspend it afterwards.
>
> Not sure about doing the pm calls on behalf of the EP device. What's
> the goal there?

I think any driver can pm_runtime_get another device. The goal is to
let the 'post_probe' callback to power up the panel, read the EDID,
etc.

BTW: as I'm slowly diving into DP vs eDP differences. Do we need to
write the EDID checksum like we do for DP?
Do you have any good summary for eDP vs DP differences?

-- 
With best wishes
Dmitry
