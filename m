Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6E528D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiEPSbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344954AbiEPSbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:31:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9502632EFB;
        Mon, 16 May 2022 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+8+afjaY3BKlHOSP79HK/qVp1CiDmSymT4MdofQ8IZ4=; b=q5xCbm4UH9jAMw10q00U9nl9fj
        KFfw+45+4Ggx4ZuRGbGIeBDWL5TE5EcKIheQZ2HOcD65sqSiIJSKWVcm/alk5iPqH8nIHyuoX2Q1D
        0aBYvGEmDA++xrFn7XpzW5GE/RMldzEZTDzod7CKCiofXw9cSy/uvAsduoZy9pzdYtPF2KMZpn4S5
        Bke46GD3RlhLsRiOYndBdsYizCEF9XKawVbKWaZqVWT7Wy0StoGuSLfn2434+wBNK4FK+a7PqP+pc
        Pi3ws4dWkxHA7vo9Gcziiim2MLThS/eXzQRC3Ex4YQg630x8f9zgXJU6jLDJNHGDTXF/3T52t/ZUg
        CoLNqxyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqfUX-00A7XG-Vy; Mon, 16 May 2022 18:30:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BC17980DCC; Mon, 16 May 2022 20:30:47 +0200 (CEST)
Date:   Mon, 16 May 2022 20:30:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <20220516183047.GM76023@worktop.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:15:00AM -0700, Sami Tolvanen wrote:
> On Mon, May 16, 2022 at 2:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 13, 2022 at 01:21:58PM -0700, Sami Tolvanen wrote:
> > > With CONFIG_CFI_CLANG, the compiler injects a type preamble
> > > immediately before each function and a check to validate the target
> > > function type before indirect calls:
> > >
> > >   ; type preamble
> > >   __cfi_function:
> > >     int3
> > >     int3
> > >     mov <id>, %eax
> > >     int3
> > >     int3
> > >   function:
> > >     ...
> >
> > When I enable CFI_CLANG and X86_KERNEL_IBT I get:
> >
> > 0000000000000c80 <__cfi_io_schedule_timeout>:
> > c80:   cc                      int3
> > c81:   cc                      int3
> > c82:   b8 b5 b1 39 b3          mov    $0xb339b1b5,%eax
> > c87:   cc                      int3
> > c88:   cc                      int3
> >
> > 0000000000000c89 <io_schedule_timeout>:
> > c89:   f3 0f 1e fa             endbr64
> >
> >
> > That seems unfortunate. Would it be possible to get an additional
> > compiler option to suppress the endbr for all symbols that get a __cfi_
> > preaamble?
> 
> What's the concern with the endbr? Dropping it would currently break
> the CFI+IBT combination on newer hardware, no?

Well, yes, but also that combination isn't very interesting. See,

  https://lore.kernel.org/all/20220420004241.2093-1-joao@overdrivepizza.com/T/#m5d67fb010d488b2f8eee33f1eb39d12f769e4ad2

and the patch I did down-thread:

  https://lkml.kernel.org/r/YoJKhHluN4n0kZDm@hirez.programming.kicks-ass.net

If we have IBT, then FineIBT is a much better option than kCFI+IBT.
Removing that superfluous endbr also shrinks the whole thing by 4 bytes.

So I'm fine with the compiler generating working code for that
combination; but please get me an option to supress it in order to save
those pointless bytes. All this CFI stuff is enough bloat as it is.

> > >   ; indirect call check
> > >     cmpl    <id>, -6(%r11)
> > >     je      .Ltmp1
> > >     ud2
> > >   .Ltmp1:
> > >     call    __x86_indirect_thunk_r11
> >
> > The first one I try and find looks like:
> >
> > 26:       41 81 7b fa a6 96 9e 38         cmpl   $0x389e96a6,-0x6(%r11)
> > 2e:       74 02                   je     32 <__traceiter_sched_kthread_stop+0x29>
> > 30:       0f 0b                   ud2
> > 32:       4c 89 f6                mov    %r14,%rsi
> > 35:       e8 00 00 00 00          call   3a <__traceiter_sched_kthread_stop+0x31> 36: R_X86_64_PLT32      __x86_indirect_thunk_r11-0x4
> >
> > This must not be. If I'm to rewrite that lot to:
> >
> >   movl  $\hash, %r10d
> >   sub   $9, %r11
> >   call  *%r11
> >   .nop  4
> >
> > Then there must not be spurious instruction in between the ud2 and the
> > indirect call/retpoline thing.
> 
> With the current compiler patch, LLVM sets up function arguments after
> the CFI check. if it's a problem, we can look into changing that.

Yes, please fix that. Again see that same patch for why this is a
problem. Objtool can trivially find retpoline calls, but finding this
kCFI gadget is going to be hard work. If you ensure they're
unconditionally stuck together, then the problem goes away find one,
finds the other.

