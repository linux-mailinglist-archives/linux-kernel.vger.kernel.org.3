Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40B2597887
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiHQVCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiHQVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:02:25 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A354AB414
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:02:23 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A63681F425;
        Wed, 17 Aug 2022 23:02:21 +0200 (CEST)
Message-ID: <ddede644-9980-79fa-4632-903f393a3aae@somainline.org>
Date:   Wed, 17 Aug 2022 23:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 07/14] arm64: dts: qcom: sc7180: split TCSR halt
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
 <20220817130342.568396-8-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-8-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Konrad
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 49f28cb531f6..5d2dd21da79c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1464,10 +1464,15 @@ ipa: ipa@1e40000 {
>  
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
> -			reg = <0 0x01f40000 0 0x40000>;
> +			reg = <0 0x01f40000 0 0x20000>;
>  		};
>  
> -		tcsr_regs: syscon@1fc0000 {
> +		tcsr_regs_1: sycon@1f60000 {
> +			compatible = "qcom,sc7180-tcsr", "syscon";
> +			reg = <0 0x01f60000 0 0x20000>;
> +		};
> +
> +		tcsr_regs_2: syscon@1fc0000 {
>  			compatible = "qcom,sc7180-tcsr", "syscon";
>  			reg = <0 0x01fc0000 0 0x40000>;
>  		};
> @@ -1932,8 +1937,8 @@ remoteproc_mpss: remoteproc@4080000 {
>  				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
>  			reset-names = "mss_restart", "pdc_reset";
>  
> -			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> -			qcom,spare-regs = <&tcsr_regs 0xb3e4>;
> +			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
> +			qcom,spare-regs = <&tcsr_regs_2 0xb3e4>;
>  
>  			status = "disabled";
>  
