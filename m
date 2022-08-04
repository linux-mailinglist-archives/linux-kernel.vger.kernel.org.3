Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAE58951D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiHDAHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiHDAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640C474E5;
        Wed,  3 Aug 2022 17:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB626170A;
        Thu,  4 Aug 2022 00:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF6FC433C1;
        Thu,  4 Aug 2022 00:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659571620;
        bh=Y9eQwL1+HZw033EMRF5penmB6F7vfzbm6rSPvrWcNOc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iATBZ8r9/0ed92C4XDiwuJl9Ve3G7jtmJtBWxN37Q4PhAaOFu5zoe9wka4xnmGgM3
         eDLmlPBYspR7dUFdQqPM/FbXT7T4PjptumbXRKnfD4thrYcv5vkei6wxNtP5MispBl
         JL57yUCgQOqC7pUzTDJ71zYeMYjtmJKQJgf1QmWsayk5TdNf6ok+4qT6qV5T6ymUMi
         PCLr8YIUZTusOZJi7M0smqFm9d1xJC8VM4ljGMJGN8AzwOZT0bw7H1GiavmzhJRrxz
         Ft67ukkoymdBdGLPeZIzEesp3NxuU5GtRUzpr+DW5b9ttl2Q4+9+dLzFhkI/YoukRk
         rrUlAIu1xWJCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4DBD45C092A; Wed,  3 Aug 2022 17:07:00 -0700 (PDT)
Date:   Wed, 3 Aug 2022 17:07:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
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
Subject: Re: [PATCH v3 1/3] rcu/exp: Use NMI to get the backtrace of
 cpu_curr(other_cpu) first
Message-ID: <20220804000700.GM2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220730102330.1255-1-thunder.leizhen@huawei.com>
 <20220730102330.1255-2-thunder.leizhen@huawei.com>
 <20220801231415.GC2860372@paulmck-ThinkPad-P17-Gen-1>
 <1fd08a9a-fd2b-2608-da55-5bc526515131@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd08a9a-fd2b-2608-da55-5bc526515131@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:06:00AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/8/2 7:14, Paul E. McKenney wrote:
> > On Sat, Jul 30, 2022 at 06:23:28PM +0800, Zhen Lei wrote:
> >> The backtrace of cpu_curr(other_cpu) is unwinded based on the 'fp' saved
> >> during its last switch-out. For the most part, it's out of date. So try
> >> to use NMI to get the backtrace first, just like those functions in
> >> "tree_stall.h" did. Such as rcu_dump_cpu_stacks().
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > 
> > Much better, thank you!
> > 
> >> ---
> >>  kernel/rcu/tree_exp.h | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> >> index 0f70f62039a9090..21381697de23f0b 100644
> >> --- a/kernel/rcu/tree_exp.h
> >> +++ b/kernel/rcu/tree_exp.h
> >> @@ -665,7 +665,8 @@ static void synchronize_rcu_expedited_wait(void)
> >>  				mask = leaf_node_cpu_bit(rnp, cpu);
> >>  				if (!(READ_ONCE(rnp->expmask) & mask))
> >>  					continue;
> >> -				dump_cpu_task(cpu);
> >> +				if (!trigger_single_cpu_backtrace(cpu))
> >> +					dump_cpu_task(cpu);
> > 
> > But why not just leave this unchanged, rather than adding the call to
> > trigger_single_cpu_backtrace() in this patch and then removing it in
> > the next patch?
> 
> To make the patch clear and easy to describe. Otherwise, I need to
> give an additional description of it in the next patch, because I
> searched all dump_cpu_task(). This seems to make the next patch
> less simple.
> 
> Some of the patch sets I've seen have been done step by step like
> this. But I can't find it now.
> 
> On the other hand, this patch is a small fix. Earlier versions may
> only backport it, not the next cleanup patch.

You do have the option of doing a Cc to stable to control the backporting,
if that is a potential issue for you.

On the commit log, just say that the one use case already avoided doing
the trigger_single_cpu_backtrace(), and thus did not need to be updated.

So please resend the series, but without the undo/redo.  There would
thus be two patches rather than three, but there are plenty of other
things that need fixing anyway.

							Thanx, Paul

> >>  			}
> >>  		}
> >>  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
