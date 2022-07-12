Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF85729B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiGLXNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiGLXN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:13:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F6BDB83
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657667606; x=1689203606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xL+V7QRPCo0EgB1wnPrVNvk55kqTmrvYnWwIghDNid4=;
  b=N3tnoPWPiylHENPKgeamFN5VJ9+zoXO5pQu8rmmcYxbomEy5ZHeqlbia
   uxuvQ8FxaWS8mAvD3cpnfX2erFFa4s1F8fckwO9R6V0jNeDVTLVksk/Ev
   GCYrlIom7mGXSfJF2x49fA4ke555YGhrsWEEKege8rx2FvD6o0d3Y2krH
   Q/tHxpr/jcJHbAW9JFkSM6wznlXUEjaSBKYqt0EkdL2dE+NotFrRILllA
   GFUkjTSzASV/yJJs3sQGxApyqh1Sr3HBfHSklt2VVicJnfOUfpKdNqi6y
   cSgsRGVanOfJbidr/VEdahWUeQDi1vhP45fTywgoFcWGKM1ON1UeL7lOs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286196159"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="286196159"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="570381832"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 16:13:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D2D98366; Wed, 13 Jul 2022 02:13:29 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 04/13] x86/mm: Handle LAM on context switch
Date:   Wed, 13 Jul 2022 02:13:19 +0300
Message-Id: <20220712231328.5294-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/include/asm/mmu.h         |  3 +++
 arch/x86/include/asm/mmu_context.h | 24 +++++++++++++++++
 arch/x86/include/asm/tlbflush.h    | 36 +++++++++++++++++++++++++
 arch/x86/mm/tlb.c                  | 42 +++++++++++++++++++-----------
 4 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..002889ca8978 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -40,6 +40,9 @@ typedef struct {
 
 #ifdef CONFIG_X86_64
 	unsigned short flags;
+
+	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
+	unsigned long lam_cr3_mask;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..69c943b2ae90 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 }
 #endif
 
+#ifdef CONFIG_X86_64
+static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
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
+static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
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
index 4af5579c7ef7..66db94d4daf4 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -100,6 +100,16 @@ struct tlb_state {
 	 */
 	bool invalidate_other;
 
+#ifdef CONFIG_X86_64
+	/*
+	 * Active LAM mode.
+	 *
+	 * X86_CR3_LAM_U57/U48 shifted right by X86_CR3_LAM_U57_BIT or 0 if LAM
+	 * disabled.
+	 */
+	u8 lam;
+#endif
+
 	/*
 	 * Mask that contains TLB_NR_DYN_ASIDS+1 bits to indicate
 	 * the corresponding user PCID needs a flush next time we
@@ -363,4 +373,30 @@ static inline void __native_tlb_flush_global(unsigned long cr4)
 	native_write_cr4(cr4 ^ X86_CR4_PGE);
 	native_write_cr4(cr4);
 }
+
+#ifdef CONFIG_X86_64
+static inline unsigned long tlbstate_lam_cr3_mask(void)
+{
+	unsigned long lam = this_cpu_read(cpu_tlbstate.lam);
+
+	return lam << X86_CR3_LAM_U57_BIT;
+}
+
+static inline void set_tlbstate_cr3_lam_mask(unsigned long mask)
+{
+	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
+}
+
+#else
+
+static inline unsigned long tlbstate_lam_cr3_mask(void)
+{
+	return 0;
+}
+
+static inline void set_tlbstate_cr3_lam_mask(u64 mask)
+{
+}
+#endif
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..4c93f87a8928 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -154,17 +154,18 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
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
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
+					      unsigned long lam)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 	/*
@@ -173,7 +174,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 	 * boot because all CPU's the have same capabilities:
 	 */
 	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+	return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
 }
 
 /*
@@ -274,15 +275,16 @@ static inline void invalidate_user_asid(u16 asid)
 		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
 }
 
-static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
+static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, unsigned long lam,
+			    bool need_flush)
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
@@ -491,6 +493,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	unsigned long prev_lam = tlbstate_lam_cr3_mask();
+	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
@@ -520,7 +524,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
+	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
 		 * the system so hard that we don't see the call trace.
@@ -622,15 +626,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
+	set_tlbstate_cr3_lam_mask(new_lam);
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
@@ -691,6 +696,10 @@ void initialize_tlbstate_and_flush(void)
 	/* Assert that CR3 already references the right mm. */
 	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
 
+	/* LAM expected to be disabled in CR3 and init_mm */
+	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
+	WARN_ON(mm_lam_cr3_mask(&init_mm));
+
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
 	 * doesn't work like other CR4 bits because it can only be set from
@@ -699,8 +708,8 @@ void initialize_tlbstate_and_flush(void)
 	WARN_ON(boot_cpu_has(X86_FEATURE_PCID) &&
 		!(cr4_read_shadow() & X86_CR4_PCIDE));
 
-	/* Force ASID 0 and force a TLB flush. */
-	write_cr3(build_cr3(mm->pgd, 0));
+	/* Disable LAM, force ASID 0 and force a TLB flush. */
+	write_cr3(build_cr3(mm->pgd, 0, 0));
 
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
@@ -708,6 +717,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
+	set_tlbstate_cr3_lam_mask(0);
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
@@ -1047,8 +1057,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
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

