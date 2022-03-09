Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B554D26DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiCICOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCICOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:14:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4E655A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:13:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dbd2b5e180so6378987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 18:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Tgx8ae//L5IA0Yqg+D9TLCaQ78LCepfaB8sQmorTCkw=;
        b=MplWLgkdZ8IkcjAeb21RK5idtG0QrhB110v1i6oAlFmk+o/WSuHWqzP494bK70E7Eo
         fjKGcDBgc0imLsTkwtvZ3kQn2UkYlL62orIgwKmTodTRrwRGQoUPJ+ehmRykoKnaSX7J
         iwk7RvncXYTqLzMKecCI/UMTaP76eiLxO8Zln+1Ty0Vwztj6EPtPrnrHTawy+DkPMRMD
         S77g1ZaTw9Wl0ejhmMXzpC1OEB+P2Rq6G3HYsJcUvG9JAyD2X/vw95P8q9/HBpZWA0iY
         8TnOTrhC0qHqGNFiBMqruRJxuoeJQIDPeESHbDm8C/ImMVZxYLnXmywwEo8h1TgjAwBY
         BZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Tgx8ae//L5IA0Yqg+D9TLCaQ78LCepfaB8sQmorTCkw=;
        b=7/AoK1cE4r/JEs0nHxAxhWj01zhJqKN8uXfKMYFwpDXS8Z9TG+rm9mArgS+xq+bPHP
         oMzNNr0K1IdHaL0L5BVwnjr86FGTtezTuSF4GbycPnXbp4771nNTElTIlnjt4iUPNoMZ
         TQDmcF9y6nHB9QmqDwkqlmnlitAS86KBDn1ePt9mab3KNCJ5MwesBKdD3i9pnqV1+xTn
         U5qbkuxjV+1o7fctMKmV4Z4xhg/wiFBWAoCruUuGjgV7rJt2jR4JUn7838BXW0MDv82m
         sFpS5wDr7akIZP04Q+pdQJWp779CzPWheTLQ5vQhNAwFUYdWdp7ZfyC8ihfkyhOgkGWt
         oMDw==
X-Gm-Message-State: AOAM531QSJJve+LX0YZM+8smg8jRbBIB0cQ1GVQIprn79eJk0+UUh2Dq
        AWh+JWyX38CxZdavBL9Ya6RQ4ifC9SY=
X-Google-Smtp-Source: ABdhPJxpZg9qvT6bw4Ya7lic+kI5kNScSSEI4fdD4oIlmk43BZFCQsHnQxb+oPeJq/M2cLqOF8wWJ5xmfNY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a81:dca:0:b0:2db:fe0c:6bcb with SMTP id
 193-20020a810dca000000b002dbfe0c6bcbmr15742320ywn.420.1646792006120; Tue, 08
 Mar 2022 18:13:26 -0800 (PST)
Date:   Tue,  8 Mar 2022 19:12:19 -0700
In-Reply-To: <20220309021230.721028-1-yuzhao@google.com>
Message-Id: <20220309021230.721028-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 02/14] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support the accessed bit in non-leaf PMD entries,
e.g., x86 sets the accessed bit in a non-leaf PMD entry when using it
as part of linear address translation [1]. Page table walkers that
clear the accessed bit may use this capability to reduce their search
space.

Note that:
1. Although an inline function is preferable, this capability is added
   as a configuration option for consistency with the existing macros.
2. Due to the little interest in other varieties, this capability was
   only tested on Intel and AMD CPUs.

[1]: Intel 64 and IA-32 Architectures Software Developer's Manual
     Volume 3 (June 2021), section 4.8

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/Kconfig                   | 9 +++++++++
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/pgtable.h | 3 ++-
 arch/x86/mm/pgtable.c          | 5 ++++-
 include/linux/pgtable.h        | 4 ++--
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..f9c59ecadbbb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1322,6 +1322,15 @@ config DYNAMIC_SIGFRAME
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
=20
+config ARCH_HAS_NONLEAF_PMD_YOUNG
+	bool
+	depends on PGTABLE_LEVELS > 2
+	help
+	  Architectures that select this option are capable of setting the
+	  accessed bit in non-leaf PMD entries when using them as part of linear
+	  address translations. Page table walkers that clear the accessed bit
+	  may use this capability to reduce their search space.
+
 source "kernel/gcov/Kconfig"
=20
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..e787b7fc75be 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NONLEAF_PMD_YOUNG
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index 60b6ce45c2e3..f973788f6b21 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -819,7 +819,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
=20
 static inline int pmd_bad(pmd_t pmd)
 {
-	return (pmd_flags(pmd) & ~_PAGE_USER) !=3D _KERNPG_TABLE;
+	return (pmd_flags(pmd) & ~(_PAGE_USER | _PAGE_ACCESSED)) !=3D
+	       (_KERNPG_TABLE & ~_PAGE_ACCESSED);
 }
=20
 static inline unsigned long pages_to_mb(unsigned long npg)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..a224193d84bf 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -550,7 +550,7 @@ int ptep_test_and_clear_young(struct vm_area_struct *vm=
a,
 	return ret;
 }
=20
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEA=
F_PMD_YOUNG)
 int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pmd_t *pmdp)
 {
@@ -562,6 +562,9 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vm=
a,
=20
 	return ret;
 }
+#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int pudp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pud_t *pudp)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 79f64dcff07d..743e7fc4afda 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,7 +212,7 @@ static inline int ptep_test_and_clear_young(struct vm_a=
rea_struct *vma,
 #endif
=20
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEA=
F_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pmd_t *pmdp)
@@ -233,7 +233,7 @@ static inline int pmdp_test_and_clear_young(struct vm_a=
rea_struct *vma,
 	BUILD_BUG();
 	return 0;
 }
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=
 */
 #endif
=20
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
--=20
2.35.1.616.g0bdcbb4464-goog

