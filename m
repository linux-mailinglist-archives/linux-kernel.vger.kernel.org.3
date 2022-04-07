Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3D4F893D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiDGVyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiDGVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4150C1697B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649368355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUVt4HvRAcRrp8jAWSNaIy2SDdBijJ3Vk+5LrS/EnzE=;
        b=Y5ytvYMEO1DSzam841sAVWZGm19xWHxlouQOB629oDI7pi29J88fxMJhcYTwJM2Jnb4O9P
        hJODEVBwxhUSOjyXpGskIGlTVoBQJY/nXe0V6cgUwlN1RX4goXChVGsaE9Omlv54HwUlXH
        9sydEWtr6NN/QW+xs3RvtEkNW+7+1es=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-U4P9xZtvNgS-vqgUGAawBA-1; Thu, 07 Apr 2022 17:52:34 -0400
X-MC-Unique: U4P9xZtvNgS-vqgUGAawBA-1
Received: by mail-qk1-f198.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso2422171qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 14:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pUVt4HvRAcRrp8jAWSNaIy2SDdBijJ3Vk+5LrS/EnzE=;
        b=d+wNg54nArOBf2zIpC/usxUW0ma9VbUuKwMMoVjhh/R41e/ECTK5ZBjAncymZ/ZBZw
         /BY9e+kTkdK5+2m6mm9FVRpJFfGlHnMq3NAmTWXCcr1p9CgxG5P3wslw0UARdGIXHyjb
         y4C4cNOpuiHkVTcWwU6scCZgsmf2l8cFKHsBXFHjhJbfjdPh71ejlkYsB0RqtG/nlQkR
         OqkVrXQJ5589DB1PrLu1mA3Peby/I9o4T/5FIhXNP9/qd1Y69WRH0/ugjqAT8jt5HUio
         7pbS9bpj1O7cQ3tsNFRNu/QOrpKamgyr9QDWovHR8jKRklgmQSmwVbpe20Bv9RqFZZJa
         /bLw==
X-Gm-Message-State: AOAM532pzct1n6avG7iLlTxGzJu87iLhFg38IS0EtrsB1SylrG4OhB+L
        zO9cGaX7J6wr9owpyFvr1AGlHcHl1o0dHDNIeyFX5h7tsKwONNwRy2P9ZzccPshV4U84kYQRia4
        qd8Suko6nWYBxjDc48qoPImt5
X-Received: by 2002:ac8:4993:0:b0:2eb:ba1e:a52e with SMTP id f19-20020ac84993000000b002ebba1ea52emr13169643qtq.148.1649368353819;
        Thu, 07 Apr 2022 14:52:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYJ6VITxc+pwdFKhvN3EJj/ApoYqfkFBTzIY3CbIcegb7xuzsWSnUtj7kwZJb+zSaLHXp41g==
X-Received: by 2002:ac8:4993:0:b0:2eb:ba1e:a52e with SMTP id f19-20020ac84993000000b002ebba1ea52emr13169615qtq.148.1649368353508;
        Thu, 07 Apr 2022 14:52:33 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id x18-20020a05622a001200b002eb856d7786sm16937599qtw.84.2022.04.07.14.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:52:33 -0700 (PDT)
Message-ID: <eaa082c8-a583-4606-4ec4-1d43c4d48b97@redhat.com>
Date:   Thu, 7 Apr 2022 17:52:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>
References: <20220407184254.3612387-1-npache@redhat.com>
 <20220407131809.f2d256541e2c039c434c0d72@linux-foundation.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220407131809.f2d256541e2c039c434c0d72@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On 4/7/22 16:18, Andrew Morton wrote:
> On Thu,  7 Apr 2022 14:42:54 -0400 Nico Pache <npache@redhat.com> wrote:
> 
>> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
>> be targeted by the oom reaper. This mapping is used to store the futex
>> robust list head; the kernel does not keep a copy of the robust list and
>> instead references a userspace address to maintain the robustness during
>> a process death. A race can occur between exit_mm and the oom reaper that
>> allows the oom reaper to free the memory of the futex robust list before
>> the exit path has handled the futex death:
>>
>>     CPU1                               CPU2
>> ------------------------------------------------------------------------
>>     page_fault
>>     do_exit "signal"
>>     wake_oom_reaper
>>                                         oom_reaper
>>                                         oom_reap_task_mm (invalidates mm)
>>     exit_mm
>>     exit_mm_release
>>     futex_exit_release
>>     futex_cleanup
>>     exit_robust_list
>>     get_user (EFAULT- can't access memory)
>>
>> If the get_user EFAULT's, the kernel will be unable to recover the
>> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
>>
>> Use the robust_list address stored in the kernel to skip the VMA that holds
>> it, allowing a successful futex_cleanup.
>>
>> Theoretically a failure can still occur if there are locks mapped as
>> PRIVATE|ANON; however, the robust futexes are a best-effort approach.
>> This patch only strengthens that best-effort.
>>
>> The following case can still fail:
>> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)
>>
>> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
> 
> Should this fix be backported into -stable kernels?

Yes I believe so. This is caused by the commit marked under 'Fixes:' which is in
stable branch.
> 
>> --- a/include/linux/oom.h
>> +++ b/include/linux/oom.h
>> @@ -106,7 +106,8 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>>  	return 0;
>>  }
>>  
>> -bool __oom_reap_task_mm(struct mm_struct *mm);
>> +bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
>> +		__user *robust_list);
> 
> Should explicitly include futex.h
Good point. On second thought I think we also need to surround some of the
changes with a ifdef CONFIG_FUTEX. current->robust_list is undefined if we turn
that config option off.
> 
>>  long oom_badness(struct task_struct *p,
>>  		unsigned long totalpages);
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 3aa839f81e63..c14fe6f8e9a5 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3126,7 +3126,8 @@ void exit_mmap(struct mm_struct *mm)
>>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>>  		 * __oom_reap_task_mm() will not block.
>>  		 */
>> -		(void)__oom_reap_task_mm(mm);
>> +		(void)__oom_reap_task_mm(mm, current->robust_list);
>> +
>>  		set_bit(MMF_OOM_SKIP, &mm->flags);
>>  	}
>>  
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 7ec38194f8e1..727cfc3bd284 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -509,9 +509,11 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>>  static struct task_struct *oom_reaper_list;
>>  static DEFINE_SPINLOCK(oom_reaper_lock);
>>  
>> -bool __oom_reap_task_mm(struct mm_struct *mm)
>> +bool __oom_reap_task_mm(struct mm_struct *mm, struct robust_list_head
>> +		__user *robust_list)
>>  {
> 
> It's pretty sad to make such a low-level function aware of futex
> internals.  How about making it a more general `void *skip_area'?
Yes we can make this change. My concern is that the caller may now have to cast
the type: __oom_reap_task_mm(mm_struct, (void*) current->robust_list). But I
doubt that is a big concern.

> 
>>  	struct vm_area_struct *vma;
>> +	unsigned long head = (unsigned long) robust_list;
>>  	bool ret = true;
>>  
>>  	/*
>> @@ -526,6 +528,11 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>>  			continue;
>>  
>> +		if (vma->vm_start <= head && vma->vm_end > head) {
> 
> This check as you have it is making assumptions about the length of the
> area at *robust_list and about that area's relation to the area
> represented by the vma.
> 
> So if this is to be made more generic, we'd also need skip_area_len so
> we can perform a full overlap check.
Im not sure I follow here. Can a single MMAP call span multiple VMAs? The
address would be part of the pthread_t struct which is mmapped by the userspace
code. We are simply looking for that VMA and skipping the oom of it. It does not
try to find the individual locks (allocated separately and represented on a
LinkedList), it just prevents the reaping of the robust_list_head (part of
pthread_t) which stores the start of this LL. If some of the locks are private
(shared locks are not reaped) we may run into a case where this still fails;
however, we haven't been able to reproduce this.

Thanks for the review :) I will make the required changes for this to be more
config independent.

Cheers,
-- Nico
> 
> I dunno, maybe not worth it at this time, what do others think.
> 
> But the special-casing in here is pretty painful.
> 
>> +			pr_info("oom_reaper: skipping vma, contains robust_list");
>> +			continue;
>> +		}
>> +
>>  		/*
>>  		 * Only anonymous pages have a good chance to be dropped
>>  		 * without additional steps which we cannot afford as we
>> @@ -587,7 +594,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>>  	trace_start_task_reaping(tsk->pid);
>>  
>>  	/* failed to reap part of the address space. Try again later */
>> -	ret = __oom_reap_task_mm(mm);
>> +	ret = __oom_reap_task_mm(mm, tsk->robust_list);
>>  	if (!ret)
>>  		goto out_finish;
>>  
>> @@ -1190,7 +1197,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>>  	 * possible change in exit_mmap is seen
>>  	 */
>> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
>> +	if (!test_bit(MMF_OOM_SKIP, &mm->flags) &&
>> +			!__oom_reap_task_mm(mm, p->robust_list))
>>  		ret = -EAGAIN;
>>  	mmap_read_unlock(mm);
>>  
>> -- 
>> 2.35.1
> 

