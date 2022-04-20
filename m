Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1FD508F01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358146AbiDTSFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbiDTSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:05:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29153FDA2;
        Wed, 20 Apr 2022 11:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1695CCE1F6D;
        Wed, 20 Apr 2022 18:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBD7C385A0;
        Wed, 20 Apr 2022 18:02:27 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:02:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420140226.32a10ece@gandalf.local.home>
In-Reply-To: <20220420164847.GG4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
        <20220418225033.3944860-1-paulmck@kernel.org>
        <20220420113231.6d3202e4@gandalf.local.home>
        <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
        <20220420121906.13752d3e@gandalf.local.home>
        <20220420164847.GG4285@paulmck-ThinkPad-P17-Gen-1>
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

On Wed, 20 Apr 2022 09:48:47 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > > If NOHZ_FULL is enabled, is there a way to also be able to have this full
> > > > mb on RT removed as well?  
> 
> Ah, I did miss this question, apologies.  The tradeoff is IPIs during
> each Tasks Trace RCU grace period on the one hand or the read-side
> memory barrier on the other.
> 
> CONFIG_TASKS_TRACE_RCU_READ_MB=y gets you the read-side memory barriers.
> 
> CONFIG_TASKS_TRACE_RCU_READ_MB=n gets you the IPIs.
> 
> Choose wisely!  ;-)

Yes, I figured this part.

> 
> More seriously, I could easily imagine an RT system being set up so that
> Tasks Trace RCU grace periods never happen while the real-time application
> is running.  This requires the system administrator being careful what
> tracing facilities are used that those application is running, but
> it seems doable to me.

Not something I would want to put onto the system administrator.

> 
> Such an RT system could build with CONFIG_TASKS_TRACE_RCU_READ_MB=n to
> avoid the read-side memory barriers, but also avoiding the IPIs while
> the application was running.
> 
> Even more seriously, if the real-time application runs in nohz_full mode,
> Tasks Trace RCU will avoid IPIing it.  In that case, the kernel can be
> built with CONFIG_TASKS_TRACE_RCU_READ_MB=n and avoid both the read-side
> memory barriers and the IPIs.

Is this currently the case?

> 
> And the final bit of seriousness for this email, if your real-time
> application didn't have a time-critical CPU-bound component, it might
> be possible to avoid both read-side memory barriers and IPIs by
> adjusting the rcu_tasks_trace_qs() code in the context-switch hook.
> 
> > Hmm, if we no longer need the rude version due to noinstr, if then we need
> > to use something that adds full memory barriers at *every function call*
> > then I rather keep the rude version.  
> 
> A full memory barrier at every function call does sound more heavy weight
> than would be good.  ;-)

Hmm, I just realized that the function tracer can not use any "reader side"
tracing. Thus, I wonder if we can modify the rude side to be a bit less
rude? That is, what can be changed if the reader always happens inside an
"RCU is watching" location but still has the requirement that it can not
tell RCU it started "reading" and allows preemption?

The issue with function tracing is that the "read side" starts at the
location that calls the trampoline (aka fentry or mcount call). Where it's
either a nop or a call to the trampoline. To free the trampoline, we would
still need to wait for all locations watched by RCU to schedule. Would it
still be rude to do so? That is, we do not need to worry about idle tasks
nor NOHZ_FULL tasks.

-- Steve

