Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8A4C2BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiBXM2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiBXM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB3A515042F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDMbuifa4ArrlCCaskYJsKRDb81/8AtnseyfrM1WxsM=;
        b=KMygp2ufpskQCr5xNoy6cgf9q9k+PVQ8HbDhLLpxoALcEwhO/yr8mTAIdGkIiJJqjXpiKC
        3TK7meD+AiE3Q/JsWbegjoc7uJdUyob4dabENfAwbUOGYDZLlcpfl+RWABZVGjORGEf0yy
        rkAjP8P6OC/FjN7abe2B2MCI/oe/iVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-OfqclEZmMTaoH6E2cMJyoQ-1; Thu, 24 Feb 2022 07:27:31 -0500
X-MC-Unique: OfqclEZmMTaoH6E2cMJyoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 594B9804311;
        Thu, 24 Feb 2022 12:27:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C4A526DC7;
        Thu, 24 Feb 2022 12:27:06 +0000 (UTC)
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
        David Hildenbrand <david@redhat.com>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [PATCH RFC 01/13] mm/rmap: fix missing swap_free() in try_to_unmap() after arch_unmap_one() failed
Date:   Thu, 24 Feb 2022 13:26:02 +0100
Message-Id: <20220224122614.94921-2-david@redhat.com>
In-Reply-To: <20220224122614.94921-1-david@redhat.com>
References: <20220224122614.94921-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
undo that properly via swap_free().

Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
Cc: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..f825aeef61ca 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1625,6 +1625,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				break;
 			}
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
+				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
-- 
2.35.1

