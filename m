Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17D533C97
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiEYM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiEYM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:27:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB6A86D868
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:27:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 175201FB;
        Wed, 25 May 2022 05:27:30 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.0.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A533F73D;
        Wed, 25 May 2022 05:27:28 -0700 (PDT)
Date:   Wed, 25 May 2022 13:27:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <Yo4gq6he3zb/B6kx@FVFF77S0Q05N>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
 <20220316100132.244849-4-bobo.shaobowang@huawei.com>
 <YmFXrBG5AmX3+4f8@lakrids>
 <20220421100639.03c0d123@gandalf.local.home>
 <YmF0xYpTMoWOIl00@lakrids>
 <20220421114201.21228eeb@gandalf.local.home>
 <YmGF/OpIhAF8YeVq@lakrids>
 <8f36ebd2-2c56-d896-3a91-c97a5760b344@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f36ebd2-2c56-d896-3a91-c97a5760b344@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:57:35AM +0800, Wangshaobo (bobo) wrote:
> 
> 锟斤拷 2022/4/22 0:27, Mark Rutland 写锟斤拷:
> > On Thu, Apr 21, 2022 at 11:42:01AM -0400, Steven Rostedt wrote:
> > > On Thu, 21 Apr 2022 16:14:13 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > > Let's say you have 10 ftrace_ops registered (with bpf and kprobes this can
> > > > > be quite common). But each of these ftrace_ops traces a function (or
> > > > > functions) that are not being traced by the other ftrace_ops. That is, each
> > > > > ftrace_ops has its own unique function(s) that they are tracing. One could
> > > > > be tracing schedule, the other could be tracing ksoftirqd_should_run
> > > > > (whatever).
> > > > Ok, so that's when messing around with bpf or kprobes, and not generally
> > > > when using plain old ftrace functionality under /sys/kernel/tracing/
> > > > (unless that's concurrent with one of the former, as per your other
> > > > reply) ?
> > > It's any user of the ftrace infrastructure, which includes kprobes, bpf,
> > > perf, function tracing, function graph tracing, and also affects instances.
> > > 
> > > > > Without this change, because the arch does not support dynamically
> > > > > allocated trampolines, it means that all these ftrace_ops will be
> > > > > registered to the same trampoline. That means, for every function that is
> > > > > traced, it will loop through all 10 of theses ftrace_ops and check their
> > > > > hashes to see if their callback should be called or not.
> > > > Sure; I can see how that can be quite expensive.
> > > > 
> > > > What I'm trying to figure out is who this matters to and when, since the
> > > > implementation is going to come with a bunch of subtle/fractal
> > > > complexities, and likely a substantial overhead too when enabling or
> > > > disabling tracing of a patch-site. I'd like to understand the trade-offs
> > > > better.
> > > > 
> > > > > With dynamically allocated trampolines, each ftrace_ops will have their own
> > > > > trampoline, and that trampoline will be called directly if the function
> > > > > is only being traced by the one ftrace_ops. This is much more efficient.
> > > > > 
> > > > > If a function is traced by more than one ftrace_ops, then it falls back to
> > > > > the loop.
> > > > I see -- so the dynamic trampoline is just to get the ops? Or is that
> > > > doing additional things?
> > > It's to get both the ftrace_ops (as that's one of the parameters) as well
> > > as to call the callback directly. Not sure if arm is affected by spectre,
> > > but the "loop" function is filled with indirect function calls, where as
> > > the dynamic trampolines call the callback directly.
> > > 
> > > Instead of:
> > > 
> > >    bl ftrace_caller
> > > 
> > > ftrace_caller:
> > >    [..]
> > >    bl ftrace_ops_list_func
> > >    [..]
> > > 
> > > 
> > > void ftrace_ops_list_func(...)
> > > {
> > > 	__do_for_each_ftrace_ops(op, ftrace_ops_list) {
> > > 		if (ftrace_ops_test(op, ip)) // test the hash to see if it
> > > 					     //	should trace this
> > > 					     //	function.
> > > 			op->func(...);
> > > 	}
> > > }
> > > 
> > > It does:
> > > 
> > >    bl dyanmic_tramp
> > > 
> > > dynamic_tramp:
> > >    [..]
> > >    bl func  // call the op->func directly!
> > > 
> > > 
> > > Much more efficient!
> > > 
> > > 
> > > > There might be a middle-ground here where we patch the ftrace_ops
> > > > pointer into a literal pool at the patch-site, which would allow us to
> > > > handle this atomically, and would avoid the issues with out-of-range
> > > > trampolines.
> > > Have an example of what you are suggesting?
> > We can make the compiler to place 2 NOPs before the function entry point, and 2
> > NOPs after it using `-fpatchable-function-entry=4,2` (the arguments are
> > <total>,<before>). On arm64 all instructions are 4 bytes, and we'll use the
> > first two NOPs as an 8-byte literal pool.
> > 
> > Ignoring BTI for now, the compiler generates (with some magic labels added here
> > for demonstration):
> > 
> > 	__before_func:
> > 			NOP
> > 			NOP
> > 	func:
> > 			NOP
> > 			NOP
> > 	__remainder_of_func:
> > 			...
> > 
> > At ftrace_init_nop() time we patch that to:
> > 
> > 	__before_func:
> > 			// treat the 2 NOPs as an 8-byte literal-pool
> > 			.quad	<default ops pointer> // see below
> > 	func:
> > 			MOV	X9, X30
> > 			NOP
> > 	__remainder_of_func:
> > 			...
> > 
> > When enabling tracing we do
> > 
> > 	__before_func:
> > 			// patch this with the relevant ops pointer
> > 			.quad	<ops pointer>
> > 	func:
> > 			MOV	X9, X30
> > 			BL	<trampoline>	// common trampoline
> 
> I have a question that does this common trampoline allocated by
> module_alloc()? if yes, how to handle the long jump from traced func to
> common trampoline if only adding two NOPs in front of func.

No; as today there'd be *one* trampoline in the main kernel image, and where a
module is out-of-range it will use a PLT the module loader created at load time
(and any patch-site in that module would use the same PLT and trampoline,
regardless of what the ops pointer was).

There might be a PLT between the call and the trampoline, but that wouldn't
have any functional effect; we'd still get all the arguments, the original LR
(in x9), and the location of the call (in the LR), as we get today.

For how we do that today, see commits:

* e71a4e1bebaf7fd9 ("arm64: ftrace: add support for far branches to dynamic ftrace")
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e71a4e1bebaf7fd990efbdc04b38e5526914f0f1

* f1a54ae9af0da4d7 ("arm64: module/ftrace: intialize PLT at load time")
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1a54ae9af0da4d76239256ed640a93ab3aadac0

* 3b23e4991fb66f6d ("arm64: implement ftrace with regs")
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b23e4991fb66f6d152f9055ede271a726ef9f21

Thanks,
Mark.
