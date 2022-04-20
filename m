Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27C508F95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381541AbiDTSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbiDTSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5722B3A;
        Wed, 20 Apr 2022 11:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0CE660C77;
        Wed, 20 Apr 2022 18:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F1AC385A1;
        Wed, 20 Apr 2022 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650479847;
        bh=4EenesDThqJTFTZ0cCZkHpMagQ9TLUbr8Pe+ltgITV4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T/XdlTe8pauPi6UWDSa9QsQEezZZ3TEXH+28Jz5wdNZhJSozRrKeL/eN8zg334aUy
         MUf2KTm8vYHCdACt1knV9kjUQkkJChQZK1mfirtbUfdynG/eUGwv4veQcJvspaVlkR
         dxNMlf91JskFADaaj1ZKq7GF7eFfWcuUtp3Tvs51MLNbRHr7/0sCgeZ6M0U0mhyfxM
         TDCLFTHjM4e9WYbZhgONskK4l2D+EuKMATxIFBmpJrTzrCuArxvTsZEgnSAa/icvLN
         91SJQvgKvx4aE8UfJKL2IA0IVdRsWk3vkoBN3xBg2QLfO7/atLPVd1/gj6Bl/a4y9I
         qa0OtlecffxdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A875D5C0562; Wed, 20 Apr 2022 11:37:26 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:37:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420183726.GJ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
 <20220418225033.3944860-1-paulmck@kernel.org>
 <20220420113231.6d3202e4@gandalf.local.home>
 <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <20220420121906.13752d3e@gandalf.local.home>
 <20220420164847.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220420140226.32a10ece@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140226.32a10ece@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:02:26PM -0400, Steven Rostedt wrote:
> On Wed, 20 Apr 2022 09:48:47 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > > If NOHZ_FULL is enabled, is there a way to also be able to have this full
> > > > > mb on RT removed as well?  
> > 
> > Ah, I did miss this question, apologies.  The tradeoff is IPIs during
> > each Tasks Trace RCU grace period on the one hand or the read-side
> > memory barrier on the other.
> > 
> > CONFIG_TASKS_TRACE_RCU_READ_MB=y gets you the read-side memory barriers.
> > 
> > CONFIG_TASKS_TRACE_RCU_READ_MB=n gets you the IPIs.
> > 
> > Choose wisely!  ;-)
> 
> Yes, I figured this part.

Very good!  ;-)

> > More seriously, I could easily imagine an RT system being set up so that
> > Tasks Trace RCU grace periods never happen while the real-time application
> > is running.  This requires the system administrator being careful what
> > tracing facilities are used that those application is running, but
> > it seems doable to me.
> 
> Not something I would want to put onto the system administrator.

Indeed, I could imagine cases where this restriction would not be welcome.

> > Such an RT system could build with CONFIG_TASKS_TRACE_RCU_READ_MB=n to
> > avoid the read-side memory barriers, but also avoiding the IPIs while
> > the application was running.
> > 
> > Even more seriously, if the real-time application runs in nohz_full mode,
> > Tasks Trace RCU will avoid IPIing it.  In that case, the kernel can be
> > built with CONFIG_TASKS_TRACE_RCU_READ_MB=n and avoid both the read-side
> > memory barriers and the IPIs.
> 
> Is this currently the case?

Yes.

There are of course races where the IPI might be sent due to some task
other than the application running, but where the IPI arrives after
that task is done and the application is once again running in nohz_full
userspace mode, but once the application is going, no IPIs will be sent.

> > And the final bit of seriousness for this email, if your real-time
> > application didn't have a time-critical CPU-bound component, it might
> > be possible to avoid both read-side memory barriers and IPIs by
> > adjusting the rcu_tasks_trace_qs() code in the context-switch hook.
> > 
> > > Hmm, if we no longer need the rude version due to noinstr, if then we need
> > > to use something that adds full memory barriers at *every function call*
> > > then I rather keep the rude version.  
> > 
> > A full memory barrier at every function call does sound more heavy weight
> > than would be good.  ;-)
> 
> Hmm, I just realized that the function tracer can not use any "reader side"
> tracing. Thus, I wonder if we can modify the rude side to be a bit less
> rude? That is, what can be changed if the reader always happens inside an
> "RCU is watching" location but still has the requirement that it can not
> tell RCU it started "reading" and allows preemption?

This was the original motivation for Tasks RCU, in which voluntary context
switches (but not preemptions) are quiescent states.  But this does not
send IPIs because it instead relies on the memory ordering provided by
the scheduler.

This flavor of RCU does not care about whether or not RCU is watching,
but it does ignore idle tasks, which no not necessarily ever do voluntary
context switches, for example, when a given CPU remains idle for a long
time.

But the comments on schedule_idle() look like they were set up to
try to do something about this.  I don't see how they do without
that CPU coming out of idle, though.  So what am I missing?

> The issue with function tracing is that the "read side" starts at the
> location that calls the trampoline (aka fentry or mcount call). Where it's
> either a nop or a call to the trampoline. To free the trampoline, we would
> still need to wait for all locations watched by RCU to schedule. Would it
> still be rude to do so? That is, we do not need to worry about idle tasks
> nor NOHZ_FULL tasks.

The original purpose of RCU Tasks Rude was to deal with the idle tasks,
given that RCU Tasks dealt only with the non-idle tasks.

Or is there a trick that I missed?

							Thanx, Paul
