Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172465792DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiGSF50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiGSF5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:57:24 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9D2AC6E;
        Mon, 18 Jul 2022 22:57:23 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Jul
 2022 13:57:21 +0800
Message-ID: <3cc2e18a-1813-9939-4808-a59858f6451e@amlogic.com>
Date:   Tue, 19 Jul 2022 13:57:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] arm64: dts: meson: add S4 Soc clock controller in DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-3-yu.tu@amlogic.com>
 <f5b3e2de-ec60-88ee-4066-6b3860b6c89a@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <f5b3e2de-ec60-88ee-4066-6b3860b6c89a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
	Thank you for your advice.

On 2022/7/12 17:41, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 08/07/2022 08:27, Yu Tu wrote:
>> Added information about the S4 SOC Clock controller in DT.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index ff213618a598..ad2ec26a1f4a 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -86,7 +86,7 @@ gic: interrupt-controller@fff01000 {
>>   		};
>>   
>>   		apb4: apb4@fe000000 {
>> -			compatible = "simple-bus";
>> +			compatible = "simple-bus", "syscon";
> 
> This is not allowed.
> 1. syscon needs also dedicated compatible
> 2. simple-bus with syscon means it is not a simple bus anymore, so nope.
I will correct it.
> 
>>   			reg = <0x0 0xfe000000 0x0 0x480000>;
>>   			#address-cells = <2>;
>>   			#size-cells = <2>;
>> @@ -118,6 +118,13 @@ gpio_intc: interrupt-controller@4080 {
>>   					<10 11 12 13 14 15 16 17 18 19 20 21>;
>>   			};
>>   
>> +			clkc: clock-controller {
>> +				compatible = "amlogic,s4-clkc";
>> +				#clock-cells = <1>;
>> +				clocks = <&xtal>;
>> +				clock-names = "xtal";
>> +			};
>> +
>>   			uart_B: serial@7a000 {
>>   				compatible = "amlogic,meson-s4-uart",
>>   					     "amlogic,meson-ao-uart";
> 
> 
> Best regards,
> Krzysztof
> 
> .
