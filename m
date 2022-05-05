Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF28051B66E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiEEDT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEEDTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:19:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D394C6558
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 20:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42975B82B20
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986AC385A4;
        Thu,  5 May 2022 03:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651720543;
        bh=6ym+MpO3fiqcC6XmnkGoayTx3xDXLKgHKtv8X22Zlxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VDwKKkDxMRwk1fDBDCeHMiKsKRK31zrKBcKjptSi3VU0h3yJAu4b+VP2d31nAzCxE
         Rpn/nAoR+vFN7hGl1mCFSifVeOLgSQySahsZJCo5lKvl3nppU1iXZdNNhYjddNMUj7
         2RVy98Fv6yaHN5bhqZEtF08rGElqd1X71dpyWACYCqy8/eppQe3i8MWCxrZp0S97PH
         WdYRFd41bI/lXuFOE5b/zkgOAdhgETg2JEG7b3mzGC4wYHaIx9kN9HHOeXErwLYThz
         DoQRxNMUHZYTWnAufm1FAfM51RbeI22Jq2f1psnpkdSTadOObLkkm8KhAQtCNy91s+
         xMnBI7/A+ZUBQ==
Date:   Thu, 5 May 2022 12:15:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-Id: <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
In-Reply-To: <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
References: <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
        <20220421114201.21228eeb@gandalf.local.home>
        <YmGF/OpIhAF8YeVq@lakrids>
        <20220421130648.56b21951@gandalf.local.home>
        <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
        <20220422114541.34d71ad9@gandalf.local.home>
        <YmLlmaXF00hPkOID@lakrids>
        <20220426174749.b5372c5769af7bf901649a05@kernel.org>
        <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, 4 May 2022 11:24:43 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Apr 26, 2022 at 05:47:49PM +0900, Masami Hiramatsu wrote:
> > Hi Mark,
> > 
> > On Fri, 22 Apr 2022 18:27:53 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Fri, Apr 22, 2022 at 11:45:41AM -0400, Steven Rostedt wrote:
> > > > On Fri, 22 Apr 2022 11:12:39 +0100
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > 
> > > > > As an aside, I'd also love to remove the REGS/!REGs distinction, and always
> > > > > save a minimum amount of state (like ARGS, but never saving a full pt_regs),
> > > > > since on arm64 the extra state stored for the REGS case isn't useful (and we
> > > > > can't reliably capture all of the pt_regs state anyway, so bits of it are made
> > > > > up or not filled in).
> > > > 
> > > > Note, the reason for the addition of REGS was a requirement of kprobes.
> > > > Because before ftrace, kprobes would be triggered at the start of a
> > > > function by a breakpoint that would load in all the regs. And for backward
> > > > compatibility, Masami wanted to make sure that kprobes coming from ftrace
> > > > had all the regs just like it had when coming from a breakpoint.
> > 
> > Yes. Since this kprobes->ftrace conversion is done by kprobes transparently,
> > user doesn't know their kprobe handler is called from sw break or ftrace.
> 
> The big problem is that on arm64 kprobes and ftrace are *very* different, and
> we can't do that transparently (unless both had a mode which just provided the
> ARGS).

OK, in that case, we can just drop the KPROBE_ON_FTRACE support on arm64.
A problem I thought in this case, is that the fprobe which I introduced recently
for eBPF is expecting to access pt_regs. I would like to know that what kind
of limitation exists if the ftrace on arm64 makes pt_regs. Only PSTATE is
a problem?

> 
> > > > IIUC, kprobes is the only reason we have the "regs" variant (all other use
> > > > cases could get by with the ARGS version).
> > > 
> > > I see. FWIW, we don't have KPROBES_ON_FTRACE on arm64.
> > 
> > Right. Since x86 fentry puts the entry on function address, I need such
> > compatibility.
> > 
> > But on arm64, ftrace leads some preparation instructions, kprobes can put
> > the sw break on the function address there. And may not need to put the
> > kprobes on it. So it depends on arch. I would like to keep the kprobes 
> > available at the function address so that it can trace any registers.
> > (like debugger usage)
> > 
> > > Also, the same problems apply to KRETPROBES: the synthetic `pstate`
> > > value is bogus and we don't fill in other bits of the regs (e.g. the PMR
> > > value), so it's not a "real" pt_regs, and things like
> > > interrupts_enabled(regs) won't work correctly.
> > 
> > Would you mean the process which kprobes_save/restore_local_irqflag() does?
> > Is the regs->pstate saved correctly in sw break or ftrace? (sorry, I missed
> > the context)
> 
> For `BRK` (SW break) instructions we take an exception, PSTATE (and all of the
> struct pt_regs) is saved correctly.

Great, thanks for the confirmation!

> 
> For ftrace, PSTATE (and other bits of pt_regs) are not saved correctly.
> Practically speaking it's not feasible to do so reliably without taking an
> exception, which is why I'd like to reduce ftrace down to just the ARGs.

OK. But my interest is that the ftrace on arm64 can provide a limited
access to registers via pt_regs or not. I don't mind the contained values
so much because in the most case, 'users' will (most likely) access to the
ARGs via BPF or tracefs (and we can just warn users if they try to access
the registers which is not saved.) But if the arm64 ftrace only provides
a special data structure, arch-independent code must have 2 different access
code. That is inefficient. That is my concern.
IOW, I'm interested in interface abstraction.

> > > In addition, as
> > > KRETPROBES only hooks function entry/exit and x9-x17 + x19-x28 are
> > > meaningless at those times, no-one's going to care what they contain
> > > anyway.
> > 
> > It depends on what bug they are trying to trace. C source level bug
> > will not need such information, but assembly level bug (or compiler
> > level bug) may need such registers. Anyway, this also depends on user.
> > I just won't like limit the usage.
> 
> If that's how kretprobes are intended to be used, then I think they must
> *always* use a BRK as that's the only way to reliably get a complete struct
> pt_regs.
> 
> I've implemented that:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kprobes/kretprobe-brk-trampoline&id=80be4ccbf47b0294a02b05b797cbff36364bc435
> 
> ... and can send that out as a patch shortly.

Hm, this is reasonable, and not hard to port it for rethook on arm64.

Just FYI, the rethook will be used for kprobe and fprobe (ftrace based
probe, which was introduced for batch BPF probe [1]). kprobe will be
used for assembly level debug, but fprobe may not. Thus, eventually
those should have 2 different trampolines specified by rethook 'flags'.
But for the first step, I think we can use BRK trampoline by default. 

[1] https://lore.kernel.org/all/20220316122419.933957-1-jolsa@kernel.org/T/#u

> > > The state we can correctly snapshot (and that would be useful)
> > > is the same as ARGS.
> > > 
> > > It'd be nice if KRETPROBES could just use ARGS, but a standard KPROBE
> > > that traps could provide regs (since it actually gets "real" regs, and
> > > within a function the other GPRs could be important).
> > 
> > Here, the KRETPROBES means the exit handler, or including entry handler?
> > Since kretprobes uses a standard kprobe to trap the function entry.
> 
> I'm suggesting that (if there are cases where kretprobes are only used to
> acquire arguments and return vaalues, and not other state), we change things so
> that kretprobes can use a different entry handler from a regular kprobe, and
> that new handler only has to acquire the arguments and return values, matching
> the ftrace ARGS.

I would like to move this feature on fprobe. Since the kretprobe is used
widely, it is hard to change the interface. Now fprobe is only used for
BPF, so I think there is a chance to change it.

So there are 2 options I think.

- Keep fprobe and kprobe current interface (use pt_regs) but only the registers
  for argument and return values are accessible (hopefully, the interrupt state
  etc. too) from fprobes. With this, the BPF can use same program code for
  kprobes and fprobe, but BPF compiler will be able to reject user program
  which access the non-saved registers.

- Introduce a new data structure which saves argument and return value for
  fprobe. BPF runtime program and BPF compiler needs to be changed for this.

> 
> That way we can have:
> 
> a) A regular kprobe, which uses BRK as today, and gets a full pt_regs
> 
> b) A regular kretprobe, which uses BRK for both entry/exit, and gets a full
>    pt_regs in both cases.
> 
> c) An args-only kretprobe, where the entry/exit handlers only present the ARGS
>    to the registered handlers.
> 
> If kretprobes always needs the full pt_regs, then (c) isn't necessary, and we
> don't need to change anything more than the kretprobes trampoline, as above.

I'm OK for the args-only, but that is not kretprobe, we need another one
and should remove current kretprobe in this case for avoiding confusion.
I think fprobe is a good candidate because it is not widely used yet.
Anyway, we need to talk with BPF people about this idea.

As a compromise plan, keep using pt_regs but filling a part of them on arm64.


> What I really want to get away from it kretprobes and ftrace having an
> incomplete pt_regs, and the two ways of doing that are:
> 
> 1) Save/restore the full pt_regs by taking an exception.
> 
> 2) Save/restore a minimal ARGS structure, and ensure the interfaces don't have
>    to pass a struct pt_regs pointer.
> 
> For kretprobes I can implement either, but for ftrace (2) is the only real
> option.

Hmm, I'm still not sure why you can't pass an incomplete pt_regs? (to optimize
stack usage??)

Anyway, I think your kretprobe patch is perfect. I think it is good for kretprobe.

Thank you,

> 
> Thanks,
> Mark.
> 
> > If you talk about fprobes (ftrace probe interface), it will only use the
> > ftrace. Thus your idea is acceptable for it (because fprobe is different
> > from kprobes *).
> > 
> > * Of course we have to talk with BPF people so that they will only access
> > ARGS from BPF program on fprobes.
> > 
> > Thank you,
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
