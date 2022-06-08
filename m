Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6435438B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiFHQRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbiFHQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:17:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A0169E33;
        Wed,  8 Jun 2022 09:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFED3B82616;
        Wed,  8 Jun 2022 16:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B961C3411D;
        Wed,  8 Jun 2022 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654705054;
        bh=mAAwuvSjxA6CBOGMlU9li3MF2JwHl56SFaFLEK3/gC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO4yWQBvE/HN/7DZZsMFEjTRCDnfRW8LmwBh4QY8rmyLgyWxGl8KFqkIzgwrkADC9
         Hj8JIx8Ts8GpW5tuL3+RsWY+xN0gB0PuQnLlUYTNvbbs3cT493iUiO49DVKWyVcL+X
         Vx6Ef4+L9XbaFbouJEAW7CmE1QvYkY6J0XJFGDma/kiPICzUWL7xhXki3l4uKzHdRU
         slNFSVCR52TJyg+qK9qoiTdTQ2WiAb1OM4UrtMKYrohsmVMJLodYwJ5yqgwz3rhBz3
         kUChQ1a+iL5iqraoDBEGroeDpTOddzX3XhdkR9Md5dwdkzI+1J+VtDRKzj+osYYLS3
         U5GlwFSypb0Bw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nyyN8-0004hS-8X; Wed, 08 Jun 2022 18:17:30 +0200
Date:   Wed, 8 Jun 2022 18:17:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280x: Add reference device
Message-ID: <YqDLmsrAkI1OnHqd@hovoldconsulting.com>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607214113.4057684-4-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:41:12PM -0700, Bjorn Andersson wrote:
> Add basic support for the SC8280XP reference device, which allows it to
> boot to a shell (using EFIFB) with functional storage (UFS), USB,
> keyboard, touchpad, touchscreen, backlight and remoteprocs.
> 
> The PMICs are, per socinfo, reused from other platforms. But given that
> the address of the PMICs doesn't match other cases and that it's
> desirable to label things according to the schematics a new dtsi file is
> created to represent the reference combination of PMICs.

nit: missing p in "sc8280xp" in Subject.

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts    | 423 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 108 +++++
>  3 files changed, 532 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
 
> +	vreg_misc_3p3: misc-3p3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VREG_MISC_3P3";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8280_1_gpios 0 GPIO_ACTIVE_HIGH>;

The PMIC gpios are 1-based, so this should be

		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;

or the regulator fails to probe.

> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +	};
> +};

> +&qup0_i2c4 {
> +       status = "okay";

Please move the status property last throughout here too.

> +       clock-frequency = <400000>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
> +
> +       hid@10 {

I've changed this to use the more descriptive name "touchscreen".

> +               compatible = "hid-over-i2c";
> +               reg = <0x10>;
> +               hid-descr-addr = <0x1>;
> +                       
> +               interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +};

> +&qup2_i2c5 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> +
> +       hid@15 {

And this to "touchpad@15"

> +               compatible = "hid-over-i2c";
> +               reg = <0x15>;
> +               hid-descr-addr = <0x1>;
> +
> +               interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +
> +       hid@68 {

And keyboard@68

Sure these are multifunction devices, but this is the primary function.

> +               compatible = "hid-over-i2c";
> +               reg = <0x68>;
> +               hid-descr-addr = <0x1>;
> +
> +               interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +};

> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> new file mode 100644
> index 000000000000..36ed7d808ab8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi

> +	pmc8280c: pmic@2 {
> +		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmc8280c_gpios: gpio@8800 {
> +			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmc8280c_gpios 0 0 9>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pmc8280c_lpg: lpg@e800 {

I renamed the node (and label suffix) "pwm" when I noticed that the
binding had changed in mainline.

Since this device is used as a PWM provider I guess that's a better
name?

> +			compatible = "qcom,pm8350c-pwm";
> +			reg = <0xe800>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			#pwm-cells = <2>;
> +
> +			status = "disabled";
> +		};
> +	};

Johan
