Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA314E68D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352686AbiCXSpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbiCXSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:45:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5729344CD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:43:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so9563494lfj.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SznxYBgLW8a9K7icQkkxQQQmB0jHpEaS7kU5FK71pvk=;
        b=o1CBG1mV9f11VgVz8ncx5nABm/hLQ3k8i/0qeF0Uo54MRY/r3LgqhW0aB1kPPBLT93
         NHuxranzAV3snmi0zRL6EODctyu1eX8FR7Bs3vozkJ68YqknD0ynKjIv0U6hP3WzigrA
         UcYcxgzpqAAXsQMzLCKhbOWq8b81lA5AvsBzBSLnuaf2YfpiTN3/Z9ZH9zo3QvwnzWzd
         0rZAndMjtXG2gP2Vd03Lc19VxyCedjyPLmwP+JRePcOCZ/3fiS6lqAfzaL5mg7y/sVwq
         xOhdwXUjYroWCkN3jxlKokj/lnrpwg4ikYyqc6YYQpolPdCUbiQ1KSvyImkCKv2J0nLD
         oZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SznxYBgLW8a9K7icQkkxQQQmB0jHpEaS7kU5FK71pvk=;
        b=2ClYdVYaclc/TiyHPav9uclOTRMBuOwsp+QDzuTtNTBxX4/0Om/CT8BXx4wl08K0g9
         AayNvmXTGTrBfgqA7DsFTCeeS0fcu53YfjcrZI7qa3/384b6Ps2Z9hbxeOwD8Z820ULq
         Y9gLVYEYtBWc+pwHJSwGT9/83K2D+OLHk5NyOlWZ2dB/H2UWNtx/2YbK2o0FB1d2CB3F
         SRAJDbD9oMEhwc5h0SZlLNWDkkh+zVtXnONOmFvdx4uIlH3l9GsVRXRErZe8Q/zRFqOk
         P586g8aG5CdPZof+SHlqOVv8eG0+0KRLZErzLJ/eWXWIj+SDxnatXfFsEkAdhHLGhgYP
         bcUw==
X-Gm-Message-State: AOAM530eiHh7GVwnrztM2WidVI1Q+Yb/nkqado/pSyXD2l953GNlT6OV
        D6xIJs/odxBrBWPVWCIum4nZodfjr1iyeiOE0yr+6w==
X-Google-Smtp-Source: ABdhPJwl3FHsimV0j/FRMLTa7TeQyLJcX+GDFnUBHAD06jNi3NvA8VGj1za3NlGgQUwdcOY+DkcOQpXusFJ+tjIVSJc=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr4747266lfd.190.1648147437941; Thu, 24
 Mar 2022 11:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <YjxTt3pFIcV3lt8I@zn.tnic>
In-Reply-To: <YjxTt3pFIcV3lt8I@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 24 Mar 2022 11:43:46 -0700
Message-ID: <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
Subject: Re: clang memcpy calls
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 4:19 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi folks,
>
> so I've been looking at a recent objtool noinstr warning from clang
> builds:
>
> vmlinux.o: warning: objtool: sync_regs()+0x20: call to memcpy() leaves .noinstr.text section
>
> The issue is that clang generates a memcpy() call when a struct copy
> happens:
>
>         if (regs != eregs)
>                 *regs = *eregs;

Specifically, this is copying one struct pt_regs to another. It looks
like the sizeof struct pt_regs is just large enough to have clang emit
the libcall.
https://godbolt.org/z/scx6aa8jq
Otherwise clang will also use rep; movsq; when -mno-sse -O2 is set and
the structs are below ARBITRARY_THRESHOLD.  Should ARBITRARY_THRESHOLD
be raised so that we continue to inline the memcpy? *shrug*

Though, looking at the compiled memcpy (`llvm-objdump -D
--disassemble-symbols=memcpy vmlinux`), maybe we *should* try harder.
Filed
https://github.com/llvm/llvm-project/issues/54535.

>
> see below for asm output.
>
> While gcc does simply generate an actual "rep; movsq".
>
> So, how hard would it be to make clang do that too pls?

As Mark said in the sibling reply; I don't know of general ways to
inhibit libcall optimizations on the level you're looking for, short
of heavy handy methods of disabling optimizations entirely.  There's
games that can be played with -fno-builtin-*, but they're not super
portable, and I think there's a handful of *blessed* functions that
must exist in any env, freestanding or not: memcpy, memmove, memset,
and memcmp for which you cannot yet express "these do not exist."

>
> Oh, and another thing while we're comparing asm: I'd love for clang's
> -fverbose-asm to issue interleaved C source lines too, like gcc does.
>
> That's it - no pink pony - just "normal" wishes. :-)

Looks like someone had started work on this in 2017, but it stalled out:
https://github.com/llvm/llvm-project/issues/17839#issuecomment-980923994
Linus has asked for this in the past, too. So it's something we'll add
to the TODO list to revisit.  I highly suspect that clang has
discarded the AST by the time LLVM gets to asm emission, but I could
be wrong.  https://github.com/llvm/llvm-project/issues/17839#issuecomment-1077933948

>
> GCC:
> ====
>
> sync_regs:
> .LASANPC4246:
> # arch/x86/kernel/traps.c:770: {
>         movq    %rdi, %rsi      # tmp91, eregs
> # arch/x86/kernel/traps.c:771:  struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
> #APP
> # 771 "arch/x86/kernel/traps.c" 1
>         movq %gs:cpu_current_top_of_stack(%rip), %rax   # cpu_current_top_of_stack, pfo_val__
> # 0 "" 2
> # arch/x86/kernel/traps.c:771:  struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
> #NO_APP
>         subq    $168, %rax      #, <retval>
> # arch/x86/kernel/traps.c:772:  if (regs != eregs)
>         cmpq    %rdi, %rax      # eregs, <retval>
>         je      .L387   #,
> # arch/x86/kernel/traps.c:773:          *regs = *eregs;
>         movl    $21, %ecx       #, tmp89
>         movq    %rax, %rdi      # <retval>, <retval>
>         rep movsq
> .L387:
> # arch/x86/kernel/traps.c:775: }
>         ret
>
> CLANG:
> ======
>
>         .section        .noinstr.text,"ax",@progbits
>         .globl  sync_regs                       # -- Begin function sync_regs
>         .p2align        6, 0x90
>         .type   sync_regs,@function
> sync_regs:                              # @sync_regs
> # %bb.0:                                # %entry
>         pushq   %rbx
>         #APP
>         movq    %gs:cpu_current_top_of_stack(%rip), %rbx
>         #NO_APP
>         addq    $-168, %rbx
>         cmpq    %rdi, %rbx
>         je      .LBB19_2
> # %bb.1:                                # %if.then
>         movq    %rdi, %rsi
>         movl    $168, %edx
>         movq    %rbx, %rdi
>         callq   memcpy@PLT
> .LBB19_2:                               # %if.end
>         movq    %rbx, %rax
>         popq    %rbx
>         retq
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Thanks,
~Nick Desaulniers
