Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23C64A541E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiBAAe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiBAAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:34:55 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF0C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:34:55 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d188so19173862iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RxjgSGztYUFbx7bjM7KqKNH0qHJ5gdw8CggC6+9rrQ=;
        b=IL6Y0sZzrChCOgfOM3tMFFLMgnoZbgv3BLZ8uvwghxync3/m7dJ2meo7QZNfdIFpFV
         AE6NUtEQQtCT/QODYblVO8UVgEdDxaUF7EiM+GP41QIxOGg4PcmoTVoyZIZAnzXt++DN
         0Xjv56VGx1Gb/LxPntRGY81CcPP1YlzbOQ33A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RxjgSGztYUFbx7bjM7KqKNH0qHJ5gdw8CggC6+9rrQ=;
        b=K4gi7NlxAadNmTlDG6cDzwPfWDlfbnobC/Jc0xWxZNfD4Mwcspz2qQSuK9d8zXwssS
         Ai9Ol3DCrOhWYvVu4qe5nYd3DpLfUcggIeHlQSaT+dMxONIDpxrbnMXjMjzbpZS0fiZC
         7J1g113wO9wg5O2IyAg4lHsP3j5zqbUXH2mP7C4bHhwqbABnyHneXyRTshhW/kxShacU
         LCUnvK0aK9w1QCAAkCRwbRf+XNndbN3DTLbCP1MvPbppu+aupo9zopEVGjmxHrZYNnlw
         kVZqrbNwGcm2W+Kfd4jueSiHgXxzQVWof6sUJJZHi1gSF8/OFcMnd2tpk5hBRZu8obav
         8rSA==
X-Gm-Message-State: AOAM5327DTakr1N/gEdbDT/DfspFQ9z3oC5f3/JUIsfeqArKt+97ThST
        JgPRhLkPg0/hEW1aZth+UW+u7Q6B/b/0Lg==
X-Google-Smtp-Source: ABdhPJzB7PSgMS2eMPTYJ92H5ArD3jppjURXX5/IdG3yoYMjCKEt890xufQuaxlJ+vfYUYq+8HfdsQ==
X-Received: by 2002:a05:6602:2dc8:: with SMTP id l8mr7154908iow.63.1643675694410;
        Mon, 31 Jan 2022 16:34:54 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id q9sm11406928iop.30.2022.01.31.16.34.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 16:34:53 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id h7so19212994iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:34:53 -0800 (PST)
X-Received: by 2002:a05:6638:168d:: with SMTP id f13mr8859539jat.44.1643675692795;
 Mon, 31 Jan 2022 16:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20220201001042.3724523-1-dianders@chromium.org>
 <20220131161034.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid>
 <CAD=FV=U4oma5qeoboczmKf6Qx7hpuwFbU-wi51p=owaKgZCQtg@mail.gmail.com> <Yfh/zXKrzC5zaxl/@builder.lan>
In-Reply-To: <Yfh/zXKrzC5zaxl/@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 31 Jan 2022 16:34:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XhVC2g+Me_7Hj=cKEz_GxUJao7OSbfV-nT6GS535SpOA@mail.gmail.com>
Message-ID: <CAD=FV=XhVC2g+Me_7Hj=cKEz_GxUJao7OSbfV-nT6GS535SpOA@mail.gmail.com>
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

On Mon, Jan 31, 2022 at 4:33 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 31 Jan 18:25 CST 2022, Doug Anderson wrote:
>
> > Hi,
> >
> > On Mon, Jan 31, 2022 at 4:11 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index 40cb414bc377..dc98a87e2871 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -616,6 +616,9 @@ qfprom: efuse@784000 {
> > >
> > >                 sdhc_1: sdhci@7c4000 {
> > >                         compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> > > +                       pinctrl-names = "default", "sleep";
> > > +                       pinctrl-0 = <&sdc1_clk>, <&sdc1_cmd>, <&sdc1_data>, <&sdc1_rclk>;
> > > +                       pinctrl-1 = <&sdc1_clk_sleep>, <&sdc1_cmd_sleep>, <&sdc1_data_sleep>, <&sdc1_rclk_sleep>;
> > >                         status = "disabled";
> > >
> > >                         reg = <0 0x007c4000 0 0x1000>,
> > > @@ -2425,6 +2428,9 @@ apss_merge_funnel_in: endpoint {
> > >
> > >                 sdhc_2: sdhci@8804000 {
> > >                         compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> > > +                       pinctrl-names = "default", "sleep";
> > > +                       pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>;
> > > +                       pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>;
> > >                         status = "disabled";
> > >
> > >                         reg = <0 0x08804000 0 0x1000>;
> > > @@ -3943,81 +3949,76 @@ qup_uart15_rx: qup-uart15-rx {
> > >                                 function = "qup17";
> > >                         };
> > >
> > > -                       sdc1_on: sdc1-on {
> > > -                               clk {
> > > -                                       pins = "sdc1_clk";
> > > -                               };
> > >
> > > -                               cmd {
> > > -                                       pins = "sdc1_cmd";
> > > -                               };
> > >
> > > -                               data {
> > > -                                       pins = "sdc1_data";
> > > -                               };
> > > +                       sdc1_clk: sdc1-clk {
> >
> > Ugh. I just noticed that there are way too many blank lines here in
> > the output. Happy to have this fixed when applying or I can post a v2.
> >
>
> I can fix that up as I apply it. Will let it sit for a few days to
> attract reviews first though.

Sounds good. Thanks! I might end up sending a v2 anyway since I found
a few more fixups, but I'll at least wait a day or two so I don't spam
people too hard.

-Doug
