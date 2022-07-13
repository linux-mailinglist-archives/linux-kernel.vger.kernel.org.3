Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF62573AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiGMQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiGMQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD6C67
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAB461AAD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3510C34114;
        Wed, 13 Jul 2022 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657728811;
        bh=nOM4PVCC020ledRm9uERtcgcfEe1oMeE0QVyxwM6nLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahgE4NZa37YIUA6qhBVA8Sqm9HrocDWU4eE/EQKrsdV5EvNxgkqoSo2sVLZQBPaC+
         wuqOgDt+8f896BEMELWAtTT3TJoskus6uNR2Np8YuItzHuvy1S1sfGveAJXSdDJU6R
         0I5JAiht7C2vjFFqHOs8iaGzQrB5N3K1RburnW09+nwdHbu64vzyo3n7B86Fut6Wt2
         +3o4v1pc47JHB362Zze7rWHaeBH6sjG5QwpQGVyV5BL5ALyE4wm8yx96eS6WmvFeKE
         eL5vsowMmfsd4HEXXVPhXcGK2FLm9tH1OvLTmvef8gZcPHMvsWjyksMGrLIh0JXJRR
         CJc+IP8urYG+A==
Date:   Wed, 13 Jul 2022 09:13:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: objtool "'naked' return found in RETHUNK build" with clang +
 CONFIG_K{A,C}SAN=y
Message-ID: <Ys7vKYJ9tyih8Cng@dev-arch.thelio-3990X>
References: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X>
 <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:01:58AM -0700, Nick Desaulniers wrote:
> On Wed, Jul 13, 2022 at 8:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Josh and Peter,
> >
> > After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
> > commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
> > see a spew of objtool warnings when building certain configurations with
> > clang. Examples below, they appear to trigger in every single file.
> >
> > With x86_64_defconfig + CONFIG_KASAN=y:
> >
> > arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
> > init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> >
> > With x86_64_defconfig + CONFIG_KCSAN=y:
> >
> > arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> 
> Thanks for the report. I wonder if this might be a compiler bug; it
> seems like the {a|t}san.module_{c|d}tor functions are being emitted
> with ret instructions?
> 
> If you have one of these builds lying around still, can you provide:
> 
> $ llvm-objdump -dr --disassemble-symbols=tsan.module_ctor
> arch/x86/kernel/fpu/bugs.o

Sure thing.

With KASAN:

$ llvm-objdump -r --disassemble-symbols=asan.module_ctor,asan.module_dtor build/arch/x86/kernel/fpu/bugs.o

build/arch/x86/kernel/fpu/bugs.o:	file format elf64-x86-64

Disassembly of section .text.asan.module_ctor:

0000000000000000 <asan.module_ctor>:
       0: be 01 00 00 00               	movl	$1, %esi
       5: 48 c7 c7 00 00 00 00         	movq	$0, %rdi
		0000000000000008:  R_X86_64_32S	.data
       c: e8 00 00 00 00               	callq	0x11 <asan.module_ctor+0x11>
		000000000000000d:  R_X86_64_PLT32	__asan_register_globals-0x4
      11: c3                           	retq

Disassembly of section .text.asan.module_dtor:

0000000000000000 <asan.module_dtor>:
       0: be 01 00 00 00               	movl	$1, %esi
       5: 48 c7 c7 00 00 00 00         	movq	$0, %rdi
		0000000000000008:  R_X86_64_32S	.data
       c: e8 00 00 00 00               	callq	0x11 <asan.module_dtor+0x11>
		000000000000000d:  R_X86_64_PLT32	__asan_unregister_globals-0x4
      11: c3                           	retq

With KCSAN:

$ llvm-objdump -r --disassemble-symbols=tsan.module_ctor build/arch/x86/kernel/fpu/bugs.o

build/arch/x86/kernel/fpu/bugs.o:	file format elf64-x86-64

Disassembly of section .text.tsan.module_ctor:

0000000000000000 <tsan.module_ctor>:
       0: e8 00 00 00 00               	callq	0x5 <tsan.module_ctor+0x5>
		0000000000000001:  R_X86_64_PLT32	__tsan_init-0x4
       5: c3                           	retq

Cheers,
Nathan
