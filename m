Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAA490C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiAQQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:18:36 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:12677 "HELO
        mailgate02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S241024AbiAQQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:18:34 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.41])
        by mailgate02.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 1C4A26006D207;
        Tue, 18 Jan 2022 00:18:30 +0800 (CST)
Received: from [172.31.2.139] (172.20.16.101) by BJSGEXMBX11.didichuxing.com
 (172.20.15.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 Jan
 2022 00:18:29 +0800
Message-ID: <ac76408f-4bf4-1674-b86e-b51c7f2f8edf@didichuxing.com>
Date:   Tue, 18 Jan 2022 00:18:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] sched/numa: initialize numa statistics when forking new
 task
Content-Language: en-US
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Honglei Wang <wanghonglei@didichuxing.com>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.41
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <56de780f.71f0.17e68b742c3.Coremail.jameshongleiwang@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.16.101]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX11.didichuxing.com (172.20.15.141)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, friendly ping... any comments about this?

At 2022-01-13 21:39:20, "Honglei Wang" <wanghonglei@didichuxing.com> wrote:
> The child processes will inherit numa_pages_migrated and
> total_numa_faults from the parent. It means even if there is no numa
> fault happen on the child, the statistics in /proc/$pid of the child
> process might show huge amount. This is a bit weird. Let's initialize
> them when do fork.
>
> Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
> ---
>   kernel/sched/fair.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..1aa0ec123a4b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2826,6 +2826,8 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
> 	/* Protect against double add, see task_tick_numa and task_numa_work */
> 	p->numa_work.next		= &p->numa_work;
> 	p->numa_faults			= NULL;
> +	p->numa_pages_migrated		= 0;
> +	p->total_numa_faults		= 0;
> 	RCU_INIT_POINTER(p->numa_group, NULL);
> 	p->last_task_numa_placement	= 0;
> 	p->last_sum_exec_runtime	= 0;
> -- 
> 2.14.1
