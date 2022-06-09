Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291B3544DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiFIN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiFIN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:29:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B5922E6BF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:29:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a10so9901662wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rjMuIRUcb0cPQvXILDOIo+coVEcP/6ZTYygCO+zLwZI=;
        b=llsDjVZg+rOdu3CGzqkX32eaAVwdPsiU1VS8nnyvNRDE8sSblRFHTicWYkcfv1MHXu
         MdioVqNNs5cZ6VFBcG/BTh+RYCpb4wW/GsS0eXUaIy0clqjbpJSnR1ulbw/7zoIenBq5
         GrUbInpSMPpuI1FYSkYzT523tdWtskkHSqijsxWHddPhy9Ua2EDYEGOq/3ZraWyloBKi
         IYBEdx9YQRGK140dTUf06Mckk0WfQToxgONPNEvHd6As8zdXa28IdWZ5JxDGVqVLQktY
         jr1QPxVBWK0Kbx7LIDEtxfJ3aXBUuioiTK9kFPOUNXroue4i/t/PAPRtgUMUE5v9JXNw
         txhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjMuIRUcb0cPQvXILDOIo+coVEcP/6ZTYygCO+zLwZI=;
        b=esCHKYywEcWsqpf9tKYkgiGqxN++3O7g1RpFKGePG+aeU/Z4NdlJHSpd9HVhTqncEY
         G1s5LjcKNfQOURDz1WVBYbpHrNI1S7Ou12CQ5rhW0oMPglz/CfsBclvmt/rA69xBotNi
         25/5MkSwUSpreMjqkzLk8Zgdwqc35ni05xED1DCPZY9JDWIg+3lwNah+h0Gt9axMnqHv
         Uk2mvInFCDFtUBPKTZwWGHZ3jFEnPbd2mh5Kd5TyLVeZ9fF/GtqNq/xnqnPItrJ5g/rP
         q5vJJCngBKxxE6Qrdb0e6xED4se0wb1l7qwHpxDq6nbaftEXnD/9Tp31UHejGM8M5Th2
         U/Uw==
X-Gm-Message-State: AOAM533jxlajJOm7QYtVaK5Plk3nU/puXQxGShMVo0m0nosqIYlyAlVO
        2cbSPrFbChTrcYiZ3notOf7EIA==
X-Google-Smtp-Source: ABdhPJyZ8W/NkcPXAC3pwT4egxuS2urSSW5AltvpWbSolwLujgLmjNCc1uFC8yzG/FYW9KPUrP/oOA==
X-Received: by 2002:a7b:c057:0:b0:39c:4579:42e1 with SMTP id u23-20020a7bc057000000b0039c457942e1mr3381516wmc.102.1654781377037;
        Thu, 09 Jun 2022 06:29:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0039c15861001sm26391486wmb.21.2022.06.09.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:29:36 -0700 (PDT)
Date:   Thu, 9 Jun 2022 15:29:29 +0200
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] perf/hw_breakpoint: Reduce contention with large
 number of tasks
Message-ID: <YqH1uUtWHkFr/jDY@elver.google.com>
References: <20220609113046.780504-1-elver@google.com>
 <20220609113046.780504-7-elver@google.com>
 <CACT4Y+aHZ4RTsz_SY=U5NKRWR1M4f0cy1WdepJyBGkbYy7_=TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aHZ4RTsz_SY=U5NKRWR1M4f0cy1WdepJyBGkbYy7_=TA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:03PM +0200, Dmitry Vyukov wrote:
[...]
> > -/* Serialize accesses to the above constraints */
> > -static DEFINE_MUTEX(nr_bp_mutex);
> > +/*
> > + * Synchronizes accesses to the per-CPU constraints; users of data in bp_cpuinfo
> > + * must acquire bp_cpuinfo_lock as writer to get a stable snapshot of all CPUs'
> > + * constraints. Modifications without use may only acquire bp_cpuinfo_lock as a
> > + * reader, but must otherwise ensure modifications are never lost.
> > + */
> 
> I can't understand this comment.
> Modifications need to acquire in read mode, while only users must
> acquire in write mode. Shouldn't it be the other way around? What is
> "Modifications without use"?

Right, maybe this comment needs tweaking.

The main rules are -- the obvious ones:

	 - plain reads are ok with just a read-lock (target is task,
	   reading 'cpu_pinned');

	 - plain writes need a write-lock (target is CPU, writing
	   'cpu_pinned');

the not so obvious one:

	- "modification without use" are the increment/decrement of
	  tsk_pinned done if the target is a task; in this case, we can
	  happily allow concurrent _atomic_ increments/decrements from
	  different tasks as long as there is no "use" i.e. read the
	  value and check it to make a decision if there is space or not
	  (this is only done by CPU targets).

So the main idea is that the rwlock when held as a reader permits these
"modifications without use" concurrently by task targets, but will block
a CPU target wishing to get a stable snapshot until that acquires the
rwlock as a writer.

The modifications done by task targets are done on atomic variables, so
we never loose any increments/decrements, but while these modifications
are going on, the global view of tsk_pinned may be inconsistent.
However, we know that once a CPU target acquires the rwlock as a writer,
there will be no more "readers" -- or rather any task targets that can
update tsk_pinned concurrently -- and therefore tsk_pinned must be
stable once we acquire the rwlock as a writer.

I'll have to think some more how to best update the comment...

> > +static DEFINE_RWLOCK(bp_cpuinfo_lock);
> > +
> > +/*
> > + * Synchronizes accesses to the per-task breakpoint list in task_bps_ht. Since
> > + * rhltable synchronizes concurrent insertions/deletions, independent tasks may
> > + * insert/delete concurrently; therefore, a mutex per task would be sufficient.
> > + *
> > + * To avoid bloating task_struct with infrequently used data, use a sharded
> > + * mutex that scales with number of CPUs.
> > + */
> > +static DEFINE_PER_CPU(struct mutex, task_sharded_mtx);
> > +
> > +static struct mutex *get_task_sharded_mtx(struct perf_event *bp)
> > +{
> > +       int shard;
> > +
> > +       if (!bp->hw.target)
> > +               return NULL;
> > +
> > +       /*
> > +        * Compute a valid shard index into per-CPU data.
> > +        */
> > +       shard = task_pid_nr(bp->hw.target) % nr_cpu_ids;
> > +       shard = cpumask_next(shard - 1, cpu_possible_mask);
> > +       if (shard >= nr_cpu_ids)
> > +               shard = cpumask_first(cpu_possible_mask);
> > +
> > +       return per_cpu_ptr(&task_sharded_mtx, shard);
> > +}
> > +
> > +static struct mutex *bp_constraints_lock(struct perf_event *bp)
> > +{
> > +       struct mutex *mtx = get_task_sharded_mtx(bp);
> > +
> > +       if (mtx) {
> > +               mutex_lock(mtx);
> > +               read_lock(&bp_cpuinfo_lock);
> 
> Is NR_CPUS == 1 case still important to optimize? I guess with small
> VMs it may be important again.
> If so, we could just write-lock bp_cpuinfo_lock always if NR_CPUS == 1.

Not sure, I guess it's easy to add the check for NR_CPUS==1.

[...]
> > @@ -397,12 +497,11 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
> >
> >  void release_bp_slot(struct perf_event *bp)
> >  {
> > -       mutex_lock(&nr_bp_mutex);
> > +       struct mutex *mtx = bp_constraints_lock(bp);
> >
> >         arch_unregister_hw_breakpoint(bp);
> 
> If I understand this correctly, this can weaken protection for
> arch_unregister_hw_breakpoint() and __modify_bp_slot(). Previously
> they were globally serialized, but now several calls can run in
> parallel. Is it OK?

__modify_bp_slot() just calls __release_bp_slot() and
__reserve_bp_slot() which is related to constraints accounting, and is
all internal to hw_breakpoint.

Only ppc overrides some of the sea arch_ functions. In arch/powerpc:
arch_unregister_hw_breakpoint() looks like it only accesses
bp->ctx->task, so that looks ok; however, looks like
arch_release_bp_slot() might want its own lock because it mutates a
list, but that lock wants to be in powerpc code.
