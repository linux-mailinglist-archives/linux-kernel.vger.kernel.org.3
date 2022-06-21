Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F05552A04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbiFUDkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbiFUDkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:40:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612BB62D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:39:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h187so15668149oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWxtngEThL/1CXndF6OBNy94w7fuARzauxhQ7hxLhOE=;
        b=SXW893XzMEBxwo+LkZJq5IBDKGRH9yjB51xSiP5mHpUwPu4P2GMPq1gjaIxldpUuQE
         Kl7msxEtaIDRUXxcojnPL73Lu+KBakHKxmL7nB2SAuLcMpr6GdlvQAFOFX3onPexAuwX
         kr6gG8tncr4XBlsAjwP0sDiOfk/jCt3P/pzpCcMWekAAEdxeTmWc9UVPT5xcGcbhjKSr
         zX8JkDxpwPlwQRtpXYO9s1NKKZt3TpGjSX8rrp/qV/khkXUxmL7fRo8ajkN+YUP85guQ
         6tftfEJZHMc1Aeor5FRMAsGHUk8FmvWxemOVv0jG2hm+98Kxjf1V5ta7e0CSWZi/biUG
         uoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWxtngEThL/1CXndF6OBNy94w7fuARzauxhQ7hxLhOE=;
        b=cwiMm75/ksdK47vKCV0OGAF8j6aP2XfDQtCByOQTOwJZvB6akNu9YqwdSBSkkWEP8D
         O+vwxRBTUXjpUep9AtmTxZ7ZNSh1MmJeXYkNqSUPzVANrc+vRMEU82xpamsxkrbWP31n
         /4Ir3WvrCNIAXkj/pXRpWZjk+FXTwXt7o86OcnWioycP/QmTu7qrWDyc6vq+zmr3preG
         aU4WIIRlvl10O9NUcXEGdsxbAI2OnA1ubpZalQjmdTHtFun/IlpXin+rhreiLlZb6v/4
         uzh4RE6mrTkhPvzJqbsmPEP69boZcZlHFcZIR8GknnHddYEpCSJBQnbREkO6WLPQcjC5
         utoQ==
X-Gm-Message-State: AOAM532OKEiBhmnp+QW1WzZkT9Tx5yV2yE8da3jg5/Jsrx31Fizr+ykL
        Gr3AZHj36e0XU24Xk1aLpu8Ehw==
X-Google-Smtp-Source: ABdhPJzasNTQSQFYwStVLiv+HTVfwGDinnn0CJxvWRSXoooldyj+Em+8GYm7NFgp9nFMOcgsHd5ihA==
X-Received: by 2002:a05:6808:3027:b0:2f9:6618:ea55 with SMTP id ay39-20020a056808302700b002f96618ea55mr18305800oib.247.1655782798638;
        Mon, 20 Jun 2022 20:39:58 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t23-20020a05683022f700b006060322125esm8877594otc.46.2022.06.20.20.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 20:39:58 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:39:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280x: Add reference device
Message-ID: <YrE9jGuLNeFHFGr7@builder.lan>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-4-bjorn.andersson@linaro.org>
 <YqDLmsrAkI1OnHqd@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDLmsrAkI1OnHqd@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Jun 11:17 CDT 2022, Johan Hovold wrote:

> On Tue, Jun 07, 2022 at 02:41:12PM -0700, Bjorn Andersson wrote:
> > Add basic support for the SC8280XP reference device, which allows it to
> > boot to a shell (using EFIFB) with functional storage (UFS), USB,
> > keyboard, touchpad, touchscreen, backlight and remoteprocs.
> > 
> > The PMICs are, per socinfo, reused from other platforms. But given that
> > the address of the PMICs doesn't match other cases and that it's
> > desirable to label things according to the schematics a new dtsi file is
> > created to represent the reference combination of PMICs.
> 
> nit: missing p in "sc8280xp" in Subject.
> 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile            |   1 +
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts    | 423 +++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 108 +++++
> >  3 files changed, 532 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>  
> > +	vreg_misc_3p3: misc-3p3-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "VREG_MISC_3P3";
> > +
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +
> > +		gpio = <&pmc8280_1_gpios 0 GPIO_ACTIVE_HIGH>;
> 
> The PMIC gpios are 1-based, so this should be
> 
> 		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
> 
> or the regulator fails to probe.
> 
> > +		enable-active-high;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&misc_3p3_reg_en>;
> > +
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +	reserved-memory {
> > +	};
> > +};
> 
> > +&qup0_i2c4 {
> > +       status = "okay";
> 
> Please move the status property last throughout here too.
> 
> > +       clock-frequency = <400000>;
> > +
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
> > +
> > +       hid@10 {
> 
> I've changed this to use the more descriptive name "touchscreen".
> 
> > +               compatible = "hid-over-i2c";
> > +               reg = <0x10>;
> > +               hid-descr-addr = <0x1>;
> > +                       
> > +               interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> > +       };
> > +};
> 
> > +&qup2_i2c5 {
> > +       status = "okay";
> > +       clock-frequency = <400000>;
> > +
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> > +
> > +       hid@15 {
> 
> And this to "touchpad@15"
> 
> > +               compatible = "hid-over-i2c";
> > +               reg = <0x15>;
> > +               hid-descr-addr = <0x1>;
> > +
> > +               interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
> > +       };
> > +
> > +       hid@68 {
> 
> And keyboard@68
> 
> Sure these are multifunction devices, but this is the primary function.
> 
> > +               compatible = "hid-over-i2c";
> > +               reg = <0x68>;
> > +               hid-descr-addr = <0x1>;
> > +
> > +               interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> > +       };
> > +};
> 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > new file mode 100644
> > index 000000000000..36ed7d808ab8
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> 
> > +	pmc8280c: pmic@2 {
> > +		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
> > +		reg = <0x2 SPMI_USID>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		pmc8280c_gpios: gpio@8800 {
> > +			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
> > +			reg = <0x8800>;
> > +			gpio-controller;
> > +			gpio-ranges = <&pmc8280c_gpios 0 0 9>;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +		};
> > +
> > +		pmc8280c_lpg: lpg@e800 {
> 
> I renamed the node (and label suffix) "pwm" when I noticed that the
> binding had changed in mainline.
> 
> Since this device is used as a PWM provider I guess that's a better
> name?
> 

The pm8350c seems to include a number of PWM channels, the RGB current
sink (triled) and the LUT block - together making up the "Light Pulse
Generator".

So with that in mind, the compatible seems to have come from the fact
that the author only intended to use one of the PWM sub-blocks...


Thanks for the feedback on the series, will updated and resubmit
accordingly.

Regards,
Bjorn

> > +			compatible = "qcom,pm8350c-pwm";
> > +			reg = <0xe800>;
> > +
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			#pwm-cells = <2>;
> > +
> > +			status = "disabled";
> > +		};
> > +	};
> 
> Johan
