Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F504EC784
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbiC3O4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiC3O4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:56:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C44377C4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:54:32 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 504621EC053C;
        Wed, 30 Mar 2022 16:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648652067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0XcKZj9VtB7PcWTJd2tob0Gsn6yINFgyWOE06eV75IM=;
        b=i6FcvaSf/2lAd7wT5+fLUSk0rF12Bp2H/knX8X60DUpug4C0SaGvCwVNIjZVuD51xRL4kn
        3FMNF9P7VuGeUC3K9vO/oN74wPl9dU47s6Ar4Lx4+4rlzQQmZ296t6tI4uxAyoQZw7wCWO
        V9OcoHkkFyA7OLdms99LnyZqs7r11Rs=
Date:   Wed, 30 Mar 2022 16:54:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Matthias Welwarsky <matthias.welwarsky@sysgo.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: x86, possible bug in __memmove() alternatives patching
Message-ID: <YkRvHqDRVPY0srkQ@zn.tnic>
References: <3422754.iIbC2pHGDl@linux-3513>
 <3346653.QJadu78ljV@linux-3513>
 <066bbff7-d2fe-44d3-0245-ccbcb5990257@intel.com>
 <3160482.aeNJFYEL58@linux-3513>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3160482.aeNJFYEL58@linux-3513>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 03:56:52PM +0200, Matthias Welwarsky wrote:
> Here's the relevant bits:
> 
>         /* FSRM implies ERMS => no length checks, do the copy directly */
> .Lmemmove_begin_forward:
>         ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
>         ALTERNATIVE "", __stringify(movq %rdx, %rcx; rep movsb; RET), 
> X86_FEATURE_ERMS
> 
> If FSRM is there but ERMS isn't, the first ALTERNATIVE is activated but not 
> the second one. That means the length check (< 32) and subsequent "jb 1f" is 
> suppressed but the "movq %rdx, %rcx; rep movsb; RET" is also not there.

Yap, this is what the live, patched code looks like below.

Basically, both alternatives are NOPped out so execution wanders off
somewhere into the weeds.

The kernel has exploded somewhere later during init:

#0  delay_tsc (cycles=2976021) at arch/x86/lib/delay.c:79
#1  0xffffffff81954bd3 in panic (fmt=fmt@entry=0xffffffff82108368 "Attempted to kill init! exitcode=0x%08x\n")
    at kernel/panic.c:359
#2  0xffffffff81954f67 in do_exit (code=<optimized out>, code@entry=9) at kernel/exit.c:775
#3  0xffffffff8108d921 in make_task_dead (signr=9) at kernel/exit.c:898
#4  0xffffffff81001cf7 in rewind_stack_and_make_dead () at arch/x86/entry/entry_64.S:1439
#5  0x0000000000000000 in ?? ()

with the last thing on the console saying:

[    0.200955] Freeing SMP alternatives memory: 32K
<EOF>


(gdb) disas/rs __memmove,+40
Dump of assembler code from 0xffffffff815079a0 to 0xffffffff815079c8:
arch/x86/lib/memmove_64.S:
29              mov %rdi, %rax
   0xffffffff815079a0 <memmove+0>:      48 89 f8        mov    %rdi,%rax

30
31              /* Decide forward/backward copy mode */
32              cmp %rdi, %rsi
   0xffffffff815079a3 <memmove+3>:      48 39 fe        cmp    %rdi,%rsi

33              jge .Lmemmove_begin_forward
   0xffffffff815079a6 <memmove+6>:      7d 0f   jge    0xffffffff815079b7 <__memmove+23>

34              mov %rsi, %r8
   0xffffffff815079a8 <__memmove+8>:    49 89 f0        mov    %rsi,%r8

35              add %rdx, %r8
   0xffffffff815079ab <__memmove+11>:   49 01 d0        add    %rdx,%r8

36              cmp %rdi, %r8
   0xffffffff815079ae <__memmove+14>:   49 39 f8        cmp    %rdi,%r8

37              jg 2f
   0xffffffff815079b1 <__memmove+17>:   0f 8f a9 00 00 00       jg     0xffffffff81507a60 <__memmove+192>

38
39              /* FSRM implies ERMS => no length checks, do the copy directly */
40      .Lmemmove_begin_forward:
41              ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
   0xffffffff815079b7 <__memmove+23>:   0f 1f 84 00 00 00 00 00 nopl   0x0(%rax,%rax,1)
   0xffffffff815079bf <__memmove+31>:   66 90   xchg   %ax,%ax
   0xffffffff815079c1 <__memmove+33>:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

42              ALTERNATIVE "", __stringify(movq %rdx, %rcx; rep movsb; RET), X86_FEATURE_ERMS
43
44              /*
45               * movsq instruction have many startup latency
46               * so we handle small size by general register.
47               */
48              cmp  $680, %rdx
   0xffffffff815079c7 <__memmove+39>:   48 81 fa a8 02 00 00    cmp    $0x2a8,%rdx

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
