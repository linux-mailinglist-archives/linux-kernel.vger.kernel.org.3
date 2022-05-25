Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982053403D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiEYPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbiEYPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C991B0A4A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA023619FE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C93C385B8;
        Wed, 25 May 2022 15:16:53 +0000 (UTC)
Date:   Wed, 25 May 2022 11:16:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sched: Fix a typo in scheduler
Message-ID: <20220525111651.6c8f8c31@gandalf.local.home>
In-Reply-To: <20220521125420.12683-1-wudaemon@163.com>
References: <20220521125420.12683-1-wudaemon@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 12:54:20 +0000
Junwen Wu <wudaemon@163.com> wrote:

> Nice value is MIN_NICE(-20) to MAX_NICE(19), it better uses
> int instead of long.

First of all, the subject is completely incorrect. There's no typo to be
fixed. Second, why do you think it's better to use an int instead of long?
Long is the natural word size of an architecture.

Now perhaps for consistency, we could fix all the locations that switch
between long and int. For example, the sys_nice() definition has nice and
retval as long and are set by functions that return int. But then again,
sys_nice() returns long (and that cannot be changed).

Unless there's a real issue to be fixed (which I do not see one), I'd say
leave it as is, because this change is doing nothing but adding unnecessary
churn to the git repo.

Hence, NAK.

-- Steve


> 
> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---
>  include/linux/sched.h | 2 +-
>  kernel/sched/core.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 75ba8aa60248..cffc7cbed987 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1830,7 +1830,7 @@ static inline int dl_task_check_affinity(struct task_struct *p, const struct cpu
>  #endif
>  
>  extern int yield_to(struct task_struct *p, bool preempt);
> -extern void set_user_nice(struct task_struct *p, long nice);
> +extern void set_user_nice(struct task_struct *p, int nice);
>  extern int task_prio(const struct task_struct *p);
>  
>  /**
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fcf0c180617c..15c1b63d771b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6888,7 +6888,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
>  }
>  #endif
>  
> -void set_user_nice(struct task_struct *p, long nice)
> +void set_user_nice(struct task_struct *p, int nice)
>  {
>  	bool queued, running;
>  	int old_prio;

