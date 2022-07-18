Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F38577CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiGRH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiGRH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:58:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F19186C8;
        Mon, 18 Jul 2022 00:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023FBB80860;
        Mon, 18 Jul 2022 07:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF40C341C8;
        Mon, 18 Jul 2022 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658131102;
        bh=9VkCz/bfnf/qGq2/1Oq0qquI0jn6/NXBPsVwJD7f5nI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qoFOIwraAytdTjsX1H90InvZK44DZvKpq4U2Nq1XWousJUEXvVlG/5C9bJQUZjdiy
         r5ebGrArIVD7qCjVS7hnUKj4H427U7b7HVkZPJeKoFm22l1V1IgaSXU7J88BqxjM2O
         uOLG2z1UfZZb5tQoFO+cuzFtk4LvLQeMW6OBmHzehlRidUu3AnTUoSb9Coxgwfamzv
         XKWMXngIbmjOFUPjTMWeQ6oJ61hwE7j/z/RIjg8RuP1zNHGfN1NCr9KKZ+1VK8LwDT
         DPwEEjFLUs5AA2DDG4cXENnMOEvtXTKvl20pSqtvuKapiYxe16L7jgvT5vLzS4Xpbe
         tpnJimxUPfilw==
Message-ID: <22495dc6-0d55-70d0-d9f3-bcfafcae62d1@kernel.org>
Date:   Mon, 18 Jul 2022 10:58:16 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sm6350: Add interconnect support
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
 <20220525144404.200390-6-luca.weiss@fairphone.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220525144404.200390-6-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.22 17:44, Luca Weiss wrote:
> Add all the different NoC providers that are found in SM6350 and
> populate different nodes that use the interconnect properties.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes since v2:
> * none
> 
>   arch/arm64/boot/dts/qcom/sm6350.dtsi | 109 +++++++++++++++++++++++++++
>   1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index fb1a0f662575..119073f19285 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1,11 +1,13 @@
>   // SPDX-License-Identifier: BSD-3-Clause
>   /*
>    * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
> + * Copyright (c) 2022, Luca Weiss <luca.weiss@fairphone.com>
>    */
>   
>   #include <dt-bindings/clock/qcom,gcc-sm6350.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interconnect/qcom,sm6350.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -539,6 +541,10 @@ i2c0: i2c@880000 {
>   				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
>   
> @@ -552,6 +558,10 @@ i2c2: i2c@888000 {
>   				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
> +						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
>   		};
> @@ -578,6 +588,10 @@ i2c6: i2c@980000 {
>   				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
>   
> @@ -591,6 +605,10 @@ i2c7: i2c@984000 {
>   				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
>   
> @@ -604,6 +622,10 @@ i2c8: i2c@988000 {
>   				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
>   
> @@ -615,6 +637,9 @@ uart9: serial@98c000 {
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_uart9_default>;
>   				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
> +				interconnect-names = "qup-core", "qup-config";
>   				status = "disabled";
>   			};
>   
> @@ -628,11 +653,62 @@ i2c10: i2c@990000 {
>   				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>   				#address-cells = <1>;
>   				#size-cells = <0>;
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
> +						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>   				status = "disabled";
>   			};
>   
>   		};
>   
> +		config_noc: interconnect@1500000 {
> +			compatible = "qcom,sm6350-config-noc";
> +			reg = <0 0x01500000 0 0x28000>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		system_noc: interconnect@1620000 {
> +			compatible = "qcom,sm6350-system-noc";
> +			reg = <0 0x01620000 0 0x17080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +
> +			clk_virt: interconnect-clk-virt {
> +				compatible = "qcom,sm6350-clk-virt";
> +				#interconnect-cells = <2>;
> +				qcom,bcm-voters = <&apps_bcm_voter>;
> +			};
> +		};
> +
> +		aggre1_noc: interconnect@16e0000 {
> +			compatible = "qcom,sm6350-aggre1-noc";
> +			reg = <0 0x016e0000 0 0x15080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			compatible = "qcom,sm6350-aggre2-noc";
> +			reg = <0 0x01700000 0 0x1f880>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +
> +			compute_noc: interconnect-compute-noc {
> +				compatible = "qcom,sm6350-compute-noc";
> +				#interconnect-cells = <2>;
> +				qcom,bcm-voters = <&apps_bcm_voter>;
> +			};
> +		};
> +
> +		mmss_noc: interconnect@1740000 {
> +			compatible = "qcom,sm6350-mmss-noc";
> +			reg = <0 0x01740000 0 0x1c100>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		ufs_mem_hc: ufs@1d84000 {
>   			compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
>   				     "jedec,ufs-2.0";
> @@ -933,6 +1009,10 @@ sdhc_2: sdhci@8804000 {
>   				 <&gcc GCC_SDCC2_APPS_CLK>,
>   				 <&rpmhcc RPMH_CXO_CLK>;
>   			clock-names = "iface", "core", "xo";
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &clk_virt SLAVE_EBI_CH0 0>,
> +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +
>   			qcom,dll-config = <0x0007642c>;
>   			qcom,ddr-config = <0x80040868>;
>   			power-domains = <&rpmhpd 0>;
> @@ -947,11 +1027,15 @@ sdhc2_opp_table: sdhc2-opp-table {
>   				opp-100000000 {
>   					opp-hz = /bits/ 64 <100000000>;
>   					required-opps = <&rpmhpd_opp_svs_l1>;
> +					opp-peak-kBps = <790000 131000>;
> +					opp-avg-kBps = <50000 50000>;
>   				};
>   
>   				opp-202000000 {
>   					opp-hz = /bits/ 64 <202000000>;
>   					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <3190000 294000>;
> +					opp-avg-kBps = <261438 300000>;

Just wondering where do these values come from? Are they from the downstream DT?
The rest looks good to me.

Thanks,
Georgi

>   				};
>   			};
>   		};
> @@ -1017,12 +1101,33 @@ dp_phy: dp-phy@88ea200 {
>   			};
>   		};
>   
> +		dc_noc: interconnect@9160000 {
> +			compatible = "qcom,sm6350-dc-noc";
> +			reg = <0 0x09160000 0 0x3200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		system-cache-controller@9200000 {
>   			compatible = "qcom,sm6350-llcc";
>   			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
>   			reg-names = "llcc_base", "llcc_broadcast_base";
>   		};
>   
> +		gem_noc: interconnect@9680000 {
> +			compatible = "qcom,sm6350-gem-noc";
> +			reg = <0 0x09680000 0 0x3e200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		npu_noc: interconnect@9990000 {
> +			compatible = "qcom,sm6350-npu-noc";
> +			reg = <0 0x09990000 0 0x1600>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		usb_1: usb@a6f8800 {
>   			compatible = "qcom,sm6350-dwc3", "qcom,dwc3";
>   			reg = <0 0x0a6f8800 0 0x400>;
> @@ -1051,6 +1156,10 @@ usb_1: usb@a6f8800 {
>   
>   			resets = <&gcc GCC_USB30_PRIM_BCR>;
>   
> +			interconnects = <&aggre2_noc MASTER_USB3 0 &clk_virt SLAVE_EBI_CH0 0>,
> +					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
>   			usb_1_dwc3: usb@a600000 {
>   				compatible = "snps,dwc3";
>   				reg = <0 0x0a600000 0 0xcd00>;

