Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E84E3B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiCVJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiCVJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:16:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3C29CA2;
        Tue, 22 Mar 2022 02:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED727B81C59;
        Tue, 22 Mar 2022 09:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAFAC340EC;
        Tue, 22 Mar 2022 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647940499;
        bh=WINthaWEckUg/sw0H371TWwDWslpgqf/pcyy3jLtdrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h/RXRssYXgvARgN2tqZnMmbKhZfNUhhZWVQKzU8xjhO87aHYUFM3tcIRPXZF8evcm
         1mK/I8kWc0EAdCnLT3NiqCQJBfeFzQg11c8DfWEoCrH9FdSJi8HmBmzPar6XP/gTB2
         hCw6V1Jm0XjMMaBMOPN/JxUTCbTxYPiYghuG+N2A73r7GHGk+5DIOAMCGjypmQLe77
         qyTAuReggOQs4z4ROUD7dzuBzceoZ/0i0KFfrQ1dok37VXAObaZ9aZ47fkSYkE2ZKj
         vgCqXYTd7eZr+RMue4/vAhlduhz8Gb8ljm7eby0lrwjm4eDPBFbLnJG0AyNiZYoWDW
         cfVM15bijCA4A==
Date:   Tue, 22 Mar 2022 18:14:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-Id: <20220322181454.659b15269d8c2e2348f19ba1@kernel.org>
In-Reply-To: <YjmD9ks5OAiZkjoL@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
        <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
        <YjmD9ks5OAiZkjoL@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 09:08:22 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:
> 
> > > Also, I think both should fix regs->ss.
> > 
> > I'm not sure this part. Since the return trampoline should run in the same
> > context of the called function, isn't ss same there too?
> 
> It creates pt_regs on the stack, so the trampolines do:
> 
> 	push $arch_rethook_trampoline
> 	push %rsp
> 	pushf
> 	sub $24, %rsp /* cs, ip, orig_ax */
> 	push %rdi
> 	...
> 	push %r15
> 
> That means that if anybody looks at regs->ss, it'll find
> $arch_rethook_trampoline, which isn't a valid segment descriptor, or am
> I just really bad at counting today?

Ah, got it. It seems that the ss was skipped from the beginning, and
no one argued that.

> I'm thinking you want a copy of __KERNEL_DS in that stack slot, not a
> function pointer.

The function pointer is for unwinding stack which involves the kretprobe.
Anyway, I can add a slot for ss if it is neeeded. But if it always be
__KERNEL_DS, is it worth to save it?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
