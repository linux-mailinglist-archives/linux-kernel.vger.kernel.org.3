Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3C54686B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiFJOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiFJOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:35:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD419C38
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654871731; x=1686407731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M7J+S+8vKN7ZN6sRTgB+WMuENPjFvOnnpOT0nqPfDhU=;
  b=lhpPw0Om2q9u/wU1SJgH3gF5apa14t9Hz8hUjyT0+LZVKirrfVfDmIEj
   L7TFIki3w7305/2bVpJ0V2FhEvNtykI0mH3Kz7/370/1M2R1R+2nwHcfw
   UbdaIpdASVEp1lmzhlgCq7f4C1OzHzX87AfMxHecHzPggcyJIozPdKv0n
   I8/Ncb6XOZ7tVHjWiFP+ya774+IFT6bXNwOJJZgbH8fMCz3Mi7YuZ1zIX
   8/XgrncZgqE0c8NprP4BasFqGVKHYCBn0mfjh6m79GWo+sCh7RcjiN45D
   AmNi0p1MJWVSlEzj9rr6GXKk5lt8reC7OLr+jhc24PIs5h0C/2W8EMYzz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="341706100"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="341706100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 07:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="710959729"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2022 07:35:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 41F83506; Fri, 10 Jun 2022 17:35:30 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Date:   Fri, 10 Jun 2022 17:35:23 +0300
Message-Id: <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h         |  1 +
 arch/x86/include/asm/mmu_context.h | 24 ++++++++++++
 arch/x86/include/asm/tlbflush.h    |  3 ++
 arch/x86/mm/tlb.c                  | 62 ++++++++++++++++++++++--------
 4 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..d150e92163b6 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -40,6 +40,7 @@ typedef struct {
 
 #ifdef CONFIG_X86_64
 	unsigned short flags;
+	u64 lam_cr3_mask;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..e6eac047c728 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 }
 #endif
 
+#ifdef CONFIG_X86_64
+static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
+{
+	return mm->context.lam_cr3_mask;
+}
+
+static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
+}
+
+#else
+
+static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+}
+#endif
+
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
@@ -168,6 +191,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	arch_dup_pkeys(oldmm, mm);
 	paravirt_arch_dup_mmap(oldmm, mm);
+	dup_lam(oldmm, mm);
 	return ldt_dup_context(oldmm, mm);
 }
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 4af5579c7ef7..5b93dad93ff4 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -86,6 +86,9 @@ struct tlb_state {
 		unsigned long		last_user_mm_spec;
 	};
 
+#ifdef CONFIG_X86_64
+	u64 lam_cr3_mask;
+#endif
 	u16 loaded_mm_asid;
 	u16 next_asid;
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..458867a8f4bd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -154,17 +154,17 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, u64 lam)
 {
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		return __sme_pa(pgd) | kern_pcid(asid);
+		return __sme_pa(pgd) | kern_pcid(asid) | lam;
 	} else {
 		VM_WARN_ON_ONCE(asid != 0);
-		return __sme_pa(pgd);
+		return __sme_pa(pgd) | lam;
 	}
 }
 
-static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid, u64 lam)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 	/*
@@ -173,7 +173,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 	 * boot because all CPU's the have same capabilities:
 	 */
 	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+	return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
 }
 
 /*
@@ -274,15 +274,15 @@ static inline void invalidate_user_asid(u16 asid)
 		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
 }
 
-static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
+static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, u64 lam, bool need_flush)
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
@@ -486,11 +486,36 @@ void cr4_update_pce(void *ignored)
 static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
+#ifdef CONFIG_X86_64
+static inline u64 tlbstate_lam_cr3_mask(void)
+{
+	return this_cpu_read(cpu_tlbstate.lam_cr3_mask);
+}
+
+static inline void set_tlbstate_lam_cr3_mask(u64 mask)
+{
+	this_cpu_write(cpu_tlbstate.lam_cr3_mask, mask);
+}
+
+#else
+
+static inline u64 tlbstate_lam_cr3_mask(void)
+{
+	return 0;
+}
+
+static inline void set_tlbstate_lam_cr3_mask(u64 mask)
+{
+}
+#endif
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	u64 prev_lam = tlbstate_lam_cr3_mask();
+	u64 new_lam = mm_cr3_lam_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
@@ -504,6 +529,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * cpu_tlbstate.loaded_mm) matches next.
 	 *
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
+	 *
+	 * NB: Initial LAM enabling calls us with prev == next. We must update
+	 * CR3 if prev_lam doesn't match the new one.
 	 */
 
 	/* We don't want flush_tlb_func() to run concurrently with us. */
@@ -520,7 +548,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
+	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
 		 * the system so hard that we don't see the call trace.
@@ -551,7 +579,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * provides that full memory barrier and core serializing
 	 * instruction.
 	 */
-	if (real_prev == next) {
+	if (real_prev == next && prev_lam == new_lam) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
@@ -622,15 +650,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
+	set_tlbstate_lam_cr3_mask(new_lam);
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
@@ -687,6 +716,7 @@ void initialize_tlbstate_and_flush(void)
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
 	unsigned long cr3 = __read_cr3();
+	u64 lam = cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
 
 	/* Assert that CR3 already references the right mm. */
 	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
@@ -700,7 +730,7 @@ void initialize_tlbstate_and_flush(void)
 		!(cr4_read_shadow() & X86_CR4_PCIDE));
 
 	/* Force ASID 0 and force a TLB flush. */
-	write_cr3(build_cr3(mm->pgd, 0));
+	write_cr3(build_cr3(mm->pgd, 0, lam));
 
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
@@ -1047,8 +1077,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  */
 unsigned long __get_current_cr3_fast(void)
 {
-	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	unsigned long cr3 =
+		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+		this_cpu_read(cpu_tlbstate.loaded_mm_asid),
+		tlbstate_lam_cr3_mask());
 
 	/* For now, be very restrictive about when this can be called. */
 	VM_WARN_ON(in_nmi() || preemptible());
-- 
2.35.1

