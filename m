Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769924CD3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiCDMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiCDMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:03:43 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836F70905
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:02:56 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 16DA83F5F9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646395375;
        bh=ziDoTWrhgvxfoiTtoB+eoixvqTIbKaiUmLJOIQUx+fo=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=I+3RZGrTULSPwtuCy4UEElWweXvvSMpzlkzX0WzJFmvOdjcNy/1w3mw6noE7GREvG
         pvvcDZBAhrR89fOyx8/plg/7YPmoweWznNtIItaILHATxFRUisYVl2/DOiBFsnRsCP
         FaRr4g1zf0XEX5P2LEsgjyVkmUDlaIBAd7RA7QrvHzulKNoP44Vr2c3/LapsgXY0/8
         66wSr/Wd9lJMbFdMgMmjdBm3RQcii3MzuctMdJ3CtcxAFj1RTf7ThmuUFQbBOcZ6KI
         wNi6y9BTW41yYhSy+Rs/xYqsBtilpEfkjzOsPOnWiXHU5vKlbDOnTp//nuv650AjRO
         9Tq5SOkeGnedg==
Received: by mail-ej1-f70.google.com with SMTP id l24-20020a170906a41800b006da873d66b6so3036145ejz.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ziDoTWrhgvxfoiTtoB+eoixvqTIbKaiUmLJOIQUx+fo=;
        b=mHUYNcSA6TLYHoFXpRER612sjQyY+CgL2RJHw/jT+PA/uMzddqwqRe7JVAz3HYtYdQ
         ikjW1w3ytJsfKpOBEWBJiue9Y+R+J4oVdDNTvx2Q0m7efjJ5aviqDmIfOSdXdvQ0MXXX
         oUjxR3FglEd8E7Ha5yOHSxr/DGdwUrUAKiJXqFEpPmH3gGusnIJ+Tu8ha3Zz34qZZq4C
         KuEsXsDoqjxv1lW+0P8kb/ehvIwOG1bvsKlPejCirnOyJljo2iteZN3J0xmckfdOMon7
         +sgaJswGsSA/IjJX+cnad99o+VMYTyZrouXt2f8olO2EE2DZqngRjeILDYunYJ9yjdgO
         2xGA==
X-Gm-Message-State: AOAM530HFpmWFWvYnk7Vde8EKpMD2hW1nxfk0Rig0WzHhEroKz+6ymBd
        Mn9vWmqIIFUIIlnR2rhH+eZHX10HDPxlxF4/ke3iu1JhkV0dCKTf7REGbd1j8sCprpvc6UYK8jM
        KdYdtkICOclRKjgHhwPFG/06Uj5Lqz5R6IE1k9bzeHw==
X-Received: by 2002:a17:907:97c7:b0:6da:b3ba:6d9f with SMTP id js7-20020a17090797c700b006dab3ba6d9fmr2930517ejc.256.1646395374218;
        Fri, 04 Mar 2022 04:02:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxadYgR0dqVm5Syha+4nSHAdOfyiQ4U8WM23uPG0pHlzJQduTvVG8IaE+rPMGft0u7l4Cabg==
X-Received: by 2002:a17:907:97c7:b0:6da:b3ba:6d9f with SMTP id js7-20020a17090797c700b006dab3ba6d9fmr2930492ejc.256.1646395373957;
        Fri, 04 Mar 2022 04:02:53 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id c14-20020a170906340e00b006ce98f2581asm1651796ejb.205.2022.03.04.04.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 04:02:53 -0800 (PST)
Message-ID: <3c71e9af-b1f1-4954-b09f-9dc4d68844f3@canonical.com>
Date:   Fri, 4 Mar 2022 13:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: describe known
 hardware and its interrupts
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <CGME20220225180401epcas5p35d6c09ca6da36289d66d1bb0dcdeffa1@epcas5p3.samsung.com>
 <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
 <000001d82fb5$e1c43d30$a54cb790$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <000001d82fb5$e1c43d30$a54cb790$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 11:52, Alim Akhtar wrote:
> Hi Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>> Sent: Friday, February 25, 2022 9:07 PM
>> To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
>> <tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com>; Alim Akhtar
>> <alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> samsung-soc@vger.kernel.org
>> Subject: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: describe known
>> hardware and its interrupts
>>
>> Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer block,
>> so only two compatibles were used so far (for Exynos4210 and
>> Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
>> However the Exynos4210 flavor actually differs by number of interrupts.
>>
>> Add new compatibles, maintaining backward compatibility with Exynos4210,
> and
>> constraints for number of interrupts.  This allows to exactly match the
> Exynos
>> MCT hardware.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>> .../timer/samsung,exynos4210-mct.yaml         | 55 ++++++++++++++++++-
>> 1 file changed, 52 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>> mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>> mct.yaml
>> index f11cbc7ccc14..d4e23fd7a1da 100644
>> --- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
>> +++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yam
>> +++ l
>> @@ -19,9 +19,20 @@ description: |+
>>
>> properties:
>>   compatible:
>> -    enum:
>> -      - samsung,exynos4210-mct
>> -      - samsung,exynos4412-mct
>> +    oneOf:
>> +      - enum:
>> +          - samsung,exynos4210-mct
>> +          - samsung,exynos4412-mct
>> +      - items:
>> +          - enum:
>> +              - samsung,exynos3250-mct
>> +              - samsung,exynos5250-mct
>> +              - samsung,exynos5260-mct
>> +              - samsung,exynos5420-mct
>> +              - samsung,exynos5433-mct
>> +              - samsung,exynos850-mct
>> +              - tesla,fsd-mct
>> +          - const: samsung,exynos4210-mct
>>
>>   clocks:
>>     minItems: 2
>> @@ -63,6 +74,44 @@ required:
>>   - interrupts
>>   - reg
>>
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: samsung,exynos3250-mct
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          minItems: 8
>> +          maxItems: 8
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: samsung,exynos5250-mct
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          minItems: 6
>> +          maxItems: 6
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - samsung,exynos5260-mct
>> +              - samsung,exynos5420-mct
>> +              - samsung,exynos5433-mct
>> +              - samsung,exynos850-mct
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          minItems: 12
>> +          maxItems: 12
>> +
> 
> Probably you can update the list for tesla,fsd-mct as well in this patch
> (as the support was added recently)

Right.


Best regards,
Krzysztof
