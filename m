Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEFD5A1738
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiHYQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243390AbiHYQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E35BD09B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661446038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtxYVN1b73jxS32uO5RlU+EmZHH9eyqhBC2B1AT9Izo=;
        b=Oy0cAaFrw5H/bFldIXsN+YVUsnqUbUP7UlJsSiSvr7aD2Bh9osPBFQ5/OknfEOgcy9heYH
        EY1am7Tttma1Q2Vqw9ykIShqTsuA/JLipJYKmMYcjkI4Jdu4YYGBtzHGbuMp2PDZgMhrm8
        eN80H9n/uQegg5MVuPFrCb5awbZOpSA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-gOthU2mwMBair-ARSgbNrQ-1; Thu, 25 Aug 2022 12:47:07 -0400
X-MC-Unique: gOthU2mwMBair-ARSgbNrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F1371C09C9A;
        Thu, 25 Aug 2022 16:47:06 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0BE5492CA2;
        Thu, 25 Aug 2022 16:47:03 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 1/3] mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()
Date:   Thu, 25 Aug 2022 18:46:57 +0200
Message-Id: <20220825164659.89824-2-david@redhat.com>
In-Reply-To: <20220825164659.89824-1-david@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for a special flag that is not even properly documented to be
internal-only.

Let's just factor this check out and get rid of this flag. The separate
function has the nice benefit that we can centralize comments.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 16 +++++++++++++++-
 mm/gup.c           | 12 ++----------
 mm/huge_memory.c   |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 982f2607180b..8b85765d7a98 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2881,7 +2881,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 				 * and return without waiting upon it */
 #define FOLL_NOFAULT	0x80	/* do not fault in pages */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
-#define FOLL_NUMA	0x200	/* force NUMA hinting page fault */
 #define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
@@ -2997,6 +2996,21 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
 	return !PageAnonExclusive(page);
 }
 
+/*
+ * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
+ * a (NUMA hinting) fault is required.
+ */
+static inline bool gup_can_follow_protnone(unsigned int flags)
+{
+	/*
+	 * FOLL_FORCE has to be able to make progress even if the VMA is
+	 * inaccessible. Further, FOLL_FORCE access usually does not represent
+	 * application behaviour and we should avoid triggering NUMA hinting
+	 * faults.
+	 */
+	return flags & FOLL_FORCE;
+}
+
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..a1355dbd848e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -554,7 +554,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		migration_entry_wait(mm, pmd, address);
 		goto retry;
 	}
-	if ((flags & FOLL_NUMA) && pte_protnone(pte))
+	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
 		goto no_page;
 
 	page = vm_normal_page(vma, address, pte);
@@ -707,7 +707,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
-	if ((flags & FOLL_NUMA) && pmd_protnone(pmdval))
+	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
 		return no_page_table(vma, flags);
 
 retry_locked:
@@ -1153,14 +1153,6 @@ static long __get_user_pages(struct mm_struct *mm,
 
 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
 
-	/*
-	 * If FOLL_FORCE is set then do not force a full fault as the hinting
-	 * fault information is unrelated to the reference behaviour of a task
-	 * using the address space
-	 */
-	if (!(gup_flags & FOLL_FORCE))
-		gup_flags |= FOLL_NUMA;
-
 	do {
 		struct page *page;
 		unsigned int foll_flags = gup_flags;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e9414ee57c5b..482c1826e723 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1449,7 +1449,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 		return ERR_PTR(-EFAULT);
 
 	/* Full NUMA hinting faults to serialise migration in fault paths */
-	if ((flags & FOLL_NUMA) && pmd_protnone(*pmd))
+	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
 		return NULL;
 
 	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
-- 
2.37.1

