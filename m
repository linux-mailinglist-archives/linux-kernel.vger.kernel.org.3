Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A328B4B84CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiBPJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:49:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiBPJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A37E2B4072
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645004960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZfOtFEoi6jPUWDy50tF9fEsGXQRQqyIANlBUu6Ts5c=;
        b=faA21TKRiY+fR9ZiteElUmfmuHrq+1s40BNwUyotMovb6BNvWP4IaGgmJ/9TBQEUi0qAiR
        c/kHst1yVKPBgFPD0KOROw0roAgXoHW4MDBL5yVrWwTOG+kvJaClXKqveA0LfRgEgTBMqR
        UnJtR9MsGXmg0ddrZz7JDGgS5OTpD4I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-eLwqPexkMZy7DyX59K8Rqg-1; Wed, 16 Feb 2022 04:49:19 -0500
X-MC-Unique: eLwqPexkMZy7DyX59K8Rqg-1
Received: by mail-pf1-f199.google.com with SMTP id h3-20020a628303000000b004e12f44a262so1172826pfe.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZfOtFEoi6jPUWDy50tF9fEsGXQRQqyIANlBUu6Ts5c=;
        b=KuMdRYelMC5t5yvwL54xWSskemp4qe0h1Sw85Cd9l0vq86PMk+SlBPAsRwu5I7Gg2j
         WWwEFylPrtl7B1LLfxlVM+Ahr2PiaSQnnxTGutfQuhTA14ZTjNzjx7nqSjZVHb596SHW
         m4oKTc6k1OZRLmXZHzd2qqSOAByszxk1WeKm1vxf2F4a5Vb8DUAi8NGMWJ+BeljTHWYw
         b/6klyVcIxObGjnC13a5s/X3+hxlhLo0IxbJTk6N07712VSCq5Sv8L+L5NR+JzW0YwkV
         Bo60IRXnQLycOTz81VShyWU3tQHN5lRsnVXc4A5uytH6uUWbjO9Srz3ZHkR3KCIm8R2q
         dk0A==
X-Gm-Message-State: AOAM530igqjvrg/ASC9W4+99/PKT58gO9+CA0DCkHo3fWHHLijf/6f0G
        UdvvH3FPS+PF2aWWs7G0xnaJ8sqvJbc6GvqJ0qMjE/AevOawKzcoEjj7NRSOCH8uhPTudy951X1
        43Gfbt/GJfuaZqTkDWnHz7alB4l306Q1GBez7ce/bC4k/tEsKhzQem0iwqTnG++IZuTtLHU4i6w
        ==
X-Received: by 2002:a17:90a:e7ca:b0:1b9:66c8:982c with SMTP id kb10-20020a17090ae7ca00b001b966c8982cmr784818pjb.30.1645004958385;
        Wed, 16 Feb 2022 01:49:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr7nMoK1mV1Zu2nttOBw8/qblPs/Y5s3WL1TIEPfmM1m5wytDOSBV+uQUMnFliIrLh3OSfJg==
X-Received: by 2002:a17:90a:e7ca:b0:1b9:66c8:982c with SMTP id kb10-20020a17090ae7ca00b001b966c8982cmr784784pjb.30.1645004958039;
        Wed, 16 Feb 2022 01:49:18 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.81])
        by smtp.gmail.com with ESMTPSA id qe7sm11567835pjb.25.2022.02.16.01.49.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 01:49:17 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v4 3/4] mm: Change zap_details.zap_mapping into even_cows
Date:   Wed, 16 Feb 2022 17:48:09 +0800
Message-Id: <20220216094810.60572-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216094810.60572-1-peterx@redhat.com>
References: <20220216094810.60572-1-peterx@redhat.com>
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

Quoting partly from Hugh:

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

