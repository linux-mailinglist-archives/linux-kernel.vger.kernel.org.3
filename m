Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFA55553A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376986AbiFVUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376916AbiFVUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9090532069
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655928465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2Cyh8ITNZ+gZ6xEYsgwg61dMFDvIXxq2c4v5+G6gs0=;
        b=M62JFLSG+o2uniOykJ6+vX0dGlVvHs4GtWa3GwZWRTLqWS5TDZoRxY87UIuhdUfF7yVowJ
        U0Cu42ZpvVqFm+JUsuMahphkyKCuaQwu0D2YuIkss/OVwkNzCTJcZO4gjtXKUwX2o+kJLZ
        6X3mozN/UrMp49oAnVrukB1KC1/gR2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-rXvd6mGtNwCedqorPZnMhA-1; Wed, 22 Jun 2022 16:07:43 -0400
X-MC-Unique: rXvd6mGtNwCedqorPZnMhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 904C3101AA47;
        Wed, 22 Jun 2022 20:07:43 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19E8C40D2969;
        Wed, 22 Jun 2022 20:07:43 +0000 (UTC)
Message-ID: <627771df-19a5-a0a0-e27d-81be87d6d1f2@redhat.com>
Date:   Wed, 22 Jun 2022 16:07:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     john.p.donnelly@oracle.com, Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220428012342.3713-1-hdanton@sina.com>
 <368f1ad6-83b9-01cd-1fba-3e87a0f73725@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <368f1ad6-83b9-01cd-1fba-3e87a0f73725@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 13:48, john.p.donnelly@oracle.com wrote:
> On 4/27/22 8:23 PM, Hillf Danton wrote:
>> On  Wed, 27 Apr 2022 13:31:24 -0400 Waiman Long wrote:
>>> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling 
>>> more
>>> consistent"), the writer that sets the handoff bit can be interrupted
>>> out without clearing the bit if the wait queue isn't empty. This 
>>> disables
>>> reader and writer optimistic lock spinning and stealing.
>>>
>>> Now if a non-first writer in the queue is somehow woken up or first
>>> entering the waiting loop, it can't acquire the lock.  This is not
>>> the case before that commit as the writer that set the handoff bit
>>> will clear it when exiting out via the out_nolock path. This is less
>>> efficient as the busy rwsem stays in an unlock state for a longer time.
>>>
>>> This patch allows a non-first writer to ignore the handoff bit if it
>>> is not originally set or initiated by the first waiter.
>>>
>>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>>> consistent")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
>>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>>> index 9d1db4a54d34..65f0262f635e 100644
>>> --- a/kernel/locking/rwsem.c
>>> +++ b/kernel/locking/rwsem.c
>>> @@ -335,8 +335,6 @@ struct rwsem_waiter {
>>>       struct task_struct *task;
>>>       enum rwsem_waiter_type type;
>>>       unsigned long timeout;
>>> -
>>> -    /* Writer only, not initialized in reader */
>>>       bool handoff_set;
>>>   };
>>>   #define rwsem_first_waiter(sem) \
>>> @@ -459,10 +457,12 @@ static void rwsem_mark_wake(struct 
>>> rw_semaphore *sem,
>>>                * to give up the lock), request a HANDOFF to
>>>                * force the issue.
>>>                */
>>> -            if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>>> -                time_after(jiffies, waiter->timeout)) {
>>> -                adjustment -= RWSEM_FLAG_HANDOFF;
>>> -                lockevent_inc(rwsem_rlock_handoff);
>>> +            if (time_after(jiffies, waiter->timeout)) {
>>> +                if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
>>> +                    adjustment -= RWSEM_FLAG_HANDOFF;
>>> +                    lockevent_inc(rwsem_rlock_handoff);
>>> +                }
>>> +                waiter->handoff_set = true;
>>>               }
>>
>> Handoff is tracked in both sem->count and waiter->handoff_set,
>>
>>> atomic_long_add(-adjustment, &sem->count);
>>> @@ -599,7 +599,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, 
>>> struct rwsem_waiter *waiter,
>>>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>>                       struct rwsem_waiter *waiter)
>>>   {
>>> -    bool first = rwsem_first_waiter(sem) == waiter;
>>> +    struct rwsem_waiter *first = rwsem_first_waiter(sem);
>>>       long count, new;
>>>         lockdep_assert_held(&sem->wait_lock);
>>> @@ -609,11 +609,20 @@ static inline bool rwsem_try_write_lock(struct 
>>> rw_semaphore *sem,
>>>           bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>>             if (has_handoff) {
>>> -            if (!first)
>>> +            /*
>>> +             * Honor handoff bit and yield only when the first
>>> +             * waiter is the one that set it. Otherwisee, we
>>> +             * still try to acquire the rwsem.
>>> +             */
>>> +            if (first->handoff_set && (waiter != first))
>>>                   return false;
>>
>> and checked against both parties, thus in a simpler manner 
>> RWSEM_FLAG_HANDOFF
>> in sem->count means the first waiter has been waiting for lock long 
>> enough.
>>
>> Feel free to ignore the comment given the Fixes tag above.
>>
>> Hillf
>>>   -            /* First waiter inherits a previously set handoff bit */
>>> -            waiter->handoff_set = true;
>>> +            /*
>>> +             * First waiter can inherit a previously set handoff
>>> +             * bit and spin on rwsem if lock acquisition fails.
>>> +             */
>>> +            if (waiter == first)
>>> +                waiter->handoff_set = true;
>>>           }
>>>             new = count;
>>> @@ -1027,6 +1036,7 @@ rwsem_down_read_slowpath(struct rw_semaphore 
>>> *sem, long count, unsigned int stat
>>>       waiter.task = current;
>>>       waiter.type = RWSEM_WAITING_FOR_READ;
>>>       waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>>> +    waiter.handoff_set = false;
>>>         raw_spin_lock_irq(&sem->wait_lock);
>>>       if (list_empty(&sem->wait_list)) {
>>> -- 
>>> 2.27.0
>
>
> Was this ever added ?
>
> I don't see it in
>
>
> a111daf0c53ae 2022-06-19 | Linux 5.19-rc3

This patch hasn't been taken up by upstream yet. I have reposted a v2 
with update to the patch description.

Cheers,
Longman

