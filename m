Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D694BA736
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiBQRd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:33:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBQRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:33:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A515F353
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:33:11 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:33:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645119188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g46W2ujMzZ0SbZmNOAXSHQ2Kv0SmQ9Y1FWBTwikBicA=;
        b=wRZEerD+adqSR/+xcb9EvZcSBM/QVOiCFzR7BoBpPdygu+sGYrXbnnOPidqSLhnw/qGxu0
        uRIRqBQDjcC2GRl7MuYdoo1lKa4lSdPu9xowRDXjwYTx6MKi6p/vFhCXOMoyNPd56v0poe
        WEh1H7BP0/0pQvL8DRMup0hFeIE/FEmH08hJh+XPG96j5XPCPjlWw1A2nBYiNriMNQC2Gv
        DeHdEhu2fSs7ZMAD767TyKd4IOOddTvzG0EP09Y1If5MJeohKmTuezWSNYMtluzfv9DamJ
        xnTse5y7x3Jb/oPS1XSjaUn72laui2gFJewyGCQRy5lhUSXZ3Jm09UfiK1FRQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645119188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g46W2ujMzZ0SbZmNOAXSHQ2Kv0SmQ9Y1FWBTwikBicA=;
        b=lcoMp3hftWA+yXVSqoHe+fD5HGlbPTHdTHa10wrGiw6nhwwCJlz2TSWoTd2EDwYhV1heiu
        a2HgKToD99OgJgDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] random: remove batched entropy locking
Message-ID: <Yg6G08tFN5kjamG2@linutronix.de>
References: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
 <20220204155142.56419-1-Jason@zx2c4.com>
 <Yf1M3YGVq71oC9BM@linutronix.de>
 <CAG48ez1ucJikx_6GzK2XUfCGoTeL+R418riTn+ECj_ud5BSFow@mail.gmail.com>
 <CAHmME9q6bm_pXer0aVq907-RevtH8nLPH=Uo2UU6gEKU6GaFwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9q6bm_pXer0aVq907-RevtH8nLPH=Uo2UU6gEKU6GaFwA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-16 21:58:14 [+0100], Jason A. Donenfeld wrote:
> > Why raw_cpu_ptr? include/linux/percpu-defs.h says about raw_*() operations:
> >
> >  * Operations for contexts where we do not want to do any checks for
> >  * preemptions.  Unless strictly necessary, always use [__]this_cpu_*()
> >  * instead.
> >
> > So when I see a raw_*() percpu thing, I read it as "it is expected
> > that we can migrate after this point (or we're in some really weird
> > context where the normal context check doesn't work)". Is that
> > incorrect?
> 
> If it says "contexts where we do not want to do any checks for
> preemptions", then that would apply here I would think? We're taking a
> local lock, which means afterwards there are no preemptions. For
> context, the code that got committed after Sebastian's final review
> is:
> 
>         local_lock_irqsave(&batched_entropy_u32.lock, flags);
>         batch = raw_cpu_ptr(&batched_entropy_u32);
> 
> However, I think most other code uses this_cpu_ptr() instead? So not sure.

It depends what you are looking for.
raw_cpu_ptr(&batched_entropy_u32) give you the pointer to
&batched_entropy_u32 of _this_ CPU - the CPU you are currently running.
this_cpu_ptr() does the same except that it has smp_processor_id() in
it. smp_processor_id() will yell at you (given you enabled
CONFIG_DEBUG_PREEMPT) if the code can migrate to another CPU.
So it will yell at you unless:
- you disable preemption / migration so code can't migrate
- you run on a per-CPU thread i.e. a thread which is bound to a single
  CPU and therefore can't migrate to another.

The local_lock_irqsave() acquires a lock / disables interrupt and
therefore can't migrate. So I suggested to use raw_cpu_ptr() as an
optimisation in the debug-case.

If you disable preemption before accessing a per-CPU variable with
this_cpu_ptr() then you _need_ to ensure that nobody is accessing the
variable from in-IRQ context. Nobody will yell at you. But if you use a
local-lock then you get lockdep annotation and lockdep will complain if
you use that variable always in process context and sometimes in-IRQ.

> Jason

Sebastian
