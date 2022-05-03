Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458EC51892A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbiECP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiECP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:57:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E133B2BA;
        Tue,  3 May 2022 08:54:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j8so15296548pll.11;
        Tue, 03 May 2022 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6MKZ6EdwZOffehvzKxtwmorygtElybKIQWosDARmac=;
        b=N9wn5tt042Vo6cF/rgCW+QiLyhKSHaRhaGnf/ly5tJzrALccDaY48Pj0CZQcA+XoTM
         t7Bta1Aox/z58eYkQy4R3M4vjuQd1RrX1oRwofU/CeGJ1oP/ZidYv2zQg43gPbfoYnf9
         QpANmnxjro+gjCJn7YaJMqXUNkFfVdaLyyfZHem4NmA/mD/uEOzaPLWAyQMDvgXoYfru
         nFsdRAh7bGHmDPuYe1pcJfWoDz4lELSkKdA02tAn8JQKpBFLM7PRETxc0V9X41d0vzkD
         S6kGFL0gPIVqKrpb6ciCqfsFzAGSewC4l4Hqly2b6FpsMJcKBb3iVSYmXJWtXWPNQyFl
         LSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6MKZ6EdwZOffehvzKxtwmorygtElybKIQWosDARmac=;
        b=RKlkKvIjesY4/w60cr95sZAAwb1u1JoGLZwc5NiS5Eq5j17s9FLeJ5kU1ETPm3YEmR
         0Sb3BgoyZNSrwu7EqA4a6aTnUNwd6AuI7JW0Na98TVlZv2ppRZJEKgq8KxY8C3SxGgOn
         tmAJwUl6wQoAyL5dAs/lX729V5ZHMfCd1CA9WZVIE054eU+txXcCuN7qAIXKrz9GH6oN
         Uznz1sdpvyJSyvRwRNVco1uZP6uitoskTCfmwbIlU0vk0mM2jX4WYMk8rY5q6Iu/cltK
         kUQ+pUhYVU11tGO0HFm/iGn2WvzjRtKPwY9TkTFKy1LSFbV5mSHYjZWpY8ReI20GaHSI
         QN9Q==
X-Gm-Message-State: AOAM530at+QVaTFb8Qa2TF+QpebFmsO+Kcsk1JXjlIUWHJuX4+85L6/u
        3Kxt0ibD1PUYOiLOBqSSMi08VAm3iOKrz3PeypI=
X-Google-Smtp-Source: ABdhPJxH2Zx9sWLWrIYKsCaXKwgvdgawQ08skaiwUhzBeEbbEJlNhkElWWFw4EqmfxQMYAQmKl9U7TSQsPYxgvJ+Kdc=
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id
 i7-20020a1709026ac700b0015024d6b2eemr17508346plt.168.1651593241176; Tue, 03
 May 2022 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org> <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org> <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org> <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
From:   =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Date:   Tue, 3 May 2022 17:53:50 +0200
Message-ID: <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     Doug Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 18:55, Doug Anderson <dianders@chromium.org> wrote:

> > Except shuffling the compatibles in bindings, you are changing the
> > meaning of final "google,lazor" compatible. The bootloader works as
> > expected - from most specific (rev5-sku6) to most generic compatible
> > (google,lazor) but why do you need to advertise the latest rev as
> > "google,lazor"? Why the bootloader on latest rev (e.g. rev7) cannot bind
> > to rev7 compatible?
>
> The problem really comes along when a board strapped as -rev8 comes
> along that is a board spin (and thus a new revision) but "should" be
> invisible to software. Since it should be invisible to software we
> want it to boot without any software changes. As per my previous mail,
> sometimes HW guys make these changes without first consulting software
> (since it's invisible to SW!) and we want to make sure that they're
> still going to strap as "-rev8".

If you want to boot it without any SW changes, do not change the SW.
Do not change the DTB. If you admit that you want to change DTB, so
the SW, sure, change it and accept the outcome - you have a new
compatible. This new compatible can be or might be not compatible with
rev7. Up to you.

>
> So what happens with this -rev8 board? The bootloader will check and
> it won't see any device tree that advertises "google,lazor-rev8",
> right?

Your bootloader looks for a specific rev8, which is not compatible
with rev7 (or is it? I lost the point of your example), and you ship
it with a DTB which has rev7, but not rev8. You control both pieces -
bootloader and DTB. You cannot put incompatible pieces of firmware
(one behaving entirely different than other) and expect proper output.
This is why you also have bindings.

> If _all_ lazor revisions all include the "google,lazor"
> compatible then the bootloader won't have any way to know which to
> pick. The bootloader _doesn't_ have the smarts to know that "-rev7" is
> closest to "-rev8".

rev7 the next in the compatible list, isn't it? So bootloader picks up
the fallback...

> It'll just randomly pick one of the "google,lazor"
> boards. :( This is why we only advertise "google,lazor" for the newest
> device tree.
>
> Yes, I agree it's not beautiful but it's what we ended up with. I
> don't think we want to compromise on the ability to boot new revisions
> without software changes because that will just incentivize people to
> not increment the board revision. The only other option would be to
> make the bootloader smart enough to pick the "next revision down" but
> so far they haven't been willing to do that.

Just choose the fallback and follow Devicetree spec...

> I guess the question, though, is what action should be taken. I guess
> options are:
>
> 1. Say that the above requirement that new "invisible" HW revs can
> boot w/ no software changes is not a worthy requirement. Personally, I
> wouldn't accept this option.
>
> 2. Ignore. Don't try to document top level compatible for these devices.
>
> 3. Document the compatible and accept that it's going to shuffle around a lot.
>
> 4. Try again to get the bootloader to match earlier revisions as fallbacks.
>
>
> > > Now we can certainly argue back and forth above the above scheme and
> > > how it's terrible and/or great, but it definitely works pretty well
> > > and it's what we've been doing for a while now. Before that we used to
> > > proactively add a whole bunch of "future" revisions "just in case".
> > > That was definitely worse and had the same problem that we'd have to
> > > shuffle compatibles. See, for instance `rk3288-veyron-jerry.dts`.
> > >
> > > One thing we _definitely_ don't want to do is to give HW _any_
> > > incentive to make board spins _without_ changing the revision. HW
> > > sometimes makes spins without first involving software and if it
> > > doesn't boot because they updated the board ID then someone in China
> > > will just put the old ID in and ship it off. That's bad.
> > >
> > > --
> > >
> > > But I guess this doesn't answer your question: how can userspace
> > > identify what board this is running? I don't have an answer to that,
> > > but I guess I'd say that the top-level "compatible" isn't really it.
> >
> > It can, the same as bootloader, by looking at the most specific
> > compatible (rev7).
> >
> > > If nothing else, I think just from the definition it's not guaranteed
> > > to be right, is it? From the spec: "Specifies a list of platform
> > > architectures with which this platform is compatible." The key thing
> > > is "a list". If this can be a list of things then how can you use it
> > > to uniquely identify what one board you're on?
> >
> > The most specific compatible identifies or, like recently Rob confirmed
> > in case of Renesas, the list of compatibles:
> > https://lore.kernel.org/linux-devicetree/Yk2%2F0Jf151gLuCGz@robh.at.kernel.org/
>
> I'm confused. If the device tree contains the compatibles:
>
> "google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7180"
>
> You want to know what board you're on and you look at the compatible,
> right? You'll decide that you're on a "google,lazor-rev4" which is the
> most specific compatible. ...but you could have booted a
> "google,lazor-rev3". How do you know?

Applying the wrong DTB on the wrong device will always give you the
wrong answer. You can try too boot google,lazor-rev3 on x86 PC and it
does not make it a google,lazor-rev3...

Best regards,
Krzysztof
