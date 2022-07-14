Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEE5747FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiGNJNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiGNJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:13:09 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF322B34;
        Thu, 14 Jul 2022 02:13:08 -0700 (PDT)
Received: from [10.88.19.41] (10.88.19.41) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server id 15.1.2176.2; Thu, 14 Jul 2022 17:13:06 +0800
Message-ID: <79ff63fc-dbd7-bc31-ebe7-7d15d121add1@amlogic.com>
Date:   Thu, 14 Jul 2022 17:13:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 4/4] dt-binding:perf: Add Amlogic DDR PMU
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
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
References: <20220712063641.2790997-1-jiucheng.xu@amlogic.com>
 <20220712063641.2790997-4-jiucheng.xu@amlogic.com>
 <94ab770b-8a8a-4299-a54e-2ff77afb9e04@arm.com>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <94ab770b-8a8a-4299-a54e-2ff77afb9e04@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.88.19.41]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2022 8:54 PM, Robin Murphy wrote:
> [ EXTERNAL EMAIL ]
>
> On 2022-07-12 07:36, Jiucheng Xu wrote:
>> Add binding documentation for the Amlogic G12 series DDR
>> performance monitor unit.
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>>   .../devicetree/bindings/perf/aml-ddr-pmu.yaml | 51 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 52 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml 
>> b/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
>> new file mode 100644
>> index 000000000000..c586b4ab4009
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/aml-ddr-pmu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic G12 DDR performance monitor
>> +
>> +maintainers:
>> +  - Jiucheng Xu <jiucheng.xu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - aml,g12-ddr-pmu
>> +      - items:
>> +          - enum:
>> +              - aml,g12-ddr-pmu
>> +          - const: aml,g12-ddr-pmu
>
> Judging by what the driver actually implements, this should probably be:
>
>   compatible:
>     items:
>       - enum:
>         - amlogic,g12a-ddr-pmu
>         - amlogic,g12b-ddr-pmu
>         - amlogic,sm1-ddr-pmu
>       - const: amlogic,g12-ddr-pmu
>
> There doesn't seem much point in allowing only the common compatible 
> without a SoC-specific identifier. Note also that "aml," is not the 
> documented vendor prefix.
Okay, I finally know what you mean.
>
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - model
>
> Remove this, and use the compatible strings properly as above.
Okay. I will make the change.
>
>> +  - dmc_nr
>> +  - chann_nr
>
> I suspect those could probably be inferred from the correct compatible 
> string, but if not (i.e. within one SoC you have multiple PMUs 
> supporting the same events but with different numbers of usable 
> channels), then document what exactly they mean.
>
Yes, as you mentioned, these could be inferred from the compatible 
string. I will make the change.
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>
> As mentioned in the driver review, if you really want to use a named 
> interrupt (which should usually be unnecessary when there's only one), 
> it has to be a defined name. DT is not a mechanism for overriding what 
> Linux shows in /proc/interrupts.
>
> Thanks,
> Robin.
>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +          ddr_pmu: ddr_pmu {
>> +                  compatible = "amlogic,g12-ddr-pmu";
>> +                  model = "g12a";
>> +                  dmc_nr = <1>;
>> +                  chann_nr = <4>;
>> +                  reg = <0x0 0xff638000 0x0 0x100
>> +                         0x0 0xff638c00 0x0 0x100>;
>> +                  interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
>> +                  interrupt-names = "ddr_pmu";
>> +          };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fd2a56a339b4..ac0a1df4622d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1055,6 +1055,7 @@ M:    Jiucheng Xu <jiucheng.xu@amlogic.com>
>>   S:    Supported
>>   W:    http://www.amlogic.com
>>   F:    Documentation/admin-guide/perf/aml-ddr-pmu.rst
>> +F:    Documentation/devicetree/bindings/perf/aml-ddr-pmu.yaml
>>   F:    drivers/perf/amlogic/
>>   F:    include/soc/amlogic/
>
