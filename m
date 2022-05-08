Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB251EEEB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiEHQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiEHQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E5DF58
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D6A611F5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA36C385AF;
        Sun,  8 May 2022 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652026611;
        bh=s+Wtb80a0asBOvxsopCXgpsx46DIS6cRWDYhtKPxr+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkoeFI5VxGNdiR6dEMJprMVwqcPIjixFK0LGBNa2FnQ3UrE07s0u9P3DP1rvrdZeP
         MjVyztSXMpr6XlyKbKIKAZk9EAF6Q3Z58kbIRrsEQUfXTxzIsZd133tcgFLyPIamdB
         lCkHlPr/0Ya6r/JV2T7J0td6fuD5Ksl6lRHCvrghv2nkn4DknPDk0S9NTKfIFvFO8t
         HnxZy4EQRE2TVtaARRaJsT60uO+AyOS2frIwmINVmwesgrQJ2DGDLBiJE23xYJeNe6
         ha9WEF64F7Ayrkszj/m3S+GY9JmDLBiJJlBl9EUogF3g8Xtujc2g+cTGrxXBbRgsux
         B0XAhQ86+iykg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v2 4/4] riscv: convert pgtable_l4|[l5]_enabled to static key
Date:   Mon,  9 May 2022 00:07:49 +0800
Message-Id: <20220508160749.984-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220508160749.984-1-jszhang@kernel.org>
References: <20220508160749.984-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a specific HW platform, pgtable_l4|[l5]_enabled won't change after
boot, and the check sits at hot code path, this characteristic makes it
suitable for optimization with static key.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/cpufeature.h | 11 +++++++
 arch/riscv/include/asm/pgalloc.h    | 16 +++++-----
 arch/riscv/include/asm/pgtable-64.h | 40 ++++++++++++-------------
 arch/riscv/include/asm/pgtable.h    |  5 ++--
 arch/riscv/kernel/cpu.c             |  4 +--
 arch/riscv/mm/init.c                | 46 +++++++++++++----------------
 arch/riscv/mm/kasan_init.c          | 16 +++++-----
 arch/riscv/tools/cpucaps            |  2 ++
 8 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 634a653c7fa2..a51f2602a0e3 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -96,4 +96,15 @@ static inline bool system_supports_fpu(void)
 	return IS_ENABLED(CONFIG_FPU) && !cpus_have_final_cap(RISCV_HAS_NO_FPU);
 }
 
+static inline bool system_supports_sv48(void)
+{
+	return IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL) &&
+		!cpus_have_const_cap(RISCV_HAS_NO_SV48);
+}
+
+static inline bool system_supports_sv57(void)
+{
+	return IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL) &&
+		!cpus_have_const_cap(RISCV_HAS_NO_SV57);
+}
 #endif
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 947f23d7b6af..f49233ca696a 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -41,7 +41,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 {
-	if (pgtable_l4_enabled) {
+	if (system_supports_sv48()) {
 		unsigned long pfn = virt_to_pfn(pud);
 
 		set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
@@ -51,7 +51,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
 				     pud_t *pud)
 {
-	if (pgtable_l4_enabled) {
+	if (system_supports_sv48()) {
 		unsigned long pfn = virt_to_pfn(pud);
 
 		set_p4d_safe(p4d,
@@ -61,7 +61,7 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 {
-	if (pgtable_l5_enabled) {
+	if (system_supports_sv57()) {
 		unsigned long pfn = virt_to_pfn(p4d);
 
 		set_pgd(pgd, __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
@@ -71,7 +71,7 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 				     p4d_t *p4d)
 {
-	if (pgtable_l5_enabled) {
+	if (system_supports_sv57()) {
 		unsigned long pfn = virt_to_pfn(p4d);
 
 		set_pgd_safe(pgd,
@@ -82,7 +82,7 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 #define pud_alloc_one pud_alloc_one
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return __pud_alloc_one(mm, addr);
 
 	return NULL;
@@ -91,7 +91,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		__pud_free(mm, pud);
 }
 
@@ -100,7 +100,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
+	if (system_supports_sv57()) {
 		gfp_t gfp = GFP_PGTABLE_USER;
 
 		if (mm == &init_mm)
@@ -120,7 +120,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 #define p4d_free p4d_free
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		__p4d_free(mm, p4d);
 }
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 7e246e9f8d70..9ee4abf0f528 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -7,17 +7,15 @@
 #define _ASM_RISCV_PGTABLE_64_H
 
 #include <linux/const.h>
-
-extern bool pgtable_l4_enabled;
-extern bool pgtable_l5_enabled;
+#include <asm/cpufeature.h>
 
 #define PGDIR_SHIFT_L3  30
 #define PGDIR_SHIFT_L4  39
 #define PGDIR_SHIFT_L5  48
 #define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
 
-#define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
-		(pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
+#define PGDIR_SHIFT     (system_supports_sv57() ? PGDIR_SHIFT_L5 : \
+		(system_supports_sv48() ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
 /* Size of region mapped by a page global directory */
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
@@ -119,7 +117,7 @@ static inline struct page *pud_page(pud_t pud)
 #define mm_p4d_folded  mm_p4d_folded
 static inline bool mm_p4d_folded(struct mm_struct *mm)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		return false;
 
 	return true;
@@ -128,7 +126,7 @@ static inline bool mm_p4d_folded(struct mm_struct *mm)
 #define mm_pud_folded  mm_pud_folded
 static inline bool mm_pud_folded(struct mm_struct *mm)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return false;
 
 	return true;
@@ -159,7 +157,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		*p4dp = p4d;
 	else
 		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
@@ -167,7 +165,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 
 static inline int p4d_none(p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return (p4d_val(p4d) == 0);
 
 	return 0;
@@ -175,7 +173,7 @@ static inline int p4d_none(p4d_t p4d)
 
 static inline int p4d_present(p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return (p4d_val(p4d) & _PAGE_PRESENT);
 
 	return 1;
@@ -183,7 +181,7 @@ static inline int p4d_present(p4d_t p4d)
 
 static inline int p4d_bad(p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return !p4d_present(p4d);
 
 	return 0;
@@ -191,7 +189,7 @@ static inline int p4d_bad(p4d_t p4d)
 
 static inline void p4d_clear(p4d_t *p4d)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		set_p4d(p4d, __p4d(0));
 }
 
@@ -207,7 +205,7 @@ static inline unsigned long _p4d_pfn(p4d_t p4d)
 
 static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
 
 	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
@@ -224,7 +222,7 @@ static inline struct page *p4d_page(p4d_t p4d)
 #define pud_offset pud_offset
 static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 {
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		return p4d_pgtable(*p4d) + pud_index(address);
 
 	return (pud_t *)p4d;
@@ -232,7 +230,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		*pgdp = pgd;
 	else
 		set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
@@ -240,7 +238,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 
 static inline int pgd_none(pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		return (pgd_val(pgd) == 0);
 
 	return 0;
@@ -248,7 +246,7 @@ static inline int pgd_none(pgd_t pgd)
 
 static inline int pgd_present(pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		return (pgd_val(pgd) & _PAGE_PRESENT);
 
 	return 1;
@@ -256,7 +254,7 @@ static inline int pgd_present(pgd_t pgd)
 
 static inline int pgd_bad(pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		return !pgd_present(pgd);
 
 	return 0;
@@ -264,13 +262,13 @@ static inline int pgd_bad(pgd_t pgd)
 
 static inline void pgd_clear(pgd_t *pgd)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		set_pgd(pgd, __pgd(0));
 }
 
 static inline p4d_t *pgd_pgtable(pgd_t pgd)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		return (p4d_t *)pfn_to_virt(pgd_val(pgd) >> _PAGE_PFN_SHIFT);
 
 	return (p4d_t *)p4d_pgtable((p4d_t) { pgd_val(pgd) });
@@ -288,7 +286,7 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		return pgd_pgtable(*pgd) + p4d_index(address);
 
 	return (p4d_t *)pgd;
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 046b44225623..ef2a1654100a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -63,8 +63,8 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
-#define VA_BITS		(pgtable_l5_enabled ? \
-				57 : (pgtable_l4_enabled ? 48 : 39))
+#define VA_BITS		(system_supports_sv57() ? \
+				57 : (system_supports_sv48() ? 48 : 39))
 #else
 #define VA_BITS		32
 #endif
@@ -738,7 +738,6 @@ extern uintptr_t _dtb_early_pa;
 #define dtb_early_pa	_dtb_early_pa
 #endif /* CONFIG_XIP_KERNEL */
 extern u64 satp_mode;
-extern bool pgtable_l4_enabled;
 
 void paging_init(void);
 void misc_mem_init(void);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..c8f3989b08f3 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -141,9 +141,9 @@ static void print_mmu(struct seq_file *f)
 #if defined(CONFIG_32BIT)
 	strncpy(sv_type, "sv32", 5);
 #elif defined(CONFIG_64BIT)
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		strncpy(sv_type, "sv57", 5);
-	else if (pgtable_l4_enabled)
+	else if (system_supports_sv48())
 		strncpy(sv_type, "sv48", 5);
 	else
 		strncpy(sv_type, "sv39", 5);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5f3f26dd9f21..b6a59a5d1a7f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -21,6 +21,7 @@
 #include <linux/crash_dump.h>
 #include <linux/hugetlb.h>
 
+#include <asm/cpufeature.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
@@ -44,11 +45,6 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
 #endif
 EXPORT_SYMBOL(satp_mode);
 
-bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
-bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
-EXPORT_SYMBOL(pgtable_l4_enabled);
-EXPORT_SYMBOL(pgtable_l5_enabled);
-
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
@@ -555,26 +551,26 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 }
 
 #define pgd_next_t		p4d_t
-#define alloc_pgd_next(__va)	(pgtable_l5_enabled ?			\
-		pt_ops.alloc_p4d(__va) : (pgtable_l4_enabled ?		\
+#define alloc_pgd_next(__va)	(system_supports_sv57() ?		\
+		pt_ops.alloc_p4d(__va) : (system_supports_sv48() ?	\
 		pt_ops.alloc_pud(__va) : pt_ops.alloc_pmd(__va)))
-#define get_pgd_next_virt(__pa)	(pgtable_l5_enabled ?			\
-		pt_ops.get_p4d_virt(__pa) : (pgd_next_t *)(pgtable_l4_enabled ?	\
+#define get_pgd_next_virt(__pa)	(system_supports_sv57() ?		\
+		pt_ops.get_p4d_virt(__pa) : (pgd_next_t *)(system_supports_sv48() ?	\
 		pt_ops.get_pud_virt(__pa) : (pud_t *)pt_ops.get_pmd_virt(__pa)))
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
-				(pgtable_l5_enabled ?			\
+				(system_supports_sv57() ?		\
 		create_p4d_mapping(__nextp, __va, __pa, __sz, __prot) : \
-				(pgtable_l4_enabled ?			\
+				(system_supports_sv48() ?		\
 		create_pud_mapping((pud_t *)__nextp, __va, __pa, __sz, __prot) :	\
 		create_pmd_mapping((pmd_t *)__nextp, __va, __pa, __sz, __prot)))
-#define fixmap_pgd_next		(pgtable_l5_enabled ?			\
-		(uintptr_t)fixmap_p4d : (pgtable_l4_enabled ?		\
+#define fixmap_pgd_next		(system_supports_sv57() ?		\
+		(uintptr_t)fixmap_p4d : (system_supports_sv48() ?	\
 		(uintptr_t)fixmap_pud : (uintptr_t)fixmap_pmd))
-#define trampoline_pgd_next	(pgtable_l5_enabled ?			\
-		(uintptr_t)trampoline_p4d : (pgtable_l4_enabled ?	\
+#define trampoline_pgd_next	(system_supports_sv57() ?		\
+		(uintptr_t)trampoline_p4d : (system_supports_sv48() ?	\
 		(uintptr_t)trampoline_pud : (uintptr_t)trampoline_pmd))
-#define early_dtb_pgd_next	(pgtable_l5_enabled ?			\
-		(uintptr_t)early_dtb_p4d : (pgtable_l4_enabled ?	\
+#define early_dtb_pgd_next	(system_supports_sv57() ?		\
+		(uintptr_t)early_dtb_p4d : (system_supports_sv48() ?	\
 		(uintptr_t)early_dtb_pud : (uintptr_t)early_dtb_pmd))
 #else
 #define pgd_next_t		pte_t
@@ -680,14 +676,14 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 #ifdef CONFIG_64BIT
 static void __init disable_pgtable_l5(void)
 {
-	pgtable_l5_enabled = false;
+	cpus_set_cap(RISCV_HAS_NO_SV57);
 	kernel_map.page_offset = PAGE_OFFSET_L4;
 	satp_mode = SATP_MODE_48;
 }
 
 static void __init disable_pgtable_l4(void)
 {
-	pgtable_l4_enabled = false;
+	cpus_set_cap(RISCV_HAS_NO_SV48);
 	kernel_map.page_offset = PAGE_OFFSET_L3;
 	satp_mode = SATP_MODE_39;
 }
@@ -816,11 +812,11 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
 			   PGDIR_SIZE,
 			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
 
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
 				   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
 
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
 				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
 
@@ -961,11 +957,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	/* Setup fixmap P4D and PUD */
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		create_p4d_mapping(fixmap_p4d, FIXADDR_START,
 				   (uintptr_t)fixmap_pud, P4D_SIZE, PAGE_TABLE);
 	/* Setup fixmap PUD and PMD */
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		create_pud_mapping(fixmap_pud, FIXADDR_START,
 				   (uintptr_t)fixmap_pmd, PUD_SIZE, PAGE_TABLE);
 	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
@@ -973,10 +969,10 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	/* Setup trampoline PGD and PMD */
 	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
 			   trampoline_pgd_next, PGDIR_SIZE, PAGE_TABLE);
-	if (pgtable_l5_enabled)
+	if (system_supports_sv57())
 		create_p4d_mapping(trampoline_p4d, kernel_map.virt_addr,
 				   (uintptr_t)trampoline_pud, P4D_SIZE, PAGE_TABLE);
-	if (pgtable_l4_enabled)
+	if (system_supports_sv48())
 		create_pud_mapping(trampoline_pud, kernel_map.virt_addr,
 				   (uintptr_t)trampoline_pmd, PUD_SIZE, PAGE_TABLE);
 #ifdef CONFIG_XIP_KERNEL
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index a22e418dbd82..7b662661f7a9 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -209,15 +209,15 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
 }
 
-#define kasan_early_shadow_pgd_next			(pgtable_l5_enabled ?	\
+#define kasan_early_shadow_pgd_next		(system_supports_sv57() ?	\
 				(uintptr_t)kasan_early_shadow_p4d :		\
-							(pgtable_l4_enabled ?	\
+						(system_supports_sv48() ?	\
 				(uintptr_t)kasan_early_shadow_pud :		\
 				(uintptr_t)kasan_early_shadow_pmd))
 #define kasan_populate_pgd_next(pgdp, vaddr, next, early)			\
-		(pgtable_l5_enabled ?						\
+		(system_supports_sv57() ?					\
 		kasan_populate_p4d(pgdp, vaddr, next, early) :			\
-		(pgtable_l4_enabled ?						\
+		(system_supports_sv48() ?					\
 			kasan_populate_pud(pgdp, vaddr, next, early) :		\
 			kasan_populate_pmd((pud_t *)pgdp, vaddr, next)))
 
@@ -274,7 +274,7 @@ asmlinkage void __init kasan_early_init(void)
 				(__pa((uintptr_t)kasan_early_shadow_pte)),
 				PAGE_TABLE));
 
-	if (pgtable_l4_enabled) {
+	if (system_supports_sv48()) {
 		for (i = 0; i < PTRS_PER_PUD; ++i)
 			set_pud(kasan_early_shadow_pud + i,
 				pfn_pud(PFN_DOWN
@@ -282,7 +282,7 @@ asmlinkage void __init kasan_early_init(void)
 					PAGE_TABLE));
 	}
 
-	if (pgtable_l5_enabled) {
+	if (system_supports_sv57()) {
 		for (i = 0; i < PTRS_PER_P4D; ++i)
 			set_p4d(kasan_early_shadow_p4d + i,
 				pfn_p4d(PFN_DOWN
@@ -393,9 +393,9 @@ static void __init kasan_shallow_populate_p4d(pgd_t *pgdp,
 }
 
 #define kasan_shallow_populate_pgd_next(pgdp, vaddr, next)			\
-		(pgtable_l5_enabled ?						\
+		(system_supports_sv57() ?					\
 		kasan_shallow_populate_p4d(pgdp, vaddr, next) :			\
-		(pgtable_l4_enabled ?						\
+		(system_supports_sv48() ?					\
 		kasan_shallow_populate_pud(pgdp, vaddr, next) :			\
 		kasan_shallow_populate_pmd(pgdp, vaddr, next)))
 
diff --git a/arch/riscv/tools/cpucaps b/arch/riscv/tools/cpucaps
index cb1ff2747859..0b9e19ec8371 100644
--- a/arch/riscv/tools/cpucaps
+++ b/arch/riscv/tools/cpucaps
@@ -3,3 +3,5 @@
 # Internal CPU capabilities constants, keep this list sorted
 
 HAS_NO_FPU
+HAS_NO_SV48
+HAS_NO_SV57
-- 
2.34.1

