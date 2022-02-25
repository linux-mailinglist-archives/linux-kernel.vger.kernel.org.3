Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAF4C40C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiBYI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiBYI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:56:39 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48435225002;
        Fri, 25 Feb 2022 00:56:08 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id m3so6390530eda.10;
        Fri, 25 Feb 2022 00:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S27aJRS83juI73kqWU0BxLGP8P3u79JStBDKAuIXFhk=;
        b=BUSEpEhuOkhpppOXNXT+BdPEpe0kBH3iNchfYBbsC6y9Tkl5wzy7/5bmyTC81UCd3w
         k/H7U2PPBCOWOV1rjRa+4TtBG7TOFNRbqveJQJD8tf++JN+msReM1iWfeuTbxy2Agvgy
         LTcb6gY93DtI1wzO+FgJnxlu9eTSqPYkOC1bSKSpkjhb2qNkr8QM2mzTGfybW2Ojm5qW
         3f5GoDePgPJIgMlTTlUEhl97WvMJEwUC5/AeqA/QY1Np1a/Z9eXe+sct40rS/ycrNdA1
         z99y7ARB9cfh3D5HiciUPZsuphghzs0W/S3JAXaDNQYzcYoj7ypg3eTk2faNETy63g7Y
         fHKg==
X-Gm-Message-State: AOAM531sTq3c3YlZMy6BxwaBoRN8NpMZftXm1LrA03m6kXnmSCpg/AU8
        dEh5YKsKYsdpITaohIi5IpeiMs/3bPQ=
X-Google-Smtp-Source: ABdhPJyoLJT8Or8rEnWPT56mqaT7iWjipB/VQRiQnuSeper/ezx7KtfhXCBHPXRwKEykdvb/PXvTsg==
X-Received: by 2002:a05:6402:438e:b0:410:a8bd:fee0 with SMTP id o14-20020a056402438e00b00410a8bdfee0mr6084025edc.426.1645779366594;
        Fri, 25 Feb 2022 00:56:06 -0800 (PST)
Received: from [192.168.0.130] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id gb11-20020a170907960b00b006d20acf7e36sm763580ejc.144.2022.02.25.00.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 00:56:05 -0800 (PST)
Message-ID: <82d76824-ef5b-23f9-149e-2c5d9f88e94a@kernel.org>
Date:   Fri, 25 Feb 2022 09:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: Add sample averaging property
 for ADM1275
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220224154329.9755-1-potin.lai@quantatw.com>
 <20220224154329.9755-3-potin.lai@quantatw.com>
 <c6607953-927e-4d85-21cb-72e01a121453@kernel.org>
 <b527a418-b807-7afa-9ed0-2ac4271ff79e@kernel.org>
 <91e35667-5203-271b-8a0e-b9ddf71561d6@roeck-us.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <91e35667-5203-271b-8a0e-b9ddf71561d6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 09:41, Guenter Roeck wrote:
> On 2/24/22 23:31, Krzysztof Kozlowski wrote:
>> On 25/02/2022 08:06, Krzysztof Kozlowski wrote:
>>> On 24/02/2022 16:43, Potin Lai wrote:
>>>> Add new properties for binding sample averaging in PMON_CONFIG register
>>>>
>>>> - adi,volt-curr-sample-average
>>>> - adi,power-sample-average
>>>>
>>>> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
>>>> ---
>>>>   .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>>>>   1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> index 223393d7cafd..325f6827648f 100644
>>>> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> @@ -37,6 +37,48 @@ properties:
>>>>       description:
>>>>         Shunt resistor value in micro-Ohm.
>>>>   
>>>> +  adi,volt-curr-sample-average:
>>>> +    description: |
>>>> +      A value to configure VI_AVG in PMON_CONFIG register to indicate a
>>>> +      number of samples to be used to report voltage and currentvalues.
>>>
>>> missing space after current.
>>>
>>>> +      If set to 7, the 128 samples averaging would be used.
>>>> +
>>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>>
>>> Make it a uint32.
>>>
>>> The previous usage of this field was more appropriate. Instead of
>>> keeping register values in DT, it's better to keep logical value. What
>>> if in next cheap the register values have calculation method?
>>>
>>> This should be like in v1 - enum for number of samples to take in averaging.
>>>
>>
>> One more thought: this field could also stay in current approach if you
>> change the meaning from "value to configure VI_AVG" to something like
>> "the exponent used to determine the number of samples, where the base is 2".
>>
>> This approach would allow you to skip the "ilog" in the code. It sill
>> won't be that easily scalable if another chip comes with different
>> formula, but I think that's unlikely.
>>
> 
> The standard hwmon ABI expects the number of samples, it isn't always a
> power of 2, and the driver already implements it (with ilog2) as sysfs
> attribute. I don't really see the point of "optimizing" something
> like this to be chip specific just to avoid some error checking.

Thanks for confirming. +1



Best regards,
Krzysztof
