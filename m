Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB6F518973
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiECQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiECQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:17:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC735DF5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:13:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh6so34475124ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Ix4flC8Lt3S4LnOPEHPllIKGgAhWjlUsKL1j7FHpiA=;
        b=TiIgOs8E9eUtJtPgW7RvVvjvQUD+arFYWw9VJ7yG42lh0uXjsFc2qQHnw1+SKnesT4
         QxmO1Bd6Ztk+nlweneKQQuvWpjUXJHw7M/kIi/D2NRK4dmWn2XVXb/eCq9ckNxGMN6bX
         b82uUlY+TPqCznXNXmO5xYHktW47VgLFdc1JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Ix4flC8Lt3S4LnOPEHPllIKGgAhWjlUsKL1j7FHpiA=;
        b=6ImBhHMuNOLzXfSZFX5Vodnb07/PRNEi9AbmFWs52xzzHi80pw/IvWv9mC3SHl2ljU
         HqIpoUM6Qj7dCxzTQExrgkzwV8W4PoSnlhN7EoUiJ7aszrPhiVXF4rsvAlQxqOe+HWcP
         kXKL4eTvdUCDxm37Gp3fn3A+F/+30dLFivO+iVuEwO4TkSCZA+8ZJhXDnxjOgXmUq3aH
         ubkyJovy7Nv859WQNFt6atfiaA2JIe67hPW3aKKTDyAqJIi5SP8+fINCF9lbcnvSudTE
         nHpbdlqhwVEjub9NJVQkcGqSeW1mScZAkhKMFu6E8mE3rDR6sOaTNlFRDkTdj91dJ/6Z
         gxqQ==
X-Gm-Message-State: AOAM533rgHuG6RMNMD75JNvLjphWmMtrnRNZXwreNkolZd+n7g51o6sE
        racjhJhNN4hJXORkqXblDd6Hm6otGzau8Pvy
X-Google-Smtp-Source: ABdhPJxaX5WT9fsRehH/+egBclchdNWS+WkN5ajtZJaOnKtRIRJO3wHmCiNhAjy/NRpK/EaksegNuw==
X-Received: by 2002:a17:907:9705:b0:6f0:2b25:784e with SMTP id jg5-20020a170907970500b006f02b25784emr16325456ejc.76.1651594403564;
        Tue, 03 May 2022 09:13:23 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006f3ef214e19sm4752558ejc.127.2022.05.03.09.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:13:22 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i5so24020096wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:13:21 -0700 (PDT)
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id
 t8-20020a5d42c8000000b0020ad91f87b5mr13504406wrr.301.1651594401230; Tue, 03
 May 2022 09:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org> <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org> <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org> <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
 <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
In-Reply-To: <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 May 2022 09:13:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com>
Message-ID: <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
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

On Tue, May 3, 2022 at 8:54 AM Krzysztof Koz=C5=82owski
<k.kozlowski.k@gmail.com> wrote:
>
> On Tue, 19 Apr 2022 at 18:55, Doug Anderson <dianders@chromium.org> wrote=
:
>
> > > Except shuffling the compatibles in bindings, you are changing the
> > > meaning of final "google,lazor" compatible. The bootloader works as
> > > expected - from most specific (rev5-sku6) to most generic compatible
> > > (google,lazor) but why do you need to advertise the latest rev as
> > > "google,lazor"? Why the bootloader on latest rev (e.g. rev7) cannot b=
ind
> > > to rev7 compatible?
> >
> > The problem really comes along when a board strapped as -rev8 comes
> > along that is a board spin (and thus a new revision) but "should" be
> > invisible to software. Since it should be invisible to software we
> > want it to boot without any software changes. As per my previous mail,
> > sometimes HW guys make these changes without first consulting software
> > (since it's invisible to SW!) and we want to make sure that they're
> > still going to strap as "-rev8".
>
> If you want to boot it without any SW changes, do not change the SW.
> Do not change the DTB. If you admit that you want to change DTB, so
> the SW, sure, change it and accept the outcome - you have a new
> compatible. This new compatible can be or might be not compatible with
> rev7. Up to you.
>
> >
> > So what happens with this -rev8 board? The bootloader will check and
> > it won't see any device tree that advertises "google,lazor-rev8",
> > right?
>
> Your bootloader looks for a specific rev8, which is not compatible
> with rev7 (or is it? I lost the point of your example)

Actually the whole point is that _we don't know_ if -rev7 and -rev8
are compatible.

Think of it this way. You've got component A on your board and you
power it up with 1.8 V. We run out of component A and we decide to
replace it with component B. The vendor promises that component B is a
drop-in replacement for component A. You boot up a few devices with
component B and everything looks good. You build a whole lot of
products.

Sometime down the line you start getting failure reports. It turns out
that products that have component B are sporadically failing in the
field. After talking to the vendor, they suggest that we need to power
component B with 1.85 V instead of 1.80 V. Luckily we can adjust the
voltage with the PMIC, but component A's vendor doesn't want you to
bump the voltage up to 1.85V.

Even though we originally thought that the two boards were 100%
compatible, it later turns out that they're not.

So as a general principle, if we make big changes to a product we
increment the board revision strappings even if we think it's
invisible to software. This can help us get out of sticky situations
in the future.


> and you ship
> it with a DTB which has rev7, but not rev8. You control both pieces -
> bootloader and DTB. You cannot put incompatible pieces of firmware
> (one behaving entirely different than other) and expect proper output.
> This is why you also have bindings.

...and by "you" in "*you* control both pieces" you mean some
collection of people spread across several companies and several
countries and who don't always communicate well with each other. If
they believe that a change should be invisible to software, folks
building the hardware in China don't always send me a heads up in
California, but I still want them to bump the revision number just in
case they messed up and we do need a software change down the road.


> > If _all_ lazor revisions all include the "google,lazor"
> > compatible then the bootloader won't have any way to know which to
> > pick. The bootloader _doesn't_ have the smarts to know that "-rev7" is
> > closest to "-rev8".
>
> rev7 the next in the compatible list, isn't it? So bootloader picks up
> the fallback...

No. The bootloader works like this (just looking at the revision
strappings and ignoring the SKU strappings):

1. Read board strappings and get and ID (like "8")

2. Look for "google,lazor-rev8".

3. If it's not there, look for "google,lazor"

4. If it's not there then that's bad.

...so "-rev7" is _not_ in the compatible list for "-rev8".


> > It'll just randomly pick one of the "google,lazor"
> > boards. :( This is why we only advertise "google,lazor" for the newest
> > device tree.
> >
> > Yes, I agree it's not beautiful but it's what we ended up with. I
> > don't think we want to compromise on the ability to boot new revisions
> > without software changes because that will just incentivize people to
> > not increment the board revision. The only other option would be to
> > make the bootloader smart enough to pick the "next revision down" but
> > so far they haven't been willing to do that.
>
> Just choose the fallback and follow Devicetree spec...

It does choose the fallback and follow the devicetree spec, but the
bootloader doesn't have rules to consider "-rev7" as a fallback for
"-rev8".


> > I guess the question, though, is what action should be taken. I guess
> > options are:
> >
> > 1. Say that the above requirement that new "invisible" HW revs can
> > boot w/ no software changes is not a worthy requirement. Personally, I
> > wouldn't accept this option.
> >
> > 2. Ignore. Don't try to document top level compatible for these devices=
.
> >
> > 3. Document the compatible and accept that it's going to shuffle around=
 a lot.
> >
> > 4. Try again to get the bootloader to match earlier revisions as fallba=
cks.
> >
> >
> > > > Now we can certainly argue back and forth above the above scheme an=
d
> > > > how it's terrible and/or great, but it definitely works pretty well
> > > > and it's what we've been doing for a while now. Before that we used=
 to
> > > > proactively add a whole bunch of "future" revisions "just in case".
> > > > That was definitely worse and had the same problem that we'd have t=
o
> > > > shuffle compatibles. See, for instance `rk3288-veyron-jerry.dts`.
> > > >
> > > > One thing we _definitely_ don't want to do is to give HW _any_
> > > > incentive to make board spins _without_ changing the revision. HW
> > > > sometimes makes spins without first involving software and if it
> > > > doesn't boot because they updated the board ID then someone in Chin=
a
> > > > will just put the old ID in and ship it off. That's bad.
> > > >
> > > > --
> > > >
> > > > But I guess this doesn't answer your question: how can userspace
> > > > identify what board this is running? I don't have an answer to that=
,
> > > > but I guess I'd say that the top-level "compatible" isn't really it=
.
> > >
> > > It can, the same as bootloader, by looking at the most specific
> > > compatible (rev7).
> > >
> > > > If nothing else, I think just from the definition it's not guarante=
ed
> > > > to be right, is it? From the spec: "Specifies a list of platform
> > > > architectures with which this platform is compatible." The key thin=
g
> > > > is "a list". If this can be a list of things then how can you use i=
t
> > > > to uniquely identify what one board you're on?
> > >
> > > The most specific compatible identifies or, like recently Rob confirm=
ed
> > > in case of Renesas, the list of compatibles:
> > > https://lore.kernel.org/linux-devicetree/Yk2%2F0Jf151gLuCGz@robh.at.k=
ernel.org/
> >
> > I'm confused. If the device tree contains the compatibles:
> >
> > "google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7=
180"
> >
> > You want to know what board you're on and you look at the compatible,
> > right? You'll decide that you're on a "google,lazor-rev4" which is the
> > most specific compatible. ...but you could have booted a
> > "google,lazor-rev3". How do you know?
>
> Applying the wrong DTB on the wrong device will always give you the
> wrong answer. You can try too boot google,lazor-rev3 on x86 PC and it
> does not make it a google,lazor-rev3...

I don't understand what you're saying here. If a device tree has the compat=
ible:

"google,lazor-rev4", "google,lazor-rev3", "google,lazor", "qualcomm,sc7180"

You wouldn't expect to boot it on an x86 PC, but you would expect to
boot it on either a "google,lazor-rev4" _or_ a "google,lazor-rev3".
Correct? Now, after we've booted software wants to look at the
compatible of the device tree that was booted. The most specific entry
in that device tree is "google,lazor-rev4". ...but we could have
booted it on a "google,lazor-rev3". How can you know?

-Doug
