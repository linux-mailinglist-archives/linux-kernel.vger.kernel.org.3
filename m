Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72C4E55EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiCWQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiCWQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:07:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09421706C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:06:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e5827a76f4so22583977b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNdgroiW0MXjQ1AJ+7byePTTsvQ9RWf63r2qZjoIhzM=;
        b=BDixQbSmDLCatKCAqmxGMt8khsgiM9XapdUq+Gh3JZZv3gPFoi0P0fw0k42KHOE2H/
         RwAYQyYcIZkdR36tf3ycyu1/5r+e/m4RQpQvneCZZfN4jkFOgngZXY/23sGoYLaiqv2p
         yFcfYkvkV21WjEOkWrQzKXPOF3HCapNpdpJlOq/Etx3bwae2mpI/m1JWC4H33F0FkfqG
         05fGFRVSXuYZtZMiGxqM3X1Hh/O5U6tTn+z1FucZ9+l3LER1X89AAMZNeFu0znsrZvKq
         /NyKKJvrGZprsSZhDqoyFsaQBUkPZy7GDtaEBJ6hPSjFUa9hxiG2d7cueEq5o5Wq2Ju/
         bP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNdgroiW0MXjQ1AJ+7byePTTsvQ9RWf63r2qZjoIhzM=;
        b=sigysFJ6FIHznVEl8dAiTe3BgV3jTvGlyt542i7wXj/MO5LdgmHf8FXZjChSrGq8T2
         f/ZTCpJxLeQWKdcC2kJqDzXd0juO9wq27xJWK2BPHQcUwa+sAAx5+qXqtRVPDNA/Q+1p
         TAX3PjTurd1xRi5lJOl65BFDFKxilUD8fd9AZOLzA4LHWeJSbMnxbywNgJrc7SGRP1zN
         BzGRbGKnW0aUKq/35RRZ1Dn+d8f++2TFls8BiaQHSJzMGJuAALLDlxo2PdJcOh7ZJSVr
         MRekEUCxQ7VVUmBnV7QcsJkBsSejBQx/erej3FafEKwwT9+5Yl6sLMmOv9Ha0RopeQfT
         3Djw==
X-Gm-Message-State: AOAM532JFyJ8bKJnpGZ5J3siY+n+G0AywVHiCWPRGB/rp/Qh7SnyQRWH
        tJfhdKURoOeZ1tCQSx6qHUEeHYV7v4XdgG6ttHeStg==
X-Google-Smtp-Source: ABdhPJy3ADoka5C1IUqU+SF64IvaEfpu3FaPlfL6EMD1BG/jyxNrLVeWbCG7YSyWhQ27KxMMwTr/pC6PiPTVKaURBnI=
X-Received: by 2002:a05:690c:809:b0:2e5:a6cb:bccd with SMTP id
 bx9-20020a05690c080900b002e5a6cbbccdmr605457ywb.47.1648051561524; Wed, 23 Mar
 2022 09:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220311011715.2440601-1-eric.dumazet@gmail.com> <14cceb7c-f5f7-ee8e-18aa-4884ef212eb0@intel.com>
In-Reply-To: <14cceb7c-f5f7-ee8e-18aa-4884ef212eb0@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 23 Mar 2022 09:05:50 -0700
Message-ID: <CANn89iK7cj+Msz7=+nzmbC=BbaA9Rpp4e+u0d-xRuSr1K-TbPg@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: use smp_call_function_many() in arch_freq_prepare_all()
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 8:36 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 3/11/2022 2:17 AM, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > Opening /proc/cpuinfo can have a big latency on hosts with many cpus,
> > mostly because it is essentially doing:
> >
> >     for_each_online_cpu(cpu)
> >      smp_call_function_single(cpu, aperfmperf_snapshot_khz, ...)
> >
> > smp_call_function_single() is reusing a common csd, meaning that
> > each invocation needs to wait for completion of the prior one.
> >
> > Paul recent patches have lowered number of cpus receiving the IPI,
> > but there are still cases where the latency of the above loop can
> > reach 10 ms, then an extra msleep(10) is performed, for a total of 20ms.
> >
> > Using smp_call_function_many() allows for full parallelism,
> > and latency is down to ~80 usec, on a host with 256 cpus.
>
> This looks reasonable to me.
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> or if you want me to pick it up, please resend the patch with a CC to
> linux-pm@vger.kernel.org.

I do not know what x86 maintainers prefer ?

Let them give their advice here, thanks !

>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > ---
> >   arch/x86/kernel/cpu/aperfmperf.c | 32 +++++++++++++++++++++++---------
> >   1 file changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> > index 22911deacb6e441ad60ddb57190ef3772afb3cf0..a305310ceb44784a0ad9be7c196061d98fa1adbc 100644
> > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > @@ -67,7 +67,8 @@ static void aperfmperf_snapshot_khz(void *dummy)
> >       atomic_set_release(&s->scfpending, 0);
> >   }
> >
> > -static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
> > +static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait,
> > +                                 struct cpumask *mask)
> >   {
> >       s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
> >       struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> > @@ -76,9 +77,13 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
> >       if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> >               return true;
> >
> > -     if (!atomic_xchg(&s->scfpending, 1) || wait)
> > -             smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
> > -
> > +     if (!atomic_xchg(&s->scfpending, 1) || wait) {
> > +             if (mask)
> > +                     __cpumask_set_cpu(cpu, mask);
> > +             else
> > +                     smp_call_function_single(cpu, aperfmperf_snapshot_khz,
> > +                                              NULL, wait);
> > +     }
> >       /* Return false if the previous iteration was too long ago. */
> >       return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
> >   }
> > @@ -97,13 +102,14 @@ unsigned int aperfmperf_get_khz(int cpu)
> >       if (rcu_is_idle_cpu(cpu))
> >               return 0; /* Idle CPUs are completely uninteresting. */
> >
> > -     aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
> > +     aperfmperf_snapshot_cpu(cpu, ktime_get(), true, NULL);
> >       return per_cpu(samples.khz, cpu);
> >   }
> >
> >   void arch_freq_prepare_all(void)
> >   {
> >       ktime_t now = ktime_get();
> > +     cpumask_var_t mask;
> >       bool wait = false;
> >       int cpu;
> >
> > @@ -113,17 +119,25 @@ void arch_freq_prepare_all(void)
> >       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> >               return;
> >
> > +     if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> > +             return;
> > +
> > +     cpus_read_lock();
> >       for_each_online_cpu(cpu) {
> >               if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
> >                       continue;
> >               if (rcu_is_idle_cpu(cpu))
> >                       continue; /* Idle CPUs are completely uninteresting. */
> > -             if (!aperfmperf_snapshot_cpu(cpu, now, false))
> > +             if (!aperfmperf_snapshot_cpu(cpu, now, false, mask))
> >                       wait = true;
> >       }
> >
> > -     if (wait)
> > -             msleep(APERFMPERF_REFRESH_DELAY_MS);
> > +     preempt_disable();
> > +     smp_call_function_many(mask, aperfmperf_snapshot_khz, NULL, wait);
> > +     preempt_enable();
> > +     cpus_read_unlock();
> > +
> > +     free_cpumask_var(mask);
> >   }
> >
> >   unsigned int arch_freq_get_on_cpu(int cpu)
> > @@ -139,7 +153,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
> >       if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
> >               return 0;
> >
> > -     if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
> > +     if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true, NULL))
> >               return per_cpu(samples.khz, cpu);
> >
> >       msleep(APERFMPERF_REFRESH_DELAY_MS);
>
>
