Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7024F8059
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbiDGNVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbiDGNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:21:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4625ECAE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:19:06 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C87291EC0374;
        Thu,  7 Apr 2022 15:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649337540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZATBzTZMokNeN4igmVVfQJf7SSJwYkYInz5yH9/Cy+4=;
        b=qNpgJiE5GAGR0+0rVGAVwEFHSDkYd8gzxE6o4kZtpram52PHGJKV4agaO/xqZaMuCekokQ
        0zFb7XAQedvBVYHYjvVTsahYF8uPrxxVq/KkinU+22tnidOEQtcShrBmJ8ujb8aZbDUefH
        JlQ/N/AHOlIEWidgsAS6uhzy6GLxYbI=
Date:   Thu, 7 Apr 2022 15:18:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Message-ID: <Yk7kwzIv2YA+aO7y@zn.tnic>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
 <20220318143016.124387-2-jiangshanlai@gmail.com>
 <Yk3jVrXoVpxuR0Mp@zn.tnic>
 <CAJhGHyBFbtyUs-nf0+gWm2a3hiS5BxZ3jk=sbGNw-4ShB8AtzQ@mail.gmail.com>
 <Yk6fQfgo975pW3t0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yk6fQfgo975pW3t0@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:22:25AM +0200, Borislav Petkov wrote:
> Maybe there was a reason it was done this way:

Ok, I went and singlestepped this code so that I can see what's going
on.

The second memcpy in fixup_bad_iret() copies the remainder of pt_regs
from the current stack. The result in tmp looks like this:

(gdb) p/x tmp
$10 = {error_entry_ret = 0xffffffff81a00998, regs = {r15 = 0x0, r14 = 0x0, r13 = 0x7fffffffea30, r12 = 0x40002b, bp = 0x40, 
    bx = 0xa, r11 = 0x246, r10 = 0x8, r9 = 0x7fffffffe860, r8 = 0x0, ax = 0x0, cx = 0x0, dx = 0x0, si = 0x7fffffffe860, 
    di = 0x2, orig_ax = 0x30, ip = 0x403000, cs = 0x33, flags = 0x246, sp = 0x8badf00d5aadc0de, ss = 0x33}}

note error_entry_ret which is:

(gdb) x/10i 0xffffffff81a00998
   0xffffffff81a00998 <asm_exc_general_protection+8>:   mov    %rsp,%rdi
   0xffffffff81a0099b <asm_exc_general_protection+11>:  mov    0x78(%rsp),%rsi
   0xffffffff81a009a0 <asm_exc_general_protection+16>:  movq   $0xffffffffffffffff,0x78(%rsp)
   0xffffffff81a009a9 <asm_exc_general_protection+25>:  call   0xffffffff818c8960 <exc_general_protection>
   0xffffffff81a009ae <asm_exc_general_protection+30>:  jmp    0xffffffff81a01030 <error_return>
   0xffffffff81a009b3:  data16 nopw %cs:0x0(%rax,%rax,1)

i.e., the return address to the #GP handler that has been pushed on
the stack when the IRET fault has happened and former has called
error_entry().

fixup_bad_iret() then ends up returning this in new_stack:

(gdb) p/x *new_stack
$12 = {error_entry_ret = 0xffffffff81a00998, regs = {r15 = 0x0, r14 = 0x0, r13 = 0x7fffffffea30, r12 = 0x40002b, bp = 0x40, 
    bx = 0xa, r11 = 0x246, r10 = 0x8, r9 = 0x7fffffffe860, r8 = 0x0, ax = 0x0, cx = 0x0, dx = 0x0, si = 0x7fffffffe860, 
    di = 0x2, orig_ax = 0x30, ip = 0x403000, cs = 0x33, flags = 0x246, sp = 0x8badf00d5aadc0de, ss = 0x33}}

and when error_entry() does:

        mov     %rax, %rsp

The stack has:

=> 0xffffffff81a0102d <error_entry+173>:        jmp    0xffffffff81a00fd2 <error_entry+82>
0xfffffe0000250f50:     0xffffffff81a00998      0x0000000000000000
0xfffffe0000250f60:     0x0000000000000000      0x00007fffffffea30
0xfffffe0000250f70:     0x000000000040002b      0x0000000000000040
0xfffffe0000250f80:     0x000000000000000a      0x0000000000000246
0xfffffe0000250f90:     0x0000000000000008      0x00007fffffffe860

and you can recognize new_stack there.

Then it does:

        jmp     error_entry_from_usermode_after_swapgs

where it does:

error_entry_from_usermode_after_swapgs:
        /* Put us onto the real thread stack. */
        popq    %r12                            /* save return addr in %12 */
        movq    %rsp, %rdi                      /* arg0 = pt_regs pointer */
        call    sync_regs
        movq    %rax, %rsp                      /* switch stack */
        ENCODE_FRAME_POINTER
        pushq   %r12
        RET

and in here it uses %r12 to stash the return address 0xffffffff81a00998
while sync_regs() runs.

So yeah, all your patch does is get rid of void *error_entry_ret in

struct bad_iret_stack {
        void *error_entry_ret;
        struct pt_regs regs;
};

So your commit message should have been as simple as:

"Always stash the address error_entry() is going to return to, in %r12
and get rid of the void *error_entry_ret; slot in struct bad_iret_stack
which was supposed to account for it and pt_regs pushed on the stack.

After this, both functions can work on a struct pt_regs pointer
directly."

In any case, I don't see why amluto would do this so this looks like a
sensible cleanup to do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
