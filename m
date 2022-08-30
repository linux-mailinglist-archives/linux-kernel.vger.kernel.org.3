Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468295A71DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiH3Xc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiH3XcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B373927
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q8-20020a170902dac800b001753aa66955so909788plx.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=uOrNiSaejaAx5qzRVyZqVhgDN11YWeACFj1vc5KtsMM=;
        b=YXVYf02f1px4URqdoH8nvqICJVlUXR58i4S4EWdE/hO0LlZchKboqu1WNljPY1heGh
         A3rHjpNxpwcgDEHBC/OUuYajkuVymRwDCfpYvLFoYSPFvj2/YGkYFTgC4H8mvjAZDtVE
         P8WqIcQ2yDCxfwFg2TSMjm4RiLWOk4Sw/aBfpZAjhRBT8sd3Q165e8iwoCCefsDLOxcL
         EhIIwcSHCQZn6Aeo4Vsn1Ko1Sr3KOiRidG62d8LMpPC4dwRZW4Qy1epFU9BE+hxZ6DOW
         B87xr/unhn5oZBF+SBf795Ugzr16QlxHjdJCSpUo0t3+PsfHLFr1gnEyyc7QX2j1CDGN
         TSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=uOrNiSaejaAx5qzRVyZqVhgDN11YWeACFj1vc5KtsMM=;
        b=zbDGcmbvM79VP695cCVT4xj5JiXzVZkVzjYd0fL1Uk26IrmzQk52yVxD9mXeiG8BIv
         +7Jjr96aMeOeyEr6O4YvhBNvcHaz4Ugk109lsRL12P4Z9geXt4RpM79rEWXmzWixPQrX
         LGN7F4fNHLxHnRCPIWwDb1Hgw6N4ruRSJevP1EcjcptmsS3EzTAW8/w174qh2KT8AY3i
         tNIFprRIwAzC3kf5DrLAEJhmEJ2zTXHZ2SdiEbtMGfcT9ZgJ5QGyYjqe3VfVMJGKvD6t
         GLD2T8TZ6CeLDqZ8YZTI9Ljy2vfbsF2qpU4O3or5Mp40Fg3ruMhoyjUgLDm3gQsk32/2
         He9Q==
X-Gm-Message-State: ACgBeo0Ek9CLFvzlKc4fkvODd4A4tPb/vRq4Td8XC6xhQeK8qniO4tHN
        iiGlO8zt5XbYv9Jb998s7UaZRyK0c7UsmcbZ5nRr2e04bob+AhW1NWJkZ/rsR9AvASAvZ/JnAaB
        ltxlPtSK7fkjNxdkpRDtrX5qCtA1v+mX70JeaxPKsv+LlA2QVPIzoojhR08VLDA0EGhg5ItR1hL
        gHtpeRnQ6F/Q==
X-Google-Smtp-Source: AA6agR4y5BrK6d8x+Ox8ZJFf7ghiZkw8sll3zq6f27EjB9bHHyNZxn3pbmX72/UaMjFQ28GlKHsmZfspYrVTkTwGn0s=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:1a14:b0:52d:3e35:5b38 with
 SMTP id g20-20020a056a001a1400b0052d3e355b38mr23603216pfv.11.1661902320611;
 Tue, 30 Aug 2022 16:32:00 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:18 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6529; i=samitolvanen@google.com;
 h=from:subject; bh=nax/A443rh70RgFtHDBePJR2kdPLcGN3ANa3NK4sLi8=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3NK1Z21u8OhRuM2jehM3T+7tCoihG4K4pRyvz7
 OkhRsH6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzQAKCRBMtfaEi7xW7i94C/
 97cAZRVEO58C0yxsqxcjc52SnV0Q3pdCtoAixUtA2bkV68T2uBNfNz5YWatziNJlUDvsL6JgHGx1fo
 9RuZHIvtx3o9OGO6wTG7Vnrm2yRlwBYD1H7GxD9XFn8onBGGA9Wn/u+btijUxyPaDKRqm7kiiZMUBV
 JgtHzTVCp1ORfJxxfbnrzxkN33JefyJwz+V9rnSx4w/Zko0s1CovjwzoWhYYQyx9smbXsW704bRnWE
 j2mI/qzGiHQTarDyRtR+gfjXFPLIFLmxiLLMNPQgZCBuNcmbHMnuN5cPrfEsZ8gOqB9V/uoQmseQev
 nXx6hwxdy4nWzyKYl0ylTpJBC0IbzUUnFQJqsepJS8sVdpmoplvPgX+FeyCbld30TJSm7IDOSwMYPM
 QsjftdSaOo6CRXP2ezJh6Ndzgx+FF9sZoEO0DeWuLVanjx+InxI7QCBiPUJb94OxRsRgYRwhkLL3KE
 9+hIOnieKNzQKrAzNHaNN/jbkXiz7/4y6Mu2RzMMPJrNw=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 10/21] arm64: Add CFI error handling
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
        autolearn=ham autolearn_force=no version=3.4.6
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
2.37.2.672.g94769d06f0-goog

