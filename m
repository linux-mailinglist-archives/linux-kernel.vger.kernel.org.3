Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3518349F29E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiA1Eye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346106AbiA1Eyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643345672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0OLEdIrUqYcaY6DYkFVTZPLD4+1hLYjm8QOXt2Ctgs=;
        b=DqcQDMxcgN4MZAcskziob3S2ldDRW8aAWg5MhNyrtNGd6+LLSbSA11/3vLnayDB6cR7fj7
        AhHOTz4tjhzWYCEMrHZaX6kYg7tumHUoXCGUEogW0qZAmvjiN2cOfprURzUYb1y3PafehF
        V+fgxVIze1zHMHzzxCWcelQWr14AvLQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-fi-u0vRNOVamLqRpHkrtrg-1; Thu, 27 Jan 2022 23:54:30 -0500
X-MC-Unique: fi-u0vRNOVamLqRpHkrtrg-1
Received: by mail-wr1-f70.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so1782514wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0OLEdIrUqYcaY6DYkFVTZPLD4+1hLYjm8QOXt2Ctgs=;
        b=CbaRXXiGBHAbgqcU7qKroTw+S86u5l8CrEB2wvsIjQTiFtEyWdqWMK4jayJ/dHUMW4
         pxnc4Jznzy5z0tNHPFONBhEP2ST51Rkk+CKstWtlvPd1x2uw6yMFKVCeA7zw791Knc98
         vGrkRboHy5ayIMX9AXi+uoxPNSE0o78CxU1oGfMooh3QBxhY9LH7SCvgbb7+cvJTm15k
         za5kHW7qTl2wRN6VywZi9HIK5VKc8ePly9Qj4qaTVl4cr5SJEPUkq3ID/3icIkHsnIIy
         olI2v3oE4TgIT2W11xEKuKUX4WvOP+fEgjvZKp3AamWv+TpK18KXafdfAAZjsjZ72qid
         8/NQ==
X-Gm-Message-State: AOAM530vH2JFvQNPNKItbhChU3s4tZDa8iubfKmWROLnIFyZ0PNZrrcB
        xw5krZNGmN4QXszVVxo2jjdxkSQ1VTCvWvNW2UCiCXqcxjLotPtOeqtsxMlwKlevY21sjr6ofOR
        03VtuKvCiCzhxpBYOv5cTLZqP
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr5486419wrs.611.1643345669617;
        Thu, 27 Jan 2022 20:54:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNjlbcr557L0JzcCx8cJn1ypoGGBxeXy3L3cPs1G3/t3aoCJ8N911EUy9hAc8Wvze/o8vnfQ==
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr5486406wrs.611.1643345669412;
        Thu, 27 Jan 2022 20:54:29 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id i13sm814014wrf.3.2022.01.27.20.54.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Jan 2022 20:54:29 -0800 (PST)
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
Subject: [PATCH v3 1/4] mm: Don't skip swap entry even if zap_details specified
Date:   Fri, 28 Jan 2022 12:54:09 +0800
Message-Id: <20220128045412.18695-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220128045412.18695-1-peterx@redhat.com>
References: <20220128045412.18695-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "details" pointer shouldn't be the token to decide whether we should skip
swap entries.  For example, when the user specified details->zap_mapping==NULL,
it means the user wants to zap all the pages (including COWed pages), then we
need to look into swap entries because there can be private COWed pages that
was swapped out.

Skipping some swap entries when details is non-NULL may lead to wrongly leaving
some of the swap entries while we should have zapped them.

A reproducer of the problem:

===8<===
        #define _GNU_SOURCE         /* See feature_test_macros(7) */
        #include <stdio.h>
        #include <assert.h>
        #include <unistd.h>
        #include <sys/mman.h>
        #include <sys/types.h>

        int page_size;
        int shmem_fd;
        char *buffer;

        void main(void)
        {
                int ret;
                char val;

                page_size = getpagesize();
                shmem_fd = memfd_create("test", 0);
                assert(shmem_fd >= 0);

                ret = ftruncate(shmem_fd, page_size * 2);
                assert(ret == 0);

                buffer = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
                                MAP_PRIVATE, shmem_fd, 0);
                assert(buffer != MAP_FAILED);

                /* Write private page, swap it out */
                buffer[page_size] = 1;
                madvise(buffer, page_size * 2, MADV_PAGEOUT);

                /* This should drop private buffer[page_size] already */
                ret = ftruncate(shmem_fd, page_size);
                assert(ret == 0);
                /* Recover the size */
                ret = ftruncate(shmem_fd, page_size * 2);
                assert(ret == 0);

                /* Re-read the data, it should be all zero */
                val = buffer[page_size];
                if (val == 0)
                        printf("Good\n");
                else
                        printf("BUG\n");
        }
===8<===

We don't need to touch up the pmd path, because pmd never had a issue with swap
entries.  For example, shmem pmd migration will always be split into pte level,
and same to swapping on anonymous.

Add another helper should_zap_cows() so that we can also check whether we
should zap private mappings when there's no page pointer specified.

This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
should do the same check upon migration entry, hwpoison entry and genuine swap
entries too.  To be explicit, we should still remember to keep the private
entries if even_cows==false, and always zap them when even_cows==true.

The issue seems to exist starting from the initial commit of git.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..4bfeaca7cbc7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1313,6 +1313,17 @@ struct zap_details {
 	struct folio *single_folio;	/* Locked folio to be unmapped */
 };
 
+/* Whether we should zap all COWed (private) pages too */
+static inline bool should_zap_cows(struct zap_details *details)
+{
+	/* By default, zap all pages */
+	if (!details)
+		return true;
+
+	/* Or, we zap COWed pages only if the caller wants to */
+	return !details->zap_mapping;
+}
+
 /*
  * We set details->zap_mapping when we want to unmap shared but keep private
  * pages. Return true if skip zapping this page, false otherwise.
@@ -1320,11 +1331,15 @@ struct zap_details {
 static inline bool
 zap_skip_check_mapping(struct zap_details *details, struct page *page)
 {
-	if (!details || !page)
+	/* If we can make a decision without *page.. */
+	if (should_zap_cows(details))
 		return false;
 
-	return details->zap_mapping &&
-		(details->zap_mapping != page_rmapping(page));
+	/* E.g. zero page */
+	if (!page)
+		return false;
+
+	return details->zap_mapping != page_rmapping(page);
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
@@ -1405,17 +1420,29 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
-			continue;
-
-		if (!non_swap_entry(entry))
+		if (!non_swap_entry(entry)) {
+			/*
+			 * If this is a genuine swap entry, then it must be an
+			 * private anon page.  If the caller wants to skip
+			 * COWed pages, ignore it.
+			 */
+			if (!should_zap_cows(details))
+				continue;
 			rss[MM_SWAPENTS]--;
-		else if (is_migration_entry(entry)) {
+		} else if (is_migration_entry(entry)) {
 			struct page *page;
 
 			page = pfn_swap_entry_to_page(entry);
+			if (zap_skip_check_mapping(details, page))
+				continue;
 			rss[mm_counter(page)]--;
+		} else if (is_hwpoison_entry(entry)) {
+			/* If the caller wants to skip COWed pages, ignore it */
+			if (!should_zap_cows(details))
+				continue;
+		} else {
+			/* We should have covered all the swap entry types */
+			WARN_ON_ONCE(1);
 		}
 		if (unlikely(!free_swap_and_cache(entry)))
 			print_bad_pte(vma, addr, ptent, NULL);
-- 
2.32.0

