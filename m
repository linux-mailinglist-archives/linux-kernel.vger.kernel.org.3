Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B158E5625A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiF3VxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiF3VxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:53:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17EF1DEBF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:53:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC511042;
        Thu, 30 Jun 2022 14:53:17 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE56C3F792;
        Thu, 30 Jun 2022 14:53:15 -0700 (PDT)
Date:   Thu, 30 Jun 2022 22:53:10 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Message-ID: <20220630215310.wb3kab72tlh5pq2g@airbuntu>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624074240.13108-1-quic_satyap@quicinc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya

On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
> Below recursion is observed in a rare scenario where __schedule()
> takes rq lock, at around same time task's affinity is being changed,
> bpf function for tracing sched_switch calls migrate_enabled(),
> checks for affinity change (cpus_ptr != cpus_mask) lands into
> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
> recursion bug.
> 
> Fix the issue by switching to preempt_enable/disable() for non-RT
> Kernels.

Interesting bug. Thanks for the report. Unfortunately I can't see this being
a fix as it just limits the bug visibility to PREEMPT_RT kernels, but won't fix
anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this failure.

I'm curious how the race with set affinity is happening. I would have thought
user space would get blocked as __schedule() will hold the rq lock.

Do you have more details on that?


Thanks

--
Qais Yousef

> 
> -010 |spin_bug(lock = ???, msg = ???)
> -011 |debug_spin_lock_before(inline)
> -011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
> -012 |_raw_spin_lock(inline)
> -012 |raw_spin_rq_lock_nested(inline)
> -012 |raw_spin_rq_lock(inline)
> -012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
> -013 |__set_cpus_allowed_ptr(inline)
> -013 |migrate_enable()
> -014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
> -015 |perf_trace_run_bpf_submit(inline)
> -015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
> -016 |__traceiter_sched_switch(inline)
> -016 |trace_sched_switch(inline)
> -016 |__schedule(sched_mode = ?)
> -017 |schedule()
> -018 |arch_local_save_flags(inline)
> -018 |arch_irqs_disabled(inline)
> -018 |__raw_spin_lock_irq(inline)
> -018 |_raw_spin_lock_irq(inline)
> -018 |worker_thread(__worker = 0xFFFFFF88CE251300)
> -019 |kthread(_create = 0xFFFFFF88730A5A80)
> -020 |ret_from_fork(asm)
> 
> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> ---
>  kernel/sched/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bfa7452ca92e..e254e9227341 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2223,6 +2223,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
>  
>  void migrate_disable(void)
>  {
> +#ifdef CONFIG_PREEMPT_RT
>  	struct task_struct *p = current;
>  
>  	if (p->migration_disabled) {
> @@ -2234,11 +2235,15 @@ void migrate_disable(void)
>  	this_rq()->nr_pinned++;
>  	p->migration_disabled = 1;
>  	preempt_enable();
> +#else
> +	preempt_disable();
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(migrate_disable);
>  
>  void migrate_enable(void)
>  {
> +#ifdef CONFIG_PREEMPT_RT
>  	struct task_struct *p = current;
>  
>  	if (p->migration_disabled > 1) {
> @@ -2265,6 +2270,9 @@ void migrate_enable(void)
>  	p->migration_disabled = 0;
>  	this_rq()->nr_pinned--;
>  	preempt_enable();
> +#else
> +	preempt_enable();
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(migrate_enable);
>  
> -- 
> 2.36.1
> 
