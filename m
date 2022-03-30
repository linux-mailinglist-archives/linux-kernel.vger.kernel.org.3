Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AF4EBEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiC3KZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiC3KZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:25:54 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CAAC2241E2;
        Wed, 30 Mar 2022 03:24:09 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Mar 2022 19:24:09 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 831202058443;
        Wed, 30 Mar 2022 19:24:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 19:24:09 +0900
Received: from [10.212.182.122] (unknown [10.212.182.122])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 94A70B62B7;
        Wed, 30 Mar 2022 19:24:08 +0900 (JST)
Subject: Re: [PATCH v2 5/5] dt-bindings: phy: uniphier: Clean up clock-names
 and reset-names using compatible string
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648617651-9004-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617651-9004-6-git-send-email-hayashi.kunihiko@socionext.com>
 <ecc821cb-4dd0-48e6-668d-45c178efbbf0@linaro.org>
 <076c1292-053e-759d-3e6f-c262093d9d1c@socionext.com>
 <65d1eebd-f460-4073-4dc1-b1de62aa2ee4@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <7f1c3ded-5405-44d8-c5c2-8f7d7a42b1fc@socionext.com>
Date:   Wed, 30 Mar 2022 19:24:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <65d1eebd-f460-4073-4dc1-b1de62aa2ee4@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/03/30 18:45, Krzysztof Kozlowski wrote:
> On 30/03/2022 11:16, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
>> On 2022/03/30 17:13, Krzysztof Kozlowski wrote:
>>> On 30/03/2022 07:20, Kunihiko Hayashi wrote:
>>>> Instead of "oneOf:" choices, use "allOf:" and "if:" to define
>>>> clock-names
>>>> and reset-names that can be taken by the compatible string.
>>>>
>>>> The order of clock-names and reset-names doesn't change here.
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>    .../phy/socionext,uniphier-ahci-phy.yaml      | 73 ++++++++++++------
>>>>    .../phy/socionext,uniphier-pcie-phy.yaml      | 37 ++++++---
>>>>    .../phy/socionext,uniphier-usb3hs-phy.yaml    | 75 +++++++++++++-----
>>>>    .../phy/socionext,uniphier-usb3ss-phy.yaml    | 77 ++++++++++++++-----
>>>>    4 files changed, 188 insertions(+), 74 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>> index 14f7579e7daa..61d9306e1852 100644
>>>> ---
>>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>> +++
>>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>> @@ -30,33 +30,62 @@ properties:
>>>>        minItems: 1
>>>>        maxItems: 2
>>>>
>>>> -  clock-names:
>>>> -    oneOf:
>>>> -      - items:          # for PXs2
>>>> -          - const: link
>>>> -      - items:          # for Pro4
>>>> -          - const: link
>>>> -          - const: gio
>>>> -      - items:          # for others
>>>> -          - const: link
>>>> -          - const: phy
>>>> +  clock-names: true
>>>>
>>>>      resets:
>>>>        minItems: 2
>>>>        maxItems: 6
>>>>
>>>> -  reset-names:
>>>> -    oneOf:
>>>> -      - items:          # for Pro4
>>>> -          - const: link
>>>> -          - const: gio
>>>> -          - const: phy
>>>> -          - const: pm
>>>> -          - const: tx
>>>> -          - const: rx
>>>> -      - items:          # for others
>>>> -          - const: link
>>>> -          - const: phy
>>>> +  reset-names: true
>>>> +
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: socionext,uniphier-pro4-ahci-phy
>>>> +    then:
>>>> +      properties:
>>>> +        clock-names:
>>>> +          items:
>>>> +            - const: link
>>>> +            - const: gio
>>>> +        reset-names:
>>>> +          items:
>>>> +            - const: link
>>>> +            - const: gio
>>>> +            - const: phy
>>>> +            - const: pm
>>>> +            - const: tx
>>>> +            - const: rx
>>>
>>> Constrain also everywhere clocks and resets, so here should be:
>>>     resets:
>>>       minItems: 6
>>>       maxItems: 6
>>
>> If I put the constraint here, it would conflict with the original one.
>> Should I also replace the original resets
>>
>>       resets:
>>         minItems: 2
>>         maxItems: 6
>>
>> with "resets: true"?
> 
> It should not conflict. Check the bindings for Samsung Exynos clock I
> sent you last time. In the main "properties" you put the widest
> constraints, like you have now (2-6). Then for each compatible you
> narrow it (2-2, 6-6).
> 
> You can later test it by adding/removing clocks to check if constraints
> are properly working.

I understand. The main "properties" should be the widest constraints,
and I checked that Exynos clock is set to the widest (1-10).
I'll add the constraints.

Thank you,

---
Best Regards
Kunihiko Hayashi
