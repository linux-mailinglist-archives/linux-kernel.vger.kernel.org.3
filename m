Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E959E592A29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiHOHOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiHOHOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:14:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268BF18B30
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so51564247b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=F4xmUEdaUsMsbEYfVbJBjjwTvc/M3miaYS+QPbbrcOU=;
        b=i0l14FcXIF2jFcRbhjNQJ4bpatMDCJ3ghyqdJ4AnfApm/UBqv9DDDDJpWOZBVgpw1I
         WYUbXtKtD3Dpceay5gMJsRPNJJOvJaF5275SnlO4cNWxXYCBjZzQWOsOFEM4+STi2qUC
         Owpo33q+E9BlLueZ8NH0ClPcNIt/RaZhmfIxkGceBrZdrbUVOEu9GJqLZ+HFdXEMc2QY
         CymVfkKl4qAXlBoiefo/nNij/wOO9k65CPgiPluDRdUWuATaWe06fOtqg9KNFQz05yLk
         cFTqGJzXjgIXvHDBjPp5pjVBXkKcouV/abrK8r92j6RSgL57kFrFhq50/9lgYEVFTXNH
         by4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=F4xmUEdaUsMsbEYfVbJBjjwTvc/M3miaYS+QPbbrcOU=;
        b=RB8Ri7XhMgLp18aUq9Inpk7FGUhl8lRBRvCQiKzRUXPt46IbOq0gb5JSYnW7KXeyIu
         bba1jLVKxPYbr1Xd0wC5boXhsSehiYY2wnlolDkd+R1VQRitvh3iVWERuB9CH7hPZ65d
         xUouKE0NrdUSs2qU2n2wOyr4yC9VK/cl3XgssdzQOz3ntyKKPYpadcJSNgKM8wSz6Xlu
         1gaSBcC1kk6kkYxYHWj9BogpiVSGVjgXiJH/F2YYBuQ5JOUzFh0xbBKYv8PqecEGBVZo
         O1uWiLU/cs8zbm9HSBYnRrT7g4zrAS7zbyfPYEmBsJ4b2W9Pc2T9r2gAQtu/IV7X3yrY
         O4FA==
X-Gm-Message-State: ACgBeo0IQ+MGvIMxQZ8dhcAN8ulgKtvLXkVoXTPI1ieV0gC/PhczK/RY
        yMgPkJzH55KmUYzZa4rJjcb5uUqxIuk=
X-Google-Smtp-Source: AA6agR6U+7wNSbpd+r8CvO2k2mdeSkKSW80LN7oxzy0asd5he7PvVy9sooHt5csrkeJeg7wygOv3Axb6cJQ=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:d91:5887:ac93:ddf0])
 (user=yuzhao job=sendgmr) by 2002:a25:4ce:0:b0:67c:3362:c396 with SMTP id
 197-20020a2504ce000000b0067c3362c396mr11024827ybe.336.1660547655351; Mon, 15
 Aug 2022 00:14:15 -0700 (PDT)
Date:   Mon, 15 Aug 2022 01:13:20 -0600
In-Reply-To: <20220815071332.627393-1-yuzhao@google.com>
Message-Id: <20220815071332.627393-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v14 01/14] mm: x86, arm64: add arch_has_hw_pte_young()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Barry Song <baohua@kernel.org>
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
 arch/arm64/include/asm/pgtable.h | 15 ++-------------
 arch/x86/include/asm/pgtable.h   |  6 +++---
 include/linux/pgtable.h          | 13 +++++++++++++
 mm/memory.c                      | 14 +-------------
 4 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgta=
ble.h
index b5df82aa99e6..71a1af42f0e8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1082,24 +1082,13 @@ static inline void update_mmu_cache(struct vm_area_=
struct *vma,
  * page after fork() + CoW for pfn mappings. We don't always have a
  * hardware-managed access flag on arm64.
  */
-static inline bool arch_faults_on_old_pte(void)
-{
-	/* The register read below requires a stable CPU to make any sense */
-	cant_migrate();
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
 static inline bool pud_sect_supported(void)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index 44e2d6f1dbaa..dc5f7d8ef68a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1431,10 +1431,10 @@ static inline bool arch_has_pfn_modify_check(void)
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
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 014ee8f0fbaa..95f408df4695 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -260,6 +260,19 @@ static inline int pmdp_clear_flush_young(struct vm_are=
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
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index b994784158f5..46071cf00b47 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -126,18 +126,6 @@ int randomize_va_space __read_mostly =3D
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
@@ -2871,7 +2859,7 @@ static inline bool __wp_page_copy_user(struct page *d=
st, struct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
-	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
+	if (!arch_has_hw_pte_young() && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
=20
 		vmf->pte =3D pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
--=20
2.37.1.595.g718a3a8f04-goog

