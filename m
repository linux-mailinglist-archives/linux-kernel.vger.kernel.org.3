Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B670F5A790F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiHaIam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiHaIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D830F65
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661934634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NFEsdZZZDsnHBh+g7oky6kdPceWmzGWYxGqF9lptHPg=;
        b=Bw9ybbd0m78q7BTJIrFpdEZNtDRdJo3HjxSfiaGKqJtG4mKaz9gF8W3z+Sktz/74hfjXfF
        fdAIn5apk0gAvubifXo9wtJ2bxtAc2dePjfCmHeqt2UHgE/6uyaJ9/JYVnUV0dMIJfyOpp
        1snPs++ANpUsu+xz2VtblWiBVI1uOSo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-fF7fsLlTOwuzp0yfJQsY4Q-1; Wed, 31 Aug 2022 04:30:29 -0400
X-MC-Unique: fF7fsLlTOwuzp0yfJQsY4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB8901C04B44;
        Wed, 31 Aug 2022 08:30:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF582166B26;
        Wed, 31 Aug 2022 08:30:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
Date:   Wed, 31 Aug 2022 10:30:24 +0200
Message-Id: <20220831083024.37138-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is stale, because a TLB flush is no longer sufficient and
required to synchronize against concurrent GUP-fast. This used to be true
in the past, whereby a TLB flush would have implied an IPI on architectures
that support GUP-fast, resulting in GUP-fast that disables local interrupts
from completing before completing the flush.

However, ever since general RCU GUP-fast was introduced in
commit 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()"),
this handling no longer applies in general. RCU primarily prevents page
tables from getting freed while they might still get walked by GUP-fast,
but we can race with GUP-fast after clearing the PTE and flushing the
TLB.

Nowadays, we can see a refcount change from GUP-fast at any point in
time. However, GUP-fast detects concurrent PTE changes by looking up the
PTE, temporarily grabbing a reference, and dropping the reference again if
the PTE changed in the meantime.

An explanation by Jason Gunthorpe regarding how existing memory barriers
should be fine to make sure that concurrent GUP-fast cannot succeed in
grabbing a reference with write permissions after we cleared the PTE and
flushed the TLB can be found at [1].

Note that clearing PageAnonExclusive via page_try_share_anon_rmap()
might still need some explicit memory barriers to not have any possible
races with RCU GUP-fast.

[1] https://lkml.kernel.org/r/Yw5rwIUPm49XtqOB@nvidia.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 42ab153335a2..e88291f63461 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1072,23 +1072,20 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 		swapped = PageSwapCache(page);
 		flush_cache_page(vma, pvmw.address, page_to_pfn(page));
 		/*
-		 * Ok this is tricky, when get_user_pages_fast() run it doesn't
-		 * take any lock, therefore the check that we are going to make
-		 * with the pagecount against the mapcount is racy and
-		 * O_DIRECT can happen right after the check.
-		 * So we clear the pte and flush the tlb before the check
-		 * this assure us that no O_DIRECT can happen after the check
-		 * or in the middle of the check.
-		 *
-		 * No need to notify as we are downgrading page table to read
-		 * only not changing it to point to a new page.
+		 * Especially if we're downgrading protection, make sure to
+		 * flush the TLB now. No need to notify as we are not changing
+		 * the PTE to point at a different page.
 		 *
 		 * See Documentation/mm/mmu_notifier.rst
 		 */
 		entry = ptep_clear_flush(vma, pvmw.address, pvmw.pte);
+
 		/*
-		 * Check that no O_DIRECT or similar I/O is in progress on the
-		 * page
+		 * Make sure that there are no unexpected references (e.g.,
+		 * concurrent O_DIRECT). Note that while concurrent GUP-fast
+		 * could raise the refcount temporarily to grab a write
+		 * reference, it will observe the changed PTE and drop that
+		 * temporary reference again.
 		 */
 		if (page_mapcount(page) + 1 + swapped != page_count(page)) {
 			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
-- 
2.37.1

