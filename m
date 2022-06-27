Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4155DF54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiF0UKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbiF0UKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:10:49 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9061E1F2E9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:10:47 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id f10-20020a4aa68a000000b0042579cb6238so2090018oom.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hFExjqqaFZRyzvRO/3MzKxEpNEgPwycl58jKIyFzQp8=;
        b=MP3Z0zzW726o54qM6nWHhk5n9UljfNI9Z1E1qmkbbR0n68hrYbTO4sSZypZFX8bPT/
         FYdihhVt0SggpXBlCwnoA1HYQndVt1WGsOYdbbIrVr5f15/mMPmSJ0gDbYjVxAFWq5kF
         9PLE7Jwy2kJWhFofHh8Ws1OvDPlDUpfzuc9w4QtSjFFTW4u1vwD582pXJrIzdVIjzO2f
         zOZtE7jLyifrzhaIo6XEC33l+c6fP4FT3aK2/XF38lHjI2AB6Sk9xld5ja0ROPl4Mm29
         Ik8RDEBmaoHcrIqzTxAWf8trKeoK0h7AwznQN0pIgj6N3/ymhCgjQaaHdIpiM/WIP3wD
         TArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFExjqqaFZRyzvRO/3MzKxEpNEgPwycl58jKIyFzQp8=;
        b=RKhN114r7ONpxVQ4+4szFP6UJn+MMdOic4b5ffjrP2acIBXO9mW+9zFvnibxTwpr15
         OIXV8ls24UcZLkVzn27Er+0TZHP4b2MEDoEx5aJdG+gAwtiIjTFmpVrcjkuayzejFqSu
         0q7Qp+UVSutwBppLX0AdawuQaSu1dC1oHQJ36CN6oEqVfHam6O3TwASfB2zaFNHcdfXi
         +IH6gsdQGC+pnjKFqM0TMJ5msyNdlJLUrBGc2M+cttRwlbC3CpRVjAbjD5AB4oiF8qfl
         i+vFB+LV+365VXx3b9R1PRubFB07zbQOOzj0OvNdi2uamGHqPET9pzEp2zVeAxJozWmb
         lbIw==
X-Gm-Message-State: AJIora/Vz/wj/2wdDTh6LOuzT/UIF/V3RSZsJ09F1cS8Y2rCpP1kX8Gx
        a206vZqzsZKZyWk51qRYuAwnzw==
X-Google-Smtp-Source: AGRyM1tEovjEORdjnv/VCojfJMAHXrvvk7tPOwNbVkO0shIRs17+RLgsnRW380Ev5ttYeBU/LmQdVg==
X-Received: by 2002:a4a:8688:0:b0:41f:8ef5:5b3e with SMTP id x8-20020a4a8688000000b0041f8ef55b3emr6630331ooh.34.1656360646805;
        Mon, 27 Jun 2022 13:10:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e28-20020a0568301f3c00b00616e3fcadaasm78599oth.62.2022.06.27.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:10:46 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:10:44 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: align OPP table names with DT schema
Message-ID: <YroOxPn/mQjJiJtX@builder.lan>
References: <20220627093250.84391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627093250.84391-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Jun 04:32 CDT 2022, Krzysztof Kozlowski wrote:

> DT schema expects names of operating points tables to start with
> "opp-table":
> 
>   ipq6018-cp01-c1.dtb: cpu_opp_table: $nodename:0: 'cpu_opp_table' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> Use hyphens instead of underscores, fix the names to match DT schema or
> remove the prefix entirely when it is not needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> 
> ---
> 
> Changes since v1:
> 1. Extend commit msg.
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/sc7180.dtsi  | 18 +++++++++---------
>  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 12 ++++++------
>  arch/arm64/boot/dts/qcom/sdm630.dtsi  |  4 ++--
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/sm6350.dtsi  |  4 ++--
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  |  8 ++++----
>  arch/arm64/boot/dts/qcom/sm8250.dtsi  | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/sm8350.dtsi  |  4 ++--
>  arch/arm64/boot/dts/qcom/sm8450.dtsi  |  2 +-
>  11 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 0034a20a9705..8f528b8a5fec 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -87,7 +87,7 @@ L2_0: l2-cache {
>  		};
>  	};
>  
> -	cpu_opp_table: cpu_opp_table {
> +	cpu_opp_table: opp-table-cpu {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 05472510e29d..ec22668e641b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -216,7 +216,7 @@ CLUSTER_PWRDN: cluster-gdhs {
>  		};
>  	};
>  
> -	cpu_opp_table: cpu-opp-table {
> +	cpu_opp_table: opp-table-cpu {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 0abc765c615e..3a222ac71cca 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -398,7 +398,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0_opp_table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -453,7 +453,7 @@ cpu0_opp10: opp-1804800000 {
>  		};
>  	};
>  
> -	cpu6_opp_table: cpu6_opp_table {
> +	cpu6_opp_table: opp-table-cpu6 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -725,7 +725,7 @@ sdhc_1: sdhci@7c4000 {
>  
>  			status = "disabled";
>  
> -			sdhc1_opp_table: sdhc1-opp-table {
> +			sdhc1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-100000000 {
> @@ -744,7 +744,7 @@ opp-384000000 {
>  			};
>  		};
>  
> -		qup_opp_table: qup-opp-table {
> +		qup_opp_table: opp-table-qup {
>  			compatible = "operating-points-v2";
>  
>  			opp-75000000 {
> @@ -2602,7 +2602,7 @@ sdhc_2: sdhci@8804000 {
>  
>  			status = "disabled";
>  
> -			sdhc2_opp_table: sdhc2-opp-table {
> +			sdhc2_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-100000000 {
> @@ -2621,7 +2621,7 @@ opp-202000000 {
>  			};
>  		};
>  
> -		qspi_opp_table: qspi-opp-table {
> +		qspi_opp_table: opp-table-qspi {
>  			compatible = "operating-points-v2";
>  
>  			opp-75000000 {
> @@ -2825,7 +2825,7 @@ video-encoder {
>  				compatible = "venus-encoder";
>  			};
>  
> -			venus_opp_table: venus-opp-table {
> +			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-150000000 {
> @@ -2963,7 +2963,7 @@ dpu_intf0_out: endpoint {
>  					};
>  				};
>  
> -				mdp_opp_table: mdp-opp-table {
> +				mdp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-200000000 {
> @@ -3042,7 +3042,7 @@ dsi0_out: endpoint {
>  					};
>  				};
>  
> -				dsi_opp_table: dsi-opp-table {
> +				dsi_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-187500000 {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index fbe0633a0841..b387fab78bd8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -417,7 +417,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0-opp-table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -477,7 +477,7 @@ cpu0_opp_2016mhz: opp-2016000000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4-opp-table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -547,7 +547,7 @@ cpu4_opp_2611mhz: opp-2611200000 {
>  		};
>  	};
>  
> -	cpu7_opp_table: cpu7-opp-table {
> +	cpu7_opp_table: opp-table-cpu7 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -763,7 +763,7 @@ psci {
>  		method = "smc";
>  	};
>  
> -	qspi_opp_table: qspi-opp-table {
> +	qspi_opp_table: opp-table-qspi {
>  		compatible = "operating-points-v2";
>  
>  		opp-75000000 {
> @@ -787,7 +787,7 @@ opp-300000000 {
>  		};
>  	};
>  
> -	qup_opp_table: qup-opp-table {
> +	qup_opp_table: opp-table-qup {
>  		compatible = "operating-points-v2";
>  
>  		opp-75000000 {
> @@ -3334,7 +3334,7 @@ video-firmware {
>  				iommus = <&apps_smmu 0x21a2 0x0>;
>  			};
>  
> -			venus_opp_table: venus-opp-table {
> +			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-133330000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 2a2944e16945..b4367339d8b9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1405,7 +1405,7 @@ mmcc: clock-controller@c8c0000 {
>  					<0>;
>  		};
>  
> -		dsi_opp_table: dsi-opp-table {
> +		dsi_opp_table: opp-table-dsi {
>  			compatible = "operating-points-v2";
>  
>  			opp-131250000 {
> @@ -1494,7 +1494,7 @@ mdp5_intf1_out: endpoint {
>  					};
>  				};
>  
> -				mdp_opp_table: mdp-opp {
> +				mdp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-150000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b96d0aa9f10b..2e9d93d6b28a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -462,7 +462,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0_opp_table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -557,7 +557,7 @@ cpu0_opp18: opp-1766400000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4_opp_table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -1104,7 +1104,7 @@ rng: rng@793000 {
>  			clock-names = "core";
>  		};
>  
> -		qup_opp_table: qup-opp-table {
> +		qup_opp_table: opp-table-qup {
>  			compatible = "operating-points-v2";
>  
>  			opp-50000000 {
> @@ -3569,7 +3569,7 @@ sdhc_2: sdhci@8804000 {
>  
>  			status = "disabled";
>  
> -			sdhc2_opp_table: sdhc2-opp-table {
> +			sdhc2_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-9600000 {
> @@ -3594,7 +3594,7 @@ opp-201500000 {
>  			};
>  		};
>  
> -		qspi_opp_table: qspi-opp-table {
> +		qspi_opp_table: opp-table-qspi {
>  			compatible = "operating-points-v2";
>  
>  			opp-19200000 {
> @@ -3971,7 +3971,7 @@ video-core1 {
>  				compatible = "venus-encoder";
>  			};
>  
> -			venus_opp_table: venus-opp-table {
> +			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-100000000 {
> @@ -4208,7 +4208,7 @@ clock_camcc: clock-controller@ad00000 {
>  			clock-names = "bi_tcxo";
>  		};
>  
> -		dsi_opp_table: dsi-opp-table {
> +		dsi_opp_table: opp-table-dsi {
>  			compatible = "operating-points-v2";
>  
>  			opp-19200000 {
> @@ -4310,7 +4310,7 @@ dpu_intf2_out: endpoint {
>  					};
>  				};
>  
> -				mdp_opp_table: mdp-opp-table {
> +				mdp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-19200000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index d4f8f33f3f0c..9297aa53d860 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -497,7 +497,7 @@ sdhc_1: sdhci@7c4000 {
>  
>  			status = "disabled";
>  
> -			sdhc1_opp_table: sdhc1-opp-table {
> +			sdhc1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-19200000 {
> @@ -941,7 +941,7 @@ sdhc_2: sdhci@8804000 {
>  
>  			status = "disabled";
>  
> -			sdhc2_opp_table: sdhc2-opp-table {
> +			sdhc2_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-100000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index d3fd0af61766..c0c96c557bb0 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -288,7 +288,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0_opp_table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -383,7 +383,7 @@ cpu0_opp18: opp-1785600000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4_opp_table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -473,7 +473,7 @@ cpu4_opp17: opp-2419200000 {
>  		};
>  	};
>  
> -	cpu7_opp_table: cpu7_opp_table {
> +	cpu7_opp_table: opp-table-cpu7 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -3563,7 +3563,7 @@ sdhc_2: sdhci@8804000 {
>  
>  			status = "disabled";
>  
> -			sdhc2_opp_table: sdhc2-opp-table {
> +			sdhc2_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-19200000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 8098330aeb4f..e13e0e8a786b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -336,7 +336,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> -	cpu0_opp_table: cpu0_opp_table {
> +	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -426,7 +426,7 @@ cpu0_opp17: opp-1804800000 {
>  		};
>  	};
>  
> -	cpu4_opp_table: cpu4_opp_table {
> +	cpu4_opp_table: opp-table-cpu4 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -521,7 +521,7 @@ cpu4_opp18: opp-2419200000 {
>  		};
>  	};
>  
> -	cpu7_opp_table: cpu7_opp_table {
> +	cpu7_opp_table: opp-table-cpu7 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -914,7 +914,7 @@ rng: rng@793000 {
>  			clock-names = "core";
>  		};
>  
> -		qup_opp_table: qup-opp-table {
> +		qup_opp_table: opp-table-qup {
>  			compatible = "operating-points-v2";
>  
>  			opp-50000000 {
> @@ -2937,7 +2937,7 @@ sdhc_2: sdhci@8804000 {
>  
>  			status = "disabled";
>  
> -			sdhc2_opp_table: sdhc2-opp-table {
> +			sdhc2_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-19200000 {
> @@ -3123,7 +3123,7 @@ video-encoder {
>  				compatible = "venus-encoder";
>  			};
>  
> -			venus_opp_table: venus-opp-table {
> +			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				opp-720000000 {
> @@ -3486,7 +3486,7 @@ dpu_intf2_out: endpoint {
>  					};
>  				};
>  
> -				mdp_opp_table: mdp-opp-table {
> +				mdp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-200000000 {
> @@ -3656,7 +3656,7 @@ dsi1_phy: dsi-phy@ae96400 {
>  
>  				status = "disabled";
>  
> -				dsi_opp_table: dsi-opp-table {
> +				dsi_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
>  					opp-187500000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 743cba9b683c..db497b954f4c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -638,7 +638,7 @@ ipcc: mailbox@408000 {
>  			#mbox-cells = <2>;
>  		};
>  
> -		qup_opp_table_100mhz: qup-100mhz-opp-table {
> +		qup_opp_table_100mhz: opp-table-qup100mhz {
>  			compatible = "operating-points-v2";
>  
>  			opp-50000000 {
> @@ -657,7 +657,7 @@ opp-100000000 {
>  			};
>  		};
>  
> -		qup_opp_table_120mhz: qup-120mhz-opp-table {
> +		qup_opp_table_120mhz: opp-table-qup120mhz {
>  			compatible = "operating-points-v2";
>  
>  			opp-50000000 {
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 7d08fad76371..ab4ea6672b48 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -343,7 +343,7 @@ CLUSTER_PD: cpu-cluster0 {
>  		};
>  	};
>  
> -	qup_opp_table_100mhz: qup-100mhz-opp-table {
> +	qup_opp_table_100mhz: opp-table-qup {
>  		compatible = "operating-points-v2";
>  
>  		opp-50000000 {
> -- 
> 2.34.1
> 
