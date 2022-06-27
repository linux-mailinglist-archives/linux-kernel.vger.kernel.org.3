Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8555CACB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiF0WC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbiF0V4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:56:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D927F18E33;
        Mon, 27 Jun 2022 14:55:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6F881758;
        Mon, 27 Jun 2022 14:55:18 -0700 (PDT)
Received: from [10.57.85.164] (unknown [10.57.85.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57D733F66F;
        Mon, 27 Jun 2022 14:55:17 -0700 (PDT)
Message-ID: <2cb087fe-21d8-7513-4e55-b836d7086a1c@arm.com>
Date:   Mon, 27 Jun 2022 22:55:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Convert CoreSight bindings to DT
 schema
To:     Rob Herring <robh@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220603011933.3277315-1-robh@kernel.org>
 <20220603011933.3277315-3-robh@kernel.org>
 <01e9e2a0-df0a-3b31-f819-d68c6eb0f01d@arm.com>
 <20220627201115.GA2870653-robh@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220627201115.GA2870653-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 21:11, Rob Herring wrote:
> On Mon, Jun 20, 2022 at 06:17:20PM +0100, Suzuki K Poulose wrote:
>> Hi Rob
>>
>> A big Thank You for the effort ! A minor comment below.
>>
>> On 03/06/2022 02:19, Rob Herring wrote:
>>> Each CoreSight component has slightly different requirements and
>>> nothing applies to every component, so each CoreSight component has its
>>> own schema document.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> --
>>> v2:
>>>    - Add missing arm,coresight-dynamic-replicator.yaml and
>>>      arm,coresight-static-funnel.yaml
>>>    - Update MAINTAINERS
>>>    - Fix coresight.txt references
>>>    - Fix double blank line
>>> ---
>>>    .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
>>>    .../bindings/arm/arm,coresight-cti.yaml       |   3 +-
>>>    .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
>>>    .../arm/arm,coresight-dynamic-replicator.yaml | 126 ++++++
>>>    .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
>>>    .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
>>>    .../arm/arm,coresight-static-funnel.yaml      |  89 ++++
>>>    .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
>>>    .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
>>>    .../bindings/arm/arm,coresight-tmc.yaml       | 131 ++++++
>>>    .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
>>>    .../arm/arm,embedded-trace-extension.yaml     |   1 -
>>>    .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
>>>    Documentation/trace/coresight/coresight.rst   |   2 +-
>>>    MAINTAINERS                                   |   3 +-
>>>    15 files changed, 1106 insertions(+), 408 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
>>>    create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
>>>    delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
>>>
>>
>> ...
>>
>>> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
>>> new file mode 100644
>>> index 000000000000..e0377ce48537
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
>>> @@ -0,0 +1,156 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/arm,coresight-etm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Arm CoreSight Embedded Trace MacroCell
>>> +
>>> +maintainers:
>>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>>> +  - Mike Leach <mike.leach@linaro.org>
>>> +  - Leo Yan <leo.yan@linaro.org>
>>> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
>>> +
>>> +description: |
>>> +  CoreSight components are compliant with the ARM CoreSight architecture
>>> +  specification and can be connected in various topologies to suit a particular
>>> +  SoCs tracing needs. These trace components can generally be classified as
>>> +  sinks, links and sources. Trace data produced by one or more sources flows
>>> +  through the intermediate links connecting the source to the currently selected
>>> +  sink.
>>> +
>>> +  The Embedded Trace Macrocell (ETM) is a real-time trace module providing
>>> +  instruction and data tracing of a processor.
>>> +
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - arm,coresight-etm3x
>>> +          - arm,coresight-etm4x
>>> +          - arm,coresight-etm4x-sysreg
>>> +  required:
>>> +    - compatible
>>> +
>>> +allOf:
>>> +  - if:
>>> +      not:
>>> +        properties:
>>> +          compatible:
>>> +            contains:
>>> +              const: arm,coresight-etm4x-sysreg
>>> +    then:
>>> +      $ref: /schemas/arm/primecell.yaml#
>>> +      required:
>>> +        - reg
> 
> 
> ^^^^
> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - description:
>>> +          Embedded Trace Macrocell with memory mapped access.
>>> +        items:
>>> +          - enum:
>>> +              - arm,coresight-etm3x
>>> +              - arm,coresight-etm4x
>>> +          - const: arm,primecell
>>> +      - description:
>>> +          Embedded Trace Macrocell (version 4.x), with system register access only
>>> +        const: arm,coresight-etm4x-sysreg
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>
>> The register field is mandatory for everything, except
>> arm,coresight-etm4x-sysreg. Is there a way to enforce that
>> selectively for the others ?
> 
> Yes, that's what it is doing up above that I flagged.
> 

Thanks for the claritification.

...

>>> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
>>> new file mode 100644
>>> index 000000000000..905008faa012
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
>>> @@ -0,0 +1,101 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/arm,coresight-stm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Arm CoreSight System Trace MacroCell
>>> +
>>> +maintainers:
>>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>>> +  - Mike Leach <mike.leach@linaro.org>
>>> +  - Leo Yan <leo.yan@linaro.org>
>>> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
>>> +
>>> +description: |
>>> +  CoreSight components are compliant with the ARM CoreSight architecture
>>> +  specification and can be connected in various topologies to suit a particular
>>> +  SoCs tracing needs. These trace components can generally be classified as
>>> +  sinks, links and sources. Trace data produced by one or more sources flows
>>> +  through the intermediate links connecting the source to the currently selected
>>> +  sink.
>>> +
>>> +  The STM is a trace source that is integrated into a CoreSight system, designed
>>> +  primarily for high-bandwidth trace of instrumentation embedded into software.
>>> +  This instrumentation is made up of memory-mapped writes to the STM Advanced
>>> +  eXtensible Interface (AXI) slave, which carry information about the behavior
>>> +  of the software.
>>> +
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: arm,coresight-stm
>>> +  required:
>>> +    - compatible
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/arm/primecell.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: arm,coresight-stm
>>> +      - const: arm,primecell
>>> +
>>> +  reg:
>>> +    maxItems: 2
>>
>> stm-stimulus-base is mandatory for stm. So I believe, we should add
>>
>> 	minItems: 2
>> above ?
> 
> That's the default if not explicit.

Ok. So, with the above explanation, ( with gratitude )

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
