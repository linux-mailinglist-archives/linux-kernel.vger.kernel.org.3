Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D814D9D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbiCOOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349120AbiCOOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D551750B15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647353956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fCgJg7id0ExabGCMvT39C6jmUmXD3+Z3spzphLwh+3A=;
        b=QGJ6zaYun4vwVFSioH5USr9cxJE1dbW+v2IR4kqTv+95RzFsdW6xfikg5B1DS7bpFd/T9w
        +TeoxQTK189K0BJio2NWhrWfaVyqUpoD+z+d6LOU/lBJYkh5xsuJe7HHL3rkY/O4XajY4R
        IIoogKGkLZ7qATmAkyI6lp61brlwYOU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-cpSV8RIgNtyurFg1q55rhQ-1; Tue, 15 Mar 2022 10:19:14 -0400
X-MC-Unique: cpSV8RIgNtyurFg1q55rhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5E8A3C14CD2;
        Tue, 15 Mar 2022 14:19:12 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84EC64087D7E;
        Tue, 15 Mar 2022 14:19:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/7] x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue, 15 Mar 2022 15:18:33 +0100
Message-Id: <20220315141837.137118-4-david@redhat.com>
In-Reply-To: <20220315141837.137118-1-david@redhat.com>
References: <20220315141837.137118-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use bit 3 to remember PG_anon_exclusive in swap ptes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/include/asm/pgtable.h       | 16 ++++++++++++++++
 arch/x86/include/asm/pgtable_64.h    |  4 +++-
 arch/x86/include/asm/pgtable_types.h |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8a9432fb3802..0c676da4babb 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1291,6 +1291,22 @@ static inline void update_mmu_cache_pud(struct vm_area_struct *vma,
 {
 }
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return pte_set_flags(pte, _PAGE_SWP_EXCLUSIVE);
+}
+
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_flags(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return pte_clear_flags(pte, _PAGE_SWP_EXCLUSIVE);
+}
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
 {
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 56d0399a0cd1..e479491da8d5 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -186,7 +186,7 @@ static inline void native_pgd_clear(pgd_t *pgd)
  *
  * |     ...            | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
  * |     ...            |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
- * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| X|F|SD|0| <- swp entry
+ * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| E|F|SD|0| <- swp entry
  *
  * G (8) is aliased and used as a PROT_NONE indicator for
  * !present ptes.  We need to start storing swap entries above
@@ -203,6 +203,8 @@ static inline void native_pgd_clear(pgd_t *pgd)
  * F (2) in swp entry is used to record when a pagetable is
  * writeprotected by userfaultfd WP support.
  *
+ * E (3) in swp entry is used to rememeber PG_anon_exclusive.
+ *
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
  *
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..54a8f370046d 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -83,6 +83,11 @@
 #define _PAGE_SOFT_DIRTY	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * We borrow bit 3 to remember PG_anon_exclusive.
+ */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_PWT
+
 /*
  * Tracking soft dirty bit when a page goes to a swap is tricky.
  * We need a bit which can be stored in pte _and_ not conflict
-- 
2.35.1

