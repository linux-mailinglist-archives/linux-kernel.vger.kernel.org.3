Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE204EF805
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiDAQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350940AbiDAQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:33:52 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4DA25497C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:06:55 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-df22f50e0cso3192219fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjPMVpfZYa2UWTaTkojTnQ6GnHTEqGgbKYMCrmrRLrQ=;
        b=r+3EhPACyXQcjv8gzZJUGWpdNsnZtK3tOGXNJ1dAH8X2HAgciA6YAIrNA4sAB2zycn
         zI2MQO/tXB4us3uL13ZwPetv5PtOmKEWF57FbltrhPb/12ZOBS1lwVtaR7Oy5Q8y5diJ
         kCTakVAmHLhxfoub5KBRnhCTElv63XD7R3q6r3xZ9Gw7iRPnrfVuJfIk6vRLM6dWcZdB
         hJHiTXyTbWftTSeszkQovyEA/qIIX2qMUwyYtGpk4HhRU1AiAokZzM1eMLvZLmITqMKG
         wKnCIr18qeqD30p6YUK2UhBYJer1tJxEP1GF1QvH9jRbAvPFzEbfIdDXztavoP8ur7Ul
         TFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjPMVpfZYa2UWTaTkojTnQ6GnHTEqGgbKYMCrmrRLrQ=;
        b=jFcORr4hENcdoVY24J1Abe1F4yWDS5mg/zSkvB964Q5OAxNGrPihNObs9zcYAk1GPB
         JhP1+tdUTIHEfUTAbIqp6erT4mOihAxQ5cMd6pufwdWnFkPAqrMFpcvuWGbi3/hA1GVc
         NbW67zPLUG9femt4gUSnVc3hpk79Te0TKokrwCATI/OXxpzbtcyeAY/n6JpS/DyCAN97
         TuTEjYXMRmZOI/PNvEkgPZFNNqhXDQu/JPSxShQgNtcvWW+6a7kVe9yFML4PEGDAeU7h
         hgOCFa5F8hw5zkliFH7Zu69S+UIZVw5INosOulPP9rSc2cWrgFPbFllQ5MWrNuh5fIlW
         EY0A==
X-Gm-Message-State: AOAM533974m7Vzh+mtlXdnoMS2B90FNGIhZ6JYzp6ZvfR3XSO/B20USP
        cxy5u60vPIPJipM29j2uIJFtnszzmifnabr9yVTC1g==
X-Google-Smtp-Source: ABdhPJzIDhptL2aCKvMFb3/TL8dAbiG6w4SKgEc0uj76Q7Gvfk6fcm/uaLuun9wdqjFOq0qzZ9kaz3Q2n75s4Sqk+N4=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr5306787oac.211.1648829214046; Fri, 01
 Apr 2022 09:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220401134649.2222485-1-qiang1.zhang@intel.com>
In-Reply-To: <20220401134649.2222485-1-qiang1.zhang@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Apr 2022 18:06:42 +0200
Message-ID: <CACT4Y+YrKd=+uJT9UN8QvctPUGKnOgcReYfX41vNuVC0ecWXcg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: Fix sleeping function called from invalid
 context on RT kernel
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, 1 Apr 2022 at 15:46, Zqiang <qiang1.zhang@intel.com> wrote:
>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> preempt_count: 1, expected: 0
> ...........
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.1-rt16-yocto-preempt-rt #22
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl+0x60/0x8c
> dump_stack+0x10/0x12
>  __might_resched.cold+0x13b/0x173
> rt_spin_lock+0x5b/0xf0
>  ___cache_free+0xa5/0x180
> qlist_free_all+0x7a/0x160
> per_cpu_remove_cache+0x5f/0x70
> smp_call_function_many_cond+0x4c4/0x4f0
> on_each_cpu_cond_mask+0x49/0xc0
> kasan_quarantine_remove_cache+0x54/0xf0
> kasan_cache_shrink+0x9/0x10
> kmem_cache_shrink+0x13/0x20
> acpi_os_purge_cache+0xe/0x20
> acpi_purge_cached_objects+0x21/0x6d
> acpi_initialize_objects+0x15/0x3b
> acpi_init+0x130/0x5ba
> do_one_initcall+0xe5/0x5b0
> kernel_init_freeable+0x34f/0x3ad
> kernel_init+0x1e/0x140
> ret_from_fork+0x22/0x30
>
> When the kmem_cache_shrink() be called, the IPI was triggered, the
> ___cache_free() is called in IPI interrupt context, the local-lock
> or spin-lock will be acquired. on PREEMPT_RT kernel, these lock is
> replaced with sleepbale rt-spinlock, so the above problem is triggered.
> fix it by move the qlist_free_allfrom() the IPI interrupt context
> to the task context when PREEMPT_RT is enabled.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  Add raw_spinlock protect per-cpu shrink qlist.
>
>  mm/kasan/quarantine.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 08291ed33e93..0e33d30abb8d 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -99,6 +99,17 @@ static unsigned long quarantine_size;
>  static DEFINE_RAW_SPINLOCK(quarantine_lock);
>  DEFINE_STATIC_SRCU(remove_cache_srcu);
>
> +#ifdef CONFIG_PREEMPT_RT
> +struct cpu_shrink_qlist {
> +       raw_spinlock_t lock;
> +       struct qlist_head qlist;
> +};
> +
> +static DEFINE_PER_CPU(struct cpu_shrink_qlist, shrink_qlist) = {
> +       .lock = __RAW_SPIN_LOCK_UNLOCKED(shrink_qlist.lock),
> +};
> +#endif
> +
>  /* Maximum size of the global queue. */
>  static unsigned long quarantine_max_size;
>
> @@ -311,12 +322,23 @@ static void qlist_move_cache(struct qlist_head *from,
>  static void per_cpu_remove_cache(void *arg)
>  {
>         struct kmem_cache *cache = arg;
> -       struct qlist_head to_free = QLIST_INIT;
>         struct qlist_head *q;
> -
> +#ifndef CONFIG_PREEMPT_RT
> +       struct qlist_head to_free = QLIST_INIT;
> +#else
> +       unsigned long flags;
> +       struct cpu_shrink_qlist *sq;
> +#endif
>         q = this_cpu_ptr(&cpu_quarantine);
> +#ifndef CONFIG_PREEMPT_RT
>         qlist_move_cache(q, &to_free, cache);
>         qlist_free_all(&to_free, cache);
> +#else
> +       sq = this_cpu_ptr(&shrink_qlist);
> +       raw_spin_lock_irqsave(&sq->lock, flags);
> +       qlist_move_cache(q, &sq->qlist, cache);
> +       raw_spin_unlock_irqrestore(&sq->lock, flags);
> +#endif
>  }
>
>  /* Free all quarantined objects belonging to cache. */
> @@ -324,6 +346,10 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>  {
>         unsigned long flags, i;
>         struct qlist_head to_free = QLIST_INIT;
> +#ifdef CONFIG_PREEMPT_RT
> +       int cpu;
> +       struct cpu_shrink_qlist *sq;
> +#endif
>
>         /*
>          * Must be careful to not miss any objects that are being moved from
> @@ -334,6 +360,16 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>          */
>         on_each_cpu(per_cpu_remove_cache, cache, 1);
>
> +#ifdef CONFIG_PREEMPT_RT
> +       for_each_online_cpu(cpu) {
> +               sq = per_cpu_ptr(&shrink_qlist, cpu);
> +               raw_spin_lock_irqsave(&sq->lock, flags);
> +               qlist_move_cache(&sq->qlist, &to_free, cache);
> +               raw_spin_unlock_irqrestore(&sq->lock, flags);
> +       }
> +       qlist_free_all(&to_free, cache);

I think now there is another subtle bug.
I assume that by the time kasan_quarantine_remove_cache(cache) returns
all objects belonging to the cache must be freed. I think there are
scenarios where it's not the case.
Consider there is thread 1 that calls kasan_quarantine_remove_cache(A)
and thread 2 that calls kasan_quarantine_remove_cache(B).
Consider that kasan_quarantine_remove_cache callbacks for both A and B
has finished and shrink_qlist contains all objects that belong to
caches A and B.
Now thread 1 executes for_each_online_cpu part and collects all
objects into the local to_free list.
Now thread 2 executes the for_each_online_cpu, calls qlist_free_all
(on an empty list) and returns from kasan_quarantine_remove_cache.
Then cache B is completely destroyed and freed.
Now thread 1 resumes and calls qlist_free_all for objects from cache B.
Bang!




> +#endif
> +
>         raw_spin_lock_irqsave(&quarantine_lock, flags);
>         for (i = 0; i < QUARANTINE_BATCHES; i++) {
>                 if (qlist_empty(&global_quarantine[i]))
> --
> 2.25.1
>
