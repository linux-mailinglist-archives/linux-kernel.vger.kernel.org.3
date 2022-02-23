Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86B4C1025
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiBWKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiBWKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:20:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD48BE32
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6dI8rlxnvMgk/CFWZ7aIu/AOOPTmafd9dUBuyUNg4Oc=; b=XuPw/GXs8D8h1ys61CHxVZ2YpD
        lqIDjNOD1VfzUWUujSiEvHpT6ZVs8XQ/iXFIzK7+L3I4EHZT4a5Jp02Dk/QQ0GDouPV4GXcOdF0ZH
        E6X0BH5mhFhiBF54GSx/m2qFjtHxH4ho1g/2F6VLgsptGlKyRTdmhskr3C4TzMjhp+VKMAld86KCr
        B09Jc4w3nJvQzLpVrsv/JI15KzYQeLl+ROk/elVoNfLuzw44GINaWaOEO3/URTlijCpDSgl2w5/19
        vPn0HYI9o6iLy+8cmdLi9S4jyMLSlAhN2XPEjiNa93jkjepkRIsXxni2nIJ9w2XYW7idKOQTQQ+Zt
        CFl6pT6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMok5-00CEGq-P4; Wed, 23 Feb 2022 10:19:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA3B7300454;
        Wed, 23 Feb 2022 11:19:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3BA6203DC967; Wed, 23 Feb 2022 11:19:27 +0100 (CET)
Date:   Wed, 23 Feb 2022 11:19:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        mingo@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched: Update schedstats when migrating threads
Message-ID: <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126152222.5429-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:22:23AM -0600, Carlos Bilbao wrote:
> The kernel manages per-task scheduler statistics or schedstats. Such
> counters should be reinitialized when the thread is migrated to a
> different core rq, except for the values recording number of migrations.

I'm confused, why should we reset schedstats on migrate? I'm thinking
this breaks per-task, since tasks tend to bounce around quite a lot.

> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  kernel/sched/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe53e510e711..d64c2a290176 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
>  int migrate_task_to(struct task_struct *p, int target_cpu)
>  {
>  	struct migration_arg arg = { p, target_cpu };
> +	uint64_t forced_migrations, migrations_cold;
>  	int curr_cpu = task_cpu(p);
>  
>  	if (curr_cpu == target_cpu)
> @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> +	if (schedstat_enabled()) {
> +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
> +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
> +		memset(&p->stats, 0, sizeof(p->stats));
> +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
> +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
> +		schedstat_inc(p->stats.nr_migrations_cold);
> +	}
>  
>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
> -- 
> 2.27.0
> 
