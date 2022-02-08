Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D84AD99B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358273AbiBHNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiBHNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:00:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F41C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:00:55 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p15so52040002ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sgE/xQ/+9cclDjXn3p9Poq5b+nUiXr8NosRhKU1WPOI=;
        b=u0NGyojcfUrrXm7SA9UB6FvjZCVTK2c3+k5JX8hnf13T0wAr7bHay4EuWIGxlqc7ht
         URWuXbXGijtB2CErJs54bRz+VolKQ5aI7p43JPRRALiy2RBrGmRD07kYrmVIPqkN5b3B
         qNVBR2AZlI4KTqy7Zyjsw7P3f9Tj6tNVhg2zZsQgUdWXOuUTyA8Cuv9UfzQOOGNUKap5
         QHJ3coUKIzh13R9l5RWmisTrOhGrpst/lqjT5tf8Wpqy5wSALdEJNIyMJoYkrOjLBhA8
         gAq0kwPTEbUNFLUTiCVxLit9RYIbDVVLXvceQWiAE/lHjj51dKDFtVvZrgnsqJxDTHxb
         tZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sgE/xQ/+9cclDjXn3p9Poq5b+nUiXr8NosRhKU1WPOI=;
        b=fpaDPdXbxDNQvqUuKomBcHz9TNp+XwgUxk8aI/LXhCFDtfQlsHshTTellab9Bqasbw
         XitAe68XJJDwFuWDlKBieTvNVclpcrp+WTiEMd5nTJ25GYad6jUf8jaEo6yP1e7ODEp7
         V4CRSzrp/0a+dAVyogNBx/l+nmClCeJyY3TmHLof9HMBvJs9ftKrpp3+yf/GdgTn/S91
         x5x069pINNgn1nyDGAf1riMedr9EN4HOJAblfnW76m75L78JZd/VQ1G6d4yiLX3/XLAg
         jXp149EuE0wCjSHCH16fvoqzn947Xt4iForV2EEqSeddrcOnvG2AzkERBPRx2FN4ViJN
         n9DQ==
X-Gm-Message-State: AOAM530TPRkEwb3YfzhLJ14GLgIe0Nhj5dwyfTEmQUQx6xsGVLNukxX9
        GesoN2Bf59lnpz63tnogXPMyPg==
X-Google-Smtp-Source: ABdhPJx0Xa0/oSNN61iMZmiZDaLdK5fU7sB6YAOngEbNBgD+TUspwhEFssy+nEbHiA9adB0tdhR3eQ==
X-Received: by 2002:a17:907:6d1e:: with SMTP id sa30mr2000503ejc.24.1644325253383;
        Tue, 08 Feb 2022 05:00:53 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.65])
        by smtp.gmail.com with ESMTPSA id z2sm3032818ejr.68.2022.02.08.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:00:52 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:00:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
Message-ID: <20220208130047.GA273989@leoy-ThinkPad-X240s>
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220205153940.GB391033@leoy-ThinkPad-X240s>
 <4d5951ee-d7d2-1e76-eb24-5f3c46d1662c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d5951ee-d7d2-1e76-eb24-5f3c46d1662c@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Mon, Feb 07, 2022 at 12:06:14PM +0000, German Gomez wrote:

[...]

> > I reviewed the code and also traced the backtrace for the function
> > arm_spe_pmu_start(), I can confirm that every time perf session will
> > execute below flow:
> >
> >   evlist__enable()
> >     __evlist__enable()
> >       evlist__for_each_cpu() {  -> call affinity__set()
> >         evsel__enable_cpu()
> >       }
> >
> > We can see the macro evlist__for_each_cpu() will extend to invoke
> > evlist__cpu_begin() and affinity__set(); affinity__set() will set CPU
> > affinity to the target CPU, thus perf process will firstly migrate to
> > the target CPU and enable event on the target CPU.  This means perf
> > will not send remote IPI and it directly runs on target CPU, and the
> > dd program will not interfere capabilities for perf session.
>
> Thank you for looking at this,
> 
> I re-tested on the N1SDP (previously I was using a graviton2 instance).
> I had to adjust the command slightly with "-m,2" to get it consistently
> this time:
> 
> $ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
> $ perf record -e arm_spe_0// -C0 -m,2 -- sleep 1
> $ perf report -D | grep CONTEXT | head
> .  0000000e:  65 b5 6e 00 00                                  CONTEXT 0x6eb5 el2
> .  0000004e:  65 b5 6e 00 00                                  CONTEXT 0x6eb5 el2
> .  0000008e:  65 b5 6e 00 00                                  CONTEXT 0x6eb5 el2
> [...]

Indeed!  I can reproduce the issue now.  And I can capture backtrace
for arm_spe_pmu_start() with below commands:

# cd /home/leoy/linux/tools/perf
# ./perf probe --add "arm_spe_pmu_start" -s /home/leoy/linux/ -k /home/leoy/linux/vmlinux
# echo 1 > /sys/kernel/debug/tracing/events/probe/arm_spe_pmu_start/enable
# echo stacktrace > /sys/kernel/debug/tracing/events/probe/arm_spe_pmu_start/trigger

... run your commands with non-root user ...

# cat /sys/kernel/debug/tracing/trace

             dd-7697    [000] d.h2.   506.068700: arm_spe_pmu_start: (arm_spe_pmu_start+0x8/0xe0)
             dd-7697    [000] d.h3.   506.068701: <stack trace>
=> kprobe_dispatcher
=> kprobe_breakpoint_handler
=> call_break_hook
=> brk_handler
=> do_debug_exception
=> el1_dbg
=> el1h_64_sync_handler
=> el1h_64_sync
=> arm_spe_pmu_start
=> event_sched_in.isra.0
=> merge_sched_in
=> visit_groups_merge.constprop.0
=> ctx_sched_in
=> perf_event_sched_in
=> ctx_resched
=> __perf_event_enable
=> event_function
=> remote_function
=> flush_smp_call_function_queue
=> generic_smp_call_function_single_interrupt
=> ipi_handler
=> handle_percpu_devid_irq
=> generic_handle_domain_irq
=> gic_handle_irq
=> call_on_irq_stack
=> do_interrupt_handler
=> el1_interrupt
=> el1h_64_irq_handler
=> el1h_64_irq
=> _raw_spin_unlock_irqrestore
=> urandom_read_nowarn.isra.0
=> random_read
=> vfs_read
=> ksys_read
=> __arm64_sys_read
=> invoke_syscall
=> el0_svc_common.constprop.0
=> do_el0_svc
=> el0_svc
=> el0t_64_sync_handler
=> el0t_64_sync

The backtrace clearly shows the function arm_spe_pmu_start() is
invoked in the 'dd' process (dd-7697); the flow is:
- perf program sends IPI to CPU0;
- 'dd' process is running on CPU0 and it's interrupted to handle IPI;
- 'dd' process has root capabilities, so it will enable context
  tracing for non-root perf session.

> >> One way to fix this is by caching the value of the CX bit during the
> >> initialization of the PMU event, so that it remains consistent for the
> >> duration of the session.
> >>
> >> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n275
> >> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n713
> >> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n751
> >>
> >> Signed-off-by: German Gomez <german.gomez@arm.com>
> >> ---
> >>  drivers/perf/arm_spe_pmu.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> >> index d44bcc29d..8515bf85c 100644
> >> --- a/drivers/perf/arm_spe_pmu.c
> >> +++ b/drivers/perf/arm_spe_pmu.c
> >> @@ -57,6 +57,7 @@ struct arm_spe_pmu {
> >>  	u16					pmsver;
> >>  	u16					min_period;
> >>  	u16					counter_sz;
> >> +	bool					pmscr_cx;

So the patch makes sense to me.  Just a minor comment:

Here we can define a u64 for recording pmscr value rather than a
bool value.

struct arm_spe_pmu {
    ...
    u64 pmscr;
};

> >>  
> >>  #define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
> >>  #define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
> >> @@ -260,6 +261,7 @@ static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
> >>  static u64 arm_spe_event_to_pmscr(struct perf_event *event)
> >>  {
> >>  	struct perf_event_attr *attr = &event->attr;
> >> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> >>  	u64 reg = 0;
> >>  
> >>  	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << SYS_PMSCR_EL1_TS_SHIFT;
> >> @@ -272,7 +274,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
> >>  	if (!attr->exclude_kernel)
> >>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
> >>  
> >> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> >> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && spe_pmu->pmscr_cx)
> >>  		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
> >>  
> >>  	return reg;
> >> @@ -709,10 +711,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
> >>  	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> >>  		return -EOPNOTSUPP;
> >>  
> >> +	spe_pmu->pmscr_cx = perfmon_capable();
> >>  	reg = arm_spe_event_to_pmscr(event);

Thus here we can change as:

  spe_pmu->pmscr = arm_spe_event_to_pmscr(event);

And then in the function arm_spe_pmu_start(), we can skip calling
arm_spe_event_to_pmscr() and directly set PMSCR register:

static void arm_spe_pmu_start(struct perf_event *event, int flags)
{
    ...

    isb();
    write_sysreg_s(spe_pmu->pmscr, SYS_PMSCR_EL1);
}

Thanks,
Leo

> >>  	if (!perfmon_capable() &&
> >>  	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
> >> -		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
> >>  		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
> >>  		return -EACCES;
> >>  
> >> -- 
> >> 2.25.1
> >>
