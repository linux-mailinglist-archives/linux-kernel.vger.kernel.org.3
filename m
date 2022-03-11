Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A34D6750
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350613AbiCKRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiCKRO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:14:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A21959D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:13:55 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14F9E3F323
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647018833;
        bh=RfqNtSnj7KKKappRytqaJ2yaBytssi4EFd5mt0OX61o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iTKMULHw0VSM/mQTOwU6K9A/dmM99yp0YiRjgxKj4kksoYJuKQElBd1PDnjGTd/9V
         biME75E4YyMee/jn2jX/XwAl7HNKsK5o5Kg+Xfy4Y3cIYW2MF1tpeqRWc6UOSA/CYn
         eyh8Ked5z0NAcVRakGtznLrNj/jMkqMA9p2xiN35w8tV3Mvs4lqrOcKMI7Ed0R+8bi
         8bVpgJjaJAI+pPdT8IZPRIMLo4S7HWxaxOrw+/6j6EFfNeP/zFaE9pW0U+AfcRuTuN
         wnDqTCjLNIVEotAtz0AnJWDpIfidQxU+VNpOD05D0HhsfkUkb5AOcptE1y0js8Y5cT
         cgmL/BZAVfPrw==
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso5219254edh.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RfqNtSnj7KKKappRytqaJ2yaBytssi4EFd5mt0OX61o=;
        b=CZHdE4M9lplEpHFLsGCE0D0BNgcqisBV/KuCKgdAVVCuWiKhQVWqiKtn4t1ycbOZN0
         fNTf9BvJRtyGI6u7ukXp6Fs4an9wv1+7JcHoauwvClHjt3puwnGw184Gi2uO3prUR8ua
         EN0socQwxMD9iPJ/1gYUHfhV8rJx+MUV/93ihAalZn78Mul1/LThhxzK2FuzV5Or1nEL
         c+Khc1YPx3s7cJxp2FzjqNkwMzVE5gJ8MjtamWC+mns07uG1rklGuuO5jmOdIOUX0BpU
         8ZrgtJhlaTOl75QJM+c601f5c9S6+O/nfZvHjVit2eItmF/MEK3ShvQdgjklxfDjWCFR
         0Gmw==
X-Gm-Message-State: AOAM533v+g/0h9ITVS3zrmDLFdNdf0IjMnu8Lmu0SAlonSVSjyDQF5w1
        /hoDDMo3zwd0ysNzMvp7hR7EywMrQfcOATqkaYfVnkn0juZZC1zj0vFkjzbynB2DuteqPVZTzFh
        M0yjm4zvrhnoAm2W3OmymrypkntedWVOFMWSrcn4dEw==
X-Received: by 2002:a17:907:97c7:b0:6da:b3ba:6d9f with SMTP id js7-20020a17090797c700b006dab3ba6d9fmr9858771ejc.256.1647018832687;
        Fri, 11 Mar 2022 09:13:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRIzUayyIxbwvakLgZFmLbT5KgaaaJ42ffeJIr0rYpRuq1vd6YDm0FwIL/67DY8Vy2zzgkGQ==
X-Received: by 2002:a17:907:97c7:b0:6da:b3ba:6d9f with SMTP id js7-20020a17090797c700b006dab3ba6d9fmr9858747ejc.256.1647018832433;
        Fri, 11 Mar 2022 09:13:52 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id hz7-20020a1709072ce700b006db4bd52016sm3254706ejc.144.2022.03.11.09.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 09:13:52 -0800 (PST)
Message-ID: <9cebbeb7-3914-6a7a-def1-06b5ee71932f@canonical.com>
Date:   Fri, 11 Mar 2022 18:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/10] dt-bindings: timer: Add HPE GXP Timer Binding
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Rob Herring <robh@kernel.org>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-5-nick.hawkins@hpe.com>
 <YittU9MfIFye9e2p@robh.at.kernel.org>
 <PH0PR84MB1718CAA1172CE891AA4E361C880C9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <PH0PR84MB1718CAA1172CE891AA4E361C880C9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 17:22, Hawkins, Nick wrote:
> On Thu, Mar 10, 2022 at 01:52:24PM -0600, nick.hawkins@hpe.com wrote:
>>> From: Nick Hawkins <nick.hawkins@hpe.com>>
>>>
>>> Creating binding for gxp timer in device tree hpe,gxp-timer Although 
>>> there are multiple times on the SoC we are only enabling one at this 
>>> time.
>>>
>>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>>
>>>
>>> ----
>>>
>>> v2:
>>>  *Removed maintainer change from patch  *Verified there was no 
>>> compilation errors  *Added reference code in separate patch of 
>>> patchset
>>> ---
>>>  .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
>>>  1 file changed, 45 insertions(+)
>>>  create mode 100644 
>>> Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml 
>>> b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>>> new file mode 100644
>>> index 000000000000..1f4e345c5fb8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>>> @@ -0,0 +1,45 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: 
>>> +INVALID URI REMOVED
>>> +xp-timer.yaml*__;Iw!!NpxR!yaItMPvjqEf3fKyp1xDQAzawRQDd8uDGTNKMlVPpn5Y
>>> +56IUABMYbali7jonBl20K$
>>> +$schema: 
>>> +INVALID URI REMOVED
>>> +aml*__;Iw!!NpxR!yaItMPvjqEf3fKyp1xDQAzawRQDd8uDGTNKMlVPpn5Y56IUABMYba
>>> +li7jmX565-G$
>>> +
>>> +title: HPE GXP TIMER
>>> +
>>> +maintainers:
>>> +  - Nick Hawkins <nick.hawkins@hpe.com>>
>>> +  - Jean-Marie Verdun <verdun@hpe.com>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: hpe,gxp-timer
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: T0CNT register
>>> +      - description: T0CS register
>>> +      - description: TIMELO register
> 
>> Is the spec public to know what T0CNT, T0CS, and TIMELO are?
> No it is not, should I not mention the register descriptions at all?
> 
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clock-frequency:
>>> +    description: The frequency of the clock that drives the counter, in Hz.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clock-frequency
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    timer@10003000 {
>>> +        compatible = "hpe,gxp-timer";
>>> +        reg = <0xc0000080 0x1>>, <0xc0000094 0x01>>, <0xc0000088 0x08>>;
> 
>> Based on the driver these are 4 bytes, 1 byte, 4 bytes in size.
> 
>> Are there other registers in 0x80-0x95 range or do these offsets change in other chips? If not, just 1 entry covering the whole thing would be better.
> There are other registers in this range that cover different timers/clocks, for the most part between chip generations the offsets remain the same unless there is an architectural issue.
> Can you provide a quick example of what one entry would be?

arch/arm/boot/dts/versatile-ab.dts

and actually 90% of DTS... it's rather a challange to find such
fine-grained iomap.

Best regards,
Krzysztof
