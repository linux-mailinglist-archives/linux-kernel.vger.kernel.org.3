Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700434A46B7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376635AbiAaMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:17:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47718 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376355AbiAaMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:17:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9AB86212C9;
        Mon, 31 Jan 2022 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643631448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0J5qsEULaGdStUQG1tCq3jYf4FW+3nyxfh1A8mb1zI=;
        b=jZjlrZdG/PZEg0JUDxRqonrhJxrMcWC2CX7478aBiASWCSOeIr5ODAzQjJSfEQUPHjKcT6
        tj5EzyCjmeYg7wbHQ2/npvtxVSlwKiJQBXWT/1GPU5mvbfKENyUhmGPRL0JMjZ16RUWthS
        jxITMw+21LX2r4qfzwu5jASzz1eXWGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643631448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0J5qsEULaGdStUQG1tCq3jYf4FW+3nyxfh1A8mb1zI=;
        b=O61pz9tKeMENnqaDd21EbvwJP5FqbVRyCDUcIZEuFhta/Gelyou0Y/HKMv47/0IHyOnmZP
        +FFTuB3CVLOmYkCQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BAC72A3B8D;
        Mon, 31 Jan 2022 12:17:27 +0000 (UTC)
Date:   Mon, 31 Jan 2022 12:17:26 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH v0 3/3] sched/numa: Add adaptive scan period
 calculation
Message-ID: <20220131121726.GZ3301@suse.de>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-4-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220128052851.17162-4-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:58:51AM +0530, Bharata B Rao wrote:
> From: Disha Talreja <dishaa.talreja@amd.com>
> 
> This patch implements an adaptive algorithm for calculating
> the autonuma scan period. In the existing mechanism of scan
> period calculation,
> 
> - scan period is derived from the per-thread stats.
> - static threshold (NUMA_PERIOD_THRESHOLD) is used for changing
>   the scan rate.
> 
> In this new approach (Process Adaptive autoNUMA), we gather NUMA
> fault stats at per-process level which allows for capturing the
> application behaviour better. In addition, the algorithm learns
> and adjusts the scan rate based on remote fault rate. By not
> sticking to a static threshold, the algorithm can respond better
> to different workload behaviours.
> 

This appears to replace the per-task numa_scan_period with a per-mm
numa_scan_period. This likely leads to more stable rate overall but it
potentially misses that some threads are more active than others and
miss that different threads may have different local/remote faults and
private/shared faults. I think this may be smoothing the average while
potentially missing outliers.

After the patch, p->numa_scan_period appears to primarily affect if a
page is retried for migration but a lot of infrastructure is still left
behind and it's unclear what purpose it serves.

> Since the threads of a processes are already considered as a group,
> we add a bunch of metrics to the task's mm to track the various
> types of faults and derive the scan rate from them.
> 
> The new per-process fault stats contribute only to the per-process
> scan period calculation, while the existing per-thread stats
> continue to contribute towards the numa_group stats which
> eventually determine the thresholds for migrating memory and
> threads across nodes.
> 
> In this algorithm, the remote fault rates are maintained for
> the previous two scan windows. These historical remote fault
> rates along with the remote fault rate from the current window
> are used to determine the intended trend of the scanning period.
> 
> An increase in the trend implies an increased period thereby
> resulting in slower scanning. A decrease in the trend implies
> decreased period and hence faster scanning.
> 

Clarify what affects the trend in the changelog. e.g. how do differences
in local vs remote and private vs shared affect trend?

What happens if one thread is primarily local faults while another is
primarily remote faults, how does that affect the trend and overall
scan period? The per-task scanning is flawed in terms that more active
threads can scan address space regions that the task is uninterested in
but I worry that masking that with an address space average may delay
the correction of an imbalance in one thread because an overall trend
misses the details.

> The intended trends for the last two windows are tracked and
> the actual trend is reversed (thereby increasing or decreasing
> the scan period in that window) only if the same trend reversal
> has been intended in the previous two windows.
> 
> While the remote fault rate metric is derived from the accumulated
> remote and local faults from all the threads of the mm, the
> per-mm private and shared faults also contribute in deciding
> the trend of the scan period.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  include/linux/mm_types.h |   5 +
>  kernel/sched/debug.c     |   2 +
>  kernel/sched/fair.c      | 265 ++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/sched.h     |   2 +
>  4 files changed, 268 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 2c6f119b947f..d57cd96d8df0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -619,6 +619,11 @@ struct mm_struct {
>  
>  		spinlock_t pan_numa_lock;
>  		unsigned int numa_scan_period;
> +		int remote_fault_rates[2]; /* histogram of remote fault rate */
> +		long scanned_pages;

Why signed? What happens if it wraps (either negative if signed or back
to 0 if unsigned)?

> +		bool trend;
> +		int slope;
> +		u8 hist_trend;

Document the fields.

>  #endif
>  		/*
>  		 * An operation with batched TLB flushing is going on. Anything
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index aa29211de1bf..060bb46166a6 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -334,6 +334,8 @@ static __init int sched_init_debug(void)
>  	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
>  	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
>  	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
> +	debugfs_create_u32("pan_scan_period_min", 0644, numa, &sysctl_pan_scan_period_min);
> +	debugfs_create_u32("pan_scan_period_max", 0644, numa, &sysctl_pan_scan_period_max);
>  #endif

Update Documentation and what relationship if any scan_period_*_ms has
with pan_scan_period_*. Add the units to be consistent.

>  
>  	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4911b3841d00..5a9cacfbf9ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1026,6 +1026,10 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
>  /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
>  unsigned int sysctl_numa_balancing_scan_delay = 1000;
>  
> +/* Clips of max and min scanning periods */
> +unsigned int sysctl_pan_scan_period_min = 50;
> +unsigned int sysctl_pan_scan_period_max = 5000;
> +

Why are the period different to the min/max for the previous per-task
values? (admittedly, those values were pulled out of a hat).

>  struct numa_group {
>  	refcount_t refcount;
>  
> @@ -2102,6 +2106,242 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
>  /**********************************************/
>  /*  Process-based Adaptive NUMA (PAN) Design  */
>  /**********************************************/
> +#define SLOPE(N, D) ((N)/(D))
> +

Document. N/D implies numerator and denominator. Usage implies a
percentage change in remote faults but not always and there are a lot of
magic numers with limited explanation.

> +static unsigned int pan_scan_max(struct task_struct *p)
> +{
> +	unsigned long smax, nr_scan_pages;
> +	unsigned long rss = 0;
> +
> +	smax = sysctl_pan_scan_period_max;
> +	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
> +
> +	rss = get_mm_rss(p->mm);
> +	if (!rss)
> +		rss = nr_scan_pages;
> +
> +	if (READ_ONCE(p->mm->numa_scan_seq) == 0) {
> +		smax = p->mm->scanned_pages * sysctl_pan_scan_period_max;
> +		smax = smax / rss;
> +		smax = max_t(unsigned long, sysctl_pan_scan_period_min, smax);
> +	}
> +

rss is not necessarily related to virtual address space size e.g. sparse
mappings. May not be relevant but worth commenting on why it doesn't
matter.

> +	return smax;
> +}
> +
> +/*
> + * Process-based Adaptive NUMA scan period update alogirthm
> + *
> + * These are the important concepts behind the scan period update:
> + *
> + * - increase trend (of scan period)
> + *   scan period => up, memory coverage => down, overhead => down,
> + *   accuracy => down
> + * - decrease trend
> + *   scan period => down, memory coverage => up, overhead => up,
> + *   accuracy => up
> + * - trend: Reflects the current active trend
> + *   1 means increasing trend, 0 means decreasing trend
> + * - slope
> + *   it controls scan_period: new_scan_period = current_scan_period *
> + *                                              100 / slope
> + * - hist_trend: Reflects the intended trend in the last two
> + *   windows. Uses the last two bits (bit0 and bit1) for the same.
> + *   1 if increasing trend was intended, 0 if decreasing was intended.
> + */
> +
> +/*
> + * Check if the scan period needs updation when the remote fault
> + * rate has changed (delta > 5)
> + *
> + * Returns TRUE if scan period needs updation, else FALSE.
> + */
> +static bool pan_changed_rate_update(struct mm_struct *mm, int ps_ratio,
> +				    int oldest_remote_fault_rate,
> +				    int fault_rate_diff)
> +{
> +	u8 value;
> +
> +	/*
> +	 * Set the intended trend for the current window.
> +	 * - If the remote fault rate has decreased, set the
> +	 *   intended trend to increasing.
> +	 * - Otherwise leave the intended trend as decreasing.
> +	 */
> +	mm->hist_trend = mm->hist_trend << 1;
> +	if (fault_rate_diff < 5)
> +		mm->hist_trend |= 0x01;
> +

Why 5? Presumably 50% but not clear.

> +	value = mm->hist_trend & 0x03;
> +

Document better what is contained in this u8 value.

> +	if (fault_rate_diff < -5 && value == 3) {
> +		/*

Document magic numbers.

> +		 * The remote fault rate has decreased and the intended
> +		 * trend was set to increasing in the previous window.
> +		 *
> +		 * If on decreasing trend, reverse the trend and change
> +		 * the slope using the fault rates from (current-1)
> +		 * and (current-2) windows.
> +		 *
> +		 * If already on increasing trend, change the slope using
> +		 * the fault rates from (current) and (current-1) windows.
> +		 */
> +		if (!mm->trend) {
> +			mm->trend = true;
> +			mm->slope = SLOPE(mm->remote_fault_rates[0] * 100,
> +					  oldest_remote_fault_rate);
> +		} else {
> +			mm->slope = SLOPE(mm->remote_fault_rates[1] * 100,
> +					  mm->remote_fault_rates[0]);
> +		}
> +	} else if (fault_rate_diff > 5 && value == 0) {
> +		/*
> +		 * The remote fault rate has increased and the intended
> +		 * trend was set to decreasing in the previous window.
> +		 *
> +		 * If on increasing trend,
> +		 *  - If shared fault ratio is more than 30%, don't yet
> +		 *  reverse the trend, just mark the intended trend as
> +		 *  increasing.
> +		 *  - Otherwise reverse the trend. Change the slope using
> +		 *  the fault rates from (current-1) and (current-2) windows.
> +		 *
> +		 *  If on decreasing trend
> +		 *  - Continue with a changed slope using the fault
> +		 *  rates from (current) and (current-1) windows.
> +		 */
> +		if (mm->trend) {
> +			if (ps_ratio < 7) {
> +				mm->hist_trend |= 0x01;
> +				return true;
> +			}
> +
> +			mm->trend = false;
> +			mm->slope = SLOPE(mm->remote_fault_rates[0] * 100,
> +					  oldest_remote_fault_rate);
> +		} else {
> +			mm->slope = SLOPE(mm->remote_fault_rates[1] * 100,
> +					  mm->remote_fault_rates[0]);
> +		}
> +	} else if (value == 1 || value == 2) {
> +		/*
> +		 * The intended trend is oscillating
> +		 *
> +		 * If on decreasing trend and the shared fault ratio
> +		 * is more than 30%, reverse the trend and change the slope.
> +		 *
> +		 * If on increasing trend, continue as is.
> +		 */
> +		if (!mm->trend && ps_ratio < 7) {
> +			mm->hist_trend |= 0x01;
> +			mm->trend = true;
> +			mm->slope = SLOPE(100 * 100,
> +					  100 + ((7 - ps_ratio) * 10));
> +		}
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/*
> + * Check if the scan period needs updation when the remote fault
> + * rate has remained more or less the same (delta <= 5)
> + *
> + * Returns TRUE if scan period needs updation, else FALSE.
> + */


s/updation/updating/

> +static bool pan_const_rate_update(struct mm_struct *mm, int ps_ratio,
> +				  int oldest_remote_fault_rate)

Document the intent behind the difference between pan_const_rate_update
and pan_changed_rate_update.

> +{
> +	int diff1, diff2;
> +

Clarify what diff1 and diff2 are the differences between in the naming.

> +	mm->hist_trend = mm->hist_trend << 1;
> +
> +	/*
> +	 * If we are in the increasing trend, don't change anything
> +	 * except the intended trend for this window that was reset
> +	 * to decreasing by default.
> +	 */
> +	if (mm->trend)
> +		return false;
> +
> +	/* We are in the decreasing trend, reverse under some condidtions. */
> +	diff1 = oldest_remote_fault_rate - mm->remote_fault_rates[0];
> +	diff2 = mm->remote_fault_rates[0] - mm->remote_fault_rates[1];
> +
> +	if (ps_ratio < 7) {
> +		/*
> +		 * More than 30% of the pages are shared, so no point in
> +		 * further reducing the scan period. If increasing trend
> +		 * was intended in the previous window also, then reverse
> +		 * the trend to increasing. Else just record the increasing
> +		 * intended trend for this window and return.
> +		 */
> +		mm->hist_trend |= 0x01;
> +		if ((mm->hist_trend & 0x03) == 3) {
> +			mm->trend = true;
> +			mm->slope = SLOPE(100 * 100,
> +					  (100 + ((7 - ps_ratio) * 10)));
> +		} else
> +			return false;
> +	} else if (diff1 >= 0 && diff2 >= 0 && mm->numa_scan_seq > 1) {
> +		/*
> +		 * Remote fault rate has reduced successively in the last
> +		 * two windows and address space has been scanned at least
> +		 * once. If increasing trend was intended in the previous
> +		 * window also, then reverse the trend to increasing. Else
> +		 * just record the increasing trend for this window and return.
> +		 */
> +		mm->hist_trend |= 0x01;
> +		if ((mm->hist_trend & 0x03) == 3) {
> +			mm->trend = true;
> +			mm->slope = SLOPE(100 * 100, 110);
> +			mm->hist_trend |= 0x03;
> +		} else
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static void pan_calculate_scan_period(struct task_struct *p)
> +{
> +	int remote_fault_rate, oldest_remote_fault_rate, ps_ratio, i, diff;
> +	struct mm_struct *mm = p->mm;
> +	unsigned long remote_hist = mm->faults_locality_history[0];
> +	unsigned long local_hist = mm->faults_locality_history[1];
> +	unsigned long shared_hist = mm->faults_shared_history[0];
> +	unsigned long priv_hist = mm->faults_shared_history[1];
> +	bool need_update;
> +
> +	ps_ratio = (priv_hist * 10) / (priv_hist + shared_hist + 1);
> +	remote_fault_rate = (remote_hist * 100) / (local_hist + remote_hist + 1);
> +
> +	/* Keep the remote fault ratio at least 1% */
> +	remote_fault_rate = max(remote_fault_rate, 1);
> +	for (i = 0; i < 2; i++)
> +		if (mm->remote_fault_rates[i] == 0)
> +			mm->remote_fault_rates[i] = 1;
> +

What if there is one thread in the entire address that is responsible
for all of the remote faults if it's a shared region? Does this skew the
scan rates for unrelated threads?

> +	/* Shift right in mm->remote_fault_rates[] to keep track of history */
> +	oldest_remote_fault_rate = mm->remote_fault_rates[0];
> +	mm->remote_fault_rates[0] = mm->remote_fault_rates[1];
> +	mm->remote_fault_rates[1] = remote_fault_rate;
> +	diff = remote_fault_rate - oldest_remote_fault_rate;
> +
> +	if (abs(diff) <= 5)
> +		need_update = pan_const_rate_update(mm, ps_ratio,
> +						    oldest_remote_fault_rate);
> +	else
> +		need_update = pan_changed_rate_update(mm, ps_ratio,
> +						      oldest_remote_fault_rate,
> +						      diff);
> +
> +	if (need_update) {
> +		if (mm->slope == 0)
> +			mm->slope = 100;
> +		mm->numa_scan_period = (100 * mm->numa_scan_period) / mm->slope;
> +	}
> +}
> +
>  /*
>   * Update the cumulative history of local/remote and private/shared
>   * statistics. If the numbers are too small worthy of updating,
> @@ -2145,14 +2385,17 @@ static bool pan_update_history(struct task_struct *p)
>  
>  /*
>   * Updates mm->numa_scan_period under mm->pan_numa_lock.
> - * Returns p->numa_scan_period now but updated to return
> - * p->mm->numa_scan_period in a later patch.
>   */

But p->numa_scan_period still exists so it's harder to evaluate the
overall result.

>  static unsigned long pan_get_scan_period(struct task_struct *p)
>  {
> -	pan_update_history(p);
> +	if (pan_update_history(p))
> +		pan_calculate_scan_period(p);
> +
> +	p->mm->numa_scan_period = clamp(p->mm->numa_scan_period,
> +					READ_ONCE(sysctl_pan_scan_period_min),
> +					pan_scan_max(p));
>  
> -	return p->numa_scan_period;
> +	return p->mm->numa_scan_period;
>  }
>  
>  /*
> @@ -2860,6 +3103,7 @@ static void task_numa_work(struct callback_head *work)
>  		mm->numa_scan_offset = start;
>  	else
>  		reset_ptenuma_scan(p);
> +	mm->scanned_pages += ((sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT)) - pages);
>  	mmap_read_unlock(mm);
>  
>  	/*
> @@ -2882,10 +3126,15 @@ static void pan_init_numa(struct task_struct *p)
>  
>  	spin_lock_init(&mm->pan_numa_lock);
>  	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
> +	mm->scanned_pages = 0;
> +	mm->trend = false;
> +	mm->hist_trend = 0;
> +	mm->slope = 100;
>  
>  	for (i = 0; i < 2; i++) {
>  		mm->faults_locality_history[i] = 0;
>  		mm->faults_shared_history[i] = 0;
> +		mm->remote_fault_rates[i] = 1;
>  	}
>  }
>  
> @@ -2948,6 +3197,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>  	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
>  		return;
>  
> +	if (!spin_trylock(&curr->mm->pan_numa_lock))
> +		return;
> +
>  	/*
>  	 * Using runtime rather than walltime has the dual advantage that
>  	 * we (mostly) drive the selection from busy threads and that the

This potentially misses triggering of scans in general but again, the
more stable scan rates may be due to mm-wide averaging while missing
per-task specifics.

> @@ -2955,16 +3207,17 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>  	 * NUMA placement.
>  	 */
>  	now = curr->se.sum_exec_runtime;
> -	period = (u64)curr->numa_scan_period * NSEC_PER_MSEC;
> +	period = (u64)curr->mm->numa_scan_period * NSEC_PER_MSEC;
>  
>  	if (now > curr->node_stamp + period) {
>  		if (!curr->node_stamp)
> -			curr->numa_scan_period = task_scan_start(curr);
> +			curr->mm->numa_scan_period = task_scan_start(curr);
>  		curr->node_stamp += period;
>  
>  		if (!time_before(jiffies, curr->mm->numa_next_scan))
>  			task_work_add(curr, work, TWA_RESUME);
>  	}
> +	spin_unlock(&curr->mm->pan_numa_lock);
>  }
>  
>  static void update_scan_period(struct task_struct *p, int new_cpu)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index de53be905739..635f96bc989d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2424,6 +2424,8 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
>  extern unsigned int sysctl_numa_balancing_scan_period_min;
>  extern unsigned int sysctl_numa_balancing_scan_period_max;
>  extern unsigned int sysctl_numa_balancing_scan_size;
> +extern unsigned int sysctl_pan_scan_period_min;
> +extern unsigned int sysctl_pan_scan_period_max;
>  #endif
>  
>  #ifdef CONFIG_SCHED_HRTICK
> -- 
> 2.25.1
> 

-- 
Mel Gorman
SUSE Labs
