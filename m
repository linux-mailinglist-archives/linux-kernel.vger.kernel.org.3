Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A684A8393
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiBCMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:08:08 -0500
Received: from foss.arm.com ([217.140.110.172]:42786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbiBCMIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:08:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80D7511D4;
        Thu,  3 Feb 2022 04:08:06 -0800 (PST)
Received: from [10.57.13.234] (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE903F774;
        Thu,  3 Feb 2022 04:08:05 -0800 (PST)
Message-ID: <83349132-eac4-d05d-ff47-204fa8914922@arm.com>
Date:   Thu, 3 Feb 2022 12:08:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/15] coresight: Make ETM4x TRCIDR0 register accesses
 consistent with sysreg.h
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202160226.37858-1-james.clark@arm.com>
 <20220202160226.37858-2-james.clark@arm.com>
 <41b08fa5-6333-48e8-4727-2082c001e148@arm.com>
 <da8768ba-fb10-e2d5-fdcf-2b3c6b9c6b18@arm.com>
 <3df77ddd-31df-c2d8-7aac-e21c7ba48f1e@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <3df77ddd-31df-c2d8-7aac-e21c7ba48f1e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2022 10:54, Suzuki K Poulose wrote:
> On 03/02/2022 10:40, James Clark wrote:
>>
>>
>> On 02/02/2022 17:05, Suzuki K Poulose wrote:
>>> Hi James
>>>
>>> Thanks for taking this tedious task of cleaning the code and making
>>> this robust and readable.
>>>
>>> One minor comment below.
>>>
>>> On 02/02/2022 16:02, James Clark wrote:
>>>> This is a no-op change for style and consistency and has no effect on the
>>>> binary produced by gcc-11.
>>>>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>>    .../coresight/coresight-etm4x-core.c          | 37 +++++--------------
>>>>    drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++++
>>>>    drivers/hwtracing/coresight/coresight-priv.h  |  1 +
>>>>    3 files changed, 27 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> index bf18128cf5de..8aefee4e72fd 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> @@ -1091,41 +1091,22 @@ static void etm4_init_arch_data(void *info)
>>>>        etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
>>>>          /* INSTP0, bits[2:1] P0 tracing support field */
>>>> -    if (BMVAL(etmidr0, 1, 1) && BMVAL(etmidr0, 2, 2))
>>>> -        drvdata->instrp0 = true;
>>>> -    else
>>>> -        drvdata->instrp0 = false;
>>>> -
>>>> +    drvdata->instrp0 = !!((REG_VAL(etmidr0, TRCIDR0_INSTP0) & 0b01) &&
>>>> +                  (REG_VAL(etmidr0, TRCIDR0_INSTP0) & 0b10));
>>>
>>> I don't understand this check. For ETMv4, here is what I find in the spec (ARM IHI 0064C)
>>>
>>> P0 tracing support field. The permitted values are:
>>> 0b00  Tracing of load and store instructions as P0 elements is not
>>>        supported.
>>> 0b11  Tracing of load and store instructions as P0 elements is
>>>        supported, so TRCCONFIGR.INSTP0 is supported.
>>>
>>> All other values are reserved.
>>>
>>> So the check could simply be :
>>>
>>>      drvdata->instrp0 = (REG_VAL(emtidr0, TRCIDR0_INSTP0) == 0b11;
>>
>> Yes I can make this change, but it does make the compiler emit a slightly different binary
>> so we can't rely on that to check the refactor is ok.
>>
>> Should I change it in this commit or stick it on the very end? Probably the end is best
>> in case I have to do any rebases and I still need to validate there are no mistakes.
> 
> I would say, fix the existing check first and then convert to use the
> updated symbols.
> 
> That way we could queue the fix separately and you may be able to rebase
> your next version on the updated tree ?

Good idea, I've resubmitted v2 with that and the other comments you left.

> 
> 
> Cheers
> Suzuki
