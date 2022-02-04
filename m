Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705E4A9895
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358485AbiBDLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358482AbiBDLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:50:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB8C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:50:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so1752652wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 03:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XBV2NEdWJ9ljGaEuHHgzchFvTAcJQTaSQmnJqyLsTc0=;
        b=wifJrs7e9Av90Ae+xhybcNJr8yN3BdyZ8Eh/A9e0KB/NwBXTyHQ6K+Tgwz/hm1X2oM
         V+fXSKh7iO+UT0w2hSeyJ9Jvhl5uaA0FX/yd/fo7DCPePBzmQpmJ2Bi4HuyQKTZM+V88
         YN9/tQgvexig/pUo7LTJV7VgUXaMtY6KHFVGk2XwIs0ABexdLehkFbVasOy6uw6fqJ1t
         vgC6elKDTgPYqwCNJ6oDfxYUlSiKWfaGmou/W68ELVorQdsp/FBMksEMsuvW5fiR8fvr
         No6KPFvRMiYEWFoQTRykSiouOruuwV7nN703LR5IFc8zROn7BAUFsl1cgAdrXx0nD8s2
         dGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XBV2NEdWJ9ljGaEuHHgzchFvTAcJQTaSQmnJqyLsTc0=;
        b=YmLN+LD8ttTcNyAEFBlTKz9PATy9NphDELphVH1yL8wT8mZ5VHTnZJD3lLamjuMyvp
         iYVyWZbNHQHiVcqp2wVHCNadxl/nxv6dY/noiuOQYO1WG5M32h7hkPs6/n8uqRc3pU7y
         0vbwc8T3Ra17leX18VJStnLoVeWQU+GoTbfG/638WObZeK8CjjClQSFvwjXFElGDOUt6
         c1HOuhyD5wvICTOBKiXzGFpyJJNuTe+db2IyBljlmcr+DAS0frotTJpZl0BQU+LHtRR8
         cYLd5L4nWEe9LAOltg0amao4ieA79C+n2QFKvUzPXhGxAIBGbSBvOVwwz7E8PudHbRMG
         pmng==
X-Gm-Message-State: AOAM533c8yClYfHMTj+l3zHSK7jTeUNGF6srpKXiU0BR48Vzperl7Tc9
        T9USrME9+pSSe8t5LnHhHA53zw==
X-Google-Smtp-Source: ABdhPJyvenc6JqlkfeRzzFkn21z3hodSeNht23CRynoJr1VAprtVoPHcrJVh0sGv6DqQNoz29M3nYA==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr2260058wri.238.1643975427582;
        Fri, 04 Feb 2022 03:50:27 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:46b:d462:f12b:a36? ([2a01:e34:ed2f:f020:46b:d462:f12b:a36])
        by smtp.googlemail.com with ESMTPSA id r2sm2517731wrz.99.2022.02.04.03.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 03:50:26 -0800 (PST)
Message-ID: <2ef44d81-fb6f-5753-de62-e36778be0537@linaro.org>
Date:   Fri, 4 Feb 2022 12:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
Content-Language: en-US
To:     Chetan Mistry <Chetan.Mistry@arm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
 <23c3480a-c46b-f049-5758-d11124367190@arm.com>
 <1b6047eb-2f14-ddde-4712-145a26dc8aa5@linaro.org>
 <42e8c75e-3827-3950-0705-4670ec1c904e@arm.com>
 <0e9eb5a9-733c-cf4d-a8c9-e13b5258dce5@linaro.org>
 <120bdfda-92b9-d098-d298-e319be158417@arm.com>
 <DB6PR0802MB22791E85B333050C801ED388F8299@DB6PR0802MB2279.eurprd08.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <DB6PR0802MB22791E85B333050C801ED388F8299@DB6PR0802MB2279.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks!

On 04/02/2022 12:48, Chetan Mistry wrote:
> Hi Daniel,
> 
> Here is a link to the Compiled Jupyter Notebook with the performance 
> analysis of the proposed system vs what is currently there:
> 
> https://nbviewer.org/gist/chemis01/0e86ad81508860659a57338dae8274f9 
> <https://nbviewer.org/gist/chemis01/0e86ad81508860659a57338dae8274f9>
> 
> Kind Regards,
> 
> Chetan
> 
> *From: *Lukasz Luba <lukasz.luba@arm.com>
> *Date: *Friday, 7 January 2022 at 13:39
> *To: *Daniel Lezcano <daniel.lezcano@linaro.org>
> *Cc: *rafael@kernel.org <rafael@kernel.org>, 
> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, 
> amitk@kernel.org <amitk@kernel.org>, Chetan Mistry 
> <Chetan.Mistry@arm.com>, rui.zhang@intel.com <rui.zhang@intel.com>, 
> linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>
> *Subject: *Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
> 
> 
> 
> On 1/7/22 11:52 AM, Daniel Lezcano wrote:
>> On 06/01/2022 14:16, Lukasz Luba wrote:
>>>
>>> Thank you for fast response!
>>>
>>> On 1/6/22 12:16 PM, Daniel Lezcano wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>> On 06/01/2022 12:54, Lukasz Luba wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Could you have a look at this, please?
>>>>
>>>> Yes, I had a quick look at the code and went to the algorithm
>>>> description.
>>>>
>>>> Still digesting ...
>>>>
>>>>> On 12/17/21 6:49 PM, Chetankumar Mistry wrote:
>>>>>> Implement the Ziegler-Nichols Heuristic algorithm to better
>>>>>> estimate the PID Coefficients for a running platform.
>>>>>> The values are tuned to minimuse the amount of overshoot in
>>>>>> the temperature of the platform and subsequently minimise
>>>>>> the number of switches for cdev states.
>>>>>>
>>>>>> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
>>>>>
>>>>>
>>>>> This is the continuation of the previous idea to have
>>>>> better k_* values. You might remember this conversation [1].
>>>>>
>>>>> I've spent some time researching papers how and what can be done
>>>>> in this field and if possible to plumb in to the kernel.
>>>>> We had internal discussions (~2017) of one method fuzzy-logic that I
>>>>> found back then, but died at the begging not fitting into this
>>>>> IPA kernel specific environment and user-space. Your suggestion with
>>>>> observing undershooting and overshooting results sparked better idea.
>>>>> I thought it's worth to invest in it but I didn't have
>>>>> time. We are lucky, Chetan was designated to help me and
>>>>> experiment/implement/test these ideas and here is the patch set.
>>>>>
>>>>> He's chosen the Ziegler-Nichols method, which shows really
>>>>> good results in benchmarks (Geekbench and GFXbench on hikey960 Android).
>>>>> The improved performance in Geekbench is ~10% (vs. old IPA).
>>>>
>>>> +10% perf improvements sounds great. What about the temperature
>>>> mitigation (temp avg + stddev) ?
>>>
>>> Chetan would respond about that with the link to the .html file.
>>> We just have to create an official public server space for it.
>>> I hope till Monday evening we would get something.
>>>
>>>>
>>>>> The main question from our side is the sysfs interface
>>>>> which we could be used to trigger this algorithm for
>>>>> better coefficients estimations.
>>>>> We ask user to echo to some sysfs files in thermal zone
>>>>> and start his/her workload. This new IPA 'learns' the system
>>>>> utilization and reaction in temperature. After a few rounds,
>>>>> we get better fitted coefficients.
>>>>> If you need more background about the code or mechanisms, or tests,
>>>>> I'm sure Chetan is happy to provide you those.
>>>>
>>>> I'm worried about the complexity of the algorithm and the overhead
>>>> implied.
>>>>
>>>> The k_* factors are tied with the system and the thermal setup (fan,
>>>> heatsink, processor, opp, ...). So IIUC when the factors are found, they
>>>> should not change and could be part of the system setup.
>>>
>>> True, they are found and will be fixed for that board.
>>>
>>>>
>>>> Would the algorithm fit better in a separate userspace kernel tooling?
>>>> So we can run it once and find the k_* for a board.
>>>
>>> We wanted to be part of IPA in kernel because:
>>> - the logic needs access to internals of IPA
>>> - it would be easy accessible for all distros out-of-box
>>> - no additional maintenance and keeping in sync two codes, especially
>>>    those in some packages for user-space
>> 
>> Sorry, I'm not convinced :/
>> 
>> AFAICT, the temperature and the sampling rate should be enough
>> information to find out the k_*
> 
> We are allowing to overshoot the temperature by not capping the
> power actors, but we have a safety net to not overshoot too much.
> It's internal decision insdie IPA. Userspace would have to
> re-implement whole IPA logic and take control over cooling
> device states - which would contradict the decision from IPA
> controlling the same thermal zone. The finding of coefficients
> is by testing many values while running. The post processing
> of the data (temp., power requests, frequency, etc) won't tell us
> the the limits. We have to check them. That means the user-space tool
> would have to re-implement major part of IPA, but also somehow
> get the CPUs utilization, then use the obsolete user-space
> governor API to experiment with them.
> 
>> 
>> IMO, an userspace tool in ./tools/thermal/ipa is the right place
>> 
>> So if you give the tooling to the SoC vendor via the thermal ones, with
>> a file containing the temp + timestamp, they should be able to find the
>> k_* and setup their boards.
> 
> This feature is aimed for every user of the device, even w/o
> expert knowledge in thermal/power. If vendor or OEM didn't
> support properly the board, users could do this and they don't
> have to be restricted (IMO).
> Apart from that, I see vendors are rather interested in investing
> in their proprietary solutions, not willing to share know-how
> in open source power/thermal mechanisms. Then user is restricted
> IMO in using the board. This might block e.g. research of some
> PhD students, who have good ideas, but the restrictions of the platform
> prevent them or cause the behavior of the board that they cannot
> control. I would like to enable everyone to use fully the potential
> of the HW/SW - even end-user.
> 
>> 
>> Actually my opinion is the kernel should not handle everything and the
>> SoC vendor should at least do some work to setup their system. If they
>> are able to find out the sustainable power, they can do the same for the
>> right coefficients.
> 
> Ideally, yes, I would also like to see that. As you said a few months
> ago during review of my former patches, a lot of this 'sustainable
> power' entries in DT are Linaro contribution. I wish vendors also
> contribute, but c'est la vie.
> 
>> 
>>>> Additionally, the values can be stored in the Documentation for
>>>> different board and a documentation on how to use the tool.
>>>>
>>>> Then up to the SoC vendor to setup the k_* in sysfs, so no need to
>>>> change any interface.
>>>
>>> It wouldn't be for SoC vendor, but up to the OEM or board designer,
>>> because the same SoC might have different thermal headroom thanks
>>> to better cooling or bigger PCB, etc.
>> 
>> Right, s/SoC vendor/SoC platform/
>> 
>>> I agree that these optimized k_* values might be shared in the kernel.
>>> Ideally I would see them in the board's DT file, in the thermal zone,
>>> but I'm afraid they are not 'Device description' so don't fit into DT
>>> scope. They are rather optimizations of pure kernel mechanism.
>>>
>>> where would be a good place for it? Maybe a new IPA Documentation/
>>> sub-directory?
>> 
>> You can improve the documentation in:
>> 
>> Documentation/driver-api/thermal/power_allocator.rst
>> 
>> And if we agree on a tools/thermal/ipa, the documentation with examples
>> and some SoC reference can be put there also
>> 
>>>>> If you are interested in those analyses we can find a way to share a>
>>>>> .html file with the results from LISA notebook.
>>>>
>>>> Yes,
>>>
>>> Sure thing, let me arrange that.
>> 
>> 
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are 
> confidential and may also be privileged. If you are not the intended 
> recipient, please notify the sender immediately and do not disclose the 
> contents to any other person, use it for any purpose, or store or copy 
> the information in any medium. Thank you.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
