Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50E14F21C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiDECnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiDECnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A986D71EC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8n+4P5JjRaDUHKZYY8oH8Iy0i6vYl4G2VE7hAdGm3Q=;
        b=XYqWP2IOZP/UU5FPWFCBJQ+q+zF2wpogoTeForttZeLMTkUrGMwdtJnR7genFKEeb05hwc
        lt5UInW0d31rmawsfOkUEBThCp3Z6dijJ+LzZ9tlfjS085b8UyAFOfxq1sjP7aNUsaFIZ1
        KAFDK9UfESZsZt9k6Uqfa+Fke85QaHw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-lQqqXMKxPqeKenshi0aNSQ-1; Mon, 04 Apr 2022 21:48:42 -0400
X-MC-Unique: lQqqXMKxPqeKenshi0aNSQ-1
Received: by mail-il1-f197.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so7180847ilc.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8n+4P5JjRaDUHKZYY8oH8Iy0i6vYl4G2VE7hAdGm3Q=;
        b=HEMA8i7TF0pjLLZqzLr5xJWLbup3atpL/gXuGYUHqk9Ed236hX0Hu3MvrioldgKHXY
         uiU9bnuOCz6ImkCVmFRTwTKsPHz9CVXbHNl6BLnn6KLbIdFwDIIitDSlxPseKPDwUVHU
         RNu+d6YI0xh6ihdBJ8sTD9/eWsMSUo+CjoRbOMfrAGjY54TdT0YTQI+lzZu0UwRzcbPJ
         WBaPiIZUdIPMaV/URgyc3yqv9QVo52y4Iux2hHFfMNQ6iF/BfB6h7/BLJNwQSVetTxv5
         UGYvBcfRmkbdZaPclbW0aLr105GUQO19UxZJ2fWvrDbWbh1oXGnuBZyG+9JZSxeMXVa8
         ik4A==
X-Gm-Message-State: AOAM531YOvelJf6gXc4y+1C78YHevJrKiyBJ1tGOuvVjWr4U/BwyBHW6
        JtuMFp3S+FLhkPyArEFIyRBlYBjYe86XpweUa9Wyv01ugHnOdr50sSiV3Lsr0hYAJZypnvI9lB0
        OfuFnzzrha0nDmJdeAqMGraAmrnP6Cwqd/tV9NCrrg6j0ssrXlib5kkG/Og5NGOEbQvf5rM2HdQ
        ==
X-Received: by 2002:a05:6602:490:b0:638:c8ed:1e38 with SMTP id y16-20020a056602049000b00638c8ed1e38mr589245iov.202.1649123321824;
        Mon, 04 Apr 2022 18:48:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBgvwBVvGE1Vqojm5+pnVWt3lmiOe9Zr6Q3Q9kFVvDL2PkJIvmVaEpRNWmsAlmIdguH9c/+A==
X-Received: by 2002:a05:6602:490:b0:638:c8ed:1e38 with SMTP id y16-20020a056602049000b00638c8ed1e38mr589217iov.202.1649123321422;
        Mon, 04 Apr 2022 18:48:41 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s5-20020a056602168500b0064c82210ce4sm7650607iow.13.2022.04.04.18.48.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 04/23] mm/uffd: PTE_MARKER_UFFD_WP
Date:   Mon,  4 Apr 2022 21:48:38 -0400
Message-Id: <20220405014838.14131-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the 1st user of pte marker: the uffd-wp marker.

When the pte marker is installed with the uffd-wp bit set, it means this pte
was wr-protected by uffd.

We will use this special pte to arm the ptes that got either unmapped or
swapped out for a file-backed region that was previously wr-protected.  This
special pte could trigger a page fault just like swap entries.

This idea is greatly inspired by Hugh and Andrea in the discussion, which is
referenced in the links below.

Some helpers are introduced to detect whether a swap pte is uffd wr-protected.
After the pte marker introduced, one swap pte can be wr-protected in two forms:
either it is a normal swap pte and it has _PAGE_SWP_UFFD_WP set, or it's a pte
marker that has PTE_MARKER_UFFD_WP set.

Link: https://lore.kernel.org/lkml/20201126222359.8120-1-peterx@redhat.com/
Link: https://lore.kernel.org/lkml/20201130230603.46187-1-peterx@redhat.com/
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h       |  3 ++-
 include/linux/userfaultfd_k.h | 43 +++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  9 ++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7a00627845f0..fffbba0036f6 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -276,7 +276,8 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
 
 typedef unsigned long pte_marker;
 
-#define  PTE_MARKER_MASK     (0)
+#define  PTE_MARKER_UFFD_WP  BIT(0)
+#define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
 
 #ifdef CONFIG_PTE_MARKER
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 33cea484d1ad..bd09c3c89b59 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -15,6 +15,8 @@
 
 #include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <asm-generic/pgtable_uffd.h>
 
 /* The set of all possible UFFD-related VM flags. */
@@ -236,4 +238,45 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 
 #endif /* CONFIG_USERFAULTFD */
 
+static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
+{
+	return is_pte_marker_entry(entry) &&
+	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
+}
+
+static inline bool pte_marker_uffd_wp(pte_t pte)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	swp_entry_t entry;
+
+	if (!is_swap_pte(pte))
+		return false;
+
+	entry = pte_to_swp_entry(pte);
+
+	return pte_marker_entry_uffd_wp(entry);
+#else
+	return false;
+#endif
+}
+
+/*
+ * Returns true if this is a swap pte and was uffd-wp wr-protected in either
+ * forms (pte marker or a normal swap pte), false otherwise.
+ */
+static inline bool pte_swp_uffd_wp_any(pte_t pte)
+{
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
+	if (!is_swap_pte(pte))
+		return false;
+
+	if (pte_swp_uffd_wp(pte))
+		return true;
+
+	if (pte_marker_uffd_wp(pte))
+		return true;
+#endif
+	return false;
+}
+
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index a1688b9314b2..6e7c2d59fa96 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -915,6 +915,15 @@ config PTE_MARKER
 	help
 	  Allows to create marker PTEs for file-backed memory.
 
+config PTE_MARKER_UFFD_WP
+	bool "Marker PTEs support for userfaultfd write protection"
+	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
+
+	help
+	  Allows to create marker PTEs for userfaultfd write protection
+	  purposes.  It is required to enable userfaultfd write protection on
+	  file-backed memory types like shmem and hugetlbfs.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.32.0

