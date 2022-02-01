Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C244A5E71
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiBAOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiBAOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:39:22 -0500
X-Greylist: delayed 79 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Feb 2022 06:39:22 PST
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEBC061714;
        Tue,  1 Feb 2022 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WfiEQcqWlqA2wHWIL9U4U6jinXG6ycg3gZ8RU4/D1pU=; b=Gq0+VGG+c4NNDBhX4wkPfnHZgQ
        p+5W4IRJn2OzjtPj/3/0RNZZF+/WbOChgrWbwH9/FH3swn0txTohUqTJCQkAPxx/+gaqJP6sPdNjB
        L+0m6EoXmdOrQUfbDR0ZK8F5uhnE+tw4Wfeh/2lIgtzAtKI6iDxKKE/Wg6zIM1kGZ8WmQJ2FfQZG9
        8jkFSlPrC6U3EMQCEDwXxP/rYQbj8afcFyA7VquXxOK6McfhFZ+Dtv7BGsCcWJFSS4Bzbo27k/8Yi
        11/58rgZ8PApcifYMi/KIIEVvON7dCV4tC1gi5/NFWSEfGqa6Mp7uMFPeua7h9bRPpe3mUt72PG4V
        ZzpokFSA==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nEuJU-00C7OI-0z; Tue, 01 Feb 2022 14:39:20 +0000
Date:   Tue, 1 Feb 2022 14:39:20 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
Message-ID: <YflGGM45F3TqERNj@earth.li>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
 <20220118012051.21691-4-ansuelsmth@gmail.com>
 <Yfhmum8BnB1JIALP@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfhmum8BnB1JIALP@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:46:18PM -0600, Bjorn Andersson wrote:
> On Mon 17 Jan 19:20 CST 2022, Ansuel Smith wrote:
> 
> > Add cells definition for rpm node and add missing regulators for the 4
> > regulator present on ipq8064. There regulators are controlled by rpm and
> > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> > reject any regulator change request.
> > 
> 
> Is the SMB208 mandatory on all ipq8064 designs, or should this be pushed
> out to the device dts?

It's not; the RB3011 uses a different regulator (a TPS563900).

> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 35 +++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 094125605bea..824cf13dd037 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -829,10 +829,45 @@ rpm: rpm@108000 {
> >  			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
> >  			clock-names = "ram";
> >  
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> >  			rpmcc: clock-controller {
> >  				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> >  				#clock-cells = <1>;
> >  			};
> > +
> > +			regulators {
> > +				compatible = "qcom,rpm-smb208-regulators";
> > +
> > +				smb208_s1a: s1a {
> > +					regulator-min-microvolt = <1050000>;
> > +					regulator-max-microvolt = <1150000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +
> > +				smb208_s1b: s1b {
> > +					regulator-min-microvolt = <1050000>;
> > +					regulator-max-microvolt = <1150000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +
> > +				smb208_s2a: s2a {
> > +					regulator-min-microvolt = < 800000>;
> > +					regulator-max-microvolt = <1250000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +
> > +				smb208_s2b: s2b {
> > +					regulator-min-microvolt = < 800000>;
> > +					regulator-max-microvolt = <1250000>;
> > +
> > +					qcom,switch-mode-frequency = <1200000>;
> > +				};
> > +			};
> >  		};
> >  
> >  		tcsr: syscon@1a400000 {
> > -- 
> > 2.33.1
> > 

J.

-- 
... "There's no money, there's no weed. It's all been replaced by a fucking
    big pile of corpses."  -- Lock, Stock and Two Smoking Barrels
