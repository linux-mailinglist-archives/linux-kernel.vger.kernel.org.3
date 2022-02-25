Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9B4C46D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiBYNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiBYNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:43:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242A10DA7C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F430B82BAE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EFAC340F1;
        Fri, 25 Feb 2022 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645796574;
        bh=fGmc0x/h7cEAqjR3UF1XdS5cQTnMUT/jNaettMFuU/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iNZXBOHxlCAcjG5ZBjHelsBC1joOEtHcsMRqPQcM0IoQyGPeSIIqOL2v1Tug/mY4K
         2zMwyQ+NhAYAyxJBr030hTHGXuUHGQHMWN2249mSy1/FrIOL9/VAYwUDYD7NVXji2Z
         pguGtIqGP/+Jr+TXDjSDlEHF0uccThEFWSYoGJGZv2MTl7TfOteyUFQuJh9rPx8NZe
         Qcj8aubU84wiVcYgdsm0ZRffyqfxr2MW9LZBxfcHiKKMM1EXUZC0W+wgMglZ5j+QLA
         XjNMoSAQD3EN11ma8dCdbw/CPy9VvQkZUp9wg8WhzKSlUzS/gJ2ABnZ3jGmpvnLT0o
         pgv7t611d3J0A==
Date:   Fri, 25 Feb 2022 22:42:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220225224249.cbabe82e530758cdb28e65e9@kernel.org>
In-Reply-To: <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
        <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 11:46:23 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Feb 25, 2022 at 10:32:15AM +0900, Masami Hiramatsu wrote:
> > Hi Peter,
> > 
> > On Thu, 24 Feb 2022 15:51:53 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > With IBT on, sym+0 is no longer the __fentry__ site.
> > > 
> > > NOTE: the architecture has a special case and *does* allow placing an
> > > INT3 breakpoint over ENDBR in which case #BP has precedence over #CP
> > > and as such we don't need to disallow probing these instructions.
> > 
> > Does this mean we can still putting a probe on sym+0??
> 
> I'm not sure... Possibly not. I'm not sure if there's an ABI that
> by-passes kprobes_lookup_name(). Arguably you could give it a direct
> address instead of a name and still hit the ENDBR I think. But the ABI
> surface of this thing it too big for me to easily tell.
> 
> > If so, NAK this patch, since the KPROBES_ON_FTRACE is not meaning
> > to accelerate the function entry probe, but just allows user to
> > put a probe on 'call _mcount' (which can be modified by ftrace).
> > 
> > func:
> >   endbr  <- sym+0  : INT3 is used. (kp->addr = func+0)
> >   nop5   <- sym+4? : ftrace is used. (kp->addr = func+4?)
> >   ...
> > 
> > And anyway, in some case (e.g. perf probe) symbol will be a basement
> > symbol like '_text' and @offset will be the function addr - _text addr
> > so that we can put a probe on local-scope function.
> > 
> > If you think we should not probe on the endbr, we should treat the
> > pair of endbr and nop5 (or call _mcount) instructions as a virtual
> > single instruction. This means kp->addr should point sym+0, but use
> > ftrace to probe.
> > 
> > func:
> >   endbr  <- sym+0  : ftrace is used. (kp->addr = func+0)
> >   nop5   <- sym+4? : This is not able to be probed.
> >   ...
> 
> Well, it's all a bit crap :/
> 
> This patch came from kernel/trace/trace_kprobe.c selftest failing at
> boot. That tries to set a kprobe on kprobe_trace_selftest_target which
> the whole kprobe machinery translates into
> kprobe_trace_selftest_target+0 and then not actually hitting the fentry.

OK.

> 
> IOW, that selftest seems to hard-code/assume +0 matches __fentry__,
> which just isn't true in general (arm64, powerpc are architectures that
> come to mind) and now also might not be true on x86.

Yeah, right. But if we can handle this as above, maybe we can continue
to put the probe on the entry of the function.

> 
> Calling the selftest broken works for me and I'll drop the patch.
> 
> 
> Note that with these patches:
> 
>  - Not every function starts with ENDBR; the compiler is free to omit
>    this instruction if it can determine the function address is never
>    taken (and as such there's never an indirect call to it).
> 
>  - If there is an ENDBR, not every function entry will actually execute
>    it. This first instruction is used exclusively as an indirect entry
>    point. All direct calls should be to the next instruction.
> 
>  - If there was an ENDBR, it might be turned into a 4 byte UD1
>    instruction to ensure any indirect call *will* fail.

Ah, I see. So that is a booby trap for the cracker. 

> 
> Given all that, kprobe users are in a bit of a bind. Determining the
> __fentry__ point basically means they *have* to first read the function
> assembly to figure out where it is.

OK, this sounds like kp->addr should be "call fentry" if there is ENDBR.

> 
> This patch takes the approach that sym+0 means __fentry__, irrespective
> of where it might actually live. I *think* that's more or less
> consistent with what other architectures do; specifically see
> arch/powerpc/kernel/kprobes.c:kprobe_lookup_name(). I'm not quite sure
> what ARM64 does when it has BTI on (which is then very similar to what
> we have here).

Yeah, I know the powerpc does such thing, but I think that is not what
user expected. I actually would like to fix that, because in powerpc
and other non-x86 case (without BTI/IBT), the instructions on sym+0 is
actually executed.

> 
> What do you think makes most sense here?

Are there any way to distinguish the "preparing instructions" (part of
calling mcount) and this kind of trap instruction online[1]? If possible,
I would like to skip such traps, but put the probe on preparing
instructions.
It seems currently we are using ftrace address as the end marker of
the trap instruction, but we actually need another marker to split
the end of ENDBR and the preparing instructions.

[1]
On x86, we have

func:
endbr
call __fentry__ <-- ftrace location

But on other arch,

func:
[BTI instruction]
push return address <--- preparing instruction(s)
call __fentry__     <-- ftrace location



Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
