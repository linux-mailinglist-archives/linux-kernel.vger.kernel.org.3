Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA514A7A82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347636AbiBBVc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347618AbiBBVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:32:50 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BBC061744
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:32:50 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h7so781899iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGTOdXpCfpyaz8M+/fYDUe/NgCW7SBGMlvp2i1b84zI=;
        b=Tpp8U7y5JxXRpmOYMr1x6CrNjgnKiBuTzJX3FpA7ZFqWHBbpr7Xt2eJEQhhf152wL9
         1rhMAUwEr0J17TUBUT6E420HKMR5YbJ8Yd3vhp89mjsl6gsM/o41Me9RR5nd1ZTqDpae
         N7zok0/JgckZdLtIXwwUYYwbpc/zRtHuxP7Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGTOdXpCfpyaz8M+/fYDUe/NgCW7SBGMlvp2i1b84zI=;
        b=tH20HbhdOhBEsWO6trhPiuXJxFSL4Hso8jpAjbQYa74k8sjcv44gtPrTZrm3FZ2e8c
         uBSaziVCYi17wanUbdtmNvf0YEga0ka2eUyfOchpIEXYIwzBId1j0hnB0qIv+TJ2qicg
         kDa/YhubWjH6APCLEOCj4RPBJlDho69ghot3TD0GRh8b49CIqZ8LRSE4V2h0h2t96SE7
         vFH8zm48cGEOuPUHum0M6lRFxwSRaWImULf82Zgjf/Kdx+qvuEBczlBEVzzL3EYhUj41
         2EbuYBreNomcCjB/gi2V0HTF+3jwDo2R8IkiWVUohk/E+rHkMzQaVdJGys2/OBUlxd50
         30mg==
X-Gm-Message-State: AOAM532KznBop5K1nGklpwaWU0nSgxMXK0OQqjQm4DGxevZnu1qY4bCj
        Fal7SHRO4/SsbHK0awMe7RxTfx+wmMNjRw==
X-Google-Smtp-Source: ABdhPJxgebHtqyCPbWt6y9Kt3SbfnrpHSZLuAUW4NZ6H3oEBnDCxVAW6lZvvBGQf7b9jX+f3cMn8eA==
X-Received: by 2002:a6b:d812:: with SMTP id y18mr17553123iob.161.1643837569570;
        Wed, 02 Feb 2022 13:32:49 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id a10sm2117548ilv.44.2022.02.02.13.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 13:32:48 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id i1so502730ils.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:32:48 -0800 (PST)
X-Received: by 2002:a05:6e02:1bed:: with SMTP id y13mr2711266ilv.27.1643837568176;
 Wed, 02 Feb 2022 13:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.5.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
 <CAE-0n528Bxdj+DKhi2Lan4qR_=4KHD7A1Zkr15tmu+MchryJ1A@mail.gmail.com>
 <CAD=FV=UcpKaLQ31CGKUnaNnZcYnM4N_t8VC43FPGktoYDiMfsw@mail.gmail.com>
 <YfC5i2jR5N+pmHoZ@ripper> <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
 <YfgRS/UtRn6Ewwhj@builder.lan> <CAD=FV=V=pbmP-wKhAOVRBC0M=YjYm3Ym-022g8uBEZOxKW-8BQ@mail.gmail.com>
 <CAD=FV=WQ0gR18x9rhioLtYGO3oWtny1c52YaiZHUG=PG03d+OQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WQ0gR18x9rhioLtYGO3oWtny1c52YaiZHUG=PG03d+OQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Feb 2022 13:32:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=URxmrQmC4snL7QoZyDQxdcFHy=c9yXkfE+sW2fN447bg@mail.gmail.com>
Message-ID: <CAD=FV=URxmrQmC4snL7QoZyDQxdcFHy=c9yXkfE+sW2fN447bg@mail.gmail.com>
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

On Mon, Jan 31, 2022 at 5:01 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jan 31, 2022 at 8:50 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > > Either we leave it as is - which follows my interpretation of what the DT
> > > spec says - or we (and the DT maitainers) agree that it shouldn't be
> > > there (because this dtb won't run on any random qcom,sc7180 anyways) at
> > > all.
> >
> > I'm curious what part of the DT spec says that we should have the SoC
> > in there? I know I've always done it, but it's always just been
> > following the examples of what was done before. When talking about the
> > root node, I see this in the `devicetree-specification-v0.4-rc1` spec:
> >
> > ---
> >
> > Specifies a list of platform architectures with which this platform is
> > compatible. This property can be used by operating systems in
> > selecting platform specific code. The recommended form of the property
> > value is: "manufacturer,model"
> >
> > For example:
> > compatible = "fsl,mpc8572ds"
> >
> > ---
> >
> > That doesn't say anything about putting the SoC there.
> >
> >
> > I would also note that I'd be at least moderately inclined to land
> > things as-is and deal with this in a follow-up patch, though I'm happy
> > to spin if that's what people agree upon too. This is not a new
> > problem and so it doesn't seem like it makes sense to glom dealing
> > with it into this patch series...
>
> I noticed that you applied the first 4 patches in the series (thanks!)
> but not this one. Are we waiting to get agreement on this before
> landing? As per above, I think it'd be OK to land as-is and then I'm
> happy to do a follow-up patch to clean this up since this isn't a new
> issue. Having this patch outstanding makes it a little confusing with
> the other cleanup patches that I'm posting... ;-)

I didn't hear anything and I was sending a new version of the cleanup
patch series, so I:

* Added this last patch to the end of the cleanup series.

* Addressed the "-regulator" suffix issue that Stephen pointed out.

* Didn't remove the SoC compatible from the top-level node in this
patch, but added follow-on patches in the series that do it.

Hopefully that looks good to everyone. I removed both of Stephen's and
Matthias's review tags from the v3 version.

https://lore.kernel.org/r/20220202132301.v3.12.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid

-Doug
