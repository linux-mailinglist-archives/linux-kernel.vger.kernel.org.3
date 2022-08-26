Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6855A2F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbiHZSwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345386AbiHZSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:51:49 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2FE2C57;
        Fri, 26 Aug 2022 11:47:52 -0700 (PDT)
Received: from [192.168.1.101] (afbd60.neoplus.adsl.tpnet.pl [95.49.29.60])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3A4A53F6BE;
        Fri, 26 Aug 2022 20:47:34 +0200 (CEST)
Message-ID: <99337b67-affa-a969-e2e3-f624c9ba0b31@somainline.org>
Date:   Fri, 26 Aug 2022 20:47:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v3 15/16] arm64: dts: qcom: sm8150: split TCSR halt
 regs out of mutex
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
 <20220819083209.50844-16-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220819083209.50844-16-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.08.2022 10:32, Krzysztof Kozlowski wrote:
> The TCSR halt regs are next to TCSR mutex (in one address block called
> TCSR_MUTEX), so before converting the TCSR mutex into device with
> address space, we need to split the halt regs to its own syscon device.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
> 
> Changes since v2:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 7d509ecd44da..6df2e6828282 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -2056,7 +2056,12 @@ ipa_virt: interconnect@1e00000 {
>  
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
> -			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			reg = <0x0 0x01f40000 0x0 0x20000>;
> +		};
> +
> +		tcsr_regs_1: sycon@1f60000 {
> +			compatible = "qcom,sm8150-tcsr", "syscon";
> +			reg = <0x0 0x01f60000 0x0 0x20000>;
>  		};
>  
>  		remoteproc_slpi: remoteproc@2400000 {
