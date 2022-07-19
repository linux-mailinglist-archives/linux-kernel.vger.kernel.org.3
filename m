Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8547357954C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGSIeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiGSIen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:34:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED9C3CBD8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/eqc8C2YttlByFBthEIEYCYux1DkeFmhc8p302py+JQ=; b=m4e7c+KH4aAqqStqt06zkYNXRY
        lEXXrmMmM5tlF94gY/d6RGMkSGF41RoifCM34cDAtQ39iXgq/NPwhAbMIz8FtRSSgeyotDsNJISL6
        lSoJrVMPI1MbeC5XwDNuS4AOaksDMVipQZTofXUsrN8+BwHsmgvYF0o65otMBhCvNf9xsH8AUe1r9
        9PS4wgx+Xcy+OrZOZjJVivtuSCJ5GTKItWn6BUO9UnEOG4jiZ3U8GZoL5vRS7eykrqWTQb4nwBVYs
        LQUxoRpp2WnPrcywn3AXI97FAJNYUkOBZGp+on0CqplVwii3XSYhh9RQNqDVxcXa6c1VWFVOPGFbA
        PtFGARUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDigE-00DT4n-Vc; Tue, 19 Jul 2022 08:34:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1223A9802A7; Tue, 19 Jul 2022 10:34:09 +0200 (CEST)
Date:   Tue, 19 Jul 2022 10:34:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 37/38] x86/bpf: Emit call depth accounting if required
Message-ID: <YtZsgMl64mWbDZUG@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <20220716230954.898341815@linutronix.de>
 <CAADnVQJb6vY5j+RAW9NYA1gcPXsocytFTL1xvNx+eyWojy3deg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJb6vY5j+RAW9NYA1gcPXsocytFTL1xvNx+eyWojy3deg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:30:01PM -0700, Alexei Starovoitov wrote:
> On Sat, Jul 16, 2022 at 4:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > @@ -1431,19 +1437,26 @@ st:                     if (is_imm8(insn->off))
> >                         break;
> >
> >                         /* call */
> > -               case BPF_JMP | BPF_CALL:
> > +               case BPF_JMP | BPF_CALL: {
> > +                       int offs;
> > +
> >                         func = (u8 *) __bpf_call_base + imm32;
> >                         if (tail_call_reachable) {
> >                                 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >                                 EMIT3_off32(0x48, 0x8B, 0x85,
> >                                             -round_up(bpf_prog->aux->stack_depth, 8) - 8);
> > -                               if (!imm32 || emit_call(&prog, func, image + addrs[i - 1] + 7))
> > +                               if (!imm32)
> >                                         return -EINVAL;
> > +                               offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> 
> It's a bit hard to read all the macro magic in patches 28-30,
> but I suspect the asm inside
> callthunk_desc.template
> that will be emitted here before the call
> will do
> some math on %rax
> movq %rax, PER_CPU_VAR(__x86_call_depth).
> 
> Only %rax register is scratched by the callthunk_desc, right?
> If so, it's ok for all cases except this one.
> See the comment few lines above
> after if (tail_call_reachable)
> and commit ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT")
> We use %rax to keep the tail_call count.
> The callthunk_desc would need to preserve %rax.
> I guess extra push %rax/pop %rax would do it.

The accounting template is basically:

	sarq $5, PER_CPU_VAR(__x86_call_depth)

No registeres used (with debugging on it's a few more memops).
