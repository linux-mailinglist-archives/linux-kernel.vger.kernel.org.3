Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2384D641D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiCKOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbiCKOxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:53:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3381EA9958;
        Fri, 11 Mar 2022 06:52:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888CD175A;
        Fri, 11 Mar 2022 06:52:34 -0800 (PST)
Received: from [10.57.43.254] (unknown [10.57.43.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 673393F7F5;
        Fri, 11 Mar 2022 06:52:32 -0800 (PST)
Message-ID: <292386ee-cfa8-d849-57ce-156c76680e12@arm.com>
Date:   Fri, 11 Mar 2022 14:52:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/6] coresight: Fail to open with return stacks if they
 are unavailable
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        leo.yan@linaro.com, mike.leach@linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>, John Garry <john.garry@huawei.com>,
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
From:   James Clark <james.clark@arm.com>
In-Reply-To: <50e5ff63-ae00-f04b-fc5b-f294742cb13a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2022 11:24, Suzuki K Poulose wrote:
> Hi James
> 
> On 13/01/2022 09:10, James Clark wrote:
>> Maintain consistency with the other options by failing to open when they
>> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
>> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
>> requested but not supported by hardware.
> 
> Looking at this again (with similar comment to the Branch Broadcast),
> won't it disable using retstack on all CPUs, even when some of them
> support it ?
> 
> i.e., CPU0 - supports retstack, CPU1 - doesn't
> 
> A perf run with retstack will fail, as CPU1 doesn't support it (even
> though we advertise it, unconditionally).
> 
> So, if we ignore the failure, this would still allow CPU0 to use
> the feature and as long as the OpenCSD is able to decode the trace
> we should ignore the failure ?
> 
> I think we may also need to tune the etm4x_enable_hw() to skip
> updating the TRCCONFIGR with features not supported by the ETM
> 

Hi Suzuki,

I'm picking up this branch broadcast change again after the haitus.

For this point, do you think it would be worth distinguishing between "no
known CPUs that support the feature" vs "not currently running on a
CPU that supports it but there are others that do"?

Also would we want to distinguish between per-CPU or per-process events?
For the former it actually is possible to fail to open because all of
the information is known.

I'm just thinking of the case where someone asks for a load of flags
and thinks that they're getting them but get no feedback that they won't.
But I understand having some complicated solution like I'm suggesting
might be even more surprising to users.

Maybe the cleanest solution is to ask users to supply a config that
can work on anywhere the event could possibly be scheduled. It doesn't
really make sense to have retstack on a per-process event on big-little
and then getting half of one type of data and half of another. It would
make more sense to fail to open in that case and they have the choice of
either doing per-CPU events or disabling retstacks altogether.

This seems like a similar problem to the issue causing the Coresight self
test failure where a certain sink was picked that couldn't be reached and
the test failed.

In that case the change we made doesn't quite match up to my suggestion here:

 * Per-cpu but an unreachable sink -> fail
 * Per-process and potentially reachable sink in the future -> pass

Maybe it would have been better to say that the sink always has to be
reachable otherwise is the outcome predicatable?

James

> Suzuki
> 
> 
>>
>> The consequence of not doing this is that the user may not be
>> aware that they are not enabling the feature as it is silently disabled.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 04669ecc0efa..a93c1a5fe045 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>       }
>>         /* return stack - enable if selected and supported */
>> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>> -        /* bit[12], Return stack enable bit */
>> -        config->cfg |= BIT(12);
>> -
>> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
>> +        if (!drvdata->retstack) {
>> +            ret = -EINVAL;
>> +            goto out;
>> +        } else {
>> +            /* bit[12], Return stack enable bit */
>> +            config->cfg |= BIT(12);
>> +        }
>> +    }
>>       /*
>>        * Set any selected configuration and preset.
>>        *
> 
