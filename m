Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B24D25A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiCIBOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiCIBMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:12:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2C154D29
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:54:58 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id c14-20020a17090a674e00b001bf1c750f9bso2674132pjm.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=rg3wku5xl2PL1N8SWaxt6E1BdTA98F4PakQ3p281Xms=;
        b=O64hORryFW0PuVuYKrnQl8oNSa4OGbfGckwZFC6nKrQkABNaZwPbHS2td2uADd2eZH
         r1INm/Xlv3kHI5ucB1SlOrh5nZt8oPjA7jMN3wcMLX8FiG+T8hVz0t6/BPdYZNm7QlEx
         6rOaZlgdUJq/EvR5lSl8mT5/H9PmRz9JItr33y9PnUs83iBp3/X+ZVMhofDvVkOSand8
         5nD1gKQMo1crl6fpOIt5iQAA3wE3L7ZWlaxefDbjhbzR4AHf7oR8P8YkDvIESTegqxPD
         Q3MSNJxddUTcyDQ1MHBLL4jZATzOwhcOQOp7p6S+awYx3C/q/CcYKaKIK0p9BcZm7eI5
         Ctgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=rg3wku5xl2PL1N8SWaxt6E1BdTA98F4PakQ3p281Xms=;
        b=XUHsCLbZ4e/ruDV5KuQUcIDL+H+MthmVWW+FZckQXHgiJgrudUzs7/5YcSya5mn+qL
         fc+FhJ5nwcU1bUwHsNeiLlSFyecZx9qCB4qAr5pioARrQ1YVVcrpi2TQTF5QF8d01+5Q
         4YC7FhzbV7bw6JyQ93KsNe3BXmlnlnk1gupIlANZWFOvx5BsGiLZQFVTe5NdibzRlwi2
         wZbGvjFIF1oKeRr5TK0YHI/wIG4fBHCSwUjOBSqNL8tc7HgJgC77JLpa38e1/vVpLXak
         E8inUQmKFWwJL0ZARkm4P/4AUUaWlGsA7tbhi8DcXRMjpNXNlAND7Qh8T+ufRjtlaQrx
         F0oQ==
X-Gm-Message-State: AOAM5310oQYAKLf56Na2vSlBbJQoMeAuctJgbcU4aM6Dx3+MqqPkEQQD
        B7NrduMw1pwXzIWzSqWyRGMTOxVIz64=
X-Google-Smtp-Source: ABdhPJx2Wz0gCLpU/Cb3g6spmRzUflTMCrVxePalS3HpuV0FsFmfWj4JRbLWXQl61RBEoVEf1MoFqyQ5WaM=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a05:6e02:1aaf:b0:2c5:3cc5:af7d with SMTP id
 l15-20020a056e021aaf00b002c53cc5af7dmr16764355ilv.32.1646783305487; Tue, 08
 Mar 2022 15:48:25 -0800 (PST)
Date:   Tue,  8 Mar 2022 16:47:11 -0700
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
Message-Id: <20220308234723.3834941-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v8 01/14] mm: x86, arm64: add arch_has_hw_pte_young()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures automatically set the accessed bit in PTEs, e.g.,
x86 and arm64 v8.2. On architectures that do not have this capability,
clearing the accessed bit in a PTE usually triggers a page fault
following the TLB miss of this PTE (to emulate the accessed bit).

Being aware of this capability can help make better decisions, e.g.,
whether to spread the work out over a period of time to reduce bursty
page faults when trying to clear the accessed bit in many PTEs.

Note that theoretically this capability can be unreliable, e.g.,
hotplugged CPUs might be different from builtin ones. Therefore it
should not be used in architecture-independent code that involves
correctness, e.g., to determine whether TLB flushes are required (in
combination with the accessed bit).

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/arm64/include/asm/pgtable.h | 14 ++------------
 arch/x86/include/asm/pgtable.h   |  6 +++---
 include/linux/pgtable.h          | 13 +++++++++++++
 mm/memory.c                      | 14 +-------------
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgta=
ble.h
index c4ba047a82d2..990358eca359 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -999,23 +999,13 @@ static inline void update_mmu_cache(struct vm_area_st=
ruct *vma,
  * page after fork() + CoW for pfn mappings. We don't always have a
  * hardware-managed access flag on arm64.
  */
-static inline bool arch_faults_on_old_pte(void)
-{
-	WARN_ON(preemptible());
-
-	return !cpu_has_hw_af();
-}
-#define arch_faults_on_old_pte		arch_faults_on_old_pte
+#define arch_has_hw_pte_young		cpu_has_hw_af
=20
 /*
  * Experimentally, it's cheap to set the access flag in hardware and we
  * benefit from prefaulting mappings as 'old' to start with.
  */
-static inline bool arch_wants_old_prefaulted_pte(void)
-{
-	return !arch_faults_on_old_pte();
-}
-#define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
+#define arch_wants_old_prefaulted_pte	cpu_has_hw_af
=20
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index 8a9432fb3802..60b6ce45c2e3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1423,10 +1423,10 @@ static inline bool arch_has_pfn_modify_check(void)
 	return boot_cpu_has_bug(X86_BUG_L1TF);
 }
=20
-#define arch_faults_on_old_pte arch_faults_on_old_pte
-static inline bool arch_faults_on_old_pte(void)
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(void)
 {
-	return false;
+	return true;
 }
=20
 #endif	/* __ASSEMBLY__ */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f4f4077b97aa..79f64dcff07d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -259,6 +259,19 @@ static inline int pmdp_clear_flush_young(struct vm_are=
a_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
=20
+#ifndef arch_has_hw_pte_young
+/*
+ * Return whether the accessed bit is supported on the local CPU.
+ *
+ * This stub assumes accessing through an old PTE triggers a page fault.
+ * Architectures that automatically set the access bit should overwrite it=
.
+ */
+static inline bool arch_has_hw_pte_young(void)
+{
+	return false;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..a7379196a47e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -122,18 +122,6 @@ int randomize_va_space __read_mostly =3D
 					2;
 #endif
=20
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
@@ -2778,7 +2766,7 @@ static inline bool cow_user_page(struct page *dst, st=
ruct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
-	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
+	if (!arch_has_hw_pte_young() && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
=20
 		vmf->pte =3D pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
--=20
2.35.1.616.g0bdcbb4464-goog

