Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF758A04B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiHDSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiHDSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:10:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE006BD7A;
        Thu,  4 Aug 2022 11:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A06DB82659;
        Thu,  4 Aug 2022 18:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB90C433D7;
        Thu,  4 Aug 2022 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659636599;
        bh=ubVdlOu1JerXLBxOqdY7Uq80Ing8CaFR2I2AKThWle4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gsI2Aab9sqVEyxiYj3RZjAnABNT5WtnjDIoMPh+n8jspfK8k/UPH2SYJtOLb102Q2
         mceuA3jnu28YHItQ8eGCKketiKrDvwKxBExLGvtgDsf9NDKJlBtm9A1xoswsgQm7fI
         lPJYIv/X5Yk+BQD7lO4/Z7gHZdI9HyAvuKqoht1lgWUnj5VYYCgt9EAHg3NN2tlLk0
         Yitabe6OAaHGvluoA/GngI6qMLlAqEDkHFH7qqkI0+ckVjVvArUu/HQlfEr8hnBdzl
         gfnjPeReNWYP34CN2svXURpimX/YfOuK3yXnKO/14mbz0P2AKJqCwswjNh27DsR2Ut
         OYB2aSmepFKJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E0CA75C04D0; Thu,  4 Aug 2022 11:09:58 -0700 (PDT)
Date:   Thu, 4 Aug 2022 11:09:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rcu: Display registers of self-detected stall as
 far as possible
Message-ID: <20220804180958.GQ2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220804023420.1663-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804023420.1663-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:34:18AM +0800, Zhen Lei wrote:
> v3 --> v4:
> 1. To avoid undo/redo, merge patch 1-2 in v3 into one.
> 
> v2 --> v3:
> 1. Patch 1 Add trigger_single_cpu_backtrace(cpu) in synchronize_rcu_expedited_wait()
>    Subsequently, we can see that all callers of dump_cpu_task() try
>    trigger_single_cpu_backtrace() first. Then I do the cleanup in Patch 2.
> 2. Patch 3, as Paul E. McKenney's suggestion, push the code into dump_cpu_task().
> 
> For newcomers:
> Currently, dump_cpu_task() is mainly used by RCU, in order to dump the
> stack traces of the current task of the specified CPU when a rcu stall
> is detected.
> 
> For architectures that do not support NMI interrupts, registers is not
> printed when rcu stall is self-detected. This patch series improve it.

Thank you!  I have queued both for further testing and review.  I had
to rebase them to the -rcu tree's "dev" branch.  There was one trivial
conflict, but could you please check the resulting commits, both for
my wordsmithing and to make sure that your changes still work in your
environment?  (I do not have access to that sort of hardware.)

In the future, could you please send your patches against the -rcu
tree's "dev" branch?

							Thanx, Paul

> v2:
> https://lkml.org/lkml/2022/7/27/1800
> 
> Zhen Lei (2):
>   sched/debug: Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task()
>   sched/debug: Show the registers of 'current' in dump_cpu_task()
> 
>  kernel/rcu/tree_stall.h |  8 +++-----
>  kernel/sched/core.c     | 14 ++++++++++++++
>  kernel/smp.c            |  3 +--
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.1
> 
