Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68174BBE18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiBRRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbiBRRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2784C7B9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=y1BqAPopW4amCojJ1jHN1wrCsivM9+TaKLpxGKtH/GM=; b=KKUyyjWyUvOV7Ek39FI/+dLZNo
        eyZ/yITL8LPIvZxdZPJIq++byqeWX87lvihLv0Nf9kshC8CAXpXiuUDf+vGt7Rm4wEO4A0tmWUACZ
        jBE4RxEAtB1ica0q97T93r66dGpPpgIkO8VlwKocFKPkW30OzgJB9844fvNXVm+UJrbLd/2vEUm+e
        Rvb+bX5ABBqleM+ylkMlgqm7/JdmNHvkoU/iGnBcQaOdtgmvl6DxkHjjEKrRjYi9UzjSP4NO/DAPW
        zva72nkgncY8ozKo/FhmNhIUVinDa0n/lB+7OLkeFlQw4h11kBLNLquYE667XbrSFIZjO3dbyXItz
        e+Q6+Otg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00Gl8i-Gr; Fri, 18 Feb 2022 17:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C940630144C;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 40F6D2096F3D9; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.456054276@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 15/29] x86: Disable IBT around firmware
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume firmware isn't IBT clean and disable it across calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/efi.h   |    9 +++++++--
 arch/x86/include/asm/ibt.h   |   10 ++++++++++
 arch/x86/kernel/apm_32.c     |    7 +++++++
 arch/x86/kernel/cpu/common.c |   28 ++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

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
@@ -120,8 +121,12 @@ extern asmlinkage u64 __efi_call(void *f
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
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -6,6 +6,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 #ifdef CONFIG_X86_64
 #define ASM_ENDBR	"endbr64\n\t"
 #else
@@ -25,6 +27,9 @@ static inline bool is_endbr(const void *
 	return val == ~0xfa1e0ff3;
 }
 
+extern u64 ibt_save(void);
+extern void ibt_restore(u64 save);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef CONFIG_X86_64
@@ -39,10 +44,15 @@ static inline bool is_endbr(const void *
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 #define ASM_ENDBR
 
 #define __noendbr
 
+static inline u64 ibt_save(void) { return 0; }
+static inline void ibt_restore(u64 save) { }
+
 #else /* __ASSEMBLY__ */
 
 #define ENDBR
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
@@ -676,6 +680,7 @@ static long __apm_bios_call_simple(void
 	struct desc_struct	save_desc_40;
 	struct desc_struct	*gdt;
 	struct apm_bios_call	*call = _call;
+	u64			ibt;
 
 	cpu = get_cpu();
 	BUG_ON(cpu != 0);
@@ -685,10 +690,12 @@ static long __apm_bios_call_simple(void
 
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -592,6 +592,34 @@ static __init int setup_disable_pku(char
 __setup("nopku", setup_disable_pku);
 #endif /* CONFIG_X86_64 */
 
+#ifdef CONFIG_X86_IBT
+
+u64 ibt_save(void)
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
+void ibt_restore(u64 save)
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
 	u64 msr;


