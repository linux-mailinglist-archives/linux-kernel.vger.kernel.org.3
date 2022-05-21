Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEED52FA89
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 12:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiEUKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEUKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 06:01:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808731402E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2jbdxCX0746y1clUp3qUeAGat6RVN++2ggug8b6xgpo=; b=FjWAeykjVzYskWAxEpeAwELQeH
        lfkK/jeXjyMEuJIU2l6oKQqvFLHcgiu0fKrVFHNi8TWp+SepfhKWl0JZCTgXChwiD64HDDOUnoqB8
        RG5e7d6O8rjpDZeOPfH70A50RZWTaF2HFxP2+8nUL9LeuaE3O35tAYEYKl0DbRQIEX4ES/ZVjAfyZ
        RDVdbUL/q7oPeCfzBZ49buULRSRLeLRZVZwKJWi2N0ZgCTckarcSIA465AgxBYmlkK26wmcoxgzEY
        BMM4rNs5v7PjsT1fZZRhKA1i3wrNiRD5znAPy4DKnY5WazV/WVXkcYuMUKp/yIuKKU+uImoRCXc05
        u/5/R0HA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsLua-000CIo-3N; Sat, 21 May 2022 10:00:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BA3F980E99; Sat, 21 May 2022 12:00:37 +0200 (CEST)
Date:   Sat, 21 May 2022 12:00:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
Message-ID: <20220521100037.GA2578@worktop.programming.kicks-ass.net>
References: <20220520235138.3140590-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235138.3140590-1-joshdon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:51:38PM -0700, Josh Don wrote:

> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index 38a2cec21014..ddef2b8ddf68 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -277,7 +277,11 @@ void __sched_core_account_forceidle(struct rq *rq)
>  		if (p == rq_i->idle)
>  			continue;
>  
> -		__schedstat_add(p->stats.core_forceidle_sum, delta);
> +		/*
> +		 * Note: this will account forceidle to the current cpu, even
> +		 * if it comes from our SMT sibling.
> +		 */
> +		account_forceidle_time(p, delta);
>  	}

AFAICT this is the only caller of that function.

>  }
>  
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 78a233d43757..598d1026d629 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -226,6 +226,17 @@ void account_idle_time(u64 cputime)
>  		cpustat[CPUTIME_IDLE] += cputime;
>  }
>  
> +
> +#ifdef CONFIG_SCHED_CORE
> +/* Account for forceidle time due to core scheduling. */
> +void account_forceidle_time(struct task_struct *p, u64 delta)
> +{
> +	schedstat_add(p->stats.core_forceidle_sum, delta);

But then you loose the __, why? 

> +
> +	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
> +}
> +#endif
