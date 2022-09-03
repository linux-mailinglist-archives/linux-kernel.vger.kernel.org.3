Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6985ABEEA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiICMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiICMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:23:40 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867AA5C94E;
        Sat,  3 Sep 2022 05:23:38 -0700 (PDT)
Received: from [192.168.1.101] (afbd23.neoplus.adsl.tpnet.pl [95.49.29.23])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A20BC1F678;
        Sat,  3 Sep 2022 14:23:34 +0200 (CEST)
Message-ID: <c668acbb-3287-c902-95ca-fa3ccb7d8263@somainline.org>
Date:   Sat, 3 Sep 2022 14:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Add pm7250b PMIC
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220902111055.106814-1-luca.weiss@fairphone.com>
 <20220902111055.106814-2-luca.weiss@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220902111055.106814-2-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.09.2022 13:10, Luca Weiss wrote:
> PM7250B is a PMIC primarily used for charging and fuel gauge but also
> has some of the standard functionality like temp-alarm, adc, etc.
> 
> Add the .dtsi with some of the functionality added.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org

Konrad
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 149 ++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm7250b.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> new file mode 100644
> index 000000000000..61f7a6345150
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +	thermal-zones {
> +		pm7250b-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm7250b_temp>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +
> +				trip2 {
> +					temperature = <145000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&spmi_bus {
> +	pmic@2 {
> +		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm7250b_temp: temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			io-channels = <&pm7250b_adc ADC5_DIE_TEMP>;
> +			io-channel-names = "thermal";
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pm7250b_adc: adc@3100 {
> +			compatible = "qcom,spmi-adc5";
> +			reg = <0x3100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +
> +			adc-chan@0 {
> +				reg = <ADC5_REF_GND>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
> +			};
> +
> +			adc-chan@1 {
> +				reg = <ADC5_1P25VREF>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
> +			};
> +
> +			adc-chan@2 {
> +				reg = <ADC5_DIE_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
> +			};
> +
> +			adc-chan@7 {
> +				reg = <ADC5_USB_IN_I>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "usb_in_i_uv";
> +			};
> +
> +			adc-chan@8 {
> +				reg = <ADC5_USB_IN_V_16>;
> +				qcom,pre-scaling = <1 16>;
> +				label = "usb_in_v_div_16";
> +			};
> +
> +			adc-chan@9 {
> +				reg = <ADC5_CHG_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "chg_temp";
> +			};
> +
> +			adc-chan@e {
> +				reg = <ADC5_AMUX_THM2>;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "smb1390_therm";
> +			};
> +
> +			adc-chan@1e {
> +				reg = <ADC5_MID_CHG_DIV6>;
> +				qcom,pre-scaling = <1 6>;
> +				label = "chg_mid";
> +			};
> +
> +			adc-chan@83 {
> +				reg = <ADC5_VPH_PWR>;
> +				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
> +			};
> +
> +			adc-chan@84 {
> +				reg = <ADC5_VBAT_SNS>;
> +				qcom,pre-scaling = <1 3>;
> +				label = "vbat_sns";
> +			};
> +
> +			adc-chan@99 {
> +				reg = <ADC5_SBUx>;
> +				qcom,pre-scaling = <1 3>;
> +				label = "chg_sbux";
> +			};
> +		};
> +
> +		pm7250b_adc_tm: adc-tm@3500 {
> +			compatible = "qcom,spmi-adc-tm5";
> +			reg = <0x3500>;
> +			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	pmic@3 {
> +		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
> +		reg = <0x3 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
