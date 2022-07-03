Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB6564818
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiGCOTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:19:48 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083122DF0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:19:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VIBiDcp_1656857979;
Received: from 30.30.96.30(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VIBiDcp_1656857979)
          by smtp.aliyun-inc.com;
          Sun, 03 Jul 2022 22:19:41 +0800
Message-ID: <a18ec752-352d-9f76-22f6-524933949071@linux.alibaba.com>
Date:   Sun, 3 Jul 2022 22:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] sched/core: Fix the bug that task won't enqueue into
 core tree when update cookie
Content-Language: en-US
From:   cruzzhao <cruzzhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
In-Reply-To: <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping... This bug really affects the performance, and is this bugfix correct?

在 2022/6/28 下午3:57, Cruz Zhao 写道:
> In function sched_core_update_cookie(), a task will enqueue into the
> core tree only when it enqueued before, that is, if an uncookied task
> is cookied, it will not enqueue into the core tree until it enqueue
> again, which will result in unnecessary force idle.
> 
> Here follows the scenario:
>   CPU x and CPU y are a pair of SMT siblings.
>   1. Start task a running on CPU x without sleeping, and task b and
>      task c running on CPU y without sleeping.
>   2. We create a cookie and share it to task a and task b, and then
>      we create another cookie and share it to task c.
>   3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched
> 
> And we will find out that core_forceidle_sum of task a takes 30%
> time of the sampling period, which shouldn't happen as task a and b
> have the same cookie.
> 
> Then we migrate task a to CPU x', migrate task b and c to CPU y', where
> CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
> will found out that core_forceidle_sum of task a and b are almost zero.
> 
> To solve this problem, we enqueue the task into the core tree if it's
> on rq.
> 
> Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  kernel/sched/core_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> index 38a2cec..ba2466c 100644
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -75,7 +75,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
>  	old_cookie = p->core_cookie;
>  	p->core_cookie = cookie;
>  
> -	if (enqueued)
> +	if (task_on_rq_queued(p))
>  		sched_core_enqueue(rq, p);
>  
>  	/*
