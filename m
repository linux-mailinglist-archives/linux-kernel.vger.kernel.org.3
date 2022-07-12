Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23C4570EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiGLAWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiGLAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0687825EB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A0E361488
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A1C34115;
        Tue, 12 Jul 2022 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657585288;
        bh=3oyUjHasbMBDyjiSUsn+4mHMHkx+3FpyCRlC94UOk+U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fjwtWoahZc1gqkOV4jB1MfpL74qORtPRoxJ5lPds53A3f9sLE3kEzvHJ8NFj6b/AC
         fsBhJv/BQAx9mCmJ9eINek7QReFJuRQtLaJPYpa6RJs3ZVjVylbelm0M3uVwplnYYi
         HtlIPC1nCfGtJrkL9WN3Eq1S2qSzF6nizF/AN659aOkHwq1RG5O3CNLlO+wXtEcqK5
         MLA91PAxHS1h5Uapw/lJpDMBx7jJC4uH2ByZGYF550tfmja6p9j9SjUYf63GKQmTLs
         Dfy1/BL8m+n2WiepcOpPP20+D2gmHDdnm6t2JhSQxIafl/KaQxkCGX41/2p4jvfWuU
         AQEil50vOxnNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4B6485C03B9; Mon, 11 Jul 2022 17:21:28 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:21:28 -0700
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
Message-ID: <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220503073844.4148944-1-elver@google.com>
 <20220711182918.338f000f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711182918.338f000f@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:29:18PM -0400, Steven Rostedt wrote:
> 
> I know I acked this, but I finally got a tree where it is included in my
> testing, and I hit this:
> 
> INFO: NMI handler (perf_event_nmi_handler) took too long to run: 9.860 msecs
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 16462 at include/trace/events/printk.h:10 printk_sprint+0x81/0xda
> Modules linked in: ppdev parport_pc parport
> CPU: 1 PID: 16462 Comm: event_benchmark Not tainted 5.19.0-rc5-test+ #5
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> EIP: printk_sprint+0x81/0xda
> Code: 89 d8 e8 88 fc 33 00 e9 02 00 00 00 eb 6b 64 a1 a4 b8 91 c1 e8 fd d6 ff ff 84 c0 74 5c 64 a1 14 08 92 c1 a9 00 00 f0 00 74 02 <0f> 0b 64 ff 05 14 08 92 c1 b8 e0 c4 6b c1 e8 a5 dc 00 00 89 c7 e8
> EAX: 80110001 EBX: c20a52f8 ECX: 0000000c EDX: 6d203036
> ESI: 3df6004c EDI: 00000000 EBP: c61fbd7c ESP: c61fbd70
> DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
> CR0: 80050033 CR2: b7efc000 CR3: 05b80000 CR4: 001506f0
> Call Trace:
>  vprintk_store+0x24b/0x2ff
> perf: interrupt took too long (7980 > 7977), lowering kernel.perf_event_max_sample_rate to 25000
>  vprintk+0x37/0x4d
>  _printk+0x14/0x16
>  nmi_handle+0x1ef/0x24e
>  ? find_next_bit.part.0+0x13/0x13
>  ? find_next_bit.part.0+0x13/0x13
>  ? function_trace_call+0xd8/0xd9
>  default_do_nmi+0x57/0x1af
>  ? trace_hardirqs_off_finish+0x2a/0xd9
>  ? to_kthread+0xf/0xf
>  exc_nmi+0x9b/0xf4
>  asm_exc_nmi+0xae/0x29c
> 
> 
> On Tue,  3 May 2022 09:38:44 +0200
> Marco Elver <elver@google.com> wrote:
> 
> > Petr points out [1] that calling trace_console_rcuidle() in
> > call_console_driver() had been the wrong thing for a while, because
> > "printk() always used console_trylock() and the message was flushed to
> > the console only when the trylock succeeded. And it was always deferred
> > in NMI or when printed via printk_deferred()."
> 
> The issue is that we use "trace_console_rcuidle()" where the "_rcuidle()"
> version uses srcu, which the last I knew is not safe in NMI context.
> 
> Paul, has that changed?

On x86, both srcu_read_lock() and srcu_read_unlock() should be OK from
NMI context, give or take their use of lockdep.  Which is why we have
srcu_read_lock_notrace() and srcu_read_unlock_notrace(), which do not
use lockdep.  Which __DO_TRACE() does in fact invoke.  Ah, but you have
this: "WARN_ON_ONCE(rcuidle && in_nmi())".

Because all the world is not an x86.

For srcu_read_lock() and srcu_read_unlock() to be NMI-safe more generally,
this_cpu_inc() would need to be NMI-safe on all platforms.  This requires
it be implemented with read-modify-write atomic instructions, which
appears to be the case on arm64, s390 (for at least some configs,
maybe all depending on what the "laa" instruction does), and again x86.
The generic code relies on disabling interrrupts, which does nothing
against NMIs.

So srcu_read_lock_notrace() and srcu_read_unlock_notrace() are NMI-safe
only on arm64, s390, and x86.  So that WARN_ON_ONCE() is necessary.

> Thus, we need to make sure that printk() is always called when "rcu is
> watching" and remove the _rcuidle() part, or we do not call it from nmi
> context. Or make srcu nmi safe.

Which means making this_cpu_inc() NMI-safe.  Which could be done
by making the generic this_cpu_inc() implementation use something
like arch_atomic_fetch_add().  Or a cmpxchg() loop.  Or making
__srcu_read_lock() and srcu_read_unlock() check the architecture and Do
The Right Thing.  Maybe a CONFIG_THIS_CPU_NMI_SAFE that is set by
x86, s390, and arm64?

Is either approach something that those other architectures would be
willing to countenance?  For me, it might be worth it just to not have
to dig through many layers of this_cpu macro definitions from time
to time...  :-/

							Thanx, Paul

> For now, I'm reverting this in my local tree.
> 
> -- Steve
> 
