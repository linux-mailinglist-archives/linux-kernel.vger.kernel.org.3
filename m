Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134AC518D60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiECTsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiECTs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:48:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D04F35DC5;
        Tue,  3 May 2022 12:44:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d6so21025844ede.8;
        Tue, 03 May 2022 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQnD85cVfPYR06uPlA7HSi8T+qmUiGLm8r/q4PY5R38=;
        b=Jn/JH4XDh3Ktm179HHeKvfHYAUS6dyKbrA8FXU+x8vdl++7LuIqKtf0tUIWo8Rmksv
         8EPDDLTMu5BW6WwsOIf9mnWiMtx/7vJMz5QA12siOmz8fNi3nRUi5aqoagv7oYxc8frD
         d4p192DltF9+kgpna9zmLXwkhiEvZtEyFezbGF+HD+e0pPjVogFtGpsZHiRev4yzMmJ8
         cSZ89EdUGgBoKcY0zgg9dH9uN6toodz+LLAU+C6ceddGGIt8DAoArozxrtvP1p8ZstxA
         9CMCuybgbFcauAOZns5EoFhwAOhtv2iLuBrCGjurvVHrQ0btEFW40BKMaWP7CImxMve1
         pVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQnD85cVfPYR06uPlA7HSi8T+qmUiGLm8r/q4PY5R38=;
        b=oEjmDO5B2reUknQ+H4PyJrm34BGblsFRfbFreRecQLRZfqlWpXKfqbCcjvRnSGo1Cn
         Wpc4rTAn7yvHi93RTh27iylL7lh2K5j0+eVdfe2cYZDxnNN1rDoEN5q+DnAUOnLxtUaD
         +T4ho4Xd5at4F1HLNWexj9xHx8LI6Fh4iU5qglQcqvaT51uYJWJrawz1ObNBHqs1kF+w
         24jyf/2t7Fnh4Rt2CYOZzu9xx2LHBxkx9BvoFkMsxH23tjVCWwa6H8BFVKNgx+pY3ivh
         pIh2HAPodiITVN7C1SWxXrAZ5e+Z8bX+MUlP9SdrvkWskhrq4S69dJ7YRApgiHsWaCwK
         uifg==
X-Gm-Message-State: AOAM531PZFRCiXTV08cmD7Qo8EIqqwDXI1Oi/0680/EJGaUWq+TTyxN0
        HUpMVaXsyitwvHccb5S4A/M=
X-Google-Smtp-Source: ABdhPJy8v3Yn6+QlsNNfjIWzL6pZVVxhTruGIEbWm2GpriPSliEeFnNJsl/gGN5LhwbWrgrkdZUmqg==
X-Received: by 2002:a05:6402:4391:b0:427:f2f0:607b with SMTP id o17-20020a056402439100b00427f2f0607bmr3116571edc.45.1651607092613;
        Tue, 03 May 2022 12:44:52 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id q23-20020aa7da97000000b0042617ba6380sm8104003eds.10.2022.05.03.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:44:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 6/6] arm64: dts: allwinner: h616: Add X96 Mate TV box support
Date:   Tue, 03 May 2022 21:44:51 +0200
Message-ID: <8928776.CDJkKcVGEf@kista>
In-Reply-To: <20220428230933.15262-7-andre.przywara@arm.com>
References: <20220428230933.15262-1-andre.przywara@arm.com> <20220428230933.15262-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar comments as for OrangePi Zero2...

Dne petek, 29. april 2022 ob 01:09:33 CEST je Andre Przywara napisal(a):
> The X96 Mate is an Allwinner H616 based TV box, featuring:
>   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
>   - 2GiB/4GiB RAM (fully usable!)
>   - 16/32/64GiB eMMC
>   - 100Mbps Ethernet (via embedded AC200 EPHY, not yet supported)
>   - Unsupported Allwinner WiFi chip
>   - 2 x USB 2.0 host ports
>   - HDMI port
>   - IR receiver
>   - 5V/2A DC power supply via barrel plug
> 
> For more information see: https://linux-sunxi.org/X96_Mate

Please remove external links.

> 
> Add a basic devicetree for it, with SD card and eMMC working, as
> well as serial and the essential peripherals, like the AXP PMIC.
> 
> This DT is somewhat minimal, and should work on many other similar TV
> boxes with the Allwinner H616 chip.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h616-x96-mate.dts    | 177 ++++++++++++++++++
>  2 files changed, 178 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/
allwinner/Makefile
> index df2214e6d946..6a96494a2e0a 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -39,3 +39,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/
arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> new file mode 100644
> index 000000000000..aedb3a3dff38
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2021 Arm Ltd.

2022?

> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "X96 Mate";
> +	compatible = "hechuang,x96-mate", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the DC input */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dcdce>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&reg_dcdce>;
> +	vqmmc-supply = <&reg_bldo1>;
> +	bus-width = <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&r_rsb {
> +	status = "okay";
> +
> +	axp305: pmic@745 {
> +		compatible = "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x745>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_vcc5v>;
> +		vinb-supply = <&reg_vcc5v>;
> +		vinc-supply = <&reg_vcc5v>;
> +		vind-supply = <&reg_vcc5v>;
> +		vine-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc-sys";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3-ext";
> +				status = "disabled";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_aldo3: aldo3 {
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3-ext2";
> +				status = "disabled";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_bldo2: bldo2 {
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc1v8-2";
> +				status = "disabled";
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				regulator-min-microvolt = 
<2500000>;
> +				regulator-max-microvolt = 
<2500000>;
> +				regulator-name = "vcc2v5";
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1080000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1080000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1360000>;
> +				regulator-max-microvolt = 
<1360000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-boot-on;

Did you check if reboot (when booted from SD card) works? It should have same 
issue as OrangePi Zero2.

Please also check and add pio power supplies.

Best regards,
Jernej

> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> -- 
> 2.35.3
> 
> 


