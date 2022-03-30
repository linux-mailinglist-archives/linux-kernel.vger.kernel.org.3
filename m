Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8EB4ECA08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbiC3QxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349082AbiC3QxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:53:03 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEA294A02
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:51:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f38so37810914ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogSh6Ya/e1DQ9tiDUE5KnGnV5+fyJPCcT/yfwDoIMiI=;
        b=OL/qa7W8QuC1dyKipcvCHRRVF/1TQTMeRHn0NvKkvFey1wHGX/Adas+AXjade3nxzi
         G/HWpG26mRTS5IAfWcsZ/4gQBYsDAjwFW1sMLbpX1HLz4nSKx4V3Kzm5JXK3wCmPjc20
         xyQD9hTNpkTpJ+YwfSK2NHpCqk+1mubKV7pbXCMPcEhJOV0xrPgu3g5DggzaUurO897z
         vbKxQApSb5IyNGr2kYuWJftjAFr6Cy70TSHWK1f4t54rs/JiHCssWTdHX23BqI0hAEF5
         uZrHif8XWeNyOf01oMuRDPZazQ38hkh/ZaOlg8ON466jC88qfmu+WZSp0tEDs+OHppTq
         TQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogSh6Ya/e1DQ9tiDUE5KnGnV5+fyJPCcT/yfwDoIMiI=;
        b=xnVownooto9tSCpq0BVRQ8X9yFKCsj2CQEx/NNy80q2ozXtJVoturXS8+DXDnbSz6a
         UDg+yUsaD6zwyjp4Wb7z9OxwvgXrIeDc1fkfVNA/lYMLPzWZLk2nzKYhzb+e6ukj5cAv
         FDvA1xan7W5KLYgfbWPDenvrGKSNZ5UxIn4BjkoUfIevcxbdV0gHu5tqg0Y+A9rB6NdP
         sAbdlLrWwp+xvQ7IICLGXFZ81R1xDPl0NDxWT6XRJHvWS+y0zVyBrKkh4oOdddpQ+Xvw
         wg+2n3ZhR/K8qaGhe15OAduOzCq8tJyp05O8GLCfSHcmMe1Q7NTKm+TJ/hiy+KJd/Jn1
         8LNg==
X-Gm-Message-State: AOAM531Xfd47uBk7QK0scY3bgSp3b/GFO757Kb23njtujB0PaqFGamOL
        RO9PAugSXaqwizdvfXO35iZ7F5xHAjE+vzC2oyoNsg==
X-Google-Smtp-Source: ABdhPJzzooK814hu4ouNtW3ruEwGU4iQ0Ye3npH4LcIbOoXDP6DYnai7TZZ8z0TabFoIPfbFV+wiTwZ/IcHbPDJ56PE=
X-Received: by 2002:a25:f441:0:b0:611:4f60:aab1 with SMTP id
 p1-20020a25f441000000b006114f60aab1mr531088ybe.598.1648659074585; Wed, 30 Mar
 2022 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220311011715.2440601-1-eric.dumazet@gmail.com> <87ee2jo2je.ffs@tglx>
In-Reply-To: <87ee2jo2je.ffs@tglx>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Mar 2022 09:51:03 -0700
Message-ID: <CANn89i+aCnUQj+UkRQBQ+mkL3xeFCmSkgeCYx+hmMNmko+EZ4Q@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: use smp_call_function_many() in arch_freq_prepare_all()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, Mar 30, 2022 at 8:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Eric,
>
> On Thu, Mar 10 2022 at 17:17, Eric Dumazet wrote:
> > Opening /proc/cpuinfo can have a big latency on hosts with many cpus,
>
> this is important because open() sends IPIs? I assume you meant
> reading. But even that is of questionable importance unless you care to
> provide some useful information why this matters.

In our case, we had soft lockups.
Backporting recent patch from Paul helped a lot.

While doing the backport, I realized that the function was a bit silly,
because it was essentially looping X times sending an IPI, instead
of using broadcast IPI facility, which is less expensive.

We _also_ removed the binary that was for some unknown reason scanning
/proc/cpuinfo (that was a copy of ethtool )
but I felt that we should fix the kernel to save headaches for others.

>
> AFAIK, there are _two_ cases why /proc/cpuinfo is read:
>
>    1) Retrieve information about the CPUs and the [mis]features
>       supported by the kernel. This information is fully static and for
>       that purpose exposing the nominal CPU frequency would be
>       completely sufficient.
>
>    2) Retrieve the 'actual' CPU frequency because using the per CPU
>       sysfs interface is slow. In the worst case do that in a loop.
>
> I consider #2 an abuse and in fact the exposure of aperf/mperf to that
> interface should have never happened at all. But sure, features....
>
> As a consequence we are tinkering with this nonsense and optimizing it
> to death without even thinking about whether this interface makes sense
> or not:
>
> > Using smp_call_function_many() allows for full parallelism,
> > and latency is down to ~80 usec, on a host with 256 cpus.
>
> which I hate with a passion because that allows *unpriviledged* user
> space to inject systemwide IPIs every 10ms just to read these counters
> which are providing not more than some estimate and are of no value for
> the only sane use case of /proc/cpuinfo, i.e. #1 above.

You do realize that before my patch, this is already happening ?

My "optimization" simply replace an open loop of individual IPI with
use of the broadcast IPI capability.

Are you saying we should remove IPI broadcast and use loops
of IPI, one cpu at a time ?

>
> What's worse, that 80 usec worst case latency is spent in the context of
> an *unpriviledged* user space thread in preemption disabled context to
> wait for the SMP function calls to complete. RT users are very happy
> about that...
>
> On a machine with 256 CPUs the readout of /proc/cpuinfo without this
> whole aperf/mperf IPI muck takes already ~3msec just to dump information
> which is largely uninteresting:
>
> Total size:            400014
> Unique line size:       15146 ~= 3%
>
> Total lines:             7168
> Unique lines:             857 ~= 11%
>
> This 3msec is only the time for 'read()' w/o any IPI costs or subsequent
> parsing.
>
> Can we please take a step back and think about this for real instead of
> using the 'all I have is a hammer' approach?
>
> The use cases I'm aware of are:
>
>     1) Read the CPU [mis]features supported by the kernel:
>
>        Why would you read more than one CPU just for this if it's
>        trivial to figure out whether the system supports heterogenous
>        feature sets or not. Even if so, then still 90% of that
>        information is redundant because the feature differences are not
>        per CPU, they are per CPU clusters
>
>     2) Topology information
>
>     3) Provide a report for whatever purpose
>
>     4) CPU MHz retrieval
>
> I might have missed some "important" use case here. Feel free to educate
> me on that.
>
> Neither #1 nor #2 have any interest in redundant information nor do they
> care about "accurate" CPU MHz information.
>
> For #3 the amount of redundant information does not matter, but neither
> does the CPU MHz information. That's perfectly fine with the nominal
> frequency.
>
> So that leaves us with #4, which is a monitoring problem:
>
>    1) For the one off case the latency does not matter at all and if
>       done right then the whole IPI nonsense can be avoided
>       completely.
>
>    2) For continuous monitoring it matters obviously
>
>       If that's the real use case people care about then we should
>       provide a proper interface for it and do the obvious:
>
>        Set a flag to tell the CPUs to collect that data on a regular
>        base, e.g. in the tick interrupt.
>
>        The resulting overhead is going to be:
>
>          - The time to check the flag. If placed right then the costs is
>            in the low single digit cycles and not necessarily noticable
>            at all in the noise of the tick interrupt.
>
>          - The readout time for the A/MPERF MSRs, i.e. about 300 cycles
>            total.
>
>       IOW, we are talking about 200 - 300 cycles overhead for providing
>       the information on demand and very low single digits cycles
>       overhead per tick if the flag is not set.
>
>       Pretty much independent of the uarchs I tested on with a trivial
>       check, i.e. 'if (!collect) return;', the result was completely
>       within the noise of the timer interrupt and I really could not
>       read any significant difference out of it for the case where
>       collect was false.
>
>       Now compare that to the current IPI case with your patch:
>
>         - The IPI cost is ~3us on the remote CPU on the machine I did
>           the experiments on. But that's not taking the resulting cache
>           pollution and whatever into account.
>
>         - The costs for waiting on the initiating CPU for the remote
>           CPUs maxed out at ~90us
>
>        which sums up to 90 + 256 * 3 = 858us total compute time every
>        10ms, which amounts to 1.7e6 cycles.
>
>       That means 300 * 256 = 76800 cycles per 10ms worst case if all
>       CPUs are busy and have a tick running versus 1.7e6 cycles plus
>       associated costs.
>
> But it gets even better. The addition of frequency invariance scheduling
> for x86 already reads APERF and MPERF in *every* tick on recent machines.
>
> Of course this code lives elsewhere and does not share anything with the
> preexisting aperf/mperf muck. Sigh!
>
> So there is no real reason anymore to avoid a periodic readout of
> APERF/MPERF and provide the data for the other users.
>
> Something like the below makes all the IPI nonsense and more go
> away. It's probably incomplete, but builds, boots and shows pretty
> numbers. :)
>
> Thanks,
>
>         tglx
> ---
>  arch/x86/kernel/cpu/aperfmperf.c |  464 +++++++++++++++++++++++++++++++--------
>  arch/x86/kernel/cpu/proc.c       |    2
>  arch/x86/kernel/smpboot.c        |  355 -----------------------------
>  fs/proc/cpuinfo.c                |    6
>  include/linux/cpufreq.h          |    1
>  5 files changed, 372 insertions(+), 456 deletions(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -6,146 +6,422 @@
>   * Copyright (C) 2017 Intel Corp.
>   * Author: Len Brown <len.brown@intel.com>
>   */
> -
> -#include <linux/delay.h>
> -#include <linux/ktime.h>
> +#include <linux/cpufreq.h>
>  #include <linux/math64.h>
>  #include <linux/percpu.h>
> -#include <linux/cpufreq.h>
> -#include <linux/smp.h>
>  #include <linux/sched/isolation.h>
> -#include <linux/rcupdate.h>
> +#include <linux/sched/topology.h>
> +#include <linux/smp.h>
> +#include <linux/syscore_ops.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
>
>  #include "cpu.h"
>
>  struct aperfmperf_sample {
> -       unsigned int    khz;
> -       atomic_t        scfpending;
> -       ktime_t time;
> -       u64     aperf;
> -       u64     mperf;
> +       seqcount_t      seq;
> +       unsigned long   last_update;
> +       u64             acnt;
> +       u64             mcnt;
> +       u64             aperf;
> +       u64             mperf;
>  };
>
> -static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
> -
> -#define APERFMPERF_CACHE_THRESHOLD_MS  10
> -#define APERFMPERF_REFRESH_DELAY_MS    10
> -#define APERFMPERF_STALE_THRESHOLD_MS  1000
> +static DEFINE_PER_CPU(struct aperfmperf_sample, samples) = {
> +       .seq = SEQCNT_ZERO(apermperf_sample.s)
> +};
>
> -/*
> - * aperfmperf_snapshot_khz()
> - * On the current CPU, snapshot APERF, MPERF, and jiffies
> - * unless we already did it within 10ms
> - * calculate kHz, save snapshot
> - */
> -static void aperfmperf_snapshot_khz(void *dummy)
> +unsigned int arch_freq_get_on_cpu(int cpu)
>  {
> -       u64 aperf, aperf_delta;
> -       u64 mperf, mperf_delta;
> -       struct aperfmperf_sample *s = this_cpu_ptr(&samples);
> -       unsigned long flags;
> +       struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> +       unsigned long last;
> +       unsigned int seq;
> +       u64 acnt, mcnt;
>
> -       local_irq_save(flags);
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -       local_irq_restore(flags);
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               return 0;
>
> -       aperf_delta = aperf - s->aperf;
> -       mperf_delta = mperf - s->mperf;
> +       do {
> +               seq = raw_read_seqcount_begin(&s->seq);
> +               last = s->last_update;
> +               acnt = s->acnt;
> +               mcnt = s->mcnt;
> +       } while (read_seqcount_retry(&s->seq, seq));
>
>         /*
> -        * There is no architectural guarantee that MPERF
> -        * increments faster than we can read it.
> +        * Bail on invalid count and when the last update was too long ago,
> +        * which covers idle and NOHZ full CPUs.
>          */
> -       if (mperf_delta == 0)
> -               return;
> +       if (!mcnt || (jiffies - last) > (HZ / 25))
> +               return 0;
>
> -       s->time = ktime_get();
> -       s->aperf = aperf;
> -       s->mperf = mperf;
> -       s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
> -       atomic_set_release(&s->scfpending, 0);
> +       return div64_u64((cpu_khz * acnt), mcnt);
>  }
>
> -static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
> +static void init_counter_refs(void)
>  {
> -       s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
> -       struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> +       u64 aperf, mperf;
> +
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +       this_cpu_write(samples.aperf, aperf);
> +       this_cpu_write(samples.mperf, mperf);
> +}
> +
> +#ifdef CONFIG_X86_64
> +/*
> + * APERF/MPERF frequency ratio computation.
> + *
> + * The scheduler wants to do frequency invariant accounting and needs a <1
> + * ratio to account for the 'current' frequency, corresponding to
> + * freq_curr / freq_max.
> + *
> + * Since the frequency freq_curr on x86 is controlled by micro-controller and
> + * our P-state setting is little more than a request/hint, we need to observe
> + * the effective frequency 'BusyMHz', i.e. the average frequency over a time
> + * interval after discarding idle time. This is given by:
> + *
> + *   BusyMHz = delta_APERF / delta_MPERF * freq_base
> + *
> + * where freq_base is the max non-turbo P-state.
> + *
> + * The freq_max term has to be set to a somewhat arbitrary value, because we
> + * can't know which turbo states will be available at a given point in time:
> + * it all depends on the thermal headroom of the entire package. We set it to
> + * the turbo level with 4 cores active.
> + *
> + * Benchmarks show that's a good compromise between the 1C turbo ratio
> + * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
> + * which would ignore the entire turbo range (a conspicuous part, making
> + * freq_curr/freq_max always maxed out).
> + *
> + * An exception to the heuristic above is the Atom uarch, where we choose the
> + * highest turbo level for freq_max since Atom's are generally oriented towards
> + * power efficiency.
> + *
> + * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
> + * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
> + */
> +
> +DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
>
> -       /* Don't bother re-computing within the cache threshold time. */
> -       if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> -               return true;
> +static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
> +static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
>
> -       if (!atomic_xchg(&s->scfpending, 1) || wait)
> -               smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
> +void arch_set_max_freq_ratio(bool turbo_disabled)
> +{
> +       arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
> +                                       arch_turbo_freq_ratio;
> +}
> +EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
> +
> +static bool turbo_disabled(void)
> +{
> +       u64 misc_en;
> +       int err;
>
> -       /* Return false if the previous iteration was too long ago. */
> -       return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
> +       err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> +       if (err)
> +               return false;
> +
> +       return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
>  }
>
> -unsigned int aperfmperf_get_khz(int cpu)
> +static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
>  {
> -       if (!cpu_khz)
> -               return 0;
> +       int err;
>
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return 0;
> +       err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
> +       if (err)
> +               return false;
>
> -       if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> -               return 0;
> +       err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
> +       if (err)
> +               return false;
>
> -       if (rcu_is_idle_cpu(cpu))
> -               return 0; /* Idle CPUs are completely uninteresting. */
> +       *base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
> +       *turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
>
> -       aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
> -       return per_cpu(samples.khz, cpu);
> +       return true;
>  }
>
> -void arch_freq_prepare_all(void)
> +#define X86_MATCH(model)                                       \
> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,            \
> +               INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
> +
> +static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> +       X86_MATCH(XEON_PHI_KNL),
> +       X86_MATCH(XEON_PHI_KNM),
> +       {}
> +};
> +
> +static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
> +       X86_MATCH(SKYLAKE_X),
> +       {}
> +};
> +
> +static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
> +       X86_MATCH(ATOM_GOLDMONT),
> +       X86_MATCH(ATOM_GOLDMONT_D),
> +       X86_MATCH(ATOM_GOLDMONT_PLUS),
> +       {}
> +};
> +
> +static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
> +                               int num_delta_fratio)
>  {
> -       ktime_t now = ktime_get();
> -       bool wait = false;
> -       int cpu;
> +       int fratio, delta_fratio, found;
> +       int err, i;
> +       u64 msr;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> +       if (err)
> +               return false;
> +
> +       fratio = (msr >> 8) & 0xFF;
> +       i = 16;
> +       found = 0;
> +       do {
> +               if (found >= num_delta_fratio) {
> +                       *turbo_freq = fratio;
> +                       return true;
> +               }
> +
> +               delta_fratio = (msr >> (i + 5)) & 0x7;
> +
> +               if (delta_fratio) {
> +                       found += 1;
> +                       fratio -= delta_fratio;
> +               }
>
> -       if (!cpu_khz)
> -               return;
> +               i += 8;
> +       } while (i < 64);
>
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> +       return true;
> +}
> +
> +static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
> +{
> +       u64 ratios, counts;
> +       u32 group_size;
> +       int err, i;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
> +       if (err)
> +               return false;
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
> +       if (err)
> +               return false;
> +
> +       for (i = 0; i < 64; i += 8) {
> +               group_size = (counts >> i) & 0xFF;
> +               if (group_size >= size) {
> +                       *turbo_freq = (ratios >> i) & 0xFF;
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> +{
> +       u64 msr;
> +       int err;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> +       if (err)
> +               return false;
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
> +       *turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
> +
> +       /* The CPU may have less than 4 cores */
> +       if (!*turbo_freq)
> +               *turbo_freq = msr & 0xFF;         /* 1C turbo    */
> +
> +       return true;
> +}
> +
> +static bool intel_set_max_freq_ratio(void)
> +{
> +       u64 base_freq, turbo_freq;
> +       u64 turbo_ratio;
> +
> +       if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
> +               goto out;
> +
> +       if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
> +           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> +               goto out;
> +
> +       if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
> +           knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> +               goto out;
> +
> +       if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
> +           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
> +               goto out;
> +
> +       if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
> +               goto out;
> +
> +       return false;
> +
> +out:
> +       /*
> +        * Some hypervisors advertise X86_FEATURE_APERFMPERF
> +        * but then fill all MSR's with zeroes.
> +        * Some CPUs have turbo boost but don't declare any turbo ratio
> +        * in MSR_TURBO_RATIO_LIMIT.
> +        */
> +       if (!base_freq || !turbo_freq) {
> +               pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
> +               return false;
> +       }
> +
> +       turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
> +       if (!turbo_ratio) {
> +               pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
> +               return false;
> +       }
> +
> +       arch_turbo_freq_ratio = turbo_ratio;
> +       arch_set_max_freq_ratio(turbo_disabled());
> +
> +       return true;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static struct syscore_ops freq_invariance_syscore_ops = {
> +       .resume = init_counter_refs,
> +};
> +
> +static void register_freq_invariance_syscore_ops(void)
> +{
> +       /* Bail out if registered already. */
> +       if (freq_invariance_syscore_ops.node.prev)
>                 return;
>
> -       for_each_online_cpu(cpu) {
> -               if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> -                       continue;
> -               if (rcu_is_idle_cpu(cpu))
> -                       continue; /* Idle CPUs are completely uninteresting. */
> -               if (!aperfmperf_snapshot_cpu(cpu, now, false))
> -                       wait = true;
> +       register_syscore_ops(&freq_invariance_syscore_ops);
> +}
> +#else
> +static inline void register_freq_invariance_syscore_ops(void) {}
> +#endif
> +
> +static void __init_freq_invariance(bool cppc_ready)
> +{
> +       bool ret = false;
> +
> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +               ret = intel_set_max_freq_ratio();
> +       else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> +               if (!cppc_ready)
> +                       return;
> +               ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
>         }
>
> -       if (wait)
> -               msleep(APERFMPERF_REFRESH_DELAY_MS);
> +       if (ret) {
> +               static_branch_enable(&arch_scale_freq_key);
> +               register_freq_invariance_syscore_ops();
> +               pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> +       } else {
> +               pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
> +       }
>  }
>
> -unsigned int arch_freq_get_on_cpu(int cpu)
> +static void disable_freq_invariance_workfn(struct work_struct *work)
>  {
> -       struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> +       static_branch_disable(&arch_scale_freq_key);
> +}
>
> -       if (!cpu_khz)
> -               return 0;
> +static DECLARE_WORK(disable_freq_invariance_work,
> +                   disable_freq_invariance_workfn);
>
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return 0;
> +DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>
> -       if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> -               return 0;
> +static void scale_freq_tick(u64 acnt, u64 mcnt)
> +{
> +       u64 freq_scale;
> +
> +       if (!arch_scale_freq_invariant())
> +               return;
> +
> +       if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> +               goto error;
> +
> +       if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> +               goto error;
> +
> +       freq_scale = div64_u64(acnt, mcnt);
> +       if (!freq_scale)
> +               goto error;
> +
> +       if (freq_scale > SCHED_CAPACITY_SCALE)
> +               freq_scale = SCHED_CAPACITY_SCALE;
> +
> +       this_cpu_write(arch_freq_scale, freq_scale);
> +       return;
> +
> +error:
> +       pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> +       schedule_work(&disable_freq_invariance_work);
> +}
> +#else /* CONFIG_X86_64 */
> +static inline void __init_freq_invariance(bool cppc_ready) { }
> +static inline void scale_freq_tick(u64 acnt, u64 mcnt) { }
> +#endif /* !CONFIG_X86_64 */
> +
> +void init_freq_invariance(bool secondary, bool cppc_ready)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               return;
> +
> +       init_counter_refs();
> +       if (!secondary)
> +               __init_freq_invariance(cppc_ready);
> +}
> +
> +void arch_scale_freq_tick(void)
> +{
> +       struct aperfmperf_sample *s = this_cpu_ptr(&samples);
> +       u64 acnt, mcnt, aperf, mperf;
>
> -       if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
> -               return per_cpu(samples.khz, cpu);
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               return;
> +
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +       acnt = aperf - s->aperf;
> +       mcnt = mperf - s->mperf;
>
> -       msleep(APERFMPERF_REFRESH_DELAY_MS);
> -       atomic_set(&s->scfpending, 1);
> -       smp_mb(); /* ->scfpending before smp_call_function_single(). */
> -       smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
> +       raw_write_seqcount_begin(&s->seq);
> +       s->last_update = jiffies;
> +       s->acnt = acnt;
> +       s->mcnt = mcnt;
> +       raw_write_seqcount_end(&s->seq);
> +
> +       s->aperf = aperf;
> +       s->mperf = mperf;
>
> -       return per_cpu(samples.khz, cpu);
> +       scale_freq_tick(acnt, mcnt);
>  }
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -84,7 +84,7 @@ static int show_cpuinfo(struct seq_file
>                 seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>
>         if (cpu_has(c, X86_FEATURE_TSC)) {
> -               unsigned int freq = aperfmperf_get_khz(cpu);
> +               unsigned int freq = arch_freq_get_on_cpu(cpu);
>
>                 if (!freq)
>                         freq = cpufreq_quick_get(cpu);
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -56,7 +56,6 @@
>  #include <linux/numa.h>
>  #include <linux/pgtable.h>
>  #include <linux/overflow.h>
> -#include <linux/syscore_ops.h>
>
>  #include <asm/acpi.h>
>  #include <asm/desc.h>
> @@ -1847,357 +1846,3 @@ void native_play_dead(void)
>  }
>
>  #endif
> -
> -#ifdef CONFIG_X86_64
> -/*
> - * APERF/MPERF frequency ratio computation.
> - *
> - * The scheduler wants to do frequency invariant accounting and needs a <1
> - * ratio to account for the 'current' frequency, corresponding to
> - * freq_curr / freq_max.
> - *
> - * Since the frequency freq_curr on x86 is controlled by micro-controller and
> - * our P-state setting is little more than a request/hint, we need to observe
> - * the effective frequency 'BusyMHz', i.e. the average frequency over a time
> - * interval after discarding idle time. This is given by:
> - *
> - *   BusyMHz = delta_APERF / delta_MPERF * freq_base
> - *
> - * where freq_base is the max non-turbo P-state.
> - *
> - * The freq_max term has to be set to a somewhat arbitrary value, because we
> - * can't know which turbo states will be available at a given point in time:
> - * it all depends on the thermal headroom of the entire package. We set it to
> - * the turbo level with 4 cores active.
> - *
> - * Benchmarks show that's a good compromise between the 1C turbo ratio
> - * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
> - * which would ignore the entire turbo range (a conspicuous part, making
> - * freq_curr/freq_max always maxed out).
> - *
> - * An exception to the heuristic above is the Atom uarch, where we choose the
> - * highest turbo level for freq_max since Atom's are generally oriented towards
> - * power efficiency.
> - *
> - * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
> - * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
> - */
> -
> -DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
> -
> -static DEFINE_PER_CPU(u64, arch_prev_aperf);
> -static DEFINE_PER_CPU(u64, arch_prev_mperf);
> -static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
> -static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
> -
> -void arch_set_max_freq_ratio(bool turbo_disabled)
> -{
> -       arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
> -                                       arch_turbo_freq_ratio;
> -}
> -EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
> -
> -static bool turbo_disabled(void)
> -{
> -       u64 misc_en;
> -       int err;
> -
> -       err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> -       if (err)
> -               return false;
> -
> -       return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> -}
> -
> -static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> -{
> -       int err;
> -
> -       err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
> -       if (err)
> -               return false;
> -
> -       err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
> -       *turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
> -
> -       return true;
> -}
> -
> -#define X86_MATCH(model)                                       \
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,            \
> -               INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
> -
> -static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> -       X86_MATCH(XEON_PHI_KNL),
> -       X86_MATCH(XEON_PHI_KNM),
> -       {}
> -};
> -
> -static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
> -       X86_MATCH(SKYLAKE_X),
> -       {}
> -};
> -
> -static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
> -       X86_MATCH(ATOM_GOLDMONT),
> -       X86_MATCH(ATOM_GOLDMONT_D),
> -       X86_MATCH(ATOM_GOLDMONT_PLUS),
> -       {}
> -};
> -
> -static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
> -                               int num_delta_fratio)
> -{
> -       int fratio, delta_fratio, found;
> -       int err, i;
> -       u64 msr;
> -
> -       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> -       if (err)
> -               return false;
> -
> -       fratio = (msr >> 8) & 0xFF;
> -       i = 16;
> -       found = 0;
> -       do {
> -               if (found >= num_delta_fratio) {
> -                       *turbo_freq = fratio;
> -                       return true;
> -               }
> -
> -               delta_fratio = (msr >> (i + 5)) & 0x7;
> -
> -               if (delta_fratio) {
> -                       found += 1;
> -                       fratio -= delta_fratio;
> -               }
> -
> -               i += 8;
> -       } while (i < 64);
> -
> -       return true;
> -}
> -
> -static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
> -{
> -       u64 ratios, counts;
> -       u32 group_size;
> -       int err, i;
> -
> -       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
> -       if (err)
> -               return false;
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
> -       if (err)
> -               return false;
> -
> -       for (i = 0; i < 64; i += 8) {
> -               group_size = (counts >> i) & 0xFF;
> -               if (group_size >= size) {
> -                       *turbo_freq = (ratios >> i) & 0xFF;
> -                       return true;
> -               }
> -       }
> -
> -       return false;
> -}
> -
> -static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> -{
> -       u64 msr;
> -       int err;
> -
> -       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> -       if (err)
> -               return false;
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
> -       *turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
> -
> -       /* The CPU may have less than 4 cores */
> -       if (!*turbo_freq)
> -               *turbo_freq = msr & 0xFF;         /* 1C turbo    */
> -
> -       return true;
> -}
> -
> -static bool intel_set_max_freq_ratio(void)
> -{
> -       u64 base_freq, turbo_freq;
> -       u64 turbo_ratio;
> -
> -       if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
> -               goto out;
> -
> -       if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
> -           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> -               goto out;
> -
> -       if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
> -           knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> -               goto out;
> -
> -       if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
> -           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
> -               goto out;
> -
> -       if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
> -               goto out;
> -
> -       return false;
> -
> -out:
> -       /*
> -        * Some hypervisors advertise X86_FEATURE_APERFMPERF
> -        * but then fill all MSR's with zeroes.
> -        * Some CPUs have turbo boost but don't declare any turbo ratio
> -        * in MSR_TURBO_RATIO_LIMIT.
> -        */
> -       if (!base_freq || !turbo_freq) {
> -               pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
> -               return false;
> -       }
> -
> -       turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
> -       if (!turbo_ratio) {
> -               pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
> -               return false;
> -       }
> -
> -       arch_turbo_freq_ratio = turbo_ratio;
> -       arch_set_max_freq_ratio(turbo_disabled());
> -
> -       return true;
> -}
> -
> -static void init_counter_refs(void)
> -{
> -       u64 aperf, mperf;
> -
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -       this_cpu_write(arch_prev_aperf, aperf);
> -       this_cpu_write(arch_prev_mperf, mperf);
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static struct syscore_ops freq_invariance_syscore_ops = {
> -       .resume = init_counter_refs,
> -};
> -
> -static void register_freq_invariance_syscore_ops(void)
> -{
> -       /* Bail out if registered already. */
> -       if (freq_invariance_syscore_ops.node.prev)
> -               return;
> -
> -       register_syscore_ops(&freq_invariance_syscore_ops);
> -}
> -#else
> -static inline void register_freq_invariance_syscore_ops(void) {}
> -#endif
> -
> -void init_freq_invariance(bool secondary, bool cppc_ready)
> -{
> -       bool ret = false;
> -
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return;
> -
> -       if (secondary) {
> -               if (static_branch_likely(&arch_scale_freq_key)) {
> -                       init_counter_refs();
> -               }
> -               return;
> -       }
> -
> -       if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> -               ret = intel_set_max_freq_ratio();
> -       else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> -               if (!cppc_ready) {
> -                       return;
> -               }
> -               ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
> -       }
> -
> -       if (ret) {
> -               init_counter_refs();
> -               static_branch_enable(&arch_scale_freq_key);
> -               register_freq_invariance_syscore_ops();
> -               pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> -       } else {
> -               pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
> -       }
> -}
> -
> -static void disable_freq_invariance_workfn(struct work_struct *work)
> -{
> -       static_branch_disable(&arch_scale_freq_key);
> -}
> -
> -static DECLARE_WORK(disable_freq_invariance_work,
> -                   disable_freq_invariance_workfn);
> -
> -DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
> -
> -void arch_scale_freq_tick(void)
> -{
> -       u64 freq_scale;
> -       u64 aperf, mperf;
> -       u64 acnt, mcnt;
> -
> -       if (!arch_scale_freq_invariant())
> -               return;
> -
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -       acnt = aperf - this_cpu_read(arch_prev_aperf);
> -       mcnt = mperf - this_cpu_read(arch_prev_mperf);
> -
> -       this_cpu_write(arch_prev_aperf, aperf);
> -       this_cpu_write(arch_prev_mperf, mperf);
> -
> -       if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> -               goto error;
> -
> -       if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> -               goto error;
> -
> -       freq_scale = div64_u64(acnt, mcnt);
> -       if (!freq_scale)
> -               goto error;
> -
> -       if (freq_scale > SCHED_CAPACITY_SCALE)
> -               freq_scale = SCHED_CAPACITY_SCALE;
> -
> -       this_cpu_write(arch_freq_scale, freq_scale);
> -       return;
> -
> -error:
> -       pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> -       schedule_work(&disable_freq_invariance_work);
> -}
> -#endif /* CONFIG_X86_64 */
> --- a/fs/proc/cpuinfo.c
> +++ b/fs/proc/cpuinfo.c
> @@ -5,14 +5,10 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>
> -__weak void arch_freq_prepare_all(void)
> -{
> -}
> -
>  extern const struct seq_operations cpuinfo_op;
> +
>  static int cpuinfo_open(struct inode *inode, struct file *file)
>  {
> -       arch_freq_prepare_all();
>         return seq_open(file, &cpuinfo_op);
>  }
>
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1199,7 +1199,6 @@ static inline void sched_cpufreq_governo
>                         struct cpufreq_governor *old_gov) { }
>  #endif
>
> -extern void arch_freq_prepare_all(void);
>  extern unsigned int arch_freq_get_on_cpu(int cpu);
>
>  #ifndef arch_set_freq_scale
>
