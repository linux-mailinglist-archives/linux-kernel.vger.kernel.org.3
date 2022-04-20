Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEA508CED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355726AbiDTQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDTQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:16:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB931AF32;
        Wed, 20 Apr 2022 09:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B413B81EB2;
        Wed, 20 Apr 2022 16:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97BBC385A0;
        Wed, 20 Apr 2022 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650471199;
        bh=XKAL0LgE19cGOJZXESPqARMgpzIdUoD6v4al84Jb51k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XvyqvN0rPf042+sYnbStEDGcSEZuTaAZNV6P11vOkg2jat/l1gTkryQslD09DPOsV
         bQ62PW2TPoZLXpPj8Si0uJmiSoVb+6TQfKI1qRZxiMhfzF+Q91aOrrPgVaUDSnbIVu
         id9RothPYzgBZ5UQXnbbLIXOb1QJwPIf1ZHYeShlGdhk2NTydFg8nQT/IunAE3H8sk
         O+beQ8RUiA/wKIRaFUS4d8ZRX31lKAMBnpTCmv+hVsiqEKVqFQ9h4abugGXXtaG5qE
         Wi8iKaFsxFpVXfAKwl1EYpmhszKCWuSpWzCAd0xMiJdj9zloccEBZDLkvWYRF7hhr7
         hf+swtK+hLZQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DF815C0269; Wed, 20 Apr 2022 09:13:19 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:13:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
 <20220418225033.3944860-1-paulmck@kernel.org>
 <20220420113231.6d3202e4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420113231.6d3202e4@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:32:31AM -0400, Steven Rostedt wrote:
> On Mon, 18 Apr 2022 15:50:32 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This commit belatedly adds documentation of Tasks Rude RCU and Tasks
> > Trace RCU to RCU's requirements document.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 45278e2974c0..ff2be1ac54c4 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -2654,6 +2654,38 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
> >  three APIs are therefore implemented by separate functions that check
> >  for voluntary context switches.
> >  
> > +Tasks Rude RCU
> > +~~~~~~~~~~~~~~
> > +
> > +Some forms of tracing need to wait for all preemption-disabled regions
> > +of code running on any online CPU, including those executed when RCU is
> > +not watching.  This means that synchronize_rcu() is insufficient, and
> > +Tasks Rude RCU must be used instead.  This flavor of RCU does its work by
> > +forcing a workqueue to be scheduled on each online CPU, hence the "Rude"
> > +moniker.  And this operation is considered to be quite rude by real-time
> > +workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
> > +by battery-powered systems that don't want their idle CPUs to be awakened.
> > +
> > +The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
> > +consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
> > +and rcu_barrier_tasks_rude().
> 
> Are we going to be able to get rid of the "rude" version once we have all
> tracing in a RCU visible section?

You tell me!  ;-)

If there are no longer any users, I would be happy to get rid of it.
As of v5.18-rc1, the only user is ftrace.

> > +
> > +Tasks Trace RCU
> > +~~~~~~~~~~~~~~~
> > +
> > +Some forms of tracing need to sleep in readers, but cannot tolerate
> > +SRCU's read-side overhead, which includes a full memory barrier in both
> > +srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> > +Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> > +readers.  Real-time systems that cannot tolerate IPIs may build their
> > +kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
> > +the expense of adding full memory barriers to the read-side primitives.
> 
> If NOHZ_FULL is enabled, is there a way to also be able to have this full
> mb on RT removed as well?
> 
> > +
> > +The tasks-trace-RCU API is also reasonably compact,
> > +consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
> > +rcu_read_lock_trace_held(), call_rcu_tasks_trace(),
> > +synchronize_rcu_tasks_trace(), and rcu_barrier_tasks_trace().
> > +
> >  Possible Future Changes
> >  -----------------------
> >  
> 
> For the documentation:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I will apply this on the next rebase, thank you!

							Thanx, Paul
