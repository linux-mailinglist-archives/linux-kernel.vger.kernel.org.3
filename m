Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFD52DFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiESV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbiESV5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:57:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203C6BFC4;
        Thu, 19 May 2022 14:57:25 -0700 (PDT)
Date:   Thu, 19 May 2022 21:57:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652997443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5g6C0kJqWYkvkveA5eDtkjfiIVpH3P3HHQ/nx9I6ew=;
        b=I02byVilJwZUSnuSDim7/UlkvIu7N6v7fDFlQwIZ9Grd9yfpUC4nvi8TzVEBLJhcS7CXNT
        ss3wmo/vexVSpk1IM05AZQJ3EMLg5IrmXdQoQWUJSAnz19GOdXShW6CUCss6Fsvvf7/Mt/
        b9vLeczI3Gtbbb+boLFeqZulAHDk0Kp9qSDIf9wNu2s/27iWNqrzr2Oh4+Cqv+2iUyp9pt
        JThnGBoy9T4OboKGn3I3i+PmwI6zLyNajiFRmjRukdVjtKZmQFOkvcLXqMmGCvgiCY3pX4
        DLzo5FNIVwcZWfEEH112Zmyd49f2ej+gammmZ4ux36Ben79ctzxocv7lP0JOZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652997443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5g6C0kJqWYkvkveA5eDtkjfiIVpH3P3HHQ/nx9I6ew=;
        b=IIOALW+54fYOcsyxFNQ1hSAsWh0ZxvOUEA63WtRudmid5KMz4Yk1PMkDwSFdu2NESMYmGX
        xnfPSJV3Jy5dCZCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Fix register corruption in compat syscall
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b5a26592c9dd60bbacdf97974a7433fd802a5593.1652985970.git.jpoimboe@kernel.org>
References: <b5a26592c9dd60bbacdf97974a7433fd802a5593.1652985970.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165299744274.4207.14977158127943635879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     036c07c0c3b8a57d5c96e1f2aab62da0056f8f21
Gitweb:        https://git.kernel.org/tip/036c07c0c3b8a57d5c96e1f2aab62da0056f8f21
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 19 May 2022 11:46:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:08 +02:00

x86/entry: Fix register corruption in compat syscall

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
compat SYSCALL apparently stores the user's CX value in BP.

Before that commit, CX was saved from its stashed value in BP:

	pushq   %rbp                    /* pt_regs->cx (stashed in bp) */

But then it got changed to:

	pushq	%rcx			/* pt_regs->cx */

So the wrong value got saved and later restored back to the user.  Fix
it by pushing the correct value again (BP) for regs->cx.

Fixes: 8c42819b61b8 ("x86/entry: Use PUSH_AND_CLEAR_REGS for compat")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/b5a26592c9dd60bbacdf97974a7433fd802a5593.1652985970.git.jpoimboe@kernel.org
---
 arch/x86/entry/calling.h         | 8 ++++----
 arch/x86/entry/entry_64_compat.S | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a97cc78..29b36e9 100644
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
index ed2be36..f76e674 100644
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
