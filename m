Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91A59785E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbiHQVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiHQVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:00:28 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A654D149;
        Wed, 17 Aug 2022 14:00:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D577F1F4E1;
        Wed, 17 Aug 2022 23:00:23 +0200 (CEST)
Message-ID: <e3b8bd74-8fb0-e694-b33d-ec0182f78e8a@somainline.org>
Date:   Wed, 17 Aug 2022 23:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 04/14] arm64: dts: qcom: msm8998: split TCSR halt
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
 <20220817130342.568396-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220817130342.568396-5-krzysztof.kozlowski@linaro.org>
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
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 02d21bff2198..f0806ed103f1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1049,7 +1049,12 @@ ufsphy_lanes: phy@1da7400 {
>  
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
> -			reg = <0x01f40000 0x40000>;
> +			reg = <0x01f40000 0x20000>;
> +		};
> +
> +		tcsr_regs_1: sycon@1f60000 {
> +			compatible = "qcom,msm8998-tcsr", "syscon";
> +			reg = <0x01f60000 0x20000>;
>  		};
>  
>  		tlmm: pinctrl@3400000 {
> @@ -1340,7 +1345,7 @@ remoteproc_mss: remoteproc@4080000 {
>  			resets = <&gcc GCC_MSS_RESTART>;
>  			reset-names = "mss_restart";
>  
> -			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
> +			qcom,halt-regs = <&tcsr_regs_1 0x3000 0x5000 0x4000>;
>  
>  			power-domains = <&rpmpd MSM8998_VDDCX>,
>  					<&rpmpd MSM8998_VDDMX>;
