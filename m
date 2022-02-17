Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7154B98CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiBQGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:08:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiBQGI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 755E4C7D6A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645078093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1vbZxsyzMifaaJqgkhHlizU7SHJnrILT5bLrmNnzMQ=;
        b=OZMeYcVqlq4pNdvhAGzBxH81Z0YZ8+d6IYZV24ocHZ7Da+Ei2ODTIySnJH9ejfvXEWeTOb
        erv/7vRGIBBaFZuPJ0ntq/Lu/NLHn9jLMmlGGnx1Zq1b6mFIVU50MHR8IwP5w85IaEFUtd
        v5yarUhFHMP68iqiJ82SF/HqprOoJ2s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-6hXjHtCtP9m5i4wAPwLTrQ-1; Thu, 17 Feb 2022 01:08:12 -0500
X-MC-Unique: 6hXjHtCtP9m5i4wAPwLTrQ-1
Received: by mail-pj1-f69.google.com with SMTP id t16-20020a17090b019000b001b8af627800so5834347pjs.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1vbZxsyzMifaaJqgkhHlizU7SHJnrILT5bLrmNnzMQ=;
        b=RDqX5W1HfxEsFd6wALKoXkkQnePEZfiwMeie367FvX7C3f90AsyT+Htrl/a6QxYUOd
         kH6GMdw2HoS0jujOw5HgEHT1p5gQUyLXMwJnPLqTDNfxNWJmqiUySjM1477szH/dr5IV
         Gsjza/BdHlWErIhZn3dgnvfcPI/DOD2fe4Ekv/irzevNm5uqk89ctpjwnyTT7Fk7ARZm
         fS6E4CuPhCI7yPaaV8nPi4MxtKmlSxYuk1TG25TpIj+tUc4ciNhJ6y/COKr1AaMzdG1I
         IHcUIz4Bpgy5OPchit+8A+P7DifJMctSlNlpW5gglwhuf9C+DZwFMnBq0z40zF3ED4qz
         WB6Q==
X-Gm-Message-State: AOAM5322qqQCaYn0mHHO+znNhfqbI1dclt2bbJGoKGqkS+0jyh5unfN3
        JkE7am+E6w4Vwffo9fKUxUnEdhFn300THW+7uxKVJK+QRKsT3wk3tcbyovdcrzfkTxG+elg7PN/
        Xfxb7bAm18i0ZAu+A/CdmzjFa
X-Received: by 2002:a17:90a:ec10:b0:1b8:9da7:3d13 with SMTP id l16-20020a17090aec1000b001b89da73d13mr1531870pjy.194.1645078091161;
        Wed, 16 Feb 2022 22:08:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ+MRoSejjpjSfq3CLN/Ow3BCwyndgoRTeQRVbvX65z98rR9y1roji3xMcenHn/prKAwWNxg==
X-Received: by 2002:a17:90a:ec10:b0:1b8:9da7:3d13 with SMTP id l16-20020a17090aec1000b001b89da73d13mr1531852pjy.194.1645078090846;
        Wed, 16 Feb 2022 22:08:10 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id j8sm224230pjc.11.2022.02.16.22.08.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 22:08:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v5 3/4] mm: Change zap_details.zap_mapping into even_cows
Date:   Thu, 17 Feb 2022 14:07:45 +0800
Message-Id: <20220217060746.71256-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220217060746.71256-1-peterx@redhat.com>
References: <20220217060746.71256-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have a zap_mapping pointer maintained in zap_details, when it
is specified we only want to zap the pages that has the same mapping with
what the caller has specified.

But what we want to do is actually simpler: we want to skip zapping
private (COW-ed) pages in some cases.  It comes from unmap_mapping_pages()
where we could have passed in different even_cows values.  The other user
is unmap_mapping_folio() where we always want to skip private pages.

According to Hugh, we used a mapping pointer for historical reason, as
explained here:

  https://lore.kernel.org/lkml/391aa58d-ce84-9d4-d68d-d98a9c533255@google.com/

Quoting partly from Hugh:

  Which raises the question again of why I did not just use a boolean flag
  there originally: aah, I think I've found why.  In those days there was a
  horrible "optimization", for better performance on some benchmark I
  guess, which when you read from /dev/zero into a private mapping, would
  map the zero page there (look up read_zero_pagealigned() and
  zeromap_page_range() if you dare).  So there was another category of page
  to be skipped along with the anon COWs, and I didn't want multiple tests
  in the zap loop, so checking check_mapping against page->mapping did
  both.  I think nowadays you could do it by checking for PageAnon page (or
  genuine swap entry) instead.

This patch replaced the zap_details.zap_mapping pointer into the even_cows
boolean, then we check it against PageAnon.

Suggested-by: Hugh Dickins <hughd@google.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3728632ea993..c2defe8a1472 100644
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
@@ -3398,7 +3396,7 @@ void unmap_mapping_folio(struct folio *folio)
 	first_index = folio->index;
 	last_index = folio->index + folio_nr_pages(folio) - 1;
 
-	details.zap_mapping = mapping;
+	details.even_cows = false;
 	details.single_folio = folio;
 
 	i_mmap_lock_write(mapping);
@@ -3427,7 +3425,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 	pgoff_t	first_index = start;
 	pgoff_t	last_index = start + nr - 1;
 
-	details.zap_mapping = even_cows ? NULL : mapping;
+	details.even_cows = even_cows;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.32.0

