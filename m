Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85255229E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiEKC3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiEKC3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D2219C16
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236179; x=1683772179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WwIk/yoRfzkNhlZBUapCzd0ECs+rZYsn0Cy66q5a7cU=;
  b=OgueJi33LS/2KVInJQ2H0Sxz1pu/uqMKgXYRtqZSFso9Rgt6YVtJSoqB
   h/NS3crHyaWq/5YqwMIVhPoM95eXNhJ2805lm6SM8SlMeVRTYxfB2hV2Q
   AVlinCHKcqjs/0bYoZJAQOL0yXG8aIurfnIzsaEQkY6HmATsVgX+rzd8D
   jF+WvbtxTSUsnyGWxgXnoRGS2ZdDFJ4VNr+5z5ZreWHuVlTu0i1u+eUTL
   Qo2i2ulHraZen4pSQmPws2dXvN4hlr0B7i1ROi6IgY/pNX7ZIDi5Kk45a
   ektf/hxJF0kEt/OigbdoqMtFdoyOaEg4TevQbXZRuNQL2soQWe4hJQp6n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250093466"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="250093466"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="657937556"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2022 19:29:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 12C4281; Wed, 11 May 2022 05:28:01 +0300 (EEST)
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
Subject: [PATCH] x86: Implement Linear Address Masking support
Date:   Wed, 11 May 2022 05:27:41 +0300
Message-Id: <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
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

Linear Address Masking feature makes CPU ignore some bits of the virtual
address. These bits can be used to encode metadata.

The feature is enumerated with CPUID.(EAX=07H, ECX=01H):EAX.LAM[bit 26].

CR3.LAM_U57[bit 62] allows to encode 6 bits of metadata in bits 62:57 of
user pointers.

CR3.LAM_U48[bit 61] allows to encode 15 bits of metadata in bits 62:48
of user pointers.

CR4.LAM_SUP[bit 28] allows to encode metadata of supervisor pointers.
If 5-level paging is in use, 6 bits of metadata can be encoded in 62:57.
For 4-level paging, 15 bits of metadata can be encoded in bits 62:48.

QEMU strips address from the metadata bits and gets it to canonical
shape before handling memory access. It has to be done very early before
TLB lookup.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 accel/tcg/cputlb.c                   | 20 +++++++++++++++++---
 include/hw/core/tcg-cpu-ops.h        |  5 +++++
 target/i386/cpu.c                    |  4 ++--
 target/i386/cpu.h                    | 26 +++++++++++++++++++++++++-
 target/i386/helper.c                 |  2 +-
 target/i386/tcg/helper-tcg.h         |  1 +
 target/i386/tcg/sysemu/excp_helper.c | 28 +++++++++++++++++++++++++++-
 target/i386/tcg/sysemu/misc_helper.c |  3 +--
 target/i386/tcg/sysemu/svm_helper.c  |  3 +--
 target/i386/tcg/tcg-cpu.c            |  1 +
 10 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2035b2ac0ac0..15eff0df39c1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1295,6 +1295,17 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
 }
 
+static vaddr clean_addr(CPUArchState *env, vaddr addr)
+{
+    CPUClass *cc = CPU_GET_CLASS(env_cpu(env));
+
+    if (cc->tcg_ops->do_clean_addr) {
+        addr = cc->tcg_ops->do_clean_addr(env_cpu(env), addr);
+    }
+
+    return addr;
+}
+
 /*
  * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
  * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
@@ -1757,10 +1768,11 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
  *
  * @prot may be PAGE_READ, PAGE_WRITE, or PAGE_READ|PAGE_WRITE.
  */
-static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
+static void *atomic_mmu_lookup(CPUArchState *env, target_ulong address,
                                MemOpIdx oi, int size, int prot,
                                uintptr_t retaddr)
 {
+    target_ulong addr = clean_addr(env, address);
     size_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
@@ -1904,10 +1916,11 @@ load_memop(const void *haddr, MemOp op)
 }
 
 static inline uint64_t QEMU_ALWAYS_INLINE
-load_helper(CPUArchState *env, target_ulong addr, MemOpIdx oi,
+load_helper(CPUArchState *env, target_ulong address, MemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
 {
+    target_ulong addr = clean_addr(env, address);
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
@@ -2307,9 +2320,10 @@ store_helper_unaligned(CPUArchState *env, target_ulong addr, uint64_t val,
 }
 
 static inline void QEMU_ALWAYS_INLINE
-store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+store_helper(CPUArchState *env, target_ulong address, uint64_t val,
              MemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
+    target_ulong addr = clean_addr(env, address);
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index e13898553aff..8e81f45510bf 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -82,6 +82,11 @@ struct TCGCPUOps {
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr) QEMU_NORETURN;
 
+    /**
+     * @do_clean_addr: Callback for clearing metadata/tags from the address.
+     */
+    vaddr (*do_clean_addr)(CPUState *cpu, vaddr addr);
+
     /**
      * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
      */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cb6b5467d067..6e3e8473bf04 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -662,7 +662,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS)
 #define TCG_7_0_EDX_FEATURES 0
-#define TCG_7_1_EAX_FEATURES 0
+#define TCG_7_1_EAX_FEATURES CPUID_7_1_EAX_LAM
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -876,7 +876,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 982c5323537c..5d6cc8efb7da 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -232,6 +232,9 @@ typedef enum X86Seg {
 #define CR0_CD_MASK  (1U << 30)
 #define CR0_PG_MASK  (1U << 31)
 
+#define CR3_LAM_U57  (1ULL << 61)
+#define CR3_LAM_U48  (1ULL << 62)
+
 #define CR4_VME_MASK  (1U << 0)
 #define CR4_PVI_MASK  (1U << 1)
 #define CR4_TSD_MASK  (1U << 2)
@@ -255,6 +258,7 @@ typedef enum X86Seg {
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LAM_SUP    (1U << 28)
 
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
@@ -263,7 +267,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
+                | CR4_LAM_SUP))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -877,6 +882,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_AVX_VNNI          (1U << 4)
 /* AVX512 BFloat16 Instruction */
 #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 /* XFD Extend Feature Disabled */
 #define CPUID_D_1_EAX_XFD               (1U << 4)
 
@@ -2287,6 +2294,23 @@ static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
     return !!(cpu->hyperv_features & BIT(feat));
 }
 
+static inline uint64_t cr3_reserved_bits(CPUX86State *env)
+{
+    uint64_t reserved_bits;
+
+    if (!(env->efer & MSR_EFER_LMA)) {
+        return 0;
+    }
+
+    reserved_bits = (~0ULL) << env_archcpu(env)->phys_bits;
+
+    if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM) {
+        reserved_bits &= ~(CR3_LAM_U48 | CR3_LAM_U57);
+    }
+
+    return reserved_bits;
+}
+
 static inline uint64_t cr4_reserved_bits(CPUX86State *env)
 {
     uint64_t reserved_bits = CR4_RESERVED_MASK;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index fa409e9c44a8..f91ebab840d6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -247,7 +247,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 0a4401e917f9..03ab858598d2 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -51,6 +51,7 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
+vaddr x86_cpu_clean_addr(CPUState *cpu, vaddr addr);
 #endif
 
 void breakpoint_handler(CPUState *cs);
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index e1b6d8868338..caaab413381b 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -64,7 +64,7 @@ static int mmu_translate(CPUState *cs, hwaddr addr, MMUTranslateFunc get_hphys_f
             uint64_t pml4e_addr, pml4e;
 
             if (la57) {
-                pml5e_addr = ((cr3 & ~0xfff) +
+                pml5e_addr = ((cr3 & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e_addr = GET_HPHYS(cs, pml5e_addr, MMU_DATA_STORE, NULL);
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
@@ -437,3 +437,29 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     }
     return true;
 }
+
+static inline int64_t sign_extend64(uint64_t value, int index)
+{
+    int shift = 63 - index;
+    return (int64_t)(value << shift) >> shift;
+}
+
+vaddr x86_cpu_clean_addr(CPUState *cs, vaddr addr)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+    bool la57 = env->cr[4] & CR4_LA57_MASK;
+
+    if (addr >> 63) {
+        if (env->cr[4] & CR4_LAM_SUP) {
+            return sign_extend64(addr, la57 ? 56 : 47);
+        }
+    } else {
+        if (env->cr[3] & CR3_LAM_U57) {
+            return sign_extend64(addr, 56);
+        } else if (env->cr[3] & CR3_LAM_U48) {
+            return sign_extend64(addr, 47);
+        }
+    }
+
+    return addr;
+}
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 3715c1e2625b..faeb4a16383c 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -97,8 +97,7 @@ void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
         cpu_x86_update_cr0(env, t0);
         break;
     case 3:
-        if ((env->efer & MSR_EFER_LMA) &&
-                (t0 & ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        if (t0 & cr3_reserved_bits(env)) {
             cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
         }
         if (!(env->efer & MSR_EFER_LMA)) {
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 2b6f450af959..cbd99f240bb8 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -287,8 +287,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
     new_cr3 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.cr3));
-    if ((env->efer & MSR_EFER_LMA) &&
-            (new_cr3 & ((~0ULL) << cpu->phys_bits))) {
+    if (new_cr3 & cr3_reserved_bits(env)) {
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
     new_cr4 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.cr4));
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6fdfdf959899..754454d19041 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -77,6 +77,7 @@ static const struct TCGCPUOps x86_tcg_ops = {
     .record_sigsegv = x86_cpu_record_sigsegv,
 #else
     .tlb_fill = x86_cpu_tlb_fill,
+    .do_clean_addr = x86_cpu_clean_addr,
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .debug_excp_handler = breakpoint_handler,
-- 
2.35.1

