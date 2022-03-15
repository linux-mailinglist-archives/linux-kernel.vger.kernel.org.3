Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32E4D99AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbiCOKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiCOKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AC7A1BEA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647341546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2n5YxPaBAt4DbQTg1N/HEvM7OHIbsuhh5l7jJDC7c0=;
        b=cLrFq3eSoDzeDnpq0ZPVghOFg9dDZwvO7jUqhq3Xph8fO3A3ZKogywybGg4EZW13m7Zmui
        JX0mqBdlPPFI9OTu8FPYPUqqaEFy8Fc9lIX5hIR/dc/0vD6hwninoEwzRNCLxizb83gxYH
        UF/eiGMYH7cWsyA3C8ZCPbTzk/Bwezk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-wa3DS3mZOwCy3Pt8IXxjbw-1; Tue, 15 Mar 2022 06:52:23 -0400
X-MC-Unique: wa3DS3mZOwCy3Pt8IXxjbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 882AC101CC60;
        Tue, 15 Mar 2022 10:52:21 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BCC62D465;
        Tue, 15 Mar 2022 10:51:44 +0000 (UTC)
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
Subject: [PATCH v2 09/15] mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon() page exclusively
Date:   Tue, 15 Mar 2022 11:47:35 +0100
Message-Id: <20220315104741.63071-10-david@redhat.com>
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

We want to mark anonymous pages exclusive, and when using
page_move_anon_rmap() we know that we are the exclusive user, as
properly documented. This is a preparation for marking anonymous pages
exclusive in page_move_anon_rmap().

In both instances, we're holding page lock and are sure that we're the
exclusive owner (page_count() == 1). hugetlb already properly uses
page_move_anon_rmap() in the write fault handler.

Note that in case of a PTE-mapped THP, we'll only end up calling this
function if the whole THP is only referenced by the single PTE mapping
a single subpage (page_count() == 1); consequently, it's fine to modify
the compound page mapping inside page_move_anon_rmap().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 2 ++
 mm/memory.c      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c1f7eaba23ff..0b6fb409b9e4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1317,6 +1317,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		try_to_free_swap(page);
 	if (page_count(page) == 1) {
 		pmd_t entry;
+
+		page_move_anon_rmap(page, vma);
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
diff --git a/mm/memory.c b/mm/memory.c
index 00c45b3a9576..7b32f422798d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3307,6 +3307,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * and the page is locked, it's dark out, and we're wearing
 		 * sunglasses. Hit it.
 		 */
+		page_move_anon_rmap(page, vma);
 		unlock_page(page);
 		wp_page_reuse(vmf);
 		return VM_FAULT_WRITE;
-- 
2.35.1

