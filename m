Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F255978A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbiHQVEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbiHQVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:03:59 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F39A96E;
        Wed, 17 Aug 2022 14:03:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B0F751F425;
        Wed, 17 Aug 2022 23:03:54 +0200 (CEST)
Message-ID: <9170643e-ad89-d31c-0307-59dc737e362f@somainline.org>
Date:   Wed, 17 Aug 2022 23:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 10/14] arm64: dts: qcom: sdm845: split TCSR halt
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
 <20220817130342.568396-11-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-11-krzysztof.kozlowski@linaro.org>
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

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index f0e286715d1b..21ed14200986 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2590,7 +2590,12 @@ ipa: ipa@1e40000 {
>  
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
> -			reg = <0 0x01f40000 0 0x40000>;
> +			reg = <0 0x01f40000 0 0x20000>;
> +		};
> +
> +		tcsr_regs_1: sycon@1f60000 {
> +			compatible = "qcom,sdm845-tcsr", "syscon";
> +			reg = <0 0x01f60000 0 0x20000>;
>  		};
>  
>  		tlmm: pinctrl@3400000 {
> @@ -3207,7 +3212,7 @@ mss_pil: remoteproc@4080000 {
>  				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
>  			reset-names = "mss_restart", "pdc_reset";
>  
> -			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> +			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
>  
>  			power-domains = <&rpmhpd SDM845_CX>,
>  					<&rpmhpd SDM845_MX>,
