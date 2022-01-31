Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26A4A4C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380644AbiAaQvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380622AbiAaQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:51:07 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C97AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:51:07 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z18so3136048ilp.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoJBR2UAHuZ27nnY7SUfUkCqFdZWcHemP7QDz7/AXSA=;
        b=EIzWMoBbBvH13FGod+pwqX1OF+cE3PacbCpDfqOmTlNJJbsSanl6RvXlQkO8wK5GcB
         7yIDXpYgkIK9uxGQHVBrnRpE4eA+EFn5edIeggvXvS9jF6R7H8xhI9/AuweD9E4zA7nG
         UwC5RMM7yacKTGnTPSfMdbG4dBLkxpGqyPkrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoJBR2UAHuZ27nnY7SUfUkCqFdZWcHemP7QDz7/AXSA=;
        b=LnqWjzowQoQY4rcNPCfBm9dGAMG3TmOUXToYnG0Cwr1aQyhkEfDFSBNr8Rnu9LSaAu
         5MhY0NAPyzjEcGWaLvbHLdoe+D01bOgs1un/1eMUKcOFr1AQmqE/ca5d7/2MS9XOjJ6T
         29ReH/xJxyBrEWWU36HUnbDcBdZFnj7pK+OhPln80ozJ5GKoEbgS/SebVjPwhFKz0VR2
         dSGIgQgr0SSIbC9U3RxT3rRnMwmifeaXPDjtMk7nTCklClDYLxT+YtwVhhX/ZYDoa8sw
         aooBBtXDZXGYzRQlq7h3XmCnOJosoCmT6ZrR+jrE5VwIcgdw5WFg0BPnPtp7QCCuruCQ
         uLQA==
X-Gm-Message-State: AOAM532ndD1qSeVfbXCB02qCujPhF6mwW1k8nqIMjXEvuRnnU9kQQRDi
        HpTMx2VMqtd08rXbFNrJ4Hvt75Stf9rUMg==
X-Google-Smtp-Source: ABdhPJwvALBfa7cv2qQZ3Xxg4FrH/BJdWKAAtysG1tCbHh1f84Ml9VM9VB7Mo+UtIrJRqy0bZvfOKw==
X-Received: by 2002:a92:3f0f:: with SMTP id m15mr12967253ila.112.1643647866243;
        Mon, 31 Jan 2022 08:51:06 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id e5sm17978513ilq.9.2022.01.31.08.51.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:51:05 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id d3so11904255ilr.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:51:04 -0800 (PST)
X-Received: by 2002:a92:cd84:: with SMTP id r4mr13019803ilb.180.1643647864404;
 Mon, 31 Jan 2022 08:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.5.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
 <CAE-0n528Bxdj+DKhi2Lan4qR_=4KHD7A1Zkr15tmu+MchryJ1A@mail.gmail.com>
 <CAD=FV=UcpKaLQ31CGKUnaNnZcYnM4N_t8VC43FPGktoYDiMfsw@mail.gmail.com>
 <YfC5i2jR5N+pmHoZ@ripper> <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
 <YfgRS/UtRn6Ewwhj@builder.lan>
In-Reply-To: <YfgRS/UtRn6Ewwhj@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 31 Jan 2022 08:50:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V=pbmP-wKhAOVRBC0M=YjYm3Ym-022g8uBEZOxKW-8BQ@mail.gmail.com>
Message-ID: <CAD=FV=V=pbmP-wKhAOVRBC0M=YjYm3Ym-022g8uBEZOxKW-8BQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sc7280: Add herobrine-r1
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kgodara@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        quic_rjendra@quicinc.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 31, 2022 at 8:41 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 27 Jan 15:16 CST 2022, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2022-01-25 19:01:31)
> > > On Tue 25 Jan 15:46 PST 2022, Doug Anderson wrote:
> > >
> > > > Hi,
> > > >
> > > > On Tue, Jan 25, 2022 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > Quoting Douglas Anderson (2022-01-25 14:44:22)
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > > > new file mode 100644
> > > > > > index 000000000000..f95273052da0
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > > > @@ -0,0 +1,313 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Google Herobrine board device tree source
> > > > > > + *
> > > > > > + * Copyright 2022 Google LLC.
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +
> > > > > > +#include "sc7280-herobrine.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +       model = "Google Herobrine (rev1+)";
> > > > > > +       compatible = "google,herobrine", "qcom,sc7280";
> > > > >
> > > > > Can we stop adding "qcom,sc7280" to the board compatible string? It
> > > > > looks out of place. It's the compatible for the SoC and should really be
> > > > > the compatible for the /soc node.
> > > >
> > > > I don't have any objections, but I feel like this is the type of thing
> > > > I'd like Bjorn to have the final say on. What say you, Bjorn?
> > > >
> > >
> > > One practical case I can think of right away, where this matters is in
> > > cpufreq-dt-plat.c where we blocklist qcom,sc7280.
> > >
> > > I don't know if we rely on this in any other places, but I'm not keen on
> > > seeing a bunch of board-specific compatibles sprinkled throughout the
> > > implementation - it's annoying enough having to add each platform to
> > > these drivers.
> >
> > Looking at sc7180, grep only shows cpufreq-dt-plat.c
> >
>
> Good, then we handle all other platform specifics in drivers using
> platform-specific compatibles.
>
> >  $ git grep qcom,sc7180\" -- drivers
> >  drivers/cpufreq/cpufreq-dt-platdev.c:   { .compatible = "qcom,sc7180", },
> >
> > Simplest solution would be to look at / and /soc for a compatible
> > string.
> >
>
> You mean that / would contain the device's compatible and /soc the soc's
> compatible? I'm afraid I don't see how this would help you - you still
> need the compatible in the dts, just now in two places.
>
>
> Either we leave it as is - which follows my interpretation of what the DT
> spec says - or we (and the DT maitainers) agree that it shouldn't be
> there (because this dtb won't run on any random qcom,sc7180 anyways) at
> all.

I'm curious what part of the DT spec says that we should have the SoC
in there? I know I've always done it, but it's always just been
following the examples of what was done before. When talking about the
root node, I see this in the `devicetree-specification-v0.4-rc1` spec:

---

Specifies a list of platform architectures with which this platform is
compatible. This property can be used by operating systems in
selecting platform specific code. The recommended form of the property
value is: "manufacturer,model"

For example:
compatible = "fsl,mpc8572ds"

---

That doesn't say anything about putting the SoC there.


I would also note that I'd be at least moderately inclined to land
things as-is and deal with this in a follow-up patch, though I'm happy
to spin if that's what people agree upon too. This is not a new
problem and so it doesn't seem like it makes sense to glom dealing
with it into this patch series...

-Doug
