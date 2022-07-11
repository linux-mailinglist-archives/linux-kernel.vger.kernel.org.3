Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2137056FD3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiGKJxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiGKJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:52:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E303AB0E;
        Mon, 11 Jul 2022 02:25:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F3315BF;
        Mon, 11 Jul 2022 02:25:15 -0700 (PDT)
Received: from [10.163.45.183] (unknown [10.163.45.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53DC93F73D;
        Mon, 11 Jul 2022 02:25:12 -0700 (PDT)
Message-ID: <d03e334a-ec7e-cd87-7f0b-ac7564266d3a@arm.com>
Date:   Mon, 11 Jul 2022 14:55:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] perf/core: Add macros for possible
 sysctl_perf_event_paranoid values
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
References: <20220701063949.1769434-1-anshuman.khandual@arm.com>
 <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com>
 <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/22 19:01, Peter Zijlstra wrote:
> On Fri, Jul 08, 2022 at 10:10:15AM +0100, James Clark wrote:
>>
>>
>> On 01/07/2022 07:39, Anshuman Khandual wrote:
>>> sysctl_perf_event_paranoid can have values from [-1, 0, 1, 2] which decides
>>> on perf event restrictions for unprivileged users. But using them directly
>>> makes it difficult to correlate exact restriction level they might impose.
>>> This just adds macros for those numerical restriction values, making them
>>> clear and improving readability.
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-perf-users@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  include/linux/perf_event.h | 22 ++++++++++++++++++----
>>>  kernel/events/core.c       |  9 +--------
>>>  kernel/kallsyms.c          |  3 ++-
>>>  3 files changed, 21 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index da759560eec5..78156b9154df 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -1359,14 +1359,28 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
>>>  #define PERF_SECURITY_KERNEL		2
>>>  #define PERF_SECURITY_TRACEPOINT	3
>>>  
>>> +/*
>>> + * perf event paranoia level:
>>> + *  -1 - not paranoid at all
>>> + *   0 - disallow raw tracepoint access for unpriv
>>> + *   1 - disallow cpu events for unpriv
>>> + *   2 - disallow kernel profiling for unpriv
>>> + */
>>> +enum {
>>> +	PERF_EVENT_DISALLOW_NONE	= -1,
>>> +	PERF_EVENT_DISALLOW_TRACE,
>>> +	PERF_EVENT_DISALLOW_CPU,
>>> +	PERF_EVENT_DISALLOW_KERNEL
>>> +};
>>> +
>>>  static inline int perf_is_paranoid(void)
>>>  {
>>> -	return sysctl_perf_event_paranoid > -1;
>>> +	return sysctl_perf_event_paranoid > PERF_EVENT_DISALLOW_NONE;
>>>  }
>>>  
>>
>> Hi Anshuman,
>>
>> There are quite a few other instances of integers left in the tools code.
>> If you search for perf_event_paranoid_check() and perf_event_paranoid()
>> you will find them.
>>
>> I'm also wondering if it makes sense to return your new enum from all of
>> the helper functions instead of an int and make it explicit that it's
>> an instance of this new type? Although the compiler doesn't seem to warn
>> about using integers so maybe it's not worth doing this.
> 
> so I don't see the point of all this; it's already wrapped in these
> helper functions that have a descriptive name, why do we need more muck
> on top?

Enumerating [-1, 0, 1, 2] paranoid range values in kernel too, does not add
much value as well ?
