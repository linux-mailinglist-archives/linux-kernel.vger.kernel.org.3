Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD659788F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbiHQVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242277AbiHQVFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:05:04 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0015AB4EA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:05:02 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 22E651F425;
        Wed, 17 Aug 2022 23:05:00 +0200 (CEST)
Message-ID: <b50f554d-d6b0-5947-2557-d81bbfb1c2f9@somainline.org>
Date:   Wed, 17 Aug 2022 23:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 12/14] arm64: dts: qcom: qcs404: switch TCSR mutex
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
 <20220817130342.568396-13-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-13-krzysztof.kozlowski@linaro.org>
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
>   qcom/qcs404-evb-4000.dtb: hwlock: 'reg' is a required property
>   qcom/qcs404-evb-4000.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Not tested on a device, but looks good to the eye:
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 9ab990061522..3a94eb2cc448 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -295,12 +295,6 @@ smem {
>  		hwlocks = <&tcsr_mutex 3>;
>  	};
>  
> -	tcsr_mutex: hwlock {
> -		compatible = "qcom,tcsr-mutex";
> -		syscon = <&tcsr_mutex_regs 0 0x1000>;
> -		#hwlock-cells = <1>;
> -	};
> -
>  	soc: soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -726,9 +720,10 @@ gcc: clock-controller@1800000 {
>  			assigned-clock-rates = <19200000>;
>  		};
>  
> -		tcsr_mutex_regs: syscon@1905000 {
> -			compatible = "syscon";
> +		tcsr_mutex: hwlock@1905000 {
> +			compatible = "qcom,tcsr-mutex";
>  			reg = <0x01905000 0x20000>;
> +			#hwlock-cells = <1>;
>  		};
>  
>  		tcsr: syscon@1937000 {
