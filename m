Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7644CBCAF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiCCLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6803D17CC46
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=41LwMtvOLrmCCpEeK45Bz2QrPFsLhIO0Z4y1ZqPj0RU=; b=u4r7OEYkkwKYBV97kICizEAx+w
        R5764ZVq9GofrhWujZ0oimFzgLd6nM8+YCekhKryN3zZYjiqq2rjUDjcZz5VC5Mko1mqzMqgQcQrk
        CwPfSzB3dXv/Ex2mSLtri6/n/I1e7mrBiGdQJM6ZJyXJhsk3eKr1ti9ofH4VjOEE58WcJJNd6Lnn2
        1AJeKclMzdQ5F+Tty9b1GuBUm16UCftGdj103aK+lofvR1OFpB8Jor+WjXiDtmUnpXDtZUlXUV3fg
        t+T/w/gwhGnNzgb2IxMkpmK+10FPFntYnJ2EiSvlgeVzJpFyCxtk5ONnIXdBA8HBMfE3n/f0usnKH
        1eMrgNXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00BaH4-9r; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08F22302D39;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 76DB230126659; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.421945580@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 24/39] x86/ibt: Disable IBT around firmware
References: <20220303112321.422525803@infradead.org>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/efi.h   |    9 +++++++--
 arch/x86/include/asm/ibt.h   |    6 ++++++
 arch/x86/kernel/apm_32.c     |    7 +++++++
 arch/x86/kernel/cpu/common.c |   28 ++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

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
@@ -39,6 +39,9 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
+extern __noendbr u64 ibt_save(void);
+extern __noendbr void ibt_restore(u64 save);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef CONFIG_X86_64
@@ -61,6 +64,9 @@ static inline bool is_endbr(u32 val)
 
 static inline bool is_endbr(u32 val) { return false; }
 
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
@@ -594,6 +594,34 @@ static __init int setup_disable_pku(char
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


