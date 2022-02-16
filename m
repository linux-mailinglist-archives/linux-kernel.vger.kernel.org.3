Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B174B84D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiBPJtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:49:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiBPJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 306A32B4059
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645004932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0OLEdIrUqYcaY6DYkFVTZPLD4+1hLYjm8QOXt2Ctgs=;
        b=Wzd/ZrYycohIFIg9aOqh54zhVaoF2gzrP2SKn+5Mo7zRbcOW3PRKDJFFtigME93NvulK/c
        K8T7qE+PJACAa5YlqOW+VWe9M4x2/s0AFP5iHOUzTBtHjF7drFOE9jV6QdR5L2QbbeNsxi
        aehIz2C/ztFOMswiaObVEkLZtjc0Abk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428--igpvnesOy-yVz2uT6RGBg-1; Wed, 16 Feb 2022 04:48:51 -0500
X-MC-Unique: -igpvnesOy-yVz2uT6RGBg-1
Received: by mail-pj1-f72.google.com with SMTP id q40-20020a17090a17ab00b001bafa89b70aso1102946pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0OLEdIrUqYcaY6DYkFVTZPLD4+1hLYjm8QOXt2Ctgs=;
        b=QLm2kvPmXw2M8K4TBN2B2eXpHEu2QN15x9EkIeJ191r85l7Dz/JvSZksIRvIL4YnSI
         RxNp7VZQXGGmjCnxgNFTs3BBhQ6M/F8wHcZ8gbHIgB5AC63vTTBAH0y+lRUiN6lPTHpi
         PYx9rIdqHOJPHGrfQPUvCQimCvip/2g/SdZJ/YkcE8B88JUbzTc1YSGy5eKa43tKt19A
         sw8/ZKkAXxm/dR1wDCdZ/VaQU9m+/vWVpkfiHNOYnEXb5+lwtDXtxyvDMbEtzFr1ztRp
         jw782qAV3HKx1khUPHId8ry0OWOjHsXMCfMiUmkTiuhsL1XYPhUMuhsI5d5HR9XfLaSf
         huxw==
X-Gm-Message-State: AOAM532qfbWgVbwNLFEs46X1CUGEQzckWAUQ3Vy+Tj5p/SiV1tWi55QO
        27jPcqjuYNbNRnvJusWQo+V0SCGq+kOzw7KwQLgEHeaua9uMSqRZYUA9tLS7kzUkzs/Zx4gPkuL
        O1coTr9P+kiYIAZxntVr3cQKED9HonoiG5o8qPr66ak+10FJbAXSlw7GpnLcwNPQZerRqwqdcjQ
        ==
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id i12-20020a1709026acc00b001498f60a526mr2088583plt.25.1645004929947;
        Wed, 16 Feb 2022 01:48:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8ro/PQOMeJ2c0+5tdk79xjZJksrx44v8baDKpAy/uaeFgFPs2vRvtMpMFMhDbUf7ALQrB3g==
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id i12-20020a1709026acc00b001498f60a526mr2088543plt.25.1645004929405;
        Wed, 16 Feb 2022 01:48:49 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.81])
        by smtp.gmail.com with ESMTPSA id qe7sm11567835pjb.25.2022.02.16.01.48.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 01:48:49 -0800 (PST)
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
Subject: [PATCH v4 1/4] mm: Don't skip swap entry even if zap_details specified
Date:   Wed, 16 Feb 2022 17:48:07 +0800
Message-Id: <20220216094810.60572-2-peterx@redhat.com>
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

