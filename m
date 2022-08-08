Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111758CD41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiHHSDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHHSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E5BBD;
        Mon,  8 Aug 2022 11:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE616611EF;
        Mon,  8 Aug 2022 18:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365DEC433C1;
        Mon,  8 Aug 2022 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659981792;
        bh=65sBpdeLVb6QH1HyalM98f/AiWjqmRtsN2+ZoQO/wvI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=brc6ntRPOx118YrEWYQOgW1pl0eItMiVZwpCo9NVKpYRImJ77yNjGIeoKtMa9FZgW
         P51rbUCiKydOkxTlGsXU+9SdKNixdYABofJ9DfTmwGc/nP3M+Tk4A+7YVCDU7vcdvQ
         +0eG7FNhhXmPkzCg1Kbe0KVgl6IYCzqfWhBviSVXjD1j+hIOSKmzKeZMyKAPqO9TmG
         6GI0MjP8GKZ2GsFGas8/IucZRWWOVU7Hn1HJiWCSgUlZwpPTVf532R9AO8Ygi3TSqg
         Bi2RdIaDR/TnTywft5vcvSic4DTW3pJ5kKdcgEGbuBUlG+bvATJndVsOHVKpH7fBQe
         pKeo6qQl01Dig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C3E145C128A; Mon,  8 Aug 2022 11:03:11 -0700 (PDT)
Date:   Mon, 8 Aug 2022 11:03:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Reduce the frequency of triggering irq-work for
 strict grace period
Message-ID: <20220808180311.GG2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220808022626.12825-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808022626.12825-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:26:26AM +0800, Zqiang wrote:
> For kernel built with PREEMPT_RCU=y and RCU_STRICT_GRACE_PERIOD=y,
> currently, the irq-work will be triggered by high frequency to make
> the scheduler re-evaluate and call hooks to check whether there are
> qs need to report when exit RCU read critical section in irq-disbaled
> context. however if there is no gp in progress, the irq-work trigger
> is meaningless.
> 
> This commit reduced irq-work trigger frequency by check whether the
> current CPU is not experiencing qs or there is task that blocks
> the current grace period for RCU_STRICT_GRACE_PERIOD=y kernel.
> 
> The test results are as follows:
> 
> echo rcu_preempt_deferred_qs_handler > /sys/kernel/debug/tracing/set_ftrace_filter
> echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
> insmod rcutorture.ko
> sleep 20
> rmmod rcutorture.ko
> echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
> echo > /sys/kernel/debug/tracing/set_ftrace_filter
> 
> head /sys/kernel/debug/tracing/trace_stat/function*
> 
> original:
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      838746    182650.3 us     0.217 us        0.004 us
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      841768    191138.6 us     0.227 us        0.024 us
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      828243    180455.6 us     0.217 us        0.004 us
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      810258    189158.1 us     0.233 us        0.023 us
> 
> apply patch:
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function0 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      302373    67434.95 us     0.223 us        0.001 us
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function1 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      307174    68398.34 us     0.222 us        0.002 us
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function2 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      250910    56157.42 us     0.223 us        0.002 us
> 
> ==> /sys/kernel/debug/tracing/trace_stat/function3 <==
>   Function                               Hit    Time            Avg             s^2
>   --------                               ---    ----            ---             ---
>   rcu_preempt_deferred_qs_handle      279902    62644.64 us     0.223 us        0.003 us
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Looks good, queued for testing and review, thank you!

Please check the version shown below for the usual wordsmithing.

							Thanx, Paul

------------------------------------------------------------------------

commit 1e5aa3d5d53a6b38718510cce2b91a8199303891
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Mon Aug 8 10:26:26 2022 +0800

    rcu: Avoid triggering strict-GP irq-work when RCU is idle
    
    Kernels built with PREEMPT_RCU=y and RCU_STRICT_GRACE_PERIOD=y trigger
    irq-work from rcu_read_unlock(), and the resulting irq-work handler
    invokes rcu_preempt_deferred_qs_handle().  The point of this triggering
    is to force grace periods to end quickly in order to give tools like KASAN
    a better chance of detecting RCU usage bugs such as leaking RCU-protected
    pointers out of an RCU read-side critical section.
    
    However, this irq-work triggering is unconditional.  This works, but
    there is no point in doing this irq-work unless the current grace period
    is waiting on the running CPU or task, which is not the common case.
    After all, in the common case there are many rcu_read_unlock() calls
    per CPU per grace period.
    
    This commit therefore triggers the irq-work only when the current grace
    period is waiting on the running CPU or task.
    
    This change was tested as follows on a four-CPU system:
    
            echo rcu_preempt_deferred_qs_handler > /sys/kernel/debug/tracing/set_ftrace_filter
            echo 1 > /sys/kernel/debug/tracing/function_profile_enabled
            insmod rcutorture.ko
            sleep 20
            rmmod rcutorture.ko
            echo 0 > /sys/kernel/debug/tracing/function_profile_enabled
            echo > /sys/kernel/debug/tracing/set_ftrace_filter
    
    This procedure produces results in this per-CPU set of files:
    
            /sys/kernel/debug/tracing/trace_stat/function*
    
    Sample output from one of these files is as follows:
    
      Function                               Hit    Time            Avg             s^2
      --------                               ---    ----            ---             ---
      rcu_preempt_deferred_qs_handle      838746    182650.3 us     0.217 us        0.004 us
    
    The baseline sum of the "Hit" values (the number of calls to this
    function) was 3,319,015.  With this commit, that sum was 1,140,359,
    for a 2.9x reduction.  The worst-case variance across the CPUs was less
    than 25%, so this large effect size is statistically significant.
    
    The raw data is available in the Link: URL.
    
    Link: https://lore.kernel.org/all/20220808022626.12825-1-qiang1.zhang@intel.com/
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b76076014e126..1514909cf905f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -641,7 +641,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 
 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
