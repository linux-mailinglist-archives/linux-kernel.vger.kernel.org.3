Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547A24CCCED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiCDFTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiCDFTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8925E9A995
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQXe4rml5LknCAC9VWmfIhmJrE0oVG26j9HM2k7VJ/Y=;
        b=QEW/oiNnGDnL8Fb07kMj0s66sF+eblaRjPoVOM7U8v/FPiRmXWddMNSievE3IpxDSc/9kE
        ZUfNnFfvzUDdeKXoW2UO3DGUiqKWlSvOxYZVSDGrjjitmYYVhwObwisry6jqIjlGw+0dJi
        IEatfeg5/MARZCpCHp0tsY4Xxlr3C7k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-FOjqB8vdNTeTycsD9nA67A-1; Fri, 04 Mar 2022 00:18:28 -0500
X-MC-Unique: FOjqB8vdNTeTycsD9nA67A-1
Received: by mail-pl1-f197.google.com with SMTP id j3-20020a170902da8300b0014fdd4e979cso4095854plx.17
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQXe4rml5LknCAC9VWmfIhmJrE0oVG26j9HM2k7VJ/Y=;
        b=Mr8eUexr9OaX69cj/z9dKG98bWAD3Sm+/TtrPt3a0ZVFEIfidv7TcVzjdX1qm29tbh
         U+940Diod1ls8jlLbds26zbn5dGtSOZLCCpx7GaCp85lsZhDrPPw1BAxIDq6v9dJnPAM
         v7FE2EX7F7GgFJU3PsmwDAruQ61Z3C8mNnh4bnK9cR/rB+gcReYeG/2RRkiQpSX5KxpK
         cPn5rQ88SDS2iQQQdl3hx4YCKlkMt1Ptg4F1DW0iS1o13LvC0oZnu5rltxHU78hel7hJ
         LxJnVpA0BRtUJwz1ZVmbc1TFBHpMf3wGC6fCCO1BeJJjL8fnyoVULNEFy7CwO2w6uXk6
         +dGA==
X-Gm-Message-State: AOAM531dJ1+OI2Y3Huh5845YI1BrSwZOudG4Il+E0Q7jz4ulHU7fr4sz
        Zbd01w3OaFZnT3ANkx0mTQ2mtb+sK2gA2LtGJFUTJFJ5KuXE/4157kp/9pozYaOrssIXGhS7yqY
        SdGu7aqPrwSB+oBisQjLgyG7M
X-Received: by 2002:a17:903:2285:b0:151:4b38:298e with SMTP id b5-20020a170903228500b001514b38298emr29450205plh.36.1646371107399;
        Thu, 03 Mar 2022 21:18:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWOXIBo4RzUqL6IP5zCBIf1bLH01fWQdczZaceP2UrGilCNmkw3HF88pBzciWEi4lBzLO6HQ==
X-Received: by 2002:a17:903:2285:b0:151:4b38:298e with SMTP id b5-20020a170903228500b001514b38298emr29450185plh.36.1646371107064;
        Thu, 03 Mar 2022 21:18:27 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:26 -0800 (PST)
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
Subject: [PATCH v7 08/23] mm/shmem: Allow uffd wr-protect none pte for file-backed mem
Date:   Fri,  4 Mar 2022 13:16:53 +0800
Message-Id: <20220304051708.86193-9-peterx@redhat.com>
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
index 6d179c720089..4878b6b99df9 100644
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
@@ -184,8 +185,16 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -200,6 +209,20 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -233,6 +256,39 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
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
@@ -251,6 +307,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 		next = pmd_addr_end(addr, end);
 
+		change_pmd_prepare(vma, pmd, cp_flags);
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
 		 * held for read. It's possible a parallel update to occur
@@ -316,6 +373,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
+		change_prepare(vma, pud, pmd, addr, cp_flags);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
@@ -336,6 +394,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
+		change_prepare(vma, p4d, pud, addr, cp_flags);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
@@ -361,6 +420,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	inc_tlb_flush_pending(mm);
 	do {
 		next = pgd_addr_end(addr, end);
+		change_prepare(vma, pgd, p4d, addr, cp_flags);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-- 
2.32.0

