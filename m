Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0A4AE5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiBHXup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiBHXun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:50:43 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE43C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:50:42 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r27so808948oiw.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfjRDOxBlYHHE14BCEgNLKQP/YKV4fajU6/9Z4+F+7A=;
        b=BS1mRT/hnJZLCPbRnmOQrH/RP9NXql41p4yiX3I3vTpbaWa9H2QX9ueT/PbbIIpBuO
         wKqnqoM3msoIl9hG3IiOugSaK1fQ8hoYA+r15JyTQPHg8hfVsy9t1ilb+jSAzpn6wcMK
         gAS/tWHJXvWOtI1yFKDxXFYr2mF3e/kdxYNAAeEeMGFHRkJwhl3TCK59jaVEx76efa3A
         DaCnejo/My5XGJocCbE3m5k8l7o9LKYrF0frYXql9fHASVIExKIvafASKEGaBPqk/WJR
         /4Tthh1oC+i21lhVB8JNUmUR187U/N30084/wUF/y8Noy8UWZtM8jrTTKwcemIGn34+C
         AIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfjRDOxBlYHHE14BCEgNLKQP/YKV4fajU6/9Z4+F+7A=;
        b=2sBS1MCCsB4f/GIxEWuxdcc+D6E+zSpxXsu6OVfsAy+vKQjTsuyaqmeLAxyOGwUbuK
         jG+mvJ7xsyorC9ZcKscYNbXwuIVAP/LLPTMhZ5GgcoemD5TKw/XDAbWJ7ovk7rwjmCud
         M3lzyRMWnWNRCUSnaNEo2aOXL1rCYuHNY7B//TVG7LJdeR522zvZusrmcbltDsbp9wkc
         w+rIAYS66SZmAySyXIYAGP3MYZscaXhiTxDzb4QHWIKx8tOZShnSHWtVVoQKd+Gm3JdC
         /FpDZvaow9V8ito+I3MywZpPAvjiqQwmvp9gvJlmOfsF2BubZz6vjatizjxzGtWGHPF7
         vGDg==
X-Gm-Message-State: AOAM5306tGn/P3SDAj+RQcuOG6q1AAczQdSOuGO/i6MygjHxkgsCeeTt
        X6WZu6fxUzFaGP9MXzSQ7ghjuw==
X-Google-Smtp-Source: ABdhPJwsbbOsQ2Ax/QBE65F8Xax4Q1ry58y4ohjRKiITBFnYm47y1u0Jiw5XKGU8I+Mz56JLFI6/nA==
X-Received: by 2002:a05:6808:1920:: with SMTP id bf32mr177216oib.304.1644364241902;
        Tue, 08 Feb 2022 15:50:41 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d22sm5729003otp.79.2022.02.08.15.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:50:41 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:52:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org, robh+dt@kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, krzysztof.kozlowski@canonical.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
Message-ID: <YgMCW9GrY6SRteOU@ripper>
References: <1644333525-30920-1-git-send-email-quic_sbillaka@quicinc.com>
 <1644333525-30920-3-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644333525-30920-3-git-send-email-quic_sbillaka@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Feb 07:18 PST 2022, Sankeerth Billakanti wrote:

> Enable the eDP display panel support without HPD on sc7280 platform.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> 
> Changes in v2:
>   - sort node references alphabetically
>   - improve readability
>   - move the pwm pinctrl to pwm node
>   - move the regulators to root
>   - define backlight power
>   - remove dummy regulator node
>   - cleanup pinctrl definitions
> 
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 122 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    |   2 -
>  2 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..bff2707 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -21,6 +21,34 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	backlight_power: backlight-power {
> +		compatible = "regulator-fixed";
> +		regulator-name = "backlight_power";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_power>;
> +	};
> +
> +	edp_power: edp-power {
> +		compatible = "regulator-fixed";
> +		regulator-name = "edp_power";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_panel_power>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -76,6 +104,42 @@ ap_ts_pen_1v8: &i2c13 {
>  	};
>  };
>  
> +&edp_out {

Sorry for missing this while merging changes in sc7280.dtsi. But it
would be really nice if this was labeled mdss_edp_out instead (or
possibly defined within the &mdss_edp node).

Now you will have &edp_out and &dp_out floating around away from the edp
and dp nodes...

> +	remote-endpoint = <&edp_panel_in>;
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_edp {
> +	status = "okay";
> +
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l10c_0p8>;
> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l10c_0p8>;
> +};
> +
> +&mdss_dp {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp_hot_plug_det>;
> +	data-lanes = <0 1>;
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l1b_0p8>;
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>  &nvme_3v3_regulator {
>  	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>  };
> @@ -84,7 +148,65 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&pm8350c_pwm {

This label doesn't exist, so I won't be able to merge this patch.

> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&edp_bl_pwm>;
> +};
> +
> +&pm8350c_gpios {
> +	edp_bl_power: edp-bl-power {
> +		pins = "gpio7";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	edp_bl_pwm: edp-bl-pwm {
> +		pins = "gpio8";
> +		function = "func1";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
> +
> +&soc {
> +	edp_backlight: edp-backlight {
> +		compatible = "pwm-backlight";

This is not a device on the mmio bus, so it should not love within the
&soc.

> +
> +		power-supply = <&backlight_power>;
> +		pwms = <&pm8350c_pwm 3 65535>;
> +	};
> +
> +	edp_panel: edp_panel {

Ditto.

Regards,
Bjorn

> +		compatible = "sharp,lq140m1jw46";
> +
> +		power-supply = <&edp_power>;
> +		backlight = <&edp_backlight>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				edp_panel_in: endpoint {
> +					remote-endpoint = <&edp_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &tlmm {
> +	edp_panel_power: edp-panel-power {
> +		pins = "gpio80";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
>  		function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 3572399..f8fa716 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3012,8 +3012,6 @@
>  
>  			mdss_edp: edp@aea0000 {
>  				compatible = "qcom,sc7280-edp";
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&edp_hot_plug_det>;
>  
>  				reg = <0 0xaea0000 0 0x200>,
>  				      <0 0xaea0200 0 0x200>,
> -- 
> 2.7.4
> 
