Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725451318D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbiD1Kqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbiD1Kqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:46:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B1ED86AEC;
        Thu, 28 Apr 2022 03:43:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963DB1474;
        Thu, 28 Apr 2022 03:43:10 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EEF53F774;
        Thu, 28 Apr 2022 03:43:07 -0700 (PDT)
Message-ID: <1d1aae6e-50db-d6db-9727-62f9c2d1ca6b@arm.com>
Date:   Thu, 28 Apr 2022 11:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 04/10] arm64: dts: juno: use proper
 'dma-channels/requests' properties
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <20220427155840.596535-5-krzysztof.kozlowski@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220427155840.596535-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-27 16:58, Krzysztof Kozlowski wrote:
> pl330 DMA controller bindings documented 'dma-channels' and
> 'dma-requests' properties (without leading hash sign), so fix the DTS to
> match the bindings.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 4f40a5c8f565..96ef0ddc0b2d 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -829,8 +829,8 @@ dma-controller@7ff00000 {
>   		compatible = "arm,pl330", "arm,primecell";
>   		reg = <0x0 0x7ff00000 0 0x1000>;
>   		#dma-cells = <1>;
> -		#dma-channels = <8>;
> -		#dma-requests = <32>;
> +		dma-channels = <8>;
> +		dma-requests = <32>;

BTW, this has always been wrong - Juno is configured with only 8 request 
interfaces. But then it's moot anyway since PL330 has an ID register for 
this stuff[1], so the DT properties aren't used by Linux, and shouldn't 
be needed in general.

Thanks,
Robin.

[1] 
https://developer.arm.com/documentation/ddi0424/d/programmers-model/register-descriptions/configuration-register-0?lang=en

>   		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
