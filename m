Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF152B017
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiERBrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiERBq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:46:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEEA369F6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:46:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s196-20020a252ccd000000b0064ea2e6bcb7so229133ybs.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1bKeqo1zCElFP+SckxGjo2derYSk4l4pfi9HINvqfq4=;
        b=HsLFhyzjsAQkrYPW7tweXLviM2ac4Z/u86RJZLb+b4+uKw9PjWuLuZ/poZpOBXlJ4A
         EnLzqKLUp8mfbTC3uzZ35oFke3PMrffiZDsnYY+QZqBtNwEhl1uy2E0bpFXnluoh7L67
         vklNO5RUH9u2/rP4//lRvouGI3jWzLqmYcmMENQfHoNSFkIu+P5F6Na9vhUAUVt2vqL9
         PX1oYXdcS4oygIzDn7r9TSwLhjBQH3HDYzL2D6tZ09CiUA0tGd4Ed4tS7nYHF37XYXVR
         2amql6QycMPOP1s7d34tUB6/TFPSvHk6mK85S15EuwCH/j0UXE6zAFdq4orvDLbO5AnQ
         5JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1bKeqo1zCElFP+SckxGjo2derYSk4l4pfi9HINvqfq4=;
        b=mo8RJBPjH+cp5+jPwh98oAaStWsyChWHd9nH1BaAs+9lPSk7VOB6GrXU5qZAahMpZa
         0PesaFfqwWlIJnzqirWvXCu9bH39G4bZGbIdYCJy+o5RLRfVp45jFEGV4KJsZpAlisld
         f2aCgv/p9bLOeVUZaOOt4/nx0zA4AUrA4UXWKVJ2FsyNHTK59/PDAMK7v6BAwrbGBnMK
         DBhWBG39brkowTH7Sm3GrWji9u1NpGmuKHIZcnFU5w7rUG7qfQvCtqPFR6V0Oo9IwSZ5
         e/OrCGWEyw1kODXBGlsr+IlYrfmg1FaJOAZuM7H6mbg5DCiDikRrmo0clUu9gmrZS+q2
         y9UA==
X-Gm-Message-State: AOAM5315xG7vfZaMO5x9mH7s5NERDuojBaQnenDEpAqmRBcrCnOhfEsD
        ViuBi6Sv9AWrfaliYqheBeO2A5GJkto=
X-Google-Smtp-Source: ABdhPJwoW0FqVmxJqH6MjT8JiYpV8QeLbjHhvuKY/1xTwLhHOPRrNl6S2kOtFNWFNSQfvLVIKwiqOtORNPY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:f7bc:90c9:d86e:4ea8])
 (user=yuzhao job=sendgmr) by 2002:a25:8c87:0:b0:64a:870a:e29d with SMTP id
 m7-20020a258c87000000b0064a870ae29dmr24844386ybl.596.1652838417591; Tue, 17
 May 2022 18:46:57 -0700 (PDT)
Date:   Tue, 17 May 2022 19:46:21 -0600
In-Reply-To: <20220518014632.922072-1-yuzhao@google.com>
Message-Id: <20220518014632.922072-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v11 02/14] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
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
        linux-kernel@vger.kernel.org, x86@kernel.org,
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

Thanks to the following developers for their efforts [2][3].
  Randy Dunlap <rdunlap@infradead.org>
  Stephen Rothwell <sfr@canb.auug.org.au>

[1]: Intel 64 and IA-32 Architectures Software Developer's Manual
     Volume 3 (June 2021), section 4.8
[2] https://lore.kernel.org/r/bfdcc7c8-922f-61a9-aa15-7e7250f04af7@infradea=
d.org/
[3] https://lore.kernel.org/r/20220413151513.5a0d7a7e@canb.auug.org.au/

Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Barry Song <baohua@kernel.org>
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
 arch/Kconfig                   | 8 ++++++++
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/pgtable.h | 3 ++-
 arch/x86/mm/pgtable.c          | 5 ++++-
 include/linux/pgtable.h        | 4 ++--
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..8a2cb732b09e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1376,6 +1376,14 @@ config DYNAMIC_SIGFRAME
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
=20
+config ARCH_HAS_NONLEAF_PMD_YOUNG
+	bool
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
index 4bed3abf444d..fce1d9f41cc3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -86,6 +86,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index 016606a0cf20..9cb3cf4cf6dd 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -820,7 +820,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
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
2.36.0.550.gb090851708-goog

