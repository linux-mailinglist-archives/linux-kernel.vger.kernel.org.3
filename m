Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11950E57F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbiDYQYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbiDYQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:24:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DFBA6D857
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:21:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CAA11FB;
        Mon, 25 Apr 2022 09:21:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1EC3F774;
        Mon, 25 Apr 2022 09:21:37 -0700 (PDT)
Message-ID: <cfab5ffc-af96-8368-0aae-927a6be65472@arm.com>
Date:   Mon, 25 Apr 2022 18:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] sched/dl: Remove some comments and adjust code in
 push_dl_task
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220422090944.52618-1-jiahao.os@bytedance.com>
 <20220422090944.52618-3-jiahao.os@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220422090944.52618-3-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 11:09, Hao Jia wrote:

Nitpick: I would change the message slightly into something like:

sched/deadline: Remove superfluous rq clock update in push_dl_task()

> The change to call update_rq_clock() before activate_task()
> commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
> when pushing a task") is no longer needed since commit f4904815f97a
> ("sched/deadline: Fix double accounting of rq/running bw in push & pull")
> removed the add_running_bw() before the activate_task().
> 
> So we remove some comments that are no longer needed and update
> rq clock in activate_task().
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> ---
>  kernel/sched/deadline.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fb4255ae0b2c..8eb694ed7ac1 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2319,13 +2319,7 @@ static int push_dl_task(struct rq *rq)
>  
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, later_rq->cpu);
> -
> -	/*
> -	 * Update the later_rq clock here, because the clock is used
> -	 * by the cpufreq_update_util() inside __add_running_bw().
> -	 */
> -	update_rq_clock(later_rq);
> -	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> +	activate_task(later_rq, next_task, 0);
>  	ret = 1;
>  
>  	resched_curr(later_rq);

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
