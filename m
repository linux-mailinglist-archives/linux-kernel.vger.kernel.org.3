Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFB487989
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiAGPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:10:50 -0500
Received: from foss.arm.com ([217.140.110.172]:41660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232227AbiAGPKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:10:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA68E13D5;
        Fri,  7 Jan 2022 07:10:48 -0800 (PST)
Received: from [10.57.38.163] (unknown [10.57.38.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86033F66F;
        Fri,  7 Jan 2022 07:10:46 -0800 (PST)
Subject: Re: [PATCH 2/3] coresight: Fail to open with return stacks if they
 are unavailable
From:   James Clark <james.clark@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20211208160907.749482-1-james.clark@arm.com>
 <20211208160907.749482-2-james.clark@arm.com>
 <b52ef2f3-9e30-59a6-2aea-e46c93915868@arm.com>
 <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
Message-ID: <70b562dc-adcd-da34-3811-ff872bc7cab8@arm.com>
Date:   Fri, 7 Jan 2022 15:10:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2021 11:13, James Clark wrote:
> 
> 
> On 09/12/2021 11:00, Suzuki K Poulose wrote:
>> On 08/12/2021 16:09, James Clark wrote:
>>> Maintain consistency with the other options by failing to open when they
>>> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
>>> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
>>> requested but not supported by hardware.
>>>
>>> The consequence of not doing this is that the user may not be
>>> aware that they are not enabling the feature as it is silently disabled.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> index d2bafb50c66a..0a9bb943a5e5 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>       }
>>>         /* return stack - enable if selected and supported */
>>> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>>> -        /* bit[12], Return stack enable bit */
>>> -        config->cfg |= BIT(12);
>>> -
>>> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
>>> +        if (!drvdata->retstack) {
>>> +            ret = -EINVAL;
>>> +            goto out;
>>> +        } else {
>>> +            /* bit[12], Return stack enable bit */
>>> +            config->cfg |= BIT(12);
>>> +        }
>>
>> nit: While at this, please could you change the hard coded value
>> to ETM4_CFG_BIT_RETSTK ?
>>
> I started changing them all because I had trouble searching for bits by name but then
> I thought it would snowball into a bigger change so I undid it.
> 
> I think I'll just go and do it now if it's an issue here.

Hi Suzuki,

I started on this and I think the only worthwhile change is to make them all consistent
with sysreg.h. As in have xxx_SHIFT and xxx_MASK style definitions like:

  #define TRCCONFIGR_INSTP0_SHIFT		1
  #define TRCCONFIGR_INSTPO_MASK		GENMASK(1,0)

This has been done for SPE and some of the new ETM stuff. If that sounds right to you
I will go and do it as a followup patch to this one. It is quite a bit change so I can
see maybe we don't want to do it? (Personally I would vote to do it)

James

> 
>> Otherwise, looks good to me
>>
>> Suzuki
