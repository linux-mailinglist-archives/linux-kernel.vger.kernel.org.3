Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485884D6EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiCLMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiCLMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:17:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01320C183
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tIW40NX0q6YMrlyMHLkm14DA2URwvXBl2CCOrpycC8w=; b=mIKFl/nAvWnGaLh2kZ/w7Ho7wp
        sVoTZ67KQdoOtbn6XLOignZLDxHsi4AnAtWSRCWzg4SFt+akQW5poIqoAQECOutdsBnWNSfGr9Ihp
        YILsAHuHLZTDG7c4M5BjQ+DsjUnLyw9/SvPQkj5z9sFrD5wTZXqNsWF3depaj+7nB4sKcQmtg/ayZ
        CJpsJ3nfBiv5DHd7LhfWJR7OBu6pMwQj3emg4NFljW0vaQTWmaXrO3H8S9eiBi6odcqzB2Y4pwU/x
        ug3WnIZHU5fUoP0P5cXtkXNI0+i4Q7zdXeValGLuNlDm/Jxc7erUzWDgizcNmhDxoBd0hfGJJBT9d
        JL+gFbTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT0ej-000ABf-RP; Sat, 12 Mar 2022 12:15:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73CAD98791D; Sat, 12 Mar 2022 13:15:33 +0100 (CET)
Date:   Sat, 12 Mar 2022 13:15:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <20220312121533.GD6235@worktop.programming.kicks-ass.net>
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
 <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
 <20220308234403.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <Yim6nUmfGk5FHv6K@hirez.programming.kicks-ass.net>
 <20220310150152.GL4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310150152.GL4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:01:52AM -0800, Paul E. McKenney wrote:

> > > > > ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> > > > 
> > > > Arguably, with the flavours folded again, rcu_dereference_check() ought
> > > > to default include rcu_read_lock_sched_held() or its equivalent I
> > > > suppose.
> > > > 
> > > > Paul?
> > > 
> > > That would reduce the number of warnings, but it also would hide bugs.
> > > 
> > > So, are you sure you really want this?
> > 
> > I don't understand... Since the flavours got merged regular RCU has it's
> > quescent state held off by preempt_disable. So how can relying on that
> > cause bugs?
> 
> Somene forgets an rcu_read_lock() and there happens to be something
> like a preempt_disable() that by coincidence covers that particular
> rcu_dereference().  The kernel therefore doesn't complain.  That someone
> goes on to other things, maybe even posthumously.  Then some time later
> the preempt_disable() goes away, for good and sufficient reasons.
> 
> Good luck figuring out where to put the needed rcu_read_lock() and
> rcu_read_unlock().

Well, that's software engineering for you. Also in that case the warning
will work as expected. Then figuring out how to fix it is not the
problem of the warning -- that worked as advertised.

(also, I don't think it'll be too hard, you just gotta figure out which
object is rcu protected -- the warning gives you this, where the lookup
happens -- again the warning helps, and how long it's used for, all
relatively well definted things)

I don't see a problem. No bugs hidden.

> > And if we can rely on that, then surely rcu_dereferenced_check() ought
> > to play by the same rules, otherwise we get silly warnings like these at
> > hand.
> > 
> > Specifically, we removed the rcu_read_lock() here because this has
> > rq->lock held, which is a raw_spinlock_t which very much implies preempt
> > disable, on top of that, it's also an IRQ-safe lock and thus IRQs will
> > be disabled.
> > 
> > There is no possible way for RCU to make progress.
> 
> Then let's have that particular rcu_dereference_check() explicitly state
> what it needs, which seems to be either rcu_read_lock() on the one hand.
> Right now, that could be just this:
> 
> 	p = rcu_dereference_check(gp, rcu_read_lock_sched_held());
> 
> Or am I missing something here?

That will work; I just don't agree with it. Per the rules of RCU it is
entirely correct to mix rcu_read_lock() and preempt_disable() (or
anything that implies the same). So I strongly feel that
rcu_dereference() should not warn about obviously correct code. Why
would we need to special case this ?
