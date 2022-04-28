Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598D512EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiD1ImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbiD1IlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC60B33E29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v822+pslh1KbevnoZOKSzpfD4OCwDeeTa9Xkok8HSu4=;
        b=KJppoeBLBGelatLtnt14CQQGSLXxg+CJMU54bUR0Xbc3x5h3ryuh36MHqz7vHTUq+up8D5
        se+Wn4BiLHYYHG15yQNyrPzdbK1yQl+cnEWbU/toPQ57nd3DkuAiCO/vatzIpjWjxwCnfw
        XYwkAoXiBYGLf7dTTDNK/syPAvDhaSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-qeJH1XxgPGKnMYatyjfFOQ-1; Thu, 28 Apr 2022 04:35:54 -0400
X-MC-Unique: qeJH1XxgPGKnMYatyjfFOQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEB1080419F;
        Thu, 28 Apr 2022 08:35:47 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 480D9566A27;
        Thu, 28 Apr 2022 08:35:41 +0000 (UTC)
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
Subject: [PATCH v4 10/17] mm/huge_memory: remove outdated VM_WARN_ON_ONCE_PAGE from unmap_page()
Date:   Thu, 28 Apr 2022 10:34:34 +0200
Message-Id: <20220428083441.37290-11-david@redhat.com>
In-Reply-To: <20220428083441.37290-1-david@redhat.com>
References: <20220428083441.37290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can already theoretically fail to unmap (still having page_mapped()) in
case arch_unmap_one() fails, which can happen on sparc. Failures to
unmap are handled gracefully, just as if there are other references on
the target page: freezing the refcount in split_huge_page_to_list()
will fail if still mapped and we'll simply remap.

In commit 504e070dc08f ("mm: thp: replace DEBUG_VM BUG with VM_WARN when
unmap fails for split") we already converted to VM_WARN_ON_ONCE_PAGE,
let's get rid of it completely now.

This is a preparation for making try_to_migrate() fail on anonymous pages
with GUP pins, which will make this VM_WARN_ON_ONCE_PAGE trigger more
frequently.

Reported-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 04c9446b87a8..cb5bcd833d9e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2240,8 +2240,6 @@ static void unmap_page(struct page *page)
 		try_to_migrate(folio, ttu_flags);
 	else
 		try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
-
-	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
 }
 
 static void remap_page(struct folio *folio, unsigned long nr)
-- 
2.35.1

