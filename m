Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A920C58A918
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiHEJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiHEJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:57:43 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7D13E0E;
        Fri,  5 Aug 2022 02:57:42 -0700 (PDT)
Received: from [10.88.19.200] (10.88.19.200) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.6; Fri, 5 Aug 2022
 17:57:37 +0800
Message-ID: <0fac4541-0d05-1076-487b-86a7b92da71e@amlogic.com>
Date:   Fri, 5 Aug 2022 17:57:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4 3/4] arm64: dts: meson: Add DDR PMU node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <20220805071426.2598818-3-jiucheng.xu@amlogic.com>
 <e963157e-5ff0-f0c1-2299-50528cf291c3@linaro.org>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <e963157e-5ff0-f0c1-2299-50528cf291c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.19.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/5 16:22, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 05/08/2022 09:14, Jiucheng Xu wrote:
>> Add DDR PMU device node for G12 series SoC
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>> Changes v3 -> v4:
>>    - No change
>>
>> Changes v2 -> v3:
>>    - No change
>>
>> Changes v1 -> v2:
>>    - Remove model, dmc_nr, chann_nr properties
>>    - Add g12a-ddr-pmu, g12b-ddr-pmu, sm1-ddr-pmu compatibles as
>>      identifier
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 7 +++++++
>>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 4 ++++
>>   arch/arm64/boot/dts/amlogic/meson-g12b.dtsi       | 4 ++++
>>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 4 ++++
>>   4 files changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index 45947c1031c4..7e556fe575be 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -2146,6 +2146,13 @@ hdmi_tx_out: endpoint {
>>   			};
>>   		};
>>   
>> +		ddr_pmu: ddr_pmu@ff638000 {
> No underscores in node names.
>
> Node names should be generic, so pmu.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Okay, I will modify it.
>
>> +			compatible = "amlogic,g12-ddr-pmu";
>> +			reg = <0x0 0xff638000 0x0 0x100
>> +			       0x0 0xff638c00 0x0 0x100>;
>> +			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +
>>   		gic: interrupt-controller@ffc01000 {
>>   			compatible = "arm,gic-400";
>>   			reg = <0x0 0xffc01000 0 0x1000>,
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index fb0ab27d1f64..4a32e081e70e 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -133,3 +133,7 @@ map1 {
>>   		};
>>   	};
>>   };
>> +
>> +&ddr_pmu {
>> +	compatible = "amlogic,g12a-ddr-pmu";
>> +};
> Adding nodes at the end causes conflicts. They should be added in some
> order...
Is alphabetical order okay?
>
> Best regards,
> Krzysztof
>
-- 
Thanks,
Jiucheng

