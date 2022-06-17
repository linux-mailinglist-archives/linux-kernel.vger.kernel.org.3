Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9D54F9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382942AbiFQPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381652AbiFQPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C17B3B552
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655478039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONdx8UrD/iFgfBJOk2FUQJlKyfF0Fn1r/7hliPk7HK0=;
        b=KSGaJBw2XkfBG6L63aEoILl3XFFjEJfE3LQ1Oyi+Fir+QpPrHFJz9jHNf66WO89Pwe3HvU
        SZgbpVOWkqTjINd+PsUqY7aQ0sVib5qEB49LmIjnT6e9yUkQYlaosQiC9/tCr+JMRZGrGW
        TjqwmGmse+GYIS0DZGi2w8EjOf2RROk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-hVOxLB2yNgenoGphNrK42w-1; Fri, 17 Jun 2022 11:00:28 -0400
X-MC-Unique: hVOxLB2yNgenoGphNrK42w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B8D93810D20;
        Fri, 17 Jun 2022 15:00:28 +0000 (UTC)
Received: from [10.22.18.98] (unknown [10.22.18.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D18FD40CFD0A;
        Fri, 17 Jun 2022 15:00:27 +0000 (UTC)
Message-ID: <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
Date:   Fri, 17 Jun 2022 11:00:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
 <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 10:57, Shakeel Butt wrote:
> On Fri, Jun 17, 2022 at 7:43 AM Waiman Long <longman@redhat.com> wrote:
>> On 6/17/22 08:07, Peter Zijlstra wrote:
>>> On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
>>>> --- a/kernel/locking/qrwlock.c
>>>> +++ b/kernel/locking/qrwlock.c
>>>> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
>>>>       /*
>>>>        * Readers come here when they cannot get the lock without waiting
>>>>        */
>>>> -    if (unlikely(in_interrupt())) {
>>>> -            /*
>>>> -             * Readers in interrupt context will get the lock immediately
>>>> -             * if the writer is just waiting (not holding the lock yet),
>>>> -             * so spin with ACQUIRE semantics until the lock is available
>>>> -             * without waiting in the queue.
>>>> -             */
>>>> -            atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
>>>> -            return;
>>>> -    }
>>>>       atomic_sub(_QR_BIAS, &lock->cnts);
>>>>
>>>>       trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
>>> This is known to break tasklist_lock.
>>>
>> We certainly can't break the current usage of tasklist_lock.
>>
>> I am aware of this problem with networking code and is thinking about
>> either relaxing the check to exclude softirq or provide a
>> read_lock_unfair() variant for networking use.
> read_lock_unfair() for networking use or tasklist_lock use?

I mean to say read_lock_fair(), but it could also be the other way 
around. Thanks for spotting that.

Cheers,
Longman

