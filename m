Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF6554953
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355619AbiFVJYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiFVJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629C101E4;
        Wed, 22 Jun 2022 02:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0448D619FD;
        Wed, 22 Jun 2022 09:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630BBC34114;
        Wed, 22 Jun 2022 09:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655889862;
        bh=iTS+u7yAATjiH/+SOJmoPgp7RM/UZWMzGzrc2qaVMWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rp9xF2QsZVLdyXNltQ2e9gGIVh1ye/REClnPUQRW9RxJBmNfQgVVX0JpnYRhjSoT6
         un1Qi3QFlhKACflBymjE5i8q+7UynjLORwGzFuKli+Fds3RvKfFaw7xDR+wnH1MyfD
         FrVtDUv8kK8/43U6RjaZfu2c7mIpRaEhrbQQAnvPsx1hPuLKDy4owL+On/JqaMKtEA
         t5UoTOm0QWWDd0XQyL9sUZSgBSPDNXFSbNI1YjDYrLMuCvxxcBzxoXeKYQBy6He+GR
         rJpbUNa1ISDt0UgVbY7KeXKQLyWbIJBfe82o09yq2Q+P1Nf4U3L/HTDtzRbEvwsnx+
         Z2PLELmRgGUzw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3waw-0002hV-Kz; Wed, 22 Jun 2022 11:24:19 +0200
Date:   Wed, 22 Jun 2022 11:24:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: add SA8540P and ADP
Message-ID: <YrLfwnbmdcniKeOG@hovoldconsulting.com>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-6-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622041224.627803-6-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:23PM -0700, Bjorn Andersson wrote:
> Introduce the Qualcomm SA8540P automotive platform and the SA8295P ADP
> development board.
> 
> The SA8540P and SC8280XP are fairly similar, so the SA8540P is built
> ontop of the SC8280XP dtsi to reduce duplication. As more advanced
> features are integrated this might be re-evaluated.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs (NSPs crashes shortly after
> booting) and USB.
> 
> The SA8295P ADP contains four PM8450 PMICs, which according to their
> revid are compatible with PM8150. They are defined within the ADP for
> now, to avoid creating additional .dtsi files for PM8150 with just
> addresses changed - and to allow using the labels from the schematics.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

No change log?

>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 427 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi    | 133 +++++++
>  3 files changed, 561 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index ceeae094a59f..2f416b84b71c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> new file mode 100644
> index 000000000000..8dbcd95966b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts

> +&remoteproc_adsp {
> +	status = "okay";

Please move the status properties last also for ADP.

> +	firmware-name = "qcom/sa8540p/adsp.mbn";
> +};

> +/* PINCTRL */
> +&pm8450c_gpios {
> +	usb2_en_state: usb2-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pm8450e_gpios {
> +	usb3_en_state: usb3-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pm8450g_gpios {
> +	usb4_en_state: usb4-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +
> +	usb5_en_state: usb5-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};

Perhaps hold off with adding these always-on VBUS "regulators" until
adding support for the multiport controller?

> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> new file mode 100644
> index 000000000000..8ea2886fbab2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include "sc8280xp.dtsi"
> +
> +/delete-node/ &cpu0_opp_table;
> +/delete-node/ &cpu4_opp_table;
> +
> +/ {
> +	cpu0_opp_table: cpu0-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-403200000 {
> +			opp-hz = /bits/ 64 <403200000>;
> +		};
> +		opp-499200000 {
> +			opp-hz = /bits/ 64 <499200000>;
> +		};
> +		opp-595200000 {
> +			opp-hz = /bits/ 64 <595200000>;
> +		};
> +		opp-710400000 {
> +			opp-hz = /bits/ 64 <710400000>;
> +		};
> +		opp-806400000 {
> +			opp-hz = /bits/ 64 <806400000>;
> +		};
> +		opp-902400000 {
> +			opp-hz = /bits/ 64 <902400000>;
> +		};
> +		opp-1017600000 {
> +			opp-hz = /bits/ 64 <1017600000>;
> +		};
> +		opp-1113600000 {
> +			opp-hz = /bits/ 64 <1113600000>;
> +		};
> +		opp-1209600000 {
> +			opp-hz = /bits/ 64 <1209600000>;
> +		};
> +		opp-1324800000 {
> +			opp-hz = /bits/ 64 <1324800000>;
> +		};
> +		opp-1440000000 {
> +			opp-hz = /bits/ 64 <1440000000>;
> +		};
> +		opp-1555200000 {
> +			opp-hz = /bits/ 64 <1555200000>;
> +		};
> +		opp-1670400000 {
> +			opp-hz = /bits/ 64 <1670400000>;
> +		};
> +		opp-1785600000 {
> +			opp-hz = /bits/ 64 <1785600000>;
> +		};
> +		opp-1881600000 {
> +			opp-hz = /bits/ 64 <1881600000>;
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +		};
> +		opp-2131200000 {
> +			opp-hz = /bits/ 64 <2131200000>;
> +		};
> +		opp-2246400000 {
> +			opp-hz = /bits/ 64 <2246400000>;
> +		};
> +	};
> +
> +	cpu4_opp_table: cpu4-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-825600000 {
> +			opp-hz = /bits/ 64 <825600000>;
> +		};
> +		opp-940800000 {
> +			opp-hz = /bits/ 64 <940800000>;
> +		};
> +		opp-1056000000 {
> +			opp-hz = /bits/ 64 <1056000000>;
> +		};
> +		opp-1171200000 {
> +			opp-hz = /bits/ 64 <1171200000>;
> +		};
> +		opp-1286400000 {
> +			opp-hz = /bits/ 64 <1286400000>;
> +		};
> +		opp-1401600000 {
> +			opp-hz = /bits/ 64 <1401600000>;
> +		};
> +		opp-1516800000 {
> +			opp-hz = /bits/ 64 <1516800000>;
> +		};
> +		opp-1632000000 {
> +			opp-hz = /bits/ 64 <1632000000>;
> +		};
> +		opp-1747200000 {
> +			opp-hz = /bits/ 64 <1747200000>;
> +		};
> +		opp-1862400000 {
> +			opp-hz = /bits/ 64 <1862400000>;
> +		};
> +		opp-1977600000 {
> +			opp-hz = /bits/ 64 <1977600000>;
> +		};
> +		opp-2073600000 {
> +			opp-hz = /bits/ 64 <2073600000>;
> +		};
> +		opp-2169600000 {
> +			opp-hz = /bits/ 64 <2169600000>;
> +		};
> +		opp-2284800000 {
> +			opp-hz = /bits/ 64 <2284800000>;
> +		};
> +		opp-2380800000 {
> +			opp-hz = /bits/ 64 <2380800000>;
> +		};
> +		opp-2496000000 {
> +			opp-hz = /bits/ 64 <2496000000>;
> +		};
> +		opp-2592000000 {
> +			opp-hz = /bits/ 64 <2592000000>;
> +		};
> +	};
> +};
> +
> +&rpmhpd {
> +	compatible = "qcom,sa8540p-rpmhpd";
> +};

Should we add sa8540p compatibles (with sc8280xp as fallback) for the
other peripherals from the start in case we find out that there are
indeed differences down the line?

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
