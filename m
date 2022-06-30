Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3F56262D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiF3WhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiF3WhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D81EEF4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BC0C62433
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1DDC34115;
        Thu, 30 Jun 2022 22:37:12 +0000 (UTC)
Date:   Thu, 30 Jun 2022 18:37:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Message-ID: <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624074240.13108-1-quic_satyap@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:42:40AM -0700, Satya Durga Srinivasu Prabhala wrote:
> Below recursion is observed in a rare scenario where __schedule()
> takes rq lock, at around same time task's affinity is being changed,
> bpf function for tracing sched_switch calls migrate_enabled(),
> checks for affinity change (cpus_ptr != cpus_mask) lands into
> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
> recursion bug.
> 
> Fix the issue by switching to preempt_enable/disable() for non-RT
> Kernels.
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

trace_sched_switch() disables preemption.

So how is this a fix?

-- Steve

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
