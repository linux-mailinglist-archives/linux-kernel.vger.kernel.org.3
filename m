Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912352DD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiESSrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiESSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:47:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBE9D057
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 59926CE26FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591FAC385AA;
        Thu, 19 May 2022 18:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652986044;
        bh=fhw58TxNdXzkrYfdfbkqMnSdc7qK+D7DLSpOMWDBj+0=;
        h=From:To:Cc:Subject:Date:From;
        b=dPRCmITXN+5pHTu52MXgHA//qk8xVhPONUDh9RXwoaIzmeW3LPXnqu5m9uzurXhaO
         P5U6z+8Hp0Ervd2SEtbWAL64LnJn0IzUNQKHeQ5q0jWN0Fka9TjMGOhLtkJE06J4nP
         SdlTc9hqwz0RonMW+u/R2hOysludhYgBzZaG/1gcl3dqo1/S/EWim/ivLo8W/t8/yM
         j4Of3wdX+8MkVlYyb/HM9WHyd+RaG7riiHwMkN/ti5n6OtDo2MDqHUogQ5/ua30uAW
         WPf3KAN0hDePfnGHJkT8+ZJxSInobAeNWODD/+EKfobxy1RafjVKI3Zp0xwIN2S0E4
         qrtuDn5vOykvw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] x86/entry: Fix register corruption in compat syscall
Date:   Thu, 19 May 2022 11:46:58 -0700
Message-Id: <b5a26592c9dd60bbacdf97974a7433fd802a5593.1652985970.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: Guenter Roeck <linux@roeck-us.net>
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

