Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A54CCCE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiCDFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbiCDFSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:18:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C1115A11
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCL3KButghAabZJudedPY5ytCZQMosbpyIRioh4blvI=;
        b=OZ/8KC/oFGtaJEm8fgiGpsGBZhrH1+4xALXGN/2CI5z/peeeXH/nCSExQo4IJ7bO/Eex3R
        YEv5vovVvN1mmu/JmYezjoIa9sESWR1cBlVvni1n3hlTeETOkUDB7iTwdEl6+G2xe2Lmkk
        gACIp1bqia+c20/WKaWxcZFI8S+C/H8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-iqUB8XQHNZ-kYkVE-BhsYQ-1; Fri, 04 Mar 2022 00:17:32 -0500
X-MC-Unique: iqUB8XQHNZ-kYkVE-BhsYQ-1
Received: by mail-pf1-f200.google.com with SMTP id i72-20020a62874b000000b004f66c5b963cso2695112pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCL3KButghAabZJudedPY5ytCZQMosbpyIRioh4blvI=;
        b=2oiGOQQ/XD404kg5qvo6lwGou3c09zn9tE6zigcdarx7B829caw9HIQ3izRu2qF6bn
         RqJq3rf5/wAjhA/byw1nK6ZTEYJetk9n1kphbQOrglsjUawrIrPa1+ykXOE2aDpcYbda
         FduD0adhmJSYaCBvjvsudoBVQ9nO1MxsknQ0aekiJZeAPWlbc5Rw/Akzh7fxu+fF2+RN
         6D0XfhY7VfTXGZAjhHJ/3rxsVseZjIgjEXsTQFTfKen5UyzXE8CYdZ2WmDdCzecvQbiM
         oB0i7Jf9m3iLGrU4wbwFVCfnVwSP7xa3PKPKW3ZMhdti2sFJiL2V3DWkTTZdcFiawIZc
         kBuA==
X-Gm-Message-State: AOAM532H5+cwnbyIJ/pN+5aGs7R0Wi3FDPm9I7KV3KdX3+mjYZPQSsAv
        htSv7oD+QMJvSMdhdi/lrjeC92K7Sr7c0Kn/vBA3WJlm7HW6YUd20FjocUd8GTa7hAtWYMJ4+Y/
        FD7qI0t/c00G2XP0pbUgD0QTG
X-Received: by 2002:a63:2fc1:0:b0:374:9f30:9559 with SMTP id v184-20020a632fc1000000b003749f309559mr33022345pgv.278.1646371050818;
        Thu, 03 Mar 2022 21:17:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJym7Td/RpnBv1y2IaKZPLGC+ETMIqu+l9tJA1ieJk002T9FcPI25/B0PQuSJLNVv/X4K+wkwg==
X-Received: by 2002:a63:2fc1:0:b0:374:9f30:9559 with SMTP id v184-20020a632fc1000000b003749f309559mr33022332pgv.278.1646371050512;
        Thu, 03 Mar 2022 21:17:30 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.17.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:17:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 01/23] mm: Introduce PTE_MARKER swap entry
Date:   Fri,  4 Mar 2022 13:16:46 +0800
Message-Id: <20220304051708.86193-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new swap entry type called PTE_MARKER.  It can be
installed for any pte that maps a file-backed memory when the pte is
temporarily zapped, so as to maintain per-pte information.

The information that kept in the pte is called a "marker".  Here we define the
marker as "unsigned long" just to match pgoff_t, however it will only work if
it still fits in swp_offset(), which is e.g. currently 58 bits on x86_64.

A new config CONFIG_PTE_MARKER is introduced too; it's by default off.  A bunch
of helpers are defined altogether to service the rest of the pte marker code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h |  9 ++++
 include/linux/swap.h          | 15 ++++++-
 include/linux/swapops.h       | 78 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  7 ++++
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..f39cad20ffc6 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_GENERIC_HUGETLB_H
 #define _ASM_GENERIC_HUGETLB_H
 
+#include <linux/swap.h>
+#include <linux/swapops.h>
+
 static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
 {
 	return mk_pte(page, pgprot);
@@ -80,6 +83,12 @@ static inline int huge_pte_none(pte_t pte)
 }
 #endif
 
+/* Please refer to comments above pte_none_mostly() for the usage */
+static inline int huge_pte_none_mostly(pte_t pte)
+{
+	return huge_pte_none(pte) || is_pte_marker(pte);
+}
+
 #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 42ebe2d6078d..20b4aceed920 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -55,6 +55,19 @@ static inline int current_is_kswapd(void)
  * actions on faults.
  */
 
+/*
+ * PTE markers are used to persist information onto PTEs that are mapped with
+ * file-backed memories.  As its name "PTE" hints, it should only be applied to
+ * the leaves of pgtables.
+ */
+#ifdef CONFIG_PTE_MARKER
+#define SWP_PTE_MARKER_NUM 1
+#define SWP_PTE_MARKER     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
+			    SWP_MIGRATION_NUM + SWP_DEVICE_NUM)
+#else
+#define SWP_PTE_MARKER_NUM 0
+#endif
+
 /*
  * Unaddressable device memory support. See include/linux/hmm.h and
  * Documentation/vm/hmm.rst. Short description is we need struct pages for
@@ -100,7 +113,7 @@ static inline int current_is_kswapd(void)
 
 #define MAX_SWAPFILES \
 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
-	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)
+	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
 
 /*
  * Magic header for a swap area. The first part of the union is
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d356ab4047f7..5103d2a4ae38 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -247,6 +247,84 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
 
 #endif
 
+typedef unsigned long pte_marker;
+
+#define  PTE_MARKER_MASK     (0)
+
+#ifdef CONFIG_PTE_MARKER
+
+static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
+{
+	return swp_entry(SWP_PTE_MARKER, marker);
+}
+
+static inline bool is_pte_marker_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_PTE_MARKER;
+}
+
+static inline pte_marker pte_marker_get(swp_entry_t entry)
+{
+	return swp_offset(entry) & PTE_MARKER_MASK;
+}
+
+static inline bool is_pte_marker(pte_t pte)
+{
+	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
+}
+
+#else /* CONFIG_PTE_MARKER */
+
+static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
+{
+	/* This should never be called if !CONFIG_PTE_MARKER */
+	WARN_ON_ONCE(1);
+	return swp_entry(0, 0);
+}
+
+static inline bool is_pte_marker_entry(swp_entry_t entry)
+{
+	return false;
+}
+
+static inline pte_marker pte_marker_get(swp_entry_t entry)
+{
+	return 0;
+}
+
+static inline bool is_pte_marker(pte_t pte)
+{
+	return false;
+}
+
+#endif /* CONFIG_PTE_MARKER */
+
+static inline pte_t make_pte_marker(pte_marker marker)
+{
+	return swp_entry_to_pte(make_pte_marker_entry(marker));
+}
+
+/*
+ * This is a special version to check pte_none() just to cover the case when
+ * the pte is a pte marker.  It existed because in many cases the pte marker
+ * should be seen as a none pte; it's just that we have stored some information
+ * onto the none pte so it becomes not-none any more.
+ *
+ * It should be used when the pte is file-backed, ram-based and backing
+ * userspace pages, like shmem.  It is not needed upon pgtables that do not
+ * support pte markers at all.  For example, it's not needed on anonymous
+ * memory, kernel-only memory (including when the system is during-boot),
+ * non-ram based generic file-system.  It's fine to be used even there, but the
+ * extra pte marker check will be pure overhead.
+ *
+ * For systems configured with !CONFIG_PTE_MARKER this will be automatically
+ * optimized to pte_none().
+ */
+static inline int pte_none_mostly(pte_t pte)
+{
+	return pte_none(pte) || is_pte_marker(pte);
+}
+
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset(entry));
diff --git a/mm/Kconfig b/mm/Kconfig
index c313bad5167a..25bcbb89f8e5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -900,6 +900,13 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config PTE_MARKER
+	def_bool n
+	bool "Marker PTEs support"
+
+	help
+	  Allows to create marker PTEs for file-backed memory.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.32.0

