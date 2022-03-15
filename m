Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B64D9952
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiCOKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347298AbiCOKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858F34B89;
        Tue, 15 Mar 2022 03:43:58 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AESOGUl5behUc4E+X66bv+zbJxndpsxvDwtbt9GxUtk=;
        b=1KHQ7O6TjxC+o+ngACdS8ML8bVoK+AjL2Lhsm8BHttdTGuynjup9mt+dV2MVoztY1UsnT1
        +VP8xXF8Xif452v1hggf0yQelS8vG/xYELO+qy3neV9XQ7Yq4gTM+N1NnG7KLgFiIOPOe3
        I3adu0vjBsXgxS/CaqPsswcKf8scT5k+AiA1apR1mfH3ptJU7yYELCSzoUIkHVwE3yCjRO
        taUGLxDSaQuu16r9opQ6OVn4tdbGaOwQf9y+i8VLU+ACMpvWPvMLs4OBPnIhw4sqclyUU7
        x8iNsXS0k7eG+0krZWdBXSHWqLlWwTdl4LF5nKnuVIoeTZ8zKhgARnwofRB/zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AESOGUl5behUc4E+X66bv+zbJxndpsxvDwtbt9GxUtk=;
        b=LxhHHFc4tvUKFMcXNpF/aSo1cAzF0Gj152UUsSrOFg2KqogLGanRB+OnY0QbUSJ/3oJAYG
        DN04jIqudKZ0DeDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Disable IBT around firmware
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.759989383@infradead.org>
References: <20220308154318.759989383@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103596.16921.3686146131158647702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fe379fa4d199abc52d5b4a256e52cf94eff685cf
Gitweb:        https://git.kernel.org/tip/fe379fa4d199abc52d5b4a256e52cf94eff685cf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:40 +01:00

x86/ibt: Disable IBT around firmware

Assume firmware isn't IBT clean and disable it across calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.759989383@infradead.org
---
 arch/x86/include/asm/efi.h   |  9 +++++++--
 arch/x86/include/asm/ibt.h   |  6 ++++++
 arch/x86/kernel/apm_32.c     |  7 +++++++
 arch/x86/kernel/cpu/common.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 03cb127..98938a6 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -7,6 +7,7 @@
 #include <asm/tlb.h>
 #include <asm/nospec-branch.h>
 #include <asm/mmu_context.h>
+#include <asm/ibt.h>
 #include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <linux/pgtable.h>
@@ -120,8 +121,12 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 	efi_enter_mm();							\
 })
 
-#define arch_efi_call_virt(p, f, args...)				\
-	efi_call((void *)p->f, args)					\
+#define arch_efi_call_virt(p, f, args...) ({				\
+	u64 ret, ibt = ibt_save();					\
+	ret = efi_call((void *)p->f, args);				\
+	ibt_restore(ibt);						\
+	ret;								\
+})
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index fcaf6a4..52fb05d 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -52,6 +52,9 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
+extern __noendbr u64 ibt_save(void);
+extern __noendbr void ibt_restore(u64 save);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef CONFIG_X86_64
@@ -74,6 +77,9 @@ static inline bool is_endbr(u32 val)
 
 static inline bool is_endbr(u32 val) { return false; }
 
+static inline u64 ibt_save(void) { return 0; }
+static inline void ibt_restore(u64 save) { }
+
 #else /* __ASSEMBLY__ */
 
 #define ENDBR
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 241dda6..60e330c 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -232,6 +232,7 @@
 #include <asm/paravirt.h>
 #include <asm/reboot.h>
 #include <asm/nospec-branch.h>
+#include <asm/ibt.h>
 
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 extern int (*console_blank_hook)(int);
@@ -598,6 +599,7 @@ static long __apm_bios_call(void *_call)
 	struct desc_struct	save_desc_40;
 	struct desc_struct	*gdt;
 	struct apm_bios_call	*call = _call;
+	u64			ibt;
 
 	cpu = get_cpu();
 	BUG_ON(cpu != 0);
@@ -607,11 +609,13 @@ static long __apm_bios_call(void *_call)
 
 	apm_irq_save(flags);
 	firmware_restrict_branch_speculation_start();
+	ibt = ibt_save();
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(call->func, call->ebx, call->ecx,
 			  &call->eax, &call->ebx, &call->ecx, &call->edx,
 			  &call->esi);
 	APM_DO_RESTORE_SEGS;
+	ibt_restore(ibt);
 	firmware_restrict_branch_speculation_end();
 	apm_irq_restore(flags);
 	gdt[0x40 / 8] = save_desc_40;
@@ -676,6 +680,7 @@ static long __apm_bios_call_simple(void *_call)
 	struct desc_struct	save_desc_40;
 	struct desc_struct	*gdt;
 	struct apm_bios_call	*call = _call;
+	u64			ibt;
 
 	cpu = get_cpu();
 	BUG_ON(cpu != 0);
@@ -685,10 +690,12 @@ static long __apm_bios_call_simple(void *_call)
 
 	apm_irq_save(flags);
 	firmware_restrict_branch_speculation_start();
+	ibt = ibt_save();
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(call->func, call->ebx, call->ecx,
 					 &call->eax);
 	APM_DO_RESTORE_SEGS;
+	ibt_restore(ibt);
 	firmware_restrict_branch_speculation_end();
 	apm_irq_restore(flags);
 	gdt[0x40 / 8] = save_desc_40;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 709acab..03bd73f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -517,6 +517,34 @@ static __init int setup_disable_pku(char *arg)
 __setup("nopku", setup_disable_pku);
 #endif /* CONFIG_X86_64 */
 
+#ifdef CONFIG_X86_KERNEL_IBT
+
+__noendbr u64 ibt_save(void)
+{
+	u64 msr = 0;
+
+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
+		rdmsrl(MSR_IA32_S_CET, msr);
+		wrmsrl(MSR_IA32_S_CET, msr & ~CET_ENDBR_EN);
+	}
+
+	return msr;
+}
+
+__noendbr void ibt_restore(u64 save)
+{
+	u64 msr;
+
+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
+		rdmsrl(MSR_IA32_S_CET, msr);
+		msr &= ~CET_ENDBR_EN;
+		msr |= (save & CET_ENDBR_EN);
+		wrmsrl(MSR_IA32_S_CET, msr);
+	}
+}
+
+#endif
+
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
 	u64 msr = CET_ENDBR_EN;
