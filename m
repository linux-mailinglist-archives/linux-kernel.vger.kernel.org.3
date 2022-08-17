Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA1597856
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbiHQU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbiHQU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:58:20 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D45AB1A7;
        Wed, 17 Aug 2022 13:57:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CCB1D1F635;
        Wed, 17 Aug 2022 22:57:53 +0200 (CEST)
Message-ID: <fd1492fa-4244-b283-d2a6-b4ffac7d53d6@somainline.org>
Date:   Wed, 17 Aug 2022 22:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 02/14] arm64: dts: qcom: msm8996: split TCSR halt
 regs out of mutex
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
 <20220817130342.568396-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-3-krzysztof.kozlowski@linaro.org>
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



On 17.08.2022 15:03, Krzysztof Kozlowski wrote:
> The TCSR halt regs are next to TCSR mutex, so before converting the TCSR
> mutex into device with address space, we need to split the halt regs to
> its own syscon device.  This also describes more accurately the devices
> and their IO address space.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Not tested on a device, but looks good to the eye:
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

On a note, are they really named TCSR_1 and TCSR_2 in the docs?
Qualcomm is usually more exquisite in their naming :P

Konrad
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 742eac4ce9b3..3411ced96db6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -359,7 +359,7 @@ opp-2150400000 {
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-msm8996", "qcom,scm";
> -			qcom,dload-mode = <&tcsr 0x13000>;
> +			qcom,dload-mode = <&tcsr_2 0x13000>;
>  		};
>  	};
>  
> @@ -840,10 +840,15 @@ pnoc: interconnect@5c0000 {
>  
>  		tcsr_mutex_regs: syscon@740000 {
>  			compatible = "syscon";
> -			reg = <0x00740000 0x40000>;
> +			reg = <0x00740000 0x20000>;
>  		};
>  
> -		tcsr: syscon@7a0000 {
> +		tcsr_1: sycon@760000 {
> +			compatible = "qcom,tcsr-msm8996", "syscon";
> +			reg = <0x00760000 0x20000>;
> +		};
> +
> +		tcsr_2: syscon@7a0000 {
>  			compatible = "qcom,tcsr-msm8996", "syscon";
>  			reg = <0x007a0000 0x18000>;
>  		};
> @@ -2413,7 +2418,7 @@ mss_pil: remoteproc@2080000 {
>  			qcom,smem-states = <&mpss_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
>  
> -			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> +			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x4000>;
>  
>  			status = "disabled";
>  
