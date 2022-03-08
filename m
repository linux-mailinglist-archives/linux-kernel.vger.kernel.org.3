Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2AC4D1C85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348267AbiCHP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348057AbiCHP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279314F475
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CIC+Y05arRCYjSRCXvWDJgsUk8zd5Bf8WQ+BVSXreEs=; b=Qne0sFRNMe+XN2WTXmfVhYdbZ0
        Mp8f3gZbqsTMAyoQ6Vpd/+p0Kd7FjKKPss9oBAfw4vn49qjkk5F9r2a9ype4Uu8BAzTtMt/Tnmnmn
        F0TBqZ8fDEBrvZVxkleGdVpEtfBaJXT6fM75dZO+5H62jIAGXCpLEcst4+1AcA/AAPKhxRTr32455
        KaGeQRkVS0tktERndw9zHbMNs9FlJWQ75euVPJ1CUYuy5q19UibIdGvCmRsoNXmGPtcqQVrfy7p0D
        VmuG1lhzBlvzdyEcudfbokfcZ3tZSgH+vztXD3FPxQ3/HKtUT+HEBpWwN9ryPgX8rCKIq+oHMWgM+
        ZRvikpUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GIvE-Q8; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 437EC302D4A;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69D9B2B561930; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.641454603@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 25/45] x86/ibt,kexec: Disable CET on kexec
References: <20220308153011.021123062@infradead.org>
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cpu.h           |    3 +++
 arch/x86/kernel/cpu/common.c         |    6 ++++++
 arch/x86/kernel/machine_kexec_64.c   |    4 +++-
 arch/x86/kernel/relocate_kernel_64.S |    8 ++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -73,4 +73,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x
 #else
 static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 #endif
+
+extern __noendbr void cet_disable(void);
+
 #endif /* _ASM_X86_CPU_H */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -612,6 +612,12 @@ static __always_inline void setup_cet(st
 	}
 }
 
+__noendbr void cet_disable(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_IBT))
+		wrmsrl(MSR_IA32_S_CET, 0);
+}
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -27,6 +27,7 @@
 #include <asm/kexec-bzimage64.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -310,6 +311,7 @@ void machine_kexec(struct kimage *image)
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 	hw_breakpoint_disable();
+	cet_disable();
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
@@ -325,7 +327,7 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
-	memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -115,6 +115,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 	pushq   %rdx
 
 	/*
+	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
+	 * below.
+	 */
+	movq	%cr4, %rax
+	andq	$~(X86_CR4_CET), %rax
+	movq	%rax, %cr4
+
+	/*
 	 * Set cr0 to a known state:
 	 *  - Paging enabled
 	 *  - Alignment check disabled


