Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696E55487C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357172AbiFVJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356423AbiFVJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:08:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8D3A71A;
        Wed, 22 Jun 2022 02:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E867DB81D0B;
        Wed, 22 Jun 2022 09:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAECC341C5;
        Wed, 22 Jun 2022 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655888814;
        bh=mJy56n4JRQ/uKhWgRE9iM6fn1pbkVBOoDXxdxvf8dbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjNpZYKoexqtAVeEYt+jlSpd8XsX7LtXnY5jBJ/bctVOembJSdLANX6AW9mAIC6ln
         lUXaz0skEb4MIym3BvifKDB0VDBx0IwUfrJTbD3Rdg1JICekprGlJL7abvRd/xCZ0j
         i30qxBpi/F4l4pBTlJzk3NiziIHgTu6VEt7SxljYEpiHdQjiyVyCCdPDgvscMAus8b
         vD2aFnjO5Bfjo8XR+nVYmZmU9DRJZNnHixL7kj0UEm1FyvAjT/53Ie4rCCXXcZ8lcm
         nbGsat+Bw3ilTyYKZJaNoIB504owWiykIoPFMQlV6MyfU3eamnwCggtL4A6i8Pf4NB
         uOjgGAJqJxI/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3wK3-0002bX-AZ; Wed, 22 Jun 2022 11:06:51 +0200
Date:   Wed, 22 Jun 2022 11:06:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Message-ID: <YrLbq32Fwfo84fxA@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041224.627803-5-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:22PM -0700, Bjorn Andersson wrote:
> Add basic support for the SC8280XP reference device, which allows it to
> boot to a shell (using EFIFB) with functional storage (UFS), USB,
> keyboard, touchpad, touchscreen, backlight and remoteprocs.
> 
> The PMICs are, per socinfo, reused from other platforms. But given that
> the address of the PMICs doesn't match other cases and that it's
> desirable to label things according to the schematics a new dtsi file is
> created to represent the reference combination of PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Reordered "status" last
> - Fixed invalid PMIC gpio 0
> - Replaced "hid" name with touchscreen, touchpad and keyboard

You also added the HID vdd-supply properties from the X13s devicetree.

I assume the CRD also uses vreg_misc_3p3 for these (always-on for now
anyway).

> - Added &xo_board_clk frequency

> +	vreg_misc_3p3: misc-3p3-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_MISC_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};

> +&qup0_i2c4 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
> +
> +	status = "okay";
> +
> +	touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +};

> +&qup2_i2c5 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> +
> +	status = "okay";
> +
> +	touchpad@15 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +
> +	keyboard@68 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x68>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +};

[...]

> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l4b>;
> +	vdda-pll-supply = <&vreg_l3b>;
> +
> +	status = "okay";
> +};
> +
> +/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
> +
> +&pmc8280_1_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +	};
> +
> +	edp_bl_reg_en: edp-bl-reg-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +	};
> +
> +	misc_3p3_reg_en: misc-3p3-reg-en-state {
> +		pins = "gpio1";
> +		function = "normal";
> +	};
> +};
> +
> +&pmc8280c_gpios {
> +	edp_bl_pwm: edp-bl-pwm-state {
> +		pins = "gpio8";
> +		function = "func1";
> +	};
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};

Nit: This one should go after &usb_1_qmpphy above if we want to keep the
pinctrl nodes last.

> +
> +&tlmm {

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
