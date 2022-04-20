Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C72508DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355948AbiDTQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiDTQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA714552B;
        Wed, 20 Apr 2022 09:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB8E61A35;
        Wed, 20 Apr 2022 16:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E59C385A1;
        Wed, 20 Apr 2022 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650473327;
        bh=aTVUVnCHDuFelpgC+spUrc0/XMq4SIg7zpfT/2UQNw8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ayo3PmREzImBbMieZjH97rBGbdkmxwSJ2f/5BiY6CnlAXxaHuL58I1N3mOfGVLVci
         sHpmUV5WTDQS1+2SQAzyVXAWl4lq6kJAo3bAq2TQzSZX4Ii6z7zHIbmlkP+PgHwjA/
         jItz9O1dto6oyyE5F6u1KUfvPVIVXVQT4idN5ZA0/1xdC7UU6HZaEslJfcoUzyHCUw
         X7TBNkHOuNLM/t57R4rylvHr4scvUtf8YehCc/iSzHI7ssX7h0+y52Bp9ihdChXgxR
         lKlUnoNnGfxr0g50auJf8rE6xaobZUAI2zQcqW+vr2fY4m7mYIE/64eMlnm0XPHBT0
         ojFfm2HkfkRWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0B58B5C0269; Wed, 20 Apr 2022 09:48:47 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:48:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420164847.GG4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
 <20220418225033.3944860-1-paulmck@kernel.org>
 <20220420113231.6d3202e4@gandalf.local.home>
 <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <20220420121906.13752d3e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420121906.13752d3e@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:19:06PM -0400, Steven Rostedt wrote:
> On Wed, 20 Apr 2022 09:13:19 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > +The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
> > > > +consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
> > > > +and rcu_barrier_tasks_rude().  
> > > 
> > > Are we going to be able to get rid of the "rude" version once we have all
> > > tracing in a RCU visible section?  
> > 
> > You tell me!  ;-)
> > 
> > If there are no longer any users, I would be happy to get rid of it.
> > As of v5.18-rc1, the only user is ftrace.
> > 
> > > > +
> > > > +Tasks Trace RCU
> > > > +~~~~~~~~~~~~~~~
> > > > +
> > > > +Some forms of tracing need to sleep in readers, but cannot tolerate
> > > > +SRCU's read-side overhead, which includes a full memory barrier in both
> > > > +srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> > > > +Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> > > > +readers.  Real-time systems that cannot tolerate IPIs may build their
> > > > +kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
> > > > +the expense of adding full memory barriers to the read-side primitives.  
> > > 
> > > If NOHZ_FULL is enabled, is there a way to also be able to have this full
> > > mb on RT removed as well?

Ah, I did miss this question, apologies.  The tradeoff is IPIs during
each Tasks Trace RCU grace period on the one hand or the read-side
memory barrier on the other.

CONFIG_TASKS_TRACE_RCU_READ_MB=y gets you the read-side memory barriers.

CONFIG_TASKS_TRACE_RCU_READ_MB=n gets you the IPIs.

Choose wisely!  ;-)

More seriously, I could easily imagine an RT system being set up so that
Tasks Trace RCU grace periods never happen while the real-time application
is running.  This requires the system administrator being careful what
tracing facilities are used that those application is running, but
it seems doable to me.

Such an RT system could build with CONFIG_TASKS_TRACE_RCU_READ_MB=n to
avoid the read-side memory barriers, but also avoiding the IPIs while
the application was running.

Even more seriously, if the real-time application runs in nohz_full mode,
Tasks Trace RCU will avoid IPIing it.  In that case, the kernel can be
built with CONFIG_TASKS_TRACE_RCU_READ_MB=n and avoid both the read-side
memory barriers and the IPIs.

And the final bit of seriousness for this email, if your real-time
application didn't have a time-critical CPU-bound component, it might
be possible to avoid both read-side memory barriers and IPIs by
adjusting the rcu_tasks_trace_qs() code in the context-switch hook.

> Hmm, if we no longer need the rude version due to noinstr, if then we need
> to use something that adds full memory barriers at *every function call*
> then I rather keep the rude version.

A full memory barrier at every function call does sound more heavy weight
than would be good.  ;-)

							Thanx, Paul
