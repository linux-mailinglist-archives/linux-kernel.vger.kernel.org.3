Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF250FC51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbiDZL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiDZL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:56:47 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3874E6D39A;
        Tue, 26 Apr 2022 04:53:39 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id ACD823F6AE;
        Tue, 26 Apr 2022 13:53:36 +0200 (CEST)
Message-ID: <761b0b5d-8bc9-e45e-826d-e04a39c1239c@somainline.org>
Date:   Tue, 26 Apr 2022 13:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v6 09/10] ARM: dts: msm: Add coresight components for
 SM8250
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220425040304.37487-1-quic_jinlmao@quicinc.com>
 <20220425040304.37487-10-quic_jinlmao@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220425040304.37487-10-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/04/2022 06:03, Mao Jinlong wrote:
> Add coresight components for sm8250. STM/ETM are added.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 488 +++++++++++++++++++++++++++
>   1 file changed, 488 insertions(+)

Hi,

please fix the commit title to match the style used in the directory of 
the files you're changing.

>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index af8f22636436..53ab2b457a2f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4685,6 +4685,494 @@
>   			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
>   			#freq-domain-cells = <1>;
>   		};

If I can see correctly, you're putting these nodes right under 
cpufreq_hw, which has a unit address of 0x18591000, so this is not 
sorted properly.


Konrad

> +
> +		stm@6002000 {
> +			compatible = "arm,coresight-stm", "arm,primecell";
> +			reg = <0 0x06002000 0 0x1000>, <0 0x16280000 0 0x180000>;
> +			reg-names = "stm-base", "stm-stimulus-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					stm_out: endpoint {
> +						remote-endpoint = <&funnel0_in7>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6041000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x06041000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel0_out: endpoint {
> +						remote-endpoint = <&merge_funnel_in0>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@7 {
> +					reg = <7>;
> +					funnel0_in7: endpoint {
> +						remote-endpoint = <&stm_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6042000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x06042000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel2_out: endpoint {
> +						remote-endpoint = <&merge_funnel_in2>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@2 {
> +					reg = <4>;
> +					funnel2_in5: endpoint {
> +						remote-endpoint = <&apss_merge_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6045000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x06045000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_merg_out_funnel_swao: endpoint {
> +						remote-endpoint = <&funnel_swao_in_funnel_merg>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <0>;
> +					merge_funnel_in0: endpoint {
> +						remote-endpoint = <&funnel0_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <1>;
> +					merge_funnel_in2: endpoint {
> +						remote-endpoint = <&funnel2_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator@6046000 {
> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +			reg = <0 0x06046000 0 0x1000>;
> +
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					replicator_out: endpoint {
> +						remote-endpoint = <&etr_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					replicator_cx_in_swao_out: endpoint {
> +						remote-endpoint = <&replicator_swao_out_cx_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etr@6048000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06048000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,scatter-gather;
> +
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint = <&replicator_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6b04000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			arm,primecell-periphid = <0x000bb908>;
> +
> +			reg = <0 0x06b04000 0 0x1000>;
> +			reg-names = "funnel-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					merge_funnel_out: endpoint {
> +						remote-endpoint = <&etf_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@7 {
> +					reg = <7>;
> +					funnel_swao_in_funnel_merg: endpoint {
> +						remote-endpoint= <&funnel_merg_out_funnel_swao>;
> +					};
> +				};
> +			};
> +
> +		};
> +
> +		etf@6b05000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06b05000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					etf_out: endpoint {
> +						remote-endpoint = <&replicator_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <0>;
> +					etf_in: endpoint {
> +						remote-endpoint = <&merge_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator@6b06000 {
> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +			reg = <0 0x06b06000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					replicator_swao_out_cx_in: endpoint {
> +						remote-endpoint = <&replicator_cx_in_swao_out>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					replicator_in: endpoint {
> +						remote-endpoint = <&etf_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7040000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07040000 0 0x1000>;
> +
> +			cpu = <&CPU0>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7140000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07140000 0 0x1000>;
> +
> +			cpu = <&CPU1>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7240000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07240000 0 0x1000>;
> +
> +			cpu = <&CPU2>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in2>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7340000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07340000 0 0x1000>;
> +
> +			cpu = <&CPU3>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7440000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07440000 0 0x1000>;
> +
> +			cpu = <&CPU4>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in4>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7540000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07540000 0 0x1000>;
> +
> +			cpu = <&CPU5>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in5>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7640000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07640000 0 0x1000>;
> +
> +			cpu = <&CPU6>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in6>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7740000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07740000 0 0x1000>;
> +
> +			cpu = <&CPU7>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +			arm,coresight-loses-context-with-cpu;
> +
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint = <&apss_funnel_in7>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@7800000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x07800000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					apss_funnel_out: endpoint {
> +						remote-endpoint = <&apss_merge_funnel_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					apss_funnel_in0: endpoint {
> +						remote-endpoint = <&etm0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					apss_funnel_in1: endpoint {
> +						remote-endpoint = <&etm1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					apss_funnel_in2: endpoint {
> +						remote-endpoint = <&etm2_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					apss_funnel_in3: endpoint {
> +						remote-endpoint = <&etm3_out>;
> +					};
> +				};
> +
> +				port@4 {
> +					reg = <4>;
> +					apss_funnel_in4: endpoint {
> +						remote-endpoint = <&etm4_out>;
> +					};
> +				};
> +
> +				port@5 {
> +					reg = <5>;
> +					apss_funnel_in5: endpoint {
> +						remote-endpoint = <&etm5_out>;
> +					};
> +				};
> +
> +				port@6 {
> +					reg = <6>;
> +					apss_funnel_in6: endpoint {
> +						remote-endpoint = <&etm6_out>;
> +					};
> +				};
> +
> +				port@7 {
> +					reg = <7>;
> +					apss_funnel_in7: endpoint {
> +						remote-endpoint = <&etm7_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@7810000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +			reg = <0 0x07810000 0 0x1000>;
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					apss_merge_funnel_out: endpoint {
> +						remote-endpoint = <&funnel2_in5>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port@1 {
> +					reg = <0>;
> +					apss_merge_funnel_in: endpoint {
> +						remote-endpoint = <&apss_funnel_out>;
> +					};
> +				};
> +			};
> +		};
>   	};
>   
>   	timer {
