Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5341583B82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiG1JuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiG1JuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:50:02 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEBC65D4D;
        Thu, 28 Jul 2022 02:50:01 -0700 (PDT)
Received: from [10.88.19.200] (10.88.19.200) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Thu, 28 Jul 2022
 17:49:58 +0800
Message-ID: <e539af08-5eac-9bdc-9807-936172b1b1fe@amlogic.com>
Date:   Thu, 28 Jul 2022 17:50:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2 4/4] dt-binding: perf: Add Amlogic DDR PMU
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
References: <20220726230329.2844101-1-jiucheng.xu@amlogic.com>
 <20220726230329.2844101-4-jiucheng.xu@amlogic.com>
 <a45957f9-bb51-8774-8f2f-675fd8314698@linaro.org>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <a45957f9-bb51-8774-8f2f-675fd8314698@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.19.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/27 15:09, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 27/07/2022 01:03, Jiucheng Xu wrote:
>> Add binding documentation for the Amlogic G12 series DDR
>> performance monitor unit.
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
>> ---
>> Changes v1 -> v2:
>>    - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>>    - Delete "model", "dmc_nr", "chann_nr" new properties
>>    - Fix compiling error
>> ---
>>   .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 45 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>
>> diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>> new file mode 100644
>> index 000000000000..46ef52b61492
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic G12 DDR performance monitor
>> +
>> +maintainers:
>> +  - Jiucheng Xu <jiucheng.xu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
> That's not oneOf...
>
>> +      - items:
>> +          - enum:
>> +              - amlogic,g12b-ddr-pmu
>> +                amlogic,g12a-ddr-pmu
>> +                amlogic,sm1-ddr-pmu
>> +          - const: amlogic,g12-ddr-pmu
>> +
>> +  reg:
>> +    maxItems: 2
> You need to list and describe the items.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ddr_pmu: ddr_pmu {
>> +
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> Code looks terrible...
>
>> +
>> +        compatible = "amlogic,g12a-ddr-pmu";
>> +        reg = <0x0 0xff638000 0x0 0x100
>> +               0x0 0xff638c00 0x0 0x100>;
> That's one item. You need to separate regs.
>
>
>
> Best regards,
> Krzysztof
Thanks for your comments. Once I thought the example DTB got generated 
means the yaml file is ok. I will learn the writing-schema. rst doc and 
modify the binding doc as your comments.

-- 
Thanks,
Jiucheng

