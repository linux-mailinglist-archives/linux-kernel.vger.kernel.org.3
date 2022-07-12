Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FF571082
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiGLC5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLC5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E1A2B264
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20728616E2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF84C341C8;
        Tue, 12 Jul 2022 02:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657594622;
        bh=1s0tBUcDXUvWcrI+5GwZsamW/tpS8Eb+RLz7f2OSl8U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TYwrnnIn7yCqCwO5s8NIXAqfZ+kRLGN1qwa4KzC/JxUgGfmY+NUZ4ANU6HWm3DfQ1
         ZYHW/p34ftUSOgMFenTxENxJj2LsW9LXY1umrXkWBQ3dy4QKW63gPfohg1w+BDyPwL
         fpZYRv9ipzyOZt7jGAaRD8uk0DZDV3E0rvKP1gOkA9aHkusDbqTRtng5BJ+UujnPSP
         LMBiEf/TL1sv/2GIYi5rVJe47+P8VSG8oDvEtINM+GdvxfFWxMDS1rnx5uqLpv29xB
         58xD/0+jENRt3AGG7Jkso9jRsRMdBXgwQCrX5Ducu/pRZSH+2fX2IHwvlctkJIKsAQ
         vbX2bgf7cLpEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E86245C0741; Mon, 11 Jul 2022 19:57:01 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:57:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220503073844.4148944-1-elver@google.com>
 <20220711182918.338f000f@gandalf.local.home>
 <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220711205319.1aa0d875@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711205319.1aa0d875@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 08:53:19PM -0400, Steven Rostedt wrote:
> On Mon, 11 Jul 2022 17:21:28 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On x86, both srcu_read_lock() and srcu_read_unlock() should be OK from
> > NMI context, give or take their use of lockdep.  Which is why we have
> > srcu_read_lock_notrace() and srcu_read_unlock_notrace(), which do not
> > use lockdep.  Which __DO_TRACE() does in fact invoke.  Ah, but you have
> > this: "WARN_ON_ONCE(rcuidle && in_nmi())".
> > 
> > Because all the world is not an x86.
> 
> But since NMIs are architecture specific, we could change that to:
> 
> 	WARN_ON_ONCE(!srcu_nmi_safe && rcuidle && in_nmi());
> 
> and add a srcu_nmi_safe constant or macro that is 1 on architectures that
> srcu is safe in NMI and 0 otherwise.
> 
> Or do we care if a tracepoint happens in those architectures where it is
> not safe. We could then just do:
> 
> 	if (!srcu_nmi_safe && rcuidle && in_nmi())
> 		return;
> 
> and just skip tracepoints that are marked rcu_idle and happen within NMI.

More generally, this is this_cpu_nmi_safe rather than just SRCU.  Or could
be, depending on what the architecture guys would like to guarantee.
SRCU is just passing through the this_cpu*() NMI-safety property.

And in addition to in_nmi(), there is the HAVE_NMI Kconfig option:

	$ git grep -w HAVE_NMI
	arch/Kconfig:config HAVE_NMI
	arch/Kconfig:	depends on HAVE_NMI
	arch/arm/Kconfig:	select HAVE_NMI
	arch/arm64/Kconfig:	select HAVE_NMI
	arch/loongarch/Kconfig:	select HAVE_NMI
	arch/mips/Kconfig:	select HAVE_NMI
	arch/powerpc/Kconfig:	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
	arch/s390/Kconfig:	select HAVE_NMI
	arch/sh/Kconfig:	select HAVE_NMI
	arch/sparc/Kconfig:	select HAVE_NMI
	arch/x86/Kconfig:	select HAVE_NMI

So if I understand correctly, arm, loongarch, mips, powerpc, sh, and
sparc are the ones that have NMIs but don't have NMI-safe this_cpu*()
operations.  These are the ones that would need !srcu_nmi_safe.

Or, longer term, I could make HAVE_NMI && !srcu_safe_nmi cause SRCU to use
explicit atomics for srcu_read_lock_trace() and srcu_read_unlock_trace().
I am assuming that any NMI handler executing srcu_read_lock_trace()
also executes the matching srcu_read_unlock_trace().  (Silly me, I know!)
This assumption means that srcu_read_lock() and srcu_read_unlock() can
continue with their non-atomic this_cpu_inc() ways.

But a quick fix that stopped the bleeding and allowed printk() to
progress would be useful in the short term, regardless of whether or
not in the longer term it makes sense to make srcu_read_lock_trace()
and srcu_read_unlock_trace() NMI-safe.

Thoughts?

							Thanx, Paul
