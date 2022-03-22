Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A194E3803
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiCVEjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiCVEjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA622BD0;
        Mon, 21 Mar 2022 21:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EDED6132F;
        Tue, 22 Mar 2022 04:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8364EC340EC;
        Tue, 22 Mar 2022 04:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647923888;
        bh=igCacf334RfY5dVvzHolV+3JIBuNaugp0Il6P51645A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TBRJ+kEBZ7IgOw0mvKmv1FDwH2sKYKmy2RLFLMHRiDzpFX9SbDsWKEtdOKOw/dBWQ
         +9mu0a+OMyYVqnCiLRduoufmIDCxZ3x1hQZmivvEYoRYfR0rae4HPf2Dd9Hmkg906R
         UwkJchHxc1cNfEeQ5VIr8OtjTyznm+ZyYpJvfGln2LGIGk8Vs4caMC2rUFax1l1ky7
         c2kONCPNMpXZe9MLC/SWiwjNqd4kBCnkel2A9kcRnlBV05lhIwZCdh1jfOhvAu2sin
         QkNtMb+Mqn/dXha9SEumLkX6GN5NlewyrI9ENER1nwwo4hp4JBLRPoGUn5XKlKrfAQ
         fiwfHE+zSL6rg==
Date:   Tue, 22 Mar 2022 13:38:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, rostedt@goodmis.org, ast@kernel.org,
        hjl.tools@gmail.com, rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-Id: <20220322133802.dbb6ae20968344960091591c@kernel.org>
In-Reply-To: <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <Yjh4xzSWtvR+vqst@hirez.programming.kicks-ass.net>
        <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 14:45:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 21, 2022 at 02:08:23PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 21, 2022 at 02:04:05PM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Mar 21, 2022 at 02:03:27PM +1100, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > After merging the tip tree, today's linux-next build (x864 allmodconfig)
> > > > > produced these new warnings:
> > > > > 
> > > > > vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > > vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocation to !ENDBR: arch_rethook_trampoline+0x0
> > > > 
> > > > Hurmph, lemme go figure out where that code comes from, I've not seen
> > > > those.
> > > 
> > > Ahh, something tracing. I'll go do some patches on top of it.
> > 
> > Also, that x86 patch has never his x86@kernel.org and doesn't have an
> > ACK from any x86 person :-(((
> 
> Worse, it adds a 3rd return trampoline without replacing any of the
> existing two :-(

Sorry about this. I missed to add Ccing to arch maintainers.
Let me check how I can fix those errors.

Thanks.

> 
> Why was this merged?


-- 
Masami Hiramatsu <mhiramat@kernel.org>
