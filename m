Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481554DDBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiCROoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiCROoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:44:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3332E5774;
        Fri, 18 Mar 2022 07:43:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t14so5209894pgr.3;
        Fri, 18 Mar 2022 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nrjSRmwoPXm9IXez3B/MaglDMOOF6v3FYdXaRwm67HA=;
        b=eLDDVu9ZuvuLkGIST++mBWWLjCy/VLhXaBS8g6MpgUmLzKluGxJ25YGKwYkodQEU51
         NZblYY23TRSQjBdg8MVsKnchLi2OvQ0v6u5AWti7m/M/TIlQJ1fJnJ0UNyx4/CXqAhJj
         C86JdIwnpFefgq81464bJMi/Sw2s7Ux616j5sBJuwXyan5fI/aw8i4glVrs0vCuKC+VS
         /R1EjGvXjS6basgBXD62BDqIoof92BY9wSW5HiSsaSaL1pfqkf5J/poNeFD8rz3Zwo92
         QQgG0OKLCv9BEk+KFvci7ucgtEXMKaUbmL33M6xrYdia2vvWFm/8uLndtdzzeJafwQ6e
         Z3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nrjSRmwoPXm9IXez3B/MaglDMOOF6v3FYdXaRwm67HA=;
        b=sOc1Ab+WejQJ/MmTwb0O/vrxHW6trqWxKQY8RQFg6vBJaJBVCY6GZnjbRqcOGjm0Rg
         XjGfCJXkiOy/MoIJnrU6IJe51HhJZ6bJyR+G8tjKx4HHc8VHkgITlUlIzl8bhJ1B7Rdn
         C4ghy5Ez9lFsFZv4z2NNtxiiHczET5iTs1t7gHEE93EYrYWajDc0SexqbRTX9+K4USv2
         zCwtTM6BTbfofj4/fBST/5SEwgG1D3HOsDlXeZfaC2SiFALvuTq+Arm8kzsCSQwT6KEv
         w0WuXoBGqsbN6dSnyJVOjSN2YOOk9uIKJghdXBVGC0HUvyI53xI3HPE99ltL8NilZNP7
         +J6Q==
X-Gm-Message-State: AOAM533JyWbeMCeJTAWpaDYZmrF9AcojPT3nPWbxPPqQofC/k9ijyGV9
        6p0Mk49z+dDycsBXT7zra0A=
X-Google-Smtp-Source: ABdhPJz2GoQsyYrWQ312FD2ddDQF1giO9+21WQTyXIp5nBVMjID6GnNjDJQLHzHbq7vHIpUFEtFB1Q==
X-Received: by 2002:aa7:942d:0:b0:4fa:662c:6621 with SMTP id y13-20020aa7942d000000b004fa662c6621mr5892856pfo.25.1647614583969;
        Fri, 18 Mar 2022 07:43:03 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id e19-20020a637453000000b003821bdb8103sm3392015pgn.83.2022.03.18.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 07:43:03 -0700 (PDT)
Date:   Fri, 18 Mar 2022 14:42:58 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu <rcu@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RCU: undefined reference to irq_work_queue
Message-ID: <YjSaciKQVuyaLqUa@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317140000.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNSuprCqjAgGgqB@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317162033.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <YjNll+Iv++LORS0n@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <20220317173621.GQ4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zu3Qiqtnw=DRnFUig8xO3WtvKuVkf=gqQ6kRihOmDTLQ@mail.gmail.com>
 <20220317205339.GT4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317205339.GT4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:53:39PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 18, 2022 at 04:41:59AM +0800, Zhouyi Zhou wrote:
> > hi
> > 
> > On Fri, Mar 18, 2022 at 4:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Mar 17, 2022 at 04:45:11PM +0000, Hyeonggon Yoo wrote:
> > > > On Thu, Mar 17, 2022 at 09:20:33AM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Mar 17, 2022 at 03:24:42PM +0000, Hyeonggon Yoo wrote:
> > > > > > On Thu, Mar 17, 2022 at 07:00:00AM -0700, Paul E. McKenney wrote:
> > > > > > > On Thu, Mar 17, 2022 at 11:32:53AM +0000, Hyeonggon Yoo wrote:
> > > > > > > > Hello RCU folks,
> > > > > > > >
> > > > > > > > I like to use minimal configuration for kernel development.
> > > > > > > > when building with tinyconfig + CONFIG_PREEMPT=y on arm64:
> > > > > > > >
> > > > > > > > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > > > > > > > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > > > > > > > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > > > > > > > make: *** [Makefile:1155: vmlinux] Error 1
> > > > > > > >
> > > > > > > > It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.
> > > > > > >
> > > > > > > Indeed it does!
> > > > > > >
> > > > > > > And kernel/rcu/Kconfig shows why:
> > > > > > >
> > > > > > > config TASKS_TRACE_RCU
> > > > > > >         def_bool 0
> > > > > > >         select IRQ_WORK
> > > > > > >         help
> > > > > > >           This option enables a task-based RCU implementation that uses
> > > > > > >           explicit rcu_read_lock_trace() read-side markers, and allows
> > > > > > >           these readers to appear in the idle loop as well as on the CPU
> > > > > > >           hotplug code paths.  It can force IPIs on online CPUs, including
> > > > > > >           idle ones, so use with caution.
> > > > > > >
> > > > > > > So the solution is to further minimize your configuration so as to
> > > > > > > deselect TASKS_TRACE_RCU.
> > > > > >
> > > > > > They are already not selected.
> > > > >
> > > > > Good, thank you.
> > > > >
> > > > > How about TASKS_RUDE_RCU, TASKS_TRACE_RCU, and TASKS_RCU_GENERIC?
> > > >
> > > > TASKS_RUDE_RCU=n
> > > > TASKS_TRACE_RCU=n
> > > > TASKS_RCU_GENERIC=y
> > > > TASKS_RCU=y
> > > >
> > > > > > > This means making sure that both BPF and
> > > > > > > the various RCU torture tests are all deselected.
> > > > > >
> > > > > > I wanted to say call_rcu_tasks() can be referenced even when IRQ_WORK is not
> > > > > > selected, making it fail to build.
> > > > >
> > > > > I am guessing because TASKS_RCU_GENERIC is selected?
> > > > >
> > > >
> > > > Right.
> > > >
> > > > > If so, does the patch at the end of this email help?
> > > > >
> > > >
> > > > No. did not help.
> > > >
> > > > I think I found reason...
> > > > with PREEMPTION=y,
> > > >
> > > > in kernel/rcu/Kconfig:
> > > > config TASKS_RCU
> > > >         def_bool PREEMPTION
> > > >         help
> > > >           This option enables a task-based RCU implementation that uses
> > > >           only voluntary context switch (not preemption!), idle, and
> > > >           user-mode execution as quiescent states.  Not for manual selection.
> > > >
> > > > in kernel/rcu/Kconfig:
> > > > config TASKS_RCU_GENERIC
> > > >         def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
> > > >         select SRCU
> > > >         help
> > > >           This option enables generic infrastructure code supporting
> > > >           task-based RCU implementations.  Not for manual selection.
> > >
> > > Ah, this is because some of the tracing code uses TASKS_RCU only
> > > when PREEMPTION=y.  That would be KPROBES and TRACING.  Maybe also
> > > TRACE_CLOCK and TRACEPOINTS, but I would hope that TRACING would
> > > cover those.  Adding the tracing guys for their thoughts.
> > >
> > > > > > > > ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> > > > > > > > update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> > > > > > > > update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> > > > > > > > make: *** [Makefile:1155: vmlinux] Error 1
> > > > > >
> > > > > > Isn't it better to fix this build failure?
> > > > >
> > > > > But of course!  However, first I need to know exactly what is causing your
> > > > > build failure.  I cannot see your .config file, so I am having to guess.
> > > > >
> > > > > Don't get me wrong, I do have a lot of practice guessing, but it is still
> > > > > just guessing.  ;-)
> > > >
> > > > Sorry to make you guess. Maybe too late, but added config as attachment ;)
> > >
> > > Perhaps I needed the practice.  ;-)
> > >
> > > > > > It fails to build when both TASKS_TRACE_RCU and IRQ_WORK are not selected
> > > > > > and PREEMPT is selected.
> > > > > >
> > > > > >   │ Symbol: TASKS_TRACE_RCU [=n]                                            │
> > > > > >   │ Type  : bool                                                            │
> > > > > >   │ Defined at kernel/rcu/Kconfig:96                                        │
> > > > > >   │ Selects: IRQ_WORK [=n]                                                  │
> > > > > >   │ Selected by [n]:                                                        │
> > > > > >   │   - BPF_SYSCALL [=n]                                                    │
> > > > > >   │   - RCU_SCALE_TEST [=n] && DEBUG_KERNEL [=y]                            │
> > > > > >   │   - RCU_TORTURE_TEST [=n] && DEBUG_KERNEL [=y]                          │
> > > > > >   │   - RCU_REF_SCALE_TEST [=n] && DEBUG_KERNEL [=y]
> > > > > >
> > > > > > Thanks!
> > > > > >
> > > > > > >
> > > > > > > Or turn on IRQ_WORK, for example, if you need to use BPF.
> > > > >
> > > > > Or do you already have TASKS_RCU_GENERIC deselected?
> > > > >
> > > >
> > > > No, this is selected. TASKS_RCU_GENERIC=y. because of PREEMPTION=y.
> > >
> > > OK, the patch shown below allows me to get TASKS_RCU_GENERIC=n even
> > > with PREEMPTION=y.  This might somehow subtly break tracing, but in
> > > that case further adjustments can be made.  Untested other than
> > > generating a few .config combinations.
> > >
> > > Thoughts?
> > >
> > >                                                         Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 678a80713b21..66c5b5543511 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -38,6 +38,7 @@ config KPROBES
> > >         depends on MODULES
> > >         depends on HAVE_KPROBES
> > >         select KALLSYMS
> > > +       select TASKS_RCU if PREEMPTION
> > >         help
> > >           Kprobes allows you to trap at almost any kernel address and
> > >           execute a callback function.  register_kprobe() establishes
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index f559870fbf8b..4f665ae0cf55 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -78,7 +78,8 @@ config TASKS_RCU_GENERIC
> > >           task-based RCU implementations.  Not for manual selection.
> > >
> > >  config TASKS_RCU
> > > -       def_bool PREEMPTION
> > > +       def_bool 0
> > > +       select IRQ_WORK
> > >         help
> > >           This option enables a task-based RCU implementation that uses
> > >           only voluntary context switch (not preemption!), idle, and
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 752ed89a293b..a7aaf150b704 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -127,6 +127,7 @@ config TRACING
> > >         select BINARY_PRINTF
> > >         select EVENT_TRACING
> > >         select TRACE_CLOCK
> > > +       select TASKS_RCU if PREEMPTION
> > >
> > >  config GENERIC_TRACER
> > >         bool
> > I apply above patch, and invoke
> > $make  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> > CC=aarch64-linux-gnu-gcc-10 tinyconfig
> > $make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> > CC=aarch64-linux-gnu-gcc-10 -j 16
> > kernel build successful this time (without above patch, kernel build
> > will quit with undefined reference to `irq_work_queue'
> > Tested-by: Zhouyi Zhou<zhouzhouyi@gmail.com>
> 
> I will apply on my next rebase, thank you!
>

Works for configurations I use.

Reported-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> 							Thanx, Paul

-- 
Thank you, You are awesome!
Hyeonggon :-)
