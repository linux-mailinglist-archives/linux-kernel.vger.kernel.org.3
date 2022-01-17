Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF59490C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbiAQQGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237342AbiAQQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642435574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwUi9SqLr0RaAGkkwKhLnami8HpHshIjYTtqA7y9lxU=;
        b=CGk0H5oSTGAFtXP6WW0NXc6VOxVE9sJ4D54gJbp7pgEhZ1oPefaVJz2/1pCgBqmXaslzJP
        kgEa/pSiZGxEsAwjX2TrcFgNhvkyM2Pou1rU6avauyqoSwptaHxV+xiKDtry52Xi5T6aTI
        ++8gKICCAHeM90XXSivkjlpvyu8JUn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-3NNPEGEvMtC6ubJeiKa7gw-1; Mon, 17 Jan 2022 11:05:56 -0500
X-MC-Unique: 3NNPEGEvMtC6ubJeiKa7gw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0486F64140;
        Mon, 17 Jan 2022 16:05:53 +0000 (UTC)
Received: from [10.22.35.55] (unknown [10.22.35.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA23C2B5BF;
        Mon, 17 Jan 2022 16:05:51 +0000 (UTC)
Message-ID: <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
Date:   Mon, 17 Jan 2022 11:05:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved robust
 futex
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, jsavitz@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@collabora.com
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 03:52, Michal Hocko wrote:
> On Fri 14-01-22 13:01:35, Nico Pache wrote:
>> In the case that two or more processes share a futex located within
>> a shared mmaped region, such as a process that shares a lock between
>> itself and child processes, we have observed that when a process holding
>> the lock is oom killed, at least one waiter is never alerted to this new
>> development and simply continues to wait.
>>
>> This is visible via pthreads by checking the __owner field of the
>> pthread_mutex_t structure within a waiting process, perhaps with gdb.
>>
>> We identify reproduction of this issue by checking a waiting process of
>> a test program and viewing the contents of the pthread_mutex_t, taking note
>> of the value in the owner field, and then checking dmesg to see if the
>> owner has already been killed.
> I believe we really need to find out why the original holder of the
> futex is not woken up to release the lock when exiting.

For a robust futex lock holder or waiter that is to be killed, it is not 
the responsibility of the task itself to wake up and release the lock. 
It is the kernel that recognizes that the task is holding or waiting for 
the robust futex and clean thing up.


>> As mentioned by Michal in his patchset introducing the oom reaper,
>> commit aac4536355496 ("mm, oom: introduce oom reaper"), the purpose of the
>> oom reaper is to try and free memory more quickly; however, In the case
>> that a robust futex is being used, we want to avoid utilizing the
>> concurrent oom reaper. This is due to a race that can occur between the
>> SIGKILL handling the robust futex, and the oom reaper freeing the memory
>> needed to maintain the robust list.
> OOM reaper is only unmapping private memory. It doesn't touch a shared
> mappings. So how could it interfere?
>
The futex itself may be in shared memory, however the robust list entry 
can be in private memory. So when the robust list is being scanned in 
this case, we can be in a use-after-free situation.
>> In the case that the oom victim is utilizing a robust futex, and the
>> SIGKILL has not yet handled the futex death, the tsk->robust_list should
>> be non-NULL. This issue can be tricky to reproduce, but with the
>> modifications of this patch, we have found it to be impossible to
>> reproduce.
> We really need a deeper analysis of the udnerlying problem because right
> now I do not really see why the oom reaper should interfere with shared
> futex.
As I said above, the robust list processing can involve private memory.
>
>> Add a check for tsk->robust_list is non-NULL in wake_oom_reaper() to return
>> early and prevent waking the oom reaper.
>>
>> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
>>
>> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/oom_kill.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 1ddabefcfb5a..3cdaac9c7de5 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -667,6 +667,21 @@ static void wake_oom_reaper(struct task_struct *tsk)
>>   	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
>>   		return;
>>   
>> +#ifdef CONFIG_FUTEX
>> +	/*
>> +	 * If the ooming task's SIGKILL has not finished handling the
>> +	 * robust futex it is not correct to reap the mm concurrently.
>> +	 * Do not wake the oom reaper when the task still contains a
>> +	 * robust list.
>> +	 */
>> +	if (tsk->robust_list)
>> +		return;
>> +#ifdef CONFIG_COMPAT
>> +	if (tsk->compat_robust_list)
>> +		return;
>> +#endif
>> +#endif
> If this turns out to be really needed, which I do not really see at the
> moment, then this is not the right way to handle this situation. The oom
> victim could get stuck and the oom killer wouldn't be able to move
> forward. If anything the victim would need to get MMF_OOM_SKIP set.

There can be other way to do that, but letting the normal kill signal 
processing finishing its job and properly invoke futex_cleanup() is 
certainly one possible solution.

Cheers,
Longman

