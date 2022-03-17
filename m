Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685014DCB20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiCQQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiCQQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:21:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAFC20DB16;
        Thu, 17 Mar 2022 09:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97818B81F25;
        Thu, 17 Mar 2022 16:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396BBC340EF;
        Thu, 17 Mar 2022 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647534034;
        bh=/+CHBTGFlXDKJZW/jGmX5qQz2Po3iveVuzuR9CMSbek=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JJoaAiuewj4hihUicGFfgIeEGWmgHBMKmb7ZX4njN9MGBZBJTioXnQua7fSnVIxUx
         g6FsIaOwoTtrR6BPOGkUctg77v3LcxEHTMZRSR2cYvhJYXKk5o1F9ynfXmZn+ZXk6C
         na0ggp+zkr0utwZjq8umbm04+oc0TKzJYBEKIObEftZ7RoqCOZ7qaI17GlCGDdiOdJ
         rqGYsbVW+dF7fkKgwYUUv9Igx+AQ6FoAAVwxu71xKeepppgmFZMUu7fYy/F85gUYRr
         xKse3T8Nsp4r69wOKn03/sA3Vfv1vcPgV+46qSZCsuKYwOcCTJixROORygHB07q3jf
         M/+tMKZ9Cqbbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D37B65C051B; Thu, 17 Mar 2022 09:20:33 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:20:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU: undefined reference to irq_work_queue
Message-ID: <20220317162033.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:24:42PM +0000, Hyeonggon Yoo wrote:
> On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
> > > Hello RCU folks,
> > > 
> > > I like to use minimal configuration for kernel development.
> > > when building with tinyconfig + CONFIG_PREEMPT=y on arm64:
> > > 
> > > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > > make: *** [Makefile:1155: vmlinux] Error 1
> > > 
> > > It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.
> > 
> > Indeed it does!
> > 
> > And kernel/rcu/Kconfig shows why:
> > 
> > config TASKS_TRACE_RCU
> > 	def_bool 0
> > 	select IRQ_WORK
> > 	help
> > 	  This option enables a task-based RCU implementation that uses
> > 	  explicit rcu_read_lock_trace() read-side markers, and allows
> > 	  these readers to appear in the idle loop as well as on the CPU
> > 	  hotplug code paths.  It can force IPIs on online CPUs, including
> > 	  idle ones, so use with caution.
> > 
> > So the solution is to further minimize your configuration so as to
> > deselect TASKS_TRACE_RCU.
> 
> They are already not selected.

Good, thank you.

How about TASKS_RUDE_RCU, TASKS_TRACE_RCU, and TASKS_RCU_GENERIC?

> > This means making sure that both BPF and
> > the various RCU torture tests are all deselected.
> 
> I wanted to say call_rcu_tasks() can be referenced even when IRQ_WORK is not
> selected, making it fail to build.

I am guessing because TASKS_RCU_GENERIC is selected?

If so, does the patch at the end of this email help?

> > > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > > make: *** [Makefile:1155: vmlinux] Error 1
> 
> Isn't it better to fix this build failure?

But of course!  However, first I need to know exactly what is causing your
build failure.  I cannot see your .config file, so I am having to guess.

Don't get me wrong, I do have a lot of practice guessing, but it is still
just guessing.  ;-)

> It fails to build when both TASKS_TRACE_RCU and IRQ_WORK are not selected
> and PREEMPT is selected.
> 
>   │ Symbol: TASKS_TRACE_RCU [=n]                                            │
>   │ Type  : bool                                                            │
>   │ Defined at kernel/rcu/Kconfig:96                                        │
>   │ Selects: IRQ_WORK [=n]                                                  │
>   │ Selected by [n]:                                                        │
>   │   - BPF_SYSCALL [=n]                                                    │
>   │   - RCU_SCALE_TEST [=n] && DEBUG_KERNEL [=y]                            │
>   │   - RCU_TORTURE_TEST [=n] && DEBUG_KERNEL [=y]                          │
>   │   - RCU_REF_SCALE_TEST [=n] && DEBUG_KERNEL [=y]
> 
> Thanks!
> 
> > 
> > Or turn on IRQ_WORK, for example, if you need to use BPF.

Or do you already have TASKS_RCU_GENERIC deselected?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bf8e341e75b4..f559870fbf8b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -86,6 +86,7 @@ config TASKS_RCU
 
 config TASKS_RUDE_RCU
 	def_bool 0
+	select IRQ_WORK
 	help
 	  This option enables a task-based RCU implementation that uses
 	  only context switch (including preemption) and user-mode
