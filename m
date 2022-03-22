Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B924E3E21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiCVMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiCVMJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:09:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214884EE3;
        Tue, 22 Mar 2022 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IK6WrLeWD44X7iLhXTxcq5l0J/O1EQHnvla6f78FgF8=; b=T1unf0F/j65S1SDua6Asc4cgpV
        UNGGgnLJLNmLLmYo8htzk3VY1V/uvXH45JgcIuhnAaNG6q1ZmzhPuCiHr34COKRdp60WNxadLUzHj
        A20RtDcNZU28ObIhmDd0cjHpLwFoSca51wb6wN2OfBog4bH7kIZxJpQsjOIYZ2wPhxggU2NyurN3e
        Df4Zx9WgfMzIqWti/hXDK0z4pDQwh3wmrKB0ZaVRM9jUyC1xg9sI9mMcqFS1XUMHQF8+OlzV4OBdW
        2mmNxa/m7W0W/Cw63U/G2C6Al3tTUdSF0N0PNQqm/bkk/Ccf1ja3cH47Ynjg6i0TjFmjv4jAqpS/7
        3QMmEX3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWdIN-00BZ8y-89; Tue, 22 Mar 2022 12:07:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B2DF30020B;
        Tue, 22 Mar 2022 13:07:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92B1B2D4484A9; Tue, 22 Mar 2022 13:07:25 +0100 (CET)
Date:   Tue, 22 Mar 2022 13:07:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rostedt@goodmis.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjm7/YbuUwjEP43r@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
 <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
 <YjmD9ks5OAiZkjoL@hirez.programming.kicks-ass.net>
 <20220322181454.659b15269d8c2e2348f19ba1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322181454.659b15269d8c2e2348f19ba1@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 06:14:54PM +0900, Masami Hiramatsu wrote:
> On Tue, 22 Mar 2022 09:08:22 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:
> > 
> > > > Also, I think both should fix regs->ss.
> > > 
> > > I'm not sure this part. Since the return trampoline should run in the same
> > > context of the called function, isn't ss same there too?
> > 
> > It creates pt_regs on the stack, so the trampolines do:
> > 
> > 	push $arch_rethook_trampoline
> > 	push %rsp
> > 	pushf
> > 	sub $24, %rsp /* cs, ip, orig_ax */
> > 	push %rdi
> > 	...
> > 	push %r15
> > 
> > That means that if anybody looks at regs->ss, it'll find
> > $arch_rethook_trampoline, which isn't a valid segment descriptor, or am
> > I just really bad at counting today?
> 
> Ah, got it. It seems that the ss was skipped from the beginning, and
> no one argued that.

Yeah, this is a long-standing issue, but I noticed it when looking at
the code yesterday.

> > I'm thinking you want a copy of __KERNEL_DS in that stack slot, not a
> > function pointer.
> 
> The function pointer is for unwinding stack which involves the kretprobe.
> Anyway, I can add a slot for ss if it is neeeded. But if it always be
> __KERNEL_DS, is it worth to save it?

Probably, to save someone future head-aches. The insn-eval.c stuff will
actually look at SS when it tries to decode BP/SP fields, and I've got
vague memories of actually using that a while ago. I think I was playing
around with double-fault and the whole espfix64 mess and hit the ESPFIX
segment.
