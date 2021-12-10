Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B3C46FDF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhLJJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:41:34 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38360 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhLJJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:41:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2FA35CE28A2;
        Fri, 10 Dec 2021 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBDAC341C8;
        Fri, 10 Dec 2021 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639129070;
        bh=wRKuYYJKuw1ebIvxw48pFuiBZnozL0DgSyvF4pTa46c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dicbruZtf0j2yGls3KVEuV63MM9K5HE+yQuVgJR/4RTlaFVEEP0xOuY2f3fzxQ0gw
         SrdN9M1ao2t56+3fCA7QQSVgpV5AACHzUZSwr2clvO52EtOfO/ZgtuY5cw/FGaoTuu
         rcoXgTUxYcsyMUs7c5y6zTWTQbq1ht3xJKQACZNUpmhXne+mo2+B1ynA7eAp4OrNM3
         GxSbAc+hVon6tJhvccsLCIJIKNUkMNk7IoThvNZhA1JarMbiekCr+JSQVlZ5nUdmbj
         ryHbpPxLECQATsdSpnz6ifmzUosInDC4vKH6heuAOJX4qN3jlUFvk8oWchmRE2lcvo
         oK9EJybDWKvjA==
Message-ID: <c9b64943-a92f-f2f9-b149-33a51a97d7a3@kernel.org>
Date:   Fri, 10 Dec 2021 11:37:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 09/13] arm64: dts: qcom: sm8450: add interconnect nodes
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        viveka@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-10-vkoul@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20211209103505.197453-10-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 9.12.21 12:35, Vinod Koul wrote:
> And the various interconnect nodes found in SM8450 SoC and use it for
> UFS controller.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 80 ++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 9556d2fc46e0..f75de777f6ea 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/clock/qcom,gcc-sm8450.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interconnect/qcom,sm8450.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   
>   / {
> @@ -573,6 +574,61 @@ uart7: serial@99c000 {
>   			};
>   		};
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

Is there really a register space for this noc?

> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		system_noc: interconnect@1680000 {
> +			compatible = "qcom,sm8450-system-noc";
> +			reg = <0 0x01680000 0 0x1e200>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		pcie_noc: interconnect@16c0000 {
> +			compatible = "qcom,sm8450-pcie-anoc";
> +			reg = <0 0x016c0000 0 0xe280>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre1_noc: interconnect@16e0000 {
> +			compatible = "qcom,sm8450-aggre1-noc";
> +			reg = <0 0x016e0000 0 0x1c080>;
> +			#interconnect-cells = <1>;
> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			compatible = "qcom,sm8450-aggre2-noc";
> +			reg = <0 0x01700000 0 0x31080>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&rpmhcc RPMH_IPA_CLK>;
> +		};
> +
> +		mmss_noc: interconnect@1740000 {
> +			compatible = "qcom,sm8450-mmss-noc";
> +			reg = <0 0x01740000 0 0x1f080>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		tcsr_mutex: hwlock@1f40000 {
>   			compatible = "qcom,tcsr-mutex";
>   			reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -816,6 +872,13 @@ rpmhcc: clock-controller {
>   			};
>   		};
>   
> +		gem_noc: interconnect@19100000 {
> +			compatible = "qcom,sm8450-gem-noc";
> +			reg = <0 0x19100000 0 0xbb800>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		ufs_mem_hc: ufshc@1d84000 {
>   			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
>   				     "jedec,ufs-2.0";
> @@ -832,6 +895,9 @@ ufs_mem_hc: ufshc@1d84000 {
>   
>   			iommus = <&apps_smmu 0xe0 0x0>;
>   
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
> +					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
>   			clock-names =
>   				"core_clk",
>   				"bus_aggr_clk",
> @@ -887,6 +953,20 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>   				#clock-cells = <0>;
>   			};
>   		};
> +
> +		nsp_noc: interconnect@320c0000 {
> +			compatible = "qcom,sm8450-nsp-noc";
> +			reg = <0 0x320c0000 0 0x10000>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		lpass_ag_noc: interconnect@3c40000 {

Nit: This should move up, if we want to order them by node address.

> +			compatible = "qcom,sm8450-lpass-ag-noc";
> +			reg = <0 0x3c40000 0 0x17200>;
> +			#interconnect-cells = <1>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
>   	};

I don't see a DT node for clk_virt, are you planning to add this later?

Thanks,
Georgi

