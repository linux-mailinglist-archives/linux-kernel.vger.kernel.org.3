Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F404C472F10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhLMOXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:23:55 -0500
Received: from foss.arm.com ([217.140.110.172]:56514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238184AbhLMOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:23:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DFA1FB;
        Mon, 13 Dec 2021 06:23:51 -0800 (PST)
Received: from [10.57.34.21] (unknown [10.57.34.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00BE83F73B;
        Mon, 13 Dec 2021 06:23:49 -0800 (PST)
Subject: Re: [PATCH 2/3] coresight: Fail to open with return stacks if they
 are unavailable
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20211208160907.749482-1-james.clark@arm.com>
 <20211208160907.749482-2-james.clark@arm.com>
 <b52ef2f3-9e30-59a6-2aea-e46c93915868@arm.com>
 <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
 <20211210172220.GA1238770@p14s>
From:   James Clark <james.clark@arm.com>
Message-ID: <36c3469c-4fc4-e156-048a-47f9d001f47f@arm.com>
Date:   Mon, 13 Dec 2021 14:23:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211210172220.GA1238770@p14s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2021 17:22, Mathieu Poirier wrote:
> Hi James,
> 
> On Thu, Dec 09, 2021 at 11:13:55AM +0000, James Clark wrote:
>>
>>
>> On 09/12/2021 11:00, Suzuki K Poulose wrote:
>>> On 08/12/2021 16:09, James Clark wrote:
>>>> Maintain consistency with the other options by failing to open when they
>>>> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
>>>> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
>>>> requested but not supported by hardware.
>>>>
>>>> The consequence of not doing this is that the user may not be
>>>> aware that they are not enabling the feature as it is silently disabled.
>>>>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>> ï¿½ drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
>>>> ï¿½ 1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> index d2bafb50c66a..0a9bb943a5e5 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ }
>>>> ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ /* return stack - enable if selected and supported */
>>>> -ï¿½ï¿½ï¿½ if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ /* bit[12], Return stack enable bit */
>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ config->cfg |= BIT(12);
>>>> -
>>>> +ï¿½ï¿½ï¿½ if (attr->config & BIT(ETM_OPT_RETSTK)) {
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ if (!drvdata->retstack) {
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ret = -EINVAL;
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ goto out;
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ } else {
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ /* bit[12], Return stack enable bit */
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ config->cfg |= BIT(12);
>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ }
>>>
>>> nit: While at this, please could you change the hard coded value
>>> to ETM4_CFG_BIT_RETSTK ?
>>>
>> I started changing them all because I had trouble searching for bits by name but then
>> I thought it would snowball into a bigger change so I undid it.
>>
>> I think I'll just go and do it now if it's an issue here.
> 
> I can apply this set right away and you send another patch to fix all hard coded
> bitfields or you can send another revision with all 4 patches included in it
> (bitfields fix plus these 3).  Just let me know what you want to do.  And next
> time please add a cover letter.

I think I would like to hold off for a bit based on Mike's feedback. Seems like I may
need to make a change about return stacks.

Thanks
James

> 
> Thanks,
> Mathieu
> 
>>
>>> Otherwise, looks good to me
>>>
>>> Suzuki
