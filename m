Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0531358AE5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiHEQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiHEQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D49B6286F7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659718035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcSUhXeJFeySYKRzpAqyW060+k6lvrGATvWh7EXTjrk=;
        b=W7haFOJBEczTzxrUM6QayTJIZRIFQtuyBuwhNXNk5K9KDnXx5S12C0uJn6NiBXwXAXXS4C
        f0CZ1B4KBkzCRLLlYQ41csWpVxZbJ2KYR/amXVfh/efIMeskMqJrcJ+qqGL09sHKHNLgPf
        /428nNQAD/9jy7n/6pwT6Uowy44drx0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-hzb2JzrCOfS4DaRxLTqxqw-1; Fri, 05 Aug 2022 12:47:12 -0400
X-MC-Unique: hzb2JzrCOfS4DaRxLTqxqw-1
Received: by mail-wm1-f72.google.com with SMTP id x17-20020a05600c21d100b003a32dda6577so575542wmj.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=qcSUhXeJFeySYKRzpAqyW060+k6lvrGATvWh7EXTjrk=;
        b=d/0vbkINZ1Y2xpDJO+eEzoftQ/pJxB6vSGE5O700bnpfpWhzn2J/L0o8Q4vEJ8mGW0
         c/lqwHbw7IPDXf8upDWhRT8ezLMcqGlJEq1sWkfDww50CoCeIvoo4oi0ucLH6P8dkxGp
         YVCCDOd9vWm+VnVG4gzwQk8pdUOXIvBdCRX8UDsYk60Zn2nqTd/f2teuQ2+DyXj6zvN7
         Qn0wL1+kAcfvubguQGz1dtN6crWK1zLr8nRKoGRvq5ygB6EypeGEDguEenxrdIR+XaWJ
         C4Y2cqhESTiHI6MCRR9JIxetTjty1XHdvFhGiC5WgPuYSoTrXiieWYn9nDj662x94GZH
         yLNA==
X-Gm-Message-State: ACgBeo0MN1+ZktTZF/vX75D4zEVmHEPeIo5v1BTuX8h5O6xoCREb+ADK
        NWwxWqO2+l7DMCjUD5+zzQWiRkAQxkA0lqVY11hgFq8ZRqL8E25lZzUz1rAGhALleGnBzUK2hFf
        BHUP/GS5qsTMhfx/tjKZ6n1g4
X-Received: by 2002:a5d:47a4:0:b0:220:600d:2b0f with SMTP id 4-20020a5d47a4000000b00220600d2b0fmr4919943wrb.407.1659718031336;
        Fri, 05 Aug 2022 09:47:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6IlxXVWu6gMx48hOnf0BE9pE2m/+ckY1U34qFr8yEjmOlouF1/uzqoGxgfvWyDqtxbaSIpJg==
X-Received: by 2002:a5d:47a4:0:b0:220:600d:2b0f with SMTP id 4-20020a5d47a4000000b00220600d2b0fmr4919926wrb.407.1659718031126;
        Fri, 05 Aug 2022 09:47:11 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b002205b786ab3sm4358414wrt.14.2022.08.05.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:47:10 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v3 2/3] workqueue: Unbind workers before sending
 them to exit()
In-Reply-To: <CAJhGHyAzoa5Mb7cHd8oxbWOfgsGEt-8afTTVdjOWY8sgHY0Mcg@mail.gmail.com>
References: <20220802084146.3922640-1-vschneid@redhat.com>
 <20220802084146.3922640-3-vschneid@redhat.com>
 <CAJhGHyAzoa5Mb7cHd8oxbWOfgsGEt-8afTTVdjOWY8sgHY0Mcg@mail.gmail.com>
Date:   Fri, 05 Aug 2022 17:47:09 +0100
Message-ID: <xhsmh8ro2d4du.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/22 11:16, Lai Jiangshan wrote:
> On Tue, Aug 2, 2022 at 4:42 PM Valentin Schneider <vschneid@redhat.com> wrote:
>> +/*
>> + * Unlikely as it may be, a worker could wake after destroy_worker() has
>> + * happened but before reap_workers(). WORKER_DIE would be set in worker->flags,
>> + * so it would be able to kfree(worker) and head out to do_exit().
>> + *
>> + * Rather than make the reaper wait for each to-be-reaped kworker to exit and
>> + * kfree(worker) itself, make the kworkers (which have nothing to do but go
>> + * do_exit() anyway) wait for the reaper to be done with them.
>> + */
>> +static void worker_wait_reaped(struct worker *worker)
>> +{
>> +       WARN_ON_ONCE(current != worker->task);
>> +
>> +       for (;;) {
>> +               set_current_state(TASK_INTERRUPTIBLE);
>> +               if (READ_ONCE(worker->reaped))
>> +                       break;
>> +               schedule();
>> +       }
>> +       __set_current_state(TASK_RUNNING);
>> +}
>
>
> It is not a good idea to add this scheduler-ist code here.
>
> Using wq_pool_attach_mutex to protects the whole body of idle_reaper_fn()
> can stop the worker from freeing itself since the worker has to
> get the mutex before exiting.
>

Right, there's worker_detach_from_pool() before kfree(worker), hadn't
thought of that. I want to limit how many locks I'm hoarding with the
reaper, but given that one is for attach/detach I think that's OK - and I
also really don't like this worker_wait_reaped() function, so will be happy
to get rid of it. I'll give this a try, thanks!

> And I don't think batching destruction is a good idea since
> it is not a hot path.
>

The batching is mostly there because checking & removing a worker from its
pool->idle_list has to be done under pool->lock, but changing its affinity
requires a sleepable context, so I batched that outside of the spinlock
section.

>>         while (too_many_workers(pool)) {
>> -               struct worker *worker;
>>                 unsigned long expires;
>> +               unsigned long now = jiffies;
>>
>>                 /* idle_list is kept in LIFO order, check the last one */
>>                 worker = list_entry(pool->idle_list.prev, struct worker, entry);
>>                 expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>>
>> -               if (time_before(jiffies, expires)) {
>> -                       mod_timer(&pool->idle_timer, expires);
>> +               /*
>> +                * Careful: queueing a work item from here can and will cause a
>> +                * self-deadlock when dealing with an unbound pool. However,
>> +                * here the delay *cannot* be zero and *has* to be in the
>> +                * future, which works.
>> +                */
>> +               if (time_before(now, expires)) {
>
> IMHO, using raw_spin_unlock_irq(&pool->lock) here is better than
> violating locking rules *overtly* and documenting that it can not be
> really violated. But It would bring a "goto" statement.

I was worried about serializing accesses to pool->idle_reaper_work and its
underlying timer (worker_enter_idle() vs idle_reaper_fn()), though I think
the worst that can happen if idle_reaper_fn() does that without holding
pool->lock is worker_enter_idle() pushing back the timer to
IDLE_WORKER_TIMEOUT (rather than (last_active + IDLE_WORKER_TIMEOUT) -
now).

>> +                       mod_delayed_work(system_unbound_wq,
>> +                                        &pool->idle_reaper_work,
>> +                                        expires - now);
>>                         break;
>>                 }

>> @@ -5030,11 +5128,8 @@ static void rebind_workers(struct worker_pool *pool)
>>          * of all workers first and then clear UNBOUND.  As we're called
>>          * from CPU_ONLINE, the following shouldn't fail.
>>          */
>> -       for_each_pool_worker(worker, pool) {
>> -               kthread_set_per_cpu(worker->task, pool->cpu);
>> -               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>> -                                                 pool->attrs->cpumask) < 0);
>> -       }
>> +       for_each_pool_worker(worker, pool)
>> +               rebind_worker(worker, pool);
>
>
> It is better to skip the workers which are WORKER_DIE.
> Or just detach the worker when reaping it.

Hadn't even thought about this racing with to-be-destroyed workers. Having
worker_detach_from_pool() done by the worker itself is convenient for the
serialization with wq_pool_attach_mutex as you suggested, let me scratch my
head some more.

>
>>
>>         raw_spin_lock_irq(&pool->lock);
>>
>> diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
>> index e00b1204a8e9..a3d60e10a76f 100644
>> --- a/kernel/workqueue_internal.h
>> +++ b/kernel/workqueue_internal.h
>> @@ -46,6 +46,7 @@ struct worker {
>>         unsigned int            flags;          /* X: flags */
>>         int                     id;             /* I: worker id */
>>         int                     sleeping;       /* None */
>> +       int                     reaped;         /* None */
>>
>>         /*
>>          * Opaque string set with work_set_desc().  Printed out with task
>> --
>> 2.31.1
>>

