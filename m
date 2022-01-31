Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF84A4C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380479AbiAaQdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380456AbiAaQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643646783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Of3jZ+VHPXQ5Dt61jaIUicZu7ZwPC24uJWxR+ti2d3o=;
        b=RPkBrZyow2wu/gvMX1Q5i5UJot6oJ401uo6IEPNLjejyHEAN28v150TX24avlLRKSCDmmv
        23Ep6An6KxwoAMCGPUWo7MEq42OHe6JXa4YSyNMuGSMMdlr6FU8SMiZ90/RCY/ePIzME/m
        2ACCTxzlSJI8cUq8FqcDlk+M6C2r2FI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-3cmnDHY0Oh2_v_JeAp2-Iw-1; Mon, 31 Jan 2022 11:32:59 -0500
X-MC-Unique: 3cmnDHY0Oh2_v_JeAp2-Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E0486A066;
        Mon, 31 Jan 2022 16:32:56 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 601CB798CD;
        Mon, 31 Jan 2022 16:32:50 +0000 (UTC)
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
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 3/9] mm: slightly clarify KSM logic in do_swap_page()
Date:   Mon, 31 Jan 2022 17:29:33 +0100
Message-Id: <20220131162940.210846-4-david@redhat.com>
In-Reply-To: <20220131162940.210846-1-david@redhat.com>
References: <20220131162940.210846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make it clearer that KSM might only have to copy a page
in case we have a page in the swapcache, not if we allocated a fresh
page and bypassed the swapcache. While at it, add a comment why this is
usually necessary and merge the two swapcache conditions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 923165b4c27e..3c91294cca98 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3615,21 +3615,29 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	/*
-	 * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
-	 * release the swapcache from under us.  The page pin, and pte_same
-	 * test below, are not enough to exclude that.  Even if it is still
-	 * swapcache, we need to check that the page's swap has not changed.
-	 */
-	if (unlikely((!PageSwapCache(page) ||
-			page_private(page) != entry.val)) && swapcache)
-		goto out_page;
-
-	page = ksm_might_need_to_copy(page, vma, vmf->address);
-	if (unlikely(!page)) {
-		ret = VM_FAULT_OOM;
-		page = swapcache;
-		goto out_page;
+	if (swapcache) {
+		/*
+		 * Make sure try_to_free_swap or reuse_swap_page or swapoff did
+		 * not release the swapcache from under us.  The page pin, and
+		 * pte_same test below, are not enough to exclude that.  Even if
+		 * it is still swapcache, we need to check that the page's swap
+		 * has not changed.
+		 */
+		if (unlikely(!PageSwapCache(page) ||
+			     page_private(page) != entry.val))
+			goto out_page;
+
+		/*
+		 * KSM sometimes has to copy on read faults, for example, if
+		 * page->index of !PageKSM() pages would be nonlinear inside the
+		 * anon VMA -- PageKSM() is lost on actual swapout.
+		 */
+		page = ksm_might_need_to_copy(page, vma, vmf->address);
+		if (unlikely(!page)) {
+			ret = VM_FAULT_OOM;
+			page = swapcache;
+			goto out_page;
+		}
 	}
 
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
-- 
2.34.1

