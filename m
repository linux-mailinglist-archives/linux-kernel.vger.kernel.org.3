Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240D4D99B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347217AbiCOKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbiCOKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC2BC39B85
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647341599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv56vnJpljRcaCMIQ0NnfuW6KA/TkSLGs2Q5wx0q2yM=;
        b=ilUK6fOsP4y4B6pLKonN+JY+T+3fqodipQcBLtlNzkMutMVs/qrpQY15FkYmRFlNM32y1J
        T2trpyTihYhluaXEhOPFJ7K1ewr4amutT4MAZ7QW6MQld4Y4DXPWYJ1ROdubB+FnmsQE4e
        2rf/SFGCvxnLSSOXFxGLU+yGZesTO2U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-rDQ-TgvOPp-z54SJuvrWOQ-1; Tue, 15 Mar 2022 06:53:16 -0400
X-MC-Unique: rDQ-TgvOPp-z54SJuvrWOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 678A3185A7BA;
        Tue, 15 Mar 2022 10:53:15 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 088CD9E94;
        Tue, 15 Mar 2022 10:52:46 +0000 (UTC)
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 12/15] mm/gup: disallow follow_page(FOLL_PIN)
Date:   Tue, 15 Mar 2022 11:47:38 +0100
Message-Id: <20220315104741.63071-13-david@redhat.com>
In-Reply-To: <20220315104741.63071-1-david@redhat.com>
References: <20220315104741.63071-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to change the way we handle R/O pins on anonymous pages that
might be shared: if we detect a possibly shared anonymous page --
mapped R/O and not !PageAnonExclusive() -- we want to trigger unsharing
via a page fault, resulting in an exclusive anonymous page that can be
pinned reliably without getting replaced via COW on the next write
fault.

However, the required page fault will be problematic for follow_page():
in contrast to ordinary GUP, follow_page() doesn't trigger faults
internally. So we would have to end up failing a R/O pin via
follow_page(), although there is something mapped R/O into the page
table, which might be rather surprising.

We don't seem to have follow_page(FOLL_PIN) users, and it's a purely
internal MM function. Let's just make our life easier and the semantics of
follow_page() clearer by just disallowing FOLL_PIN for follow_page()
completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c     | 3 +++
 mm/hugetlb.c | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7bc1ba9ce440..ae1aa2e93b0f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -875,6 +875,9 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 	if (vma_is_secretmem(vma))
 		return NULL;
 
+	if (foll_flags & FOLL_PIN)
+		return NULL;
+
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
 	if (ctx.pgmap)
 		put_dev_pagemap(ctx.pgmap);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c0e19ea5ebb5..640364a11336 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6692,9 +6692,11 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	spinlock_t *ptl;
 	pte_t pte;
 
-	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
-	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
-			 (FOLL_PIN | FOLL_GET)))
+	/*
+	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
+	 * follow_hugetlb_page().
+	 */
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
 retry:
-- 
2.35.1

