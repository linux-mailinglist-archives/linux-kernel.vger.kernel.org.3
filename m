Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095754D981A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiCOJxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbiCOJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40614F45B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E5860FCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC3C340E8;
        Tue, 15 Mar 2022 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647337940;
        bh=xZp/eXMO91tMhDZjdCKkuGDe3fBZ3awXTZ/mm/is1j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcFk4SbvSawrtUW7/iWlGCUce6DYvW+PJdRjjAR9KXhybVPU2CZPbPLrRoS6KiLGb
         1pru22SndePlGTlrxRA0dgMqoPqHH13CGnLUC/Elc9xG8kSj8a2lIyHi7WLCF8eMvw
         58QrTH65o/Laag+EV2QLbhK1QPleKX8DASy1YYnw4nP2JHRbfLpBAG4iX4sNV5DFS6
         9DcnqU9JnjPrCB3M1u+kcaFWVF0VHRXfuwAeaDckAPnLUE4EB7C7sI8HMCk4Qh7Ceb
         8e279bhuwIMdbdnk5oU9w1kQKyU7c8eU7GXz81ScZTFTEYEjADaE3gHUAHbUFBqxpN
         gRMNrOZLaT10g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] ARM: kprobes: Make __kretprobe_trampoline as a pure asm function
Date:   Tue, 15 Mar 2022 18:52:16 +0900
Message-Id: <164733793626.1008610.12121025094280924953.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
References: <20220315182558.1a056d8b3975932f6589b60f@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __kretprobe_trampoline() as a pure asm function same as the x86
code does. Anyway, it is safe to define the symbol in the asm code
instead of accessing a C symbol from the inline asm.

Without this fix, building arm kernel with GCC-11 may cause below
error.

   /tmp/ccIWiggX.s: Assembler messages:
>> /tmp/ccIWiggX.s:22: Error: invalid literal constant: pool needs to be closer

This fixes the error reported by 0day build bot.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7e9bf33b8124 ("ARM: kprobes: Make a frame pointer on __kretprobe_trampoline")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/core.c |   57 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 4848404ba51b..51f1438456ae 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -373,43 +373,46 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
  * should be enough for stacktrace from the return handler with or
  * without pt_regs.
  */
-void __naked __kprobes __kretprobe_trampoline(void)
-{
-	__asm__ __volatile__ (
+asm(
+	".text\n"
+	".global __kretprobe_trampoline\n"
+	".type __kretprobe_trampoline, %function\n"
+	"__kretprobe_trampoline:\n"
 #ifdef CONFIG_FRAME_POINTER
-		"ldr	lr, =__kretprobe_trampoline	\n\t"
+	"ldr	lr, =__kretprobe_trampoline	\n\t"
 	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
 #ifdef CONFIG_CC_IS_CLANG
-		"stmdb	sp, {sp, lr, pc}	\n\t"
-		"sub	sp, sp, #12		\n\t"
-		/* In clang case, pt_regs->ip = lr. */
-		"stmdb	sp!, {r0 - r11, lr}	\n\t"
-		/* fp points regs->r11 (fp) */
-		"add	fp, sp,	#44		\n\t"
+	"stmdb	sp, {sp, lr, pc}	\n\t"
+	"sub	sp, sp, #12		\n\t"
+	/* In clang case, pt_regs->ip = lr. */
+	"stmdb	sp!, {r0 - r11, lr}	\n\t"
+	/* fp points regs->r11 (fp) */
+	"add	fp, sp,	#44		\n\t"
 #else /* !CONFIG_CC_IS_CLANG */
-		/* In gcc case, pt_regs->ip = fp. */
-		"stmdb	sp, {fp, sp, lr, pc}	\n\t"
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
-		/* fp points regs->r15 (pc) */
-		"add	fp, sp, #60		\n\t"
+	/* In gcc case, pt_regs->ip = fp. */
+	"stmdb	sp, {fp, sp, lr, pc}	\n\t"
+	"sub	sp, sp, #16		\n\t"
+	"stmdb	sp!, {r0 - r11}		\n\t"
+	/* fp points regs->r15 (pc) */
+	"add	fp, sp, #60		\n\t"
 #endif /* CONFIG_CC_IS_CLANG */
 #else /* !CONFIG_FRAME_POINTER */
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
+	"sub	sp, sp, #16		\n\t"
+	"stmdb	sp!, {r0 - r11}		\n\t"
 #endif /* CONFIG_FRAME_POINTER */
-		"mov	r0, sp			\n\t"
-		"bl	trampoline_handler	\n\t"
-		"mov	lr, r0			\n\t"
-		"ldmia	sp!, {r0 - r11}		\n\t"
-		"add	sp, sp, #16		\n\t"
+	"mov	r0, sp			\n\t"
+	"bl	trampoline_handler	\n\t"
+	"mov	lr, r0			\n\t"
+	"ldmia	sp!, {r0 - r11}		\n\t"
+	"add	sp, sp, #16		\n\t"
 #ifdef CONFIG_THUMB2_KERNEL
-		"bx	lr			\n\t"
+	"bx	lr			\n\t"
 #else
-		"mov	pc, lr			\n\t"
+	"mov	pc, lr			\n\t"
 #endif
-		: : : "memory");
-}
+	".size __kretprobe_trampoline, .-__kretprobe_trampoline\n"
+);
+NOKPROBE_SYMBOL(__kretprobe_trampoline);
 
 /* Called from __kretprobe_trampoline */
 static __used __kprobes void *trampoline_handler(struct pt_regs *regs)

