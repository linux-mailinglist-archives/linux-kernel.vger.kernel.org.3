Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198AF4F6A21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiDFTmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiDFTld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DCC01DD3EB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649265752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDdzkm37SCrMq3Wvcnyu6kJxNY6yi31itPv7aUVB3lw=;
        b=O6VSB/2zWbu9en1ZHxfiqGr/4JQ2Le2ZnMQPsjBgkkTyTo8kz9F0m3lcsDsR5mr0UVw8iF
        6MsAggzDpCTyNkVmrgUTfGU10tKU/HaIIwYDRbR5rAD513ELiuae2CPc0hqbAs8kc1zw7D
        apPiWiYKdGkBvlMjrZTXN0Pbs8lpIp8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-olhsE3ZVNrGR1RVaiKUVWg-1; Wed, 06 Apr 2022 13:22:30 -0400
X-MC-Unique: olhsE3ZVNrGR1RVaiKUVWg-1
Received: by mail-qt1-f198.google.com with SMTP id g22-20020ac870d6000000b002e20a1508ecso3523995qtp.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=nDdzkm37SCrMq3Wvcnyu6kJxNY6yi31itPv7aUVB3lw=;
        b=syMiBP6wb0K/N+Mv9NBVs6ND8FYxBhpSppHYEECeS/0lNoNu2O6HTJNffjdpUzqaYL
         dmT0cWNxeEcxJOmpGvxbjQbaeqUrbuTuDRaKVFjRRvTNa1XjOIwHH0P0AGJSnAQvN4e1
         WPcsriNfIRNsoWXX/Af45+dk0gMxTP4IRIN7veGPliMd5phiQ9WpYvVYGNZDwvPo07hd
         kiDZPmggPz4k+dLjLmk9BAUwXFkQzvBmLuwImVv1mnOJTUr6olE8ekLv1sxN4B2Brp7n
         eb8Q+FrO0XCjJkljiMJMEP4zBH3RChNCv5wxSm0hTfsHQ635ei/3S8VZ+dvV20QtJhUy
         sraQ==
X-Gm-Message-State: AOAM530HP7E0EqpR0jJ5/nc1T25/EN5RvJvvMJ5yGkuzWDoqH86jH386
        9qqISx/LbK+nb+RjFOMxrbWMkBRedGPZ6WbfbxynHt0nwj89ugeil6JKJVNZKX0jGNIUvZ/ME4u
        THrajd6U13xqYxWFx76Kgmrgx
X-Received: by 2002:a05:6214:2609:b0:443:d583:1fd1 with SMTP id gu9-20020a056214260900b00443d5831fd1mr8117894qvb.5.1649265750261;
        Wed, 06 Apr 2022 10:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1OOjYA4CyRzKPOJr8Z/77mW7FSbB6cuB32WQRxAB4ohJ6KA3PyMWXh/0ueWcEOiyuXN0VOg==
X-Received: by 2002:a05:6214:2609:b0:443:d583:1fd1 with SMTP id gu9-20020a056214260900b00443d5831fd1mr8117868qvb.5.1649265749983;
        Wed, 06 Apr 2022 10:22:29 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm13268513qtw.26.2022.04.06.10.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 10:22:29 -0700 (PDT)
Message-ID: <205cb301-53c1-fbb6-7dbe-2fb8b73b5701@redhat.com>
Date:   Wed, 6 Apr 2022 13:22:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
To:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz> <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld> <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
 <87bkxyaufi.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87bkxyaufi.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 09:17, Thomas Gleixner wrote:
> On Tue, Mar 22 2022 at 09:26, Michal Hocko wrote:
>> On Mon 21-03-22 19:57:24, Davidlohr Bueso wrote:
>>> On Mon, 21 Mar 2022, Nico Pache wrote:
>>>
>>>> We could proceed with the V3 approach; however if we are able to find a complete
>>>> solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
>>>> working, I dont see why we wouldnt go for it.
> 
> See below.
> 
>>> Because semantically killing the process is, imo, the wrong thing to do.
>>
>> I am not sure I follow. The task has been killed by the oom killer. All
>> we are discussing here is how to preserve the robust list metadata
>> stored in the memory which is normally unmapped by the oom_reaper to
>> guarantee a further progress. 
>>
>> I can see we have 4 potential solutions:
>> 1) do not oom_reap oom victims with robust futex metadata in anonymous
>>    memory. Easy enough but it could lead to excessive oom killing in
>>    case the victim gets stuck in the kernel and cannot terminate.
>> 2) clean up robust list from the oom_reaper context. Seems tricky due to
>>    #PF handling from the oom_reaper context which would need to be
>>    non-blocking
>> 3) filter vmas which contain robust list. Simple check for the vma
>>    range
>> 4) internally mark vmas which have to preserve the state during
>>    oom_reaping. Futex code would somehow have to mark those mappings.
>>    While more generic solution. I am not sure this is a practical
>>    approach. 
> 
> And all of that is based on wishful thinking, really. Let me explain.
> 
> The task::robust_list pointer is set unconditionally by NPTL for every
> thread of a process. It points to the 'list head' which is in the
> TLS. But this does not tell whether the task holds a robust futex or
> not. That's evaluated in the futex exit handling code.

Ah, thanks for pointing that out. So yes, skipping the OOM if it contains a
robust list is not really ideal as any process with pthreads will be skipped.

Would it be logical to change this so that we are no longer making this syscall
unconditionally? I still agree that skipping the OOM isnt very logical if we
have a better solution available. Is it set unconditionally so that users dont
have to do it dynamically when they enable the robustness?
If this is the case it may be too much of a headache to implement.

> 
> So solution #1 will prevent oom reaping completely simply because the
> pointer is set on every user space task.
Every userspace task that implements a pthread.
> 
> Solutions #2 and #3 are incomplete and just awful hacks which cure one
> particular case: A single threaded process. Why?
> 
> The chosen oom reaper victim is a process, so what does it help to check
> or cleanup the robust list for _ONE_ thread? Nothing because the other
> threads can hold robust futexes and then run into the same problem.
> 
> Aside of that you seem to believe that the robust list head in the TLS
> is the only part which is relevant. That's wrong. The list head is
> either NULL or points to the innermost pthread_mutex which is held by a
> task. Now look at this example:
> 
>   TLS:robust_list -> mutex2 -> mutex1
> 
> mutex1 is the shared one which needs to be released so that other
> processes can make progress. mutex2 is a process private one which
> resides in a different VMA. So now if you filter the robust list and
> refuse to reap the TLS VMA, what prevents the other VMA from being
> reaped? If that's reaped then mutex1 is not reachable.

This is a interesting case... So skipping the robust_head VMA would solve
the the case were all the locks are shared which is an improvement over the
current implementation.

We have been trying to modify our reproducer to creates the case described here,
but so far have been unsuccessful.
> 
> Now vs. cleaning up the robust list from the oom reaper context. That
> should be doable with a lot of care, but the proposed patch is not even
> close to a solution. It's simply broken.
> 
>> -static void futex_cleanup_begin(struct task_struct *tsk)
>> +static bool futex_cleanup_begin(struct task_struct *tsk, bool try)
>>  {
>>  	/*
>>  	 * Prevent various race issues against a concurrent incoming waiter
>> @@ -1055,7 +1056,12 @@ static void futex_cleanup_begin(struct task_struct *tsk)
>>  	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
>>  	 * attach_to_pi_owner().
>>  	 */
>> -	mutex_lock(&tsk->futex_exit_mutex);
>> +	if (try) {
>> +		if (!mutex_trylock(&tsk->futex_exit_mutex))
>> +			return false;
>> +	} else {
>> +		mutex_lock(&tsk->futex_exit_mutex);
>> +	}
> 
> That conditional locking is disgusting.
>   
>>  void futex_exit_release(struct task_struct *tsk)
>>  {
>> -	futex_cleanup_begin(tsk);
>> +	futex_cleanup_begin(tsk, false);
> 
> If the task already cleaned up the robust list then this will roll back
> tsk->futex_state from FUTEX_STATE_DEAD to FUTEX_STATE_EXITING. Sigh...
> 
>> +	futex_cleanup(tsk);
>> +	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
>> +}
>> +
>> +/* Try to perform the futex_cleanup and return true if successful.
> 
> This is not a proper multi line comment.
> 
>      /*
>       * Multi line comments look like this:
>       *
>       * Properly formatted.
>       *
>       * Don't try to use the network comment style
>       * on anything outside of networking.
>       */
> 
>> + * Designed to be called from the context of the OOM Reaper.
> 
> Let's talk about design later.
> 
>> + */
>> +bool try_futex_exit_release(struct task_struct *tsk)
>> +{
>> +	if (!futex_cleanup_begin(tsk, true))
>> +		return false;
>> +
>> +	/* We are calling this from the context of a kthread. We need to
>> +	 * instruct the kthread to use the address space of the given mm
>> +	 * so the get_user won't return -EFAULT.
> 
> How is this preventing get_user() or any other operation on the tasks
> user memory to return -EFAULT? Not at all. Any user access can fail and
Without the kthread_use_mm the kthread cannot instrument on the memory and the
get_users in futex_cleanup is guaranteed to fail... I left that comment to avoid
confusion.
> return -EFAULT. Comments are there to explain things not to create
> confusion.
> 
>> +	 */
>> +	kthread_use_mm(tsk->mm);
>>  	futex_cleanup(tsk);
> 
> But aside of that. How is this supposed to work correctly?
> 
> oom_reaper()
>   oom_reap_task()
>     oom_reap_task_mm()
>       mmap_read_trylock(mm) <- Succeeds
>         try_futex_exit_release()
>           use_mm()
>           futex_cleanup()
>             get_user() -> #PF
> 
> #PF
>   if (!mmap_read_trylock(mm)) {
> 
> So here the problem starts. The trylock can succeed or not, depending
> on the contention state of mm::mmap_lock.
> 
> So in case the trylock fails because there is a writer waiting, then it
> runs into this:
> 
>      if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
>         ....
>         return;
>      }
> 
> This condition evaluates to false because get_user() has an
> exception table entry. So this proceeds and does:
>      
>      mmap_read_lock(mm);
> 
> which is a full dead lock.
> 
> But even if the trylock succeeds then this runs into the full fault
> path, which is not correct either for pretty obvious reasons.
> 
> I assume that's all part of the design, right?

Yeah all of this makes the solution pretty useless in its current state. Thanks
for pointing that out in detail.

> But the real questions here are:
> 
>    Why are we doing this remote reaping at all?
> 
>    What is the condition that a task which is killed with a fatal signal
>    does not reach do_exit() and cleans up itself?
> 
> If the answer is "because", then we should rather make sure that this
> gets fixed.
> 
> If there is a legitimate reason why a task cannot handle a fatal signal,
> then yes the oom reaper might be necessary, but unleashing the oom
> reaper unconditionally is simply a bad idea and results in the problem
> which this is trying to paper over.
> 
> The oom reaper should be the last resort IMO and not racing against the
> killed task in the first place. IOW, give the task some time to clean
> itself up and if that fails and it is truly stuck and unable to do so,
> then reap the mm. But that should be the rare case and then the stuck
> futex should be the least of our worries.
> 
> Thanks,
> 
>         tglx

Thanks for the review!

Given our inability to reproduce the tls -> private mutex -> shared mutex case
we are going to continue forward with the VMA skipping, as that should at least
clear up the cases where all the locks are shared.

Cheers,
-- Nico

