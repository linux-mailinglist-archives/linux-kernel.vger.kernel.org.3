Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB556512C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiGDJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGDJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:44:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68EE10
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CbAHc7Nr4juUmmR3x1WTgql4quqYveqU6rxmCDtc0qg=; b=EVfJfG7QTCCUZO1KnDd6B2s9mz
        O8/clLPcnZqwS4sjuUiw+BHiRbaL01x3DKTjhozzEo6+D6SDcPgvSO0sKIOQ2NV4GwiQUl/E7UNEL
        gIuDw0Vk4W8jJ4OThP6HiGNKSTmzpvm0bkzCYVnN+43GPNgCx1ZHr+Z7QR4HBFRuEzMNSSo3gvviB
        WfHkotVX2vNV3yQIqCETKg+6bROgDXBqKo4eQfJNwiXM4Toy25sv66WaxuGfyi2cezWkvfb0EU+0O
        Z1yRGQfV890k3YTMJKTftx/X+p+zXx4woj36fW9P0sOh0vliZkOp90/27JqOFSdmbba/eF3j0Nkmb
        9mY81/DA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Ic0-00H4jp-LO; Mon, 04 Jul 2022 09:43:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F1173001AE;
        Mon,  4 Jul 2022 11:43:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 564F620295B20; Mon,  4 Jul 2022 11:43:22 +0200 (CEST)
Date:   Mon, 4 Jul 2022 11:43:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/core: Make tasks with the same cookie pairs on
 SMT siblings
Message-ID: <YsK2OovozB2XJ9Cl@hirez.programming.kicks-ass.net>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-4-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656403045-100840-4-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:57:25PM +0800, Cruz Zhao wrote:
> If the number of tasks in the runqueue of SMT siblings are equal, we call
> the core balanced, otherwise unbalanced. If the core is balanced, everytime
> we pick next task, we can pick a pair of tasks with the same cookie for
> each SMT sibling, and forceidle will be avoided.
> 
>  - Migrate the task if source core and destination core can balance
>      If ck->nr_running of src_cpu is the highest among the source core, and
>      ck->nr_running of dst_cpu is the lowest among the destination core,
>      migrate the task.
> 
>  - Select cookie matched idle CPU or idle CPU with the lowest
>    ck->nr_running among the core
>      In the fast path of task wakeup, if ck->nr_running of the cpu is the
>      lowest among the core, we can select this cpu to wake up.
> 
>  - Find cookie matched idlest CPU or cookie matched CPU with the lowest
>    ck->nr_running among the core
>      In the slow path of task wakeup, if ck->nr_running of the cpu is the
>      lowest among the core, we can select this cpu to wake up.
> 
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  kernel/sched/fair.c  |  4 ++--
>  kernel/sched/sched.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 61 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 78795a9..c18a716 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6096,7 +6096,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
>  		struct rq *rq = cpu_rq(i);
>  
> -		if (!sched_core_cookie_match(rq, p))
> +		if (!sched_core_cookie_match(NULL, rq, p))
>  			continue;
>  
>  		if (sched_idle_cpu(i))
> @@ -7681,7 +7681,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  	 * Don't migrate task if the task's cookie does not match
>  	 * with the destination CPU's core cookie.
>  	 */
> -	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> +	if (!(sched_core_cookie_match(env->src_rq, env->dst_rq, p)))
>  		return 1;

superfluous () added.

>  
>  	if (sysctl_sched_migration_cost == 0)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d852c67..ee0e558 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1195,6 +1195,56 @@ struct sched_core_cookie {
>  };
>  
>  /*
> + * When tasks with the same cookie can make pairs on SMT siblings, forceidle can be
> + * avoided a lot, so when wake up and load balance, we try to make and keep the pairs
> + * with the same cookie on SMT siblings.
> + */
> +static inline bool
> +sched_core_make_pair_balance(struct rq *src_rq, struct rq *dst_rq, struct task_struct *p)
> +{
> +	struct sched_core_cookie *ck = (struct sched_core_cookie *)p->core_cookie;
> +	unsigned int src_cpu, dst_cpu, t;
> +	unsigned int src_nr_running, dst_nr_running;
> +
> +	if (!ck)
> +		return true;
> +
> +	/*
> +	 * When load balance, if ck->nr_running on src_cpu is less than that on SMT
> +	 * siblings, don't migrate the task.
> +	 */
> +	if (src_rq) {
> +		if (!sched_core_enabled(src_rq))
> +			return true;
> +		src_cpu = cpu_of(src_rq);
> +		src_nr_running = *per_cpu_ptr(ck->nr_running, src_cpu);
> +		for_each_cpu(t, cpu_smt_mask(src_cpu)) {
> +			if (t == src_cpu)
> +				continue;
> +			if (*per_cpu_ptr(ck->nr_running, t) >= src_nr_running)
> +				return false;
> +		}
> +
> +	}
> +
> +	/*
> +	 * If task p can make pair the cookied task with p->core_cookie on the
> +	 * dst core, we can wake up task p on dst_rq, or migrate it to dst_rq.
> +	 */
> +	dst_cpu = cpu_of(dst_rq);
> +	dst_nr_running = *per_cpu_ptr(ck->nr_running, dst_cpu);
> +	for_each_cpu(t, cpu_smt_mask(dst_cpu)) {
> +		if (t == dst_cpu)
> +			continue;
> +		if (*per_cpu_ptr(ck->nr_running, t) <= dst_nr_running)
> +			return false;
> +	}
> +
> +	return true;
> +}

I don't see how this doesn't destroy regular load balancing.
Specifically the case where there are very few tasks of each cookie.
