Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5F4876D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbiAGLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiAGLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:52:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D674C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:52:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e5so3747879wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+v65dbymAmhdz70zjQsgwhuuC70Kn2IqrbK3x6r9EQ=;
        b=EniNqefda68+tvBDXbfbsYibERdc8QM8kXumEieusVvefyXztMy2uHZL/TZ+l2UXVz
         AjTA8uMHLVpqEttUV2+uuSzEjG5sABmu5+TnLBsW4b+MVG0lNPrDgGh0yb+O8PTWFCg6
         bn98LM0nToumySsLmHhPOKzBWOpYrB1G9Ms9ztog+ljmuoano/81boEuMx9+48dDrrup
         SiuNSmWEG5DtxkWpUFmhuN+nnoNrhr/efPMqFJ1uonWxHwtBppJlWJNCfAxo6UundamO
         0cUkjORJVZNr0t2ZosCMaq92diOBl1ldTHbRdTq6pqp2Q6uFjppcJHHu819xtnh9Qm8M
         MP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+v65dbymAmhdz70zjQsgwhuuC70Kn2IqrbK3x6r9EQ=;
        b=JYO+2A61P5tQ+dnsF8bTAk8/NWx+icp2UxYWjJAaZHy7bqsgz0+jcBQk+tBx1rotu2
         yyeafSoVYrgjcLptlhgCzQXbSH7EM+LWxmIEp5v2tVhB1RQBeun7bx7EEwrAiyZZUraP
         jo466hqMPozjhzplt9pEd8zvwFD2JwgoVz+RFbwAvr8DT5XiFnBJ7sNkDKGeFMcvdSL/
         2KmMQO32SnmuKihAp9IMIUqGTL9dO199I/+WYmKsi+xj3N8sFZ7YMizrb/86tD76PvR9
         7RIhdh/f6cQQygmptajerAmtB/uiOHzxKmGGES4yVFHGk5iYIQl5MRN9iMnpSPAapDYd
         y5FA==
X-Gm-Message-State: AOAM531e6Px9BFcEjvfHAN+GNlFLVZX/Zn1/4AvvFtR8wXa2oDlAAjps
        2/JyGK5RTapjCJrv9GMTmEvg9A==
X-Google-Smtp-Source: ABdhPJyONxY2KW0bOiX73rFYHQx3qpz02tX5V0UTVRixd6paxgVStplFldFYbkYmEeNCkuh0SpI2QQ==
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr10855056wms.32.1641556360452;
        Fri, 07 Jan 2022 03:52:40 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4875:220c:f3a4:c74e? ([2a01:e34:ed2f:f020:4875:220c:f3a4:c74e])
        by smtp.googlemail.com with ESMTPSA id d18sm2606303wrn.102.2022.01.07.03.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 03:52:39 -0800 (PST)
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, amitk@kernel.org,
        Chetankumar Mistry <chetan.mistry@arm.com>,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
 <23c3480a-c46b-f049-5758-d11124367190@arm.com>
 <1b6047eb-2f14-ddde-4712-145a26dc8aa5@linaro.org>
 <42e8c75e-3827-3950-0705-4670ec1c904e@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0e9eb5a9-733c-cf4d-a8c9-e13b5258dce5@linaro.org>
Date:   Fri, 7 Jan 2022 12:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <42e8c75e-3827-3950-0705-4670ec1c904e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 14:16, Lukasz Luba wrote:
> 
> Thank you for fast response!
> 
> On 1/6/22 12:16 PM, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>> On 06/01/2022 12:54, Lukasz Luba wrote:
>>> Hi Daniel,
>>>
>>> Could you have a look at this, please?
>>
>> Yes, I had a quick look at the code and went to the algorithm
>> description.
>>
>> Still digesting ...
>>
>>> On 12/17/21 6:49 PM, Chetankumar Mistry wrote:
>>>> Implement the Ziegler-Nichols Heuristic algorithm to better
>>>> estimate the PID Coefficients for a running platform.
>>>> The values are tuned to minimuse the amount of overshoot in
>>>> the temperature of the platform and subsequently minimise
>>>> the number of switches for cdev states.
>>>>
>>>> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
>>>
>>>
>>> This is the continuation of the previous idea to have
>>> better k_* values. You might remember this conversation [1].
>>>
>>> I've spent some time researching papers how and what can be done
>>> in this field and if possible to plumb in to the kernel.
>>> We had internal discussions (~2017) of one method fuzzy-logic that I
>>> found back then, but died at the begging not fitting into this
>>> IPA kernel specific environment and user-space. Your suggestion with
>>> observing undershooting and overshooting results sparked better idea.
>>> I thought it's worth to invest in it but I didn't have
>>> time. We are lucky, Chetan was designated to help me and
>>> experiment/implement/test these ideas and here is the patch set.
>>>
>>> He's chosen the Ziegler-Nichols method, which shows really
>>> good results in benchmarks (Geekbench and GFXbench on hikey960 Android).
>>> The improved performance in Geekbench is ~10% (vs. old IPA).
>>
>> +10% perf improvements sounds great. What about the temperature
>> mitigation (temp avg + stddev) ?
> 
> Chetan would respond about that with the link to the .html file.
> We just have to create an official public server space for it.
> I hope till Monday evening we would get something.
> 
>>
>>> The main question from our side is the sysfs interface
>>> which we could be used to trigger this algorithm for
>>> better coefficients estimations.
>>> We ask user to echo to some sysfs files in thermal zone
>>> and start his/her workload. This new IPA 'learns' the system
>>> utilization and reaction in temperature. After a few rounds,
>>> we get better fitted coefficients.
>>> If you need more background about the code or mechanisms, or tests,
>>> I'm sure Chetan is happy to provide you those.
>>
>> I'm worried about the complexity of the algorithm and the overhead
>> implied.
>>
>> The k_* factors are tied with the system and the thermal setup (fan,
>> heatsink, processor, opp, ...). So IIUC when the factors are found, they
>> should not change and could be part of the system setup.
> 
> True, they are found and will be fixed for that board.
> 
>>
>> Would the algorithm fit better in a separate userspace kernel tooling?
>> So we can run it once and find the k_* for a board.
> 
> We wanted to be part of IPA in kernel because:
> - the logic needs access to internals of IPA
> - it would be easy accessible for all distros out-of-box
> - no additional maintenance and keeping in sync two codes, especially
>   those in some packages for user-space

Sorry, I'm not convinced :/

AFAICT, the temperature and the sampling rate should be enough
information to find out the k_*

IMO, an userspace tool in ./tools/thermal/ipa is the right place

So if you give the tooling to the SoC vendor via the thermal ones, with
a file containing the temp + timestamp, they should be able to find the
k_* and setup their boards.

Actually my opinion is the kernel should not handle everything and the
SoC vendor should at least do some work to setup their system. If they
are able to find out the sustainable power, they can do the same for the
right coefficients.

>> Additionally, the values can be stored in the Documentation for
>> different board and a documentation on how to use the tool.
>>
>> Then up to the SoC vendor to setup the k_* in sysfs, so no need to
>> change any interface.
> 
> It wouldn't be for SoC vendor, but up to the OEM or board designer,
> because the same SoC might have different thermal headroom thanks
> to better cooling or bigger PCB, etc.

Right, s/SoC vendor/SoC platform/

> I agree that these optimized k_* values might be shared in the kernel.
> Ideally I would see them in the board's DT file, in the thermal zone,
> but I'm afraid they are not 'Device description' so don't fit into DT
> scope. They are rather optimizations of pure kernel mechanism.
> 
> where would be a good place for it? Maybe a new IPA Documentation/
> sub-directory?

You can improve the documentation in:

Documentation/driver-api/thermal/power_allocator.rst

And if we agree on a tools/thermal/ipa, the documentation with examples
and some SoC reference can be put there also

>>> If you are interested in those analyses we can find a way to share a>
>>> .html file with the results from LISA notebook.
>>
>> Yes,
> 
> Sure thing, let me arrange that.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
