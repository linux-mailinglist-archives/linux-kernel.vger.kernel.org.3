Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9262573B28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiGMQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiGMQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:25:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CD2DE9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=832nvkZXqaW1Rdvm3esdQt5krPHyQbIa8+WuQyv+HXM=; b=dph457u6XiKxidXKO4sosmAwGu
        xPbibBbBM32DDiTYhs2OoY3zXXQPjdF9K6VsNUkq0Htv48uhqv9cZ8QQUGrex+vRrcTJfcl2YxNsM
        PHcq3fRdG22401ROx3f9N4yPVz/h2tW+uuQyU3nqaeh9UBiL3jxDvt6MxpAR2WqM921kT9adnjvYw
        tfFGPWo8D4PM8zZwbQM+BM0CfXMaSSeabOAMVgGh2KQtRLgt85oGDDgQrw7M+GubmMDtU7+0SRIKC
        3kFApEdn7uproQKEn0RBpUN/65qsg/DtI+jNCyxXOxkjTS6VjlVD9IFyMZPnr/n6Gn4lZMX0gQrXV
        t2OpBEng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBfBG-008OTG-9T; Wed, 13 Jul 2022 16:25:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E40E930041D;
        Wed, 13 Jul 2022 18:25:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDF2220D74F04; Wed, 13 Jul 2022 18:25:41 +0200 (CEST)
Date:   Wed, 13 Jul 2022 18:25:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: objtool "'naked' return found in RETHUNK build" with clang +
 CONFIG_K{A,C}SAN=y
Message-ID: <Ys7yBcfBRWXPLsLq@hirez.programming.kicks-ass.net>
References: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X>
 <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
 <Ys7vKYJ9tyih8Cng@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7vKYJ9tyih8Cng@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:13:29AM -0700, Nathan Chancellor wrote:
> On Wed, Jul 13, 2022 at 09:01:58AM -0700, Nick Desaulniers wrote:
> > On Wed, Jul 13, 2022 at 8:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi Josh and Peter,
> > >
> > > After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
> > > commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
> > > see a spew of objtool warnings when building certain configurations with
> > > clang. Examples below, they appear to trigger in every single file.
> > >
> > > With x86_64_defconfig + CONFIG_KASAN=y:
> > >
> > > arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
> > > init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > >
> > > With x86_64_defconfig + CONFIG_KCSAN=y:
> > >
> > > arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > 
> > Thanks for the report. I wonder if this might be a compiler bug; it
> > seems like the {a|t}san.module_{c|d}tor functions are being emitted
> > with ret instructions?
> > 
> > If you have one of these builds lying around still, can you provide:
> > 
> > $ llvm-objdump -dr --disassemble-symbols=tsan.module_ctor
> > arch/x86/kernel/fpu/bugs.o
> 
> Sure thing.
> 
> With KASAN:
> 
> $ llvm-objdump -r --disassemble-symbols=asan.module_ctor,asan.module_dtor build/arch/x86/kernel/fpu/bugs.o
> 
> build/arch/x86/kernel/fpu/bugs.o:	file format elf64-x86-64
> 
> Disassembly of section .text.asan.module_ctor:
> 
> 0000000000000000 <asan.module_ctor>:
>        0: be 01 00 00 00               	movl	$1, %esi
>        5: 48 c7 c7 00 00 00 00         	movq	$0, %rdi
> 		0000000000000008:  R_X86_64_32S	.data
>        c: e8 00 00 00 00               	callq	0x11 <asan.module_ctor+0x11>
> 		000000000000000d:  R_X86_64_PLT32	__asan_register_globals-0x4
>       11: c3                           	retq

As Nick said; this should be: 'jmp __x86_return_thunk', on those builds.
