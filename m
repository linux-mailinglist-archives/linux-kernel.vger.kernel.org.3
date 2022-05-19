Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D896C52DB67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbiESRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiESRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:35:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E51AD9A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBBA617EE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B925DC34100;
        Thu, 19 May 2022 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981740;
        bh=2fwwgr4CUtaWp+UckqeNSTHW1jOzzTdH2/Mavh/XLwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDtCk577IEluCemliWzJzF9lBy9LtZ8srctTvEooblT+ii6lNi0LPAnWcD0mxfYFp
         kF3DCeRaTsOUqiPp1LU302ikrav45YAz84FRpNbGpJ8X7cJFl2dGR2Qhi4w1EHV2iR
         /or/dP7lk6FNLtIrzf30kvmN3z4PEya5llM/VtC7p5RXdja5oIn5rYNR2SM8m4wuND
         vEbeRZ/IHHVFj425Nocd1Jc/azhGLe2iC/sRPKHqcpp3IQYGFl3dgeyv/1pSG5ltXW
         jSapp99BUYiMUDX4DBhOdTZvizh/2+JydNreNT5DKG4pT5bOYTC+an4IQFEejx0Mez
         JVmIptPLlJjIg==
Date:   Thu, 19 May 2022 10:35:38 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220519173538.nywtw2h3y7sqfojn@treble>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.293889636@infradead.org>
 <20220519162411.GA4095576@roeck-us.net>
 <20220519170009.GL2578@worktop.programming.kicks-ass.net>
 <20220519171129.enw32izjhxsqc2xm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519171129.enw32izjhxsqc2xm@treble>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:11:31AM -0700, Josh Poimboeuf wrote:
> On Thu, May 19, 2022 at 07:00:09PM +0200, Peter Zijlstra wrote:
> > On Thu, May 19, 2022 at 09:24:11AM -0700, Guenter Roeck wrote:
> > > On Fri, May 06, 2022 at 02:14:34PM +0200, Peter Zijlstra wrote:
> > > > Since the upper regs don't exist for ia32 code, preserving them
> > > > doesn't hurt and it simplifies the code.
> > > > 
> > > > This doesn't add any attack surface that would not already be
> > > > available through INT80.
> > > > 
> > > > Notably:
> > > > 
> > > >  - 32bit SYSENTER: didn't clear si, dx, cx.
> > > > 
> > > >  - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
> > > >    take a second argument.
> > > > 
> > > >  - 64bit: didn't clear si since the C functions take a second
> > > >    argument; except the error_entry path might have only one argument,
> > > >    so clearing si was missing here.
> > > > 
> > > > 32b SYSENTER should be clearing all those 3 registers, nothing uses them
> > > > and selftests pass.
> > > > 
> > > > Unconditionally clear rsi since it simplifies code.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Reviewed-by: Borislav Petkov <bp@suse.de>
> > > 
> > > linux-next (next-20220519) crashes due to this patch when booting
> > > q35:EPYC-Rome in qemu.
> > 
> > Could you try backing out each of the hunks one at a time? They're all
> > more or less independent.
> > 
> > My bet with this being a #PF on an AMD machine, it's either the SI clear
> > or the SYSCALL change.
> 
> I think this should fix it:

Actually that one had a horrendous bug :-)

Guenter, can you try this one?

From: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] x86/entry: Fix register corruption in compat syscall

A panic was reported in the init process on AMD:

  Run /sbin/init as init process
  init[1]: segfault at f7fd5ca0 ip 00000000f7f5bbc7 sp 00000000ffa06aa0 error 7 in libc.so[f7f51000+4e000]
  Code: 8a 44 24 10 88 41 ff 8b 44 24 10 83 c4 2c 5b 5e 5f 5d c3 53 83 ec 08 8b 5c 24 10 81 fb 00 f0 ff ff 76 0c e8 ba dc ff ff f7 db <89> 18 83 cb ff 83 c4 08 89 d8 5b c3 e8 81 60 ff ff 05 28 84 07 00
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  CPU: 1 PID: 1 Comm: init Tainted: G        W         5.18.0-rc7-next-20220519 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x57/0x7d
   panic+0x10f/0x28d
   do_exit.cold+0x18/0x48
   do_group_exit+0x2e/0xb0
   get_signal+0xb6d/0xb80
   arch_do_signal_or_restart+0x31/0x760
   ? show_opcodes.cold+0x1c/0x21
   ? force_sig_fault+0x49/0x70
   exit_to_user_mode_prepare+0x131/0x1a0
   irqentry_exit_to_user_mode+0x5/0x30
   asm_exc_page_fault+0x27/0x30
  RIP: 0023:0xf7f5bbc7
  Code: 8a 44 24 10 88 41 ff 8b 44 24 10 83 c4 2c 5b 5e 5f 5d c3 53 83 ec 08 8b 5c 24 10 81 fb 00 f0 ff ff 76 0c e8 ba dc ff ff f7 db <89> 18 83 cb ff 83 c4 08 89 d8 5b c3 e8 81 60 ff ff 05 28 84 07 00
  RSP: 002b:00000000ffa06aa0 EFLAGS: 00000217
  RAX: 00000000f7fd5ca0 RBX: 000000000000000c RCX: 0000000000001000
  RDX: 0000000000000001 RSI: 00000000f7fd5b60 RDI: 00000000f7fd5b60
  RBP: 00000000f7fd1c1c R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

The task's CX register got corrupted by commit 8c42819b61b8 ("x86/entry:
Use PUSH_AND_CLEAR_REGS for compat"), which overlooked the fact that
compat SYSCALL had the user's CX value stored in BP.

Before that commit, CX was saved from its stashed value in BP:

	pushq   %rbp                    /* pt_regs->cx (stashed in bp) */

But then it got changed to:

	pushq	%rcx			/* pt_regs->cx */

resulting in the wrong value getting saved and later restored back to
the user.  Fix it by pushing the correct value again (BP) for regs->cx.

Fixes: 8c42819b61b8 ("x86/entry: Use PUSH_AND_CLEAR_REGS for compat")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/calling.h         | 8 ++++----
 arch/x86/entry/entry_64_compat.S | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a97cc78ecb92..29b36e9e4e74 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,7 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -73,7 +73,7 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
-	pushq   %rcx		/* pt_regs->cx */
+	pushq   \rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
 	pushq   %r9		/* pt_regs->r9 */
@@ -115,8 +115,8 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
+	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret
 	CLEAR_REGS
 .endm
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index ed2be3615b50..f76e674d22c4 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -200,7 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax		/* discard orig_ax high bits */
 	pushq	%rax			/* pt_regs->orig_ax */
-	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
+	PUSH_AND_CLEAR_REGS rcx=%rbp rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
-- 
2.34.3

