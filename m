Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60285569696
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiGFXwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiGFXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:52:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028312D1EB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:52:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x10so13794246edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSVkgssPYSMWDFeWt4DymCowPK9l5Ni6+5AEe415dyY=;
        b=khDwWFqETN807wJmcP7heIB6vCBbpIRCZZOBJSCN7WCuU0U+X4w8wrzrfL6dyLR3Be
         G8XhJXA53IqqVIO12N8YYW9RktFvK/f+DIdGeyxlh/FDtFDRlr8qc3oocd77ysg7cxKP
         wGirpXzRIzSK2LD+HZ3cWSm95zWN750w2ocRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSVkgssPYSMWDFeWt4DymCowPK9l5Ni6+5AEe415dyY=;
        b=quw426DdLmWfa0rmFP4t6WsvB7wATddBgWaEahj3L1c0zbNr00YPX+j4ba089IE6Wt
         pZrAq0onJlpR9/vEtfFTNPzxW9kklgB6J6Wepq61UXVu99iZediu+drCDNcurJVbuWeQ
         W3qyr3BkWJXelqG5fwcz+u328smktGvGhVtfJCSngahftlsUFB83Z3JPlZY8eykhtrpm
         37eusR6zHNiGAkYEXBkur3wbiCYKdscZmimF0HYwMlV8SSBOG8KPE9cijXW6oxOudmyB
         SOCAcjfVwgxhAI0HjRBpzBA7C/KR8OyQrKD3kgwK1KwJp0TzPg7e+aXZwjezplcYmzIl
         L3kg==
X-Gm-Message-State: AJIora9Bgr/xndXIe0bbHs8T5Q3171SD8IoemjJ9YO2k7hv31iXnf4hG
        Lqcf/6pk8PsHdYMIycnZ33Qpc0LIPuldB6EEQd4=
X-Google-Smtp-Source: AGRyM1vM0oRc4k24FN2V/cAF1wIXUy7/EkrRJTpQZHUaVsFJ5+ZjkQof0rkLQU7L9KZB74xBCc42vA==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr57028740edb.273.1657151528315;
        Wed, 06 Jul 2022 16:52:08 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906210900b0072af56103casm1822502ejt.220.2022.07.06.16.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 16:52:07 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id f190so9673160wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:52:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8d:b0:3a1:2e4d:1dd2 with SMTP id
 f13-20020a05600c4e8d00b003a12e4d1dd2mr1163259wmq.85.1657151526824; Wed, 06
 Jul 2022 16:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <SG2PR03MB500697A11DA5D0B45DE41B0ECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
 <3bf68892-9a55-1d6e-fb43-346d9378a866@somainline.org>
In-Reply-To: <3bf68892-9a55-1d6e-fb43-346d9378a866@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 16:51:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaCbb1xksYTL=dgDtZOD59nD=dx5hgYY-RFWkRVVo-7Q@mail.gmail.com>
Message-ID: <CAD=FV=VaCbb1xksYTL=dgDtZOD59nD=dx5hgYY-RFWkRVVo-7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] [PATCH v2 2/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 6, 2022 at 5:31 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
>
> On 5.07.2022 04:22, Jimmy Chen wrote:
> > This adds LTE skus for villager device tree files.
> >
> > Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/Makefile                 |  2 ++
> >  .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 -----------
> >  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
> >  .../dts/qcom/sc7280-herobrine-herobrine-r1.dts    |  1 +
> >  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
> >  .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
> >  .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
> >  arch/arm64/boot/dts/qcom/sc7280-idp.dts           |  1 +
> >  8 files changed, 48 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index bb9f4eb3e65a0..6d81ff12f5af2 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -103,6 +103,8 @@ dtb-$(CONFIG_ARCH_QCOM)   += sc7180-trogdor-r1-lte.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7280-herobrine-crd.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7280-herobrine-herobrine-r1.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7280-herobrine-villager-r0.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += sc7280-herobrine-villager-r0-lte.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += sc7280-herobrine-villager-r1-lte.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7280-idp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7280-idp2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sc7280-crd-r3.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > index cfe2741456a1a..25f31c81b2b74 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > @@ -83,17 +83,6 @@ spi_flash: flash@0 {
> >       };
> >  };
> >
> > -/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> > -&remoteproc_mpss {
> > -     status = "okay";
> > -     compatible = "qcom,sc7280-mss-pil";
> > -     iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> > -     interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> > -     memory-region = <&mba_mem>, <&mpss_mem>;
> > -     firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> > -                     "qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> > -};
> > -
> >  &remoteproc_wpss {
> >       status = "okay";
> >       firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > index e9ca6c5d24a16..921eccfec39ae 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > @@ -9,6 +9,7 @@
> >
> >  #include "sc7280-herobrine.dtsi"
> >  #include "sc7280-herobrine-audio-wcd9385.dtsi"
> > +#include "sc7280-herobrine-lte-sku.dtsi"
> >
> >  / {
> >       model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > index c1647a85a371a..c1a6719687252 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > @@ -8,6 +8,7 @@
> >  /dts-v1/;
> >
> >  #include "sc7280-herobrine.dtsi"
> > +#include "sc7280-herobrine-lte-sku.dtsi"
> >
> >  / {
> >       model = "Google Herobrine (rev1+)";
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> > new file mode 100644
> > index 0000000000000..a4809dd2f4e8a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Herobrine dts fragment for LTE SKUs
> > + *
> > + * Copyright 2022 Google LLC.
> > + */
> > +/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> > +&remoteproc_mpss {
> Hi, just a minor nit.
>
> It was recently agreed upon that the status property should go last to
> make things consistent with other DTs (qcom is - as usual - a special
> snowflake :D). Could you please fix that up? The rest looks good.
>
> Konrad

I'm not aware of this new convention. Can you please provide a link?

-Doug
