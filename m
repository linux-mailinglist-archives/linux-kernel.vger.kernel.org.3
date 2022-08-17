Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46D597863
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbiHQU7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbiHQU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:59:47 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC78AB424;
        Wed, 17 Aug 2022 13:59:40 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B33F91F643;
        Wed, 17 Aug 2022 22:59:37 +0200 (CEST)
Message-ID: <42f239d3-aa0a-b1e1-539c-acdb844bcded@somainline.org>
Date:   Wed, 17 Aug 2022 22:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 03/14] arm64: dts: qcom: msm8996: switch TCSR mutex
 to MMIO
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
 <20220817130342.568396-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-4-krzysztof.kozlowski@linaro.org>
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
> The TCSR mutex bindings allow device to be described only with address
> space (so it uses MMIO, not syscon regmap).  This seems reasonable as
> TCSR mutex is actually a dedicated IO address space and it also fixes DT
> schema checks:
> 
>   qcom/msm8996-xiaomi-natrium.dtb: hwlock: 'reg' is a required property
>   qcom/msm8996-xiaomi-natrium.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Not tested on a device, but looks good to the eye:
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 3411ced96db6..166374566a49 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -363,12 +363,6 @@ scm {
>  		};
>  	};
>  
> -	tcsr_mutex: hwlock {
> -		compatible = "qcom,tcsr-mutex";
> -		syscon = <&tcsr_mutex_regs 0 0x1000>;
> -		#hwlock-cells = <1>;
> -	};
> -
>  	memory@80000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the reg */
> @@ -838,9 +832,10 @@ pnoc: interconnect@5c0000 {
>  				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
>  		};
>  
> -		tcsr_mutex_regs: syscon@740000 {
> -			compatible = "syscon";
> +		tcsr_mutex: hwlock@740000 {
> +			compatible = "qcom,tcsr-mutex";
>  			reg = <0x00740000 0x20000>;
> +			#hwlock-cells = <1>;
>  		};
>  
>  		tcsr_1: sycon@760000 {
