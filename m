Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526C5694E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiGFWBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiGFWA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:00:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BDA1A3AB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:00:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cdce3ed04so33177777b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Yske1o/9q5kvxCT6Do7fK+m0Z7RMKAIlwEA5dqQMV6o=;
        b=ScyLwm63xSUVYY78eVpIKf7E4l6uHPJ8SKqWyYLqNgfcQS9rJpZhYXa+GvIYC8VFxz
         2VFStSncvwevlF5a8SeHX4Xsz1oxV5uuYYiB5ijS1hgFnqmnWUZ92SAkit2dsdOrKkVm
         doRskpr19skWYdTit7iDaFWDHSkEjmp1FnyOwnhb4K1iob0FZUGliEmOjr11tQKlaxMl
         A7gk8PUbqgtBAB5FxJW674j5ErsQXUNEF0mV9mDiI18iHiW2zTe0Jvp4coFt/YGkO03P
         +mGZgU80OTVBNdIcmd9CUSdknj31pHlFfc27NA1Hoqf7YpOu3eL0SW+Jp946t/R7w6FH
         wLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Yske1o/9q5kvxCT6Do7fK+m0Z7RMKAIlwEA5dqQMV6o=;
        b=Wa9o3q5jcKHWZ2PemkB7DBj/4GtXBZtnogfSIJmIeCfuASmSlKxCPU5lizUaDuTCFw
         PkojdqgQVEhNHxx/uNWI1ZmmnBDdloiJFhDB/qWJi38IK7/kCKRwlqrLNq8fw632wY/G
         XjnG53JUXCI3WnrKuoIXvEnFILmmLxHgfjYtv7vUfkyf3Nq0rLDPabrffMAZXpxk3R2U
         mserCHnYZTSgQsfWCWEZ7ncXXr49vFONTV6FUglOgAGH6yPxenfFBi2sAuRN9uXGP5/M
         LjpmMvfe0XkfabJttJ1NVl6F/QoBvJyTRzzkMkPZmfx00JxVzc33wbrdFx5vZQ+q3uHK
         iTpA==
X-Gm-Message-State: AJIora+1AbF+KftBLy3Q3McVbMFGvCp3TCBLocmf4ee9ZpgyZdb+1irp
        noswyJisBJTKQck86Wu6pGS5QxBXZKA=
X-Google-Smtp-Source: AGRyM1uPiyB7rEJDdAsYAVesh6XcxF7m4/NOwgKHx35NtLh0WZv9A8PqKLV1Gu8X5xOooB/DS/0V1C1QSZU=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:b89c:e10a:466e:cf7d])
 (user=yuzhao job=sendgmr) by 2002:a25:390:0:b0:66e:b9c7:b46c with SMTP id
 138-20020a250390000000b0066eb9c7b46cmr172371ybd.505.1657144853349; Wed, 06
 Jul 2022 15:00:53 -0700 (PDT)
Date:   Wed,  6 Jul 2022 16:00:11 -0600
In-Reply-To: <20220706220022.968789-1-yuzhao@google.com>
Message-Id: <20220706220022.968789-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20220706220022.968789-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v13 02/14] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
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
index fcf9a41a4ef5..eaeec187bd6a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1403,6 +1403,14 @@ config DYNAMIC_SIGFRAME
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
index be0b95e51df6..5715111abe13 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index dc5f7d8ef68a..5059799bebe3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -815,7 +815,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
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
index a932d7712d85..8525f2876fb4 100644
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
index 8eee31bc9bde..9c57c5cc49c2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -213,7 +213,7 @@ static inline int ptep_test_and_clear_young(struct vm_a=
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
@@ -234,7 +234,7 @@ static inline int pmdp_test_and_clear_young(struct vm_a=
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
2.37.0.rc0.161.g10f37bed90-goog

