Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1B5660F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiGECIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGECH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:07:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111AF11814;
        Mon,  4 Jul 2022 19:07:56 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LcQwr14lLz1L8h7;
        Tue,  5 Jul 2022 10:05:00 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 10:07:23 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Jul 2022 10:07:23 +0800
Subject: Re: [PATCH v2] perf/core: Fix data race between perf_event_set_output
 and perf_mmap_close
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220704120006.98141-1-yangjihong1@huawei.com>
 <YsMGixSL4CDPTTZs@worktop.programming.kicks-ass.net>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <14a8d525-ae36-02c0-0e1c-c865359217eb@huawei.com>
Date:   Tue, 5 Jul 2022 10:07:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YsMGixSL4CDPTTZs@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/7/4 23:26, Peter Zijlstra wrote:
> On Mon, Jul 04, 2022 at 08:00:06PM +0800, Yang Jihong wrote:
>> Data race exists between perf_event_set_output and perf_mmap_close.
>> The scenario is as follows:
>>
>>                    CPU1                                                       CPU2
>>                                                                      perf_mmap_close(event2)
>>                                                                        if (atomic_dec_and_test(&event2->rb->mmap_count)  // mmap_count 1 -> 0
>>                                                                          detach_rest = true;
>> ioctl(event1, PERF_EVENT_IOC_SET_OUTPUT, event2)
>>    perf_event_set_output(event1, event2)
>>                                                                        if (!detach_rest)
>>                                                                          goto out_put;
>>                                                                        list_for_each_entry_rcu(event, &event2->rb->event_list, rb_entry)
>>                                                                          ring_buffer_attach(event, NULL)
>>                                                                        // because event1 has not been added to event2->rb->event_list,
>>                                                                        // event1->rb is not set to NULL in these loops
>>
>>      ring_buffer_attach(event1, event2->rb)
>>        list_add_rcu(&event1->rb_entry, &event2->rb->event_list)
>>
>> The above data race causes a problem, that is, event1->rb is not NULL, but event1->rb->mmap_count is 0.
>> If the perf_mmap interface is invoked for the fd of event1, the kernel keeps in the perf_mmap infinite loop:
>>
>> again:
>>          mutex_lock(&event->mmap_mutex);
>>          if (event->rb) {
>> <SNIP>
>>                  if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
>>                          /*
>>                           * Raced against perf_mmap_close() through
>>                           * perf_event_set_output(). Try again, hope for better
>>                           * luck.
>>                           */
>>                          mutex_unlock(&event->mmap_mutex);
>>                          goto again;
>>                  }
>> <SNIP>
> 
> Too tired, must look again tomorrow, little feeback below.
Thanks for reviewing this patch. The perf_mmap_close, 
perf_event_set_output, and perf_mmap involve complex data race and lock 
relationships. Therefore, this simple fix is proposed.
> 
>>   kernel/events/core.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 80782cddb1da..c67c070f7b39 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5900,6 +5900,7 @@ static void ring_buffer_attach(struct perf_event *event,
>>   			       struct perf_buffer *rb)
>>   {
>>   	struct perf_buffer *old_rb = NULL;
>> +	struct perf_buffer *new_rb = rb;
>>   	unsigned long flags;
>>   
>>   	WARN_ON_ONCE(event->parent);
>> @@ -5928,6 +5929,20 @@ static void ring_buffer_attach(struct perf_event *event,
>>   
>>   		spin_lock_irqsave(&rb->event_lock, flags);
>>   		list_add_rcu(&event->rb_entry, &rb->event_list);
>> +
>> +		/*
>> +		 * When perf_mmap_close traverses rb->event_list during
>> +		 * detach all other events, new event may not be added to
>> +		 * rb->event_list, let's check again, if rb->mmap_count is 0,
>> +		 * it indicates that perf_mmap_close is executed.
>> +		 * Manually delete event from rb->event_list and
>> +		 * set event->rb to null.
>> +		 */
>> +		if (!atomic_read(&rb->mmap_count)) {
>> +			list_del_rcu(&event->rb_entry);
>> +			new_rb = NULL;
>> +		}
>> +
>>   		spin_unlock_irqrestore(&rb->event_lock, flags);
>>   	}
>>   
>> @@ -5944,7 +5959,7 @@ static void ring_buffer_attach(struct perf_event *event,
>>   	if (has_aux(event))
>>   		perf_event_stop(event, 0);
>>   
>> -	rcu_assign_pointer(event->rb, rb);
>> +	rcu_assign_pointer(event->rb, new_rb);
>>   
>>   	if (old_rb) {
>>   		ring_buffer_put(old_rb);
> 
> I'm confused by the above hunks; the below will avoid calling
> ring_buffer_attach() when !rb->mmap_count, so how can the above ever
> execute?
In this patch, !atomic_read(&rb->mmap_count) is checked before the 
perf_event_set_output function invokes ring_buffer_attach(event, rb). 
Therefore, !atomic_read(&rb->mmap_count) does not need to be checked in 
the ring_buffer_attach function.

Am I right to understand that?

Because there is no lock parallel protection between ioctl(event1, 
PERF_EVENT_IOC_SET_OUTPUT, event2) and perf_mmap_close(event2), they can 
be executed in parallel.

The following scenarios may exist:

                    CPU1 
        CPU2
 
perf_mmap_close(event2)
																	   ...
ioctl(event1, PERF_EVENT_IOC_SET_OUTPUT, event2)
    perf_event_set_output(event1, event2)
      ...
      if (rb && !atomic_read(&rb->mmap_count))
	   goto unlock;
	 // Here rb->mmap_count = 1, Keep going.
	 ...
	                                                                  if 
(atomic_dec_and_test(&event2->rb->mmap_count)  // mmap_count 1 -> 0
 
  detach_rest = true;
                                                                       ...
 
list_for_each_entry_rcu(event, &event2->rb->event_list, rb_entry)
 
  ring_buffer_attach(event, NULL)
 
  // because event1 has not been added to event2->rb->event_list,
 
  // event1->rb is not set to NULL in these loops
																	  ...
	 ring_buffer_attach(event1, rb)
	   ...
	   list_add_rcu(&event1->rb_entry, &event2->rb->event_list)
	   ...

In this case, the above problems arise.
> 
>> @@ -11883,6 +11898,13 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
>>   			goto unlock;
>>   	}
>>   
>> +	/*
>> +	 * If rb->mmap_count is 0, perf_mmap_close is being executed,
>> +	 * the ring buffer is about to be unmapped and cannot be attached.
>> +	 */
>> +	if (rb && !atomic_read(&rb->mmap_count))
>> +		goto unlock;
>> +
>>   	ring_buffer_attach(event, rb);
>>   
>>   	ret = 0;
> 
> This is wrong I think, it'll leak ring_buffer_get().
Yes, ring_buffer_put(rb) needs to be added before goto unlock.
I'll fix in next version.

Thanks,
Yang
> 
> 
> .
> 
