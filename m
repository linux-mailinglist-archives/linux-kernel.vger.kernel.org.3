Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC84F6A05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiDFTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiDFTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CD14FE43B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649266600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFw9zXRPlV53nSz3+GW2bGld92pFk9vlEbTisDakULw=;
        b=fcEbXchEN7rINwnwEZj7A3GKPRwbvUx7dXJ1fMS7c34pPvlM1AJvZRSSlPdu76H2PzM6W0
        +tBba2NKv3mPE4Kicw69xnW87qeJyvgOOGPQGFbzjPmaG2Sejq14bPnuyQwC68SpoSKdqD
        I7L3QO9CpCyi7D7fn/PKbGiKV5iL+Js=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10--aWE_Z7cOFCjcv20F5bJmg-1; Wed, 06 Apr 2022 13:36:39 -0400
X-MC-Unique: -aWE_Z7cOFCjcv20F5bJmg-1
Received: by mail-qv1-f71.google.com with SMTP id kd20-20020a056214401400b00443c252b315so4316185qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ZFw9zXRPlV53nSz3+GW2bGld92pFk9vlEbTisDakULw=;
        b=Cq8r2En4vtDQdPIEUKgMOIQO0Rd+jNrKcnTK8vhVRIQOYV/v+9jtXsJkClSuUO9B7S
         3IHN/qJQ4PztUWiOMvdqHla7wnDz7/WiyclIqWFbWrSkzc3Q/FKzhJgCxMywlrsFmp5l
         sgvK2AIJ7QPGcAN+XkBNt0A/06T7Esu6Y/2A0q4//NQ53xJivH/N02dtKrW/gSDm5HRX
         kmWoJXnqw6KJXTOEcn8RLqvavwE7WweI5ce8bxjEvZ6U+Sxa0l9Bsk+6anaOunJYlWoX
         5hh8k/v4u+s3GSlBV24wpo8WWMAIEl8OGAyZOnlx7NXGVHgREQPSPdIYKc46lpVgPwzt
         gcdw==
X-Gm-Message-State: AOAM533izqT5EsMQ8FksLtknv0UGMKoXvqTpn4dCKE3kLB7fLq5IjkJD
        Abvb8fLfIP6xGN97DVmG30IuuyzCXK9up8A2cShK5EK8UqVuRgbEFIRbYIa7gwYpeBNQllhidUN
        gsI0C3YGL6nWNt6pvd9J3GJdS
X-Received: by 2002:a05:620a:2233:b0:680:a8f5:2b4d with SMTP id n19-20020a05620a223300b00680a8f52b4dmr6381462qkh.251.1649266598824;
        Wed, 06 Apr 2022 10:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDzcu7nC99lcb2e1m3HiK4bxYvsM5cEdMBvte5lsCD4Zwf/mc4GLgSYE+aBXLrr5RMUCB5Bw==
X-Received: by 2002:a05:620a:2233:b0:680:a8f5:2b4d with SMTP id n19-20020a05620a223300b00680a8f52b4dmr6381441qkh.251.1649266598513;
        Wed, 06 Apr 2022 10:36:38 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a0b0300b00699c6a9b2d1sm5532444qkg.32.2022.04.06.10.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 10:36:37 -0700 (PDT)
Message-ID: <41eee6bd-d9b4-8b0f-500c-ed6839963b38@redhat.com>
Date:   Wed, 6 Apr 2022 13:36:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
Content-Language: en-US
From:   Nico Pache <npache@redhat.com>
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
 <87bkxyaufi.ffs@tglx> <205cb301-53c1-fbb6-7dbe-2fb8b73b5701@redhat.com>
In-Reply-To: <205cb301-53c1-fbb6-7dbe-2fb8b73b5701@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/22 11:22, Nico Pache wrote:
> 
> 
> On 3/22/22 09:17, Thomas Gleixner wrote:
>> On Tue, Mar 22 2022 at 09:26, Michal Hocko wrote:
>>> On Mon 21-03-22 19:57:24, Davidlohr Bueso wrote:
>>>> On Mon, 21 Mar 2022, Nico Pache wrote:
>>>>
>>>>> We could proceed with the V3 approach; however if we are able to find a complete
>>>>> solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
>>>>> working, I dont see why we wouldnt go for it.
>>
>> See below.
>>
>>>> Because semantically killing the process is, imo, the wrong thing to do.
>>>
>>> I am not sure I follow. The task has been killed by the oom killer. All
>>> we are discussing here is how to preserve the robust list metadata
>>> stored in the memory which is normally unmapped by the oom_reaper to
>>> guarantee a further progress. 
>>>
>>> I can see we have 4 potential solutions:
>>> 1) do not oom_reap oom victims with robust futex metadata in anonymous
>>>    memory. Easy enough but it could lead to excessive oom killing in
>>>    case the victim gets stuck in the kernel and cannot terminate.
>>> 2) clean up robust list from the oom_reaper context. Seems tricky due to
>>>    #PF handling from the oom_reaper context which would need to be
>>>    non-blocking
>>> 3) filter vmas which contain robust list. Simple check for the vma
>>>    range
>>> 4) internally mark vmas which have to preserve the state during
>>>    oom_reaping. Futex code would somehow have to mark those mappings.
>>>    While more generic solution. I am not sure this is a practical
>>>    approach. 
>>
>> And all of that is based on wishful thinking, really. Let me explain.
>>
>> The task::robust_list pointer is set unconditionally by NPTL for every
>> thread of a process. It points to the 'list head' which is in the
>> TLS. But this does not tell whether the task holds a robust futex or
>> not. That's evaluated in the futex exit handling code.
> 
> Ah, thanks for pointing that out. So yes, skipping the OOM if it contains a
> robust list is not really ideal as any process with pthreads will be skipped.
> 
> Would it be logical to change this so that we are no longer making this syscall
> unconditionally? I still agree that skipping the OOM isnt very logical if we
> have a better solution available. Is it set unconditionally so that users dont
> have to do it dynamically when they enable the robustness?
> If this is the case it may be too much of a headache to implement.
> 
>>
>> So solution #1 will prevent oom reaping completely simply because the
>> pointer is set on every user space task.
> Every userspace task that implements a pthread.
I stand corrected... Joel just showed me that it is indeed set on every
userspace task.

Not entirely sure why... but Im wrong here.   >>
>> Solutions #2 and #3 are incomplete and just awful hacks which cure one
>> particular case: A single threaded process. Why?
>>
>> The chosen oom reaper victim is a process, so what does it help to check
>> or cleanup the robust list for _ONE_ thread? Nothing because the other
>> threads can hold robust futexes and then run into the same problem.
>>
>> Aside of that you seem to believe that the robust list head in the TLS
>> is the only part which is relevant. That's wrong. The list head is
>> either NULL or points to the innermost pthread_mutex which is held by a
>> task. Now look at this example:
>>
>>   TLS:robust_list -> mutex2 -> mutex1
>>
>> mutex1 is the shared one which needs to be released so that other
>> processes can make progress. mutex2 is a process private one which
>> resides in a different VMA. So now if you filter the robust list and
>> refuse to reap the TLS VMA, what prevents the other VMA from being
>> reaped? If that's reaped then mutex1 is not reachable.
> 
> This is a interesting case... So skipping the robust_head VMA would solve
> the the case were all the locks are shared which is an improvement over the
> current implementation.
> 
> We have been trying to modify our reproducer to creates the case described here,
> but so far have been unsuccessful.
>>
>> Now vs. cleaning up the robust list from the oom reaper context. That
>> should be doable with a lot of care, but the proposed patch is not even
>> close to a solution. It's simply broken.
>>
>>> -static void futex_cleanup_begin(struct task_struct *tsk)
>>> +static bool futex_cleanup_begin(struct task_struct *tsk, bool try)
>>>  {
>>>  	/*
>>>  	 * Prevent various race issues against a concurrent incoming waiter
>>> @@ -1055,7 +1056,12 @@ static void futex_cleanup_begin(struct task_struct *tsk)
>>>  	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
>>>  	 * attach_to_pi_owner().
>>>  	 */
>>> -	mutex_lock(&tsk->futex_exit_mutex);
>>> +	if (try) {
>>> +		if (!mutex_trylock(&tsk->futex_exit_mutex))
>>> +			return false;
>>> +	} else {
>>> +		mutex_lock(&tsk->futex_exit_mutex);
>>> +	}
>>
>> That conditional locking is disgusting.
>>   
>>>  void futex_exit_release(struct task_struct *tsk)
>>>  {
>>> -	futex_cleanup_begin(tsk);
>>> +	futex_cleanup_begin(tsk, false);
>>
>> If the task already cleaned up the robust list then this will roll back
>> tsk->futex_state from FUTEX_STATE_DEAD to FUTEX_STATE_EXITING. Sigh...
>>
>>> +	futex_cleanup(tsk);
>>> +	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
>>> +}
>>> +
>>> +/* Try to perform the futex_cleanup and return true if successful.
>>
>> This is not a proper multi line comment.
>>
>>      /*
>>       * Multi line comments look like this:
>>       *
>>       * Properly formatted.
>>       *
>>       * Don't try to use the network comment style
>>       * on anything outside of networking.
>>       */
>>
>>> + * Designed to be called from the context of the OOM Reaper.
>>
>> Let's talk about design later.
>>
>>> + */
>>> +bool try_futex_exit_release(struct task_struct *tsk)
>>> +{
>>> +	if (!futex_cleanup_begin(tsk, true))
>>> +		return false;
>>> +
>>> +	/* We are calling this from the context of a kthread. We need to
>>> +	 * instruct the kthread to use the address space of the given mm
>>> +	 * so the get_user won't return -EFAULT.
>>
>> How is this preventing get_user() or any other operation on the tasks
>> user memory to return -EFAULT? Not at all. Any user access can fail and
> Without the kthread_use_mm the kthread cannot instrument on the memory and the
> get_users in futex_cleanup is guaranteed to fail... I left that comment to avoid
> confusion.
>> return -EFAULT. Comments are there to explain things not to create
>> confusion.
>>
>>> +	 */
>>> +	kthread_use_mm(tsk->mm);
>>>  	futex_cleanup(tsk);
>>
>> But aside of that. How is this supposed to work correctly?
>>
>> oom_reaper()
>>   oom_reap_task()
>>     oom_reap_task_mm()
>>       mmap_read_trylock(mm) <- Succeeds
>>         try_futex_exit_release()
>>           use_mm()
>>           futex_cleanup()
>>             get_user() -> #PF
>>
>> #PF
>>   if (!mmap_read_trylock(mm)) {
>>
>> So here the problem starts. The trylock can succeed or not, depending
>> on the contention state of mm::mmap_lock.
>>
>> So in case the trylock fails because there is a writer waiting, then it
>> runs into this:
>>
>>      if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
>>         ....
>>         return;
>>      }
>>
>> This condition evaluates to false because get_user() has an
>> exception table entry. So this proceeds and does:
>>      
>>      mmap_read_lock(mm);
>>
>> which is a full dead lock.
>>
>> But even if the trylock succeeds then this runs into the full fault
>> path, which is not correct either for pretty obvious reasons.
>>
>> I assume that's all part of the design, right?
> 
> Yeah all of this makes the solution pretty useless in its current state. Thanks
> for pointing that out in detail.
> 
>> But the real questions here are:
>>
>>    Why are we doing this remote reaping at all?
>>
>>    What is the condition that a task which is killed with a fatal signal
>>    does not reach do_exit() and cleans up itself?
>>
>> If the answer is "because", then we should rather make sure that this
>> gets fixed.
>>
>> If there is a legitimate reason why a task cannot handle a fatal signal,
>> then yes the oom reaper might be necessary, but unleashing the oom
>> reaper unconditionally is simply a bad idea and results in the problem
>> which this is trying to paper over.
>>
>> The oom reaper should be the last resort IMO and not racing against the
>> killed task in the first place. IOW, give the task some time to clean
>> itself up and if that fails and it is truly stuck and unable to do so,
>> then reap the mm. But that should be the rare case and then the stuck
>> futex should be the least of our worries.
>>
>> Thanks,
>>
>>         tglx
> 
> Thanks for the review!
> 
> Given our inability to reproduce the tls -> private mutex -> shared mutex case
> we are going to continue forward with the VMA skipping, as that should at least
> clear up the cases where all the locks are shared.
> 
> Cheers,
> -- Nico
> 

