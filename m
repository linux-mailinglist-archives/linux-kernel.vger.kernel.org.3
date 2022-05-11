Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5452357E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiEKOaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiEKOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D8106A69;
        Wed, 11 May 2022 07:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92E166101F;
        Wed, 11 May 2022 14:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59E8C34113;
        Wed, 11 May 2022 14:29:58 +0000 (UTC)
Date:   Wed, 11 May 2022 10:29:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220511102957.56bd582b@gandalf.local.home>
In-Reply-To: <Ynu8rM42aSyGN7li@pc638.lan>
References: <YnY33nq5jl6FLFOu@pc638.lan>
        <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
        <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
        <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
        <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
        <YnldSkaWu40cVimj@pc638.lan>
        <20220510100135.62a4f7df@gandalf.local.home>
        <Ynu8rM42aSyGN7li@pc638.lan>
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

On Wed, 11 May 2022 15:39:56 +0200
Uladzislau Rezki <urezki@gmail.com> wrote:

> <snip>
>  rcuop/6-54  [000] .N..  183.753018: rcu_invoke_callback:  rcu_preempt rhp=0xffffff88ffd440b0 func=__d_free.cfi_jt
>  rcuop/6-54  [000] .N..  183.753020: rcu_invoke_callback:  rcu_preempt rhp=0xffffff892ffd8400 func=inode_free_by_rcu.cfi_jt
>  rcuop/6-54  [000] .N..  183.753021: rcu_invoke_callback:  rcu_preempt rhp=0xffffff89327cd708 func=i_callback.cfi_jt
>  ... 
>  rcuop/6-54  [000] .N..  183.755941: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c5a968 func=i_callback.cfi_jt
>  rcuop/6-54  [000] .N..  183.755942: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c4bd20 func=__d_free.cfi_jt
>  rcuop/6-54  [000] dN..  183.755944: rcu_batch_end:        rcu_preempt CBs-invoked=2112 idle=>c<>c<>c<>c<
>  rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      Start context switch
>  rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      End context switch
> <snip>
> 
> i spent some time in order to understand why the context was not switched,
> even though the "rcuop" kthread was marked as TIF_NEED_RESCHED and an IPI
> was sent to the CPU_0 to reschedule. The last "." in latency field shows
> that a context has not disabled any preemption. So everything should be fine.
> 
> An explanation is that a local_bh_disable() modifies the current_thread_info()->preempt.count
> so a task becomes non preemtable but the ftrace does not provide any signal about
> it. So i was fooled for some time by my tracer logs.
> 
> Do you have any thoughts about it? Should it be solved or signaled
> somehow that a task in fact is not preemtable if a counter > 0?

Hmm, it should show it in the first part (where the 'd' is). Is this a
snapshot from the kernel or from trace-cmd?

-- Steve
