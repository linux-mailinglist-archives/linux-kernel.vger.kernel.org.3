Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515D4D1A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347398AbiCHOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbiCHOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10C7D4B1F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646749098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2n5YxPaBAt4DbQTg1N/HEvM7OHIbsuhh5l7jJDC7c0=;
        b=c/Qjm2GvywfYKMgbXq0Vja2yX3wEac1WSwZhbPEwtVQNtPmGvg2+NH3a8vT97jHzwN1tBY
        siTVzgE1w5q3vtvo7VcRhiYFLC7FgYNRU14x4v0ZGGhSUYePUyDWtIlDXVRb3D20INm2y9
        QE7gwoVPc6akMRBcZ5iZMJ9XV0zFGXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-unSRJ_ClNwqMzqeAOFxPAw-1; Tue, 08 Mar 2022 09:18:15 -0500
X-MC-Unique: unSRJ_ClNwqMzqeAOFxPAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA0961800D50;
        Tue,  8 Mar 2022 14:18:11 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8A77886E;
        Tue,  8 Mar 2022 14:18:05 +0000 (UTC)
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
Subject: [PATCH v1 09/15] mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon() page exclusively
Date:   Tue,  8 Mar 2022 15:14:31 +0100
Message-Id: <20220308141437.144919-10-david@redhat.com>
In-Reply-To: <20220308141437.144919-1-david@redhat.com>
References: <20220308141437.144919-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

