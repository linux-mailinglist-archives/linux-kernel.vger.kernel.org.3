Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58558CDCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244100AbiHHSlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiHHSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:40:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04234F42;
        Mon,  8 Aug 2022 11:40:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a18-20020a05600c349200b003a30de68697so6253897wmq.0;
        Mon, 08 Aug 2022 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=gmT8KtUmsn+TaNIBb1OePApL9TIbtpSFIIniLRWsTsQ=;
        b=euZGMJ56bzca6GT2+XUmhz+rlUCLuVvBEDXsASbLE0UCyN1gG1sDuJK6Kh+t9trtdO
         gN4Te70FMFeLUopNloTbd6AGeEnzJeCJnybUwr1Rtj0tBR3A/bK9AxoXIIHYUsCKFDsV
         gtSRz8dZhm+9p81hRQ+kvELE73eTs2sTaVXaSnOOz8b0viSlBN8I2G8EXURZBbcE0Z/p
         UskrB0oqxPDLMSG2uUKCbY2Ax1fkBI6OOwnXuu06t9wbLoPKjI72UkxNJoMc54YQ3yoB
         wuSvidt03X3nz1StjnyaEq5/6HzqLJTFeuwspCHhUfJ7ERlJLrxYflu/dzhgw5BMR9pY
         xuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmT8KtUmsn+TaNIBb1OePApL9TIbtpSFIIniLRWsTsQ=;
        b=i46XZhcryG9y4bMfFPoG58OT3v+qkxzwAwVRLmpiynTaxjDaLqepMElrxI5jPD8JEE
         m1hGYnP7k4+Iu/ddo2QYvqjsS0MXBRQ1rOY8WF53ip6kenrs6plPHy+IjcAsgXZfG7a2
         VX2DulNwuVgHcw1C9fbog+R7lMhOJkXQBSv28kF291ETBLUSVam7qQ6ATRjr8vEo+mUT
         J/tNUQEGDfUWCQYzU7zkfmtO2t6GScExcKf9DoeehtoAvnenq4i9N+FbNO/JHXrSEngJ
         Z7sFCUW7Dv3enFrwlHFciZHfu2EHQ1IrgUb9OfkNIk8kWsTuXvO98n2PWUwG8dfbTJi3
         M6aw==
X-Gm-Message-State: ACgBeo16e1mNSL0z3nC0Ktv0S3SbJOZwygRBysqp97BDgAp7Jwe/tW6a
        5xoVQID/Jto+CG355EQcCzk=
X-Google-Smtp-Source: AA6agR7jRfp0fGLQgEVqnMlQqqAoJHeztuk0nD64Kk/TD0TtyvcMEVirkAcNBQhuoaqivuvoXoB27g==
X-Received: by 2002:a05:600c:2314:b0:3a5:180:a9f8 with SMTP id 20-20020a05600c231400b003a50180a9f8mr13298501wmo.163.1659984049091;
        Mon, 08 Aug 2022 11:40:49 -0700 (PDT)
Received: from Ansuel-xps. (host-87-20-249-30.retail.telecomitalia.it. [87.20.249.30])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b003a35ec4bf4fsm14607270wmq.20.2022.08.08.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:40:48 -0700 (PDT)
Message-ID: <62f158b0.050a0220.9281c.1da3@mx.google.com>
X-Google-Original-Message-ID: <YvERLlqp6o9pa4Mh@Ansuel-xps.>
Date:   Mon, 8 Aug 2022 15:35:42 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
 <62efbb68.170a0220.88a00.8207@mx.google.com>
 <3515103e-8663-1df9-a184-a383cc0d6aa9@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3515103e-8663-1df9-a184-a383cc0d6aa9@somainline.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 12:55:36PM +0200, Konrad Dybcio wrote:
> 
> 
> On 7.08.2022 15:00, Christian Marangi wrote:
> > On Mon, Jul 18, 2022 at 06:18:24PM +0200, Christian Marangi wrote:
> >> Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
> >> some additional pcie, sata and usb configuration values, additional
> >> reserved memory and serial output.
> >>
> >> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Any news for this?Unless Qualcomm naming was different back then, you should simply merge
> all of these changes into ipq8064.dtsi, as v1 is often the pre-production,
> internal chip revision and only the last one (or the last and second-last)
> are shipped in production devices.
>

Mhh, this is not the case, there are dev board based on v1 and we also
have some device based on v1 (that have some difference for pci and usb)
One example is a Netgear r7500 where we have 2 revision one based on
ipq8064-v1.0 and one based on ipq8064-v2.0.

> > 
> >> ---
> >>  .../boot/dts/qcom-ipq8064-v2.0-smb208.dtsi    | 37 ++++++++++
> >>  arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi      | 69 +++++++++++++++++++
> >>  2 files changed, 106 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
> >>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
> >> new file mode 100644
> >> index 000000000000..0442580b22de
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
> >> @@ -0,0 +1,37 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include "qcom-ipq8064-v2.0.dtsi"
> >> +
> >> +&rpm {
> >> +	smb208_regulators: regulators {
> >> +		compatible = "qcom,rpm-smb208-regulators";
> >> +
> >> +		smb208_s1a: s1a {
> >> +			regulator-min-microvolt = <1050000>;
> >> +			regulator-max-microvolt = <1150000>;
> >> +
> >> +			qcom,switch-mode-frequency = <1200000>;
> >> +		};
> >> +
> >> +		smb208_s1b: s1b {
> >> +			regulator-min-microvolt = <1050000>;
> >> +			regulator-max-microvolt = <1150000>;
> >> +
> >> +			qcom,switch-mode-frequency = <1200000>;
> >> +		};
> >> +
> >> +		smb208_s2a: s2a {
> >> +			regulator-min-microvolt = < 800000>;
> >> +			regulator-max-microvolt = <1250000>;
> >> +
> >> +			qcom,switch-mode-frequency = <1200000>;
> >> +		};
> >> +
> >> +		smb208_s2b: s2b {
> >> +			regulator-min-microvolt = < 800000>;
> >> +			regulator-max-microvolt = <1250000>;
> >> +
> >> +			qcom,switch-mode-frequency = <1200000>;
> >> +		};
> >> +	};
> >> +};
> >> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> >> new file mode 100644
> >> index 000000000000..2f117d576daf
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> >> @@ -0,0 +1,69 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include "qcom-ipq8064.dtsi"
> >> +
> >> +/ {
> >> +	model = "Qualcomm Technologies, Inc. IPQ8064-v2.0";
> >> +
> >> +	aliases {
> >> +		serial0 = &gsbi4_serial;
> >> +	};
> >> +
> >> +	chosen {
> >> +		stdout-path = "serial0:115200n8";
> >> +	};
> >> +
> >> +	reserved-memory {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <1>;
> >> +		ranges;
> >> +
> >> +		rsvd@41200000 {
> >> +			reg = <0x41200000 0x300000>;
> >> +			no-map;
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&gsbi4 {
> >> +	qcom,mode = <GSBI_PROT_I2C_UART>;
> >> +	status = "okay";
> >> +
> >> +	serial@16340000 {
> >> +		status = "okay";
> >> +	};
> >> +	/*
> >> +	 * The i2c device on gsbi4 should not be enabled.
> >> +	 * On ipq806x designs gsbi4 i2c is meant for exclusive
> >> +	 * RPM usage. Turning this on in kernel manifests as
> >> +	 * i2c failure for the RPM.
> >> +	 */
> >> +};
> >> +
> >> +&pcie0 {
> >> +	compatible = "qcom,pcie-ipq8064-v2";
> >> +};
> >> +
> >> +&pcie1 {
> >> +	compatible = "qcom,pcie-ipq8064-v2";
> >> +};
> >> +
> >> +&pcie2 {
> >> +	compatible = "qcom,pcie-ipq8064-v2";
> >> +};
> >> +
> >> +&sata {
> >> +	ports-implemented = <0x1>;
> >> +};
> >> +
> >> +&ss_phy_0 {
> >> +	qcom,rx-eq = <2>;
> >> +	qcom,tx-deamp_3_5db = <32>;
> >> +	qcom,mpll = <5>;
> >> +};
> >> +
> >> +&ss_phy_1 {
> >> +	qcom,rx-eq = <2>;
> >> +	qcom,tx-deamp_3_5db = <32>;
> >> +	qcom,mpll = <5>;
> >> +};
> >> -- 
> >> 2.36.1
> >>
> > 

-- 
	Ansuel
