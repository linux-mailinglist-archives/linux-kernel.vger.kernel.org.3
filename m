Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBDE4F211B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiDECl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiDEClp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A36F521D05E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pI9cWciCmYBnmPhneotwA4BwtHRdfFIYJm9g8S6gDqg=;
        b=W3AXKKht0wSd9/Tv9Q0EJtVtRX6u7CG7jeB5BnN2d384jQVVXl15WgI8ykrzdM5DBkM7gk
        Q0k/iW8kGiLfISKpAD8FpFicYwV1S+ONHuLxgE0hwoSl/NiRU2RHSUaePpTIlDcsGH7cB8
        RbDcY1J3vv6jaF9w5tsUbtbYzLwFQc8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-Xvua7ITMMFCqh6jC0Xtevg-1; Mon, 04 Apr 2022 21:46:52 -0400
X-MC-Unique: Xvua7ITMMFCqh6jC0Xtevg-1
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso7429991ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pI9cWciCmYBnmPhneotwA4BwtHRdfFIYJm9g8S6gDqg=;
        b=Cgk5JmWeJVjAG9VllYyOldh83LGBa+38IIvRIW8gKwAGXkX8lkQvLxxNc0WcO1SHMv
         aOgHshHJMg8StYEADjYIkvx9n6VDf1TTCZDoy9ePFe5U8VTJOIFxnPg/+Fa1Ou6HnPdd
         L1Sa/zipxSMJvTMAszXqe7LEtKgCMfUqZTeL/0IkHrmZi30H/BsRfl1gnEcz8M8MugqB
         aTPwj9Lu85glDkAITqT8VHckVhUvFBnWUW6sobDisJBvWXZyJ9+DyLG7jkdWiJdxmlHy
         HSq5PkDmRjBhgWgsXeEe2VFOo+FKmpWkqGm0NV065YZCdqQXT0CSIWTMVJzMAPWs6en4
         yGfQ==
X-Gm-Message-State: AOAM532hl88KpqwUJZ7Xkhs6OWnZEnC2X/57dlVZf9xq/qLfnvbjGE85
        1QNNduVtPL/3vp6rSWjMGjk3y1IdH8dgJvObMt/J5CEv+4YteV9r7fzc2CfzyPeDPtWQ0E6zcWZ
        8QvyLWa8dbBfDDuEweiprjibWFVbN69iKdzMdFKmbHmVBRAuhukqnZGKVaFh9savUDG9DvZrJjA
        ==
X-Received: by 2002:a92:cdaf:0:b0:2ca:1fe0:333f with SMTP id g15-20020a92cdaf000000b002ca1fe0333fmr562675ild.173.1649123211357;
        Mon, 04 Apr 2022 18:46:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwDD4n8m40Y7RHhjN5HSEe+GsrzZ5EezHVdV8pG6lXvRYBwaehy8cbB+ODTD7LlpiU1TD9xA==
X-Received: by 2002:a92:cdaf:0:b0:2ca:1fe0:333f with SMTP id g15-20020a92cdaf000000b002ca1fe0333fmr562650ild.173.1649123211093;
        Mon, 04 Apr 2022 18:46:51 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm7556676ioi.25.2022.04.04.18.46.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:46:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v8 01/23] mm: Introduce PTE_MARKER swap entry
Date:   Mon,  4 Apr 2022 21:46:24 -0400
Message-Id: <20220405014646.13522-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 mm/Kconfig                    |  6 +++
 4 files changed, 107 insertions(+), 1 deletion(-)

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
index 7daae5a4b3e1..5553189d0215 100644
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
@@ -107,7 +120,7 @@ static inline int current_is_kswapd(void)
 
 #define MAX_SWAPFILES \
 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
-	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM)
+	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
 
 /*
  * Magic header for a swap area. The first part of the union is
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 32d517a28969..7a00627845f0 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -274,6 +274,84 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
 
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
index 034d87953600..a1688b9314b2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -909,6 +909,12 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config PTE_MARKER
+	bool "Marker PTEs support"
+
+	help
+	  Allows to create marker PTEs for file-backed memory.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.32.0

