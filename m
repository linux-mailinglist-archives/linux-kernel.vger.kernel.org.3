Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774324DC00E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiCQHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiCQHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:20:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55C1945CB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:18:54 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B2E83F499
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647501527;
        bh=ScsU2sC70svMEwiZ9pPSBhbAgDMaMBHGkqomDLPaWvY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BeN4tjkWgKSBa3kj+phyp+zCcL8W7s2nEsSH1GuVON6TcvrKpL3ECA1aieYF6e3dR
         HAnUvYsJy0U84cPpvJvAN4BsAVrMUDjO1hPY/AQh+7zQ/QM4GHyFGIZasNE99ZxSbW
         VNyOeHBupspXwWQ+DeqkHc+NEBwNnf5tAT+6ZzttoV8o/xxcicwADFTeNg4vUDAbmP
         8xjBHLrfiv+/GQSVrAjnKEXcDb0gNoCj+TfUKO3g/BSy0rCdcJBfA31/kYU5GKJaY6
         iBg4MUVYkql8zIg+f6diSMH7/NczBPuRTbsRr48C50i4ot06TocrOPe8OBmZKWsOZd
         pqGshbOOOcT8Q==
Received: by mail-wr1-f70.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so1238453wrh.14
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ScsU2sC70svMEwiZ9pPSBhbAgDMaMBHGkqomDLPaWvY=;
        b=lpNVzWJ4t/xyxIgQ3oJcmWqas5R8mRD4nat5tiAww+3cOJfVP7Sa2srZ+912Cvm4d9
         t9w2MmQNYxEhNdbA5Oy+I1qS7kpDegzeVyNlot35hHoh/CNhXc7UII5wnAkDtNtmWhYW
         AHVvmA77/RYl2J71/RMDeiZlLMPtf5yJCdG6VxHOAsC1cQEj+QY/akmusIv/gXhl3uMO
         axrHA99mr8WPbtUctnwppqPhGxVHn6tCA4C0fsJN6yPcwzHdPxZT8fLMPIlIT9uDyGjS
         6SdfOhtkEQ6mdzXUw4dY/GY6c+yfrRKb7KgfW4oR9LYKr3g3KHd/+xzGmT00MjWxoywp
         ymJw==
X-Gm-Message-State: AOAM530KSPKugQN1frjYn9xqXhW/Fa/OrNw/IYNEf7iAESiN0L6XlusI
        CvFiNeHrsBN51MYBliNEjIQaf6hILkty3VsZcDtojSKss1zXKQY6Kb927KUyVRlPGtx4qTP/oLG
        hQ/69aV/73v6Ojpw4Jzi6oUfNNRxOndR8ksze/CR44w==
X-Received: by 2002:a5d:6d83:0:b0:203:6a0e:8854 with SMTP id l3-20020a5d6d83000000b002036a0e8854mr2692872wrs.259.1647501526410;
        Thu, 17 Mar 2022 00:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytsSOdD01cQjALk7690n3GvJebKeuAROT9DhRnjhAcswV0RIc5s795EBWkfXBcW8ftjHt4ZQ==
X-Received: by 2002:a5d:6d83:0:b0:203:6a0e:8854 with SMTP id l3-20020a5d6d83000000b002036a0e8854mr2692857wrs.259.1647501526195;
        Thu, 17 Mar 2022 00:18:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm3478857wmh.33.2022.03.17.00.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:18:45 -0700 (PDT)
Message-ID: <726bde76-d792-febf-d364-6eedeb748c3b@canonical.com>
Date:   Thu, 17 Mar 2022 08:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] clocksource: arch_timer: Add arm,cortex-a7/15-timer
 in of_match list
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-4-singh.kuldeep87k@gmail.com>
 <f54b0647-12ad-5861-8b8b-5d4233bb9bd2@canonical.com>
 <20220316174108.GB21737@9a2d8922b8f1> <87zglpybzw.wl-maz@kernel.org>
 <20220317065925.GA9158@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220317065925.GA9158@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 07:59, Kuldeep Singh wrote:
> On Wed, Mar 16, 2022 at 06:43:15PM +0000, Marc Zyngier wrote:
>> On Wed, 16 Mar 2022 17:41:08 +0000,
>> Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
>>>
>>> On Wed, Mar 16, 2022 at 05:30:26PM +0100, Krzysztof Kozlowski wrote:
>>>> On 16/03/2022 10:54, Kuldeep Singh wrote:
>>>>> Few platforms such as Renesas RZ/N1D, Calxeda, Alpine etc. are using
>>>>> arm,cortex-a15-timer and arm,cortex-a7-timer entries in conjugation with
>>>>> arm,armv7-timer which are not currently defined in driver file. Add
>>>>> these entries in arch_timer_of_match list to bring them in use.
>>>>>
>>>>
>>>> This looks wrong (also Marc pointed this out) and rationale is not
>>>> sufficient. Why do you need these compatibles in the driver?
>>>
>>> Hi Krzysztof and Marc,
>>>
>>> I find myself in trouble whenever dealing with compatible entries and
>>> had 2 options when I stumble this issue.
>>> 	1. Remove unused compatible
>>
>> That'd be silly.
>>
>>> 	2. Add required compatible to binding and driver
>>
>> To the binding, yes. But to the driver?
>>
>>> My past experience and advise from other developer says not to remove an
>>> existing compatible. And also I found "arm,cortex-a15-timer" in binding
>>> which was again not documented and was present in DT. This prompted me
>>> to go for second option and make necessary additions in binding and
>>> driver following current entries.
>>
>> The "arm,cortex-a15-timer" compatible is documentation, and only
>> that. If, one day, we find a bug in this implementation, we could work
>> around it in the driver thanks to the separate compatible (although in
>> this case, we'd have much better way of doing that).
>>
>>> As per your perspective, current configuration isn't apt which means
>>> "arm,cortex-a15-timer" is a stub and is wrongly present in binding.
>>
>> That's not what I said. This compatible string is perfectly fine, and
>> accurately describe the HW. The driver doesn't need to know about the
>> fine details of the implementation, and is perfectly happy with the
>> current state of things.
>>
>> Think of it as an instance of a class. The driver doesn't need to know
>> the instance, only that it is a certain class.
>>
> 
> Thanks Marc for sharing knowledge. This was indeed helpful.
> To sum up from what I understood, bindings and DTs should always be in
> sync and driver file may not need to define all compatible entries as
> long as purpose is served.
> 
> This means no driver change will be required to address
> "arm,cortex-a7-timer". To which I have a question to Krzysztof.
> 
> Hi Krzysztof,
> 
> As per your comments on 2/3 patch, that it's DT which is not aligned
> with binding w.r.t arm,cortex-a7-timer.
> 
> What makes "arm,cortex-a7-timer" an invalid entry from binding
> perspective when we have a similar entry "arm,cortex-a15-timer" already
> present?
> 
> I think we should share some common grounds here and keep both of them
> in bindings or remove them altogether. I prefer first option, What's
> your say?

In this case the compatible should be added, just please explain it in
the message. Your previous commit msg was saying about disastrous
backward compatibility issue which so far does not exist here. It's
simply more detailed compatible.

There were few other cases where more detailed compatible was actually
unwanted, so that's why each case should be analyzed.

Best regards,
Krzysztof
