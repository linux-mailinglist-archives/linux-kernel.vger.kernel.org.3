Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269B0484937
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiADUX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiADUXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:23:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E440C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:23:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 66-20020a251245000000b0060d05da9c4eso43373200ybs.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2fzYgKHjTtrxGw0GB60HtJq3pkJVmwXmT5LDUgkS65M=;
        b=YI7VLpCNyyiUbnArPXH4Vog2iUj3Py1GveGy5aNLD018G6UTJ5D220cf3S8iAqFZM+
         ChAgVvl7odJAso8iiC8Gk0jW6zt3nXSLXLFwhahNv16mu72Qr/tPjaoNxJsh0sf99Tog
         zzLbdc/omE1wmDBCYoYXcsX9KI5r+qZclmfYOKgcEEVYtRo4fTCUb/AqeQpCTi24srgE
         WXXwVoof997pmI299Q4VRR809/TbKAPHfWcDdJ+pKT66zHCqIfwmnvDPJtv8NppW1v23
         kezUSb2GfdvOVZ/hNDqh3QznuHfUtxOBxEaueZjlEIM0iuTtXQeA0DXfSB7YiBOdpJQ5
         BHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2fzYgKHjTtrxGw0GB60HtJq3pkJVmwXmT5LDUgkS65M=;
        b=YJhHX0KZFYDIZTekBtSiQoeWMsi0IUez5piBPFgJjLgHwLuxTLWXMpGSk5Fixm9Xfo
         M6UNlx6wst2LCAaLwDxL1gIn1xrqHC2b0im2p27IXXawGVtmzQVEBsfLJJpt5kQeCpcu
         icgs1BmjktoEnaKRYr+bpZAg/j+VtN+weyLHUO0/fnfAHnH1C6U0c5XhqMbjLU/HC5xr
         r8H5w/zMmppyYmOxnMynJ2q0sNSEfjEDbZi0h+zDMZc9PKKBRDBMODAAXf4jTERZA1Z0
         zRhO7lGvyBihG+NaxOlqbwysxq6tlJRMJln6iWT/+hnhVu5QITUeSJ29sK1fSadURisb
         qVeQ==
X-Gm-Message-State: AOAM5313/r5erlOMZnhN3oGO01b3iw9+wGPRhel5AzB88AeacVK7xglI
        QFHrfJa6novqHgG2GoJavh3wgy+zGu8=
X-Google-Smtp-Source: ABdhPJzJjG/RD50GN61XoI5Bcnp6HfOxLQQyP8uuoJlHDydVLPIBL6v9CM3RuZykJkxMwwXnrdc0GXLYZr4=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:6c8c:5506:7ca2:9dfd])
 (user=yuzhao job=sendgmr) by 2002:a25:84c2:: with SMTP id x2mr17042809ybm.51.1641327802572;
 Tue, 04 Jan 2022 12:23:22 -0800 (PST)
Date:   Tue,  4 Jan 2022 13:22:20 -0700
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
Message-Id: <20220104202227.2903605-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v6 1/9] mm: x86, arm64: add arch_has_hw_pte_young()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures automatically set the accessed bit in PTEs, e.g.,
x86 and arm64 v8.2. On architectures that don't have this capability,
clearing the accessed bit in a PTE usually triggers a page fault
following the TLB miss of this PTE.

Being aware of this capability can help make better decisions, e.g.,
whether to spread the work out over a period of time to avoid bursty
page faults when trying to clear the accessed bit in a large number of
PTEs.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/pgtable.h    | 13 ++++++++-----
 arch/arm64/kernel/cpufeature.c      | 19 +++++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 arch/x86/include/asm/pgtable.h      |  6 +++---
 include/linux/pgtable.h             | 13 +++++++++++++
 mm/memory.c                         | 14 +-------------
 7 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ef6be92b1921..99518b4b2a9e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -779,6 +779,11 @@ static inline bool system_supports_tlb_range(void)
 		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
 }
 
+static inline bool system_has_hw_af(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && cpus_have_const_cap(ARM64_HW_AF);
+}
+
 extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 
 static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4ba047a82d2..e736f47436c7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -999,13 +999,16 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  * page after fork() + CoW for pfn mappings. We don't always have a
  * hardware-managed access flag on arm64.
  */
-static inline bool arch_faults_on_old_pte(void)
+static inline bool arch_has_hw_pte_young(bool local)
 {
-	WARN_ON(preemptible());
+	if (local) {
+		WARN_ON(preemptible());
+		return cpu_has_hw_af();
+	}
 
-	return !cpu_has_hw_af();
+	return system_has_hw_af();
 }
-#define arch_faults_on_old_pte		arch_faults_on_old_pte
+#define arch_has_hw_pte_young		arch_has_hw_pte_young
 
 /*
  * Experimentally, it's cheap to set the access flag in hardware and we
@@ -1013,7 +1016,7 @@ static inline bool arch_faults_on_old_pte(void)
  */
 static inline bool arch_wants_old_prefaulted_pte(void)
 {
-	return !arch_faults_on_old_pte();
+	return arch_has_hw_pte_young(true);
 }
 #define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6f3e677d88f1..5bb553ee2c0e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2171,6 +2171,25 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
+	{
+		/*
+		 * __cpu_setup always enables this capability. But if the boot
+		 * CPU has it and a late CPU doesn't, the absent
+		 * ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU will prevent this late CPU
+		 * from going online. There is neither known hardware does that
+		 * nor obvious reasons to design hardware works that way, hence
+		 * no point leaving the door open here. If the need arises, a
+		 * new weak system feature flag should do the trick.
+		 */
+		.desc = "Hardware update of the Access flag",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HW_AF,
+		.sys_reg = SYS_ID_AA64MMFR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
+		.min_field_value = 1,
+		.matches = has_cpuid_feature,
+	},
 #endif
 	{
 		.desc = "CRC32 instructions",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 870c39537dd0..56e4ef5d95fa 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -36,6 +36,7 @@ HAS_STAGE2_FWB
 HAS_SYSREG_GIC_CPUIF
 HAS_TLB_RANGE
 HAS_VIRT_HOST_EXTN
+HW_AF
 HW_DBM
 KVM_PROTECTED_MODE
 MISMATCHED_CACHE_TYPE
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..c60b16f8b741 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1397,10 +1397,10 @@ static inline bool arch_has_pfn_modify_check(void)
 	return boot_cpu_has_bug(X86_BUG_L1TF);
 }
 
-#define arch_faults_on_old_pte arch_faults_on_old_pte
-static inline bool arch_faults_on_old_pte(void)
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(bool local)
 {
-	return false;
+	return true;
 }
 
 #endif	/* __ASSEMBLY__ */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..53bd6a26918f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,19 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef arch_has_hw_pte_young
+/*
+ * Return whether the accessed bit is supported by the local CPU or system-wide.
+ *
+ * This stub assumes accessing thru an old PTE triggers a page fault.
+ * Architectures that automatically set the access bit should overwrite it.
+ */
+static inline bool arch_has_hw_pte_young(bool local)
+{
+	return false;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..ead6c7d4b9a1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -121,18 +121,6 @@ int randomize_va_space __read_mostly =
 					2;
 #endif
 
-#ifndef arch_faults_on_old_pte
-static inline bool arch_faults_on_old_pte(void)
-{
-	/*
-	 * Those arches which don't have hw access flag feature need to
-	 * implement their own helper. By default, "true" means pagefault
-	 * will be hit on old pte.
-	 */
-	return true;
-}
-#endif
-
 #ifndef arch_wants_old_prefaulted_pte
 static inline bool arch_wants_old_prefaulted_pte(void)
 {
@@ -2755,7 +2743,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
-	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
+	if (!arch_has_hw_pte_young(true) && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
 
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-- 
2.34.1.448.ga2b2bfdf31-goog

