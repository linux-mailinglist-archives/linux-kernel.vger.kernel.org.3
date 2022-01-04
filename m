Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6648412A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiADLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:47:26 -0500
Received: from foss.arm.com ([217.140.110.172]:58636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232574AbiADLrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:47:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92166142F;
        Tue,  4 Jan 2022 03:47:24 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F923F774;
        Tue,  4 Jan 2022 03:47:22 -0800 (PST)
Subject: Re: [PATCH v2 3/3] sched/pelt: Don't sync hardly load_sum with
 load_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-4-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <06bef8b2-aba6-5dd3-ddb0-ffcdc4f2a689@arm.com>
Date:   Tue, 4 Jan 2022 12:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222093802.22357-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 10:38, Vincent Guittot wrote:
> Similarly to util_avg and util_sum, don't sync load_sum with the low
> bound of load_avg but only ensure that load_sum stays in the correct range.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b4c350715c16..488213d98770 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3025,12 +3025,17 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
>  }
>  
> +#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
> +
>  static inline void
>  dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -	u32 divider = get_pelt_divider(&se->avg);
>  	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
> -	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
> +	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
> +	/* See update_tg_cfs_util() */
> +	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
> +					  cfs_rq->avg.load_avg * MIN_DIVIDER);
> +

Maybe add a:

Fixes: ceb6ba45dc80 ("sched/fair: Sync load_sum with load_avg after
dequeue")

[...]

>  static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
> @@ -3699,7 +3706,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  
>  		r = removed_load;
>  		sub_positive(&sa->load_avg, r);
> -		sa->load_sum = sa->load_avg * divider;
> +		sub_positive(&sa->load_sum, r * divider);
> +		/* See update_tg_cfs_util() */
> +		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);

Since this max_t() is used 9 times in this patch-set, maybe a macro in
pelt.h is better:

+/* Because of rounding, se->util_sum might ends up being +1 more than
+ * cfs->util_sum (XXX fix the rounding). Although this is not
+ * a problem by itself, detaching a lot of tasks with the rounding
+ * problem between 2 updates of util_avg (~1ms) can make cfs->util_sum
+ * becoming null whereas cfs_util_avg is not.
+ * Check that util_sum is still above its lower bound for the new
+ * util_avg. Given that period_contrib might have moved since the last
+ * sync, we are only sure that util_sum must be above or equal to
+ * util_avg * minimum possible divider
+  */
+#define MIN_DIVIDER    (LOAD_AVG_MAX - 1024)
+
+#define enforce_lower_bound_on_pelt_sum(sa, var) do {           \
+       (sa)->var##_sum = max_t(u32,                             \
+                               (sa)->var##_sum,                 \
+                               (sa)->var##_avg * MIN_DIVIDER);  \
+} while (0)

This way, you could also add the comment from update_tg_cfs_util()
there. And there would be no need anymore to point to it from the other
places where it is used.

[...]
