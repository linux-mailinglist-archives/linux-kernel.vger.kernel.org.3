Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD67553E72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiFUWYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFUWYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:24:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DE3136C;
        Tue, 21 Jun 2022 15:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0435AB81A3C;
        Tue, 21 Jun 2022 22:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B592BC3411C;
        Tue, 21 Jun 2022 22:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655850290;
        bh=GbMYqswrDIdbGM/zoDx9HZJB7r7/bOKYSyqfpzUFhkQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VO+rKTvzMbX16ThYPoWq1o7rA8LWuBa75uYAsl8MLNcmoWIVSJDTV1hkFAAl1E8VD
         lFidtCrSaDSr/oQSACUt9BTR7PcRJ2ioEsgfqQoYI16FnLm6kz8ixd4DIGLUJSGAV0
         norFYIx2uigm4fBsxjfACRo+v8TcbYRuB9FnQaCFQBKR2EHkh409x4mQFXX4KChXx8
         0sTboDCIUosInAz8nyVd0kvWR22GJGs31+bDdAglQGdk/hAwZkns6hHEFwlDPH+Xs/
         glbpN5DPuP3Ao2z2rfSRE6pcWb3qE28dQA05wA+mLqns2zZAl63nMnhlk9rtsBzT9m
         jpQ4C0nsx/94w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55C2D5C0AE0; Tue, 21 Jun 2022 15:24:50 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:24:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 08/12] rcu: Cleanup RCU urgency state for offline CPU
Message-ID: <20220621222450.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-8-paulmck@kernel.org>
 <5fa27044-9515-f8fa-511c-64014479e875@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa27044-9515-f8fa-511c-64014479e875@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 12:33:12PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > From: Zqiang <qiang1.zhang@intel.com>
> > 
> > When a CPU is slow to provide a quiescent state for a given grace
> > period, RCU takes steps to encourage that CPU to get with the
> > quiescent-state program in a more timely fashion.  These steps
> > include these flags in the rcu_data structure:
> > 
> > 1.	->rcu_urgent_qs, which causes the scheduling-clock interrupt to
> > 	request an otherwise pointless context switch from the scheduler.
> > 
> > 2.	->rcu_need_heavy_qs, which causes both cond_resched() and RCU's
> > 	context-switch hook to do an immediate momentary quiscent state.
> > 
> > 3.	->rcu_need_heavy_qs, which causes the scheduler-clock tick to
> 
> nit: s/->rcu_need_heavy_qs/->rcu_forced_tick/ ?

This one got lost in the shuffle, so I will apply it on my next rebase.

> > 	be enabled even on nohz_full CPUs with only one runnable task.
> > 
> > These flags are of course cleared once the corresponding CPU has passed
> > through a quiescent state.  Unless that quiescent state is the CPU
> > going offline, which means that when the CPU comes back online, it will
> > needlessly consume additional CPU time and incur additional latency,
> > which constitutes a minor but very real performance bug.
> > 
> > This commit therefore adds the call to rcu_disable_urgency_upon_qs()
> > that clears these flags to the CPU-hotplug offlining code path.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

And again, thank you!

							Thanx, Paul

> Thanks
> Neeraj
> 
> >   kernel/rcu/tree.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index f4a37f2032664..5445b19b48408 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4446,6 +4446,7 @@ void rcu_report_dead(unsigned int cpu)
> >   	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> >   	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
> >   		/* Report quiescent state -before- changing ->qsmaskinitnext! */
> > +		rcu_disable_urgency_upon_qs(rdp);
> >   		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> >   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >   	}
