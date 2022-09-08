Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D15B28CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIHV4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiIHVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E81CD502
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 66-20020a251145000000b006a7b4a27d04so12486946ybr.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=xUIiGKSm4wduWg23Tu0syDKyb899Hy/7xlDBrVmam7Q=;
        b=dOoGcHJVg127tDE6kjSdTfMsgzXzcqub02GrdOZQzyIJFfFX3Dzk4sgyyp/QY395Ts
         mH/ZbZXT1NEp8GEcjCJ0n4kO8gontmtFMPoLU+0ecx6tHoic3N1kie9uYmDWndODx3SU
         3AZwI10g4IR/s7QvDVqawVh5EJhOnHtA22/JpSZWqOp0BLWnmZ2hcyBkPPZ+cCmehgX4
         Osh6088+SIG2c6gcj+dfoyABrZWN9/bglT/6kuJvJaqyCcXi8z3+3p8VgAE3KklAr+pG
         uhVhoBXbMtSmCnoSKgM5wmod9uhv45NYDypqOcRWMEnO4cilWfZsMc8mZm5FXsdhwx6b
         9bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xUIiGKSm4wduWg23Tu0syDKyb899Hy/7xlDBrVmam7Q=;
        b=A5P1iEtAfRl6xG4QVWwiYSWrmcSloslpRiJUzIoQoxSay7Zk5+ECujmZjoI5+eLIas
         naQeCfCcfL8sdrWJMG8Tlc1Fb5297CsXAUjAASrvMFpP/haQdxQX88uDXnQ40R42Ft0h
         yJBTVjOjux7lbiBgeQI6656mDJil2WNiLqxsOJ1bOEVSEOqW9yHW8O3Tu9SZR9jp6v8k
         fTOWO8al2y4HtLnz/enX38/Q7pS9eG9Ml7jgzsRWEjdOjgRjFO8RkqDsHQ97YvfvrrdK
         TFt/+O1PFLBxY4W4juZJoe//1BjIiAWjIwWaEKo1Q6Ebd95NWoxc0XGPXI6Wm8yOi9pD
         c4bQ==
X-Gm-Message-State: ACgBeo1r9ghWgeDDQ4AiL9lXIIxIhg+q1wUzKU0Kx3CR5Y6tccylHd+m
        Hbs6mk47pk0+2ynFdB3PHaOFpsDfOBpH0iNlDWhBErO/CkpPqHojxXmbiONrtbdTYVTO99kPMRA
        ezDdzg9/v3YJJ9VkRSusCfhnSOKSS+ze1XuqJg44stf/shn6dKG0qr/njPtRRoVHCYicEw5Y7uQ
        e/oPuGx3latw==
X-Google-Smtp-Source: AA6agR4vUDRVfqHUaReM1w5Kq0C6YAR1yqQtsuNTjhE1wQty1NhZxF2XtFK0o05oiiyebsiqQoGqIYzwRprCNlYaocM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:d34e:0:b0:336:7428:dac8 with SMTP
 id d14-20020a81d34e000000b003367428dac8mr9601628ywl.94.1662674133445; Thu, 08
 Sep 2022 14:55:33 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:52 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6625; i=samitolvanen@google.com;
 h=from:subject; bh=XyaKOjBIyR6ipHRlO473Yg9X007Ywd+Fmw0kdF0HI3M=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS0ASWNwETssmwBh5NxM4y8wY0XXHT/43rDPqGd
 8Ukdeo6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktAAKCRBMtfaEi7xW7h4pC/
 0XqDoxj/PKBgq5swD0AxtBotx8Kc1w3kQb7O2RPMJWTse4Kd+PGOqS54jAH3LbS/aZXl4YLukAegj6
 vXqR3JMXIuef7nEWUkymKAIrsDNh2wxSo5iRfZdY7SLEfI2rR+1v28+edSWtvBRt8zHcmHOiWCvgjD
 ZKb9PHcvS04XX+G6PRpF821r8QrB5+hlbqf9MePw/OVFXNkZH05uYmHgRfBayF1jRipnLLori2U5qK
 Vlj0E7flyBe+KTeNYKj/bd6IXuvJrcWOyhskDGWe2dDiIcnBNOiR1ZRR0+kupspuOV88ozhqFjJejL
 Z95DGowPaFcWRNNlAk05INALkgtm2mOd8uGAvbAUHPcQeHm+XanKcO5gTPA3Dne1iZIklgdy6o3kgN
 CCJ/VoAOFZg/sO4xjUbgw9deevs6TllbQDFPY1RE/GzQP4iNnc7YgsSUFHaA+Ewc6yi8UeGdMNUOcN
 PkRjMCV/BthVjYiD+Yj1S9oIndBZoJeS/ETK6in0OfP3I=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 10/22] arm64: Add CFI error handling
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling CFI
failures. The registers containing the target address and the expected type
are encoded in the first ten bits of the ESR as follows:

 - 0-4: n, where the register Xn contains the target address
 - 5-9: m, where the register Wm contains the type hash

This produces the following oops on CFI failure (generated using lkdtm):

[   21.885179] CFI failure at lkdtm_indirect_call+0x2c/0x44 [lkdtm]
(target: lkdtm_increment_int+0x0/0x1c [lkdtm]; expected type: 0x7e0c52a)
[   21.886593] Internal error: Oops - CFI: 0 [#1] PREEMPT SMP
[   21.891060] Modules linked in: lkdtm
[   21.893363] CPU: 0 PID: 151 Comm: sh Not tainted
5.19.0-rc1-00021-g852f4e48dbab #1
[   21.895560] Hardware name: linux,dummy-virt (DT)
[   21.896543] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   21.897583] pc : lkdtm_indirect_call+0x2c/0x44 [lkdtm]
[   21.898551] lr : lkdtm_CFI_FORWARD_PROTO+0x3c/0x6c [lkdtm]
[   21.899520] sp : ffff8000083a3c50
[   21.900191] x29: ffff8000083a3c50 x28: ffff0000027e0ec0 x27: 0000000000000000
[   21.902453] x26: 0000000000000000 x25: ffffc2aa3d07e7b0 x24: 0000000000000002
[   21.903736] x23: ffffc2aa3d079088 x22: ffffc2aa3d07e7b0 x21: ffff000003379000
[   21.905062] x20: ffff8000083a3dc0 x19: 0000000000000012 x18: 0000000000000000
[   21.906371] x17: 000000007e0c52a5 x16: 000000003ad55aca x15: ffffc2aa60d92138
[   21.907662] x14: ffffffffffffffff x13: 2e2e2e2065707974 x12: 0000000000000018
[   21.909775] x11: ffffc2aa62322b88 x10: ffffc2aa62322aa0 x9 : c7e305fb5195d200
[   21.911898] x8 : ffffc2aa3d077e20 x7 : 6d20676e696c6c61 x6 : 43203a6d74646b6c
[   21.913108] x5 : ffffc2aa6266c9df x4 : ffffc2aa6266c9e1 x3 : ffff8000083a3968
[   21.914358] x2 : 80000000fffff122 x1 : 00000000fffff122 x0 : ffffc2aa3d07e8f8
[   21.915827] Call trace:
[   21.916375]  lkdtm_indirect_call+0x2c/0x44 [lkdtm]
[   21.918060]  lkdtm_CFI_FORWARD_PROTO+0x3c/0x6c [lkdtm]
[   21.919030]  lkdtm_do_action+0x34/0x4c [lkdtm]
[   21.919920]  direct_entry+0x170/0x1ac [lkdtm]
[   21.920772]  full_proxy_write+0x84/0x104
[   21.921759]  vfs_write+0x188/0x3d8
[   21.922387]  ksys_write+0x78/0xe8
[   21.922986]  __arm64_sys_write+0x1c/0x2c
[   21.923696]  invoke_syscall+0x58/0x134
[   21.924554]  el0_svc_common+0xb4/0xf4
[   21.925603]  do_el0_svc+0x2c/0xb4
[   21.926563]  el0_svc+0x2c/0x7c
[   21.927147]  el0t_64_sync_handler+0x84/0xf0
[   21.927985]  el0t_64_sync+0x18c/0x190
[   21.929133] Code: 728a54b1 72afc191 6b11021f 54000040 (d4304500)
[   21.930690] ---[ end trace 0000000000000000 ]---
[   21.930971] Kernel panic - not syncing: Oops - CFI: Fatal exception

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/include/asm/brk-imm.h |  6 ++++
 arch/arm64/kernel/traps.c        | 47 ++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
index ec7720dbe2c8..6e000113e508 100644
--- a/arch/arm64/include/asm/brk-imm.h
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -17,6 +17,7 @@
  * 0x401: for compile time BRK instruction
  * 0x800: kernel-mode BUG() and WARN() traps
  * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
+ * 0x8xxx: Control-Flow Integrity traps
  */
 #define KPROBES_BRK_IMM			0x004
 #define UPROBES_BRK_IMM			0x005
@@ -28,4 +29,9 @@
 #define KASAN_BRK_IMM			0x900
 #define KASAN_BRK_MASK			0x0ff
 
+#define CFI_BRK_IMM_TARGET		GENMASK(4, 0)
+#define CFI_BRK_IMM_TYPE		GENMASK(9, 5)
+#define CFI_BRK_IMM_BASE		0x8000
+#define CFI_BRK_IMM_MASK		(CFI_BRK_IMM_TARGET | CFI_BRK_IMM_TYPE)
+
 #endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b7fed33981f7..3c026da95bbc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/mm_types.h>
 #include <linux/kasan.h>
+#include <linux/cfi.h>
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
@@ -991,6 +992,38 @@ static struct break_hook bug_break_hook = {
 	.imm = BUG_BRK_IMM,
 };
 
+#ifdef CONFIG_CFI_CLANG
+static int cfi_handler(struct pt_regs *regs, unsigned long esr)
+{
+	unsigned long target;
+	u32 type;
+
+	target = pt_regs_read_reg(regs, FIELD_GET(CFI_BRK_IMM_TARGET, esr));
+	type = (u32)pt_regs_read_reg(regs, FIELD_GET(CFI_BRK_IMM_TYPE, esr));
+
+	switch (report_cfi_failure(regs, regs->pc, &target, type)) {
+	case BUG_TRAP_TYPE_BUG:
+		die("Oops - CFI", regs, 0);
+		break;
+
+	case BUG_TRAP_TYPE_WARN:
+		break;
+
+	default:
+		return DBG_HOOK_ERROR;
+	}
+
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+	return DBG_HOOK_HANDLED;
+}
+
+static struct break_hook cfi_break_hook = {
+	.fn = cfi_handler,
+	.imm = CFI_BRK_IMM_BASE,
+	.mask = CFI_BRK_IMM_MASK,
+};
+#endif /* CONFIG_CFI_CLANG */
+
 static int reserved_fault_handler(struct pt_regs *regs, unsigned long esr)
 {
 	pr_err("%s generated an invalid instruction at %pS!\n",
@@ -1052,6 +1085,9 @@ static struct break_hook kasan_break_hook = {
 };
 #endif
 
+
+#define esr_comment(esr) ((esr) & ESR_ELx_BRK64_ISS_COMMENT_MASK)
+
 /*
  * Initial handler for AArch64 BRK exceptions
  * This handler only used until debug_traps_init().
@@ -1059,10 +1095,12 @@ static struct break_hook kasan_break_hook = {
 int __init early_brk64(unsigned long addr, unsigned long esr,
 		struct pt_regs *regs)
 {
+#ifdef CONFIG_CFI_CLANG
+	if ((esr_comment(esr) & ~CFI_BRK_IMM_MASK) == CFI_BRK_IMM_BASE)
+		return cfi_handler(regs, esr) != DBG_HOOK_HANDLED;
+#endif
 #ifdef CONFIG_KASAN_SW_TAGS
-	unsigned long comment = esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
-
-	if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
+	if ((esr_comment(esr) & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
 		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
@@ -1071,6 +1109,9 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
 void __init trap_init(void)
 {
 	register_kernel_break_hook(&bug_break_hook);
+#ifdef CONFIG_CFI_CLANG
+	register_kernel_break_hook(&cfi_break_hook);
+#endif
 	register_kernel_break_hook(&fault_break_hook);
 #ifdef CONFIG_KASAN_SW_TAGS
 	register_kernel_break_hook(&kasan_break_hook);
-- 
2.37.2.789.g6183377224-goog

