Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934455144DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356162AbiD2I4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355948AbiD2I4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:56:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EBD8C44E8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:52:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC55211FB;
        Fri, 29 Apr 2022 01:52:43 -0700 (PDT)
Received: from wubuntu (unknown [10.57.75.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8DB43F73B;
        Fri, 29 Apr 2022 01:52:42 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:52:40 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Phil Auld <pauld@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/fair: Remove sched_trace_*() helper functions
Message-ID: <20220429085240.akxmdnc3a2s6rq7b@wubuntu>
References: <20220428144338.479094-1-qais.yousef@arm.com>
 <20220428144338.479094-2-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428144338.479094-2-qais.yousef@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC lkml

On 04/28/22 15:43, Qais Yousef wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> We no longer need them as we can use DWARF debug info or BTF + pahole to
> re-generate the required structs to compile against them for a given
> kernel.
> 
> This moves the burden of maintaining these helper functions to the
> module.
> 
> 	https://github.com/qais-yousef/sched_tp
> 
> Note that pahole v1.15 is required at least for using DWARF. And for BTF
> v1.23 which is not yet released will be required. There's alignment
> problem that will lead to crashes in earlier versions when used with
> BTF.
> 
> We should have enough infrastructure to make these helper functions now
> obsolete, so remove them.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [Rewrote commit message to reflect the new alternative]
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  include/linux/sched.h | 14 -------
>  kernel/sched/fair.c   | 98 -------------------------------------------
>  2 files changed, 112 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 67f06f72c50e..fc74ea2578b7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2378,20 +2378,6 @@ static inline void rseq_syscall(struct pt_regs *regs)
>  
>  #endif
>  
> -const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
> -char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
> -int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
> -
> -const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq);
> -const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
> -const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
> -
> -int sched_trace_rq_cpu(struct rq *rq);
> -int sched_trace_rq_cpu_capacity(struct rq *rq);
> -int sched_trace_rq_nr_running(struct rq *rq);
> -
> -const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
> -
>  #ifdef CONFIG_SCHED_CORE
>  extern void sched_core_free(struct task_struct *tsk);
>  extern void sched_core_fork(struct task_struct *p);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4c420124b5d6..ff1177a4a286 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11882,101 +11882,3 @@ __init void init_sched_fair_class(void)
>  #endif /* SMP */
>  
>  }
> -
> -/*
> - * Helper functions to facilitate extracting info from tracepoints.
> - */
> -
> -const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq)
> -{
> -#ifdef CONFIG_SMP
> -	return cfs_rq ? &cfs_rq->avg : NULL;
> -#else
> -	return NULL;
> -#endif
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_avg);
> -
> -char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len)
> -{
> -	if (!cfs_rq) {
> -		if (str)
> -			strlcpy(str, "(null)", len);
> -		else
> -			return NULL;
> -	}
> -
> -	cfs_rq_tg_path(cfs_rq, str, len);
> -	return str;
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_path);
> -
> -int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq)
> -{
> -	return cfs_rq ? cpu_of(rq_of(cfs_rq)) : -1;
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_cpu);
> -
> -const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq)
> -{
> -#ifdef CONFIG_SMP
> -	return rq ? &rq->avg_rt : NULL;
> -#else
> -	return NULL;
> -#endif
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rq_avg_rt);
> -
> -const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq)
> -{
> -#ifdef CONFIG_SMP
> -	return rq ? &rq->avg_dl : NULL;
> -#else
> -	return NULL;
> -#endif
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rq_avg_dl);
> -
> -const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq)
> -{
> -#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_SCHED_AVG_IRQ)
> -	return rq ? &rq->avg_irq : NULL;
> -#else
> -	return NULL;
> -#endif
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rq_avg_irq);
> -
> -int sched_trace_rq_cpu(struct rq *rq)
> -{
> -	return rq ? cpu_of(rq) : -1;
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rq_cpu);
> -
> -int sched_trace_rq_cpu_capacity(struct rq *rq)
> -{
> -	return rq ?
> -#ifdef CONFIG_SMP
> -		rq->cpu_capacity
> -#else
> -		SCHED_CAPACITY_SCALE
> -#endif
> -		: -1;
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
> -
> -const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
> -{
> -#ifdef CONFIG_SMP
> -	return rd ? rd->span : NULL;
> -#else
> -	return NULL;
> -#endif
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rd_span);
> -
> -int sched_trace_rq_nr_running(struct rq *rq)
> -{
> -        return rq ? rq->nr_running : -1;
> -}
> -EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
> -- 
> 2.25.1
> 
