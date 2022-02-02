Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9C4A7A70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbiBBV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347519AbiBBV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:28:25 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE68C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:28:25 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p63so715705iod.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3+VW/9EfZTino0jyY3UEfeRlHvYgao8DjPaWeUn/OQ=;
        b=XezSyPxjpz1BTWmYK0sIFqQQzb3kPxO+OMQm5jHqGMKab/Q+yOI3x8gqWGE6jf6Wia
         ulvtUtpWs2oIrRRhtcnmYxIN7/EoR063RuTNdVA+VIlm2L9hoZi64lycJfDkzpEQmzAw
         rBVhrzfZ4q8Ezkbl2fi5IRj8i6+FuqGhdUFYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3+VW/9EfZTino0jyY3UEfeRlHvYgao8DjPaWeUn/OQ=;
        b=bzHBaYAtBCOocitFkuRSWsnjriick17MepXkxvv/m5YndXjXWDxOf51UTmpgqJBBfa
         eP6p3mPH7YdFTfxIc7UE/HLs/QlyjcmdMpy+IVcyqdBqlTgq/jWoguwr/fAMwwr71jAc
         GSTxJ3c560ySC6oohrS9KbsQnucpCcbMsIx+PPp8Bqtu9d7YS8sNnRV4q7ZXH/0eM8s6
         Z0m0EWO3JaF73T0Je//IB5sshKp0dpWgoRJBaAMxh6omXW990SFKafl/SpaS5eiC+vAc
         TWDty/bFJz+G3RNPcB/3PCYLaafDzGtEKyg9h/ih+Sx6EDKLpxTMxN9qZ38u7UUUJSQJ
         Nyug==
X-Gm-Message-State: AOAM530xd9AHOCKh/5XcQYmAFqFgHZ+k6WYGG3oJB4C1MZpCeZdfRCYf
        NbFqjtPfEUjHf54/PprzcSDeZvEUVmXX/w==
X-Google-Smtp-Source: ABdhPJyYM5pH409VAg2NGOfND6sn/MzrNYyEmM5zuo4THs5xY8mdA5b966X8bQ+ZGBCM153Ns+VsYA==
X-Received: by 2002:a05:6602:1345:: with SMTP id i5mr16996771iov.143.1643837304272;
        Wed, 02 Feb 2022 13:28:24 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id o20sm8512627iov.12.2022.02.02.13.28.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 13:28:23 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id s1so482713ilj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:28:23 -0800 (PST)
X-Received: by 2002:a05:6e02:1be3:: with SMTP id y3mr18555701ilv.120.1643837302621;
 Wed, 02 Feb 2022 13:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20220201001042.3724523-1-dianders@chromium.org>
 <20220131161034.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid>
 <CAD=FV=U4oma5qeoboczmKf6Qx7hpuwFbU-wi51p=owaKgZCQtg@mail.gmail.com>
 <Yfh/zXKrzC5zaxl/@builder.lan> <CAD=FV=XhVC2g+Me_7Hj=cKEz_GxUJao7OSbfV-nT6GS535SpOA@mail.gmail.com>
In-Reply-To: <CAD=FV=XhVC2g+Me_7Hj=cKEz_GxUJao7OSbfV-nT6GS535SpOA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Feb 2022 13:28:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0rhdjZsKYHLwmP188nBqnNPB0fwqQ1z-pGMQLjqXd9A@mail.gmail.com>
Message-ID: <CAD=FV=U0rhdjZsKYHLwmP188nBqnNPB0fwqQ1z-pGMQLjqXd9A@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
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

On Mon, Jan 31, 2022 at 4:34 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jan 31, 2022 at 4:33 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Mon 31 Jan 18:25 CST 2022, Doug Anderson wrote:
> >
> > > Hi,
> > >
> > > On Mon, Jan 31, 2022 at 4:11 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > > index 40cb414bc377..dc98a87e2871 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > > @@ -616,6 +616,9 @@ qfprom: efuse@784000 {
> > > >
> > > >                 sdhc_1: sdhci@7c4000 {
> > > >                         compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> > > > +                       pinctrl-names = "default", "sleep";
> > > > +                       pinctrl-0 = <&sdc1_clk>, <&sdc1_cmd>, <&sdc1_data>, <&sdc1_rclk>;
> > > > +                       pinctrl-1 = <&sdc1_clk_sleep>, <&sdc1_cmd_sleep>, <&sdc1_data_sleep>, <&sdc1_rclk_sleep>;
> > > >                         status = "disabled";
> > > >
> > > >                         reg = <0 0x007c4000 0 0x1000>,
> > > > @@ -2425,6 +2428,9 @@ apss_merge_funnel_in: endpoint {
> > > >
> > > >                 sdhc_2: sdhci@8804000 {
> > > >                         compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> > > > +                       pinctrl-names = "default", "sleep";
> > > > +                       pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>;
> > > > +                       pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>;
> > > >                         status = "disabled";
> > > >
> > > >                         reg = <0 0x08804000 0 0x1000>;
> > > > @@ -3943,81 +3949,76 @@ qup_uart15_rx: qup-uart15-rx {
> > > >                                 function = "qup17";
> > > >                         };
> > > >
> > > > -                       sdc1_on: sdc1-on {
> > > > -                               clk {
> > > > -                                       pins = "sdc1_clk";
> > > > -                               };
> > > >
> > > > -                               cmd {
> > > > -                                       pins = "sdc1_cmd";
> > > > -                               };
> > > >
> > > > -                               data {
> > > > -                                       pins = "sdc1_data";
> > > > -                               };
> > > > +                       sdc1_clk: sdc1-clk {
> > >
> > > Ugh. I just noticed that there are way too many blank lines here in
> > > the output. Happy to have this fixed when applying or I can post a v2.
> > >
> >
> > I can fix that up as I apply it. Will let it sit for a few days to
> > attract reviews first though.
>
> Sounds good. Thanks! I might end up sending a v2 anyway since I found
> a few more fixups, but I'll at least wait a day or two so I don't spam
> people too hard.

Breadcrumbs: I ended up sending out a v2 (tagged as v3 for other
reasons) that fixes this.

https://lore.kernel.org/r/20220202132301.v3.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid/

-Doug
