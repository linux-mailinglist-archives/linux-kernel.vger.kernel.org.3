Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDC54FD15
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiFQS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFQS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDC131220
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655492281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZLCEN0uoWMCNQp5KmdqbFQh9xhKCUmm51egFMEs7tU=;
        b=PSjiUrRYSrucWbZeRP+9zoTJhFhD0KEC2yanls7jcBCgkl9fo1TEnnhEzr7r0GQ7lPa7ZT
        W6B6luxi5JXfjCRilIMJ1kfevV/iw1slNzfmpm5VWj+8Rqjos1MdHXHDUMfE/W8Cm6PvAA
        wdvgWWR2DhebIsXZFOUrEN03HnEH7Vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-PW7MfVojP6GY08X0vj0vfQ-1; Fri, 17 Jun 2022 14:57:56 -0400
X-MC-Unique: PW7MfVojP6GY08X0vj0vfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7166801E6B;
        Fri, 17 Jun 2022 18:57:55 +0000 (UTC)
Received: from [10.22.18.98] (unknown [10.22.18.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D69A40334E;
        Fri, 17 Jun 2022 18:57:55 +0000 (UTC)
Message-ID: <980387bb-f46d-e9ab-96b0-7293df08c447@redhat.com>
Date:   Fri, 17 Jun 2022 14:57:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
 <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
 <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com>
 <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 13:45, Eric Dumazet wrote:
> On Fri, Jun 17, 2022 at 7:42 PM Waiman Long <longman@redhat.com> wrote:
>> On 6/17/22 11:24, Eric Dumazet wrote:
>>> On Fri, Jun 17, 2022 at 5:00 PM Waiman Long <longman@redhat.com> wrote:
>>>> On 6/17/22 10:57, Shakeel Butt wrote:
>>>>> On Fri, Jun 17, 2022 at 7:43 AM Waiman Long <longman@redhat.com> wrote:
>>>>>> On 6/17/22 08:07, Peter Zijlstra wrote:
>>>>>>> On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
>>>>>>>> --- a/kernel/locking/qrwlock.c
>>>>>>>> +++ b/kernel/locking/qrwlock.c
>>>>>>>> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
>>>>>>>>         /*
>>>>>>>>          * Readers come here when they cannot get the lock without waiting
>>>>>>>>          */
>>>>>>>> -    if (unlikely(in_interrupt())) {
>>>>>>>> -            /*
>>>>>>>> -             * Readers in interrupt context will get the lock immediately
>>>>>>>> -             * if the writer is just waiting (not holding the lock yet),
>>>>>>>> -             * so spin with ACQUIRE semantics until the lock is available
>>>>>>>> -             * without waiting in the queue.
>>>>>>>> -             */
>>>>>>>> -            atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
>>>>>>>> -            return;
>>>>>>>> -    }
>>>>>>>>         atomic_sub(_QR_BIAS, &lock->cnts);
>>>>>>>>
>>>>>>>>         trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
>>>>>>> This is known to break tasklist_lock.
>>>>>>>
>>>>>> We certainly can't break the current usage of tasklist_lock.
>>>>>>
>>>>>> I am aware of this problem with networking code and is thinking about
>>>>>> either relaxing the check to exclude softirq or provide a
>>>>>> read_lock_unfair() variant for networking use.
>>>>> read_lock_unfair() for networking use or tasklist_lock use?
>>>> I mean to say read_lock_fair(), but it could also be the other way
>>>> around. Thanks for spotting that.
>>>>
>>> If only tasklist_lock is problematic and needs the unfair variant,
>>> then changing a few read_lock() for tasklist_lock will be less
>>> invasive than ~1000 read_lock() elsewhere....
>> After a second thought, I think the right way is to introduce a fair
>> variant, if needed. If an arch isn't using qrwlock, the native rwlock
>> implementation will be unfair. In that sense, unfair rwlock is the
>> default. We will only need to change the relevant network read_lock()
>> calls to use the fair variant which will still be unfair if qrwlock
>> isn't used. We are not going to touch other read_lock call that don't
>> care about fair or unfair.
>>
> Hmm... backporting this kind of invasive change to stable kernels will
> be a daunting task.
>
> Were rwlocks always unfair, and we have been lucky ?
>
Yes, rwlocks was always unfair and it always had this kind of soft 
lockup problem and scalability problem because of cacheline bouncing. 
That was reason of creating qrwlock which can at least provide a fair 
rwlock at task context. Now we have systems with more and more cpus and 
that is the reason why you are seeing it all over again with the 
networking code.

Cheers,
Longman

