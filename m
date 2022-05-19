Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB5752DCD9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbiESSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiESSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:31:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339556386
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:31:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m25so7487090oih.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z06dV0jy9Z09Mlv2qu5M8WQC5pe6nmMKzIWhA5pZHEM=;
        b=QGK8bsVJtt/KFlXCYsIM7TkzinPW/WmuFW9nzb1RSwzutstwUoP6klxukOffbGHxl7
         dMzB40UjZWcAzurfKlPm/kUlVWhAzNNWFUQFO/LPaErts83w9n7t948inntzt1ejnuD+
         D4+4ASeIWPo+3sdNdFZQ7nySnenwmmRdji6fLbIINgHnQ0ItYt/iUsDStOwj5CAGmp5G
         b+jLaHWsGmocbNjKhZ1MethlmRIvN3IUbll9gvIZnq9bmO3iPb8XhEyHWg/8XL3pjy1b
         aI2DoPQ5TYuYlG5mBU4Om7BYqqZCpseqSTtTKNH8UFjaylQ2QzrmmDoFOwDtfUWKutg4
         fClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Z06dV0jy9Z09Mlv2qu5M8WQC5pe6nmMKzIWhA5pZHEM=;
        b=GU8g5cn8olImES7FriDmIP03gqQKRiA/ZltClK17f+hKbw17LOICNu60Pacm3lUyGy
         wl2ByxnQsrtVPj555qDk23CTTtQ2zoMAZ2IqTHIc8tSTYaPZaI+vG8lNCvgXWky90WnX
         2/EStL1rvYARyAjhcaE3ZanewaEJzsXjRdXdiCO7X3SHfNFg9QM/AsddHrEsKwoF/WlA
         FK37mptILGAoU9Um4Hw9K4ZtNtha1A7QHixqQapeOQK9sA2Dudc1t2E3KHK/OedyXLZq
         AvOFQil4PB7myb4C4MveEWIeF7P6RoPw0hYhQpzVTR+XdIHLQrYsOczKzmmMJe/sOJuF
         Xj2g==
X-Gm-Message-State: AOAM5307Udj3GDXx8eSLLuo2NcbD949Jwg1LqKB9qHug2UK9W0BdOrFu
        0vPcnRysM2A17P7BDOomHRM=
X-Google-Smtp-Source: ABdhPJwltmX5/J5vLQXNRgG6ibBfTelOTPDksm8dMXXj57ldvFkJiPMa3rrKOaymEcr9hbLT57jEyw==
X-Received: by 2002:a05:6808:11ce:b0:2f9:d196:6597 with SMTP id p14-20020a05680811ce00b002f9d1966597mr3559632oiv.179.1652985077535;
        Thu, 19 May 2022 11:31:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870d34300b000f193e656c5sm17719oag.15.2022.05.19.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:31:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 19 May 2022 11:31:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220519183115.GA80510@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:35:38AM -0700, Josh Poimboeuf wrote:
> On Thu, May 19, 2022 at 10:11:31AM -0700, Josh Poimboeuf wrote:
> > On Thu, May 19, 2022 at 07:00:09PM +0200, Peter Zijlstra wrote:
> > > On Thu, May 19, 2022 at 09:24:11AM -0700, Guenter Roeck wrote:
> > > > On Fri, May 06, 2022 at 02:14:34PM +0200, Peter Zijlstra wrote:
> > > > > Since the upper regs don't exist for ia32 code, preserving them
> > > > > doesn't hurt and it simplifies the code.
> > > > > 
> > > > > This doesn't add any attack surface that would not already be
> > > > > available through INT80.
> > > > > 
> > > > > Notably:
> > > > > 
> > > > >  - 32bit SYSENTER: didn't clear si, dx, cx.
> > > > > 
> > > > >  - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
> > > > >    take a second argument.
> > > > > 
> > > > >  - 64bit: didn't clear si since the C functions take a second
> > > > >    argument; except the error_entry path might have only one argument,
> > > > >    so clearing si was missing here.
> > > > > 
> > > > > 32b SYSENTER should be clearing all those 3 registers, nothing uses them
> > > > > and selftests pass.
> > > > > 
> > > > > Unconditionally clear rsi since it simplifies code.
> > > > > 
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > Reviewed-by: Borislav Petkov <bp@suse.de>
> > > > 
> > > > linux-next (next-20220519) crashes due to this patch when booting
> > > > q35:EPYC-Rome in qemu.
> > > 
> > > Could you try backing out each of the hunks one at a time? They're all
> > > more or less independent.
> > > 
> > > My bet with this being a #PF on an AMD machine, it's either the SI clear
> > > or the SYSCALL change.
> > 
> > I think this should fix it:
> 
> Actually that one had a horrendous bug :-)
> 
> Guenter, can you try this one?
> 

This fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] x86/entry: Fix register corruption in compat syscall
> 
> A panic was reported in the init process on AMD:
> 
>   Run /sbin/init as init process
>   init[1]: segfault at f7fd5ca0 ip 00000000f7f5bbc7 sp 00000000ffa06aa0 error 7 in libc.so[f7f51000+4e000]
>   Code: 8a 44 24 10 88 41 ff 8b 44 24 10 83 c4 2c 5b 5e 5f 5d c3 53 83 ec 08 8b 5c 24 10 81 fb 00 f0 ff ff 76 0c e8 ba dc ff ff f7 db <89> 18 83 cb ff 83 c4 08 89 d8 5b c3 e8 81 60 ff ff 05 28 84 07 00
>   Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>   CPU: 1 PID: 1 Comm: init Tainted: G        W         5.18.0-rc7-next-20220519 #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x57/0x7d
>    panic+0x10f/0x28d
>    do_exit.cold+0x18/0x48
>    do_group_exit+0x2e/0xb0
>    get_signal+0xb6d/0xb80
>    arch_do_signal_or_restart+0x31/0x760
>    ? show_opcodes.cold+0x1c/0x21
>    ? force_sig_fault+0x49/0x70
>    exit_to_user_mode_prepare+0x131/0x1a0
>    irqentry_exit_to_user_mode+0x5/0x30
>    asm_exc_page_fault+0x27/0x30
>   RIP: 0023:0xf7f5bbc7
>   Code: 8a 44 24 10 88 41 ff 8b 44 24 10 83 c4 2c 5b 5e 5f 5d c3 53 83 ec 08 8b 5c 24 10 81 fb 00 f0 ff ff 76 0c e8 ba dc ff ff f7 db <89> 18 83 cb ff 83 c4 08 89 d8 5b c3 e8 81 60 ff ff 05 28 84 07 00
>   RSP: 002b:00000000ffa06aa0 EFLAGS: 00000217
>   RAX: 00000000f7fd5ca0 RBX: 000000000000000c RCX: 0000000000001000
>   RDX: 0000000000000001 RSI: 00000000f7fd5b60 RDI: 00000000f7fd5b60
>   RBP: 00000000f7fd1c1c R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
> 
> The task's CX register got corrupted by commit 8c42819b61b8 ("x86/entry:
> Use PUSH_AND_CLEAR_REGS for compat"), which overlooked the fact that
> compat SYSCALL had the user's CX value stored in BP.
> 
> Before that commit, CX was saved from its stashed value in BP:
> 
> 	pushq   %rbp                    /* pt_regs->cx (stashed in bp) */
> 
> But then it got changed to:
> 
> 	pushq	%rcx			/* pt_regs->cx */
> 
> resulting in the wrong value getting saved and later restored back to
> the user.  Fix it by pushing the correct value again (BP) for regs->cx.
> 
> Fixes: 8c42819b61b8 ("x86/entry: Use PUSH_AND_CLEAR_REGS for compat")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/entry/calling.h         | 8 ++++----
>  arch/x86/entry/entry_64_compat.S | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index a97cc78ecb92..29b36e9e4e74 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -63,7 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
>   * for assembly code:
>   */
>  
> -.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
> +.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
>  	.if \save_ret
>  	pushq	%rsi		/* pt_regs->si */
>  	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
> @@ -73,7 +73,7 @@ For 32-bit we have the following conventions - kernel is built with
>  	pushq   %rsi		/* pt_regs->si */
>  	.endif
>  	pushq	\rdx		/* pt_regs->dx */
> -	pushq   %rcx		/* pt_regs->cx */
> +	pushq   \rcx		/* pt_regs->cx */
>  	pushq   \rax		/* pt_regs->ax */
>  	pushq   %r8		/* pt_regs->r8 */
>  	pushq   %r9		/* pt_regs->r9 */
> @@ -115,8 +115,8 @@ For 32-bit we have the following conventions - kernel is built with
>  
>  .endm
>  
> -.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
> -	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
> +.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
> +	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret
>  	CLEAR_REGS
>  .endm
>  
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index ed2be3615b50..f76e674d22c4 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -200,7 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
>  SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
>  	movl	%eax, %eax		/* discard orig_ax high bits */
>  	pushq	%rax			/* pt_regs->orig_ax */
> -	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
> +	PUSH_AND_CLEAR_REGS rcx=%rbp rax=$-ENOSYS
>  	UNWIND_HINT_REGS
>  
>  	movq	%rsp, %rdi
> -- 
> 2.34.3
> 
