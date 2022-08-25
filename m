Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD75A19D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbiHYTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHYTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:50:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2532F023
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:50:03 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE71D3FF2B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661456999;
        bh=ElCqit8gPCJv1gvsL3cYIQefN1cLdhhp7VEm0Nv6fXA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=SlDGdJjM7as0izD1slTcUH5UKGMafwrDpoSBWIGHjF4CBAsVXFFP2uoP7RzHFN67W
         m11X0yWM3D90xx9PjewltQLQqFWli+vyCcijSELa5YZi/xYhaBIyMe7jNSCN/iRw8W
         c17YUXn1jnh7GhyPBUZLcE93GTki31tJGAHu3ijRtI17ATwkbEfroSuqgo42GlY1+x
         Q3IjhN7mpViUH0lD4Xs1kN46uQDX/nQ2VtPpUi0XGqzxuR6y01QRUomonoxi+B2gH9
         bDeV2rTJpWUdqKQXURXXZvvEkCrRyVegcEbOGh3VgZu76FNCs8OP+PPPE0cF95rgDB
         aJYQy2jwTDDxw==
Received: by mail-wm1-f71.google.com with SMTP id j22-20020a05600c485600b003a5e4420552so2875723wmo.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ElCqit8gPCJv1gvsL3cYIQefN1cLdhhp7VEm0Nv6fXA=;
        b=FurxEvdAPqwiMMtJ5ssAsdSmDMsJ4+9ojuKfCZSPPf+mZgFhdAhoiFXQsnhO4+0DiM
         E1/rhqXCRQroZETYZZEKaM5531fa/mEIxteisA9RUkWWs75FvaqaDAfmwtzkQEI1EXYL
         9IHRTwLhbFBP+sTeV2MaUv1ck0eYTH8OoaiVHZoOJkvra/r8ZfkuJwcDkvh1zZaAheZW
         nnhhe288CXTUazpEjEfSQocF7G0VD+AsZ9+dan5qTegQKy9ryib1v31SxUV8hIoc/8fs
         eUq/oS7cxXdRUy34N1ZHqx/dJ+d0OlZIPhme6hkDwYg1wWpwEZteUXB/8dYHA5sJDXBB
         dpng==
X-Gm-Message-State: ACgBeo2/u2rvyaBkJU/HLgzPYN/5gVzU3w0ehJzQd0EbSC8JW2tfm6j6
        YVUEqAwXEIiGtNml3PEJGlBiqf6w2o8AK4e1uhaGS1l0Ouo12ac0wNAdP2X5cR5GwJ8mlNXUeA7
        eYv6/I1cfe+oskIlpAl126B62lQ0ClEdFlj0Fvv+YQA==
X-Received: by 2002:a5d:6daa:0:b0:225:5eeb:f76f with SMTP id u10-20020a5d6daa000000b002255eebf76fmr3038669wrs.479.1661456999198;
        Thu, 25 Aug 2022 12:49:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ccOUiWZFXjWeags4bNyKLO9yxeQU0b0hr0yejK+PhiplvN9gzD9eUcWufaLD40ZNDCch2pw==
X-Received: by 2002:a5d:6daa:0:b0:225:5eeb:f76f with SMTP id u10-20020a5d6daa000000b002255eebf76fmr3038654wrs.479.1661456998883;
        Thu, 25 Aug 2022 12:49:58 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d49d2000000b00224f5bfa890sm41320wrs.97.2022.08.25.12.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 12:49:57 -0700 (PDT)
Message-ID: <7b635894-5a91-9294-75ab-2fad8f657577@canonical.com>
Date:   Thu, 25 Aug 2022 21:49:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC
 compatible
To:     Conor.Dooley@microchip.com
Cc:     sagar.kadam@sifive.com, atishp@atishpatra.org,
        paul.walmsley@sifive.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Daire.McNamara@microchip.com, palmer@dabbelt.com,
        robh+dt@kernel.org
References: <20220825180417.1259360-1-mail@conchuod.ie>
 <20220825180417.1259360-2-mail@conchuod.ie>
 <5f00ab85-d5ac-728d-2157-e70f2a46cc90@canonical.com>
 <2d1da51d-d5a0-bb3c-ba63-831f0efc1b3d@microchip.com>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <2d1da51d-d5a0-bb3c-ba63-831f0efc1b3d@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/22 20:56, Conor.Dooley@microchip.com wrote:
> On 25/08/2022 19:36, Heinrich Schuchardt wrote:
>> On 8/25/22 20:04, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> The l2 cache on PolarFire SoC is cross between that of the fu540 and
>>> the fu740. It has the extra interrupt from the fu740 but the lower
>>> number of cache-sets. Add a specific compatible to avoid the likes
>>> of:
>>>
>>> mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long
>>
>> Where is such a message written? I couldn't find the string in
>> next-20220825 (git grep -n 'is too long"').
> 
> dtbs_check on next-20220825 (with dt-schema v22.08 FWIW):
> mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long
> mpfs-icicle-kit.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long
> 
> I should have caught this before applying, but I got distracted
> by the unusable system.
> 
>>
>> Why should a different number of cache sets require an extra
>> compatible string. cache-size is simply a parameter going with> the existing compatible strings.
> 
> s/cache sets/interrupts
> Because the correct value for the fu540 is 3 & this is regulated by
> the binding. The alternative would be relaxing the binding to not
> regulate the number of interrupts.
> 
>>
>> I would assume that you only need an extra compatible string if
>> there is a functional difference that can not be expressed with
>> the existing parameters.
>>
>>>
>>> Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>    .../bindings/riscv/sifive-l2-cache.yaml       | 79 ++++++++++++-------
>>>    1 file changed, 49 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>>> index 69cdab18d629..ca3b9be58058 100644
>>> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>>> @@ -17,9 +17,6 @@ description:
>>>      acts as directory-based coherency manager.
>>>      All the properties in ePAPR/DeviceTree specification applies for this platform.
>>>    -allOf:
>>> -  - $ref: /schemas/cache-controller.yaml#
>>> -
>>>    select:
>>>      properties:
>>>        compatible:
>>> @@ -33,11 +30,16 @@ select:
>>>      properties:
>>>      compatible:
>>> -    items:
>>> -      - enum:
>>> -          - sifive,fu540-c000-ccache
>>> -          - sifive,fu740-c000-ccache
>>
>> Why can't you simply add microchip,mpfs-ccache here?
> 
> I *could* but I opted not to because the fu540 supports a compatible
> subset of the features & keeping the compatible for it allows systems
> with a newer dts to work with an older kernel.

That makes it clearer.

> 
>>
>>> -      - const: cache
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - sifive,fu540-c000-ccache
>>> +              - sifive,fu740-c000-ccache
>>> +          - const: cache
>>> +      - items:
>>> +          - const: microchip,mpfs-ccache
>>> +          - const: sifive,fu540-c000-ccache
>>
>> Why do we need 'sifive,fu540-c000-ccache' twice?
> 
> Is there a better way to write it given the above caveat?
> 
> Thanks,
> Conor.
> 
> 
>>
>>> +          - const: cache
>>>        cache-block-size:
>>>        const: 64
>>> @@ -72,29 +74,46 @@ properties:
>>>          The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
>>>          The reserved memory node should be defined as per the bindings in reserved-memory.txt.
>>>    -if:
>>> -  properties:
>>> -    compatible:
>>> -      contains:
>>> -        const: sifive,fu540-c000-ccache
>>> +allOf:
>>> +  - $ref: /schemas/cache-controller.yaml#
>>>    -then:
>>> -  properties:
>>> -    interrupts:
>>> -      description: |
>>> -        Must contain entries for DirError, DataError and DataFail signals.
>>> -      maxItems: 3
>>> -    cache-sets:
>>> -      const: 1024
>>> -
>>> -else:
>>> -  properties:
>>> -    interrupts:
>>> -      description: |
>>> -        Must contain entries for DirError, DataError, DataFail, DirFail signals.
>>> -      minItems: 4
>>> -    cache-sets:
>>> -      const: 2048
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - sifive,fu740-c000-ccache
>>> +              - microchip,mpfs-ccache
>>> +
>>> +    then:
>>> +      properties:
>>> +        interrupts:
>>> +          description: |
>>> +            Must contain entries for DirError, DataError, DataFail, DirFail signals.
>>> +          minItems: 4

Above you indicated that you want strict limits for the interrupt count. 
You expect exactly 4 items here. Having 5 entries would not be correct.
Please, add 'maxItems: 4'.

>>> +
>>> +    else:
>>> +      properties:
>>> +        interrupts:
>>> +          description: |
>>> +            Must contain entries for DirError, DataError and DataFail signals.
>>> +          maxItems: 3

The item count should be exactly 3. Having 2 entries would not be correct.
Please, add 'minItems: 3'.

Best regards

Heinrich

>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: sifive,fu740-c000-ccache
>>> +
>>> +    then:
>>> +      properties:
>>> +        cache-sets:
>>> +          const: 2048
>>> +
>>> +    else:
>>> +      properties:
>>> +        cache-sets:
>>> +          const: 1024
>>>      additionalProperties: false
>>>    
