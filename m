Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D1486511
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbiAFNQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:16:40 -0500
Received: from foss.arm.com ([217.140.110.172]:53122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbiAFNQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:16:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B9912FC;
        Thu,  6 Jan 2022 05:16:38 -0800 (PST)
Received: from [10.57.11.40] (unknown [10.57.11.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BFDD3F5A1;
        Thu,  6 Jan 2022 05:16:37 -0800 (PST)
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, amitk@kernel.org,
        Chetankumar Mistry <chetan.mistry@arm.com>,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
 <23c3480a-c46b-f049-5758-d11124367190@arm.com>
 <1b6047eb-2f14-ddde-4712-145a26dc8aa5@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <42e8c75e-3827-3950-0705-4670ec1c904e@arm.com>
Date:   Thu, 6 Jan 2022 13:16:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1b6047eb-2f14-ddde-4712-145a26dc8aa5@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for fast response!

On 1/6/22 12:16 PM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> On 06/01/2022 12:54, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> Could you have a look at this, please?
> 
> Yes, I had a quick look at the code and went to the algorithm description.
> 
> Still digesting ...
> 
>> On 12/17/21 6:49 PM, Chetankumar Mistry wrote:
>>> Implement the Ziegler-Nichols Heuristic algorithm to better
>>> estimate the PID Coefficients for a running platform.
>>> The values are tuned to minimuse the amount of overshoot in
>>> the temperature of the platform and subsequently minimise
>>> the number of switches for cdev states.
>>>
>>> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
>>
>>
>> This is the continuation of the previous idea to have
>> better k_* values. You might remember this conversation [1].
>>
>> I've spent some time researching papers how and what can be done
>> in this field and if possible to plumb in to the kernel.
>> We had internal discussions (~2017) of one method fuzzy-logic that I
>> found back then, but died at the begging not fitting into this
>> IPA kernel specific environment and user-space. Your suggestion with
>> observing undershooting and overshooting results sparked better idea.
>> I thought it's worth to invest in it but I didn't have
>> time. We are lucky, Chetan was designated to help me and
>> experiment/implement/test these ideas and here is the patch set.
>>
>> He's chosen the Ziegler-Nichols method, which shows really
>> good results in benchmarks (Geekbench and GFXbench on hikey960 Android).
>> The improved performance in Geekbench is ~10% (vs. old IPA).
> 
> +10% perf improvements sounds great. What about the temperature
> mitigation (temp avg + stddev) ?

Chetan would respond about that with the link to the .html file.
We just have to create an official public server space for it.
I hope till Monday evening we would get something.

> 
>> The main question from our side is the sysfs interface
>> which we could be used to trigger this algorithm for
>> better coefficients estimations.
>> We ask user to echo to some sysfs files in thermal zone
>> and start his/her workload. This new IPA 'learns' the system
>> utilization and reaction in temperature. After a few rounds,
>> we get better fitted coefficients.
>> If you need more background about the code or mechanisms, or tests,
>> I'm sure Chetan is happy to provide you those.
> 
> I'm worried about the complexity of the algorithm and the overhead implied.
> 
> The k_* factors are tied with the system and the thermal setup (fan,
> heatsink, processor, opp, ...). So IIUC when the factors are found, they
> should not change and could be part of the system setup.

True, they are found and will be fixed for that board.

> 
> Would the algorithm fit better in a separate userspace kernel tooling?
> So we can run it once and find the k_* for a board.

We wanted to be part of IPA in kernel because:
- the logic needs access to internals of IPA
- it would be easy accessible for all distros out-of-box
- no additional maintenance and keeping in sync two codes, especially
   those in some packages for user-space

> 
> Additionally, the values can be stored in the Documentation for
> different board and a documentation on how to use the tool.
> 
> Then up to the SoC vendor to setup the k_* in sysfs, so no need to
> change any interface.

It wouldn't be for SoC vendor, but up to the OEM or board designer,
because the same SoC might have different thermal headroom thanks
to better cooling or bigger PCB, etc.

I agree that these optimized k_* values might be shared in the kernel.
Ideally I would see them in the board's DT file, in the thermal zone,
but I'm afraid they are not 'Device description' so don't fit into DT
scope. They are rather optimizations of pure kernel mechanism.

where would be a good place for it? Maybe a new IPA Documentation/
sub-directory?

> 
>> If you are interested in those analyses we can find a way to share a> .html file with the results from LISA notebook.
> 
> Yes,

Sure thing, let me arrange that.
