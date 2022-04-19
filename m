Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D2650705B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350034AbiDSO27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349510AbiDSO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E506259;
        Tue, 19 Apr 2022 07:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A46E6128E;
        Tue, 19 Apr 2022 14:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DECC385A5;
        Tue, 19 Apr 2022 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650378323;
        bh=385UWGPgJs8E8vVjk7sIvSsiYikdStn+sRLPZRWRDow=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E/ykLEj2ASgMS2kC3AVCamcUKmdEQ3BGq3ek12FMf7etNH/zW0qSObFZDn/iM9eDi
         devv0LJZNKPEg4CJXphoPHaze2/29SG7ZBrHamEYMLO2Ppgzm14NBrP0yPEvPihZ2O
         Lzo0bG1Lpbui4EZpWo0bg3y2zRrkwdxLMdDi/zvieX1ckFeU7LNsRM3D8qSBj78xWr
         1ZFvy1u87/gD03jp6Q2GoSt3fld14S/Eb1o4DPx1sgxOJ4cFuuacvybqSAjUBTSQ1k
         Y9SOQncaFAao8ONb51Ynl6cD1KNE4Z6aVr376tvxjEBatKGo+2vK5n0fs8Y+ow3syH
         r/xZTcLU+YAuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29A3B5C031F; Tue, 19 Apr 2022 07:25:23 -0700 (PDT)
Date:   Tue, 19 Apr 2022 07:25:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH rcu 02/12] rcu: Make the TASKS_RCU Kconfig option be
 selected
Message-ID: <20220419142523.GJ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220419001123.GA3949851@paulmck-ThinkPad-P17-Gen-1>
 <20220419001233.3950188-2-paulmck@kernel.org>
 <20220419231358.2a0517ee265296a25b4305be@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419231358.2a0517ee265296a25b4305be@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:13:58PM +0900, Masami Hiramatsu wrote:
> On Mon, 18 Apr 2022 17:12:23 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Currently, any kernel built with CONFIG_PREEMPTION=y also gets
> > CONFIG_TASKS_RCU=y, which is not helpful to people trying to build
> > preemptible kernels of minimal size.
> > 
> > Because CONFIG_TASKS_RCU=y is needed only in kernels doing tracing of
> > one form or another, this commit moves from TASKS_RCU deciding when it
> > should be enabled to the tracing Kconfig options explicitly selecting it.
> > This allows building preemptible kernels without TASKS_RCU, if desired.
> > 
> > This commit also updates the SRCU-N and TREE09 rcutorture scenarios
> > in order to avoid Kconfig errors that would otherwise result from
> > CONFIG_TASKS_RCU being selected without its CONFIG_RCU_EXPERT dependency
> > being met.
> 
> Thanks for fixing this dependency.
> 
> This looks good to me (for kprobe part)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

> Thank you,
> 
> > 
> > [ paulmck: Apply BPF_SYSCALL feedback from Andrii Nakryiko. ]
> > 
> > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > --- Update SRCU-N and TREE09 to avoid Kconfig errors.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  arch/Kconfig                                          | 1 +
> >  kernel/bpf/Kconfig                                    | 1 +
> >  kernel/rcu/Kconfig                                    | 3 ++-
> >  kernel/trace/Kconfig                                  | 1 +
> >  tools/testing/selftests/rcutorture/configs/rcu/SRCU-N | 2 ++
> >  tools/testing/selftests/rcutorture/configs/rcu/TREE09 | 2 ++
> >  6 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 29b0167c088b..1bf29ce754af 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -35,6 +35,7 @@ config KPROBES
> >  	depends on MODULES
> >  	depends on HAVE_KPROBES
> >  	select KALLSYMS
> > +	select TASKS_RCU if PREEMPTION
> >  	help
> >  	  Kprobes allows you to trap at almost any kernel address and
> >  	  execute a callback function.  register_kprobe() establishes
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index d56ee177d5f8..2dfe1079f772 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -27,6 +27,7 @@ config BPF_SYSCALL
> >  	bool "Enable bpf() system call"
> >  	select BPF
> >  	select IRQ_WORK
> > +	select TASKS_RCU if PREEMPTION
> >  	select TASKS_TRACE_RCU
> >  	select BINARY_PRINTF
> >  	select NET_SOCK_MSG if NET
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f559870fbf8b..4f665ae0cf55 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
> >  	  task-based RCU implementations.  Not for manual selection.
> >  
> >  config TASKS_RCU
> > -	def_bool PREEMPTION
> > +	def_bool 0
> > +	select IRQ_WORK
> >  	help
> >  	  This option enables a task-based RCU implementation that uses
> >  	  only voluntary context switch (not preemption!), idle, and
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 2c43e327a619..bf5da6c4e999 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -144,6 +144,7 @@ config TRACING
> >  	select BINARY_PRINTF
> >  	select EVENT_TRACING
> >  	select TRACE_CLOCK
> > +	select TASKS_RCU if PREEMPTION
> >  
> >  config GENERIC_TRACER
> >  	bool
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
> > index 2da8b49589a0..07f5e0a70ae7 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-N
> > @@ -6,3 +6,5 @@ CONFIG_PREEMPT_NONE=y
> >  CONFIG_PREEMPT_VOLUNTARY=n
> >  CONFIG_PREEMPT=n
> >  #CHECK#CONFIG_RCU_EXPERT=n
> > +CONFIG_KPROBES=n
> > +CONFIG_FTRACE=n
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE09 b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
> > index 8523a7515cbf..fc45645bb5f4 100644
> > --- a/tools/testing/selftests/rcutorture/configs/rcu/TREE09
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
> > @@ -13,3 +13,5 @@ CONFIG_DEBUG_LOCK_ALLOC=n
> >  CONFIG_RCU_BOOST=n
> >  CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> >  #CHECK#CONFIG_RCU_EXPERT=n
> > +CONFIG_KPROBES=n
> > +CONFIG_FTRACE=n
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
