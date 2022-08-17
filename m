Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5727B59789D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiHQVDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242248AbiHQVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:03:34 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B36013D12;
        Wed, 17 Aug 2022 14:03:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9FC3C1F425;
        Wed, 17 Aug 2022 23:03:23 +0200 (CEST)
Message-ID: <b61c9896-cddd-6c93-7b48-4f2795e5636f@somainline.org>
Date:   Wed, 17 Aug 2022 23:03:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 09/14] arm64: dts: qcom: sc7280: split TCSR halt
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
 <20220817130342.568396-10-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-10-krzysztof.kozlowski@linaro.org>
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
> and their IO address space, and allows to remove incorrect syscon
> compatible from TCSR mutex:
> 
>   qcom/sc7280-herobrine-crd.dtb: hwlock@1f40000: compatible: ['qcom,tcsr-mutex', 'syscon'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Not tested on a device, but looks good to the eye:
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 13d7f267b289..89a8e6b9822a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2155,12 +2155,17 @@ ipa: ipa@1e40000 {
>  		};
>  
>  		tcsr_mutex: hwlock@1f40000 {
> -			compatible = "qcom,tcsr-mutex", "syscon";
> -			reg = <0 0x01f40000 0 0x40000>;
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0 0x01f40000 0 0x20000>;
>  			#hwlock-cells = <1>;
>  		};
>  
> -		tcsr: syscon@1fc0000 {
> +		tcsr_1: sycon@1f60000 {
> +			compatible = "qcom,sc7280-tcsr", "syscon";
> +			reg = <0 0x01f60000 0 0x20000>;
> +		};
> +
> +		tcsr_2: syscon@1fc0000 {
>  			compatible = "qcom,sc7280-tcsr", "syscon";
>  			reg = <0 0x01fc0000 0 0x30000>;
>  		};
> @@ -2522,9 +2527,9 @@ remoteproc_mpss: remoteproc@4080000 {
>  				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
>  			reset-names = "mss_restart", "pdc_reset";
>  
> -			qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
> -			qcom,ext-regs = <&tcsr 0x10000 0x10004 &tcsr_mutex 0x26004 0x26008>;
> -			qcom,qaccept-regs = <&tcsr_mutex 0x23030 0x23040 0x23020>;
> +			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x8000 0x13000>;
> +			qcom,ext-regs = <&tcsr_2 0x10000 0x10004 &tcsr_1 0x6004 0x6008>;
> +			qcom,qaccept-regs = <&tcsr_1 0x3030 0x3040 0x3020>;
>  
>  			status = "disabled";
>  
> @@ -3259,7 +3264,7 @@ remoteproc_wpss: remoteproc@8a00000 {
>  				 <&pdc_reset PDC_WPSS_SYNC_RESET>;
>  			reset-names = "restart", "pdc_sync";
>  
> -			qcom,halt-regs = <&tcsr_mutex 0x37000>;
> +			qcom,halt-regs = <&tcsr_1 0x17000>;
>  
>  			status = "disabled";
>  
