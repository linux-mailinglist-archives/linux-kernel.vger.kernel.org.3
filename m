Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B14A6C96
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiBBIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiBBIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:03:14 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A06C06173D;
        Wed,  2 Feb 2022 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=seEgaVlgz/Vp+D6vXdUCwzahcTfzufMMD8/HyxzkVJk=; b=YipIM99ngR8F00+RNu2Nn/sD4t
        6IdBK9yQHpPyr69n1jrcw+F3WlA2dibRL3Qv2e9PKjHc93gyHAF4F5619u32MhCf6+ulIzHncaVyF
        ZIjFORI1C9hwiAINgBx0PFlUDkBPMqKeNjJJyVQoLel9wsebdMpVvQU3/yZ5cEwxqD/EqLUgVee1H
        bk0E8uXIwWkNqSW2FU8YnhCE95NBRDpyt4VdsAKZPbTo5pgvvlLIAqA0R7SvYJgjQ0USLDrL/u9/V
        WcGS0bEF9OO81qCe1TVI0SVvA9uhlVLU/YO/9AqNCbV14w36eXO12446cFY7b26tE0soL+0m0CG73
        CwnuTENA==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nFAbe-00ClBn-TT; Wed, 02 Feb 2022 08:03:10 +0000
Date:   Wed, 2 Feb 2022 08:03:10 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
Message-ID: <Yfo6vgdTR4ZLGZZ4@earth.li>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
 <20220118012051.21691-4-ansuelsmth@gmail.com>
 <Yfhmum8BnB1JIALP@builder.lan>
 <YflGGM45F3TqERNj@earth.li>
 <YfmtHFfW00Qr2cLc@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfmtHFfW00Qr2cLc@Ansuel-xps.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:58:52PM +0100, Ansuel Smith wrote:
> On Tue, Feb 01, 2022 at 02:39:20PM +0000, Jonathan McDowell wrote:
> > On Mon, Jan 31, 2022 at 04:46:18PM -0600, Bjorn Andersson wrote:
> > > On Mon 17 Jan 19:20 CST 2022, Ansuel Smith wrote:
> > > 
> > > > Add cells definition for rpm node and add missing regulators for the 4
> > > > regulator present on ipq8064. There regulators are controlled by rpm and
> > > > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> > > > reject any regulator change request.
> > > > 
> > > 
> > > Is the SMB208 mandatory on all ipq8064 designs, or should this be pushed
> > > out to the device dts?
> > 
> > It's not; the RB3011 uses a different regulator (a TPS563900).
> >
> 
> Fact is that that's a special case. We have 20 devices based on ipq806x
> and they all have smb208 regulators.

Indeed, it's another Mikrotik special unfortunately (I haven't managed
to get the SMEM driver to work on the platform either).

> Is the TPS563900 also controlled by rpm?

AFAICT it's CPU controlled via I2C. It looks like one output is shared
for the CPU cores etc and the other is for the NSS cores, rather than
the full control the smb208 offers.

> Anyway should we use a dedicated dtsi to declare the correct regulators?

I've got no problem with smb208 being the default, but please add any
appropriate disabling of it to the RB3011 DTS.

> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 35 +++++++++++++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > > index 094125605bea..824cf13dd037 100644
> > > > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > > > @@ -829,10 +829,45 @@ rpm: rpm@108000 {
> > > >  			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
> > > >  			clock-names = "ram";
> > > >  
> > > > +			#address-cells = <1>;
> > > > +			#size-cells = <0>;
> > > > +
> > > >  			rpmcc: clock-controller {
> > > >  				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> > > >  				#clock-cells = <1>;
> > > >  			};
> > > > +
> > > > +			regulators {
> > > > +				compatible = "qcom,rpm-smb208-regulators";
> > > > +
> > > > +				smb208_s1a: s1a {
> > > > +					regulator-min-microvolt = <1050000>;
> > > > +					regulator-max-microvolt = <1150000>;
> > > > +
> > > > +					qcom,switch-mode-frequency = <1200000>;
> > > > +				};
> > > > +
> > > > +				smb208_s1b: s1b {
> > > > +					regulator-min-microvolt = <1050000>;
> > > > +					regulator-max-microvolt = <1150000>;
> > > > +
> > > > +					qcom,switch-mode-frequency = <1200000>;
> > > > +				};
> > > > +
> > > > +				smb208_s2a: s2a {
> > > > +					regulator-min-microvolt = < 800000>;
> > > > +					regulator-max-microvolt = <1250000>;
> > > > +
> > > > +					qcom,switch-mode-frequency = <1200000>;
> > > > +				};
> > > > +
> > > > +				smb208_s2b: s2b {
> > > > +					regulator-min-microvolt = < 800000>;
> > > > +					regulator-max-microvolt = <1250000>;
> > > > +
> > > > +					qcom,switch-mode-frequency = <1200000>;
> > > > +				};
> > > > +			};
> > > >  		};
> > > >  
> > > >  		tcsr: syscon@1a400000 {
> > > > -- 
> > > > 2.33.1

J.

-- 
/-\                             | 101 things you can't have too much
|@/  Debian GNU/Linux Developer |         of : 13 - Holidays.
\-                              |
