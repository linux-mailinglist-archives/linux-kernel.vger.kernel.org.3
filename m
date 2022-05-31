Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1653941C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbiEaPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345758AbiEaPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:38:40 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCBC62A36
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:38:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VEvuo0x_1654011513;
Received: from 192.168.0.205(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VEvuo0x_1654011513)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 23:38:34 +0800
Message-ID: <d387ede1-d000-37aa-6ede-237b65b59ce5@linux.alibaba.com>
Date:   Tue, 31 May 2022 23:38:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
 <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
 <xhsmhilpl9azq.mognet@vschneid.remote.csb> <20220531135532.GA3332@suse.de>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20220531135532.GA3332@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 21:55, Mel Gorman wrote:
> On Tue, May 31, 2022 at 12:50:49PM +0100, Valentin Schneider wrote:
>>>> With all that in mind, I'm curious whether your patch is functionaly close
>>>> to the below.
>>>>
>>>> ---
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 66c4e5922fe1..ffd43264722a 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -3836,7 +3836,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>>>    	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>>>>    	 * nr_running is checked to avoid unnecessary task stacking.
>>>>    	 */
>>>> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
>>>> +	if (cpu_rq(cpu)->nr_running <= 1)
>>>>    		return true;
>>>>    
>>>>    	return false;
>>>
>>> It's a little different. This may bring extra IPIs when nr_running == 1
>>> and the current task on wakee cpu is not the target wakeup task (i.e.,
>>> rq->curr == another_task && rq->curr != p). Then this another_task may
>>> be disturbed by IPI which is not expected. So IMO the promise by
>>> WF_ON_CPU is necessary.
>>
>> You're right, actually taking a second look at that WF_ON_CPU path,
>> shouldn't the existing condition be:
>>
>> 	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
>>
>> ? Per the p->on_rq and p->on_cpu ordering, if we have WF_ON_CPU here then
>> we must have !p->on_rq, so the deactivate has happened, thus the task
>> being alone on the rq implies nr_running==0.
>>
>> @Mel, do you remember why you went for <=1 here? I couldn't find any clues
>> on the original posting.
>>
> 
> I don't recall exactly why I went with <= 1 there but I may not have
> considered the memory ordering of on_rq and nr_running and the comment
> above it is literally what I was thinking at the time. I think you're
> right and that check can be !cpu_rq(cpu)->nr_running.
> 

If the check becomes !cpu_rq(cpu)->nr_running
My patch would change, too.
Shall we remove WF_ON_CPU completely?

