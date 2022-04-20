Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB1508D12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380485AbiDTQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380415AbiDTQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E57433A2D;
        Wed, 20 Apr 2022 09:19:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DB1619AF;
        Wed, 20 Apr 2022 16:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4330C385A0;
        Wed, 20 Apr 2022 16:19:07 +0000 (UTC)
Date:   Wed, 20 Apr 2022 12:19:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420121906.13752d3e@gandalf.local.home>
In-Reply-To: <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
        <20220418225033.3944860-1-paulmck@kernel.org>
        <20220420113231.6d3202e4@gandalf.local.home>
        <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
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

On Wed, 20 Apr 2022 09:13:19 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > +The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
> > > +consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
> > > +and rcu_barrier_tasks_rude().  
> > 
> > Are we going to be able to get rid of the "rude" version once we have all
> > tracing in a RCU visible section?  
> 
> You tell me!  ;-)
> 
> If there are no longer any users, I would be happy to get rid of it.
> As of v5.18-rc1, the only user is ftrace.
> 
> > > +
> > > +Tasks Trace RCU
> > > +~~~~~~~~~~~~~~~
> > > +
> > > +Some forms of tracing need to sleep in readers, but cannot tolerate
> > > +SRCU's read-side overhead, which includes a full memory barrier in both
> > > +srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> > > +Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> > > +readers.  Real-time systems that cannot tolerate IPIs may build their
> > > +kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
> > > +the expense of adding full memory barriers to the read-side primitives.  
> > 
> > If NOHZ_FULL is enabled, is there a way to also be able to have this full
> > mb on RT removed as well?
> >   

Hmm, if we no longer need the rude version due to noinstr, if then we need
to use something that adds full memory barriers at *every function call*
then I rather keep the rude version.

-- Steve
