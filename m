Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B450730C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354674AbiDSQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbiDSQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:38:33 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5989113DF3;
        Tue, 19 Apr 2022 09:35:49 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ec04a2ebadso178342667b3.12;
        Tue, 19 Apr 2022 09:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqDfnR/pNAXrnStMMgvKfK9Y55MNdDB4d+D1vHAYIyA=;
        b=2XruMW5wrSIfYcPoq5ggevIKVPu/mBfg0Wnp1509B7EXZ+UjuvH1YBT9mPM6yE0WZp
         P4JfiHx81Thw9H9OUbYUHuK8UIcrzOZclXHIzRxucgpzG2BxWBLvcrfZxAeqriQbx91k
         a3mPt91vpM28tZzpLv9ytty8ZV1+97JTwYa5FyUERKpXW1blYOPj9JVqgtONz8YGI8Io
         z2zlcdfoqTdyxSH5/xFDV5e3xLo2RcirjqETJzr86gy1+GTpP2cF5shDoRr9eKLfHmna
         Z8AJvqzKW3p5PH0pGVRPCpQ/qnmZeOTAdzSSY149BZFFf0oZPFZXUUNbcIxTc/DWsHyR
         ydkw==
X-Gm-Message-State: AOAM532ECNeHC/XiwwkWYsXX5sGVv/W3Xjla8Vsw3N53fyp8sIsnBtDj
        e1ZX/+If6xKM2MzxugTgn/AUVWuyfOXo62Mg7bQ=
X-Google-Smtp-Source: ABdhPJx4cWugEiiEec2p2iEDm1GKjX/IBflN9UpYPYEO5F3KboW/VLONE0phoyTe/h/Dps2Ogy7H4mbth+2oA19tzqE=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr16726449ywa.19.1650386148582; Tue, 19
 Apr 2022 09:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.875029458@linutronix.de>
In-Reply-To: <20220415161206.875029458@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:35:37 +0200
Message-ID: <CAJZ5v0jcS8p1aKfW=W05-+Zo=MytwyxOCCO+Fq-WfNhkW7804w@mail.gmail.com>
Subject: Re: [patch 09/10] x86/aperfmperf: Replace aperfmperf_get_khz()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The frequency invariance infrastructure provides the APERF/MPERF samples
> already. Utilize them for the cpu frequency display in /proc/cpuinfo.
>
> The sample is considered valid for 20ms. So for idle or isolated NOHZ full
> CPUs the function returns 0, which is matching the previous behaviour.
>
> This gets rid of the mass IPIs and a delay of 20ms for stabilizing observed
> by Eric when reading /proc/cpuinfo.
>
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

All fine IMV, one minor nit below.


Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |   77 +++++++++++++++++----------------------
>  fs/proc/cpuinfo.c                |    6 ---
>  include/linux/cpufreq.h          |    1
>  3 files changed, 35 insertions(+), 49 deletions(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -100,49 +100,6 @@ static bool aperfmperf_snapshot_cpu(int
>         return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
>  }
>
> -unsigned int aperfmperf_get_khz(int cpu)
> -{
> -       if (!cpu_khz)
> -               return 0;
> -
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return 0;
> -
> -       if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> -               return 0;
> -
> -       if (rcu_is_idle_cpu(cpu))
> -               return 0; /* Idle CPUs are completely uninteresting. */
> -
> -       aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
> -       return per_cpu(samples.khz, cpu);
> -}
> -
> -void arch_freq_prepare_all(void)
> -{
> -       ktime_t now = ktime_get();
> -       bool wait = false;
> -       int cpu;
> -
> -       if (!cpu_khz)
> -               return;
> -
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return;
> -
> -       for_each_online_cpu(cpu) {
> -               if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> -                       continue;
> -               if (rcu_is_idle_cpu(cpu))
> -                       continue; /* Idle CPUs are completely uninteresting. */
> -               if (!aperfmperf_snapshot_cpu(cpu, now, false))
> -                       wait = true;
> -       }
> -
> -       if (wait)
> -               msleep(APERFMPERF_REFRESH_DELAY_MS);
> -}
> -
>  unsigned int arch_freq_get_on_cpu(int cpu)
>  {
>         struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> @@ -529,6 +486,40 @@ void arch_scale_freq_tick(void)
>         scale_freq_tick(acnt, mcnt);
>  }
>
> +/*
> + * Discard samples older than the define maximum sample age of 20ms. There
> + * is no point in sending IPIs in such a case. If the scheduler tick was
> + * not running then the CPU is either idle or isolated.
> + */
> +#define MAX_SAMPLE_AGE ((unsigned long)HZ / 50)
> +
> +unsigned int aperfmperf_get_khz(int cpu)
> +{
> +       struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
> +       unsigned long last;
> +       unsigned int seq;
> +       u64 acnt, mcnt;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               return 0;
> +
> +       do {
> +               seq = raw_read_seqcount_begin(&s->seq);
> +               last = s->last_update;
> +               acnt = s->acnt;
> +               mcnt = s->mcnt;
> +       } while (read_seqcount_retry(&s->seq, seq));
> +
> +       /*
> +        * Bail on invalid count and when the last update was too long ago,
> +        * which covers idle and NOHZ full CPUs.
> +        */
> +       if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)

The inner parens are not needed here.

> +               return 0;
> +
> +       return div64_u64((cpu_khz * acnt), mcnt);
> +}
> +
>  static int __init bp_init_aperfmperf(void)
>  {
>         if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
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
