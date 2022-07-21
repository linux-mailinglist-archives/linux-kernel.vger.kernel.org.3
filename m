Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748B57CCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGUNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiGUNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BECCE1D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658411635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Py5p6dIw7RyqWLqBb5JYlm9TREMqDn9d4+KPpK4eceE=;
        b=cnoHEieZ13Z+431z0mSrzmZHKn0Z3rJFZzqGFCepeI+OX5QtrlcrF7jY+g/VEDER8QF5ps
        7pcJjlAtt3WsZXT6FGtQvY2Jb4eQQrw7NqX9m3sAQ/nDgz22La9voFZwYflehTy7tRol62
        ZqWOT9bsAIkwNmJe4bnueIKXIKzTWxc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-YoYp21dOPF68v9CAcLK9WA-1; Thu, 21 Jul 2022 09:53:47 -0400
X-MC-Unique: YoYp21dOPF68v9CAcLK9WA-1
Received: by mail-wm1-f70.google.com with SMTP id v123-20020a1cac81000000b003a02a3f0beeso2844986wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Py5p6dIw7RyqWLqBb5JYlm9TREMqDn9d4+KPpK4eceE=;
        b=lqr+0fhc59yd69MJPsG39Gnr4SIDHBLWPxikxhSnXw/n7rlpsM7k76Bbwx50iBiNgL
         BclwK/uMyxlJa/t9NuEv6iVF94hTe/XRglUaJj3kziDkbj6D6YVTi+dmddqtn8Dxr+rs
         Sqjy2UIX3GJvvMiV8f4AzUxaz32KvCgbK5mim61fo3nAatA5IUIHBmfa+LFhqYR57LPj
         NYvVJMR1I4u1Osv6vlgLUbAF/aCFhcjsIaHL9C+zRlQZlmKKFIbbM+TTpaXWyDzz0Shw
         J3s6lo8c1ziUEd8Rb8OyyuMtHuj4BBhq0zoqejGgRagQ4jclSkws3yCWKVT2zwpWhmbT
         qS1A==
X-Gm-Message-State: AJIora+uHwrB1OyVIzaDJsrYSL/F4bZ2yebdWnp+m5zjfdRRGITaCC9Y
        auj5NyPvP6kIk0xckhtJdLnF53zbvWJVOpuLY066MhVbA9SDXouXOXTYQ2DdiyWMoh8QJJqR05o
        WGj297N23URBsse9gXpXAusOd
X-Received: by 2002:a05:600c:4f49:b0:3a3:2717:27fc with SMTP id m9-20020a05600c4f4900b003a3271727fcmr8395156wmq.36.1658411626043;
        Thu, 21 Jul 2022 06:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtffZCfX7ip8YK5dZI/pOP5iqYltOevdyqaFsbPhaRMVJrljCorjoneygwo5G4iE+W6ugqBw==
X-Received: by 2002:a05:600c:4f49:b0:3a3:2717:27fc with SMTP id m9-20020a05600c4f4900b003a3271727fcmr8395140wmq.36.1658411625697;
        Thu, 21 Jul 2022 06:53:45 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id a8-20020adfe5c8000000b0021e5d77a489sm75105wrn.31.2022.07.21.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:53:45 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
In-Reply-To: <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
Date:   Thu, 21 Jul 2022 14:53:43 +0100
Message-ID: <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/22 11:35, Lai Jiangshan wrote:
>> @@ -1999,6 +2011,16 @@ static void destroy_worker(struct worker *worker)
>>
>>         list_del_init(&worker->entry);
>>         worker->flags |= WORKER_DIE;
>> +
>> +       /*
>> +        * We're sending that thread off to die, so any CPU would do. This is
>> +        * especially relevant for pcpu kworkers affined to an isolated CPU:
>> +        * we'd rather not interrupt an isolated CPU just for a kworker to
>> +        * do_exit().
>> +        */
>> +       if (!(worker->flags & WORKER_UNBOUND))
>> +               unbind_worker(worker);
>> +
>>         wake_up_process(worker->task);
>>  }
>
> destroy_worker() is called with raw_spin_lock_irq(pool->lock), so
> it cannot call the sleepable set_cpus_allowed_ptr().
>
> From __set_cpus_allowed_ptr:
>> * NOTE: the caller must have a valid reference to the task, the
>> * task must not exit() & deallocate itself prematurely. The
>> * call is not atomic; no spinlocks may be held.
>

Heh, I somehow forgot that this is blocking. Now in this particular case I
think pcpu kworkers are "safe" - they shouldn't be running when
destroy_worker() is invoked on them (though AFAICT that is not a "hard"
guarantee), and it doesn't make any sense for them to use
migrate_disable(). Still, yeah, not ideal.

> I think it needs something like task_set_cpumask_possible() which is
> documented as being usable in (raw) spinlocks and set the task's cpumask
> to cpu_possible_mask and let the later ttwu help migrate it to a
> proper non-isolated CPU or let it keep running.
>

I'll see what I can come up with, thanks for the suggestion.

