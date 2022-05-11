Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A319523B50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiEKRRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbiEKRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:17:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52930F71;
        Wed, 11 May 2022 10:17:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m23so3523953ljc.0;
        Wed, 11 May 2022 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4shk/CFdwB+jdtX/kM3BN61QJ7y5MajfTZDkj9q4lg0=;
        b=m7eZoto43lLIN9BJFMhFHJBsXpjcS7x2NanD1SJhIOCOr6I9zVU4W780Azz7tEbJO/
         tITybLX7GrDPCTevuEeetGO4vnjJkfrJCmM4ifKOkG5WUIeeZn6xns4pVWp+QFY7lYyt
         f19Qi1fubXRm4XPIDgQUcjgFFE3Em7BwCxklzJN8iuvP+RdKZfPBR5ErQ4w7My3mhqz5
         3MQdhy4caYOKfS6x/PZrfeJWOOWNJKG+KgKZTSg3J/Xb+bjxLjVJKLeSDpcEznlmpqGa
         Ig4gimOdo1RKNFYoxTF8XNWDsi+d4jPd74U9EHmZfBbA48HLEmDtCIdfct63VYpaFQ84
         RHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4shk/CFdwB+jdtX/kM3BN61QJ7y5MajfTZDkj9q4lg0=;
        b=Mf8lbgkMyNnowyqmaGURuILaph1IeQRf3TXDCwlZX33AkG/W1kbqWLurzq8IRMzwiu
         sPybgzdQ/WBuWJBx2TNNng2QGIFVYFh1haoggGqEhUGge4MD/F5u8cW7t3pX86/JZpKV
         lho4ucXvxuQGbYIodIbYFzw0Cpmtrzy5t/D9pcdFD96fVsAgiR1nINSf0UyjHA8+ntaB
         ZWrEkl/e4xbu1aWbdtQsVK/zE0jk1+RQOGaO7UhUdO93xsmIByD/9Fy4KPjyjTeaHZi2
         X1qvlWi6nb0zsBdsJ5TL2Xw2RvnqHWaBWasusvyApjY7vMQTVlpcNNxjLB+ucHEegaxx
         W0JQ==
X-Gm-Message-State: AOAM5327WmDf1udUmJFI8G7mws3ZdynVfjhq6ekQN94b7boxJpNYl3Zf
        GhzC82wrB77HQMOCokRP0Z4=
X-Google-Smtp-Source: ABdhPJyFQOEeDsyyyxoVt+Ott5Ta5VwX0FzCm1OMpBV4EYO/VTXxfI+8bDid7mPvGwZIPaFNt2RdEA==
X-Received: by 2002:a05:651c:158b:b0:250:a056:7e48 with SMTP id h11-20020a05651c158b00b00250a0567e48mr17856727ljq.64.1652289464987;
        Wed, 11 May 2022 10:17:44 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e9d0c000000b0024f3d1daecesm441662lji.86.2022.05.11.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:17:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 11 May 2022 19:17:42 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <Ynvvto4xcK1dn8iA@pc638.lan>
References: <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220510100135.62a4f7df@gandalf.local.home>
 <Ynu8rM42aSyGN7li@pc638.lan>
 <20220511102957.56bd582b@gandalf.local.home>
 <YnvNbRcd3KRfQW3C@pc638.lan>
 <YnvN3PPds3BlZ5fi@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnvN3PPds3BlZ5fi@pc638.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, May 11, 2022 at 10:29:57AM -0400, Steven Rostedt wrote:
> > > On Wed, 11 May 2022 15:39:56 +0200
> > > Uladzislau Rezki <urezki@gmail.com> wrote:
> > > 
> > > > <snip>
> > > >  rcuop/6-54  [000] .N..  183.753018: rcu_invoke_callback:  rcu_preempt rhp=0xffffff88ffd440b0 func=__d_free.cfi_jt
> > > >  rcuop/6-54  [000] .N..  183.753020: rcu_invoke_callback:  rcu_preempt rhp=0xffffff892ffd8400 func=inode_free_by_rcu.cfi_jt
> > > >  rcuop/6-54  [000] .N..  183.753021: rcu_invoke_callback:  rcu_preempt rhp=0xffffff89327cd708 func=i_callback.cfi_jt
> > > >  ... 
> > > >  rcuop/6-54  [000] .N..  183.755941: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c5a968 func=i_callback.cfi_jt
> > > >  rcuop/6-54  [000] .N..  183.755942: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c4bd20 func=__d_free.cfi_jt
> > > >  rcuop/6-54  [000] dN..  183.755944: rcu_batch_end:        rcu_preempt CBs-invoked=2112 idle=>c<>c<>c<>c<
> > > >  rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      Start context switch
> > > >  rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      End context switch
> > > > <snip>
> > > > 
> > > > i spent some time in order to understand why the context was not switched,
> > > > even though the "rcuop" kthread was marked as TIF_NEED_RESCHED and an IPI
> > > > was sent to the CPU_0 to reschedule. The last "." in latency field shows
> > > > that a context has not disabled any preemption. So everything should be fine.
> > > > 
> > > > An explanation is that a local_bh_disable() modifies the current_thread_info()->preempt.count
> > > > so a task becomes non preemtable but the ftrace does not provide any signal about
> > > > it. So i was fooled for some time by my tracer logs.
> > > > 
> > > > Do you have any thoughts about it? Should it be solved or signaled
> > > > somehow that a task in fact is not preemtable if a counter > 0?
> > > 
> > > Hmm, it should show it in the first part (where the 'd' is). Is this a
> > > snapshot from the kernel or from trace-cmd?
> > > 
> > I do both and the behavior is the same. But the above one looks like a
> > kernel trace output, the trace-cmd snapshot looks differently. So you
> > mean "s" has to be there then?
> > 
> > <snip>
> > 	entry->preempt_count		= pc & 0xff;
> > 	entry->pid			= (tsk) ? tsk->pid : 0;
> > 	entry->type			= type;
> > 	entry->flags =
> > #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
> > 		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
> > #else
> > 		TRACE_FLAG_IRQS_NOSUPPORT |
> > #endif
> > 		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
> > 		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
> > 		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
> > 		(tif_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
> > 		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
> > <snip>
> > 
> > BTW, i am not the 5.10 kernel. I have not checked the latest kernel
> > and what ftrace reports under holding local_bh_disable().
> >
> Sorry, the was a typo. I am checking 5.10 kernel and the trace was taken
> on that kernel.
> 
OK. It was added on the latest kernel:

root@pc638:/home/urezki# cat /sys/kernel/debug/tracing/trace_pipe
  vmalloc_test/0-1296    [062] b....    18.157470: 0xffffffffc044e5dc: -> in the local_bh_disable()

root@pc638:/home/urezki# cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 0/0   #P:64
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
root@pc638:/home/urezki# uname -a
Linux pc638 5.17.0-rc2-next-20220201 #63 SMP PREEMPT Tue May 10 20:39:08 CEST 2022 x86_64 GNU/Linux
root@pc638:/home/urezki#

so it shows *bh* disabled sections.

--
Uladzislau Rezki
