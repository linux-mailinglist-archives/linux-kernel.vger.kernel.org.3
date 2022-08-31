Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FC5A87B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiHaUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FDEA317
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661978803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbwY55D9+tVzarKq94KZUxytwKNHu4drrSPlup4k9oM=;
        b=hA1iaygBn6C3cUd3G1e1WvDmmymRjR9EhvzUfUBBusBMKIP1lFHb2/GhkRGC7Hi2Q7CT5b
        UZvYjbMHP8yjKWyAONo5Os0OXzOFsTJEjBsR9Wz14GonYiO9XVrKsYVxzuk3t+zN3St5h4
        oozgaBD5j1RSAgSdPbZxxK85K9m4qWA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-mUvYXny0NN-Ujo9GkTDB-w-1; Wed, 31 Aug 2022 16:46:39 -0400
X-MC-Unique: mUvYXny0NN-Ujo9GkTDB-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 164441C05194;
        Wed, 31 Aug 2022 20:46:39 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C7EC909FF;
        Wed, 31 Aug 2022 20:46:38 +0000 (UTC)
Message-ID: <7fae45f2-e8a6-0ba7-be02-2eff8e75113e@redhat.com>
Date:   Wed, 31 Aug 2022 16:46:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 2/5] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-3-longman@redhat.com>
 <Yw8l9zhKxgUM0ulc@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yw8l9zhKxgUM0ulc@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/22 05:12, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 09:01:16PM -0400, Waiman Long wrote:
>
>
>>   void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
>>   {
>> -	struct cpumask *user_mask = p->user_cpus_ptr;
>> -	unsigned long flags;
>> -
>>   	/*
>> -	 * Try to restore the old affinity mask. If this fails, then
>> -	 * we free the mask explicitly to avoid it being inherited across
>> -	 * a subsequent fork().
>> +	 * Try to restore the old affinity mask with __sched_setaffinity().
>> +	 * Cpuset masking will be done there too.
>>   	 */
>> -	if (!user_mask || !__sched_setaffinity(p, user_mask))
>> -		return;
>> -
>> -	raw_spin_lock_irqsave(&p->pi_lock, flags);
>> -	user_mask = clear_user_cpus_ptr(p);
>> -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>> -
>> -	kfree(user_mask);
>> +	__sched_setaffinity(p, task_user_cpus(p), false);
>>   }
> We have an issue with __sched_setaffinity() failing here. I'm not sure
> ignoring the failure is the right thing -- but I'm also not enturely
> sure what is.
I am not sure what we can do in case __sched_setaffinity() fails. Maybe 
we can print a warning when this happen. What do you think?
>>   void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>> @@ -8081,10 +8046,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>>   #endif
>>   
>>   static int
>> -__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask)
>>   {
>>   	int retval;
>>   	cpumask_var_t cpus_allowed, new_mask;
>> +	struct cpumask *user_mask = NULL;
>>   
>>   	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
>>   		return -ENOMEM;
>> @@ -8100,8 +8066,22 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>>   	retval = dl_task_check_affinity(p, new_mask);
>>   	if (retval)
>>   		goto out_free_new_mask;
>> +
>> +	/*
>> +	 * Save the user requested mask internally now and then update
>> +	 * user_cpus_ptr later after making sure this call will be
>> +	 * successful, i.e. retval == 0.
>> +	 */
>> +	if (save_mask) {
>> +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
>> +		if (!user_mask) {
>> +			retval = -ENOMEM;
>> +			goto out_free_new_mask;
>> +		}
>> +		cpumask_copy(user_mask, mask);
>> +	}
>>   again:
>> -	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
>> +	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
>>   	if (retval)
>>   		goto out_free_new_mask;
>>   
>> @@ -8115,7 +8095,16 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>>   		goto again;
>>   	}
>>   
>> +	if (save_mask) {
>> +		unsigned long flags;
>> +
>> +		/* Use pi_lock to synchronize changes to user_cpus_ptr */
>> +		raw_spin_lock_irqsave(&p->pi_lock, flags);
>> +		swap(p->user_cpus_ptr, user_mask);
>> +		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>> +	}
>>   out_free_new_mask:
>> +	kfree(user_mask);
>>   	free_cpumask_var(new_mask);
>>   out_free_cpus_allowed:
>>   	free_cpumask_var(cpus_allowed);
> I'm confused as to why it's put in this function and not in the one
> caller that actually sets the new @save_mask true, here:

Looking at this patch alone, we can certainly put mask saving in 
sched_setaffinity(). In later patches, however, I have to make 
user_cpus_ptr update in the same lock critical section as cpus_mask. 
That is the reason why it is done this way here. I can certainly make 
your suggested change in this patch and then move the saving inside in a 
later patch.

Cheers,
Longman

