Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5594F8C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiDHD0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiDHD0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E68518DAAE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649388248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwbMtpr/w594vzWsDxQkYyAj5QvpUxkx+48AUijQtdE=;
        b=QrYHabD6gXHKdyJhawwjvqK9OlXS/QJ1lyec97i9FxxnHzyF7n7EuiycdOIhU9fyj/LJi1
        b9sUcI60+D6DNjQcPUZ45+zAseovlMYiF0cg8G+NVYLbSWWWAvTK8edqKSqOYAQfoLgGkN
        F2EQahYUOzDtofb+aIpUbTAlZE5WsQs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-iOORKyIVOkCVb_Go5LeBqg-1; Thu, 07 Apr 2022 23:24:05 -0400
X-MC-Unique: iOORKyIVOkCVb_Go5LeBqg-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso8336304qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VwbMtpr/w594vzWsDxQkYyAj5QvpUxkx+48AUijQtdE=;
        b=1p8WiY4ua2shhw73cpt9HVStcVNIN+tx1pt97d47ttxPDnoRH+KBCLROLmsT4bh6sA
         d+1LUlTw/Dk9SuMIVLsNsgsGqfnR6wbhkkXHrCnu6JL7stNG9wvGVZL7YrwjLPE7VBmr
         9UCNNLZrDmjmiNREvkljp3xW1sfoQa0eCltfzWUEwEzP09SOhZ13vriLD/PL90WGOqT8
         tRMS/8iRAxvLx2OoySVAXDuDB/4CFjlrkl+eIdhYhcZNo0VWdu1o7IrBAEf2ScUfzBRP
         fjOo3KYQlzCtzvctTrdFMPGPQgXd9inG4q4N7FnvGEnYB4lqSYwxAyAFU0htGNgRQVWR
         z5fQ==
X-Gm-Message-State: AOAM530ZQJWFDdkN8Jub1U5XR3gx2N3qncTe25EupC3bPZVofTGwLIQs
        Cv//xRH3ORw0nICqW6sXrp4u5817gjWhDE6o2Y1B1eoZrDuUgqvA6xEcqIcXBQe4QYbYH4kCupf
        5x22WJ9us17MTmI7jtfWRK/IO
X-Received: by 2002:a05:6214:508e:b0:441:24df:4b with SMTP id kk14-20020a056214508e00b0044124df004bmr14503265qvb.34.1649388244749;
        Thu, 07 Apr 2022 20:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVAjMqFbyhfr+rJ24QD/v7Ras7QI1ICbZFTBoVen3rOLcMgbrRA2TID8i8n5O8xVUBtgs16w==
X-Received: by 2002:a05:6214:508e:b0:441:24df:4b with SMTP id kk14-20020a056214508e00b0044124df004bmr14503240qvb.34.1649388244423;
        Thu, 07 Apr 2022 20:24:04 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm17819102qta.49.2022.04.07.20.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 20:24:03 -0700 (PDT)
Message-ID: <925163cf-d44c-de39-7fb9-9ff7769d36a8@redhat.com>
Date:   Thu, 7 Apr 2022 23:24:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7] oom_kill.c: futex: Don't OOM reap the VMA containing
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
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408030137.3693195-1-npache@redhat.com>
 <20220407201250.b4ebaae0cb327cad7b2eb3cf@linux-foundation.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220407201250.b4ebaae0cb327cad7b2eb3cf@linux-foundation.org>
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



On 4/7/22 23:12, Andrew Morton wrote:
> On Thu,  7 Apr 2022 23:01:37 -0400 Nico Pache <npache@redhat.com> wrote:
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
>>
>> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370
>>
>> ...
>>
>> --- a/include/linux/oom.h
>> +++ b/include/linux/oom.h
>> @@ -106,7 +106,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
>>  	return 0;
>>  }
>>  
>> -bool __oom_reap_task_mm(struct mm_struct *mm);
>> +bool __oom_reap_task_mm(struct mm_struct *mm, void *robust_list);
>>  
>>  long oom_badness(struct task_struct *p,
>>  		unsigned long totalpages);
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 3aa839f81e63..d5af1b83cbb2 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3109,6 +3109,11 @@ void exit_mmap(struct mm_struct *mm)
>>  	struct mmu_gather tlb;
>>  	struct vm_area_struct *vma;
>>  	unsigned long nr_accounted = 0;
>> +	void *robust_list;
>> +
>> +#ifdef CONFIG_FUTEX
>> +	robust_list = current->robust_list;
>> +#endif
>>  
>>  	/* mm's last user has gone, and its about to be pulled down */
>>  	mmu_notifier_release(mm);
>> @@ -3126,7 +3131,8 @@ void exit_mmap(struct mm_struct *mm)
>>  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
>>  		 * __oom_reap_task_mm() will not block.
>>  		 */
>> -		(void)__oom_reap_task_mm(mm);
>> +		(void)__oom_reap_task_mm(mm, robust_list);
> 
> uninitialized var warning when CONFIG_FUTEX=n?
> 
>> +
>>  		set_bit(MMF_OOM_SKIP, &mm->flags);
>>  	}
>>  
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -509,9 +509,10 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>>  static struct task_struct *oom_reaper_list;
>>  static DEFINE_SPINLOCK(oom_reaper_lock);
>>  
>> -bool __oom_reap_task_mm(struct mm_struct *mm)
>> +bool __oom_reap_task_mm(struct mm_struct *mm, void *robust_list)
> 
> Well, this is no longer necessarily a robust_list*.  It's just an
> address to skip and the name should reflect that?
ok fair point. I left it as robust list to be more clean what is being skipped
and renamed the head variable to skip_vma so its more verbose. But I dont have
that strong of an opinion on it so I'll change it real quick.

> 
>>  {
>>  	struct vm_area_struct *vma;
>> +	unsigned long skip_vma = (unsigned long) robust_list;
>>  	bool ret = true;
>>  
>>  	/*
>> @@ -526,6 +527,20 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>>  			continue;
>>  
>> +#ifdef CONFIG_FUTEX
>> +		/*
>> +		 * The OOM reaper runs concurrently with do_exit.
>> +		 * The robust_list_head is stored in userspace and is required
>> +		 * by the exit path to recover the robust futex waiters.
>> +		 * Skip the VMA that contains the robust_list to allow for
>> +		 * proper cleanup.
>> +		 */
>> +		if (vma->vm_start <= skip_vma && vma->vm_end > skip_vma) {
>> +			pr_info("oom_reaper: skipping vma, contains robust_list");
>> +			continue;
>> +		}
>> +#endif
>> +
>>  		/*
>>  		 * Only anonymous pages have a good chance to be dropped
>>  		 * without additional steps which we cannot afford as we
>> @@ -567,6 +582,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>>  static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>>  {
>>  	bool ret = true;
>> +	void *robust_list;
>>  
>>  	if (!mmap_read_trylock(mm)) {
>>  		trace_skip_task_reaping(tsk->pid);
>> @@ -586,8 +602,11 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>>  
>>  	trace_start_task_reaping(tsk->pid);
>>  
>> +#ifdef CONFIG_FUTEX
>> +	robust_list = tsk->robust_list;
>> +#endif
>>  	/* failed to reap part of the address space. Try again later */
>> -	ret = __oom_reap_task_mm(mm);
>> +	ret = __oom_reap_task_mm(mm, robust_list);
> 
> unintialized var when CONFIG_FUTEX=n?
> 
>>  	if (!ret)
>>  		goto out_finish;
>>  
>> @@ -1149,6 +1168,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>>  	unsigned int f_flags;
>>  	bool reap = false;
>>  	long ret = 0;
>> +	void *robust_list;
>>  
>>  	if (flags)
>>  		return -EINVAL;
>> @@ -1186,11 +1206,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>>  		ret = -EINTR;
>>  		goto drop_mm;
>>  	}
>> +
>> +#ifdef CONFIG_FUTEX
>> +	robust_list = p->robust_list;
>> +#endif
>>  	/*
>>  	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>>  	 * possible change in exit_mmap is seen
>>  	 */
>> -	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
>> +	if (!test_bit(MMF_OOM_SKIP, &mm->flags) &&
>> +			!__oom_reap_task_mm(mm, robust_list))
> 
> again
Good catch. Ill fix those real quick.
> 
>>  		ret = -EAGAIN;
>>  	mmap_read_unlock(mm);
> 

