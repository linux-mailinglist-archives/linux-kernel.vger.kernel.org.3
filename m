Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F9514A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359654AbiD2NDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359644AbiD2NCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:02:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21E5CABA8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:59:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB481063;
        Fri, 29 Apr 2022 05:59:32 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8CB33F5A1;
        Fri, 29 Apr 2022 05:59:30 -0700 (PDT)
Message-ID: <0058249a-5f9f-9f67-db5b-f7c3c10c3729@arm.com>
Date:   Fri, 29 Apr 2022 14:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] sched/core: Avoid obvious double update_rq_clock
 warning
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220427080014.18483-1-jiahao.os@bytedance.com>
 <20220427080014.18483-2-jiahao.os@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220427080014.18483-2-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 10:00, Hao Jia wrote:

[...]

LGTM, comments are only nit-picks.

> Since we directly use raw_spin_rq_lock() to acquire rq lock instead of
> rq_lock(), there is no corresponding change to rq->clock_update_flags.
> In particular, we have obtained the rq lock of other cores,

s/cores/CPUs, with SMT, a core can have multiple (logical) CPUs.

[...]

> So we need to clear RQCF_UPDATED of rq->clock_update_flags synchronously
> to avoid the WARN_DOUBLE_CLOCK warning.

Why you mention `synchronously` here? Isn't this obvious? (1)

[...]

> @@ -1833,6 +1833,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
>  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
>  {
>  	struct rq *rq;
> +	struct rq_flags rf;

-       struct rq *rq;
        struct rq_flags rf;
+       struct rq *rq;

Use reverse fir tree order for variable declarations.
(./Documentation/process/maintainer-tip.rst)

[...]

> +#ifdef CONFIG_SCHED_DEBUG
> +/*
> + * In double_lock_balance()/double_rq_lock(), we use raw_spin_rq_lock() to acquire
> + * rq lock instead of rq_lock(). So at the end of these two functions we need to
> + * call double_rq_clock_clear_update() synchronously to clear RQCF_UPDATED of
                                          ^^^^^^^^^^^^^
                                          (1)

> + * rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
> + */
> +static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
> +{
> +	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +	/*
> +	 * If CONFIG_SMP is not defined, rq1 and rq2 are the same,
> +	 * so we just clear RQCF_UPDATED one of them.
> +	 */

Maybe shorter:

      /* rq1 == rq2 for !CONFIG_SMP, so just clear RQCF_UPDATED once. */

[...]

> @@ -2543,14 +2564,15 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
>  	__acquires(busiest->lock)
>  	__acquires(this_rq->lock)
>  {
> -	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
> -		return 0;
> -
> -	if (likely(raw_spin_rq_trylock(busiest)))
> +	if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
> +		likely(raw_spin_rq_trylock(busiest))) {

indention:

        if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
-               likely(raw_spin_rq_trylock(busiest))) {
+           likely(raw_spin_rq_trylock(busiest))) {

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Tested on Arm64 Juno with mainline & preempt-rt (linux-5.17.y-rt).
