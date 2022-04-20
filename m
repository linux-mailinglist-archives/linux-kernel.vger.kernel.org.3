Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6339508408
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354166AbiDTIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377011AbiDTIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:52:54 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992EF1EED1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:50:04 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9AB6F3F7B4;
        Wed, 20 Apr 2022 10:50:01 +0200 (CEST)
Date:   Wed, 20 Apr 2022 10:49:59 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sm8350-sagami: usb qmp phy node
 - add 'vdda-pll-supply' & 'vdda-phy-supply'
Message-ID: <20220420084959.fvswkrcimkvxleii@SoMainline.org>
References: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
 <Yl9y668H/N+bcrP4@builder.lan>
 <CAH=2NtwCsRmPbBJ6SAb4fL_Di3SxfUsw=mZMrRGyefd+NW=PQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtwCsRmPbBJ6SAb4fL_Di3SxfUsw=mZMrRGyefd+NW=PQQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-20 12:28:24, Bhupesh Sharma wrote:
> Hi Bjorn,
> 
> On Wed, 20 Apr 2022 at 08:11, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 19 Apr 15:58 CDT 2022, Bhupesh Sharma wrote:
> >
> > How about making the subject:
> >
> > "arm64: dts: qcom: sm8350-sagami: add supplies to USB phy node"
> >
> > It still says the same thing, but in much less characters.
> 
> Sure, this wording seems better to me. Will fix this in v3.
> 
> > > As suggested by Bjorn during review of [1], the 'vdda-pll-supply' &
> > > 'vdda-phy-supply' supplies denote the power for the bus and the
> > > clock of the usb qmp phy and are used by the qcom qmp phy driver.
> > >
> > > So, its safe to assume that the two regulators are the same as on
> > > the MTP. So let's wire them up in the same way as the MTP.
> > >
> >
> > I'm not sure it's "safe to assume", so I would like to get Konrad's
> > input before merging this.
> 
> Right. @Konrad Dybcio , @Marijn Suijten - Any comments on this fix?
> Please share your thoughts.

All we can do is read downstream sources (and/or check compiled DTS
after all overrides have been flattened together), or read sysfs to
validate values where applicable.

These are indeed the two regulators used by USB in:

	https://github.com/sonyxperiadev/kernel/blob/7378fb627b546e0eae24cccd3ab37fa9e0802f95/arch/arm64/boot/dts/qcom/lahaina-usb.dtsi#L146-L149

And the voltages are correct for our board too as per:

	https://github.com/sonyxperiadev/kernel/blob/7378fb627b546e0eae24cccd3ab37fa9e0802f95/arch/arm64/boot/dts/qcom/lahaina-regulators.dtsi

It appears only L6 is used by other hardware nodes, but that should be
fine.

As such, with the suggestions from Bjorn applied:

	Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

- Marijn

> Thanks,
> Bhupesh
> 
> > > In absence of the same 'make dtbs_check' leads to following warnings:
> > >
> > > arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
> > >  phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
> > >
> > > arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
> > >  phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
> > >
> >
> > This is good!
> >
> > Thanks for the patch Bhupesh,
> > Bjorn
> >
> > > [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
> > >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: konrad.dybcio@somainline.org
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Marijn Suijten <marijn.suijten@somainline.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > > Changes since v1:
> > > -----------------
> > > - v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg108467.html
> > > - Fixed the commit message to read usb qmp phy instead of ufs phy (which
> > >   was introduced erroraneously in the commit log).
> > >
> > >  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > > index 90b13cbe2fa6..238ac9380ca2 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> > > @@ -3,6 +3,7 @@
> > >   * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> > >   */
> > >
> > > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > >  #include "sm8350.dtsi"
> > >  #include "pm8350.dtsi"
> > >  #include "pm8350b.dtsi"
> > > @@ -75,6 +76,27 @@ ramoops@ffc00000 {
> > >       };
> > >  };
> > >
> > > +&apps_rsc {
> > > +     pm8350-rpmh-regulators {
> > > +             compatible = "qcom,pm8350-rpmh-regulators";
> > > +             qcom,pmic-id = "b";
> > > +
> > > +             vreg_l1b_0p88: ldo1 {
> > > +                     regulator-name = "vreg_l1b_0p88";
> > > +                     regulator-min-microvolt = <912000>;
> > > +                     regulator-max-microvolt = <920000>;
> > > +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > > +             };
> > > +
> > > +             vreg_l6b_1p2: ldo6 {
> > > +                     regulator-name = "vreg_l6b_1p2";
> > > +                     regulator-min-microvolt = <1200000>;
> > > +                     regulator-max-microvolt = <1208000>;
> > > +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > > +             };
> > > +     };
> > > +};
> > > +
> > >  &adsp {
> > >       status = "okay";
> > >       firmware-name = "qcom/adsp.mbn";
> > > @@ -256,4 +278,7 @@ &usb_1_hsphy {
> > >
> > >  &usb_1_qmpphy {
> > >       status = "okay";
> > > +
> > > +     vdda-phy-supply = <&vreg_l6b_1p2>;
> > > +     vdda-pll-supply = <&vreg_l1b_0p88>;
> > >  };
> > > --
> > > 2.35.1
> > >
