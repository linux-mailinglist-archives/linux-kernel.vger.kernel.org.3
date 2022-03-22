Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D04E3F45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiCVNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiCVNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:17:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DFA8443ED;
        Tue, 22 Mar 2022 06:16:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A58F31042;
        Tue, 22 Mar 2022 06:16:07 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.92.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50FFA3F73B;
        Tue, 22 Mar 2022 06:16:05 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:15:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
Message-ID: <YjnMDlS/6a4UWFQm@FVFF77S0Q05N>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
 <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:
> On Mon, 21 Mar 2022 17:48:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
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
> > The below gets rid of the objtool warnings.
> 
> Yes, I confirmed that.
> 
> > But I still think it's fairly terrible to get a (flawed) carbon copy of
> > the kretprobe code.
> 
> Indeed. I would like to replace the trampoline code of kretprobe with
> rethook, eventually. There is no reason why we keep the clone.
> (But I need more arch maintainers help for that, there are too many
>  archs implemented kretprobes)

FWIW, I'm more than happy to help on the arm64 side if you could Cc me for
that; I'm aware of other things in this area I'd like to clean up for
backtracing, too.

Thanks,
Mark.
