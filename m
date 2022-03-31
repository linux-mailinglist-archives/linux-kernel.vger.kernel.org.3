Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A14ED10C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352145AbiCaAwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiCaAwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:52:40 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36032E005;
        Wed, 30 Mar 2022 17:50:52 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 31 Mar 2022 09:50:52 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 7C28D2058443;
        Thu, 31 Mar 2022 09:50:52 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 31 Mar 2022 09:50:52 +0900
Received: from [10.212.183.63] (unknown [10.212.183.63])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9083BB62B7;
        Thu, 31 Mar 2022 09:50:51 +0900 (JST)
Subject: Re: [PATCH v3 5/5] dt-bindings: phy: uniphier: Clean up clocks,
 resets, and their names using compatible string
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648637715-19262-6-git-send-email-hayashi.kunihiko@socionext.com>
 <a784ed61-965a-5c68-c2dd-3340cf18c7b5@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <d32191fc-1302-89e4-8b24-40fe33867b98@socionext.com>
Date:   Thu, 31 Mar 2022 09:50:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a784ed61-965a-5c68-c2dd-3340cf18c7b5@linaro.org>
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

On 2022/03/31 2:40, Krzysztof Kozlowski wrote:
> On 30/03/2022 12:55, Kunihiko Hayashi wrote:
>> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
>> clock-names, resets, and reset-names that can be taken by the compatible
>> string.
>>
>> The order of clock-names and reset-names doesn't change here.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../phy/socionext,uniphier-ahci-phy.yaml      | 90 +++++++++++++-----
>>   .../phy/socionext,uniphier-pcie-phy.yaml      | 47 ++++++---
>>   .../phy/socionext,uniphier-usb3hs-phy.yaml    | 93 ++++++++++++++----
>>   .../phy/socionext,uniphier-usb3ss-phy.yaml    | 95 +++++++++++++++----
>>   4 files changed, 251 insertions(+), 74 deletions(-)
>>
> 
> (...)
> 
>> diff --git
>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>> index 1bbd164f2527..21e4414eea60 100644
>> ---
>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>> +++
>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>> @@ -34,30 +34,12 @@ properties:
>>       minItems: 2
>>       maxItems: 3
>>
>> -  clock-names:
>> -    oneOf:
>> -      - items:               # for Pro5
>> -          - const: gio
>> -          - const: link
>> -      - items:               # for PXs3 with phy-ext
>> -          - const: link
>> -          - const: phy
>> -          - const: phy-ext
>> -      - items:               # for others
>> -          - const: link
>> -          - const: phy
>> +  clock-names: true
>>
>>     resets:
>>       maxItems: 2
>>
>> -  reset-names:
>> -    oneOf:
>> -      - items:               # for Pro5
>> -          - const: gio
>> -          - const: link
>> -      - items:               # for others
>> -          - const: link
>> -          - const: phy
>> +  reset-names: true
>>
>>     vbus-supply:
>>       description: A phandle to the regulator for USB VBUS
>> @@ -80,6 +62,77 @@ properties:
>>         required for each port, if any one is omitted, the trimming data
>>         of the port will not be set at all.
>>
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: socionext,uniphier-pro5-usb3-hsphy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +        clock-names:
>> +          items:
>> +            - const: gio
>> +            - const: link
>> +        resets:
>> +          minItems: 2
>> +          maxItems: 2
>> +        reset-names:
>> +          items:
>> +            - const: gio
>> +            - const: link
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pxs2-usb3-hsphy
>> +              - socionext,uniphier-ld20-usb3-hsphy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +        clock-names:
>> +          items:
>> +            - const: link
>> +            - const: phy
>> +        resets:
>> +          minItems: 2
>> +          maxItems: 2
>> +        reset-names:
>> +          items:
>> +            - const: link
>> +            - const: phy
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pxs3-usb3-hsphy
>> +              - socionext,uniphier-nx1-usb3-hsphy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
> 
> Why minItems:2? Is the last phy-ext clock optional?

In an SoC with two controllers, there is a controller that requires extra
clock and a controller that does not. For example, PXs3 USB3 controller 1
needs "phy-ext" clock, but the controller 0 doesn't.

This difference is related to the phy configuration, where the controller 1
requires more clocks because it shares the phy with other subsystems.

So I think the last phy-ext clock should be optional.

> 
>> +          maxItems: 3
>> +        clock-names:
>> +          minItems: 2
>> +          items:
>> +            - const: link
>> +            - const: phy
>> +            - const: phy-ext
>> +        resets:
>> +          minItems: 2
>> +          maxItems: 2
>> +        reset-names:
>> +          items:
>> +            - const: link
>> +            - const: phy
>> +
>>   required:
>>     - compatible
>>     - reg
>> diff --git
>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
>> index 06c957d52d23..4c26d2d2303d 100644
>> ---
>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
>> +++
>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
>> @@ -35,34 +35,89 @@ properties:
>>       minItems: 2
>>       maxItems: 3
>>
>> -  clock-names:
>> -    oneOf:
>> -      - items:             # for Pro4, Pro5
>> -          - const: gio
>> -          - const: link
>> -      - items:             # for PXs3 with phy-ext
>> -          - const: link
>> -          - const: phy
>> -          - const: phy-ext
>> -      - items:             # for others
>> -          - const: link
>> -          - const: phy
>> +  clock-names: true
>>
>>     resets:
>>       maxItems: 2
>>
>> -  reset-names:
>> -    oneOf:
>> -      - items:              # for Pro4,Pro5
>> -          - const: gio
>> -          - const: link
>> -      - items:              # for others
>> -          - const: link
>> -          - const: phy
>> +  reset-names: true
>>
>>     vbus-supply:
>>       description: A phandle to the regulator for USB VBUS, only for USB
>> host
>>
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pro4-usb3-ssphy
>> +              - socionext,uniphier-pro5-usb3-ssphy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +        clock-names:
>> +          items:
>> +            - const: gio
>> +            - const: link
>> +        resets:
>> +          minItems: 2
>> +          maxItems: 2
>> +        reset-names:
>> +          items:
>> +            - const: gio
>> +            - const: link
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pxs2-usb3-ssphy
>> +              - socionext,uniphier-ld20-usb3-ssphy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +        clock-names:
>> +          items:
>> +            - const: link
>> +            - const: phy
>> +        resets:
>> +          minItems: 2
>> +          maxItems: 2
>> +        reset-names:
>> +          items:
>> +            - const: link
>> +            - const: phy
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pxs3-usb3-ssphy
>> +              - socionext,uniphier-nx1-usb3-ssphy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
> 
> Same question as above.

This is also the same reason.

Thank you,

---
Best Regards
Kunihiko Hayashi
