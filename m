Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972004D6E94
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiCLMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:06:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CC972B1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ejU6WI5jmR2smgFVL5pnl7wQ3KUvcvihCK5Q5wkohU0=; b=MMV8ty8liqf04/w5STtdINZm4Y
        qFQph5LR3+2BXUbw+lafq+o8K1yT1atlLjBFF/jmWnu1XVXeRrSjKprw0FG0g06vQpVGVHT4D9fEn
        FfOSHDKLdNYuk3YdX46TAAIgnHfIGWUejhLCILMpp3FCElLuZMfaSMdWPiaAgeBTWxtg+mKwaNn8W
        DvDBT9luafIUSMqE2+MUgyv7b4x4rBBiqHEgKUPiOEQJv7jJqCQNfjokF2MBLvxWulkmvKO+U6qAw
        kgYaYVrQ4MWZ+XVl27qQqizeX8uShACA7ppUccX+8HV7g4d/OuBGIMfII+3iSlJ+83eyynXhjJIaO
        T730WJvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT0Up-000A3C-Uo; Sat, 12 Mar 2022 12:05:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C28598791D; Sat, 12 Mar 2022 13:05:18 +0100 (CET)
Date:   Sat, 12 Mar 2022 13:05:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sched: topology: make cache topology separate from
 cpu topology
Message-ID: <20220312120518.GC6235@worktop.programming.kicks-ass.net>
References: <1646969135-26647-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646969135-26647-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:25:33PM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Some architectures(e.g. ARM64), caches are implemented like below:
> SD(Level 1):          ************ DIE ************
> SD(Level 0):          **** MC ****    **** MC *****
> cluster:              **cluster 0**   **cluster 1**
> cores:                0   1   2   3   4   5   6   7
> cache(Level 1):       C   C   C   C   C   C   C   C
> cache(Level 2):  	  **C**   **C**   **C**   **C**
> cache(Level 3):       *******shared Level 3********
> sd_llc_id(current):   0   0   0   0   4   4   4   4
> sd_llc_id(should be): 0   0   2   2   4   4   6   6
> 
> Caches and cpus have different topology, this causes cpus_share_cache()
> return the wrong value in sd, which will affect the CPU load balance.

Then fix your SD_flags already.

> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index cce6136b..3048fa6
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -82,6 +82,8 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
>  #define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
>  #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
>  void init_cpu_topology(void);
> +void init_cpu_cache_topology(void);
> +void fix_cpu_llc(int cpu, int *first_cpu, int *cpu_num);
>  void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_clustergroup_mask(int cpu);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a70..d894ced
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -661,6 +661,9 @@ static void update_top_cache_domain(int cpu)
>  	if (sd) {
>  		id = cpumask_first(sched_domain_span(sd));
>  		size = cpumask_weight(sched_domain_span(sd));
> +#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
> +		fix_cpu_llc(cpu, &id, &size);
> +#endif
>  		sds = sd->shared;
>  	}

NAK on that.
