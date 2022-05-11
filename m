Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895435229E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbiEKCaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF221AAB9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236184; x=1683772184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LZG1l0QEfB5T0caqDjpXl8PdwUwKifRjuJfvSf4teKw=;
  b=kCX14hDK8AVGGuK4SMJ6w2Tmv9OmAOq0qvZh7JrQB3/n0BLRqjl1L72S
   3yzexrNPVfyfiK3BfW063MFG062PUXMH2ZkxtXCLQmnk7p9/qH6C96edy
   mehtPArM75xAcfP8vOFMredUaKaodT8KqZfbd/aa7mM1e1KCTNqUzWyme
   E0uzSJsLoPMmR4915uNZjS3J8gDMh0buizkt+dFdMOr4U9tEDcoMDJmzM
   AvCKK/JpkKcJ33pc8KFnWdE8LM9GjViVhMsYTAncuc1gzhm+M5pe5j0fG
   efDhJiN9c3NNWZKcT+vgAq8oe7ZoQcqz0gY25aefEavTm3JeYbX7ftt40
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="355985771"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="355985771"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="636218430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2022 19:29:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3502357E; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 04/10] x86/mm: Introduce X86_THREAD_LAM_U48 and X86_THREAD_LAM_U57
Date:   Wed, 11 May 2022 05:27:45 +0300
Message-Id: <20220511022751.65540-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Address Masking mode for userspace pointers encoded in CR3 bits.
The mode is selected per-thread. Add new thread features indicate that the
thread has Linear Address Masking enabled.

switch_mm_irqs_off() now respects these flags and constructs CR3
accordingly.

The active LAM mode gets recorded in the tlb_state.

The thread features are not yet exposed via userpsace API.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/tlbflush.h   |  5 ++
 arch/x86/include/uapi/asm/prctl.h |  3 +
 arch/x86/mm/tlb.c                 | 95 ++++++++++++++++++++++++++-----
 3 files changed, 88 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 98fa0a114074..77cae8623858 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -17,6 +17,10 @@ void __flush_tlb_all(void);
 
 #define TLB_FLUSH_ALL	-1UL
 
+#define LAM_NONE	0
+#define LAM_U57		1
+#define LAM_U48		2
+
 void cr4_update_irqsoff(unsigned long set, unsigned long clear);
 unsigned long cr4_read_shadow(void);
 
@@ -88,6 +92,7 @@ struct tlb_state {
 
 	u16 loaded_mm_asid;
 	u16 next_asid;
+	u8 lam;
 
 	/*
 	 * If set we changed the page tables in such a way that we
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 67fc30d36c73..2dd16472d078 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -25,4 +25,7 @@
 #define ARCH_THREAD_FEATURE_DISABLE	0x3003
 #define ARCH_THREAD_FEATURE_LOCK	0x3004
 
+#define X86_THREAD_LAM_U48		0x1
+#define X86_THREAD_LAM_U57		0x2
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6eb4d91d5365..f9fe71d1f42c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -18,6 +18,7 @@
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
+#include <uapi/asm/prctl.h>
 
 #include "mm_internal.h"
 
@@ -154,17 +155,72 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+#ifdef CONFIG_X86_64
+static inline unsigned long lam_to_cr3(u8 lam)
+{
+	switch (lam) {
+	case LAM_NONE:
+		return 0;
+	case LAM_U57:
+		return X86_CR3_LAM_U57;
+	case LAM_U48:
+		return X86_CR3_LAM_U48;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static inline u8 cr3_to_lam(unsigned long cr3)
+{
+	if (cr3 & X86_CR3_LAM_U57)
+		return LAM_U57;
+	if (cr3 & X86_CR3_LAM_U48)
+		return LAM_U48;
+	return 0;
+}
+
+static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
+{
+	if (!tsk)
+		return LAM_NONE;
+
+	if (tsk->thread.features & X86_THREAD_LAM_U57)
+		return LAM_U57;
+	if (tsk->thread.features & X86_THREAD_LAM_U48)
+		return LAM_U48;
+	return LAM_NONE;
+}
+
+#else
+
+static inline unsigned long lam_to_cr3(u8 lam)
+{
+	return 0;
+}
+
+static inline u8 cr3_to_lam(unsigned long cr3)
+{
+	return LAM_NONE;
+}
+
+static u8 gen_lam(struct task_struct *tsk, struct mm_struct *mm)
+{
+	return LAM_NONE;
+}
+#endif
+
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, u8 lam)
 {
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		return __sme_pa(pgd) | kern_pcid(asid);
+		return __sme_pa(pgd) | kern_pcid(asid) | lam_to_cr3(lam);
 	} else {
 		VM_WARN_ON_ONCE(asid != 0);
-		return __sme_pa(pgd);
+		return __sme_pa(pgd) | lam_to_cr3(lam);
 	}
 }
 
-static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid, u8 lam)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 	/*
@@ -173,7 +229,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 	 * boot because all CPU's the have same capabilities:
 	 */
 	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH | lam_to_cr3(lam);
 }
 
 /*
@@ -274,15 +330,15 @@ static inline void invalidate_user_asid(u16 asid)
 		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
 }
 
-static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
+static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, u8 lam, bool need_flush)
 {
 	unsigned long new_mm_cr3;
 
 	if (need_flush) {
 		invalidate_user_asid(new_asid);
-		new_mm_cr3 = build_cr3(pgdir, new_asid);
+		new_mm_cr3 = build_cr3(pgdir, new_asid, lam);
 	} else {
-		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid);
+		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid, lam);
 	}
 
 	/*
@@ -491,6 +547,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	u8 prev_lam = this_cpu_read(cpu_tlbstate.lam);
+	u8 new_lam = gen_lam(tsk, next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
@@ -504,6 +562,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * cpu_tlbstate.loaded_mm) matches next.
 	 *
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
+	 *
+	 * NB: Initial LAM enabling calls us with prev == next. We must update
+	 * CR3 if prev_lam doesn't match the new one.
 	 */
 
 	/* We don't want flush_tlb_func() to run concurrently with us. */
@@ -520,7 +581,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
+	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
 		 * the system so hard that we don't see the call trace.
@@ -551,7 +612,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * provides that full memory barrier and core serializing
 	 * instruction.
 	 */
-	if (real_prev == next) {
+	if (real_prev == next && prev_lam == new_lam) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
@@ -622,15 +683,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
+	this_cpu_write(cpu_tlbstate.lam, new_lam);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
-		load_new_mm_cr3(next->pgd, new_asid, true);
+		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
-		load_new_mm_cr3(next->pgd, new_asid, false);
+		load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
@@ -687,6 +749,7 @@ void initialize_tlbstate_and_flush(void)
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
 	unsigned long cr3 = __read_cr3();
+	u8 lam = cr3_to_lam(cr3);
 
 	/* Assert that CR3 already references the right mm. */
 	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
@@ -700,7 +763,7 @@ void initialize_tlbstate_and_flush(void)
 		!(cr4_read_shadow() & X86_CR4_PCIDE));
 
 	/* Force ASID 0 and force a TLB flush. */
-	write_cr3(build_cr3(mm->pgd, 0));
+	write_cr3(build_cr3(mm->pgd, 0, lam));
 
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
@@ -1074,8 +1137,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  */
 unsigned long __get_current_cr3_fast(void)
 {
-	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	unsigned long cr3 =
+		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+		this_cpu_read(cpu_tlbstate.loaded_mm_asid),
+		this_cpu_read(cpu_tlbstate.lam));
 
 	/* For now, be very restrictive about when this can be called. */
 	VM_WARN_ON(in_nmi() || preemptible());
-- 
2.35.1

