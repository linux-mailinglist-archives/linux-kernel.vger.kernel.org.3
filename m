Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21252533C81
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiEYMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiEYMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:17:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1980336318
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:17:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE9C51FB;
        Wed, 25 May 2022 05:17:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.0.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A19D3F73D;
        Wed, 25 May 2022 05:17:37 -0700 (PDT)
Date:   Wed, 25 May 2022 13:17:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <Yo4eWqHA/IjNElNN@FVFF77S0Q05N>
References: <YmLlmaXF00hPkOID@lakrids>
 <20220426174749.b5372c5769af7bf901649a05@kernel.org>
 <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
 <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
 <20220509142203.6c4f2913@gandalf.local.home>
 <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
 <20220510104446.6d23b596@gandalf.local.home>
 <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
 <20220511111207.25d1a693@gandalf.local.home>
 <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:02:31PM +0900, Masami Hiramatsu wrote:
> On Wed, 11 May 2022 11:12:07 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 11 May 2022 23:34:50 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > OK, so fregs::regs will have a subset of pt_regs, and accessibility of
> > > the registers depends on the architecture. If we can have a checker like
> > > 
> > > ftrace_regs_exist(fregs, reg_offset)
> > 
> > Or something. I'd have to see the use case.
> > 
> > > 
> > > kprobe on ftrace or fprobe user (BPF) can filter user's requests.
> > > I think I can introduce a flag for kprobes so that user can make a
> > > kprobe handler only using a subset of registers. 
> > > Maybe similar filter code is also needed for BPF 'user space' library
> > > because this check must be done when compiling BPF.
> > 
> > Is there any other case without full regs that the user would want anything
> > other than the args, stack pointer and instruction pointer?
> 
> For the kprobes APIs/events, yes, it needs to access to the registers
> which is used for local variables when probing inside the function body.
> However at the function entry, I think almost no use case. (BTW, pstate
> is a bit special, that may show the actual processor-level status
> (context), so for the debugging, user might want to read it.)

As before, if we really need PSTATE we *must* take an exception to get a
reliable snapshot (or to alter the value). So I'd really like to split this
into two cases:

* Where users *really* need PSTATE (or arbitrary GPRs), they use kprobes. That
  always takes an exception and they can have a complete, real struct pt_regs.

* Where users just need to capture a function call boundary, they use ftrace.
  That uses a trampoline without taking an exception, and they get the minimal
  set of registers relevant to the function call boundary (which does not
  include PSTATE or most GPRs).
 
> Thus the BPF use case via fprobes, I think there is no usecase.
> My concern is that the BPF may allow user program to access any
> field of pt_regs. Thus if the user miss-programmed, they may see
> a wrong value (I guess the fregs is not zero-filled) for unsaved
> registers.
> 
> > That is, have a flag that says "only_args" or something, that says they
> > will only get the registers for arguments, a stack pointer, and the
> > instruction pointer (note, the fregs may not have the instruction pointer
> > as that is passed to the the caller via the "ip" parameter. If the fregs
> > needs that, we can add a "ftrace_regs_set_ip()" before calling the
> > callback registered to the fprobe).
> 
> Yes, that is what I'm thinking. If "only_args" flag is set, BPF runtime
> must check the user program. And if it finds the program access the
> unsaved registers, it should stop executing.
> 
> BTW, "what register is saved" can be determined statically, thus I think
> we just need the offset for checking (for fprobe usecase, since it will
> set the ftrace_ops flag by itself.)

For arm64 I'd like to make this static, and have ftrace *always* capture a
minimal set of ftrace_regs, which would be:

  X0 to X8 inclusive
  SP
  PC
  LR
  FP

Since X0 to X8 + SP is all that we need for arguments and return values (per
the calling convention we use), and PC+LR+FP gives us everything we need for
unwinding and live patching.

I *might* want to add x18 to that when SCS is enabled, but I'm not immediately
sure.

Thanks,
Mark.
