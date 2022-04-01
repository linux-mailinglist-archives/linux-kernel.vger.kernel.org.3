Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365034EEC77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiDALl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiDALl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:41:28 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CB46B1C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:39:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-deb9295679so2375498fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8Dv18kj8IAp5BXzcoVdvPm3aoVZ9KkfAIFlQfRSHMc=;
        b=aoPZa1pn34n3/UbbBEmBNxfGoFIYfhjDeJHZb7LC5OAYcrTuPJuXuocMHswRPmqFN8
         mjbIP5IeObSQsfZl60QvvIGmZfUITORtgwwe/TDNFBkaOuYwN6mSh5Ra0NfFu8CYU21F
         6knBvpWyYhTljKSJlwD0nNFZzNn/ZxCAtX5COK2NJXAQB6vLv0/+Z/iZ41KqW61I2jIY
         XaxAhwNl6rCY8DjhtBsr1bQIufr3ujRnIHuF4uqEUKMFGn1J8sF/OFzbzbLNtw+et2rR
         Eh85+s/sqdhBsV4HMHo2QU2em9WRSibZUtaTc30I5aOcAPaAMBhcPfr2XDBUNQIwZqbj
         fd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8Dv18kj8IAp5BXzcoVdvPm3aoVZ9KkfAIFlQfRSHMc=;
        b=LEWfFY3LN738RRtDowCU2nGlVJa0hzxl/Dc178jKA6zFwyBwDRs8I/GKjDtZ6T+pJ8
         juSwQNgud1hVmQDzaPepeV8pa/QDlt4YGfpJe43uLAwhqEJebo5dpb+KBz/YtEXhIuWu
         0rpLMzkCqmUOMlm5tHDvciLpgjhXm2lD89f1xaYd9SCh9VOgLsHDToyyeYzOOheeM3QU
         gGW8P47idkjfP2cmf+V9/hBXS4ZcqNFyitf668qExosV09Vjq++7RqY5rsYbn8EXqKIN
         chazF4JaYNZ6tOkSYvWDQG/f4js5UVwA57K+7q4uBooU883g+abHuSvziHG3cQemzVn7
         CzWg==
X-Gm-Message-State: AOAM531+L4rwtyx3VRrvPpfG72PsJfadq2/QlVGx4AuEWS7o8nvmdPvA
        iUCu+2nSMB+NsRIM7RrErGn0wd5P4RJkmFf2D2TA3Q==
X-Google-Smtp-Source: ABdhPJxWLxR+hwwbMPprX/38Wf8W+ylowuP0eojFUEJsF+C6PtS475L2/4YSCEJpDavKonwYTJhiNL5h4z5MIUgdJjw=
X-Received: by 2002:a05:6870:b629:b0:de:a293:bf74 with SMTP id
 cm41-20020a056870b62900b000dea293bf74mr4791423oab.163.1648813176421; Fri, 01
 Apr 2022 04:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220401091006.2100058-1-qiang1.zhang@intel.com>
In-Reply-To: <20220401091006.2100058-1-qiang1.zhang@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Apr 2022 13:39:23 +0200
Message-ID: <CACT4Y+Zw7FJ6Rp0+DB_crXJ0rwZHNM9n-z+V2E-e_=87c6ewgg@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix sleeping function called from invalid context
 in PREEMPT_RT
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        bigeasy@linutronix.de, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
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

On Fri, 1 Apr 2022 at 11:09, Zqiang <qiang1.zhang@intel.com> wrote:
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
> ___cache_free() is called in IPI interrupt context, the local lock
> or spin lock will be acquired. on PREEMPT_RT kernel, these lock is
> replaced with sleepbale rt spin lock, so the above problem is triggered.
> fix it by migrating the release action from the IPI interrupt context
> to the task context on RT kernel.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  mm/kasan/quarantine.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 08291ed33e93..c26fa6473119 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -90,6 +90,7 @@ static void qlist_move_all(struct qlist_head *from, struct qlist_head *to)
>   */
>  static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine);
>
> +static DEFINE_PER_CPU(struct qlist_head, cpu_shrink_qlist);
>  /* Round-robin FIFO array of batches. */
>  static struct qlist_head global_quarantine[QUARANTINE_BATCHES];
>  static int quarantine_head;
> @@ -311,12 +312,14 @@ static void qlist_move_cache(struct qlist_head *from,
>  static void per_cpu_remove_cache(void *arg)
>  {
>         struct kmem_cache *cache = arg;
> -       struct qlist_head to_free = QLIST_INIT;
> +       struct qlist_head *to_free;
>         struct qlist_head *q;
>
> +       to_free = this_cpu_ptr(&cpu_shrink_qlist);
>         q = this_cpu_ptr(&cpu_quarantine);
> -       qlist_move_cache(q, &to_free, cache);
> -       qlist_free_all(&to_free, cache);
> +       qlist_move_cache(q, to_free, cache);
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +               qlist_free_all(to_free, cache);
>  }
>
>  /* Free all quarantined objects belonging to cache. */
> @@ -324,6 +327,7 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>  {
>         unsigned long flags, i;
>         struct qlist_head to_free = QLIST_INIT;
> +       int cpu;
>
>         /*
>          * Must be careful to not miss any objects that are being moved from
> @@ -334,6 +338,11 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>          */
>         on_each_cpu(per_cpu_remove_cache, cache, 1);
>
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +               for_each_possible_cpu(cpu)
> +                       qlist_free_all(per_cpu_ptr(&cpu_shrink_qlist, cpu), cache);
> +       }

Hi Zqiang,

This code is not protected by any kind of mutex, right? If so, I think
it can lead to subtle memory corruptions, double-frees and leaks when
several tasks move to/free from cpu_shrink_qlist list.


>         raw_spin_lock_irqsave(&quarantine_lock, flags);
>         for (i = 0; i < QUARANTINE_BATCHES; i++) {
>                 if (qlist_empty(&global_quarantine[i]))
