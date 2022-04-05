Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481AB4F2164
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiDECnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiDECnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD1F115AE08
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2+qvTtHyC51V4BqYHYp23OrN7TjCUKrDVYDSF5MCVo=;
        b=QO0o1JQvBza6CEXpx7zPbkJm3vwfrMlNuAThhvXiyZyyN7c/9RkWRkdiHuZiW5ra7GzcYA
        4tfXznHUKOGjguLOJSbXIgNqNi496shVNmDjL4afyplJ8pf77jNxkLlrvAvWEfV6iFkjTP
        fSmFvty/68zwamcXFZxp9DgsdBJggKU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-8HGma5BuNPaemgpB245Rrw-1; Mon, 04 Apr 2022 21:48:54 -0400
X-MC-Unique: 8HGma5BuNPaemgpB245Rrw-1
Received: by mail-il1-f200.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso7181864ilu.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2+qvTtHyC51V4BqYHYp23OrN7TjCUKrDVYDSF5MCVo=;
        b=hDzpImuEbXQehT0BXGidS8eXFKxniUbLYfFKy9CuPTvWxKKAqAQWWfxnst/eWoj/T+
         uNJYNtzYscuVsB+RQKx63IIEcboydjKfBRSB8kNyiuhBcTDTPFwAYjm8iRcI3cEk3xvp
         FwBe5gK+uFFu2Tfi4wQcMtau96xhWpZ25D56uJFnL5/Exrh8f0DMmwQKmaHu0YIv3m9F
         294fyKW7e2+3/cp+JCXBh3+7KUB2qx00pQHFg7Z2pXr+sL7NS+IofcmW/ZH6MwG00gg8
         I267q5UBU7MSBFwzuqbuRf+TDrB3BQgxiFSs+B/J76YD+Ng+2wm0huugE2VshmNM96YK
         3OVg==
X-Gm-Message-State: AOAM532/vbF5sdCQES/EMtA9lTjaecQsCeCAiYgTtd8gnb0vyFwA/QV9
        MR7PfnZSBUOVSJz3k/Gqa8IOPRFYqByevp+OVxyQpHGHegN/+bccj5+curXIz5LriwQz+jx6Q0M
        ic+Q515Wsx5oWk/bbS3LRtHEwBWyYUa7M6nRU2A9W5KbTVKBksTZbjQsRiC4JtqsVB/1/fYd8lw
        ==
X-Received: by 2002:a05:6602:14cb:b0:646:3b7d:6aee with SMTP id b11-20020a05660214cb00b006463b7d6aeemr609375iow.178.1649123332981;
        Mon, 04 Apr 2022 18:48:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC5SfA3HnFu2jqAo60amfsdIfOUDVqgatfBUTtv0HUIBqFTM3g2TfSh/uOX6Ux3OnPnNRg4g==
X-Received: by 2002:a05:6602:14cb:b0:646:3b7d:6aee with SMTP id b11-20020a05660214cb00b006463b7d6aeemr609348iow.178.1649123332673;
        Mon, 04 Apr 2022 18:48:52 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g9-20020a056e020d0900b002ca5573dfe8sm514842ilj.22.2022.04.04.18.48.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:52 -0700 (PDT)
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
Subject: [PATCH v8 08/23] mm/shmem: Allow uffd wr-protect none pte for file-backed mem
Date:   Mon,  4 Apr 2022 21:48:50 -0400
Message-Id: <20220405014850.14352-1-peterx@redhat.com>
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

File-backed memory differs from anonymous memory in that even if the pte is
missing, the data could still resides either in the file or in page/swap cache.
So when wr-protect a pte, we need to consider none ptes too.

We do that by installing the uffd-wp pte markers when necessary.  So when
there's a future write to the pte, the fault handler will go the special path
to first fault-in the page as read-only, then report to userfaultfd server with
the wr-protect message.

On the other hand, when unprotecting a page, it's also possible that the pte
got unmapped but replaced by the special uffd-wp marker.  Then we'll need to be
able to recover from a uffd-wp pte marker into a none pte, so that the next
access to the page will fault in correctly as usual when accessed the next
time.

Special care needs to be taken throughout the change_protection_range()
process.  Since now we allow user to wr-protect a none pte, we need to be able
to pre-populate the page table entries if we see (!anonymous && MM_CP_UFFD_WP)
requests, otherwise change_protection_range() will always skip when the pgtable
entry does not exist.

For example, the pgtable can be missing for a whole chunk of 2M pmd, but the
page cache can exist for the 2M range.  When we want to wr-protect one 4K page
within the 2M pmd range, we need to pre-populate the pgtable and install the
pte marker showing that we want to get a message and block the thread when the
page cache of that 4K page is written.  Without pre-populating the pmd,
change_protection() will simply skip that whole pmd.

Note that this patch only covers the small pages (pte level) but not covering
any of the transparent huge pages yet.  That will be done later, and this patch
will be a preparation for it too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 709a6f73b764..bd62d5938c6c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -30,6 +30,7 @@
 #include <linux/mm_inline.h>
 #include <linux/pgtable.h>
 #include <linux/sched/sysctl.h>
+#include <linux/userfaultfd_k.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -188,8 +189,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					newpte = pte_swp_mksoft_dirty(newpte);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
-			} else if (is_pte_marker_entry(entry)) {
-				/* Skip it, the same as none pte */
+			} else if (pte_marker_entry_uffd_wp(entry)) {
+				/*
+				 * If this is uffd-wp pte marker and we'd like
+				 * to unprotect it, drop it; the next page
+				 * fault will trigger without uffd trapping.
+				 */
+				if (uffd_wp_resolve) {
+					pte_clear(vma->vm_mm, addr, pte);
+					pages++;
+				}
 				continue;
 			} else {
 				newpte = oldpte;
@@ -204,6 +213,20 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
+		} else {
+			/* It must be an none page, or what else?.. */
+			WARN_ON_ONCE(!pte_none(oldpte));
+			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect a none pte, because even if the
+				 * pte is none, the page/swap cache could
+				 * exist.  Doing that by install a marker.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   make_pte_marker(PTE_MARKER_UFFD_WP));
+				pages++;
+			}
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
@@ -237,6 +260,39 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
+/* Return true if we're uffd wr-protecting file-backed memory, or false */
+static inline bool
+uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
+{
+	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
+}
+
+/*
+ * If wr-protecting the range for file-backed, populate pgtable for the case
+ * when pgtable is empty but page cache exists.  When {pte|pmd|...}_alloc()
+ * failed it means no memory, we don't have a better option but stop.
+ */
+#define  change_pmd_prepare(vma, pmd, cp_flags)				\
+	do {								\
+		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+			if (WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd)))	\
+				break;					\
+		}							\
+	} while (0)
+/*
+ * This is the general pud/p4d/pgd version of change_pmd_prepare(). We need to
+ * have separate change_pmd_prepare() because pte_alloc() returns 0 on success,
+ * while {pmd|pud|p4d}_alloc() returns the valid pointer on success.
+ */
+#define  change_prepare(vma, high, low, addr, cp_flags)			\
+	do {								\
+		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+			low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
+			if (WARN_ON_ONCE(p == NULL))			\
+				break;					\
+		}							\
+	} while (0)
+
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
@@ -255,6 +311,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 		next = pmd_addr_end(addr, end);
 
+		change_pmd_prepare(vma, pmd, cp_flags);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -320,6 +377,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		change_prepare(vma, pud, pmd, addr, cp_flags);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
@@ -340,6 +398,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
+		change_prepare(vma, p4d, pud, addr, cp_flags);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
@@ -365,6 +424,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	inc_tlb_flush_pending(mm);
 	do {
 		next = pgd_addr_end(addr, end);
+		change_prepare(vma, pgd, p4d, addr, cp_flags);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-- 
2.32.0

