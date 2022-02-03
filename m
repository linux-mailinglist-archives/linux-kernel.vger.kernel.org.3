Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC284A9033
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiBCVuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbiBCVui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:50:38 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112CC06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:50:38 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id i5so6284189oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JKEpmflaidRrkEDE3CwVxZS8Wmwb1nExeoIHOzcb6c8=;
        b=ZCLJnZayoNsLcHaxjBTl3joL2ikU0JrEcehwUqDsKZJgRMFR6r1dlwoGg4yU5933qx
         Xd1MP60u3O33CxQnuv6IdxJw3Oz4e561GiYeoKyx2gEZmUseQ8ndnP7tGGPeOBIA4epo
         AhK7FcMf3Dy5vkLJFVzsHkkvXzJ/4Y8aYob0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JKEpmflaidRrkEDE3CwVxZS8Wmwb1nExeoIHOzcb6c8=;
        b=k9mWiAHyR7OGdYwhABARUHMm2akyoIuuRBg+KmMOu4Ws3I5iODPr07xBKh4LPYlsoN
         Ovz+XpEkxNuktZgBWcCkW3uHUTeMltx1MoTY2WI5hi4IwpZbxuIPFhqSGcnG+TDytb2W
         PRYV92nGmRIiBcEGx0Km9KsYbxj13em/fI6GKvqWI2yLKA3zgqCK+oBPNdPyLZ+vetm4
         1qLf9dQiNv3f8qsfAwqjK9FKa4Yc4fPlWrPjQCgj7VyYvdWJZXaPUb4B0JlTferfrU10
         XBQJH76Yyt1CbXpyF7l3LHr5lS5LZFkaMUKeBvsrChc5pAujwLzUf62PAs5ZL6ZBHV6I
         a/hw==
X-Gm-Message-State: AOAM532IrEUh9KsaaDXAPcFh6+mR2FNyZnES/4X+OXEHoXEM9vP3b23N
        74K2EtonNgRPSAY7kAo+SSJ2EGaMsUZSJ/o242WtxA==
X-Google-Smtp-Source: ABdhPJyfV0NdYddAlRu/lry/b/saTm85w+XPIgqnR8WvNh394VtoNtZMUwLfax+FK82Pn3yxBDvmaPHg1eVTKKzTrUc=
X-Received: by 2002:aca:df82:: with SMTP id w124mr340oig.112.1643925037825;
 Thu, 03 Feb 2022 13:50:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:50:37 +0000
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W2zsd+jTFyPO_UxS=UxPvB1=iaMbDQY8X2p8tJgL685g@mail.gmail.com>
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.5.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
 <CAE-0n528Bxdj+DKhi2Lan4qR_=4KHD7A1Zkr15tmu+MchryJ1A@mail.gmail.com>
 <CAD=FV=UcpKaLQ31CGKUnaNnZcYnM4N_t8VC43FPGktoYDiMfsw@mail.gmail.com>
 <YfC5i2jR5N+pmHoZ@ripper> <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
 <CAD=FV=W2zsd+jTFyPO_UxS=UxPvB1=iaMbDQY8X2p8tJgL685g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:50:37 +0000
Message-ID: <CAE-0n51QGCCCTDk6HsRdafuEuU9ZsWzTNytmZs0XfWOfzctQ1A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sc7280: Add herobrine-r1
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kgodara@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        quic_rjendra@quicinc.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-01-31 08:44:35)
> Hi,
>
> On Thu, Jan 27, 2022 at 1:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > ----8<-----
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index ca1d103ec449..32bfe453f8b4 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -179,25 +179,29 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
> >  static int __init cpufreq_dt_platdev_init(void)
> >  {
> >         struct device_node *np = of_find_node_by_path("/");
> > +       struct device_node *soc_np = of_find_node_by_path("/soc");
>
> Seems that some device trees have "/soc" and others "/soc@0". For at
> least a little context, see commit a1875bf98290 ("arm64: dts: qcom:
> sdm845: Add unit name to soc node"). Since (presumably) this would
> only be for newer SoCs then I guess you should search for "/soc@0"?
> ...and then if we ever have a SoC that's not @0 then we would have to
> iterate through all SoCs
>

Yes. We can probably just use of_find_node_by_name(NULL, "soc") instead
though and then if there are multiple soc nodes in the future we can
iterate over all the soc nodes with for_each_of_allnodes_from() and make
this logic more complicated. I'd rather not implement any of that
complicated logic until we need to though.
