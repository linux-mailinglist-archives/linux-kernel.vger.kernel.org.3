Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6044E625A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbiCXLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiCXLVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:21:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563C558B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:19:29 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C0191EC04F9;
        Thu, 24 Mar 2022 12:19:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648120764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=zQ487WGGxoU+PaAQiF6Z96QlXNCWPl8aoNSJ7IshVJ8=;
        b=fQB156FoQMS/bM1ss8dkbyOOZIvEx+opgWLoP6Jb/LSVXWv40/w5Df61jEVhjjMICBLozD
        0o1VC9MdAlaJYx7Ba///m/C10EweJbQvDInMTpKR6ps8imKToZxgXwh1A46FKRBcVtawCr
        uA6hE8op4Cllx/rOHdDTsqOXT/1cR7I=
Date:   Thu, 24 Mar 2022 12:19:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: clang memcpy calls
Message-ID: <YjxTt3pFIcV3lt8I@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

so I've been looking at a recent objtool noinstr warning from clang
builds:

vmlinux.o: warning: objtool: sync_regs()+0x20: call to memcpy() leaves .noinstr.text section

The issue is that clang generates a memcpy() call when a struct copy
happens:

        if (regs != eregs)
                *regs = *eregs;

see below for asm output.

While gcc does simply generate an actual "rep; movsq".

So, how hard would it be to make clang do that too pls?

Oh, and another thing while we're comparing asm: I'd love for clang's
-fverbose-asm to issue interleaved C source lines too, like gcc does.

That's it - no pink pony - just "normal" wishes. :-)

GCC:
====

sync_regs:
.LASANPC4246:
# arch/x86/kernel/traps.c:770: {
        movq    %rdi, %rsi      # tmp91, eregs
# arch/x86/kernel/traps.c:771:  struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
#APP
# 771 "arch/x86/kernel/traps.c" 1
        movq %gs:cpu_current_top_of_stack(%rip), %rax   # cpu_current_top_of_stack, pfo_val__
# 0 "" 2
# arch/x86/kernel/traps.c:771:  struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
#NO_APP
        subq    $168, %rax      #, <retval>
# arch/x86/kernel/traps.c:772:  if (regs != eregs)
        cmpq    %rdi, %rax      # eregs, <retval>
        je      .L387   #,
# arch/x86/kernel/traps.c:773:          *regs = *eregs;
        movl    $21, %ecx       #, tmp89
        movq    %rax, %rdi      # <retval>, <retval>
        rep movsq
.L387:
# arch/x86/kernel/traps.c:775: }
        ret

CLANG:
======

        .section        .noinstr.text,"ax",@progbits
        .globl  sync_regs                       # -- Begin function sync_regs
        .p2align        6, 0x90
        .type   sync_regs,@function
sync_regs:                              # @sync_regs
# %bb.0:                                # %entry
        pushq   %rbx
        #APP
        movq    %gs:cpu_current_top_of_stack(%rip), %rbx
        #NO_APP
        addq    $-168, %rbx
        cmpq    %rdi, %rbx
        je      .LBB19_2
# %bb.1:                                # %if.then
        movq    %rdi, %rsi
        movl    $168, %edx
        movq    %rbx, %rdi
        callq   memcpy@PLT
.LBB19_2:                               # %if.end
        movq    %rbx, %rax
        popq    %rbx
        retq


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
