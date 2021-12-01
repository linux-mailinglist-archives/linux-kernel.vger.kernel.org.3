Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB0465160
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350774AbhLAPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbhLAPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:24:22 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF49DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:21:01 -0800 (PST)
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl [83.6.166.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 02E913F6D0;
        Wed,  1 Dec 2021 16:20:59 +0100 (CET)
Message-ID: <99e88947-177c-2f39-7f88-de16c24c3e42@somainline.org>
Date:   Wed, 1 Dec 2021 16:20:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 10/15] arm64: dts: qcom: sm8450: add interconnect nodes
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-11-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201072915.3969178-11-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2021 08:29, Vinod Koul wrote:
> And the various interconnect nodes found in SM8450 SoC and use it for
> UFS controller.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 80 ++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 75827bbfb3ad..4c7cdcea33fa 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-sm8450.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/interconnect/qcom,sm8450.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
> @@ -573,6 +574,61 @@ uart7: serial@99c000 {
>  			};
>  		};
>  
> +		config_noc: interconnect@1500000 {
> +			compatible = "qcom,sm8450-config-noc";
> +			reg = <0 0x01500000 0 0x1c000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		mc_virt: interconnect@1580000 {
> +			compatible = "qcom,sm8450-mc-virt";
> +			reg = <0 0x01580000 0 0x1000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		system_noc: interconnect@1680000 {
> +			reg = <0 0x01680000 0 0x1e200>;
> +			compatible = "qcom,sm8450-system-noc";

Compatible first, please


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		pcie_noc: interconnect@16c0000 {
> +			reg = <0 0x016c0000 0 0xe280>;
> +			compatible = "qcom,sm8450-pcie-anoc";

Ditto


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre1_noc: interconnect@16e0000 {
> +			reg = <0 0x016e0000 0 0x1c080>;
> +			compatible = "qcom,sm8450-aggre1-noc";

Ditto


> +			#interconnect-cells = <1>;
> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			reg = <0 0x01700000 0 0x31080>;
> +			compatible = "qcom,sm8450-aggre2-noc";

Ditto


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&rpmhcc RPMH_IPA_CLK>;
> +		};
> +
> +		mmss_noc: interconnect@1740000 {
> +			reg = <0 0x01740000 0 0x1f080>;
> +			compatible = "qcom,sm8450-mmss-noc";

Ditto


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -817,6 +873,13 @@ rpmhcc: clock-controller {
>  			};
>  		};
>  
> +		gem_noc: interconnect@19100000 {
> +			reg = <0 0x19100000 0 0xbb800>;
> +			compatible = "qcom,sm8450-gem-noc";

Ditto


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>  		ufs_mem_hc: ufshc@1d84000 {
>  			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
>  				     "jedec,ufs-2.0";
> @@ -833,6 +896,9 @@ ufs_mem_hc: ufshc@1d84000 {
>  
>  			iommus = <&apps_smmu 0xe0 0x0>;
>  
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
> +					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
>  			clock-names =
>  				"core_clk",
>  				"bus_aggr_clk",
> @@ -888,6 +954,20 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>  				#clock-cells = <0>;
>  			};
>  		};
> +
> +		nsp_noc: interconnect@320c0000 {
> +			reg = <0 0x320c0000 0 0x10000>;
> +			compatible = "qcom,sm8450-nsp-noc";

Ditto


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		lpass_ag_noc: interconnect@3c40000 {
> +			reg = <0 0x3c40000 0 0x17200>;
> +			compatible = "qcom,sm8450-lpass-ag-noc";

Ditto


> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
>  	};
>  
>  	timer {
>

Konrad

