Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FF53F073
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiFFUqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiFFUoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F6FC4DF;
        Mon,  6 Jun 2022 13:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AEA561572;
        Mon,  6 Jun 2022 20:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436B5C385A9;
        Mon,  6 Jun 2022 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654547967;
        bh=qeDYNocyvB6ztqkmiLeKEV1qxWokU2Os5Sf6lfKULq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FLWMznABSFfkkpCwItmaxJq1ey3mCAS4AXqqUmDRoUHjQ/qct9ufY+QcZtrjhadXE
         QFmDLlQYvd//o0Ort33ZfuZTBuMuFY9rDheTFpbf7HqkJJ/Yt87LO4lFHlKjylrsb8
         UF7H/a94f7uM6JXxvsEgcbSl0V4JveoceNnBFhonxzrR/L6UCEbVun1WZ6fHg9FkYe
         t/oP70qpkDr9wfj9yz4PSYlBCfOy5AnEhW+r4OA//YZm2aWlch0DTlJGSsRSj4dW/o
         3PekMMwifLR+XgCyTqJAC1zbkjt7MX+0zV57FpKopFEAEwIUmNc6P08egXuTGZ7DBD
         TsI7lBry+VZdA==
Message-ID: <058de46e-24cf-e25b-121c-3ff080702776@kernel.org>
Date:   Mon, 6 Jun 2022 23:39:19 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.06.22 13:11, Krzysztof Kozlowski wrote:
> Add device node for CPU-memory BWMON device (bandwidth monitoring) on
> SDM845 measuring bandwidth between CPU (gladiator_noc) and Last Level
> Cache (memnoc).  Usage of this BWMON allows to remove fixed bandwidth
> votes from cpufreq (CPU nodes) thus achieve high memory throughput even
> with lower CPU frequencies.
> 
> Performance impact (SDM845-MTP RB3 board, linux next-20220422):
> 1. No noticeable impact when running with schedutil or performance
>     governors.
> 
> 2. When comparing to customized kernel with synced interconnects and
>     without bandwidth votes from CPU freq, the sysbench memory tests
>     show significant improvement with bwmon for blocksizes past the L3
>     cache.  The results for such superficial comparison:
> 
> sysbench memory test, results in MB/s (higher is better)
>   bs kB |  type |    V  | V+no bw votes | bwmon | benefit %
>       1 | W/seq | 14795 |          4816 |  4985 |      3.5%
>      64 | W/seq | 41987 |         10334 | 10433 |      1.0%
>    4096 | W/seq | 29768 |          8728 | 32007 |    266.7%
>   65536 | W/seq | 17711 |          4846 | 18399 |    279.6%
> 262144 | W/seq | 16112 |          4538 | 17429 |    284.1%
>      64 | R/seq | 61202 |         67092 | 66804 |     -0.4%
>    4096 | R/seq | 23871 |          5458 | 24307 |    345.4%
>   65536 | R/seq | 18554 |          4240 | 18685 |    340.7%
> 262144 | R/seq | 17524 |          4207 | 17774 |    322.4%
>      64 | W/rnd |  2663 |          1098 |  1119 |      1.9%
>   65536 | W/rnd |   600 |           316 |   610 |     92.7%
>      64 | R/rnd |  4915 |          4784 |  4594 |     -4.0%
>   65536 | R/rnd |   664 |           281 |   678 |    140.7%
> 
> Legend:
> bs kB: block size in KB (small block size means only L1-3 caches are
>        used
> type: R - read, W - write, seq - sequential, rnd - random
> V: vanilla (next-20220422)
> V + no bw votes: vanilla without bandwidth votes from CPU freq
> bwmon: bwmon without bandwidth votes from CPU freq
> benefit %: difference between vanilla without bandwidth votes and bwmon
>             (higher is better)
> 

Ok, now i see! So bwmon shows similar performance compared with the current
cpufreq-based bandwidth scaling. And if you add bwmon on top of vanilla, are
the results close/same? Is the plan to remove the cpufreq based bandwidth
scaling and switch to bwmon? It might improve the power consumption in some
scenarios.

Thanks,
Georgi

> Co-developed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 54 ++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 83e8b63f0910..adffb9c70566 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		pmu@1436400 {
> +			compatible = "qcom,sdm845-cpu-bwmon";
> +			reg = <0 0x01436400 0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnect-names = "ddr", "l3c";
> +
> +			operating-points-v2 = <&cpu_bwmon_opp_table>;
> +
> +			cpu_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/*
> +				 * The interconnect paths bandwidths taken from
> +				 * cpu4_opp_table bandwidth.
> +				 * They also match different tables from
> +				 * msm-4.9 downstream kernel:
> +				 *  - the gladiator_noc-mem_noc from bandwidth
> +				 *    table of qcom,llccbw (property qcom,bw-tbl);
> +				 *    bus width: 4 bytes;
> +				 *  - the OSM L3 from bandwidth table of
> +				 *    qcom,cpu4-l3lat-mon (qcom,core-dev-table);
> +				 *    bus width: 16 bytes;
> +				 */
> +				opp-0 {
> +					opp-peak-kBps = <800000 4800000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <1804000 9216000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <2188000 11980800>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <3072000 15052800>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <4068000 19353600>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <5412000 20889600>;
> +				};
> +				opp-6 {
> +					opp-peak-kBps = <6220000 22425600>;
> +				};
> +				opp-7 {
> +					opp-peak-kBps = <7216000 25497600>;
> +				};
> +			};
> +		};
> +
>   		pcie0: pci@1c00000 {
>   			compatible = "qcom,pcie-sdm845";
>   			reg = <0 0x01c00000 0 0x2000>,

