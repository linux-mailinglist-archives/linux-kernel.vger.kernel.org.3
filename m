Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3C4FF878
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiDMOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiDMOGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:06:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC45C3F;
        Wed, 13 Apr 2022 07:04:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 6132B1F45755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649858660;
        bh=+Sdn444MXOXX+FqFQqg2u1NRK2dOFaGDrORKtiAFIdo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KJLcF6FuhieJivpSA1iCfs8nTFb4VbkZsgYeo4PY6Hyse8qMzDlc6ypp7jAwYiWpL
         P9ikHIKv9kIJtwE2WUZ/mMVzc8CA3pW64pDlKkcSDEm5MAEb+6Mh03KlvpuNAwjLP6
         duU7SGyXa+JAlh+dX7oQ0ui3ONeQdqF3AlHcPggngHYZkmjqemkcc5VDZvu687uwc1
         FpYXLx7bHYXwm+zQkthAM0CkjsDdfbOjUbcWffQpH47TGZt+0u/Z2f8ctVfEQ+mkOF
         8YtfuhkBbMKlJ4/emTd+IboUAX5TgBpSFgYH4wzmp+lxhBqeZ9E3jeCaBM4KCZCdGw
         OJ9xibnqNjcyQ==
Message-ID: <b050247d-a62c-62e7-7750-24cefcc93506@collabora.com>
Date:   Wed, 13 Apr 2022 17:04:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names
 validation
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Cc:     digetx@gmail.com, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-4-amhetre@nvidia.com>
 <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <YlbSGEBKgpVC51dZ@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 16:37, Rob Herring wrote:
> On Wed, Apr 13, 2022 at 03:10:11PM +0530, Ashish Mhetre wrote:
>> From tegra186 onwards, memory controller support multiple channels.
>> Reg items are updated with address and size of these channels.
>> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
>> have overall 17 memory controller channels each.
>> There is 1 reg item for memory controller stream-id registers.
>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
>> Also update validation for reg-names added for these corresponding reg
>> items.
> 
> Somehow your subject should indicate this is for Tegra.
> 
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>  .../nvidia,tegra186-mc.yaml                   | 80 +++++++++++++++++--
>>  1 file changed, 74 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> index 13c4c82fd0d3..c7cfa6c2cd81 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> @@ -34,8 +34,12 @@ properties:
>>            - nvidia,tegra234-mc
>>  
>>    reg:
>> -    minItems: 1
>> -    maxItems: 3
>> +    minItems: 6
> 
> You just broke current users.
> 
>> +    maxItems: 18
>> +
>> +  reg-names:
>> +    minItems: 6
>> +    maxItems: 18
>>  
>>    interrupts:
>>      items:
>> @@ -142,7 +146,18 @@ allOf:
>>      then:
>>        properties:
>>          reg:
>> -          maxItems: 1
>> +          maxItems: 6
>> +          description: 5 memory controller channels and 1 for stream-id registers
>> +
>> +        reg-names:
>> +          maxItems: 6
>> +          items:
>> +            - const: sid
>> +            - const: broadcast
>> +            - const: ch0
>> +            - const: ch1
>> +            - const: ch2
>> +            - const: ch3
>>  
>>    - if:
>>        properties:
>> @@ -151,7 +166,30 @@ allOf:
>>      then:
>>        properties:
>>          reg:
>> -          minItems: 3
>> +          minItems: 18
>> +          description: 17 memory controller channels and 1 for stream-id registers
>> +
>> +        reg-names:
>> +          minItems: 18
>> +          items:
>> +            - const: sid
>> +            - const: broadcast
>> +            - const: ch0
>> +            - const: ch1
>> +            - const: ch2
>> +            - const: ch3
>> +            - const: ch4
>> +            - const: ch5
>> +            - const: ch6
>> +            - const: ch7
>> +            - const: ch8
>> +            - const: ch9
>> +            - const: ch10
>> +            - const: ch11
>> +            - const: ch12
>> +            - const: ch13
>> +            - const: ch14
>> +            - const: ch15
>>  
>>    - if:
>>        properties:
>> @@ -160,13 +198,37 @@ allOf:
>>      then:
>>        properties:
>>          reg:
>> -          minItems: 3
>> +          minItems: 18
>> +          description: 17 memory controller channels and 1 for stream-id registers
>> +
>> +        reg-names:
>> +          minItems: 18
>> +          items:
>> +            - const: sid
>> +            - const: broadcast
>> +            - const: ch0
>> +            - const: ch1
>> +            - const: ch2
>> +            - const: ch3
>> +            - const: ch4
>> +            - const: ch5
>> +            - const: ch6
>> +            - const: ch7
>> +            - const: ch8
>> +            - const: ch9
>> +            - const: ch10
>> +            - const: ch11
>> +            - const: ch12
>> +            - const: ch13
>> +            - const: ch14
>> +            - const: ch15
>>  
>>  additionalProperties: false
>>  
>>  required:
>>    - compatible
>>    - reg
>> +  - reg-names
> 
> New, added properties cannot be required. That's an ABI break.
> 
>>    - interrupts
>>    - "#address-cells"
>>    - "#size-cells"
>> @@ -182,7 +244,13 @@ examples:
>>  
>>          memory-controller@2c00000 {
>>              compatible = "nvidia,tegra186-mc";
>> -            reg = <0x0 0x02c00000 0x0 0xb0000>;
>> +            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
>> +                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
>> +                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
>> +                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
>> +                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
>> +                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
>> +            reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3";
>>              interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>>  
>>              #address-cells = <2>;
>> -- 
>> 2.17.1
>>

Oh, wait.. I didn't notice that the new reg ranges are only splitting up
the old ranges. Previously it appeared to me that these are the new ranges.

Ashish, in this case you don't need to change the regs in the DT at all.
Instead, you need to specify the per-channel reg-base offsets in the
driver code.
