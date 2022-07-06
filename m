Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F356857E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGFK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiGFK0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:26:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956B125EA1;
        Wed,  6 Jul 2022 03:26:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so18656956edb.9;
        Wed, 06 Jul 2022 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=m51M7aOH5FnJwLofP0W607fIK7M775HfSh2WEy0mTWo=;
        b=JJZXb8nugrU4hB99yEftnyX099Qa8+XsZFeQfNMyE9Js8PCpj07zB1+fVtGZAmj4UW
         NGRLyoxucyp6S57S5jMPV/IMlUKAeUmI27IAud4oJZce87gRrxXi58dhsMnwRHdivOgp
         TWokJk6BnRhb2dFySMHHaEDuqFHv6DB2ZvqaOFO/KYMOBJfecwonKssNRMGjgDh4yZUm
         Km54CjtSPIywNcEFl+hS6wC4BZeCseVERyDgMlPpB08RCJdVr5y0fgoSVb/BpuA4cA7I
         59RK4YRScLqaSjzZeLG2pSMUWA83CfTchlSs0VNOhP0H/6qeZ0mSo4Mwiq0E3iSwZeMq
         2GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=m51M7aOH5FnJwLofP0W607fIK7M775HfSh2WEy0mTWo=;
        b=p3mt8D8Q6G8Dqp6Oq5KzAl5MLa3jWxF9Z00/I+tBOwfDxp7fsrg0M7ce/9CXCXdND0
         bOG7kjV5Yrzg9G119HqppTuRxcdAKeneVqFBmLXomGp55cwhThbE0rZUiV3XQIij1LDK
         80BP2seUH8D6aARsN7s9VEiV8sDUawQ9/K9ELQi8BPFKiZovv9+QqnQ9mxMT09tE1FVG
         DbHwbDN7AamewM+9ii3l3txHZI9JKfmUP90gtro0RWMtYfasDYbZtfCRy1CwByn8B2TR
         /mYSkQ2pbTlsK432xZ5lkm3aDT7j39svGjJQ4g/82Jd3SOOPuGQ5EjBwvOqYKErOLnRK
         aImA==
X-Gm-Message-State: AJIora/LAWzv6NQXF1xvfoNYCQowe3QF1Cb/ya+j5lpUqfvqeUZKWd/n
        wtDmdeznxA7qOxHURLfihVM=
X-Google-Smtp-Source: AGRyM1teWvIdZYx1txxcSxtn7EDb6uif4hNEcDyJI+h0PwivdUZtKJ5qLCm8F/LlRHOFsgcI0CojKA==
X-Received: by 2002:a05:6402:12d8:b0:43a:6a70:9039 with SMTP id k24-20020a05640212d800b0043a6a709039mr18588969edx.379.1657103177039;
        Wed, 06 Jul 2022 03:26:17 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b0072737733f9asm10563605ejo.106.2022.07.06.03.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:26:16 -0700 (PDT)
Message-ID: <62c56348.1c69fb81.d2cad.2584@mx.google.com>
X-Google-Original-Message-ID: <YsVfY6MZxOMeahXp@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:09:39 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 03/13] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-4-ansuelsmth@gmail.com>
 <e81344f6-7da5-a209-2785-d540e41f3958@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81344f6-7da5-a209-2785-d540e41f3958@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:34:16AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 15:39, Christian Marangi wrote:
> > Add cells definition for rpm node and add missing regulators for the 4
> > regulator present on ipq8064. There regulators are controlled by rpm and
> > to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
> > reject any regulator change request.
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
> 
> Why adding these?
>

Fix dt warning, will split and put it in a separate commit.

> > +
> >  			rpmcc: clock-controller {
> >  				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> >  				#clock-cells = <1>;
> >  			};
> > +
> > +			smb208_regulators: regulators {
> > +				compatible = "qcom,rpm-smb208-regulators";
> > +				status = "okay";
> 
> Was the node disabled?
> 

smb208 is the normal and advised way to handle regulators on this
platform. Some device may want to not follow that and implement their
own regulator bypassing rpm so we add a status and on the current device
present upstream we set it disabled as it does use different regulators
implementation.

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
> 
> 
> Best regards,
> Krzysztof

-- 
	Ansuel
