Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6591E58B13C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiHEVr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiHEVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:47:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777E76450
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:47:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so3045028ybp.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=9o89AIwG1Rtq3NAnxf9mvbLACj1uWynz/alMKnAPw28=;
        b=MdAQQWQpsb02jAC9Q2QxyWXAEdZnaaEy5dED5xnZts6reNg/96hyKxKFutAuLZfPNN
         lr3yjw86dS4HByd+lriA+cONWfPI0FoAuzmDzP2kzaYOnjbYI8ht1TCTntaUl1En4Q6F
         eAQPLk2bMIX6f1LjSFljLbN6/f/1qKHWC1pxrNgfj4Jkj+EJTLKr0UxR9KQbztb6Mk0p
         rdIaB3nfSLUZKYgbgqqhXe9s+y2+D2wXtOZO/+PC8EflVUpVvaIXIW6uchhtAqwPerp7
         ZzMPjrvG1mIb/q0qzmd3qo3D9DvflEsZHCyd4s9qCSeqJFc+vCh5DyghAIIPsTqfAu3m
         5ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=9o89AIwG1Rtq3NAnxf9mvbLACj1uWynz/alMKnAPw28=;
        b=zoZRQI/5A9ZCcT+VS0tXJ1ES5MBndyu5KXkpHDPjBT3vjIwVke1upb5xj4SBvv7Sd1
         gwIwzBgFtksW1NP0vhVvU9VqGKNsJBQpKthBccSmtSMtwIF3fJ12wVv1Aa40OZWWQRMs
         rLClUeiSc5ifrWcwT8nr4kMlVqA7+irICVS2+n3zguFI4kmvzeJhXSPpVWQ0oCGs2KPB
         hrVSMYVamDnHowceosvAePZQtfxtAb1avR5b0cp5LjsOot7kcPBsCmaM7+AG8vCAwa5p
         cDKbb65n7QejgKgU3MrrRKvNr8ltUQ9pc2VERgwWcIXsGqPVPDzCvzQh+EIR8X3Y8DjJ
         mYlQ==
X-Gm-Message-State: ACgBeo3SMLrdCQtGF4RFww+54N6CXBCjTUZk93Y2D36gxDPm4HP/Sgrx
        jllKLiwaUcsquOlB2VXexznzIGrdKlCd
X-Google-Smtp-Source: AA6agR7oG0oHgRddt7/gnaZnbKGIOYC9YExihIF83/MmfiNVpovlUdVynfeeC5xNAIRdkZkdv257fWtmUf1l
X-Received: from eugenis.svl.corp.google.com ([2620:15c:2ce:200:c013:ee36:4bd2:15f])
 (user=eugenis job=sendgmr) by 2002:a25:e757:0:b0:67b:b016:6184 with SMTP id
 e84-20020a25e757000000b0067bb0166184mr799612ybh.497.1659736072468; Fri, 05
 Aug 2022 14:47:52 -0700 (PDT)
Date:   Fri,  5 Aug 2022 14:47:34 -0700
Message-Id: <20220805214734.1937451-1-eugenis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH] mte: Follow arm64.nomte override in MMU setup.
From:   Evgenii Stepanov <eugenis@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Evgenii Stepanov <eugenis@google.com>
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

The current code sets up the memory attribute for Normal Tagged memory
in MAIR_EL1 whenever MTE is supported according to AA64PFR1.MTE without
taking arm64.nomte command line option into account.

This breaks when tag pages are reused as regular memory, as direct
access to such pages through the linear map may create an invalid DRAM
address (tags-of-tags).

This change delays MTE MAIR_EL1 setup until feature overrides can be
processed.

Signed-off-by: Evgenii Stepanov <eugenis@google.com>
---
 arch/arm64/include/asm/mte.h      |  5 +++++
 arch/arm64/include/asm/proc-fns.h |  4 ++++
 arch/arm64/kernel/mte.c           | 22 ++++++++++++++++++++++
 arch/arm64/kernel/smp.c           |  3 +++
 arch/arm64/mm/mmu.c               |  3 +++
 arch/arm64/mm/proc.S              | 28 +++++++++++++++++++---------
 6 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index aa523591a44e5..bcabafe010d8c 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -48,6 +48,7 @@ long get_mte_ctrl(struct task_struct *task);
 int mte_ptrace_copy_tags(struct task_struct *child, long request,
 			 unsigned long addr, unsigned long data);
 size_t mte_probe_user_range(const char __user *uaddr, size_t size);
+void mte_update_mair(void);
 
 #else /* CONFIG_ARM64_MTE */
 
@@ -87,6 +88,10 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 	return -EIO;
 }
 
+static inline void mte_update_mair(void)
+{
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 static inline void mte_disable_tco_entry(struct task_struct *task)
diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 0d5d1f0525eb3..34d9c25960343 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -19,6 +19,10 @@ extern void cpu_do_idle(void);
 extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
 extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
+#ifdef CONFIG_ARM64_MTE
+extern void cpu_mte_update_mair(void);
+#endif
+
 #include <asm/memory.h>
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index b2b730233274b..4882c259febb4 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
+#include <asm/proc-fns.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
@@ -574,3 +575,24 @@ size_t mte_probe_user_range(const char __user *uaddr, size_t size)
 
 	return 0;
 }
+
+/*
+ * Open coded check for MTE before CPU features are set up.
+ */
+static bool arm64_early_this_cpu_has_mte(void)
+{
+	u64 pfr1;
+
+	if (!IS_ENABLED(CONFIG_ARM64_MTE))
+		return false;
+
+	pfr1 = __read_sysreg_by_encoding(SYS_ID_AA64PFR1_EL1);
+	return cpuid_feature_extract_unsigned_field(pfr1,
+						    ID_AA64PFR1_MTE_SHIFT);
+}
+
+void mte_update_mair(void)
+{
+	if (arm64_early_this_cpu_has_mte())
+		cpu_mte_update_mair();
+}
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 62ed361a4376b..6725f978d6e50 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -43,6 +43,7 @@
 #include <asm/daifflags.h>
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
+#include <asm/mte.h>
 #include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/smp_plat.h>
@@ -226,6 +227,8 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	check_local_cpu_capabilities();
 
+	mte_update_mair();
+
 	ops = get_cpu_ops(cpu);
 	if (ops->cpu_postboot)
 		ops->cpu_postboot();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index db7c4e6ae57bb..37835686369ea 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -35,6 +35,7 @@
 #include <linux/sizes.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
+#include <asm/mte.h>
 #include <asm/ptdump.h>
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
@@ -812,6 +813,8 @@ void __init paging_init(void)
 
 	idmap_t0sz = 63UL - __fls(__pa_symbol(_end) | GENMASK(VA_BITS_MIN - 1, 0));
 
+	mte_update_mair();
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 7837a69524c53..dc740db298dea 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -393,6 +393,22 @@ SYM_FUNC_END(idmap_kpti_install_ng_mappings)
 	.popsection
 #endif
 
+#ifdef CONFIG_ARM64_MTE
+/*
+ * 	cpu_mte_update_mair
+ *
+ * 	Setup Normal Tagged memory type at the corresponding MAIR index
+ */
+SYM_FUNC_START(cpu_mte_update_mair)
+	mov_q	x9, MAIR_EL1_SET
+	mov	x10, #MAIR_ATTR_NORMAL_TAGGED
+	bfi	x9, x10, #(8 *  MT_NORMAL_TAGGED), #8
+	msr	mair_el1, x9
+	tlbi	vmalle1				// Invalidate local TLB
+	dsb	nsh
+	ret
+SYM_FUNC_END(cpu_mte_update_mair)
+#endif
 /*
  *	__cpu_setup
  *
@@ -421,16 +437,14 @@ SYM_FUNC_START(__cpu_setup)
 	 * Default values for VMSA control registers. These will be adjusted
 	 * below depending on detected CPU features.
 	 */
-	mair	.req	x17
 	tcr	.req	x16
-	mov_q	mair, MAIR_EL1_SET
 	mov_q	tcr, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
 
 #ifdef CONFIG_ARM64_MTE
 	/*
-	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
+	 * Update GCR_EL1 and TFSR*_EL1 if MTE is supported
 	 * (ID_AA64PFR1_EL1[11:8] > 1).
 	 */
 	mrs	x10, ID_AA64PFR1_EL1
@@ -438,10 +452,6 @@ SYM_FUNC_START(__cpu_setup)
 	cmp	x10, #ID_AA64PFR1_MTE
 	b.lt	1f
 
-	/* Normal Tagged memory type at the corresponding MAIR index */
-	mov	x10, #MAIR_ATTR_NORMAL_TAGGED
-	bfi	mair, x10, #(8 *  MT_NORMAL_TAGGED), #8
-
 	mov	x10, #KERNEL_GCR_EL1
 	msr_s	SYS_GCR_EL1, x10
 
@@ -493,7 +503,8 @@ SYM_FUNC_START(__cpu_setup)
 	orr	tcr, tcr, #TCR_HA		// hardware Access flag update
 1:
 #endif	/* CONFIG_ARM64_HW_AFDBM */
-	msr	mair_el1, mair
+	mov_q	x9, MAIR_EL1_SET
+	msr	mair_el1, x9
 	msr	tcr_el1, tcr
 	/*
 	 * Prepare SCTLR
@@ -501,6 +512,5 @@ SYM_FUNC_START(__cpu_setup)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_ON
 	ret					// return to head.S
 
-	.unreq	mair
 	.unreq	tcr
 SYM_FUNC_END(__cpu_setup)
-- 
2.37.1.559.g78731f0fdb-goog

