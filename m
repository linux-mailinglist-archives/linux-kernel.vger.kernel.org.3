Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D62D49F2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbiA1Eys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346126AbiA1Eyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643345683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1DVV/S8YSQjtZLKWoD0HN3kRcNDUylmDF/rAE9teCo=;
        b=MC1wQej2vHJ4/VAf8obkkL8dhWBqIY0Mwkb5qx+9JM0HQgE/IbtQpZoXwtiM3bN8YiIKgr
        8uUKh5P1gKP5qi+Bjp736ERaWbMJZ2mlrMHxmJF+LJUN8KUWzXgMscDkKgg8MiAOhRp8wp
        axDPX3T4XjsRV/s0tpMKAguaI+WTg/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-hD0wDvE9PKW2tP0zzm0ayg-1; Thu, 27 Jan 2022 23:54:41 -0500
X-MC-Unique: hD0wDvE9PKW2tP0zzm0ayg-1
Received: by mail-wm1-f72.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso5330921wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1DVV/S8YSQjtZLKWoD0HN3kRcNDUylmDF/rAE9teCo=;
        b=41OcEc1O86WdWwef3taKcLQEbI8gu0I12y1UekoKg33ej6Rxxd73K1y0jQbyEslEPo
         +uggv7AlUjM6MZKheO5HYmFEUCvXO753C2BjAFg9zxiee6p9WKEcS3o/90wEp29isA+n
         Brh/Y7+wtN5hCkOpDXQe7qbDSC/fmARXTIKM/7N0/MmnBtjnRPGjbc/by/ysZAqSPBJj
         8VCShnHLZAYe9s0sYJ/Vq0FDlV+RlAbmgc1nQwCy+HF4cQRM5qzsqglgc6qn6koF8uAg
         erwdpa5Lk14nM6I7538fpMtBJ+sJ8H8AVpJjSg+rXL7E6FqSMprGZfH4bTJDWCOLIWAN
         TetA==
X-Gm-Message-State: AOAM533G+ujdTjhfRvI+cyoaBruintpYJb8TINFG6eNwCDfXkPPJjhaV
        bp4rqiCLpm5hCcx8Xtlg39MGzJ/JGDRCyE7X/tlDuUy5vhvnmOQDpawonbrVi5sskfZQb4t9KCG
        caG2ZQ1YaHreHFS1tjyx2qyr6
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr14345442wmr.4.1643345680337;
        Thu, 27 Jan 2022 20:54:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSmguUCLAJc3uPMchWo2O4qWDyEBL0Tp/mOd4YhtXSNiPDsTt43pf61km0GV/X6qLuqocw1g==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr14345423wmr.4.1643345680044;
        Thu, 27 Jan 2022 20:54:40 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id i13sm814014wrf.3.2022.01.27.20.54.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Jan 2022 20:54:39 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 3/4] mm: Change zap_details.zap_mapping into even_cows
Date:   Fri, 28 Jan 2022 12:54:11 +0800
Message-Id: <20220128045412.18695-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220128045412.18695-1-peterx@redhat.com>
References: <20220128045412.18695-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have a zap_mapping pointer maintained in zap_details, when it is
specified we only want to zap the pages that has the same mapping with what the
caller has specified.

But what we want to do is actually simpler: we want to skip zapping
private (COW-ed) pages in some cases.  We can refer to unmap_mapping_pages()
callers where we could have passed in different even_cows values.  The other
user is unmap_mapping_folio() where we always want to skip private pages.

According to Hugh, we used a mapping pointer for historical reason, as
explained here:

  https://lore.kernel.org/lkml/391aa58d-ce84-9d4-d68d-d98a9c533255@google.com/

Quotting partly from Hugh:

  Which raises the question again of why I did not just use a boolean flag
  there originally: aah, I think I've found why.  In those days there was a
  horrible "optimization", for better performance on some benchmark I guess,
  which when you read from /dev/zero into a private mapping, would map the zero
  page there (look up read_zero_pagealigned() and zeromap_page_range() if you
  dare).  So there was another category of page to be skipped along with the
  anon COWs, and I didn't want multiple tests in the zap loop, so checking
  check_mapping against page->mapping did both.  I think nowadays you could do
  it by checking for PageAnon page (or genuine swap entry) instead.

This patch replaced the zap_details.zap_mapping pointer into the even_cows
boolean, then we check it against PageAnon.

Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 14d8428ff4db..ffa8c7dfe9ad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1309,8 +1309,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
 struct zap_details {
-	struct address_space *zap_mapping;	/* Check page->mapping if set */
 	struct folio *single_folio;	/* Locked folio to be unmapped */
+	bool even_cows;			/* Zap COWed private pages too? */
 };
 
 /* Whether we should zap all COWed (private) pages too */
@@ -1321,13 +1321,10 @@ static inline bool should_zap_cows(struct zap_details *details)
 		return true;
 
 	/* Or, we zap COWed pages only if the caller wants to */
-	return !details->zap_mapping;
+	return details->even_cows;
 }
 
-/*
- * We set details->zap_mapping when we want to unmap shared but keep private
- * pages. Return true if we should zap this page, false otherwise.
- */
+/* Decides whether we should zap this page with the page pointer specified */
 static inline bool should_zap_page(struct zap_details *details, struct page *page)
 {
 	/* If we can make a decision without *page.. */
@@ -1338,7 +1335,8 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
 	if (!page)
 		return true;
 
-	return details->zap_mapping == page_rmapping(page);
+	/* Otherwise we should only zap non-anon pages */
+	return !PageAnon(page);
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
@@ -3403,7 +3401,7 @@ void unmap_mapping_folio(struct folio *folio)
 	first_index = folio->index;
 	last_index = folio->index + folio_nr_pages(folio) - 1;
 
-	details.zap_mapping = mapping;
+	details.even_cows = false;
 	details.single_folio = folio;
 
 	i_mmap_lock_write(mapping);
@@ -3432,7 +3430,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 	pgoff_t	first_index = start;
 	pgoff_t	last_index = start + nr - 1;
 
-	details.zap_mapping = even_cows ? NULL : mapping;
+	details.even_cows = even_cows;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.32.0

