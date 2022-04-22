Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C750B4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446421AbiDVKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352684AbiDVKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:12:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C164E53E28;
        Fri, 22 Apr 2022 03:09:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A341477;
        Fri, 22 Apr 2022 03:09:30 -0700 (PDT)
Received: from [10.57.11.218] (unknown [10.57.11.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2942F3F766;
        Fri, 22 Apr 2022 03:09:28 -0700 (PDT)
Message-ID: <4f4c5140-6631-a364-0ae3-4f9ba05f8fa9@arm.com>
Date:   Fri, 22 Apr 2022 11:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/6] coresight: Fail to open with return stacks if they
 are unavailable
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220113091056.1297982-1-james.clark@arm.com>
 <20220113091056.1297982-3-james.clark@arm.com>
 <50e5ff63-ae00-f04b-fc5b-f294742cb13a@arm.com>
 <292386ee-cfa8-d849-57ce-156c76680e12@arm.com>
 <CAJ9a7VjiYrnQKUBkcQPs-iJomxFUAJ9Wmq0A+JwN4O_bbqhX1A@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7VjiYrnQKUBkcQPs-iJomxFUAJ9Wmq0A+JwN4O_bbqhX1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2022 15:53, Mike Leach wrote:
> Hi,
> 
> 
> On Fri, 11 Mar 2022 at 14:52, James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 28/01/2022 11:24, Suzuki K Poulose wrote:
>>> Hi James
>>>
>>> On 13/01/2022 09:10, James Clark wrote:
>>>> Maintain consistency with the other options by failing to open when they
>>>> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
>>>> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
>>>> requested but not supported by hardware.
>>>
>>> Looking at this again (with similar comment to the Branch Broadcast),
>>> won't it disable using retstack on all CPUs, even when some of them
>>> support it ?
>>>
>>> i.e., CPU0 - supports retstack, CPU1 - doesn't
>>>
>>> A perf run with retstack will fail, as CPU1 doesn't support it (even
>>> though we advertise it, unconditionally).
>>>
>>> So, if we ignore the failure, this would still allow CPU0 to use
>>> the feature and as long as the OpenCSD is able to decode the trace
>>> we should ignore the failure ?
>>>
>>> I think we may also need to tune the etm4x_enable_hw() to skip
>>> updating the TRCCONFIGR with features not supported by the ETM
>>>
>>
>> Hi Suzuki,
>>
>> I'm picking up this branch broadcast change again after the haitus.
>>
>> For this point, do you think it would be worth distinguishing between "no
>> known CPUs that support the feature" vs "not currently running on a
>> CPU that supports it but there are others that do"?
>>
>> Also would we want to distinguish between per-CPU or per-process events?
>> For the former it actually is possible to fail to open because all of
>> the information is known.
>>
>> I'm just thinking of the case where someone asks for a load of flags
>> and thinks that they're getting them but get no feedback that they won't.
>> But I understand having some complicated solution like I'm suggesting
>> might be even more surprising to users.
>>
>> Maybe the cleanest solution is to ask users to supply a config that
>> can work on anywhere the event could possibly be scheduled. It doesn't
>> really make sense to have retstack on a per-process event on big-little
>> and then getting half of one type of data and half of another. It would
>> make more sense to fail to open in that case and they have the choice of
>> either doing per-CPU events or disabling retstacks altogether.
>>
> 
> return stack has no effect on the decoder output whatsoever. The only
> effect is to reduce the amount of traced addresses at the input
> (leaving more space for other trace),
> so it is irrelevant if CPU0 supports it but CPU1 doesn't.
> 
> sequence:
> 
> BL r0 (return stack is used only on link instructions)
> ...
> RET
> 
> will output trace:-
> ATOM E (BL r0)
> ...
> ADDR_ELEM <ret addr>
> ATOM E (RET)
> 
> for no return stack,
> 
> ATOM E (BL r0)
> ...
> ATOM E (RET)
> 
> fior return stack.
> 
> In both cases the decoder will push the address after BL r0 onto its
> return stack.
> 
> In the first case the decoder will use the supplied address, in the
> second will pop the top of its return stack.
> 
> The decode output in both cases will be "branched to r0, ran code,
> returned via link register"
> 
> The outcome is identical for the client. So the case for not tracing
> on a core that does not have return stack if specified is weak.
> 
> Perhaps a warning will be sufficient?
> 
> Mike
> 
> 
> 
>> This seems like a similar problem to the issue causing the Coresight self
>> test failure where a certain sink was picked that couldn't be reached and
>> the test failed.
>>
>> In that case the change we made doesn't quite match up to my suggestion here:
>>
>>  * Per-cpu but an unreachable sink -> fail
>>  * Per-process and potentially reachable sink in the future -> pass
>>
>> Maybe it would have been better to say that the sink always has to be
>> reachable otherwise is the outcome predicatable?

Hi Mike,

If it has no effect on the output then it makes sense to me to just drop this
patch. I think even a warning would not add much and as far as I know they are
discouraged.

James

>>
>> James
>>
>>> Suzuki
>>>
>>>
>>>>
>>>> The consequence of not doing this is that the user may not be
>>>> aware that they are not enabling the feature as it is silently disabled.
>>>>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> index 04669ecc0efa..a93c1a5fe045 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>>       }
>>>>         /* return stack - enable if selected and supported */
>>>> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>>>> -        /* bit[12], Return stack enable bit */
>>>> -        config->cfg |= BIT(12);
>>>> -
>>>> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
>>>> +        if (!drvdata->retstack) {
>>>> +            ret = -EINVAL;
>>>> +            goto out;
>>>> +        } else {
>>>> +            /* bit[12], Return stack enable bit */
>>>> +            config->cfg |= BIT(12);
>>>> +        }
>>>> +    }
>>>>       /*
>>>>        * Set any selected configuration and preset.
>>>>        *
>>>
> 
> 
> 
