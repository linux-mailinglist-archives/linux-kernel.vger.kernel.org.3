Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D921E588C51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiHCMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHCMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:42:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EA81EC4B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0954AB8211D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8445DC433C1;
        Wed,  3 Aug 2022 12:42:37 +0000 (UTC)
Date:   Wed, 3 Aug 2022 08:42:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <20220803084235.5d56d1e4@gandalf.local.home>
In-Reply-To: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Adding Paul ]

On Wed,  3 Aug 2022 09:18:45 +0800
Liu Song <liusong@linux.alibaba.com> wrote:

> From: Liu Song <liusong@linux.alibaba.com>
> 
> If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
> a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
> 128-core machine, the rcu stall warning will be triggered. Moreover,
> sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
> and no rcu stall warning will appear after adjustment.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5555e49..82c117e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8879,11 +8879,11 @@ void show_state_filter(unsigned int state_filter)
>  			sched_show_task(p);
>  	}
>  
> +	rcu_read_unlock();
>  #ifdef CONFIG_SCHED_DEBUG
>  	if (!state_filter)
>  		sysrq_sched_debug_show();

If this is just because sysrq_sched_debug_show() is very slow, does RCU
have a way to "touch" it? Like the watchdogs have? That is, to tell RCU
"Yes I know I'm taking a long time, but I'm still making forward progress,
don't complain about me". Then the sysrq_sched_debug_show() could have:

	for_each_online_cpu(cpu) {
		/*
		 * Need to reset softlockup watchdogs on all CPUs, because
		 * another CPU might be blocked waiting for us to process
		 * an IPI or stop_machine.
		 */
		touch_nmi_watchdog();
		touch_all_softlockup_watchdogs();
+		touch_rcu();
		print_cpu(NULL, cpu);
	}

??

-- Steve

>  #endif
> -	rcu_read_unlock();
>  	/*
>  	 * Only show locks if all tasks are dumped:
>  	 */

