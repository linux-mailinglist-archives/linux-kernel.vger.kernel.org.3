Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E71958FA03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiHKJ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiHKJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:25:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F8AD3D588;
        Thu, 11 Aug 2022 02:25:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1154B106F;
        Thu, 11 Aug 2022 02:25:40 -0700 (PDT)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8C3E3F70D;
        Thu, 11 Aug 2022 02:25:33 -0700 (PDT)
Message-ID: <fe9d9673-e133-3230-01b5-df463c315026@arm.com>
Date:   Thu, 11 Aug 2022 14:55:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Add Coresight support
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
References: <1632477981-13632-1-git-send-email-quic_taozha@quicinc.com>
 <1632477981-13632-3-git-send-email-quic_taozha@quicinc.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1632477981-13632-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/21 15:36, Tao Zhang wrote:
> Add the basic coresight components found on Qualcomm SM8250 Soc. The
> basic coresight components include ETF, ETMs,STM and the related
> funnels.

Hello,

Seems like this patch never merged mainline, what happened ? This change is
required to enable coresight devices on RB5 platform.

- Anshuman

> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 439 +++++++++++++++++++++++++++++++
>  1 file changed, 439 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 5f41de2..1e1579a 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -223,6 +223,445 @@
>  		regulator-max-microvolt = <1800000>;
>  		regulator-always-on;
>  	};
> +
> +	stm@6002000 {
> +		compatible = "arm,coresight-stm", "arm,primecell";
> +		reg = <0 0x06002000 0 0x1000>,
> +		      <0 0x16280000 0 0x180000>;
> +		reg-names = "stm-base", "stm-stimulus-base";
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				stm_out: endpoint {
> +					remote-endpoint =
> +					  <&funnel0_in7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6041000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06041000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel0_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in0>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@7 {
> +				reg = <7>;
> +				funnel0_in7: endpoint {
> +					remote-endpoint = <&stm_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6042000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06042000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				funnel2_out: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_in2>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@4 {
> +				reg = <4>;
> +				funnel2_in5: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@6b04000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		arm,primecell-periphid = <0x000bb908>;
> +
> +		reg = <0 0x6b04000 0 0x1000>;
> +		reg-names = "funnel-base";
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				merge_funnel_out: endpoint {
> +					remote-endpoint =
> +						<&etf_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@7 {
> +				reg = <7>;
> +				swao_funnel_in7: endpoint {
> +					slave-mode;
> +					remote-endpoint=
> +						<&merg_funnel_out>;
> +				};
> +			};
> +		};
> +
> +	};
> +
> +	funnel@6045000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x06045000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				merg_funnel_out: endpoint {
> +					remote-endpoint = <&swao_funnel_in7>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				merge_funnel_in0: endpoint {
> +					remote-endpoint =
> +					  <&funnel0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				merge_funnel_in2: endpoint {
> +					remote-endpoint =
> +					  <&funnel2_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etf@6b05000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0 0x06b05000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		in-ports {
> +			port {
> +				etf_in: endpoint {
> +					remote-endpoint =
> +					  <&merge_funnel_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7040000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07040000 0 0x1000>;
> +
> +		cpu = <&CPU0>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm0_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in0>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7140000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07140000 0 0x1000>;
> +
> +		cpu = <&CPU1>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm1_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in1>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7240000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07240000 0 0x1000>;
> +
> +		cpu = <&CPU2>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm2_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in2>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7340000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07340000 0 0x1000>;
> +
> +		cpu = <&CPU3>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm3_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in3>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7440000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07440000 0 0x1000>;
> +
> +		cpu = <&CPU4>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm4_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in4>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7540000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07540000 0 0x1000>;
> +
> +		cpu = <&CPU5>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm5_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in5>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7640000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07640000 0 0x1000>;
> +
> +		cpu = <&CPU6>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm6_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in6>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm@7740000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x07740000 0 0x1000>;
> +
> +		cpu = <&CPU7>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +		arm,coresight-loses-context-with-cpu;
> +
> +		out-ports {
> +			port {
> +				etm7_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_in7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7800000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x07800000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				apss_funnel_out: endpoint {
> +					remote-endpoint =
> +					  <&apss_merge_funnel_in>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				apss_funnel_in0: endpoint {
> +					remote-endpoint =
> +					  <&etm0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				apss_funnel_in1: endpoint {
> +					remote-endpoint =
> +					  <&etm1_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				apss_funnel_in2: endpoint {
> +					remote-endpoint =
> +					  <&etm2_out>;
> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				apss_funnel_in3: endpoint {
> +					remote-endpoint =
> +					  <&etm3_out>;
> +				};
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				apss_funnel_in4: endpoint {
> +					remote-endpoint =
> +					  <&etm4_out>;
> +				};
> +			};
> +
> +			port@5 {
> +				reg = <5>;
> +				apss_funnel_in5: endpoint {
> +					remote-endpoint =
> +					  <&etm5_out>;
> +				};
> +			};
> +
> +			port@6 {
> +				reg = <6>;
> +				apss_funnel_in6: endpoint {
> +					remote-endpoint =
> +					  <&etm6_out>;
> +				};
> +			};
> +
> +			port@7 {
> +				reg = <7>;
> +				apss_funnel_in7: endpoint {
> +					remote-endpoint =
> +					  <&etm7_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	funnel@7810000 {
> +		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> +		reg = <0 0x07810000 0 0x1000>;
> +
> +		clocks = <&aoss_qmp>;
> +		clock-names = "apb_pclk";
> +
> +		out-ports {
> +			port {
> +				apss_merge_funnel_out: endpoint {
> +					remote-endpoint =
> +					  <&funnel2_in5>;
> +				};
> +			};
> +		};
> +
> +		in-ports {
> +			port {
> +				apss_merge_funnel_in: endpoint {
> +					remote-endpoint =
> +					  <&apss_funnel_out>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &adsp {
