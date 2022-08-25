Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17BA5A1733
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbiHYQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbiHYQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62CBFAA7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661446031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3NPvWyh2xRtoYXHMmyrsAAtGbzTeyv985JIMuXJIb4=;
        b=IuyWJAWMTr8eL4p1Clm+lJ6P8aG8+34RIxuK7iEslEBbAPvkDQoTrA0lp/jcp2zU9I97d6
        g4Cg1uMCU0SgO1v+bm72qfEHBpOBVZ9z2N3xTv0JSXZKOREHoGDWdoxif3Q+ciC3IS5l4L
        PsYTTwXOVRAqwixZCDq7V4fjumRSzTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-xXkhVmbBN16ANoNW0OvGkQ-1; Thu, 25 Aug 2022 12:47:09 -0400
X-MC-Unique: xXkhVmbBN16ANoNW0OvGkQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 689E6101AA45;
        Thu, 25 Aug 2022 16:47:09 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF705492CA2;
        Thu, 25 Aug 2022 16:47:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in GUP-fast
Date:   Thu, 25 Aug 2022 18:46:58 +0200
Message-Id: <20220825164659.89824-3-david@redhat.com>
In-Reply-To: <20220825164659.89824-1-david@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be no reason why FOLL_FORCE during GUP-fast would have to
fallback to the slow path when stumbling over a PROT_NONE mapped page. We
only have to trigger hinting faults in case FOLL_FORCE is not set, and any
kind of fault handling naturally happens from the slow path -- where
NUMA hinting accounting/handling would be performed.

Note that the comment regarding THP migration is outdated:
commit 2b4847e73004 ("mm: numa: serialise parallel get_user_page against
THP migration") described that this was required for THP due to lack of PMD
migration entries. Nowadays, we do have proper PMD migration entries in
place -- see set_pmd_migration_entry(), which does a proper
pmdp_invalidate() when placing the migration entry.

So let's just reuse gup_can_follow_protnone() here to make it
consistent and drop the somewhat outdated comments.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a1355dbd848e..dfef23071dc8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2350,11 +2350,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		struct page *page;
 		struct folio *folio;
 
-		/*
-		 * Similar to the PMD case below, NUMA hinting must take slow
-		 * path using the pte_protnone check.
-		 */
-		if (pte_protnone(pte))
+		if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
 			goto pte_unmap;
 
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
@@ -2736,12 +2732,8 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 
 		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
 			     pmd_devmap(pmd))) {
-			/*
-			 * NUMA hinting faults need to be handled in the GUP
-			 * slowpath for accounting purposes and so that they
-			 * can be serialised against THP migration.
-			 */
-			if (pmd_protnone(pmd))
+			if (pmd_protnone(pmd) &&
+			    !gup_can_follow_protnone(flags))
 				return 0;
 
 			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
-- 
2.37.1

