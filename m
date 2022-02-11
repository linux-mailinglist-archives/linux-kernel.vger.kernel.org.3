Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122EF4B1A06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbiBKAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346022AbiBKAEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:04:22 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA37626C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:04:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s185so7836573oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwE69elyD4RG12W7mdlzgoVEhbd5xJqzNauxvjHyiNE=;
        b=cg275d3E6S8mO6+ZdkUje5MUQaTGjjyQaBaMou+1IT3/4XYCTOR5IFO+ZxjiLpLRl9
         6W4lfmL9WayudmVV4/CtAn5Kl9wfoycTigVNSb4Rcpi/IRLUw9osTB93hyAfQmQI65Aa
         z6IfvGsBd0OviXwNOr6e6gajfGJZvhxS0OBVCQ6zKct1zfeXhiztjtStMoRH1gLssmQO
         CnJqUEBX6EHPdjn1MMi8eJ+GHKBzry8QyljnOV44VUuyo2RdMQntFT2BsvaN9S+0TXRY
         n9raDTixEJ6mDCvxXexc9gz0F+VDIIW78Zi5WysbQFyBAi0uqhl03TCINBitvov3w1Ho
         sS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwE69elyD4RG12W7mdlzgoVEhbd5xJqzNauxvjHyiNE=;
        b=or55i+oFgqhKEv6zoClyKL69XcPaAcnxTgcZ6rC/C3n1yUE/tEGKJX8zwQ/4LxCn0b
         Dl2mYr0kj+LOUIW4sIaYw7TmLVgWim0MZaMO1X+MI7Cu0lkkgb5YxQeiSCu/TlU0llvC
         t+f1e/pBZrxvY2L8FMy6QF8KH6TPtyLnTXmtq/BXhejx1FMDnJe/9pDtnZx+EEvgxdNu
         Mz7YP5IwR5g6IQVRwS8ITsAofVA2ufKb/z1OCX90THMY+07IrFds96J1hySvig+1hs/S
         T2kDWJWeyr9uug3Ibs7q/tNYLN9h3KogPqzErpS/k9uy6CUPCYMU+gH6eR1OqoeTH5Nc
         p+rg==
X-Gm-Message-State: AOAM5330fwPPLqtPEzo5IfYhkaTasoNgxuILaovRziB56qzlczzD/ifz
        Xxo4bfAnDs/1YekrC9Eqbxl6SA==
X-Google-Smtp-Source: ABdhPJyK+1GIBtIPdHFYFYU2Kft/qVPJKO/aZBLeGW9q8XWjsUecOAvHnc1eaK93qKlp8hxSaflzEQ==
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr2246137oiv.261.1644537862165;
        Thu, 10 Feb 2022 16:04:22 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s3sm9183005ois.19.2022.02.10.16.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:04:21 -0800 (PST)
Date:   Thu, 10 Feb 2022 18:04:19 -0600
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
        quic_mkrishn@quicinc.com, quic_vproddut@quicinc.com
Subject: Re: [PATCH v4 2/5] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
Message-ID: <YgWoAwdH/AqJUshh@builder.lan>
References: <1644494255-6632-1-git-send-email-quic_sbillaka@quicinc.com>
 <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644494255-6632-3-git-send-email-quic_sbillaka@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Feb 05:57 CST 2022, Sankeerth Billakanti wrote:

> Enable the eDP display panel support without HPD on sc7280 platform.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> 
> Changes in v4:
>   - Create new patch for name changes
>   - Remove output-low
> 
> Changes in v3:
>   - Sort the nodes alphabetically
>   - Use - instead of _ as node names
>   - Place the backlight and panel nodes under root
>   - Change the name of edp_out to mdss_edp_out
>   - Change the names of regulator nodes
>   - Delete unused properties in the board file
> 
> 
> Changes in v2:
>   - Sort node references alphabetically
>   - Improve readability
>   - Move the pwm pinctrl to pwm node
>   - Move the regulators to root
>   - Define backlight power
>   - Remove dummy regulator node
>   - Cleanup pinctrl definitions
> 
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 120 ++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..6dba5ac 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -21,6 +21,59 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	backlight_3v3_regulator: backlight-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "backlight_3v3_regulator";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_power>;
> +	};
> +
> +	edp_3v3_regulator: edp-3v3-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "edp_3v3_regulator";
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
> +
> +	edp_backlight: edp-backlight {
> +		compatible = "pwm-backlight";
> +
> +		power-supply = <&backlight_3v3_regulator>;
> +		pwms = <&pm8350c_pwm 3 65535>;
> +	};
> +
> +	edp_panel: edp-panel {
> +		compatible = "sharp,lq140m1jw46";
> +
> +		power-supply = <&edp_3v3_regulator>;
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
>  };
>  
>  &apps_rsc {
> @@ -76,6 +129,44 @@ ap_ts_pen_1v8: &i2c13 {
>  	};
>  };
>  
> +&edp_out {
> +	remote-endpoint = <&edp_panel_in>;
> +};
> +
> +&mdss {
> +	status = "okay";
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
> +&mdss_edp {
> +	status = "okay";
> +
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l10c_0p8>;
> +	/delete-property/ pinctrl-names;
> +	/delete-property/ pinctrl-0;

If the first device to enable &mdss_edp overwrites pinctrl-{names,0} in
&mdss_dp and removes the properties in &mdss_edp, I think that's a sign
that they should not be in the .dtsi in the first place.

> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l10c_0p8>;
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>  &nvme_3v3_regulator {
>  	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>  };
> @@ -84,7 +175,36 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&pm8350c_gpios {
> +	edp_bl_power: edp-bl-power {
> +		pins = "gpio7";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-pull-down;

Why do you pull down these two pins? They are both outputs.

> +	};
> +
> +	edp_bl_pwm: edp-bl-pwm {
> +		pins = "gpio8";
> +		function = "func1";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-pull-down;
> +	};
> +};
> +
> +&pm8350c_pwm {

As stated previously, this will prevent me from merging this patch until
the LPG/PWM support has been accepted.

As such I would recommend that you drop the backlight parts of this
patch until that has landed - so we can merge the rest of this in the
meantime.

> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&edp_bl_pwm>;
> +};
> +
>  &tlmm {
> +	edp_panel_power: edp-panel-power {
> +		pins = "gpio80";
> +		function = "gpio";
> +		bias-pull-down;

Same here, why is this pulled down?

Thanks,
Bjorn

> +	};
> +
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
>  		function = "gpio";
> -- 
> 2.7.4
> 
