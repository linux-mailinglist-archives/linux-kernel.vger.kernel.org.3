Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56657E369
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiGVPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiGVPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4FF87F7B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658502496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hn9DDx5bldU3b2vlPA02wFcM698KkfJ81FBbCb27Mmo=;
        b=NSM8MW3Dv2/5BxJnMD58BpSH32/lLeG5bHTo1BcqEgCdtwM8UK5tBxANqAfiipbEsy8aoK
        3p5eFxn5T3/NokVwDBTVDT3vatB6Buv5UYZVQqgh+EimjoPuR0Gi/p3XFa8BaVaj/Znz0L
        Sgz5zksBIn+woejAvG5i8+3uukfziCk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-hihwNeIZMZulZnqK6qgM7g-1; Fri, 22 Jul 2022 11:08:14 -0400
X-MC-Unique: hihwNeIZMZulZnqK6qgM7g-1
Received: by mail-qk1-f198.google.com with SMTP id i15-20020a05620a404f00b006b55998179bso3902803qko.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hn9DDx5bldU3b2vlPA02wFcM698KkfJ81FBbCb27Mmo=;
        b=PZWyrNajX4ELh3059CkapvyNWdWJfmrWxzb7hFiU5C0rsWylIxoD5Lg/tz/TJnW0o1
         IQv9i5sxQwIT/sm6hT37+nVg5XX6/Ez39lT5vX2O09UDjWGKWDrmmhXZkdSUbQAp0f9g
         kRR9OqbNnIlKml3pfauA+YffA022prZNd3BSvMO3OBmEmIYNF/eTkr26oozn/1fybbi9
         m4fXC6Z2rpOW7BH697krabwYuY6AxvBqOGQTabz4DVsfeviu3s3kCbHdlAgZpgaPzFRk
         HrDh0oJRKfyNfSSKLrK6v/PK3jXTiYwDX9tmWyppG/rZehrFM1PGjFE2RkidkahH9TF8
         5Ykw==
X-Gm-Message-State: AJIora9+EOw48YAv76JBwDdwo/mcZJSxsTRtHZi0gFrfTbeSdNcgtC87
        DsYwOuMDhDHT+3kUva+ZWh+ed3z2gQkvkDG/MjoXaEoYFXyR3+sawEiaSQdI+fSA04tQ99kH7RT
        jjvbfmBvB5gG9o6H0oQLikIh8
X-Received: by 2002:ac8:5f4d:0:b0:31f:c32:1b35 with SMTP id y13-20020ac85f4d000000b0031f0c321b35mr441050qta.623.1658502493835;
        Fri, 22 Jul 2022 08:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6WtGwt9huL/Z+2o1W0sFcBKn3yCm1rh2oNJEtThon/VqWEE8LrqQc9EelDwL/uGHhmE7dCA==
X-Received: by 2002:ac8:5f4d:0:b0:31f:c32:1b35 with SMTP id y13-20020ac85f4d000000b0031f0c321b35mr441005qta.623.1658502493339;
        Fri, 22 Jul 2022 08:08:13 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id k21-20020a05620a415500b006b5ed1eccc5sm3943347qko.44.2022.07.22.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:08:13 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:08:11 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8295p: move common nodes to
 dtsi
Message-ID: <20220722150811.d4wc7cf4e4qrpjn4@halaneylaptop>
References: <20220722143232.7903-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722143232.7903-1-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 08:02:32PM +0530, Parikshit Pareek wrote:
> There are many ADP boards with lot of common features. Move common
> nodes to sa8xxxp-auto.dtsi files. This will be base for many ADP boards
> to be introduced in near future.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
> 
> Changes since v1:
> - Add , after year 2022, in the license header
> - Rename the dtsi which is suitable for common to many ADP boards
> - Split the patch in introducing common dtsi file, and adding new board
>   file
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 378 +----------------
>  .../arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi | 385 ++++++++++++++++++

Is this maybe too broad of a name? Outside of sa8295p/sa8540p inheriting
from sc8280xp, you've got sa8155p inheriting from sm8150 and sa8195p
inheriting from sc8180xp (may have butchered some of the suffixes there
but you get the point). I know for sure that sa8155p/sa8195p are
"auto-adp" boards so the sa8xxxp-auto-adp.dtsi might cause confusion.
If I was looking I'd expect that dtsi to be relevant to them as well
based on the name, but it isn't as far as I can tell.

By the way, I plan on taking these for a spin on the qdrive3 board I
have when I get access to it again (today/monday), so feel free to cc
me on new versions!

Thanks,
Andrew

>  2 files changed, 387 insertions(+), 376 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 9398f0349944..3cc92162ba02 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -2,388 +2,14 @@
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> -#include <dt-bindings/spmi/spmi.h>
> -
> -#include "sa8540p.dtsi"
> +#include "sa8xxxp-auto-adp.dtsi"
>  
>  / {
>  	model = "Qualcomm SA8295P ADP";
>  	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
> -
> -	aliases {
> -		serial0 = &qup2_uart17;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&apps_rsc {
> -	pmm8540-a-regulators {
> -		compatible = "qcom,pm8150-rpmh-regulators";
> -		qcom,pmic-id = "a";
> -
> -		vreg_l3a: ldo3 {
> -			regulator-name = "vreg_l3a";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1208000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l5a: ldo5 {
> -			regulator-name = "vreg_l5a";
> -			regulator-min-microvolt = <912000>;
> -			regulator-max-microvolt = <912000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l7a: ldo7 {
> -			regulator-name = "vreg_l7a";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l13a: ldo13 {
> -			regulator-name = "vreg_l13a";
> -			regulator-min-microvolt = <3072000>;
> -			regulator-max-microvolt = <3072000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -	};
> -
> -	pmm8540-c-regulators {
> -		compatible = "qcom,pm8150-rpmh-regulators";
> -		qcom,pmic-id = "c";
> -
> -		vreg_l1c: ldo1 {
> -			regulator-name = "vreg_l1c";
> -			regulator-min-microvolt = <912000>;
> -			regulator-max-microvolt = <912000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l2c: ldo2 {
> -			regulator-name = "vreg_l2c";
> -			regulator-min-microvolt = <3072000>;
> -			regulator-max-microvolt = <3072000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l3c: ldo3 {
> -			regulator-name = "vreg_l3c";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1200000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l4c: ldo4 {
> -			regulator-name = "vreg_l4c";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1208000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l6c: ldo6 {
> -			regulator-name = "vreg_l6c";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1200000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l7c: ldo7 {
> -			regulator-name = "vreg_l7c";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l10c: ldo10 {
> -			regulator-name = "vreg_l10c";
> -			regulator-min-microvolt = <2504000>;
> -			regulator-max-microvolt = <2504000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l17c: ldo17 {
> -			regulator-name = "vreg_l17c";
> -			regulator-min-microvolt = <2504000>;
> -			regulator-max-microvolt = <2504000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -	};
> -
> -	pmm8540-g-regulators {
> -		compatible = "qcom,pm8150-rpmh-regulators";
> -		qcom,pmic-id = "g";
> -
> -		vreg_l3g: ldo3 {
> -			regulator-name = "vreg_l3g";
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1200000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l7g: ldo7 {
> -			regulator-name = "vreg_l7g";
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -
> -		vreg_l8g: ldo8 {
> -			regulator-name = "vreg_l8g";
> -			regulator-min-microvolt = <880000>;
> -			regulator-max-microvolt = <880000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-allow-set-load;
> -		};
> -	};
> -};
> -
> -&qup2 {
> -	status = "okay";
> -};
> -
> -&qup2_uart17 {
> -	compatible = "qcom,geni-debug-uart";
> -	status = "okay";
> -};
> -
> -&remoteproc_adsp {
> -	firmware-name = "qcom/sa8540p/adsp.mbn";
> -	status = "okay";
> -};
> -
> -&remoteproc_nsp0 {
> -	firmware-name = "qcom/sa8540p/cdsp.mbn";
> -	status = "okay";
> -};
> -
> -&remoteproc_nsp1 {
> -	firmware-name = "qcom/sa8540p/cdsp1.mbn";
> -	status = "okay";
> -};
> -
> -&spmi_bus {
> -	pm8450a: pmic@0 {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x0 SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450a_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	pm8450c: pmic@4 {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x4 SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450c_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	pm8450e: pmic@8 {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x8 SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450e_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	pm8450g: pmic@c {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0xc SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450g_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -};
> -
> -&ufs_mem_hc {
> -	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> -
> -	vcc-supply = <&vreg_l17c>;
> -	vcc-max-microamp = <800000>;
> -	vccq-supply = <&vreg_l6c>;
> -	vccq-max-microamp = <900000>;
> -
> -	status = "okay";
> -};
> -
> -&ufs_mem_phy {
> -	vdda-phy-supply = <&vreg_l8g>;
> -	vdda-pll-supply = <&vreg_l3g>;
> -
> -	status = "okay";
>  };
> -
> -&ufs_card_hc {
> -	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
> -
> -	vcc-supply = <&vreg_l10c>;
> -	vcc-max-microamp = <800000>;
> -	vccq-supply = <&vreg_l3c>;
> -	vccq-max-microamp = <900000>;
> -
> -	status = "okay";
> -};
> -
> -&ufs_card_phy {
> -	vdda-phy-supply = <&vreg_l8g>;
> -	vdda-pll-supply = <&vreg_l3g>;
> -
> -	status = "okay";
> -};
> -
> -&usb_0 {
> -	status = "okay";
> -};
> -
> -&usb_0_dwc3 {
> -	/* TODO: Define USB-C connector properly */
> -	dr_mode = "peripheral";
> -};
> -
> -&usb_0_hsphy {
> -	vdda-pll-supply = <&vreg_l5a>;
> -	vdda18-supply = <&vreg_l7a>;
> -	vdda33-supply = <&vreg_l13a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_0_qmpphy {
> -	vdda-phy-supply = <&vreg_l3a>;
> -	vdda-pll-supply = <&vreg_l5a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_1 {
> -	status = "okay";
> -};
> -
> -&usb_1_dwc3 {
> -	/* TODO: Define USB-C connector properly */
> -	dr_mode = "host";
> -};
> -
> -&usb_1_hsphy {
> -	vdda-pll-supply = <&vreg_l1c>;
> -	vdda18-supply = <&vreg_l7c>;
> -	vdda33-supply = <&vreg_l2c>;
> -
> -	status = "okay";
> -};
> -
> -&usb_1_qmpphy {
> -	vdda-phy-supply = <&vreg_l4c>;
> -	vdda-pll-supply = <&vreg_l1c>;
> -
> -	status = "okay";
> -};
> -
> -&usb_2_hsphy0 {
> -	vdda-pll-supply = <&vreg_l5a>;
> -	vdda18-supply = <&vreg_l7g>;
> -	vdda33-supply = <&vreg_l13a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_2_hsphy1 {
> -	vdda-pll-supply = <&vreg_l5a>;
> -	vdda18-supply = <&vreg_l7g>;
> -	vdda33-supply = <&vreg_l13a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_2_hsphy2 {
> -	vdda-pll-supply = <&vreg_l5a>;
> -	vdda18-supply = <&vreg_l7g>;
> -	vdda33-supply = <&vreg_l13a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_2_hsphy3 {
> -	vdda-pll-supply = <&vreg_l5a>;
> -	vdda18-supply = <&vreg_l7g>;
> -	vdda33-supply = <&vreg_l13a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_2_qmpphy0 {
> -	vdda-phy-supply = <&vreg_l3a>;
> -	vdda-pll-supply = <&vreg_l5a>;
> -
> -	status = "okay";
> -};
> -
> -&usb_2_qmpphy1 {
> -	vdda-phy-supply = <&vreg_l3a>;
> -	vdda-pll-supply = <&vreg_l5a>;
> -
> -	status = "okay";
> -};
> -
> -&xo_board_clk {
> -	clock-frequency = <38400000>;
> -};
> -
> -/* PINCTRL */
> diff --git a/arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi b/arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi
> new file mode 100644
> index 000000000000..428e10f48481
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8xxxp-auto-adp.dtsi
> @@ -0,0 +1,385 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +#include "sa8540p.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &qup2_uart17;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&apps_rsc {
> +	pmm8540-a-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_l3a: ldo3 {
> +			regulator-name = "vreg_l3a";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l5a: ldo5 {
> +			regulator-name = "vreg_l5a";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7a: ldo7 {
> +			regulator-name = "vreg_l7a";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l13a: ldo13 {
> +			regulator-name = "vreg_l13a";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmm8540-c-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l2c: ldo2 {
> +			regulator-name = "vreg_l2c";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l3c: ldo3 {
> +			regulator-name = "vreg_l3c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l4c: ldo4 {
> +			regulator-name = "vreg_l4c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7c: ldo7 {
> +			regulator-name = "vreg_l7c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l10c: ldo10 {
> +			regulator-name = "vreg_l10c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l17c: ldo17 {
> +			regulator-name = "vreg_l17c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmm8540-g-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "g";
> +
> +		vreg_l3g: ldo3 {
> +			regulator-name = "vreg_l3g";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7g: ldo7 {
> +			regulator-name = "vreg_l7g";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l8g: ldo8 {
> +			regulator-name = "vreg_l8g";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +};
> +
> +&qup2 {
> +	status = "okay";
> +};
> +
> +&qup2_uart17 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sa8540p/adsp.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_nsp0 {
> +	firmware-name = "qcom/sa8540p/cdsp.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_nsp1 {
> +	firmware-name = "qcom/sa8540p/cdsp1.mbn";
> +	status = "okay";
> +};
> +
> +&spmi_bus {
> +	pm8450a: pmic@0 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450a_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450c: pmic@4 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450c_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450e: pmic@8 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x8 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450e_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450g: pmic@c {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0xc SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450g_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l17c>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l6c>;
> +	vccq-max-microamp = <900000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_card_hc {
> +	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l10c>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l3c>;
> +	vccq-max-microamp = <900000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_card_phy {
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "okay";
> +};
> +
> +&usb_0 {
> +	status = "okay";
> +};
> +
> +&usb_0_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_0_hsphy {
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7a>;
> +	vdda33-supply = <&vreg_l13a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_0_qmpphy {
> +	vdda-phy-supply = <&vreg_l3a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "host";
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l1c>;
> +	vdda18-supply = <&vreg_l7c>;
> +	vdda33-supply = <&vreg_l2c>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l4c>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_hsphy0 {
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_hsphy1 {
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_hsphy2 {
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_hsphy3 {
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_qmpphy0 {
> +	vdda-phy-supply = <&vreg_l3a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_qmpphy1 {
> +	vdda-phy-supply = <&vreg_l3a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> +
> +/* PINCTRL */
> -- 
> 2.17.1
> 

