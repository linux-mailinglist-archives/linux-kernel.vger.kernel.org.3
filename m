Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09811583C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbiG1Kyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiG1Kyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0468F5A2ED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659005670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7KoQQFhYH+e/jh/becWFAFAIXAkrcmz+iT80I8Tbdp4=;
        b=TiacOV5XW6D+JSeV2CvDAVDK7JiJ0f7oO6YAYMDjE3t7TKy+LJMlgVOrywUBXcAPUZ/d8m
        qMO/CojuBD7bRz18rzJODm51mlpTWJsejlwdEJYsfMTWgbi7lF74y05A/Ufcyj2/bCkQAo
        DmnnUk0iybm4yjq27lLPn1EX7lwGbSg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-UYdar5ivNlG8hEicXM0peQ-1; Thu, 28 Jul 2022 06:54:22 -0400
X-MC-Unique: UYdar5ivNlG8hEicXM0peQ-1
Received: by mail-wm1-f70.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so2439578wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7KoQQFhYH+e/jh/becWFAFAIXAkrcmz+iT80I8Tbdp4=;
        b=byo0sjbh208RE4pYXSAsF/n6tn0Zarh97gWV/QYglMWekeLzgURc0acIXfHkYsH0/Z
         FYM9n6qPCE8YGr3xn4ELgoAgIa1rdFK8CvB3RUppgrdxSlr5aUaSdXBZBoBzujqL41Ru
         n/7Hb2XBkznAFQjzP/AObRHmhr9ogkQlp781Js0O6PooVItuJZX3vGLsEJDq1ToVVytS
         QRcQLCNVPy0tag9BZ5izfTDeRt0oW2Xs3yCY3qXt0mdhHVnh7YgLQm4Xagb7v4t97vAj
         fnaVobNX+ut1aiOpT7HaO8NxYP8Z3ar8EkAYDYkubqmkVVHe1DiYFEz9U21ddZQZkm+0
         Ig9A==
X-Gm-Message-State: AJIora/VlI1b1pfpsr8nhG7VFyp2QRuhXdsGIOCUz5JITmOkjqy4s2iQ
        LTkWzrxeGFvqcjieSjVmKWPKSZ55a6Pr1Tv+2TMu+4w1Z0Jl0AV1I+P3wdTQ3t5odQdDwuBMe3s
        SZpDsksVrqjJBSKl2QgD7tRt4
X-Received: by 2002:a5d:6a06:0:b0:21e:bd8e:4e7f with SMTP id m6-20020a5d6a06000000b0021ebd8e4e7fmr6331096wru.134.1659005660866;
        Thu, 28 Jul 2022 03:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t/lpyV93VpdpfBbJykDH6tOiA2gUNmbbjM+9krse/4B6OVenue64hO42YUwhSkas+iIHoHvg==
X-Received: by 2002:a5d:6a06:0:b0:21e:bd8e:4e7f with SMTP id m6-20020a5d6a06000000b0021ebd8e4e7fmr6331081wru.134.1659005660593;
        Thu, 28 Jul 2022 03:54:20 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f19-20020adfb613000000b0021e13efa17esm595360wre.70.2022.07.28.03.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:54:20 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending
 them to exit()
In-Reply-To: <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
References: <20220727115327.2273547-1-vschneid@redhat.com>
 <20220727115327.2273547-2-vschneid@redhat.com>
 <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
Date:   Thu, 28 Jul 2022 11:54:19 +0100
Message-ID: <xhsmhedy5ecdg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/22 01:13, Lai Jiangshan wrote:
> Quick review before going to sleep.
>

Thanks!

> On Wed, Jul 27, 2022 at 7:54 PM Valentin Schneider <vschneid@redhat.com> wrote:
>> @@ -1806,8 +1806,10 @@ static void worker_enter_idle(struct worker *worker)
>>         /* idle_list is LIFO */
>>         list_add(&worker->entry, &pool->idle_list);
>>
>> -       if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
>> -               mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
>> +       if (too_many_workers(pool) && !delayed_work_pending(&pool->idle_reaper_work))
>> +               mod_delayed_work(system_unbound_wq,
>> +                                &pool->idle_reaper_work,
>> +                                IDLE_WORKER_TIMEOUT);
>
> system_unbound_wq doesn't have a rescuer.
>
> A new workqueue with a rescuer needs to be created and used for
> this purpose.
>

Right, I think it makes sense for those work items to be attached to a
WQ_MEM_RECLAIM workqueue. Should I add that as a workqueue-internal
thing?

>>
>>         /* Sanity check nr_running. */
>>         WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
>> @@ -1972,9 +1974,29 @@ static struct worker *create_worker(struct worker_pool *pool)
>>         return NULL;
>>  }
>>
>> +static void unbind_worker(struct worker *worker)
>> +{
>> +       kthread_set_per_cpu(worker->task, -1);
>> +       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
>> +}
>> +
>> +static void rebind_worker(struct worker *worker, struct worker_pool *pool)
>> +{
>> +       kthread_set_per_cpu(worker->task, pool->cpu);
>> +       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
>> +}
>> +
>> +static void reap_worker(struct worker *worker)
>> +{
>> +       list_del_init(&worker->entry);
>> +       unbind_worker(worker);
>> +       wake_up_process(worker->task);
>
>
> Since WORKER_DIE is set, the worker can be possible freed now
> if there is another source to wake it up.
>

My understanding for having reap_worker() be "safe" to use outside of
raw_spin_lock_irq(pool->lock) is that pool->idle_list is never accessed
outside of the pool->lock, and wake_up_worker() only wakes a worker that
is in that list. So with destroy_worker() detaching the worker from
pool->idle_list under pool->lock, I'm not aware of a codepath other than
reap_worker() that could wake it up.

The only wake_up_process() I see that doesn't involve the pool->idle_list
is in send_mayday(), but AFAIA rescuers can never end up in the idle_list
and are specifically destroyed in destroy_workqueue().

> I think reverting a part of the commit 60f5a4bcf852("workqueue:
> async worker destruction") to make use of kthread_stop()
> in destroy_worker() should be a good idea.

