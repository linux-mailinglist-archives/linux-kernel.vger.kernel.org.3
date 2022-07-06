Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31EC56884A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiGFM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiGFM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:27:31 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5E248CF;
        Wed,  6 Jul 2022 05:27:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A886C3F756;
        Wed,  6 Jul 2022 14:27:24 +0200 (CEST)
Message-ID: <a443cd40-a1d5-6e17-1c49-d592a590f1f8@somainline.org>
Date:   Wed, 6 Jul 2022 14:27:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 11/12] arm64: dts: qcom: add PMP8074 DTSI
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220704212402.1715182-1-robimarko@gmail.com>
 <20220704212402.1715182-11-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220704212402.1715182-11-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.07.2022 23:24, Robert Marko wrote:
> PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
> controlled via SPMI.
> 
> Add DTSI for it providing GPIO, regulator and RTC support.
> 
> RTC is disabled by default as there is no built-in battery so it will
> loose time unless board vendor added a battery, so make it optional.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v6:
> * Add RTC and GPIO nodes
> 
> Changes in v5:
> * Remove #address-cells and #size-cells as they are not required for
> regulator subnodes
> ---
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi | 125 ++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> new file mode 100644
> index 000000000000..a3b395e4d78f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
Hi,

Please consider BSD3, or at least dual-licensing with some permissive
license (so that for example BSDs can re-use these DTs).
> +
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +
> +&spmi_bus {
> +	pmic@0 {
> +		compatible = "qcom,pmp8074", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmp8074_adc: adc@3100 {
> +			compatible = "qcom,spmi-adc-rev2";
> +			reg = <0x3100>;
> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +
> +			ref_gnd@0 {
No underscores in node names, please change this to ref-gnd (and consequently
for all other nodes). Note that this only concerns node names and not labels.

> +				reg = <ADC5_REF_GND>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			vref_1p25@1 {
> +				reg = <ADC5_1P25VREF>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			vref_vadc@2 {
> +				reg = <ADC5_VREF_VADC>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			pmic_die: die_temp@6 {
> +				reg = <ADC5_DIE_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			xo_therm: xo_temp@76 {
> +				reg = <ADC5_XO_THERM_100K_PU>;
> +				qcom,ratiometric;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			pa_therm1: thermistor1@77 {
> +				reg = <ADC5_AMUX_THM1_100K_PU>;
> +				qcom,ratiometric;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			pa_therm2: thermistor2@78 {
> +				reg = <ADC5_AMUX_THM2_100K_PU>;
> +				qcom,ratiometric;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			pa_therm3: thermistor3@79 {
> +				reg = <ADC5_AMUX_THM3_100K_PU>;
> +				qcom,ratiometric;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +			};
> +
> +			vph_pwr@131 {
> +				reg = <ADC5_VPH_PWR>;
> +				qcom,pre-scaling = <1 3>;
> +			};
> +		};
> +
> +		pmp8074_rtc: rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> +			allow-set-time;
> +			status = "disabled";
Isn't this PMIC-internal, aka accessible on all devices using PMP8074?

> +		};
> +
> +		pmp8074_gpios: gpio@c000 {
> +			compatible = "qcom,pmp8074-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pmp8074_gpios 0 0 12>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "qcom,pmp8074", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +
> +		regulators {
> +			compatible = "qcom,pmp8074-regulators";
> +
> +			s3: s3 {
> +				regulator-name = "vdd_s3";
> +				regulator-min-microvolt = <592000>;
> +				regulator-max-microvolt = <1064000>;

Are you sure no other configurations are supported with this PMIC?
Otherwise you may accidentally burn somebody's board by setting up
regulators in a place that's not usually expected to have them..

Konrad
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			s4: s4 {
> +				regulator-name = "vdd_s4";
> +				regulator-min-microvolt = <712000>;
> +				regulator-max-microvolt = <992000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			l11: l11 {
> +				regulator-name = "l11";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +		};
> +	};
> +};
