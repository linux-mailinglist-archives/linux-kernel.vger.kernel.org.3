Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042B949850C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiAXQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:42:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46940 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbiAXQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:42:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2B2EB810FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA64C340EE;
        Mon, 24 Jan 2022 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643042571;
        bh=SqErisRUlGDkdeqDrji8hZuLh+ZPAh1XtvZmsBKGgnI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SnRbCnqDSRoMaz5rHCrNC3g9sjlvYcZye/foIYb+917Y9TkUyssdjSrHR+0JEeD1+
         sGXU1UqcSjFu0Ug1my+h8afOiHD+6K+7Y0A+3j99NrKzfUprtOJDfEV66nfcvlu/4i
         4o1JRMdRwSM1Tx+tyomD73aYPMGMkh1MypTWCKDse6ymQJDcbzkTQPL15kZ5QL65BJ
         g3v7brTijPWj7bKxQy/cRjDBumDEbm8HPvWq+kI0MfEuWJDbhYYaD8VH7NSkhCzle7
         nxK4YfasnedaCN3P14pt3+yswA/zl5mIpm4DK58pQ5DhDIhPS6CoMyWhFepyYOHXBb
         OVP7EWgPlswSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4B7895C1286; Mon, 24 Jan 2022 08:42:51 -0800 (PST)
Date:   Mon, 24 Jan 2022 08:42:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Message-ID: <20220124164251.GF4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220124103637.4001386-1-qiang1.zhang@intel.com>
 <e7d56d70-3750-b83a-8c1c-99878722c805@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d56d70-3750-b83a-8c1c-99878722c805@gnuweeb.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 05:38:21PM +0700, Ammar Faizi wrote:
> 
> [ I resend and fix my reply, my previous reply seems to have an
>   issue with the "Date" ]
> 
> Hi Zqiang,
> 
> On Mon, 24 Jan 2022 18:36:37 +0800, Zqiang <qiang1.zhang@intel.com> wrote:> +static void rcuc_kthread_dump(struct rcu_data *rdp)
> > +{
> > +	int cpu;
> > +	unsigned long j;
> > +	struct task_struct *rcuc = rdp->rcu_cpu_kthread_task;
> > +
> > +	if (rcu_is_rcuc_kthread_starving(rdp, &j)) {
> > +		cpu = rcuc ? task_cpu(rcuc) : -1;
> > +
> > +		if (rcuc) {
> > +			pr_err("%s kthread starved for %ld jiffies, stack dump:\n",
> > +									rcuc->comm, j);
> > +			sched_show_task(rcuc);
> > +			if (cpu >= 0) {
> > +				if (cpu_online(cpu) && !idle_cpu(cpu)) {
> > +					pr_err("Dump current CPU stack:\n");
> > +					if (!trigger_single_cpu_backtrace(cpu))
> > +						dump_cpu_task(cpu);
> > +				}
> > +			}
> > +		}
> > +	}
> > +}
> 
> 1) We can reduce the nested if with an early return after
>    checking `rcu_is_rcuc_kthread_starving()`.
> 
> 2) This ternary operator doesn't make sense:
> 
>    `cpu = rcuc ? task_cpu(rcuc) : -1;`
> 
>    If `rcuc` is NULL, then the "if (rcuc)" block will never
>    be executed, and `cpu` variable won't be used, why should
>    we perform a conditional with ternary to assign -1 here?
> 
> 3) We can use an early return as well for the `if (rcuc)` to
>    avoid more nested if.
> 
> FWIW, this one makes more sense:
> ```
> static void rcuc_kthread_dump(struct rcu_data *rdp)
> {
> 	 int cpu;
> 	 unsigned long j;
> 	 struct task_struct *rcuc;
> 
> 	 if (!rcu_is_rcuc_kthread_starving(rdp, &j))
> 		 return;
> 
> 	 rcuc = rdp->rcu_cpu_kthread_task;
> 	 if (!rcuc)
> 		 return;
> 
> 	 pr_err("%s kthread starved for %ld jiffies, stack dump:\n", rcuc->comm, j);

Thank you for looking this over and for the great feedback, Ammar!

I am also wondering why the above message should be printed when the
corresponding CPU is offline or idle.  Why not move the above pr_err()
line down to replace the pr_err() line below?

							Thanx, Paul

> 	 sched_show_task(rcuc);
> 	 cpu = task_cpu(rcuc);
> 	 if (cpu_online(cpu) && !idle_cpu(cpu)) {
> 		 pr_err("Dump current CPU stack:\n");
> 		 if (!trigger_single_cpu_backtrace(cpu))
> 			 dump_cpu_task(cpu);
> 	 }
> }
> ```
> 
> Thank you!
> 
> -- 
> Ammar Faizi
