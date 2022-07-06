Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDEB568900
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiGFNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiGFNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:08:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA81837D;
        Wed,  6 Jul 2022 06:08:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g26so27028796ejb.5;
        Wed, 06 Jul 2022 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvfAFw0F06jGP7rqNj2HZP5B+fqDMdcDin2Uq+H2+jg=;
        b=WPvO22ADXbyWJULpnsmdDHiBXNYyVpg1yuiDODPbGjTUllQgKvccbRsakgb7KjlSY+
         9dileoPE9oubo77iJwEN8ipD3a/uWcIP9Hqrg8D4/L5aZhTVyryQnKDv/NfQqUnaxONk
         /DiuGi2qNrSPe3/RrvaxXgi/YtAAVTO33LMDirj//Y97KCcuK4y13ioeMTCC5Zmq9EYs
         OWTWDUpQl/gtyWR/ZxhUUUommCpI28vWuzTglTvDzoukARPDFaY7ObV95LszCaeyt6Sr
         bngqjFCzkY6aE1+u0Wan/myxCxwK4HH2WJDHYo/FyoaUGBrO7dZpt6YNl/LUIJ+pi2L6
         0eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvfAFw0F06jGP7rqNj2HZP5B+fqDMdcDin2Uq+H2+jg=;
        b=oFWH7m16DRYoo25EmUKv5VG6HZZv91ua/413oma8n9G4hTAY9yNZ4R3+OGvMakdTA3
         yb3iG1kSIghHbiq59so+VJSM27aRXxHd2mJNfDeYtRwfn5T0LRJ9NVV6UI8snDZR+2X+
         b59L0zpP2mnkyre4UhgHGgpu62KGyS5Ma/xGSMyiP1NqOkuBhIgyeuxhvpJJSTrtG+Bl
         VDO8fDIVA6izWF84iQZ7FdM6jc13sIjen3RplXdA9ZCxXUF1jfZ3zvV/9rYRcMM5vZ5y
         eF626/3afZa7F+If1eXLDE1efffE8KcwxOgKu0Iy7dV1JZ2O171NtKgqMlC6GvjuI07T
         2XYw==
X-Gm-Message-State: AJIora82yJR22LdWFPWMcV/Q2iVY7Ccn7vK4rPc4jrafemAybaWea6iu
        bDxPM+KalJtHk3Wxqe4XixyldxuafnE=
X-Google-Smtp-Source: AGRyM1vU5shQz/Hz1NmeSJZJxO9vrhlXVr1NzBq82lxzA49nplcZBC9mTlaEJR/cta5p01g0Rxb5Lg==
X-Received: by 2002:a17:907:2717:b0:72a:fbc7:fdbe with SMTP id w23-20020a170907271700b0072afbc7fdbemr2256750ejk.658.1657112925555;
        Wed, 06 Jul 2022 06:08:45 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id kx12-20020a170907774c00b0072b02f99e55sm83910ejc.197.2022.07.06.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:08:45 -0700 (PDT)
Message-ID: <62c5895d.1c69fb81.21090.02f1@mx.google.com>
X-Google-Original-Message-ID: <YsWFeBtWJpge+bOd@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 14:52:08 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 03/13] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-4-ansuelsmth@gmail.com>
 <1e261828-6f87-8e02-e560-01a47758471e@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e261828-6f87-8e02-e560-01a47758471e@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:02:44PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.07.2022 15:39, Christian Marangi wrote:
> > Add cells definition for rpm node and add missing regulators for the 4
> > regulator present on ipq8064. There regulators are controlled by rpm and
> > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> > reject any regulator change request.
> That sounds.. very weird for a RPM regulator..
> 
>

I know but it's like that. In theory the smb208 can be controlled via
the gsbi4_i2c and bypass rpm completely but we have no ducmentation of
smb208 so rpm is the only way to scale voltage on this SoC.

If gsbi4_i2c is disabled any RPM voltage request fails as RPM in it's
firmware use the same line and assume it's always enabled.

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 1b4b72723ead..c0b05d2a2d6d 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -844,10 +844,46 @@ rpm: rpm@108000 {
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
> > +			smb208_regulators: regulators {
> Are you sure it is used on all ipq8064 boards? And with the same
> voltage settings?
> 

Out of 28 device we have on openwrt only the one present upstream
doesn't use the smb208 regulator and use it's own way.

The voltage are all the same, it does change with other revision of the
SoC (ipq8065) but they will pushed in another series later.

> > +				compatible = "qcom,rpm-smb208-regulators";
> > +				status = "okay";
> They are enabled by default, as you are defining them here and
> the status property is not overwritten anywhere else.
> 
> Konrad
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

-- 
	Ansuel
