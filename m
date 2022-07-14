Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D19574DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiGNMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiGNMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:32:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE7BF3CBD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:32:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA45315A1;
        Thu, 14 Jul 2022 05:32:10 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9213F792;
        Thu, 14 Jul 2022 05:32:09 -0700 (PDT)
Message-ID: <e9a069dd-6215-4725-ca64-7453b6511e35@arm.com>
Date:   Thu, 14 Jul 2022 14:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 05/10] sched/fair: reset sched_avg last_update_time
 before set_task_rq()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-6-zhouchengming@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220713040430.25778-6-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:04, Chengming Zhou wrote:
> set_task_rq() -> set_task_rq_fair() will try to synchronize the blocked
> task's sched_avg when migrate, which is not needed for already detached
> task.
> 
> task_change_group_fair() will detached the task sched_avg from prev cfs_rq
> first, so reset sched_avg last_update_time before set_task_rq() to avoid that.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8992ce5e73d2..171bc22bc142 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11637,12 +11637,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  static void task_change_group_fair(struct task_struct *p)
>  {
>  	detach_task_cfs_rq(p);
> -	set_task_rq(p, task_cpu(p));
>  
>  #ifdef CONFIG_SMP
>  	/* Tell se's cfs_rq has been changed -- migrated */
>  	p->se.avg.last_update_time = 0;
>  #endif
> +	set_task_rq(p, task_cpu(p));
>  	attach_task_cfs_rq(p);
>  }
>  

