Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3364CDCF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbiCDSu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiCDSuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:50:52 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C591D67D5;
        Fri,  4 Mar 2022 10:50:03 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id h126so18690533ybc.1;
        Fri, 04 Mar 2022 10:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvqqlVr/YQITu7u50LqWLmieFHnyyZi+SHyI1hapU84=;
        b=c9AR+A+p5SvUN8sgNp6WgzDthHV0pwfCK1jMjU0gAcMDFPcq2a8ls2Hp5oieu0qBE6
         Mrv9c8Sx1JTGlV3dJXlkAOTjWGpsd3YtB50ciVsgu6s1JwceOC2ngfhA7yeHu7B4F+DH
         /s7FTS5W9pwQwQmsxzCA1k5oTfEnrZSCoDFweDRJOjtoTZFBk+iS+qHCg2BZL1yO40PZ
         SuLNnXDp28+CwkZY6xrasWHfF08Vz7RrRmzFb7FA1tGjQ7cBUBLUPVSMkDw3WZXQz//V
         TmZVv2OFntLyXINkq45WyHEdJf6Gqi/bc9/9mXcKGlBsjH7oVBWS9vAxXR1TxSn4l5v6
         tKjA==
X-Gm-Message-State: AOAM533nhOkqkFw5KbgukYl04kVmF9X8rbOaS1krV6klpHhEE7hXxxbC
        aXS4yJf6aHq7ME3AkPwZNfM/SbathteUFNhgSgYHIgZN
X-Google-Smtp-Source: ABdhPJxGTHPRWy6Q9TvfZ4aUSFbo2Bi8AdxAYVFWVlx4+J1ngxxX7zWKxmRbNs1qaHXmtBWcjqssc+8cT4fjVGAfOzY=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr37568145ybe.365.1646419802788; Fri, 04
 Mar 2022 10:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20220304060724.314582-1-Jinzhou.Su@amd.com> <20220304060724.314582-2-Jinzhou.Su@amd.com>
 <YiG0uqa+Ho7XyuHJ@amd.com>
In-Reply-To: <YiG0uqa+Ho7XyuHJ@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Mar 2022 19:49:51 +0100
Message-ID: <CAJZ5v0jG2uodQGrWv01xLcDLgdU1MRs5vyJ5s+E4L0U4-GuR0g@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
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

On Fri, Mar 4, 2022 at 7:42 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Fri, Mar 04, 2022 at 02:07:21PM +0800, Su, Jinzhou (Joe) wrote:
> > Add frequency, mperf, aperf and tsc in the trace. This can be used
> > to debug and tune the performance of AMD P-state driver.
> >
> > Use the time difference between amd_pstate_update to calculate CPU
> > frequency. There could be sleep in arch_freq_get_on_cpu, so do not
> > use it here.
> >
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Co-developed-by: Huang Rui <ray.huang@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
>
> Let's remove "Signed-off-by" of me, just leave "Co-developed-by".

Actually, they both need to be present (the C-d-b clarifies the S-o-b
meaning), so the above is correct.

>
> > ---
> >  drivers/cpufreq/amd-pstate-trace.h | 22 ++++++++++-
> >  drivers/cpufreq/amd-pstate.c       | 59 +++++++++++++++++++++++++++++-
> >  2 files changed, 78 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> > index 647505957d4f..35f38ae67fb1 100644
> > --- a/drivers/cpufreq/amd-pstate-trace.h
> > +++ b/drivers/cpufreq/amd-pstate-trace.h
> > @@ -27,6 +27,10 @@ TRACE_EVENT(amd_pstate_perf,
> >       TP_PROTO(unsigned long min_perf,
> >                unsigned long target_perf,
> >                unsigned long capacity,
> > +              u64 freq,
> > +              u64 mperf,
> > +              u64 aperf,
> > +              u64 tsc,
> >                unsigned int cpu_id,
> >                bool changed,
> >                bool fast_switch
> > @@ -35,6 +39,10 @@ TRACE_EVENT(amd_pstate_perf,
> >       TP_ARGS(min_perf,
> >               target_perf,
> >               capacity,
> > +             freq,
> > +             mperf,
> > +             aperf,
> > +             tsc,
> >               cpu_id,
> >               changed,
> >               fast_switch
> > @@ -44,6 +52,10 @@ TRACE_EVENT(amd_pstate_perf,
> >               __field(unsigned long, min_perf)
> >               __field(unsigned long, target_perf)
> >               __field(unsigned long, capacity)
> > +             __field(unsigned long long, freq)
> > +             __field(unsigned long long, mperf)
> > +             __field(unsigned long long, aperf)
> > +             __field(unsigned long long, tsc)
> >               __field(unsigned int, cpu_id)
> >               __field(bool, changed)
> >               __field(bool, fast_switch)
> > @@ -53,15 +65,23 @@ TRACE_EVENT(amd_pstate_perf,
> >               __entry->min_perf = min_perf;
> >               __entry->target_perf = target_perf;
> >               __entry->capacity = capacity;
> > +             __entry->freq = freq;
> > +             __entry->mperf = mperf;
> > +             __entry->aperf = aperf;
> > +             __entry->tsc = tsc;
> >               __entry->cpu_id = cpu_id;
> >               __entry->changed = changed;
> >               __entry->fast_switch = fast_switch;
> >               ),
> >
> > -     TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
> > +     TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
> >                 (unsigned long)__entry->min_perf,
> >                 (unsigned long)__entry->target_perf,
> >                 (unsigned long)__entry->capacity,
> > +               (unsigned long long)__entry->freq,
> > +               (unsigned long long)__entry->mperf,
> > +               (unsigned long long)__entry->aperf,
> > +               (unsigned long long)__entry->tsc,
> >                 (unsigned int)__entry->cpu_id,
> >                 (__entry->changed) ? "true" : "false",
> >                 (__entry->fast_switch) ? "true" : "false"
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 9ce75ed11f8e..7be38bc6a673 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -65,6 +65,18 @@ MODULE_PARM_DESC(shared_mem,
> >
> >  static struct cpufreq_driver amd_pstate_driver;
> >
> > +/**
> > + * struct  amd_aperf_mperf
> > + * @aperf: actual performance frequency clock count
> > + * @mperf: maximum performance frequency clock count
> > + * @tsc:   time stamp counter
> > + */
> > +struct amd_aperf_mperf {
> > +     u64 aperf;
> > +     u64 mperf;
> > +     u64 tsc;
> > +};
> > +
> >  /**
> >   * struct amd_cpudata - private CPU data for AMD P-State
> >   * @cpu: CPU number
> > @@ -81,6 +93,9 @@ static struct cpufreq_driver amd_pstate_driver;
> >   * @min_freq: the frequency that mapped to lowest_perf
> >   * @nominal_freq: the frequency that mapped to nominal_perf
> >   * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
> > + * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> > + * @prev: Last Aperf/Mperf/tsc count value read from register
> > + * @freq: current cpu frequency value
> >   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> >   *
> >   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
> > @@ -102,6 +117,10 @@ struct amd_cpudata {
> >       u32     nominal_freq;
> >       u32     lowest_nonlinear_freq;
> >
> > +     struct amd_aperf_mperf cur;
> > +     struct amd_aperf_mperf prev;
> > +
> > +     u64 freq;
> >       bool    boost_supported;
> >  };
> >
> > @@ -211,6 +230,39 @@ static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> >                                           max_perf, fast_switch);
> >  }
> >
> > +static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
> > +{
> > +     u64 aperf, mperf, tsc;
> > +     unsigned long flags;
> > +
> > +     local_irq_save(flags);
> > +     rdmsrl(MSR_IA32_APERF, aperf);
> > +     rdmsrl(MSR_IA32_MPERF, mperf);
> > +     tsc = rdtsc();
> > +
> > +     if (cpudata->prev.mperf == mperf || cpudata->prev.tsc == tsc) {
> > +             local_irq_restore(flags);
> > +             return false;
> > +     }
> > +
> > +     local_irq_restore(flags);
> > +
> > +     cpudata->cur.aperf = aperf;
> > +     cpudata->cur.mperf = mperf;
> > +     cpudata->cur.tsc =  tsc;
> > +     cpudata->cur.aperf -= cpudata->prev.aperf;
> > +     cpudata->cur.mperf -= cpudata->prev.mperf;
> > +     cpudata->cur.tsc -= cpudata->prev.tsc;
> > +
> > +     cpudata->prev.aperf = aperf;
> > +     cpudata->prev.mperf = mperf;
> > +     cpudata->prev.tsc = tsc;
> > +
> > +     cpudata->freq = div64_u64((cpudata->cur.aperf * cpu_khz), cpudata->cur.mperf);
> > +
> > +     return true;
> > +}
> > +
> >  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> >                             u32 des_perf, u32 max_perf, bool fast_switch)
> >  {
> > @@ -226,8 +278,11 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> >       value &= ~AMD_CPPC_MAX_PERF(~0L);
> >       value |= AMD_CPPC_MAX_PERF(max_perf);
> >
> > -     trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> > -                           cpudata->cpu, (value != prev), fast_switch);
> > +     if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
> > +             trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> > +                     cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
> > +                             cpudata->cpu, (value != prev), fast_switch);
>
> How about using struct amd_aperf_mperf pointer as one input:
>
> trace_amd_pstate_perf(min_perf, des_perf, max_perf, &cpudata->cur, ...);
>
> You can refer the members of struct amd_aperf_mperf in the
> amd-pstate-trace.h:
>
>         __entry->mperf = cur->mperf;
>         __entry->aperf = cur->aperf;
>         __entry->tsc = cur->tsc;
>
> Thanks,
> Ray
