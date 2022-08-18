Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4B598189
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiHRKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiHRKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:39:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1D6CF54
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oRd8OBFVOwR2oaya9oS2Iqc7HGFuNofE+CGd0nDbieM=; b=MVoHl9n5UcYgHBrquBH3WV2omM
        PbFJ42ZpoS9z/x/z4pccI+KXTh2hMOAlmz3ppYEsUK4o5z5qD9mwrDrXfDJQYe9cu/I2TQtb1CLUw
        gDCYPelms0/JQVGdN82V7HreKEqDk/jyd8OAUiQsbKzqbaLLKSSaM70/rhKJcKG7WseQpD8eQwDsd
        JNS5JCfcr0CQuSBw9++SMDIh2InKIJwrbFQ/WR6oNyGuBbdgltci3dFaepaQf3CNSt4Z3Pfx9KH7r
        Z0TQ5YyQc1RjNVXwKOdSqLfWvW4UmudGVVewVR+u/zUcjml87/TJCfNF6gkjcmMX/dm8rYA1gwtGi
        29BLURRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOcw2-003Yjl-TS; Thu, 18 Aug 2022 10:39:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D90C980135; Thu, 18 Aug 2022 12:39:34 +0200 (CEST)
Date:   Thu, 18 Aug 2022 12:39:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v5 8/9] sched/fair: defer task sched_avg attach to
 enqueue_entity()
Message-ID: <Yv4W5u4+CXir3bjZ@worktop.programming.kicks-ass.net>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
 <20220818034343.87625-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818034343.87625-9-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:43:42AM +0800, Chengming Zhou wrote:
> When wake_up_new_task(), we would use post_init_entity_util_avg()
> to init util_avg/runnable_avg based on cpu's util_avg at that time,
> then attach task sched_avg to cfs_rq.
> 
> Since enqueue_entity() would always attach any unattached task entity,
> so we can defer this work to enqueue_entity().
> 
> post_init_entity_util_avg(p)
>   attach_entity_cfs_rq()  --> (1)
> activate_task(rq, p)
>   enqueue_task() := enqueue_task_fair()
>   enqueue_entity()
>     update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
>       if (!se->avg.last_update_time && (flags & DO_ATTACH))
>         attach_entity_load_avg()  --> (2)
> 
> This patch defer attach from (1) to (2)
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e0d34ecdabae..aacf38a72714 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -799,8 +799,6 @@ void init_entity_runnable_average(struct sched_entity *se)
>  	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
>  }
>  
> -static void attach_entity_cfs_rq(struct sched_entity *se);
> -
>  /*
>   * With new tasks being created, their initial util_avgs are extrapolated
>   * based on the cfs_rq's current util_avg:
> @@ -863,8 +861,6 @@ void post_init_entity_util_avg(struct task_struct *p)
>  		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>  		return;
>  	}
> -
> -	attach_entity_cfs_rq(se);
>  }

There are comments with update_cfs_rq_load_avg() and
remove_entity_load_avg() that seem to rely on post_init_entity_util()
doing this attach.

If that is no longer true; at the very least those comments need to be
updated, but also, I don't immediately see why that's no longer the
case, so please explain.
