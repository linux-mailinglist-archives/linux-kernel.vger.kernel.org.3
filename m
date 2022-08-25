Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45A5A18D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbiHYShG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbiHYSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:36:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A4C901BC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:36:54 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A3CA83F03E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661452612;
        bh=dpAjbusN9yBD9N/QzCXa1x041iuJNs+syZnqbC+IIao=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EYEce1S2Xh3NG/f2iXGbPdH8B4uD7mjMdTGZUsDiDutNBXrgG8IjFhNyIhcmBfqKH
         yzb7BSacwLRwP8MYq80ru5deh3tmWvzc7OhJma2+c8L0YPeCkKf2147DdL8/VkergO
         8hHff57XoRIrGUuDCKP0xeQQ5xDmMilQekI4ICJrz8ex88CkO9NxT+DRinQZBO1OPz
         azOl+7LEXDbo2RZPip9O77ofUSgPa//ldR0BS7G2PV0TwATtDzZ8ZTwNzitrdCvOpV
         2CMdc9Z8oBFy39xXV1tlBZepMBdQ3kcY2oll2CBiXAekwEoL5MWT6Wm0VBnmbBUrM7
         LQdLtat3GvoXg==
Received: by mail-wm1-f71.google.com with SMTP id f7-20020a1c6a07000000b003a60ede816cso1030063wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dpAjbusN9yBD9N/QzCXa1x041iuJNs+syZnqbC+IIao=;
        b=p7Ee/LCx5L232kEPogMIhjik1X/w6CNmy14cqii0Q3N7ikr+H45lNWKbL0gheSRXe/
         lNlMouok5O9WAX4SxKCGqYCVyPDgAV4e57v6yL8kKx3dCcWlLmHUIbyuwF0iuuLNsePb
         tsOpdLRKXxcASvDQ++Ot821ir0pjAU4U9PO175E3tbzxNEFnVh2dYNFP63ypPksLf6z/
         o+ig7XEneAnouE9dJq7t2lXQpiy+0wVD+fJ3M2/Ufcxh8jOqxhSgLHf/UEXKRFggHLA1
         r0/56OZE5oU8XbfPqUN1AuQ6BAF5qChbD5do0GXX5qygf6j8tJThWzqJnqcXvrw3Mx7A
         blfQ==
X-Gm-Message-State: ACgBeo3vJ/5hvEijE/GDz+FVKFfMaRA6cBO81J43guuAYJpByx6AZ4q0
        sqcwjomKmXGK3N4xOuEeZ0pwcp84R+oRRIvUUsJNPQn57PF69qxdLOOjWYi8EF+pZawxqc2j/2t
        WGGDYJyug6emdQo/ZxGeA+BJiatX3ewM+UKTIqtTsgA==
X-Received: by 2002:a05:600c:3d0f:b0:3a5:eece:c061 with SMTP id bh15-20020a05600c3d0f00b003a5eecec061mr3126681wmb.74.1661452612260;
        Thu, 25 Aug 2022 11:36:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4LuVbPZRwE3Kvu/sLxz4WiXDcnE8lKeB5AJKOBKdr9/2gXIomWNDt5/HMCk1Ye4DwHolXA3w==
X-Received: by 2002:a05:600c:3d0f:b0:3a5:eece:c061 with SMTP id bh15-20020a05600c3d0f00b003a5eecec061mr3126655wmb.74.1661452611922;
        Thu, 25 Aug 2022 11:36:51 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a5f3de6fddsm6392341wms.25.2022.08.25.11.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 11:36:51 -0700 (PDT)
Message-ID: <5f00ab85-d5ac-728d-2157-e70f2a46cc90@canonical.com>
Date:   Thu, 25 Aug 2022 20:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC
 compatible
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <mail@conchuod.ie>
References: <20220825180417.1259360-1-mail@conchuod.ie>
 <20220825180417.1259360-2-mail@conchuod.ie>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220825180417.1259360-2-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 20:04, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The l2 cache on PolarFire SoC is cross between that of the fu540 and
> the fu740. It has the extra interrupt from the fu740 but the lower
> number of cache-sets. Add a specific compatible to avoid the likes
> of:
> 
> mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long

Where is such a message written? I couldn't find the string in 
next-20220825 (git grep -n 'is too long"').

Why should a different number of cache sets require an extra compatible 
string. cache-size is simply a parameter going with the existing 
compatible strings.

I would assume that you only need an extra compatible string if there is 
a functional difference that can not be expressed with the existing 
parameters.

> 
> Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   .../bindings/riscv/sifive-l2-cache.yaml       | 79 ++++++++++++-------
>   1 file changed, 49 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> index 69cdab18d629..ca3b9be58058 100644
> --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> @@ -17,9 +17,6 @@ description:
>     acts as directory-based coherency manager.
>     All the properties in ePAPR/DeviceTree specification applies for this platform.
>   
> -allOf:
> -  - $ref: /schemas/cache-controller.yaml#
> -
>   select:
>     properties:
>       compatible:
> @@ -33,11 +30,16 @@ select:
>   
>   properties:
>     compatible:
> -    items:
> -      - enum:
> -          - sifive,fu540-c000-ccache
> -          - sifive,fu740-c000-ccache

Why can't you simply add microchip,mpfs-ccache here?

> -      - const: cache
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sifive,fu540-c000-ccache
> +              - sifive,fu740-c000-ccache
> +          - const: cache
> +      - items:
> +          - const: microchip,mpfs-ccache
> +          - const: sifive,fu540-c000-ccache

Why do we need 'sifive,fu540-c000-ccache' twice?

Best regards

Heinrich

> +          - const: cache
>   
>     cache-block-size:
>       const: 64
> @@ -72,29 +74,46 @@ properties:
>         The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
>         The reserved memory node should be defined as per the bindings in reserved-memory.txt.
>   
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: sifive,fu540-c000-ccache
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
>   
> -then:
> -  properties:
> -    interrupts:
> -      description: |
> -        Must contain entries for DirError, DataError and DataFail signals.
> -      maxItems: 3
> -    cache-sets:
> -      const: 1024
> -
> -else:
> -  properties:
> -    interrupts:
> -      description: |
> -        Must contain entries for DirError, DataError, DataFail, DirFail signals.
> -      minItems: 4
> -    cache-sets:
> -      const: 2048
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - sifive,fu740-c000-ccache
> +              - microchip,mpfs-ccache
> +
> +    then:
> +      properties:
> +        interrupts:
> +          description: |
> +            Must contain entries for DirError, DataError, DataFail, DirFail signals.
> +          minItems: 4
> +
> +    else:
> +      properties:
> +        interrupts:
> +          description: |
> +            Must contain entries for DirError, DataError and DataFail signals.
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sifive,fu740-c000-ccache
> +
> +    then:
> +      properties:
> +        cache-sets:
> +          const: 2048
> +
> +    else:
> +      properties:
> +        cache-sets:
> +          const: 1024
>   
>   additionalProperties: false
>   
