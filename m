Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D00497D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiAXKie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:38:34 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:48160
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232626AbiAXKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:38:27 -0500
Received: from [192.168.88.87] (unknown [36.81.38.25])
        by gnuweeb.org (Postfix) with ESMTPSA id 50EC2C302E;
        Mon, 24 Jan 2022 10:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1643020704;
        bh=xw1wMZsw66j6y31Lmm247ZVt9e0jOQk+3R9d5cjT3+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NKLVL7Twe0p0sa+qQUMkRc/VP34HHu3BWClXN79ajhy7DDpzNiLSu5NoH4Y/UM7lb
         xwUDAseqcq3P32HNUP2RfbJCPbtQTfTQFiS2AnQerHL4mjd3UePNjOtLa3Q9cTJznU
         SGQXyjh5g+cnOmqfMumC6ZIExSvszXl6jXu03K6LAMMaNKqmJLVs35/1rgLFjXByLC
         TvZtCua9YOLqf+qaD+M8txM4IeCWkBHMDJDBJHkRsYPF8Hxe6qqzOgn0qmfn0CdRXQ
         KUE4xCXE2cp8opzWcIetELuVdWGQc+yCs4zb5cg90dy74agk4NDL5ue1FRzo7Zwsp3
         pHbefpxqoyg2w==
Message-ID: <e7d56d70-3750-b83a-8c1c-99878722c805@gnuweeb.org>
Date:   Mon, 24 Jan 2022 17:38:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220124103637.4001386-1-qiang1.zhang@intel.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220124103637.4001386-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ I resend and fix my reply, my previous reply seems to have an
   issue with the "Date" ]

Hi Zqiang,

On Mon, 24 Jan 2022 18:36:37 +0800, Zqiang <qiang1.zhang@intel.com> wrote:> +static void rcuc_kthread_dump(struct rcu_data *rdp)
> +{
> +	int cpu;
> +	unsigned long j;
> +	struct task_struct *rcuc = rdp->rcu_cpu_kthread_task;
> +
> +	if (rcu_is_rcuc_kthread_starving(rdp, &j)) {
> +		cpu = rcuc ? task_cpu(rcuc) : -1;
> +
> +		if (rcuc) {
> +			pr_err("%s kthread starved for %ld jiffies, stack dump:\n",
> +									rcuc->comm, j);
> +			sched_show_task(rcuc);
> +			if (cpu >= 0) {
> +				if (cpu_online(cpu) && !idle_cpu(cpu)) {
> +					pr_err("Dump current CPU stack:\n");
> +					if (!trigger_single_cpu_backtrace(cpu))
> +						dump_cpu_task(cpu);
> +				}
> +			}
> +		}
> +	}
> +}

1) We can reduce the nested if with an early return after
    checking `rcu_is_rcuc_kthread_starving()`.

2) This ternary operator doesn't make sense:

    `cpu = rcuc ? task_cpu(rcuc) : -1;`

    If `rcuc` is NULL, then the "if (rcuc)" block will never
    be executed, and `cpu` variable won't be used, why should
    we perform a conditional with ternary to assign -1 here?

3) We can use an early return as well for the `if (rcuc)` to
    avoid more nested if.

FWIW, this one makes more sense:
```
static void rcuc_kthread_dump(struct rcu_data *rdp)
{
	 int cpu;
	 unsigned long j;
	 struct task_struct *rcuc;

	 if (!rcu_is_rcuc_kthread_starving(rdp, &j))
		 return;

	 rcuc = rdp->rcu_cpu_kthread_task;
	 if (!rcuc)
		 return;

	 pr_err("%s kthread starved for %ld jiffies, stack dump:\n", rcuc->comm, j);
	 sched_show_task(rcuc);
	 cpu = task_cpu(rcuc);
	 if (cpu_online(cpu) && !idle_cpu(cpu)) {
		 pr_err("Dump current CPU stack:\n");
		 if (!trigger_single_cpu_backtrace(cpu))
			 dump_cpu_task(cpu);
	 }
}
```

Thank you!

-- 
Ammar Faizi
