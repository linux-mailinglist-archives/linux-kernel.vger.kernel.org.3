Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA68D4C0C29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiBWF3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiBWF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:27:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C066EB0C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d7b96d74f8so26402897b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3oY760HlCqyP72oYrU3xHrMJFplDw11mb6Xbtw2c1Ls=;
        b=D9vuMKstkbgF/aCBQRDDYJkPE6oiAauxsU3dhO3caTQi1Ors7zFJtimuNwMlMum/ya
         fAcTI4uIzYyzpdE2ZrEf/e06dc5vqx0LmPw1pv8n1QaD5XqmpCV/TIWB6E1NCWUBPvjx
         kP+mi1IO7e5PuquN9CtvonrWLH58I2l06WKRG94h1m346iPt6qcvJobAmVLWvT/Por/W
         KXklWi6I38xsiROhwJwrwH5FvLqV78uNDxYi99AIQIOYR6bJ6jvCc3gKNOAsKyQCZ1fM
         DYgbo1P+vArTAQISb6AwV92QkktvbooeM3ZvW1x8EQlFOcrk6E/f/85+B3yFEDRNVe/6
         OS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3oY760HlCqyP72oYrU3xHrMJFplDw11mb6Xbtw2c1Ls=;
        b=sQH53AeFlbdvLx4iXZo5c3mfi5TFZoJvPUFXZcxWsE2hajJ2D0+vKpRAMbKNFnCgG8
         ea8q8DqhWIuzqwJJm3296tHjwetTpQSn1Y979SbEUkxDvXh4MXqIL0K0a6B52aUK8m2K
         jG26+4ocxTHi5dJ0AkCsDGtkqxs+vKvPyVkDWiVBOKPgnLgkwENxsXvpr8zw5GfgP25+
         ncpIVjQlAE7vgRQmSOTpfacLCaPmiXwG7iF+c2hZay08FoptNVHmvuftMrfoj7WMfYUb
         MTK/pu+UAKhH+m2kT9d7pPuwHL4IGqxvWmAiIQCTKFLK8t0p/M6JI7zdDv+EI50gQfjl
         ClaA==
X-Gm-Message-State: AOAM532c9Vhbi/cFJIbRRQTbKFO0ovo43EqzMOCO5s/zX8+LwJ7UgWjZ
        X0Lmnn4bKcAzcgq8M9k0HjyLbIHiOs9i8FUlc5WATUpU0rkfU78q8WirkZ6MHVk0IABwPz6M7l6
        jjjibwDB5FsCYW7aT1+KKwAFpqhsuxVwLbkLqhdJ69cRfha3IFtcMxegDJXmJclRwmSevaRlN
X-Google-Smtp-Source: ABdhPJwRtpaU+ffn34I6BuLI3XRUIkza37lNEpNOPEWvhLHQmrQIvwguXasM2lDIKujjHT1vMgrO3eyensjW
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a81:1186:0:b0:2d6:a30d:fd86 with SMTP id
 128-20020a811186000000b002d6a30dfd86mr26352453ywr.160.1645593924065; Tue, 22
 Feb 2022 21:25:24 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:22:20 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-45-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 44/47] kvm: asi: Splitting kvm_vcpu_arch into
 non/sensitive parts
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Weisse <oweisse@google.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com, pjt@google.com,
        alexandre.chartre@oracle.com, rppt@linux.ibm.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, linux-mm@kvack.org
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

From: Ofir Weisse <oweisse@google.com>

The part that was allocated via ASI LOCAL SENSITIVE is in
`struct kvm_vcpu_arch_private`. The rest is in `struct kvm_vcpu_arch`.
The latter contains a pointer `private` which is allocated to be ASI
non-sensitive from a cache.

Signed-off-by: Ofir Weisse <oweisse@google.com>


---
 arch/x86/include/asm/kvm_host.h | 109 ++++++++++++----------
 arch/x86/kvm/cpuid.c            |  14 +--
 arch/x86/kvm/kvm_cache_regs.h   |  22 ++---
 arch/x86/kvm/mmu.h              |  10 +-
 arch/x86/kvm/mmu/mmu.c          | 138 +++++++++++++--------------
 arch/x86/kvm/mmu/mmu_internal.h |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  26 +++---
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  14 +--
 arch/x86/kvm/svm/nested.c       |  34 +++----
 arch/x86/kvm/svm/sev.c          |  70 +++++++-------
 arch/x86/kvm/svm/svm.c          |  52 +++++------
 arch/x86/kvm/trace.h            |  10 +-
 arch/x86/kvm/vmx/nested.c       |  68 +++++++-------
 arch/x86/kvm/vmx/vmx.c          |  64 ++++++-------
 arch/x86/kvm/x86.c              | 160 ++++++++++++++++----------------
 arch/x86/kvm/x86.h              |   2 +-
 virt/kvm/kvm_main.c             |  38 ++++++--
 18 files changed, 436 insertions(+), 401 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 34a05add5e77..d7315f86f85c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -606,14 +606,12 @@ struct kvm_vcpu_xen {
 	u64 runstate_times[4];
 };
 
-struct kvm_vcpu_arch {
-	/*
+struct kvm_vcpu_arch_private {
+        /*
 	 * rip and regs accesses must go through
 	 * kvm_{register,rip}_{read,write} functions.
 	 */
 	unsigned long regs[NR_VCPU_REGS];
-	u32 regs_avail;
-	u32 regs_dirty;
 
 	unsigned long cr0;
 	unsigned long cr0_guest_owned_bits;
@@ -623,6 +621,63 @@ struct kvm_vcpu_arch {
 	unsigned long cr4_guest_owned_bits;
 	unsigned long cr4_guest_rsvd_bits;
 	unsigned long cr8;
+
+	/*
+	 * QEMU userspace and the guest each have their own FPU state.
+	 * In vcpu_run, we switch between the user and guest FPU contexts.
+	 * While running a VCPU, the VCPU thread will have the guest FPU
+	 * context.
+	 *
+	 * Note that while the PKRU state lives inside the fpu registers,
+	 * it is switched out separately at VMENTER and VMEXIT time. The
+	 * "guest_fpstate" state here contains the guest FPU context, with the
+	 * host PRKU bits.
+	 */
+	struct fpu_guest guest_fpu;
+
+	u64 xcr0;
+	u64 guest_supported_xcr0;
+
+	/*
+	 * Paging state of the vcpu
+	 *
+	 * If the vcpu runs in guest mode with two level paging this still saves
+	 * the paging mode of the l1 guest. This context is always used to
+	 * handle faults.
+	 */
+	struct kvm_mmu *mmu;
+
+	/* Non-nested MMU for L1 */
+	struct kvm_mmu root_mmu;
+
+	/* L1 MMU when running nested */
+	struct kvm_mmu guest_mmu;
+
+	/*
+	 * Pointer to the mmu context currently used for
+	 * gva_to_gpa translations.
+	 */
+	struct kvm_mmu *walk_mmu;
+
+	/*
+	 * Paging state of an L2 guest (used for nested npt)
+	 *
+	 * This context will save all necessary information to walk page tables
+	 * of an L2 guest. This context is only initialized for page table
+	 * walking and not for faulting since we never handle l2 page faults on
+	 * the host.
+	 */
+	struct kvm_mmu nested_mmu;
+
+	struct x86_emulate_ctxt *emulate_ctxt;
+};
+
+struct kvm_vcpu_arch {
+        struct kvm_vcpu_arch_private *private;
+	
+	u32 regs_avail;
+	u32 regs_dirty;
+
 	u32 host_pkru;
 	u32 pkru;
 	u32 hflags;
@@ -645,36 +700,6 @@ struct kvm_vcpu_arch {
 	u64 arch_capabilities;
 	u64 perf_capabilities;
 
-	/*
-	 * Paging state of the vcpu
-	 *
-	 * If the vcpu runs in guest mode with two level paging this still saves
-	 * the paging mode of the l1 guest. This context is always used to
-	 * handle faults.
-	 */
-	struct kvm_mmu *mmu;
-
-	/* Non-nested MMU for L1 */
-	struct kvm_mmu root_mmu;
-
-	/* L1 MMU when running nested */
-	struct kvm_mmu guest_mmu;
-
-	/*
-	 * Paging state of an L2 guest (used for nested npt)
-	 *
-	 * This context will save all necessary information to walk page tables
-	 * of an L2 guest. This context is only initialized for page table
-	 * walking and not for faulting since we never handle l2 page faults on
-	 * the host.
-	 */
-	struct kvm_mmu nested_mmu;
-
-	/*
-	 * Pointer to the mmu context currently used for
-	 * gva_to_gpa translations.
-	 */
-	struct kvm_mmu *walk_mmu;
 
 	struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
 	struct kvm_mmu_memory_cache mmu_shadow_page_cache;
@@ -683,21 +708,6 @@ struct kvm_vcpu_arch {
 
 	struct asi_pgtbl_pool asi_pgtbl_pool;
 
-	/*
-	 * QEMU userspace and the guest each have their own FPU state.
-	 * In vcpu_run, we switch between the user and guest FPU contexts.
-	 * While running a VCPU, the VCPU thread will have the guest FPU
-	 * context.
-	 *
-	 * Note that while the PKRU state lives inside the fpu registers,
-	 * it is switched out separately at VMENTER and VMEXIT time. The
-	 * "guest_fpstate" state here contains the guest FPU context, with the
-	 * host PRKU bits.
-	 */
-	struct fpu_guest guest_fpu;
-
-	u64 xcr0;
-	u64 guest_supported_xcr0;
 
 	struct kvm_pio_request pio;
 	void *pio_data;
@@ -734,7 +744,6 @@ struct kvm_vcpu_arch {
 
 	/* emulate context */
 
-	struct x86_emulate_ctxt *emulate_ctxt;
 	bool emulate_regs_need_sync_to_vcpu;
 	bool emulate_regs_need_sync_from_vcpu;
 	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dedabfdd292e..7192cbe06ba3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -169,12 +169,12 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 
 	best = kvm_find_cpuid_entry(vcpu, 0xD, 0);
 	if (best)
-		best->ebx = xstate_required_size(vcpu->arch.xcr0, false);
+		best->ebx = xstate_required_size(vcpu->arch.private->xcr0, false);
 
 	best = kvm_find_cpuid_entry(vcpu, 0xD, 1);
 	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
 		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
-		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
+		best->ebx = xstate_required_size(vcpu->arch.private->xcr0, true);
 
 	best = kvm_find_kvm_cpuid_features(vcpu);
 	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
@@ -208,9 +208,9 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	best = kvm_find_cpuid_entry(vcpu, 0xD, 0);
 	if (!best)
-		vcpu->arch.guest_supported_xcr0 = 0;
+		vcpu->arch.private->guest_supported_xcr0 = 0;
 	else
-		vcpu->arch.guest_supported_xcr0 =
+		vcpu->arch.private->guest_supported_xcr0 =
 			(best->eax | ((u64)best->edx << 32)) & supported_xcr0;
 
 	/*
@@ -223,8 +223,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	best = kvm_find_cpuid_entry(vcpu, 0x12, 0x1);
 	if (best) {
-		best->ecx &= vcpu->arch.guest_supported_xcr0 & 0xffffffff;
-		best->edx &= vcpu->arch.guest_supported_xcr0 >> 32;
+		best->ecx &= vcpu->arch.private->guest_supported_xcr0 & 0xffffffff;
+		best->edx &= vcpu->arch.private->guest_supported_xcr0 >> 32;
 		best->ecx |= XFEATURE_MASK_FPSSE;
 	}
 
@@ -234,7 +234,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.reserved_gpa_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu);
 
 	kvm_pmu_refresh(vcpu);
-	vcpu->arch.cr4_guest_rsvd_bits =
+	vcpu->arch.private->cr4_guest_rsvd_bits =
 	    __cr4_reserved_bits(guest_cpuid_has, vcpu);
 
 	kvm_hv_set_cpuid(vcpu);
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 90e1ffdc05b7..592780402160 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -12,12 +12,12 @@
 #define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
 static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)\
 {									      \
-	return vcpu->arch.regs[VCPU_REGS_##uname];			      \
+	return vcpu->arch.private->regs[VCPU_REGS_##uname];		      \
 }									      \
 static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,	      \
 						unsigned long val)	      \
 {									      \
-	vcpu->arch.regs[VCPU_REGS_##uname] = val;			      \
+	vcpu->arch.private->regs[VCPU_REGS_##uname] = val;		      \
 }
 BUILD_KVM_GPR_ACCESSORS(rax, RAX)
 BUILD_KVM_GPR_ACCESSORS(rbx, RBX)
@@ -82,7 +82,7 @@ static inline unsigned long kvm_register_read_raw(struct kvm_vcpu *vcpu, int reg
 	if (!kvm_register_is_available(vcpu, reg))
 		static_call(kvm_x86_cache_reg)(vcpu, reg);
 
-	return vcpu->arch.regs[reg];
+	return vcpu->arch.private->regs[reg];
 }
 
 static inline void kvm_register_write_raw(struct kvm_vcpu *vcpu, int reg,
@@ -91,7 +91,7 @@ static inline void kvm_register_write_raw(struct kvm_vcpu *vcpu, int reg,
 	if (WARN_ON_ONCE((unsigned int)reg >= NR_VCPU_REGS))
 		return;
 
-	vcpu->arch.regs[reg] = val;
+	vcpu->arch.private->regs[reg] = val;
 	kvm_register_mark_dirty(vcpu, reg);
 }
 
@@ -122,21 +122,21 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_PDPTR))
 		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_PDPTR);
 
-	return vcpu->arch.walk_mmu->pdptrs[index];
+	return vcpu->arch.private->walk_mmu->pdptrs[index];
 }
 
 static inline void kvm_pdptr_write(struct kvm_vcpu *vcpu, int index, u64 value)
 {
-	vcpu->arch.walk_mmu->pdptrs[index] = value;
+	vcpu->arch.private->walk_mmu->pdptrs[index] = value;
 }
 
 static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *vcpu, ulong mask)
 {
 	ulong tmask = mask & KVM_POSSIBLE_CR0_GUEST_BITS;
-	if ((tmask & vcpu->arch.cr0_guest_owned_bits) &&
+	if ((tmask & vcpu->arch.private->cr0_guest_owned_bits) &&
 	    !kvm_register_is_available(vcpu, VCPU_EXREG_CR0))
 		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_CR0);
-	return vcpu->arch.cr0 & mask;
+	return vcpu->arch.private->cr0 & mask;
 }
 
 static inline ulong kvm_read_cr0(struct kvm_vcpu *vcpu)
@@ -147,17 +147,17 @@ static inline ulong kvm_read_cr0(struct kvm_vcpu *vcpu)
 static inline ulong kvm_read_cr4_bits(struct kvm_vcpu *vcpu, ulong mask)
 {
 	ulong tmask = mask & KVM_POSSIBLE_CR4_GUEST_BITS;
-	if ((tmask & vcpu->arch.cr4_guest_owned_bits) &&
+	if ((tmask & vcpu->arch.private->cr4_guest_owned_bits) &&
 	    !kvm_register_is_available(vcpu, VCPU_EXREG_CR4))
 		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_CR4);
-	return vcpu->arch.cr4 & mask;
+	return vcpu->arch.private->cr4 & mask;
 }
 
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
 		static_call(kvm_x86_cache_reg)(vcpu, VCPU_EXREG_CR3);
-	return vcpu->arch.cr3;
+	return vcpu->arch.private->cr3;
 }
 
 static inline ulong kvm_read_cr4(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 60b84331007d..aea21355580d 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -89,7 +89,7 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu);
 
 static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
 {
-	if (likely(vcpu->arch.mmu->root_hpa != INVALID_PAGE))
+	if (likely(vcpu->arch.private->mmu->root_hpa != INVALID_PAGE))
 		return 0;
 
 	return kvm_mmu_load(vcpu);
@@ -111,13 +111,13 @@ static inline unsigned long kvm_get_active_pcid(struct kvm_vcpu *vcpu)
 
 static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 {
-	u64 root_hpa = vcpu->arch.mmu->root_hpa;
+	u64 root_hpa = vcpu->arch.private->mmu->root_hpa;
 
 	if (!VALID_PAGE(root_hpa))
 		return;
 
 	static_call(kvm_x86_load_mmu_pgd)(vcpu, root_hpa,
-					  vcpu->arch.mmu->shadow_root_level);
+					  vcpu->arch.private->mmu->shadow_root_level);
 }
 
 struct kvm_page_fault {
@@ -193,7 +193,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.rsvd = err & PFERR_RSVD_MASK,
 		.user = err & PFERR_USER_MASK,
 		.prefetch = prefetch,
-		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
+		.is_tdp = likely(vcpu->arch.private->mmu->page_fault == kvm_tdp_page_fault),
 		.nx_huge_page_workaround_enabled = is_nx_huge_page_enabled(),
 
 		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
@@ -204,7 +204,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (fault.is_tdp)
 		return kvm_tdp_page_fault(vcpu, &fault);
 #endif
-	return vcpu->arch.mmu->page_fault(vcpu, &fault);
+	return vcpu->arch.private->mmu->page_fault(vcpu, &fault);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a2ada1104c2d..e36171f69b8e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -704,7 +704,7 @@ static bool mmu_spte_age(u64 *sptep)
 
 static void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
 {
-	if (is_tdp_mmu(vcpu->arch.mmu)) {
+	if (is_tdp_mmu(vcpu->arch.private->mmu)) {
 		kvm_tdp_mmu_walk_lockless_begin();
 	} else {
 		/*
@@ -723,7 +723,7 @@ static void walk_shadow_page_lockless_begin(struct kvm_vcpu *vcpu)
 
 static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 {
-	if (is_tdp_mmu(vcpu->arch.mmu)) {
+	if (is_tdp_mmu(vcpu->arch.private->mmu)) {
 		kvm_tdp_mmu_walk_lockless_end();
 	} else {
 		/*
@@ -1909,7 +1909,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 static bool kvm_sync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			 struct list_head *invalid_list)
 {
-	int ret = vcpu->arch.mmu->sync_page(vcpu, sp);
+	int ret = vcpu->arch.private->mmu->sync_page(vcpu, sp);
 
 	if (ret < 0) {
 		kvm_mmu_prepare_zap_page(vcpu->kvm, sp, invalid_list);
@@ -2081,7 +2081,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     int direct,
 					     unsigned int access)
 {
-	bool direct_mmu = vcpu->arch.mmu->direct_map;
+	bool direct_mmu = vcpu->arch.private->mmu->direct_map;
 	union kvm_mmu_page_role role;
 	struct hlist_head *sp_list;
 	unsigned quadrant;
@@ -2089,13 +2089,13 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	int collisions = 0;
 	LIST_HEAD(invalid_list);
 
-	role = vcpu->arch.mmu->mmu_role.base;
+	role = vcpu->arch.private->mmu->mmu_role.base;
 	role.level = level;
 	role.direct = direct;
 	if (role.direct)
 		role.gpte_is_8_bytes = true;
 	role.access = access;
-	if (!direct_mmu && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
+	if (!direct_mmu && vcpu->arch.private->mmu->root_level <= PT32_ROOT_LEVEL) {
 		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
 		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
 		role.quadrant = quadrant;
@@ -2181,11 +2181,11 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 {
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
-	iterator->level = vcpu->arch.mmu->shadow_root_level;
+	iterator->level = vcpu->arch.private->mmu->shadow_root_level;
 
 	if (iterator->level >= PT64_ROOT_4LEVEL &&
-	    vcpu->arch.mmu->root_level < PT64_ROOT_4LEVEL &&
-	    !vcpu->arch.mmu->direct_map)
+	    vcpu->arch.private->mmu->root_level < PT64_ROOT_4LEVEL &&
+	    !vcpu->arch.private->mmu->direct_map)
 		iterator->level = PT32E_ROOT_LEVEL;
 
 	if (iterator->level == PT32E_ROOT_LEVEL) {
@@ -2193,10 +2193,10 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 		 * prev_root is currently only used for 64-bit hosts. So only
 		 * the active root_hpa is valid here.
 		 */
-		BUG_ON(root != vcpu->arch.mmu->root_hpa);
+		BUG_ON(root != vcpu->arch.private->mmu->root_hpa);
 
 		iterator->shadow_addr
-			= vcpu->arch.mmu->pae_root[(addr >> 30) & 3];
+			= vcpu->arch.private->mmu->pae_root[(addr >> 30) & 3];
 		iterator->shadow_addr &= PT64_BASE_ADDR_MASK;
 		--iterator->level;
 		if (!iterator->shadow_addr)
@@ -2207,7 +2207,7 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 static void shadow_walk_init(struct kvm_shadow_walk_iterator *iterator,
 			     struct kvm_vcpu *vcpu, u64 addr)
 {
-	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.mmu->root_hpa,
+	shadow_walk_init_using_root(iterator, vcpu, vcpu->arch.private->mmu->root_hpa,
 				    addr);
 }
 
@@ -2561,7 +2561,7 @@ static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 	gpa_t gpa;
 	int r;
 
-	if (vcpu->arch.mmu->direct_map)
+	if (vcpu->arch.private->mmu->direct_map)
 		return 0;
 
 	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
@@ -3186,7 +3186,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	do {
 		u64 new_spte;
 
-		if (is_tdp_mmu(vcpu->arch.mmu))
+		if (is_tdp_mmu(vcpu->arch.private->mmu))
 			sptep = kvm_tdp_mmu_fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
 		else
 			sptep = fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
@@ -3393,7 +3393,7 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
 
 static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	u8 shadow_root_level = mmu->shadow_root_level;
 	hpa_t root;
 	unsigned i;
@@ -3501,7 +3501,7 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
 	hpa_t root;
@@ -3611,7 +3611,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	bool need_pml5 = mmu->shadow_root_level > PT64_ROOT_4LEVEL;
 	u64 *pml5_root = NULL;
 	u64 *pml4_root = NULL;
@@ -3712,16 +3712,16 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 	int i;
 	struct kvm_mmu_page *sp;
 
-	if (vcpu->arch.mmu->direct_map)
+	if (vcpu->arch.private->mmu->direct_map)
 		return;
 
-	if (!VALID_PAGE(vcpu->arch.mmu->root_hpa))
+	if (!VALID_PAGE(vcpu->arch.private->mmu->root_hpa))
 		return;
 
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
-		hpa_t root = vcpu->arch.mmu->root_hpa;
+	if (vcpu->arch.private->mmu->root_level >= PT64_ROOT_4LEVEL) {
+		hpa_t root = vcpu->arch.private->mmu->root_hpa;
 		sp = to_shadow_page(root);
 
 		if (!is_unsync_root(root))
@@ -3741,7 +3741,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 	kvm_mmu_audit(vcpu, AUDIT_PRE_SYNC);
 
 	for (i = 0; i < 4; ++i) {
-		hpa_t root = vcpu->arch.mmu->pae_root[i];
+		hpa_t root = vcpu->arch.private->mmu->pae_root[i];
 
 		if (IS_VALID_PAE_ROOT(root)) {
 			root &= PT64_BASE_ADDR_MASK;
@@ -3760,11 +3760,11 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
 	int i;
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
-		if (is_unsync_root(vcpu->arch.mmu->prev_roots[i].hpa))
+		if (is_unsync_root(vcpu->arch.private->mmu->prev_roots[i].hpa))
 			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
 
 	/* sync prev_roots by simply freeing them */
-	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, roots_to_free);
+	kvm_mmu_free_roots(vcpu, vcpu->arch.private->mmu, roots_to_free);
 }
 
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gpa_t vaddr,
@@ -3781,7 +3781,7 @@ static gpa_t nonpaging_gva_to_gpa_nested(struct kvm_vcpu *vcpu, gpa_t vaddr,
 {
 	if (exception)
 		exception->error_code = 0;
-	return vcpu->arch.nested_mmu.translate_gpa(vcpu, vaddr, access, exception);
+	return vcpu->arch.private->nested_mmu.translate_gpa(vcpu, vaddr, access, exception);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
@@ -3834,7 +3834,7 @@ static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 
 	walk_shadow_page_lockless_begin(vcpu);
 
-	if (is_tdp_mmu(vcpu->arch.mmu))
+	if (is_tdp_mmu(vcpu->arch.private->mmu))
 		leaf = kvm_tdp_mmu_get_walk(vcpu, addr, sptes, &root);
 	else
 		leaf = get_walk(vcpu, addr, sptes, &root);
@@ -3857,7 +3857,7 @@ static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 	if (!is_shadow_present_pte(sptes[leaf]))
 		leaf++;
 
-	rsvd_check = &vcpu->arch.mmu->shadow_zero_check;
+	rsvd_check = &vcpu->arch.private->mmu->shadow_zero_check;
 
 	for (level = root; level >= leaf; level--)
 		reserved |= is_rsvd_spte(rsvd_check, sptes[level], level);
@@ -3945,8 +3945,8 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 	arch.token = (vcpu->arch.apf.id++ << 12) | vcpu->vcpu_id;
 	arch.gfn = gfn;
-	arch.direct_map = vcpu->arch.mmu->direct_map;
-	arch.cr3 = vcpu->arch.mmu->get_guest_pgd(vcpu);
+	arch.direct_map = vcpu->arch.private->mmu->direct_map;
+	arch.cr3 = vcpu->arch.private->mmu->get_guest_pgd(vcpu);
 
 	return kvm_setup_async_pf(vcpu, cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
@@ -4029,7 +4029,7 @@ static void vcpu_fill_asi_pgtbl_pool(struct kvm_vcpu *vcpu)
 static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 				struct kvm_page_fault *fault, int mmu_seq)
 {
-	struct kvm_mmu_page *sp = to_shadow_page(vcpu->arch.mmu->root_hpa);
+	struct kvm_mmu_page *sp = to_shadow_page(vcpu->arch.private->mmu->root_hpa);
 
 	/* Special roots, e.g. pae_root, are not backed by shadow pages. */
 	if (sp && is_obsolete_sp(vcpu->kvm, sp))
@@ -4052,7 +4052,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
-	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
+	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.private->mmu);
 
 	unsigned long mmu_seq;
 	bool try_asi_map;
@@ -4206,7 +4206,7 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 {
 	uint i;
 	struct kvm_mmu_root_info root;
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 
 	root.pgd = mmu->root_pgd;
 	root.hpa = mmu->root_hpa;
@@ -4230,7 +4230,7 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 static bool fast_pgd_switch(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 			    union kvm_mmu_page_role new_role)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 
 	/*
 	 * For now, limit the fast switch to 64-bit hosts+VMs in order to avoid
@@ -4248,7 +4248,7 @@ static void __kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 			      union kvm_mmu_page_role new_role)
 {
 	if (!fast_pgd_switch(vcpu, new_pgd, new_role)) {
-		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.private->mmu, KVM_MMU_ROOT_CURRENT);
 		return;
 	}
 
@@ -4279,7 +4279,7 @@ static void __kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd,
 	 */
 	if (!new_role.direct)
 		__clear_sp_write_flooding_count(
-				to_shadow_page(vcpu->arch.mmu->root_hpa));
+				to_shadow_page(vcpu->arch.private->mmu->root_hpa));
 }
 
 void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd)
@@ -4826,7 +4826,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 
 static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.root_mmu;
+	struct kvm_mmu *context = &vcpu->arch.private->root_mmu;
 	struct kvm_mmu_role_regs regs = vcpu_to_role_regs(vcpu);
 	union kvm_mmu_role new_role =
 		kvm_calc_tdp_mmu_root_page_role(vcpu, &regs, false);
@@ -4914,7 +4914,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 				struct kvm_mmu_role_regs *regs)
 {
-	struct kvm_mmu *context = &vcpu->arch.root_mmu;
+	struct kvm_mmu *context = &vcpu->arch.private->root_mmu;
 	union kvm_mmu_role new_role =
 		kvm_calc_shadow_mmu_root_page_role(vcpu, regs, false);
 
@@ -4937,7 +4937,7 @@ kvm_calc_shadow_npt_root_page_role(struct kvm_vcpu *vcpu,
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 			     unsigned long cr4, u64 efer, gpa_t nested_cr3)
 {
-	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
+	struct kvm_mmu *context = &vcpu->arch.private->guest_mmu;
 	struct kvm_mmu_role_regs regs = {
 		.cr0 = cr0,
 		.cr4 = cr4 & ~X86_CR4_PKE,
@@ -4960,7 +4960,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	union kvm_mmu_role role = {0};
 
 	/* SMM flag is inherited from root_mmu */
-	role.base.smm = vcpu->arch.root_mmu.mmu_role.base.smm;
+	role.base.smm = vcpu->arch.private->root_mmu.mmu_role.base.smm;
 
 	role.base.level = level;
 	role.base.gpte_is_8_bytes = true;
@@ -4980,7 +4980,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty, gpa_t new_eptp)
 {
-	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
+	struct kvm_mmu *context = &vcpu->arch.private->guest_mmu;
 	u8 level = vmx_eptp_page_walk_level(new_eptp);
 	union kvm_mmu_role new_role =
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
@@ -5012,7 +5012,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_ept_mmu);
 
 static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *context = &vcpu->arch.root_mmu;
+	struct kvm_mmu *context = &vcpu->arch.private->root_mmu;
 	struct kvm_mmu_role_regs regs = vcpu_to_role_regs(vcpu);
 
 	kvm_init_shadow_mmu(vcpu, &regs);
@@ -5043,7 +5043,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu_role_regs regs = vcpu_to_role_regs(vcpu);
 	union kvm_mmu_role new_role = kvm_calc_nested_mmu_role(vcpu, &regs);
-	struct kvm_mmu *g_context = &vcpu->arch.nested_mmu;
+	struct kvm_mmu *g_context = &vcpu->arch.private->nested_mmu;
 
 	if (new_role.as_u64 == g_context->mmu_role.as_u64)
 		return;
@@ -5061,9 +5061,9 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 	g_context->invlpg            = NULL;
 
 	/*
-	 * Note that arch.mmu->gva_to_gpa translates l2_gpa to l1_gpa using
+	 * Note that arch.private->mmu->gva_to_gpa translates l2_gpa to l1_gpa using
 	 * L1's nested page tables (e.g. EPT12). The nested translation
-	 * of l2_gva to l1_gpa is done by arch.nested_mmu.gva_to_gpa using
+	 * of l2_gva to l1_gpa is done by arch.private->nested_mmu.gva_to_gpa using
 	 * L2's page tables as the first level of translation and L1's
 	 * nested page tables as the second level of translation. Basically
 	 * the gva_to_gpa functions between mmu and nested_mmu are swapped.
@@ -5119,9 +5119,9 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * problem is swept under the rug; KVM's CPUID API is horrific and
 	 * it's all but impossible to solve it without introducing a new API.
 	 */
-	vcpu->arch.root_mmu.mmu_role.ext.valid = 0;
-	vcpu->arch.guest_mmu.mmu_role.ext.valid = 0;
-	vcpu->arch.nested_mmu.mmu_role.ext.valid = 0;
+	vcpu->arch.private->root_mmu.mmu_role.ext.valid = 0;
+	vcpu->arch.private->guest_mmu.mmu_role.ext.valid = 0;
+	vcpu->arch.private->nested_mmu.mmu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
 	/*
@@ -5142,13 +5142,13 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 {
 	int r;
 
-	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
+	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.private->mmu->direct_map);
 	if (r)
 		goto out;
 	r = mmu_alloc_special_roots(vcpu);
 	if (r)
 		goto out;
-	if (vcpu->arch.mmu->direct_map)
+	if (vcpu->arch.private->mmu->direct_map)
 		r = mmu_alloc_direct_roots(vcpu);
 	else
 		r = mmu_alloc_shadow_roots(vcpu);
@@ -5165,10 +5165,10 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root_hpa));
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root_hpa));
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.private->root_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.private->root_mmu.root_hpa));
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.private->guest_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.private->guest_mmu.root_hpa));
 }
 
 static bool need_remote_flush(u64 old, u64 new)
@@ -5351,9 +5351,9 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len)
 {
 	int r, emulation_type = EMULTYPE_PF;
-	bool direct = vcpu->arch.mmu->direct_map;
+	bool direct = vcpu->arch.private->mmu->direct_map;
 
-	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
+	if (WARN_ON(!VALID_PAGE(vcpu->arch.private->mmu->root_hpa)))
 		return RET_PF_RETRY;
 
 	r = RET_PF_INVALID;
@@ -5382,14 +5382,14 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 	 * paging in both guests. If true, we simply unprotect the page
 	 * and resume the guest.
 	 */
-	if (vcpu->arch.mmu->direct_map &&
+	if (vcpu->arch.private->mmu->direct_map &&
 	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE) {
 		kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(cr2_or_gpa));
 		return 1;
 	}
 
 	/*
-	 * vcpu->arch.mmu.page_fault returned RET_PF_EMULATE, but we can still
+	 * vcpu->arch.private->mmu.page_fault returned RET_PF_EMULATE, but we can still
 	 * optimistically try to just unprotect the page and let the processor
 	 * re-execute the instruction that caused the page fault.  Do not allow
 	 * retrying MMIO emulation, as it's not only pointless but could also
@@ -5412,8 +5412,8 @@ void kvm_mmu_invalidate_gva(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	int i;
 
-	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (mmu != &vcpu->arch.guest_mmu) {
+	/* It's actually a GPA for vcpu->arch.private->guest_mmu.  */
+	if (mmu != &vcpu->arch.private->guest_mmu) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_address(gva, vcpu))
 			return;
@@ -5448,7 +5448,7 @@ void kvm_mmu_invalidate_gva(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 {
-	kvm_mmu_invalidate_gva(vcpu, vcpu->arch.walk_mmu, gva, INVALID_PAGE);
+	kvm_mmu_invalidate_gva(vcpu, vcpu->arch.private->walk_mmu, gva, INVALID_PAGE);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_invlpg);
@@ -5456,7 +5456,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_invlpg);
 
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	bool tlb_flush = false;
 	uint i;
 
@@ -5638,24 +5638,24 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	        vcpu->arch.mmu_shadow_page_cache.gfp_asi = 0;
 #endif
 
-	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.private->mmu = &vcpu->arch.private->root_mmu;
+	vcpu->arch.private->walk_mmu = &vcpu->arch.private->root_mmu;
 
-	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
+	vcpu->arch.private->nested_mmu.translate_gpa = translate_nested_gpa;
 
 	asi_init_pgtbl_pool(&vcpu->arch.asi_pgtbl_pool);
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.private->guest_mmu);
 	if (ret)
 		return ret;
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.private->root_mmu);
 	if (ret)
 		goto fail_allocate_root;
 
 	return ret;
  fail_allocate_root:
-	free_mmu_pages(&vcpu->arch.guest_mmu);
+	free_mmu_pages(&vcpu->arch.private->guest_mmu);
 	return ret;
 }
 
@@ -6261,8 +6261,8 @@ unsigned long kvm_mmu_calculate_default_mmu_pages(struct kvm *kvm)
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_unload(vcpu);
-	free_mmu_pages(&vcpu->arch.root_mmu);
-	free_mmu_pages(&vcpu->arch.guest_mmu);
+	free_mmu_pages(&vcpu->arch.private->root_mmu);
+	free_mmu_pages(&vcpu->arch.private->guest_mmu);
 	mmu_free_memory_caches(vcpu);
 	asi_clear_pgtbl_pool(&vcpu->arch.asi_pgtbl_pool);
 }
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 52c6527b1a06..57ec9dd147da 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -114,7 +114,7 @@ static inline bool kvm_vcpu_ad_need_write_protect(struct kvm_vcpu *vcpu)
 	 * being enabled is mandatory as the bits used to denote WP-only SPTEs
 	 * are reserved for NPT w/ PAE (32-bit KVM).
 	 */
-	return vcpu->arch.mmu == &vcpu->arch.guest_mmu &&
+	return vcpu->arch.private->mmu == &vcpu->arch.private->guest_mmu &&
 	       kvm_x86_ops.cpu_dirty_log_size;
 }
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 193317ad60a4..c39a1a870a2b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -194,11 +194,11 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 		goto no_present;
 
 	/* if accessed bit is not supported prefetch non accessed gpte */
-	if (PT_HAVE_ACCESSED_DIRTY(vcpu->arch.mmu) &&
+	if (PT_HAVE_ACCESSED_DIRTY(vcpu->arch.private->mmu) &&
 	    !(gpte & PT_GUEST_ACCESSED_MASK))
 		goto no_present;
 
-	if (FNAME(is_rsvd_bits_set)(vcpu->arch.mmu, gpte, PG_LEVEL_4K))
+	if (FNAME(is_rsvd_bits_set)(vcpu->arch.private->mmu, gpte, PG_LEVEL_4K))
 		goto no_present;
 
 	return false;
@@ -533,7 +533,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->fault.address = addr;
-	walker->fault.nested_page_fault = mmu != vcpu->arch.walk_mmu;
+	walker->fault.nested_page_fault = mmu != vcpu->arch.private->walk_mmu;
 	walker->fault.async_page_fault = false;
 
 	trace_kvm_mmu_walker_error(walker->fault.error_code);
@@ -543,7 +543,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 static int FNAME(walk_addr)(struct guest_walker *walker,
 			    struct kvm_vcpu *vcpu, gpa_t addr, u32 access)
 {
-	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu, addr,
+	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.private->mmu, addr,
 					access);
 }
 
@@ -552,7 +552,7 @@ static int FNAME(walk_addr_nested)(struct guest_walker *walker,
 				   struct kvm_vcpu *vcpu, gva_t addr,
 				   u32 access)
 {
-	return FNAME(walk_addr_generic)(walker, vcpu, &vcpu->arch.nested_mmu,
+	return FNAME(walk_addr_generic)(walker, vcpu, &vcpu->arch.private->nested_mmu,
 					addr, access);
 }
 #endif
@@ -573,7 +573,7 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access & FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(vcpu->arch.private->mmu, &pte_access, gpte);
 
 	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn,
 			no_dirty_log && (pte_access & ACC_WRITE_MASK));
@@ -670,7 +670,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	WARN_ON_ONCE(gw->gfn != base_gfn);
 	direct_access = gw->pte_access;
 
-	top_level = vcpu->arch.mmu->root_level;
+	top_level = vcpu->arch.private->mmu->root_level;
 	if (top_level == PT32E_ROOT_LEVEL)
 		top_level = PT32_ROOT_LEVEL;
 	/*
@@ -682,7 +682,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	if (FNAME(gpte_changed)(vcpu, gw, top_level))
 		goto out_gpte_changed;
 
-	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
+	if (WARN_ON(!VALID_PAGE(vcpu->arch.private->mmu->root_hpa)))
 		goto out_gpte_changed;
 
 	for (shadow_walk_init(&it, vcpu, fault->addr);
@@ -806,7 +806,7 @@ FNAME(is_self_change_mapping)(struct kvm_vcpu *vcpu,
 	bool self_changed = false;
 
 	if (!(walker->pte_access & ACC_WRITE_MASK ||
-	    (!is_cr0_wp(vcpu->arch.mmu) && !user_fault)))
+	    (!is_cr0_wp(vcpu->arch.private->mmu) && !user_fault)))
 		return false;
 
 	for (level = walker->level; level <= walker->max_level; level++) {
@@ -905,7 +905,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * we will cache the incorrect access into mmio spte.
 	 */
 	if (fault->write && !(walker.pte_access & ACC_WRITE_MASK) &&
-	    !is_cr0_wp(vcpu->arch.mmu) && !fault->user && fault->slot) {
+	    !is_cr0_wp(vcpu->arch.private->mmu) && !fault->user && fault->slot) {
 		walker.pte_access |= ACC_WRITE_MASK;
 		walker.pte_access &= ~ACC_USER_MASK;
 
@@ -915,7 +915,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		 * then we should prevent the kernel from executing it
 		 * if SMEP is enabled.
 		 */
-		if (is_cr4_smep(vcpu->arch.mmu))
+		if (is_cr4_smep(vcpu->arch.private->mmu))
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 
@@ -1071,7 +1071,7 @@ static gpa_t FNAME(gva_to_gpa_nested)(struct kvm_vcpu *vcpu, gpa_t vaddr,
  */
 static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 {
-	union kvm_mmu_page_role mmu_role = vcpu->arch.mmu->mmu_role.base;
+	union kvm_mmu_page_role mmu_role = vcpu->arch.private->mmu->mmu_role.base;
 	int i;
 	bool host_writable;
 	gpa_t first_pte_gpa;
@@ -1129,7 +1129,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 		gfn = gpte_to_gfn(gpte);
 		pte_access = sp->role.access;
 		pte_access &= FNAME(gpte_access)(gpte);
-		FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
+		FNAME(protect_clean_gpte)(vcpu->arch.private->mmu, &pte_access, gpte);
 
 		if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access))
 			continue;
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 13038fae5088..df14b6639b35 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -177,9 +177,9 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (prefetch)
 		spte = mark_spte_for_access_track(spte);
 
-	WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->shadow_zero_check, spte, level),
+	WARN_ONCE(is_rsvd_spte(&vcpu->arch.private->mmu->shadow_zero_check, spte, level),
 		  "spte = 0x%llx, level = %d, rsvd bits = 0x%llx", spte, level,
-		  get_rsvd_bits(&vcpu->arch.mmu->shadow_zero_check, spte, level));
+		  get_rsvd_bits(&vcpu->arch.private->mmu->shadow_zero_check, spte, level));
 
 	if ((spte & PT_WRITABLE_MASK) && kvm_slot_dirty_track_enabled(slot)) {
 		/* Enforced by kvm_mmu_hugepage_adjust. */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 1beb4ca90560..c3634ac01869 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -162,7 +162,7 @@ static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role;
 
-	role = vcpu->arch.mmu->mmu_role.base;
+	role = vcpu->arch.private->mmu->mmu_role.base;
 	role.level = level;
 	role.direct = true;
 	role.gpte_is_8_bytes = true;
@@ -198,7 +198,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
+	role = page_role_for_level(vcpu, vcpu->arch.private->mmu->shadow_root_level);
 
 	/* Check for an existing root before allocating a new one. */
 	for_each_tdp_mmu_root(kvm, root, kvm_mmu_role_as_id(role)) {
@@ -207,7 +207,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 			goto out;
 	}
 
-	root = alloc_tdp_mmu_page(vcpu, 0, vcpu->arch.mmu->shadow_root_level);
+	root = alloc_tdp_mmu_page(vcpu, 0, vcpu->arch.private->mmu->shadow_root_level);
 	refcount_set(&root->tdp_mmu_root_count, 1);
 
 	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
@@ -952,7 +952,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
  */
 int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	struct tdp_iter iter;
 	struct kvm_mmu_page *sp;
 	u64 *child_pt;
@@ -1486,11 +1486,11 @@ int kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 			 int *root_level)
 {
 	struct tdp_iter iter;
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	gfn_t gfn = addr >> PAGE_SHIFT;
 	int leaf = -1;
 
-	*root_level = vcpu->arch.mmu->shadow_root_level;
+	*root_level = vcpu->arch.private->mmu->shadow_root_level;
 
 	tdp_mmu_for_each_pte(iter, mmu, gfn, gfn + 1) {
 		leaf = iter.level;
@@ -1515,7 +1515,7 @@ u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, u64 addr,
 					u64 *spte)
 {
 	struct tdp_iter iter;
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	gfn_t gfn = addr >> PAGE_SHIFT;
 	tdp_ptep_t sptep = NULL;
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f8b7bc04b3e7..c90ef5bf26cf 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -97,7 +97,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	WARN_ON(mmu_is_nested(vcpu));
 
-	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
+	vcpu->arch.private->mmu = &vcpu->arch.private->guest_mmu;
 
 	/*
 	 * The NPT format depends on L1's CR4 and EFER, which is in vmcb01.  Note,
@@ -107,16 +107,16 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
 				svm->nested.ctl.nested_cr3);
-	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
-	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
-	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
+	vcpu->arch.private->mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
+	vcpu->arch.private->mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
+	vcpu->arch.private->mmu->inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.private->walk_mmu               = &vcpu->arch.private->nested_mmu;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.private->mmu = &vcpu->arch.private->root_mmu;
+	vcpu->arch.private->walk_mmu = &vcpu->arch.private->root_mmu;
 }
 
 void recalc_intercepts(struct vcpu_svm *svm)
@@ -437,13 +437,13 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 		return -EINVAL;
 
 	if (reload_pdptrs && !nested_npt && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3)))
+	    CC(!load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, cr3)))
 		return -EINVAL;
 
 	if (!nested_npt)
 		kvm_mmu_new_pgd(vcpu, cr3);
 
-	vcpu->arch.cr3 = cr3;
+	vcpu->arch.private->cr3 = cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
 	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
@@ -500,7 +500,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 	svm_set_cr0(&svm->vcpu, vmcb12->save.cr0);
 	svm_set_cr4(&svm->vcpu, vmcb12->save.cr4);
 
-	svm->vcpu.arch.cr2 = vmcb12->save.cr2;
+	svm->vcpu.arch.private->cr2 = vmcb12->save.cr2;
 
 	kvm_rax_write(&svm->vcpu, vmcb12->save.rax);
 	kvm_rsp_write(&svm->vcpu, vmcb12->save.rsp);
@@ -634,7 +634,7 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 		return ret;
 
 	if (!npt_enabled)
-		vcpu->arch.mmu->inject_page_fault = svm_inject_page_fault_nested;
+		vcpu->arch.private->mmu->inject_page_fault = svm_inject_page_fault_nested;
 
 	if (!from_vmrun)
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
@@ -695,7 +695,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	 */
 	svm->vmcb01.ptr->save.efer   = vcpu->arch.efer;
 	svm->vmcb01.ptr->save.cr0    = kvm_read_cr0(vcpu);
-	svm->vmcb01.ptr->save.cr4    = vcpu->arch.cr4;
+	svm->vmcb01.ptr->save.cr4    = vcpu->arch.private->cr4;
 	svm->vmcb01.ptr->save.rflags = kvm_get_rflags(vcpu);
 	svm->vmcb01.ptr->save.rip    = kvm_rip_read(vcpu);
 
@@ -805,7 +805,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	vmcb12->save.cr0    = kvm_read_cr0(vcpu);
 	vmcb12->save.cr3    = kvm_read_cr3(vcpu);
 	vmcb12->save.cr2    = vmcb->save.cr2;
-	vmcb12->save.cr4    = svm->vcpu.arch.cr4;
+	vmcb12->save.cr4    = svm->vcpu.arch.private->cr4;
 	vmcb12->save.rflags = kvm_get_rflags(vcpu);
 	vmcb12->save.rip    = kvm_rip_read(vcpu);
 	vmcb12->save.rsp    = kvm_rsp_read(vcpu);
@@ -991,7 +991,7 @@ static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 	if (!(vmcb_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
 		return NESTED_EXIT_HOST;
 
-	msr    = svm->vcpu.arch.regs[VCPU_REGS_RCX];
+	msr    = svm->vcpu.arch.private->regs[VCPU_REGS_RCX];
 	offset = svm_msrpm_offset(msr);
 	write  = svm->vmcb->control.exit_info_1 & 1;
 	mask   = 1 << ((2 * (msr & 0xf)) + write);
@@ -1131,7 +1131,7 @@ static void nested_svm_inject_exception_vmexit(struct vcpu_svm *svm)
 		else if (svm->vcpu.arch.exception.has_payload)
 			svm->vmcb->control.exit_info_2 = svm->vcpu.arch.exception.payload;
 		else
-			svm->vmcb->control.exit_info_2 = svm->vcpu.arch.cr2;
+			svm->vmcb->control.exit_info_2 = svm->vcpu.arch.private->cr2;
 	} else if (nr == DB_VECTOR) {
 		/* See inject_pending_event.  */
 		kvm_deliver_exception_payload(&svm->vcpu);
@@ -1396,7 +1396,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * Set it again to fix this.
 	 */
 
-	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
+	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.private->cr3,
 				  nested_npt_enabled(svm), false);
 	if (WARN_ON_ONCE(ret))
 		goto out_free;
@@ -1449,7 +1449,7 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		 * the guest CR3 might be restored prior to setting the nested
 		 * state which can lead to a load of wrong PDPTRs.
 		 */
-		if (CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, vcpu->arch.cr3)))
+		if (CC(!load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, vcpu->arch.private->cr3)))
 			return false;
 
 	if (!nested_svm_vmrun_msrpm(svm)) {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index be2883141220..9c62566ddde8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -565,28 +565,28 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 		return -EINVAL;
 
 	/* Sync registgers */
-	save->rax = svm->vcpu.arch.regs[VCPU_REGS_RAX];
-	save->rbx = svm->vcpu.arch.regs[VCPU_REGS_RBX];
-	save->rcx = svm->vcpu.arch.regs[VCPU_REGS_RCX];
-	save->rdx = svm->vcpu.arch.regs[VCPU_REGS_RDX];
-	save->rsp = svm->vcpu.arch.regs[VCPU_REGS_RSP];
-	save->rbp = svm->vcpu.arch.regs[VCPU_REGS_RBP];
-	save->rsi = svm->vcpu.arch.regs[VCPU_REGS_RSI];
-	save->rdi = svm->vcpu.arch.regs[VCPU_REGS_RDI];
+	save->rax = svm->vcpu.arch.private->regs[VCPU_REGS_RAX];
+	save->rbx = svm->vcpu.arch.private->regs[VCPU_REGS_RBX];
+	save->rcx = svm->vcpu.arch.private->regs[VCPU_REGS_RCX];
+	save->rdx = svm->vcpu.arch.private->regs[VCPU_REGS_RDX];
+	save->rsp = svm->vcpu.arch.private->regs[VCPU_REGS_RSP];
+	save->rbp = svm->vcpu.arch.private->regs[VCPU_REGS_RBP];
+	save->rsi = svm->vcpu.arch.private->regs[VCPU_REGS_RSI];
+	save->rdi = svm->vcpu.arch.private->regs[VCPU_REGS_RDI];
 #ifdef CONFIG_X86_64
-	save->r8  = svm->vcpu.arch.regs[VCPU_REGS_R8];
-	save->r9  = svm->vcpu.arch.regs[VCPU_REGS_R9];
-	save->r10 = svm->vcpu.arch.regs[VCPU_REGS_R10];
-	save->r11 = svm->vcpu.arch.regs[VCPU_REGS_R11];
-	save->r12 = svm->vcpu.arch.regs[VCPU_REGS_R12];
-	save->r13 = svm->vcpu.arch.regs[VCPU_REGS_R13];
-	save->r14 = svm->vcpu.arch.regs[VCPU_REGS_R14];
-	save->r15 = svm->vcpu.arch.regs[VCPU_REGS_R15];
+	save->r8  = svm->vcpu.arch.private->regs[VCPU_REGS_R8];
+	save->r9  = svm->vcpu.arch.private->regs[VCPU_REGS_R9];
+	save->r10 = svm->vcpu.arch.private->regs[VCPU_REGS_R10];
+	save->r11 = svm->vcpu.arch.private->regs[VCPU_REGS_R11];
+	save->r12 = svm->vcpu.arch.private->regs[VCPU_REGS_R12];
+	save->r13 = svm->vcpu.arch.private->regs[VCPU_REGS_R13];
+	save->r14 = svm->vcpu.arch.private->regs[VCPU_REGS_R14];
+	save->r15 = svm->vcpu.arch.private->regs[VCPU_REGS_R15];
 #endif
-	save->rip = svm->vcpu.arch.regs[VCPU_REGS_RIP];
+	save->rip = svm->vcpu.arch.private->regs[VCPU_REGS_RIP];
 
 	/* Sync some non-GPR registers before encrypting */
-	save->xcr0 = svm->vcpu.arch.xcr0;
+	save->xcr0 = svm->vcpu.arch.private->xcr0;
 	save->pkru = svm->vcpu.arch.pkru;
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
@@ -2301,10 +2301,10 @@ static void sev_es_sync_to_ghcb(struct vcpu_svm *svm)
 	 * Copy their values, even if they may not have been written during the
 	 * VM-Exit.  It's the guest's responsibility to not consume random data.
 	 */
-	ghcb_set_rax(ghcb, vcpu->arch.regs[VCPU_REGS_RAX]);
-	ghcb_set_rbx(ghcb, vcpu->arch.regs[VCPU_REGS_RBX]);
-	ghcb_set_rcx(ghcb, vcpu->arch.regs[VCPU_REGS_RCX]);
-	ghcb_set_rdx(ghcb, vcpu->arch.regs[VCPU_REGS_RDX]);
+	ghcb_set_rax(ghcb, vcpu->arch.private->regs[VCPU_REGS_RAX]);
+	ghcb_set_rbx(ghcb, vcpu->arch.private->regs[VCPU_REGS_RBX]);
+	ghcb_set_rcx(ghcb, vcpu->arch.private->regs[VCPU_REGS_RCX]);
+	ghcb_set_rdx(ghcb, vcpu->arch.private->regs[VCPU_REGS_RDX]);
 }
 
 static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
@@ -2326,18 +2326,18 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 	 *
 	 * Copy their values to the appropriate location if supplied.
 	 */
-	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
+	memset(vcpu->arch.private->regs, 0, sizeof(vcpu->arch.private->regs));
 
-	vcpu->arch.regs[VCPU_REGS_RAX] = ghcb_get_rax_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RBX] = ghcb_get_rbx_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RCX] = ghcb_get_rcx_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RDX] = ghcb_get_rdx_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RSI] = ghcb_get_rsi_if_valid(ghcb);
+	vcpu->arch.private->regs[VCPU_REGS_RAX] = ghcb_get_rax_if_valid(ghcb);
+	vcpu->arch.private->regs[VCPU_REGS_RBX] = ghcb_get_rbx_if_valid(ghcb);
+	vcpu->arch.private->regs[VCPU_REGS_RCX] = ghcb_get_rcx_if_valid(ghcb);
+	vcpu->arch.private->regs[VCPU_REGS_RDX] = ghcb_get_rdx_if_valid(ghcb);
+	vcpu->arch.private->regs[VCPU_REGS_RSI] = ghcb_get_rsi_if_valid(ghcb);
 
 	svm->vmcb->save.cpl = ghcb_get_cpl_if_valid(ghcb);
 
 	if (ghcb_xcr0_is_valid(ghcb)) {
-		vcpu->arch.xcr0 = ghcb_get_xcr0(ghcb);
+		vcpu->arch.private->xcr0 = ghcb_get_xcr0(ghcb);
 		kvm_update_cpuid_runtime(vcpu);
 	}
 
@@ -2667,8 +2667,8 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 					     GHCB_MSR_CPUID_FUNC_POS);
 
 		/* Initialize the registers needed by the CPUID intercept */
-		vcpu->arch.regs[VCPU_REGS_RAX] = cpuid_fn;
-		vcpu->arch.regs[VCPU_REGS_RCX] = 0;
+		vcpu->arch.private->regs[VCPU_REGS_RAX] = cpuid_fn;
+		vcpu->arch.private->regs[VCPU_REGS_RCX] = 0;
 
 		ret = svm_invoke_exit_handler(vcpu, SVM_EXIT_CPUID);
 		if (!ret) {
@@ -2680,13 +2680,13 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 					      GHCB_MSR_CPUID_REG_MASK,
 					      GHCB_MSR_CPUID_REG_POS);
 		if (cpuid_reg == 0)
-			cpuid_value = vcpu->arch.regs[VCPU_REGS_RAX];
+			cpuid_value = vcpu->arch.private->regs[VCPU_REGS_RAX];
 		else if (cpuid_reg == 1)
-			cpuid_value = vcpu->arch.regs[VCPU_REGS_RBX];
+			cpuid_value = vcpu->arch.private->regs[VCPU_REGS_RBX];
 		else if (cpuid_reg == 2)
-			cpuid_value = vcpu->arch.regs[VCPU_REGS_RCX];
+			cpuid_value = vcpu->arch.private->regs[VCPU_REGS_RCX];
 		else
-			cpuid_value = vcpu->arch.regs[VCPU_REGS_RDX];
+			cpuid_value = vcpu->arch.private->regs[VCPU_REGS_RDX];
 
 		set_ghcb_msr_bits(svm, cpuid_value,
 				  GHCB_MSR_CPUID_VALUE_MASK,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5151efa424ac..516af87e7ab1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1425,10 +1425,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 		/*
 		 * SEV-ES guests maintain an encrypted version of their FPU
 		 * state which is restored and saved on VMRUN and VMEXIT.
-		 * Mark vcpu->arch.guest_fpu->fpstate as scratch so it won't
+		 * Mark vcpu->arch.private->guest_fpu->fpstate as scratch so it won't
 		 * do xsave/xrstor on it.
 		 */
-		fpstate_set_confidential(&vcpu->arch.guest_fpu);
+		fpstate_set_confidential(&vcpu->arch.private->guest_fpu);
 	}
 
 	err = avic_init_vcpu(svm);
@@ -1599,7 +1599,7 @@ static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	switch (reg) {
 	case VCPU_EXREG_PDPTR:
 		BUG_ON(!npt_enabled);
-		load_pdptrs(vcpu, vcpu->arch.walk_mmu, kvm_read_cr3(vcpu));
+		load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, kvm_read_cr3(vcpu));
 		break;
 	default:
 		KVM_BUG_ON(1, vcpu->kvm);
@@ -1804,7 +1804,7 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 		}
 	}
 #endif
-	vcpu->arch.cr0 = cr0;
+	vcpu->arch.private->cr0 = cr0;
 
 	if (!npt_enabled)
 		hcr0 |= X86_CR0_PG | X86_CR0_WP;
@@ -1845,12 +1845,12 @@ static bool svm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 void svm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	unsigned long host_cr4_mce = cr4_read_shadow() & X86_CR4_MCE;
-	unsigned long old_cr4 = vcpu->arch.cr4;
+	unsigned long old_cr4 = vcpu->arch.private->cr4;
 
 	if (npt_enabled && ((old_cr4 ^ cr4) & X86_CR4_PGE))
 		svm_flush_tlb(vcpu);
 
-	vcpu->arch.cr4 = cr4;
+	vcpu->arch.private->cr4 = cr4;
 	if (!npt_enabled)
 		cr4 |= X86_CR4_PAE;
 	cr4 |= host_cr4_mce;
@@ -2239,7 +2239,7 @@ enum {
 /* Return NONE_SVM_INSTR if not SVM instrs, otherwise return decode result */
 static int svm_instr_opcode(struct kvm_vcpu *vcpu)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 
 	if (ctxt->b != 0x1 || ctxt->opcode_len != 2)
 		return NONE_SVM_INSTR;
@@ -2513,7 +2513,7 @@ static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 					    unsigned long val)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	unsigned long cr0 = vcpu->arch.cr0;
+	unsigned long cr0 = vcpu->arch.private->cr0;
 	bool ret = false;
 
 	if (!is_guest_mode(vcpu) ||
@@ -2585,7 +2585,7 @@ static int cr_interception(struct kvm_vcpu *vcpu)
 			val = kvm_read_cr0(vcpu);
 			break;
 		case 2:
-			val = vcpu->arch.cr2;
+			val = vcpu->arch.private->cr2;
 			break;
 		case 3:
 			val = kvm_read_cr3(vcpu);
@@ -3396,9 +3396,9 @@ static int handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!sev_es_guest(vcpu->kvm)) {
 		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
-			vcpu->arch.cr0 = svm->vmcb->save.cr0;
+			vcpu->arch.private->cr0 = svm->vmcb->save.cr0;
 		if (npt_enabled)
-			vcpu->arch.cr3 = svm->vmcb->save.cr3;
+			vcpu->arch.private->cr3 = svm->vmcb->save.cr3;
 	}
 
 	if (is_guest_mode(vcpu)) {
@@ -3828,7 +3828,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 		 * vmcb02 when switching vmcbs for nested virtualization.
 		 */
 		vmload(svm->vmcb01.pa);
-		__svm_vcpu_run(vmcb_pa, (unsigned long *)&vcpu->arch.regs);
+		__svm_vcpu_run(vmcb_pa, (unsigned long *)&vcpu->arch.private->regs);
 		vmsave(svm->vmcb01.pa);
 
 		vmload(__sme_page_pa(sd->save_area));
@@ -3843,9 +3843,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	trace_kvm_entry(vcpu);
 
-	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
-	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
-	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
+	svm->vmcb->save.rax = vcpu->arch.private->regs[VCPU_REGS_RAX];
+	svm->vmcb->save.rsp = vcpu->arch.private->regs[VCPU_REGS_RSP];
+	svm->vmcb->save.rip = vcpu->arch.private->regs[VCPU_REGS_RIP];
 
 	/*
 	 * Disable singlestep if we're injecting an interrupt/exception.
@@ -3871,7 +3871,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 		svm->vmcb->control.asid = svm->asid;
 		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	}
-	svm->vmcb->save.cr2 = vcpu->arch.cr2;
+	svm->vmcb->save.cr2 = vcpu->arch.private->cr2;
 
 	svm_hv_update_vp_id(svm->vmcb, vcpu);
 
@@ -3926,10 +3926,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 		x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	if (!sev_es_guest(vcpu->kvm)) {
-		vcpu->arch.cr2 = svm->vmcb->save.cr2;
-		vcpu->arch.regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
-		vcpu->arch.regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
-		vcpu->arch.regs[VCPU_REGS_RIP] = svm->vmcb->save.rip;
+		vcpu->arch.private->cr2 = svm->vmcb->save.cr2;
+		vcpu->arch.private->regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
+		vcpu->arch.private->regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
+		vcpu->arch.private->regs[VCPU_REGS_RIP] = svm->vmcb->save.rip;
 	}
 
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
@@ -3999,8 +3999,8 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		/* Loading L2's CR3 is handled by enter_svm_guest_mode.  */
 		if (!test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
 			return;
-		cr3 = vcpu->arch.cr3;
-	} else if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
+		cr3 = vcpu->arch.private->cr3;
+	} else if (vcpu->arch.private->mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
 		cr3 = __sme_set(root_hpa) | kvm_get_active_pcid(vcpu);
 	} else {
 		/* PCID in the guest should be impossible with a 32-bit MMU. */
@@ -4221,7 +4221,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 					INTERCEPT_SELECTIVE_CR0)))
 			break;
 
-		cr0 = vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
+		cr0 = vcpu->arch.private->cr0 & ~SVM_CR0_SELECTIVE_MASK;
 		val = info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
 
 		if (info->intercept == x86_intercept_lmsw) {
@@ -4358,9 +4358,9 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	/* FEE0h - SVM Guest VMCB Physical Address */
 	put_smstate(u64, smstate, 0x7ee0, svm->nested.vmcb12_gpa);
 
-	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
-	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
-	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
+	svm->vmcb->save.rax = vcpu->arch.private->regs[VCPU_REGS_RAX];
+	svm->vmcb->save.rsp = vcpu->arch.private->regs[VCPU_REGS_RSP];
+	svm->vmcb->save.rip = vcpu->arch.private->regs[VCPU_REGS_RIP];
 
 	ret = nested_svm_vmexit(svm);
 	if (ret)
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 953b0fcb21ee..2dc906dc9c13 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -791,13 +791,13 @@ TRACE_EVENT(kvm_emulate_insn,
 
 	TP_fast_assign(
 		__entry->csbase = static_call(kvm_x86_get_segment_base)(vcpu, VCPU_SREG_CS);
-		__entry->len = vcpu->arch.emulate_ctxt->fetch.ptr
-			       - vcpu->arch.emulate_ctxt->fetch.data;
-		__entry->rip = vcpu->arch.emulate_ctxt->_eip - __entry->len;
+		__entry->len = vcpu->arch.private->emulate_ctxt->fetch.ptr
+			       - vcpu->arch.private->emulate_ctxt->fetch.data;
+		__entry->rip = vcpu->arch.private->emulate_ctxt->_eip - __entry->len;
 		memcpy(__entry->insn,
-		       vcpu->arch.emulate_ctxt->fetch.data,
+		       vcpu->arch.private->emulate_ctxt->fetch.data,
 		       15);
-		__entry->flags = kei_decode_mode(vcpu->arch.emulate_ctxt->mode);
+		__entry->flags = kei_decode_mode(vcpu->arch.private->emulate_ctxt->mode);
 		__entry->failed = failed;
 		),
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0a0092e4102d..34b7621adf99 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -313,7 +313,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
 	vmx->nested.pi_desc = NULL;
 
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.private->guest_mmu, KVM_MMU_ROOTS_ALL);
 
 	nested_release_evmcs(vcpu);
 
@@ -356,11 +356,11 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 	WARN_ON_ONCE(!mmu_is_nested(vcpu));
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
-		cached_root = &vcpu->arch.mmu->prev_roots[i];
+		cached_root = &vcpu->arch.private->mmu->prev_roots[i];
 
 		if (nested_ept_root_matches(cached_root->hpa, cached_root->pgd,
 					    eptp))
-			vcpu->arch.mmu->invlpg(vcpu, addr, cached_root->hpa);
+			vcpu->arch.private->mmu->invlpg(vcpu, addr, cached_root->hpa);
 	}
 }
 
@@ -410,19 +410,19 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 {
 	WARN_ON(mmu_is_nested(vcpu));
 
-	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
+	vcpu->arch.private->mmu = &vcpu->arch.private->guest_mmu;
 	nested_ept_new_eptp(vcpu);
-	vcpu->arch.mmu->get_guest_pgd     = nested_ept_get_eptp;
-	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
-	vcpu->arch.mmu->get_pdptr         = kvm_pdptr_read;
+	vcpu->arch.private->mmu->get_guest_pgd     = nested_ept_get_eptp;
+	vcpu->arch.private->mmu->inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.private->mmu->get_pdptr         = kvm_pdptr_read;
 
-	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
+	vcpu->arch.private->walk_mmu              = &vcpu->arch.private->nested_mmu;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.private->mmu = &vcpu->arch.private->root_mmu;
+	vcpu->arch.private->walk_mmu = &vcpu->arch.private->root_mmu;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
@@ -456,7 +456,7 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
 		}
 		if (nested_vmx_is_page_fault_vmexit(vmcs12,
 						    vcpu->arch.exception.error_code)) {
-			*exit_qual = has_payload ? payload : vcpu->arch.cr2;
+			*exit_qual = has_payload ? payload : vcpu->arch.private->cr2;
 			return 1;
 		}
 	} else if (vmcs12->exception_bitmap & (1u << nr)) {
@@ -1103,7 +1103,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	 * must not be dereferenced.
 	 */
 	if (reload_pdptrs && !nested_ept && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))) {
+	    CC(!load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, cr3))) {
 		*entry_failure_code = ENTRY_FAIL_PDPTE;
 		return -EINVAL;
 	}
@@ -1111,7 +1111,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	if (!nested_ept)
 		kvm_mmu_new_pgd(vcpu, cr3);
 
-	vcpu->arch.cr3 = cr3;
+	vcpu->arch.private->cr3 = cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
 	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
@@ -2508,8 +2508,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * trap. Note that CR0.TS also needs updating - we do this later.
 	 */
 	vmx_update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
+	vcpu->arch.private->cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.private->cr0_guest_owned_bits);
 
 	if (vmx->nested.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT)) {
@@ -2595,7 +2595,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	}
 
 	if (!enable_ept)
-		vcpu->arch.walk_mmu->inject_page_fault = vmx_inject_page_fault_nested;
+		vcpu->arch.private->walk_mmu->inject_page_fault = vmx_inject_page_fault_nested;
 
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL) &&
 	    WARN_ON_ONCE(kvm_set_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
@@ -3070,7 +3070,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	vm_fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
+	vm_fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.private->regs,
 				 vmx->loaded_vmcs->launched);
 
 	if (vmx->msr_autoload.host.nr)
@@ -3153,7 +3153,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		 * the guest CR3 might be restored prior to setting the nested
 		 * state which can lead to a load of wrong PDPTRs.
 		 */
-		if (CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, vcpu->arch.cr3)))
+		if (CC(!load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, vcpu->arch.private->cr3)))
 			return false;
 	}
 
@@ -3370,18 +3370,18 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * i.e. a VM-Fail detected by hardware but not KVM, KVM must unwind its
 	 * software model to the pre-VMEntry host state.  When EPT is disabled,
 	 * GUEST_CR3 holds KVM's shadow CR3, not L1's "real" CR3, which causes
-	 * nested_vmx_restore_host_state() to corrupt vcpu->arch.cr3.  Stuffing
-	 * vmcs01.GUEST_CR3 results in the unwind naturally setting arch.cr3 to
+	 * nested_vmx_restore_host_state() to corrupt vcpu->arch.private->cr3.  Stuffing
+	 * vmcs01.GUEST_CR3 results in the unwind naturally setting arch.private->cr3 to
 	 * the correct value.  Smashing vmcs01.GUEST_CR3 is safe because nested
 	 * VM-Exits, and the unwind, reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is
 	 * guaranteed to be overwritten with a shadow CR3 prior to re-entering
 	 * L1.  Don't stuff vmcs01.GUEST_CR3 when using nested early checks as
-	 * KVM modifies vcpu->arch.cr3 if and only if the early hardware checks
+	 * KVM modifies vcpu->arch.private->cr3 if and only if the early hardware checks
 	 * pass, and early VM-Fails do not reset KVM's MMU, i.e. the VM-Fail
 	 * path would need to manually save/restore vmcs01.GUEST_CR3.
 	 */
 	if (!enable_ept && !nested_early_check)
-		vmcs_writel(GUEST_CR3, vcpu->arch.cr3);
+		vmcs_writel(GUEST_CR3, vcpu->arch.private->cr3);
 
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 
@@ -3655,20 +3655,20 @@ static inline unsigned long
 vmcs12_guest_cr0(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 {
 	return
-	/*1*/	(vmcs_readl(GUEST_CR0) & vcpu->arch.cr0_guest_owned_bits) |
+	/*1*/	(vmcs_readl(GUEST_CR0) & vcpu->arch.private->cr0_guest_owned_bits) |
 	/*2*/	(vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask) |
 	/*3*/	(vmcs_readl(CR0_READ_SHADOW) & ~(vmcs12->cr0_guest_host_mask |
-			vcpu->arch.cr0_guest_owned_bits));
+			vcpu->arch.private->cr0_guest_owned_bits));
 }
 
 static inline unsigned long
 vmcs12_guest_cr4(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 {
 	return
-	/*1*/	(vmcs_readl(GUEST_CR4) & vcpu->arch.cr4_guest_owned_bits) |
+	/*1*/	(vmcs_readl(GUEST_CR4) & vcpu->arch.private->cr4_guest_owned_bits) |
 	/*2*/	(vmcs12->guest_cr4 & vmcs12->cr4_guest_host_mask) |
 	/*3*/	(vmcs_readl(CR4_READ_SHADOW) & ~(vmcs12->cr4_guest_host_mask |
-			vcpu->arch.cr4_guest_owned_bits));
+			vcpu->arch.private->cr4_guest_owned_bits));
 }
 
 static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
@@ -4255,11 +4255,11 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	 * CR0_GUEST_HOST_MASK is already set in the original vmcs01
 	 * (KVM doesn't change it);
 	 */
-	vcpu->arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vcpu->arch.private->cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
 	vmx_set_cr0(vcpu, vmcs12->host_cr0);
 
 	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
-	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
+	vcpu->arch.private->cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs12->host_cr4);
 
 	nested_ept_uninit_mmu_context(vcpu);
@@ -4405,14 +4405,14 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 */
 	vmx_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
 
-	vcpu->arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vcpu->arch.private->cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
 	vmx_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
 
-	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
+	vcpu->arch.private->cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
 
 	nested_ept_uninit_mmu_context(vcpu);
-	vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
+	vcpu->arch.private->cr3 = vmcs_readl(GUEST_CR3);
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
 	/*
@@ -5000,7 +5000,7 @@ static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
 				  vmx->nested.current_vmptr >> PAGE_SHIFT,
 				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
 
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.private->guest_mmu, KVM_MMU_ROOTS_ALL);
 
 	vmx->nested.current_vmptr = INVALID_GPA;
 }
@@ -5427,7 +5427,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	 * Nested EPT roots are always held through guest_mmu,
 	 * not root_mmu.
 	 */
-	mmu = &vcpu->arch.guest_mmu;
+	mmu = &vcpu->arch.private->guest_mmu;
 
 	switch (type) {
 	case VMX_EPT_EXTENT_CONTEXT:
@@ -5545,7 +5545,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 * TODO: sync only the affected SPTEs for INVDIVIDUAL_ADDR.
 	 */
 	if (!enable_ept)
-		kvm_mmu_free_guest_mode_roots(vcpu, &vcpu->arch.root_mmu);
+		kvm_mmu_free_guest_mode_roots(vcpu, &vcpu->arch.private->root_mmu);
 
 	return nested_vmx_succeed(vcpu);
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6e1bb017b696..beba656116d7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2242,20 +2242,20 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 
 	switch (reg) {
 	case VCPU_REGS_RSP:
-		vcpu->arch.regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
+		vcpu->arch.private->regs[VCPU_REGS_RSP] = vmcs_readl(GUEST_RSP);
 		break;
 	case VCPU_REGS_RIP:
-		vcpu->arch.regs[VCPU_REGS_RIP] = vmcs_readl(GUEST_RIP);
+		vcpu->arch.private->regs[VCPU_REGS_RIP] = vmcs_readl(GUEST_RIP);
 		break;
 	case VCPU_EXREG_PDPTR:
 		if (enable_ept)
 			ept_save_pdptrs(vcpu);
 		break;
 	case VCPU_EXREG_CR0:
-		guest_owned_bits = vcpu->arch.cr0_guest_owned_bits;
+		guest_owned_bits = vcpu->arch.private->cr0_guest_owned_bits;
 
-		vcpu->arch.cr0 &= ~guest_owned_bits;
-		vcpu->arch.cr0 |= vmcs_readl(GUEST_CR0) & guest_owned_bits;
+		vcpu->arch.private->cr0 &= ~guest_owned_bits;
+		vcpu->arch.private->cr0 |= vmcs_readl(GUEST_CR0) & guest_owned_bits;
 		break;
 	case VCPU_EXREG_CR3:
 		/*
@@ -2263,13 +2263,13 @@ static void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 		 * CR3 is loaded into hardware, not the guest's CR3.
 		 */
 		if (!(exec_controls_get(to_vmx(vcpu)) & CPU_BASED_CR3_LOAD_EXITING))
-			vcpu->arch.cr3 = vmcs_readl(GUEST_CR3);
+			vcpu->arch.private->cr3 = vmcs_readl(GUEST_CR3);
 		break;
 	case VCPU_EXREG_CR4:
-		guest_owned_bits = vcpu->arch.cr4_guest_owned_bits;
+		guest_owned_bits = vcpu->arch.private->cr4_guest_owned_bits;
 
-		vcpu->arch.cr4 &= ~guest_owned_bits;
-		vcpu->arch.cr4 |= vmcs_readl(GUEST_CR4) & guest_owned_bits;
+		vcpu->arch.private->cr4 &= ~guest_owned_bits;
+		vcpu->arch.private->cr4 |= vmcs_readl(GUEST_CR4) & guest_owned_bits;
 		break;
 	default:
 		KVM_BUG_ON(1, vcpu->kvm);
@@ -2926,7 +2926,7 @@ static inline int vmx_get_current_vpid(struct kvm_vcpu *vcpu)
 
 static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	u64 root_hpa = mmu->root_hpa;
 
 	/* No flush required if the current context is invalid. */
@@ -2963,7 +2963,7 @@ static void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
 
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->walk_mmu;
 
 	if (!kvm_register_is_dirty(vcpu, VCPU_EXREG_PDPTR))
 		return;
@@ -2978,7 +2978,7 @@ void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu)
 
 void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->walk_mmu;
 
 	if (WARN_ON_ONCE(!is_pae_paging(vcpu)))
 		return;
@@ -3019,7 +3019,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
-	vcpu->arch.cr0 = cr0;
+	vcpu->arch.private->cr0 = cr0;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR0);
 
 #ifdef CONFIG_X86_64
@@ -3067,12 +3067,12 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 			exec_controls_set(vmx, tmp);
 		}
 
-		/* Note, vmx_set_cr4() consumes the new vcpu->arch.cr0. */
+		/* Note, vmx_set_cr4() consumes the new vcpu->arch.private->cr0. */
 		if ((old_cr0_pg ^ cr0) & X86_CR0_PG)
 			vmx_set_cr4(vcpu, kvm_read_cr4(vcpu));
 	}
 
-	/* depends on vcpu->arch.cr0 to be set to a new value */
+	/* depends on vcpu->arch.private->cr0 to be set to a new value */
 	vmx->emulation_required = vmx_emulation_required(vcpu);
 }
 
@@ -3114,7 +3114,7 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		if (!enable_unrestricted_guest && !is_paging(vcpu))
 			guest_cr3 = to_kvm_vmx(kvm)->ept_identity_map_addr;
 		else if (test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
-			guest_cr3 = vcpu->arch.cr3;
+			guest_cr3 = vcpu->arch.private->cr3;
 		else /* vmcs01.GUEST_CR3 is already up-to-date. */
 			update_guest_cr3 = false;
 		vmx_ept_load_pdptrs(vcpu);
@@ -3144,7 +3144,7 @@ static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
-	unsigned long old_cr4 = vcpu->arch.cr4;
+	unsigned long old_cr4 = vcpu->arch.private->cr4;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	/*
 	 * Pass through host's Machine Check Enable value to hw_cr4, which
@@ -3171,7 +3171,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		}
 	}
 
-	vcpu->arch.cr4 = cr4;
+	vcpu->arch.private->cr4 = cr4;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
 
 	if (!is_unrestricted_guest(vcpu)) {
@@ -4040,14 +4040,14 @@ void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
 {
 	struct kvm_vcpu *vcpu = &vmx->vcpu;
 
-	vcpu->arch.cr4_guest_owned_bits = KVM_POSSIBLE_CR4_GUEST_BITS &
-					  ~vcpu->arch.cr4_guest_rsvd_bits;
+	vcpu->arch.private->cr4_guest_owned_bits = KVM_POSSIBLE_CR4_GUEST_BITS &
+					  ~vcpu->arch.private->cr4_guest_rsvd_bits;
 	if (!enable_ept)
-		vcpu->arch.cr4_guest_owned_bits &= ~X86_CR4_PGE;
+		vcpu->arch.private->cr4_guest_owned_bits &= ~X86_CR4_PGE;
 	if (is_guest_mode(&vmx->vcpu))
-		vcpu->arch.cr4_guest_owned_bits &=
+		vcpu->arch.private->cr4_guest_owned_bits &=
 			~get_vmcs12(vcpu)->cr4_guest_host_mask;
-	vmcs_writel(CR4_GUEST_HOST_MASK, ~vcpu->arch.cr4_guest_owned_bits);
+	vmcs_writel(CR4_GUEST_HOST_MASK, ~vcpu->arch.private->cr4_guest_owned_bits);
 }
 
 static u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
@@ -4345,8 +4345,8 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_vmentry_ctrl());
 
-	vmx->vcpu.arch.cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.cr0_guest_owned_bits);
+	vmx->vcpu.arch.private->cr0_guest_owned_bits = KVM_POSSIBLE_CR0_GUEST_BITS;
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~vmx->vcpu.arch.private->cr0_guest_owned_bits);
 
 	set_cr4_guest_host_mask(vmx);
 
@@ -4956,7 +4956,7 @@ static int handle_set_cr4(struct kvm_vcpu *vcpu, unsigned long val)
 
 static int handle_desc(struct kvm_vcpu *vcpu)
 {
-	WARN_ON(!(vcpu->arch.cr4 & X86_CR4_UMIP));
+	WARN_ON(!(vcpu->arch.private->cr4 & X86_CR4_UMIP));
 	return kvm_emulate_instruction(vcpu, 0);
 }
 
@@ -6626,13 +6626,13 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 		vmx->loaded_vmcs->host_state.cr3 = cr3;
 	}
 
-	if (vcpu->arch.cr2 != native_read_cr2())
-		native_write_cr2(vcpu->arch.cr2);
+	if (vcpu->arch.private->cr2 != native_read_cr2())
+		native_write_cr2(vcpu->arch.private->cr2);
 
-	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
+	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.private->regs,
 				   vmx->loaded_vmcs->launched);
 
-	vcpu->arch.cr2 = native_read_cr2();
+	vcpu->arch.private->cr2 = native_read_cr2();
 
 	VM_WARN_ON_ONCE(vcpu->kvm->asi && !is_asi_active());
 	asi_set_target_unrestricted();
@@ -6681,9 +6681,9 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	WARN_ON_ONCE(vmx->nested.need_vmcs12_to_shadow_sync);
 
 	if (kvm_register_is_dirty(vcpu, VCPU_REGS_RSP))
-		vmcs_writel(GUEST_RSP, vcpu->arch.regs[VCPU_REGS_RSP]);
+		vmcs_writel(GUEST_RSP, vcpu->arch.private->regs[VCPU_REGS_RSP]);
 	if (kvm_register_is_dirty(vcpu, VCPU_REGS_RIP))
-		vmcs_writel(GUEST_RIP, vcpu->arch.regs[VCPU_REGS_RIP]);
+		vmcs_writel(GUEST_RIP, vcpu->arch.private->regs[VCPU_REGS_RIP]);
 
 	cr4 = cr4_read_shadow();
 	if (unlikely(cr4 != vmx->loaded_vmcs->host_state.cr4)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dd862edc1b5a..680725089a18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -595,7 +595,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu)
 		vcpu->arch.dr6 &= ~BIT(12);
 		break;
 	case PF_VECTOR:
-		vcpu->arch.cr2 = payload;
+		vcpu->arch.private->cr2 = payload;
 		break;
 	}
 
@@ -736,8 +736,8 @@ bool kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 	struct kvm_mmu *fault_mmu;
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
-	fault_mmu = fault->nested_page_fault ? vcpu->arch.mmu :
-					       vcpu->arch.walk_mmu;
+	fault_mmu = fault->nested_page_fault ? vcpu->arch.private->mmu :
+					       vcpu->arch.private->walk_mmu;
 
 	/*
 	 * Invalidate the TLB entry for the faulting address, if it exists,
@@ -892,7 +892,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 #endif
 	if (!(vcpu->arch.efer & EFER_LME) && (cr0 & X86_CR0_PG) &&
 	    is_pae(vcpu) && ((cr0 ^ old_cr0) & pdptr_bits) &&
-	    !load_pdptrs(vcpu, vcpu->arch.walk_mmu, kvm_read_cr3(vcpu)))
+	    !load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, kvm_read_cr3(vcpu)))
 		return 1;
 
 	if (!(cr0 & X86_CR0_PG) &&
@@ -920,8 +920,8 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 
 	if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE)) {
 
-		if (vcpu->arch.xcr0 != host_xcr0)
-			xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);
+		if (vcpu->arch.private->xcr0 != host_xcr0)
+			xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.private->xcr0);
 
 		if (vcpu->arch.xsaves_enabled &&
 		    vcpu->arch.ia32_xss != host_xss)
@@ -930,7 +930,7 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    (kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
-	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU)) &&
+	     (vcpu->arch.private->xcr0 & XFEATURE_MASK_PKRU)) &&
 	    vcpu->arch.pkru != vcpu->arch.host_pkru)
 		write_pkru(vcpu->arch.pkru);
 }
@@ -943,7 +943,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    (kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
-	     (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU))) {
+	     (vcpu->arch.private->xcr0 & XFEATURE_MASK_PKRU))) {
 		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vcpu->arch.host_pkru)
 			write_pkru(vcpu->arch.host_pkru);
@@ -951,7 +951,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 
 	if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE)) {
 
-		if (vcpu->arch.xcr0 != host_xcr0)
+		if (vcpu->arch.private->xcr0 != host_xcr0)
 			xsetbv(XCR_XFEATURE_ENABLED_MASK, host_xcr0);
 
 		if (vcpu->arch.xsaves_enabled &&
@@ -965,7 +965,7 @@ EXPORT_SYMBOL_GPL(kvm_load_host_xsave_state);
 static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 {
 	u64 xcr0 = xcr;
-	u64 old_xcr0 = vcpu->arch.xcr0;
+	u64 old_xcr0 = vcpu->arch.private->xcr0;
 	u64 valid_bits;
 
 	/* Only support XCR_XFEATURE_ENABLED_MASK(xcr0) now  */
@@ -981,7 +981,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 	 * saving.  However, xcr0 bit 0 is always set, even if the
 	 * emulated CPU does not support XSAVE (see kvm_vcpu_reset()).
 	 */
-	valid_bits = vcpu->arch.guest_supported_xcr0 | XFEATURE_MASK_FP;
+	valid_bits = vcpu->arch.private->guest_supported_xcr0 | XFEATURE_MASK_FP;
 	if (xcr0 & ~valid_bits)
 		return 1;
 
@@ -995,7 +995,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
 			return 1;
 	}
-	vcpu->arch.xcr0 = xcr0;
+	vcpu->arch.private->xcr0 = xcr0;
 
 	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
 		kvm_update_cpuid_runtime(vcpu);
@@ -1019,7 +1019,7 @@ bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	if (cr4 & cr4_reserved_bits)
 		return false;
 
-	if (cr4 & vcpu->arch.cr4_guest_rsvd_bits)
+	if (cr4 & vcpu->arch.private->cr4_guest_rsvd_bits)
 		return false;
 
 	return static_call(kvm_x86_is_valid_cr4)(vcpu, cr4);
@@ -1069,7 +1069,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	} else if (is_paging(vcpu) && (cr4 & X86_CR4_PAE)
 		   && ((cr4 ^ old_cr4) & pdptr_bits)
-		   && !load_pdptrs(vcpu, vcpu->arch.walk_mmu,
+		   && !load_pdptrs(vcpu, vcpu->arch.private->walk_mmu,
 				   kvm_read_cr3(vcpu)))
 		return 1;
 
@@ -1092,7 +1092,7 @@ EXPORT_SYMBOL_GPL(kvm_set_cr4);
 
 static void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *mmu = vcpu->arch.private->mmu;
 	unsigned long roots_to_free = 0;
 	int i;
 
@@ -1159,13 +1159,13 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	if (kvm_vcpu_is_illegal_gpa(vcpu, cr3))
 		return 1;
 
-	if (is_pae_paging(vcpu) && !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
+	if (is_pae_paging(vcpu) && !load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, cr3))
 		return 1;
 
 	if (cr3 != kvm_read_cr3(vcpu))
 		kvm_mmu_new_pgd(vcpu, cr3);
 
-	vcpu->arch.cr3 = cr3;
+	vcpu->arch.private->cr3 = cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
 handle_tlb_flush:
@@ -1190,7 +1190,7 @@ int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
 	if (lapic_in_kernel(vcpu))
 		kvm_lapic_set_tpr(vcpu, cr8);
 	else
-		vcpu->arch.cr8 = cr8;
+		vcpu->arch.private->cr8 = cr8;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kvm_set_cr8);
@@ -1200,7 +1200,7 @@ unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu)
 	if (lapic_in_kernel(vcpu))
 		return kvm_lapic_get_cr8(vcpu);
 	else
-		return vcpu->arch.cr8;
+		return vcpu->arch.private->cr8;
 }
 EXPORT_SYMBOL_GPL(kvm_get_cr8);
 
@@ -4849,10 +4849,10 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
 					 struct kvm_xsave *guest_xsave)
 {
-	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
+	if (fpstate_is_confidential(&vcpu->arch.private->guest_fpu))
 		return;
 
-	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu,
+	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.private->guest_fpu,
 				       guest_xsave->region,
 				       sizeof(guest_xsave->region),
 				       vcpu->arch.pkru);
@@ -4861,10 +4861,10 @@ static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
 static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
-	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
+	if (fpstate_is_confidential(&vcpu->arch.private->guest_fpu))
 		return 0;
 
-	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
+	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.private->guest_fpu,
 					      guest_xsave->region,
 					      supported_xcr0, &vcpu->arch.pkru);
 }
@@ -4880,7 +4880,7 @@ static void kvm_vcpu_ioctl_x86_get_xcrs(struct kvm_vcpu *vcpu,
 	guest_xcrs->nr_xcrs = 1;
 	guest_xcrs->flags = 0;
 	guest_xcrs->xcrs[0].xcr = XCR_XFEATURE_ENABLED_MASK;
-	guest_xcrs->xcrs[0].value = vcpu->arch.xcr0;
+	guest_xcrs->xcrs[0].value = vcpu->arch.private->xcr0;
 }
 
 static int kvm_vcpu_ioctl_x86_set_xcrs(struct kvm_vcpu *vcpu,
@@ -6516,7 +6516,7 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 
 	/* NPT walks are always user-walks */
 	access |= PFERR_USER_MASK;
-	t_gpa  = vcpu->arch.mmu->gva_to_gpa(vcpu, gpa, access, exception);
+	t_gpa  = vcpu->arch.private->mmu->gva_to_gpa(vcpu, gpa, access, exception);
 
 	return t_gpa;
 }
@@ -6525,7 +6525,7 @@ gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
 	u32 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
-	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
+	return vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_read);
 
@@ -6534,7 +6534,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_read);
 {
 	u32 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_FETCH_MASK;
-	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
+	return vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
 
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
@@ -6542,7 +6542,7 @@ gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 {
 	u32 access = (static_call(kvm_x86_get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
-	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
+	return vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_write);
 
@@ -6550,7 +6550,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	return vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, 0, exception);
+	return vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, gva, 0, exception);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -6561,7 +6561,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = vcpu->arch.walk_mmu->gva_to_gpa(vcpu, addr, access,
+		gpa_t gpa = vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, addr, access,
 							    exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
@@ -6595,7 +6595,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 	int ret;
 
 	/* Inline kvm_read_guest_virt_helper for speed.  */
-	gpa_t gpa = vcpu->arch.walk_mmu->gva_to_gpa(vcpu, addr, access|PFERR_FETCH_MASK,
+	gpa_t gpa = vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, addr, access|PFERR_FETCH_MASK,
 						    exception);
 	if (unlikely(gpa == UNMAPPED_GVA))
 		return X86EMUL_PROPAGATE_FAULT;
@@ -6659,7 +6659,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa =  vcpu->arch.walk_mmu->gva_to_gpa(vcpu, addr,
+		gpa_t gpa =  vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, addr,
 							     access,
 							     exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
@@ -6757,7 +6757,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 	 * shadow page table for L2 guest.
 	 */
 	if (vcpu_match_mmio_gva(vcpu, gva) && (!is_paging(vcpu) ||
-	    !permission_fault(vcpu, vcpu->arch.walk_mmu,
+	    !permission_fault(vcpu, vcpu->arch.private->walk_mmu,
 			      vcpu->arch.mmio_access, 0, access))) {
 		*gpa = vcpu->arch.mmio_gfn << PAGE_SHIFT |
 					(gva & (PAGE_SIZE - 1));
@@ -6765,7 +6765,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
+	*gpa = vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, gva, access, exception);
 
 	if (*gpa == UNMAPPED_GVA)
 		return -1;
@@ -6867,7 +6867,7 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	int handled, ret;
 	bool write = ops->write;
 	struct kvm_mmio_fragment *frag;
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 
 	/*
 	 * If the exit was due to a NPF we may already have a GPA.
@@ -7246,7 +7246,7 @@ static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
 		value = kvm_read_cr0(vcpu);
 		break;
 	case 2:
-		value = vcpu->arch.cr2;
+		value = vcpu->arch.private->cr2;
 		break;
 	case 3:
 		value = kvm_read_cr3(vcpu);
@@ -7275,7 +7275,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 		res = kvm_set_cr0(vcpu, mk_cr_64(kvm_read_cr0(vcpu), val));
 		break;
 	case 2:
-		vcpu->arch.cr2 = val;
+		vcpu->arch.private->cr2 = val;
 		break;
 	case 3:
 		res = kvm_set_cr3(vcpu, val);
@@ -7597,7 +7597,7 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 
 static bool inject_emulated_exception(struct kvm_vcpu *vcpu)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 	if (ctxt->exception.vector == PF_VECTOR)
 		return kvm_inject_emulated_page_fault(vcpu, &ctxt->exception);
 
@@ -7621,14 +7621,14 @@ static struct x86_emulate_ctxt *alloc_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	ctxt->vcpu = vcpu;
 	ctxt->ops = &emulate_ops;
-	vcpu->arch.emulate_ctxt = ctxt;
+	vcpu->arch.private->emulate_ctxt = ctxt;
 
 	return ctxt;
 }
 
 static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 	int cs_db, cs_l;
 
 	static_call(kvm_x86_get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
@@ -7658,7 +7658,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 	int ret;
 
 	init_emulate_ctxt(vcpu);
@@ -7731,7 +7731,7 @@ static void prepare_emulation_failure_exit(struct kvm_vcpu *vcpu, u64 *data,
 
 static void prepare_emulation_ctxt_failure_exit(struct kvm_vcpu *vcpu)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 
 	prepare_emulation_failure_exit(vcpu, NULL, 0, ctxt->fetch.data,
 				       ctxt->fetch.end - ctxt->fetch.data);
@@ -7792,7 +7792,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	    WARN_ON_ONCE(!(emulation_type & EMULTYPE_PF)))
 		return false;
 
-	if (!vcpu->arch.mmu->direct_map) {
+	if (!vcpu->arch.private->mmu->direct_map) {
 		/*
 		 * Write permission should be allowed since only
 		 * write access need to be emulated.
@@ -7825,7 +7825,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	kvm_release_pfn_clean(pfn);
 
 	/* The instructions are well-emulated on direct mmu. */
-	if (vcpu->arch.mmu->direct_map) {
+	if (vcpu->arch.private->mmu->direct_map) {
 		unsigned int indirect_shadow_pages;
 
 		write_lock(&vcpu->kvm->mmu_lock);
@@ -7893,7 +7893,7 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
 	vcpu->arch.last_retry_eip = ctxt->eip;
 	vcpu->arch.last_retry_addr = cr2_or_gpa;
 
-	if (!vcpu->arch.mmu->direct_map)
+	if (!vcpu->arch.private->mmu->direct_map)
 		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
 
 	kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
@@ -8055,7 +8055,7 @@ int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 				    void *insn, int insn_len)
 {
 	int r = EMULATION_OK;
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 
 	init_emulate_ctxt(vcpu);
 
@@ -8081,7 +8081,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len)
 {
 	int r;
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 	bool writeback = true;
 	bool write_fault_to_spt;
 
@@ -8160,7 +8160,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		ctxt->exception.address = cr2_or_gpa;
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
-		if (vcpu->arch.mmu->direct_map) {
+		if (vcpu->arch.private->mmu->direct_map) {
 			ctxt->gpa_available = true;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
@@ -9484,9 +9484,9 @@ static void enter_smm(struct kvm_vcpu *vcpu)
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0x8000);
 
-	cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
+	cr0 = vcpu->arch.private->cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
 	static_call(kvm_x86_set_cr0)(vcpu, cr0);
-	vcpu->arch.cr0 = cr0;
+	vcpu->arch.private->cr0 = cr0;
 
 	static_call(kvm_x86_set_cr4)(vcpu, 0);
 
@@ -10245,14 +10245,14 @@ static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 	 * Exclude PKRU from restore as restored separately in
 	 * kvm_x86_ops.run().
 	 */
-	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
+	fpu_swap_kvm_fpstate(&vcpu->arch.private->guest_fpu, true);
 	trace_kvm_fpu(1);
 }
 
 /* When vcpu_run ends, restore user space FPU context. */
 static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
-	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
+	fpu_swap_kvm_fpstate(&vcpu->arch.private->guest_fpu, false);
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
 }
@@ -10342,7 +10342,7 @@ static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 		 * that usually, but some bad designed PV devices (vmware
 		 * backdoor interface) need this to work
 		 */
-		emulator_writeback_register_cache(vcpu->arch.emulate_ctxt);
+		emulator_writeback_register_cache(vcpu->arch.private->emulate_ctxt);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 	}
 	regs->rax = kvm_rax_read(vcpu);
@@ -10450,7 +10450,7 @@ static void __get_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->gdt.limit = dt.size;
 	sregs->gdt.base = dt.address;
 
-	sregs->cr2 = vcpu->arch.cr2;
+	sregs->cr2 = vcpu->arch.private->cr2;
 	sregs->cr3 = kvm_read_cr3(vcpu);
 
 skip_protected_regs:
@@ -10563,7 +10563,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.private->emulate_ctxt;
 	int ret;
 
 	init_emulate_ctxt(vcpu);
@@ -10632,9 +10632,9 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	dt.address = sregs->gdt.base;
 	static_call(kvm_x86_set_gdt)(vcpu, &dt);
 
-	vcpu->arch.cr2 = sregs->cr2;
+	vcpu->arch.private->cr2 = sregs->cr2;
 	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
-	vcpu->arch.cr3 = sregs->cr3;
+	vcpu->arch.private->cr3 = sregs->cr3;
 	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
 
 	kvm_set_cr8(vcpu, sregs->cr8);
@@ -10644,7 +10644,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 
 	*mmu_reset_needed |= kvm_read_cr0(vcpu) != sregs->cr0;
 	static_call(kvm_x86_set_cr0)(vcpu, sregs->cr0);
-	vcpu->arch.cr0 = sregs->cr0;
+	vcpu->arch.private->cr0 = sregs->cr0;
 
 	*mmu_reset_needed |= kvm_read_cr4(vcpu) != sregs->cr4;
 	static_call(kvm_x86_set_cr4)(vcpu, sregs->cr4);
@@ -10652,7 +10652,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	if (update_pdptrs) {
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		if (is_pae_paging(vcpu)) {
-			load_pdptrs(vcpu, vcpu->arch.walk_mmu, kvm_read_cr3(vcpu));
+			load_pdptrs(vcpu, vcpu->arch.private->walk_mmu, kvm_read_cr3(vcpu));
 			*mmu_reset_needed = 1;
 		}
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
@@ -10853,12 +10853,12 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	struct fxregs_state *fxsave;
 
-	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
+	if (fpstate_is_confidential(&vcpu->arch.private->guest_fpu))
 		return 0;
 
 	vcpu_load(vcpu);
 
-	fxsave = &vcpu->arch.guest_fpu.fpstate->regs.fxsave;
+	fxsave = &vcpu->arch.private->guest_fpu.fpstate->regs.fxsave;
 	memcpy(fpu->fpr, fxsave->st_space, 128);
 	fpu->fcw = fxsave->cwd;
 	fpu->fsw = fxsave->swd;
@@ -10876,12 +10876,12 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	struct fxregs_state *fxsave;
 
-	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
+	if (fpstate_is_confidential(&vcpu->arch.private->guest_fpu))
 		return 0;
 
 	vcpu_load(vcpu);
 
-	fxsave = &vcpu->arch.guest_fpu.fpstate->regs.fxsave;
+	fxsave = &vcpu->arch.private->guest_fpu.fpstate->regs.fxsave;
 
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
@@ -10988,7 +10988,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (!alloc_emulate_ctxt(vcpu))
 		goto free_wbinvd_dirty_mask;
 
-	if (!fpu_alloc_guest_fpstate(&vcpu->arch.guest_fpu)) {
+	if (!fpu_alloc_guest_fpstate(&vcpu->arch.private->guest_fpu)) {
 		pr_err("kvm: failed to allocate vcpu's fpu\n");
 		goto free_emulate_ctxt;
 	}
@@ -11023,9 +11023,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	return 0;
 
 free_guest_fpu:
-	fpu_free_guest_fpstate(&vcpu->arch.guest_fpu);
+	fpu_free_guest_fpstate(&vcpu->arch.private->guest_fpu);
 free_emulate_ctxt:
-	kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);
+	kmem_cache_free(x86_emulator_cache, vcpu->arch.private->emulate_ctxt);
 free_wbinvd_dirty_mask:
 	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
 fail_free_mce_banks:
@@ -11067,9 +11067,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 	static_call(kvm_x86_vcpu_free)(vcpu);
 
-	kmem_cache_free(x86_emulator_cache, vcpu->arch.emulate_ctxt);
+	kmem_cache_free(x86_emulator_cache, vcpu->arch.private->emulate_ctxt);
 	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
-	fpu_free_guest_fpstate(&vcpu->arch.guest_fpu);
+	fpu_free_guest_fpstate(&vcpu->arch.private->guest_fpu);
 
 	kvm_hv_vcpu_uninit(vcpu);
 	kvm_pmu_destroy(vcpu);
@@ -11118,7 +11118,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.dr7 = DR7_FIXED_1;
 	kvm_update_dr7(vcpu);
 
-	vcpu->arch.cr2 = 0;
+	vcpu->arch.private->cr2 = 0;
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	vcpu->arch.apf.msr_en_val = 0;
@@ -11131,8 +11131,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_async_pf_hash_reset(vcpu);
 	vcpu->arch.apf.halted = false;
 
-	if (vcpu->arch.guest_fpu.fpstate && kvm_mpx_supported()) {
-		struct fpstate *fpstate = vcpu->arch.guest_fpu.fpstate;
+	if (vcpu->arch.private->guest_fpu.fpstate && kvm_mpx_supported()) {
+		struct fpstate *fpstate = vcpu->arch.private->guest_fpu.fpstate;
 
 		/*
 		 * To avoid have the INIT path from kvm_apic_has_events() that be
@@ -11154,11 +11154,11 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 		vcpu->arch.msr_misc_features_enables = 0;
 
-		vcpu->arch.xcr0 = XFEATURE_MASK_FP;
+		vcpu->arch.private->xcr0 = XFEATURE_MASK_FP;
 	}
 
 	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
-	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
+	memset(vcpu->arch.private->regs, 0, sizeof(vcpu->arch.private->regs));
 	kvm_register_mark_dirty(vcpu, VCPU_REGS_RSP);
 
 	/*
@@ -11178,7 +11178,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0xfff0);
 
-	vcpu->arch.cr3 = 0;
+	vcpu->arch.private->cr3 = 0;
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
 
 	/*
@@ -12043,7 +12043,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 {
 	int r;
 
-	if ((vcpu->arch.mmu->direct_map != work->arch.direct_map) ||
+	if ((vcpu->arch.private->mmu->direct_map != work->arch.direct_map) ||
 	      work->wakeup_all)
 		return;
 
@@ -12051,8 +12051,8 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	if (unlikely(r))
 		return;
 
-	if (!vcpu->arch.mmu->direct_map &&
-	      work->arch.cr3 != vcpu->arch.mmu->get_guest_pgd(vcpu))
+	if (!vcpu->arch.private->mmu->direct_map &&
+	      work->arch.cr3 != vcpu->arch.private->mmu->get_guest_pgd(vcpu))
 		return;
 
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
@@ -12398,9 +12398,9 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, &fault) != UNMAPPED_GVA) {
+	    vcpu->arch.private->walk_mmu->gva_to_gpa(vcpu, gva, access, &fault) != UNMAPPED_GVA) {
 		/*
-		 * If vcpu->arch.walk_mmu->gva_to_gpa succeeded, the page
+		 * If vcpu->arch.private->walk_mmu->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
 		 * with the error code that the processor gave.
 		 */
@@ -12410,7 +12410,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.nested_page_fault = false;
 		fault.address = gva;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault);
+	vcpu->arch.private->walk_mmu->inject_page_fault(vcpu, &fault);
 }
 EXPORT_SYMBOL_GPL(kvm_fixup_and_inject_pf_error);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 3d5da4daaf53..dbcb6551d111 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -183,7 +183,7 @@ static inline bool x86_exception_has_error_code(unsigned int vector)
 
 static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
+	return vcpu->arch.private->walk_mmu == &vcpu->arch.private->nested_mmu;
 }
 
 static inline int is_pae(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 587a75428da8..3c4e27c5aea9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -109,6 +109,8 @@ static atomic_t hardware_enable_failed;
 
 static struct kmem_cache *kvm_vcpu_cache;
 
+static struct kmem_cache *kvm_vcpu_private_cache;
+
 static __read_mostly struct preempt_ops kvm_preempt_ops;
 static DEFINE_PER_CPU_ASI_NOT_SENSITIVE(struct kvm_vcpu *, kvm_running_vcpu);
 
@@ -457,6 +459,7 @@ void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	put_pid(rcu_dereference_protected(vcpu->pid, 1));
 
 	free_page((unsigned long)vcpu->run);
+	kmem_cache_free(kvm_vcpu_private_cache, vcpu->arch.private);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_destroy);
@@ -2392,7 +2395,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	 * tail pages of non-compound higher order allocations, which
 	 * would then underflow the refcount when the caller does the
 	 * required put_page. Don't allow those pages here.
-	 */ 
+	 */
 	if (!kvm_try_get_pfn(pfn))
 		r = -EFAULT;
 
@@ -3562,17 +3565,25 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	if (r)
 		goto vcpu_decrement;
 
-	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
+	vcpu = kmem_cache_zalloc(kvm_vcpu_cache,
+                                 GFP_KERNEL_ACCOUNT | __GFP_GLOBAL_NONSENSITIVE);
 	if (!vcpu) {
 		r = -ENOMEM;
 		goto vcpu_decrement;
 	}
 
+        vcpu->arch.private = kmem_cache_zalloc(kvm_vcpu_private_cache,
+                                               GFP_KERNEL | __GFP_LOCAL_NONSENSITIVE);
+        if (!vcpu->arch.private) {
+                r = -ENOMEM;
+                goto vcpu_free;
+        }
+
 	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_LOCAL_NONSENSITIVE);
 	if (!page) {
 		r = -ENOMEM;
-		goto vcpu_free;
+		goto vcpu_private_free;
 	}
 	vcpu->run = page_address(page);
 
@@ -3631,6 +3642,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	kvm_arch_vcpu_destroy(vcpu);
 vcpu_free_run_page:
 	free_page((unsigned long)vcpu->run);
+vcpu_private_free:
+	kmem_cache_free(kvm_vcpu_private_cache, vcpu->arch.private);
 vcpu_free:
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 vcpu_decrement:
@@ -5492,7 +5505,7 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		vcpu_align = __alignof__(struct kvm_vcpu);
 	kvm_vcpu_cache =
 		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
-					   SLAB_ACCOUNT,
+					   SLAB_ACCOUNT|SLAB_GLOBAL_NONSENSITIVE,
 					   offsetof(struct kvm_vcpu, arch),
 					   offsetofend(struct kvm_vcpu, stats_id)
 					   - offsetof(struct kvm_vcpu, arch),
@@ -5501,12 +5514,22 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		r = -ENOMEM;
 		goto out_free_3;
 	}
-
+        kvm_vcpu_private_cache = kmem_cache_create_usercopy("kvm_vcpu_private",
+                                   sizeof(struct kvm_vcpu_arch_private),
+                                   __alignof__(struct kvm_vcpu_arch_private),
+                                   SLAB_ACCOUNT | SLAB_LOCAL_NONSENSITIVE,
+                                   0,
+                                   sizeof(struct kvm_vcpu_arch_private),
+                                   NULL);
+	if (!kvm_vcpu_private_cache) {
+	       r = -ENOMEM;
+	       goto out_free_4;
+	}
 	for_each_possible_cpu(cpu) {
 		if (!alloc_cpumask_var_node(&per_cpu(cpu_kick_mask, cpu),
 					    GFP_KERNEL, cpu_to_node(cpu))) {
 			r = -ENOMEM;
-			goto out_free_4;
+			goto out_free_vcpu_private_cache;
 		}
 	}
 
@@ -5541,6 +5564,8 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 out_free_5:
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
+out_free_vcpu_private_cache:
+	kmem_cache_destroy(kvm_vcpu_private_cache);
 out_free_4:
 	kmem_cache_destroy(kvm_vcpu_cache);
 out_free_3:
@@ -5567,6 +5592,7 @@ void kvm_exit(void)
 	misc_deregister(&kvm_dev);
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
+	kmem_cache_destroy(kvm_vcpu_private_cache);
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_async_pf_deinit();
 	unregister_syscore_ops(&kvm_syscore_ops);
-- 
2.35.1.473.g83b2b277ed-goog

