Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A84D9D56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbiCOOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349163AbiCOOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03D6954BEF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647353982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMfZOVQVS5I2zZPcY9Fdh37ujSfx4fPUK1QRVEaCA5k=;
        b=ieC7f8slgsXCRAjSx2/5h2ZrF945fFKRRwAOqzEOQVLGVUjwDNoHrX+4EyhlgiBLj9yMTb
        h8wMIXyMYmCpS6QjyKMeExcbT5sEwnv1Q0/X4TSx1VgiIYanL8fLYNVLE3DskE8G191gwi
        8vzfg2pJ4dm7fIcxtnvAUNRHLLPUmiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-AZN94ZEqNGCaFqi4fTYG_g-1; Tue, 15 Mar 2022 10:19:40 -0400
X-MC-Unique: AZN94ZEqNGCaFqi4fTYG_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B9EF18E0043;
        Tue, 15 Mar 2022 14:19:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6428240F9D53;
        Tue, 15 Mar 2022 14:19:30 +0000 (UTC)
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
Subject: [PATCH v1 6/7] powerpc/pgtable: remove _PAGE_BIT_SWAP_TYPE for book3s
Date:   Tue, 15 Mar 2022 15:18:36 +0100
Message-Id: <20220315141837.137118-7-david@redhat.com>
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

The swap type is simply stored in bits 0x1f of the swap pte. Let's
simplify by just getting rid of _PAGE_BIT_SWAP_TYPE. It's not like that
we can simply change it: _PAGE_SWP_SOFT_DIRTY would suddenly fall into
_RPAGE_RSV1, which isn't possible and would make the
BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY) angry.

While at it, make it clearer which bit we're actually using for
_PAGE_SWP_SOFT_DIRTY by just using the proper define and introduce and
use SWP_TYPE_MASK.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 875730d5af40..8e98375d5c4a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -13,7 +13,6 @@
 /*
  * Common bits between hash and Radix page table
  */
-#define _PAGE_BIT_SWAP_TYPE	0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
@@ -751,17 +750,16 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
 	 * We filter HPTEFLAGS on set_pte.			\
 	 */							\
-	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & SWP_TYPE_MASK); \
 	BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
 	} while (0)
 
 #define SWP_TYPE_BITS 5
-#define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
-				& ((1UL << SWP_TYPE_BITS) - 1))
+#define SWP_TYPE_MASK		((1UL << SWP_TYPE_BITS) - 1)
+#define __swp_type(x)		((x).val & SWP_TYPE_MASK)
 #define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PAGE_SHIFT)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
-				((type) << _PAGE_BIT_SWAP_TYPE) \
-				| (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
+				(type) | (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
 /*
  * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
  * swap type and offset we get from swap and convert that to pte to find a
@@ -774,7 +772,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define __swp_entry_to_pmd(x)	(pte_pmd(__swp_entry_to_pte(x)))
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
+#define _PAGE_SWP_SOFT_DIRTY	_PAGE_NON_IDEMPOTENT
 #else
 #define _PAGE_SWP_SOFT_DIRTY	0UL
 #endif /* CONFIG_MEM_SOFT_DIRTY */
-- 
2.35.1

