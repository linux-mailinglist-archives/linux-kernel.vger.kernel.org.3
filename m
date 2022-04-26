Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6701E50FC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbiDZLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbiDZLws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:52:48 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21463C4B9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:49:39 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 66FBB3F67B;
        Tue, 26 Apr 2022 13:49:35 +0200 (CEST)
Message-ID: <a5daf7ed-9baa-5684-4823-30b0cca69488@somainline.org>
Date:   Tue, 26 Apr 2022 13:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v6 10/10] ARM: dts: msm: Add tpdm mm/prng for sm8250
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
 <20220425040304.37487-11-quic_jinlmao@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220425040304.37487-11-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/04/2022 06:03, Mao Jinlong wrote:
> Add tpdm mm and tpdm prng for sm8250.
>
> +---------------+                +-------------+
> |  tpdm@6c08000 |                |tpdm@684C000 |
> +-------|-------+                +------|------+
>          |                               |
> +-------|-------+                       |
> | funnel@6c0b000|                       |
> +-------|-------+                       |
>          |                               |
> +-------|-------+                       |
> |funnel@6c2d000 |                       |
> +-------|-------+                       |
>          |                               |
>          |    +---------------+          |
>          +----- tpda@6004000  -----------+
>               +-------|-------+
>                       |
>               +-------|-------+
>               |funnel@6005000 |
>               +---------------+
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 170 +++++++++++++++++++++++++++
>   1 file changed, 170 insertions(+)

Hi,


some of the previous comments (uppercase hex instead of lowercase and 
wrong commit title) still haven't been addressed.


Konrad

> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 53ab2b457a2f..ce558a2639e7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4703,6 +4703,73 @@
>   			};
>   		};
>   
> +		tpda@6004000 {
> +			compatible = "arm,primecell";
> +			reg = <0 0x06004000 0 0x1000>;
> +			reg-names = "tpda-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					reg = <0>;
> +					tpda_out_funnel_qatb: endpoint {
> +						remote-endpoint = <&funnel_qatb_in_tpda>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@9 {
> +					reg = <9>;
> +					tpda_9_in_tpdm_mm: endpoint {
> +						remote-endpoint = <&tpdm_mm_out_tpda9>;
> +					};
> +				};
> +
> +				port@23 {
> +					reg = <23>;
> +					tpda_23_in_tpdm_prng: endpoint {
> +						remote-endpoint = <&tpdm_prng_out_tpda_23>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6005000 {
> +			compatible = "arm,primecell";
> +
> +			reg = <0 0x06005000 0 0x1000>;
> +			reg-names = "funnel-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_qatb_out_funnel_in0: endpoint {
> +						remote-endpoint = <&funnel_in0_in_funnel_qatb>;
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
> +					funnel_qatb_in_tpda: endpoint {
> +						remote-endpoint = <&tpda_out_funnel_qatb>;
> +					};
> +				};
> +			};
> +		};
> +
>   		funnel@6041000 {
>   			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>   			reg = <0 0x06041000 0 0x1000>;
> @@ -4722,6 +4789,13 @@
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> +				port@6 {
> +					reg = <6>;
> +					funnel_in0_in_funnel_qatb: endpoint {
> +						remote-endpoint = <&funnel_qatb_out_funnel_in0>;
> +					};
> +				};
> +
>   				port@7 {
>   					reg = <7>;
>   					funnel0_in7: endpoint {
> @@ -4836,6 +4910,23 @@
>   			};
>   		};
>   
> +		tpdm@684C000 {
> +			compatible = "arm,primecell";
> +			reg = <0 0x0684C000 0 0x1000>;
> +			reg-names = "tpdm-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					tpdm_prng_out_tpda_23: endpoint {
> +						remote-endpoint = <&tpda_23_in_tpdm_prng>;
> +					};
> +				};
> +			};
> +		};
> +
>   		funnel@6b04000 {
>   			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>   			arm,primecell-periphid = <0x000bb908>;
> @@ -4920,6 +5011,85 @@
>   			};
>   		};
>   
> +		tpdm@6c08000 {
> +			compatible = "arm,primecell";
> +			reg = <0 0x06c08000 0 0x1000>;
> +			reg-names = "tpdm-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					tpdm_mm_out_funnel_dl_mm: endpoint {
> +						remote-endpoint = <&funnel_dl_mm_in_tpdm_mm>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6c0b000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +			reg = <0 0x06c0b000 0 0x1000>;
> +			reg-names = "funnel-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				port {
> +					funnel_dl_mm_out_funnel_dl_center: endpoint {
> +						remote-endpoint = <&funnel_dl_center_in_funnel_dl_mm>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@3 {
> +					reg = <3>;
> +					funnel_dl_mm_in_tpdm_mm: endpoint {
> +						remote-endpoint = <&tpdm_mm_out_funnel_dl_mm>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6c2d000 {
> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +
> +			reg = <0 0x06c2d000 0 0x1000>;
> +			reg-names = "funnel-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port {
> +					tpdm_mm_out_tpda9: endpoint {
> +						remote-endpoint = <&tpda_9_in_tpdm_mm>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@2 {
> +					reg = <2>;
> +					funnel_dl_center_in_funnel_dl_mm: endpoint {
> +						remote-endpoint = <&funnel_dl_mm_out_funnel_dl_center>;
> +					};
> +				};
> +			};
> +		};
> +
>   		etm@7040000 {
>   			compatible = "arm,coresight-etm4x", "arm,primecell";
>   			reg = <0 0x07040000 0 0x1000>;
