Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F8249A01E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383541AbiAXXEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:04:21 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:48238
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348958AbiAXWIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:08:34 -0500
Received: from [10.5.5.3] (unknown [68.183.184.174])
        by gnuweeb.org (Postfix) with ESMTPSA id 21C0DC316C;
        Mon, 24 Jan 2022 22:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1643062112;
        bh=zxxunHJMdrtLLW9Gj1MtrXIOO8UGQKHrxWPSXsEVrXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hz0g4K/xfkORh2e55UOv0F0+MwoNXnKbRWDbVEfYymEuHpJA0o+OVqZAOi+f9Obog
         u9wAvZ4egvndPhyr9tAASg2ilf0rnRGIwzx+AsXBZ19lWce3VKMvgqeyADxd7dfWc3
         C3mxO6xmZ++sTFqPlH5FM4zC9DlKgFuYXLr6b6K0dxCiZEmOsI7JL6EtvKgGhaAupP
         PzzGHgzuZ48TcLP5j9mLPV5OGvFrqymJG+Rl8SP3jgUfmakXOiTqdNVkUxYdAEr3wy
         t1u4T7rX13FrAr8ptO0vbLjcp/ClqTWfGvp+gYzRI0o+1ZJGHwKPI1dnL5RclkrbFv
         JWZQC9GCqLZVQ==
Message-ID: <3f08b8cf-a1dc-4d83-0de2-94203dff9a4c@gnuweeb.org>
Date:   Tue, 25 Jan 2022 05:08:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Zqiang <qiang1.zhang@intel.com>, linux-kernel@vger.kernel.org
References: <20220124103637.4001386-1-qiang1.zhang@intel.com>
 <e7d56d70-3750-b83a-8c1c-99878722c805@gnuweeb.org>
 <20220124164251.GF4285@paulmck-ThinkPad-P17-Gen-1>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220124164251.GF4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 11:42 PM, Paul E. McKenney wrote:
> On Mon, Jan 24, 2022 at 05:38:21PM +0700, Ammar Faizi wrote:
>> [snip...]
>> FWIW, this one makes more sense:
>> ```
>> static void rcuc_kthread_dump(struct rcu_data *rdp)
>> {
>> 	 int cpu;
>> 	 unsigned long j;
>> 	 struct task_struct *rcuc;
>>
>> 	 if (!rcu_is_rcuc_kthread_starving(rdp, &j))
>> 		 return;
>>
>> 	 rcuc = rdp->rcu_cpu_kthread_task;
>> 	 if (!rcuc)
>> 		 return;
>>
>> 	 pr_err("%s kthread starved for %ld jiffies, stack dump:\n", rcuc->comm, j);
> 
> Thank you for looking this over and for the great feedback, Ammar!
> 
> I am also wondering why the above message should be printed when the
> corresponding CPU is offline or idle.  Why not move the above pr_err()
> line down to replace the pr_err() line below?
> 
> 							Thanx, Paul

Hi Paul, Thank you for the review. Agree with that.
Hopefully this one looks better (untested):
```
static void rcuc_kthread_dump(struct rcu_data *rdp)
{
	int cpu;
	unsigned long j;
	struct task_struct *rcuc;

	rcuc = rdp->rcu_cpu_kthread_task;
	if (!rcuc)
		return;

	cpu = task_cpu(rcuc);
	if (cpu_is_offline(cpu) || idle_cpu(cpu))
		return;

	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
		return;

	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
	sched_show_task(rcuc);
	if (!trigger_single_cpu_backtrace(cpu))
		dump_cpu_task(cpu);
}
```

Recall that dump_cpu_task looks like this:
```
void dump_cpu_task(int cpu)
{
	pr_info("Task dump for CPU %d:\n", cpu);
	sched_show_task(cpu_curr(cpu));
}
```
which already tells us it's a dump, so "stack dump" in the pr_err()
can be omitted. Any comment, Zqiang?

-- 
Ammar Faizi
