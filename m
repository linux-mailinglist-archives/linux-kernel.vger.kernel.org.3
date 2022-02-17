Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF14B98BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiBQGIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:08:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiBQGIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07CDAC7D4F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645078083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSU30vCJtk7GotZgltWgn1HG21KfRp7j8JvnndBOhWw=;
        b=CsHaBznw49UKzgWzxyqbZ/Tw2tgCHqUTiWMH0vNLr2TxyAW47dUwY6CyRu3XkQX8qQBSxM
        Tinz+XG2BOojfNFFMSnUDgUt8Y7cUUj8xAtKm6v57lkMqmfC9VPox1Tghyx5fOFTTaEhbM
        gBjBVk0arPnnxv3izmsXa3du+EJW/BU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-AN7owxkMOPS3goyTwb2E8A-1; Thu, 17 Feb 2022 01:08:01 -0500
X-MC-Unique: AN7owxkMOPS3goyTwb2E8A-1
Received: by mail-pl1-f199.google.com with SMTP id w3-20020a170902a70300b0014cced44ad7so2106815plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSU30vCJtk7GotZgltWgn1HG21KfRp7j8JvnndBOhWw=;
        b=IlYqKPGPX4CytPIrWPAV8EzNqpHlCwv/y5dwY5UmCrpGbE1KgXTwlhhNF1T6NQs2CX
         VcVLdxERR8wn4rbIvmGZQBeuEMrlLX6ZrqPDoHBPp6dbaq/28Bc7IsH419G1rJCO82HR
         QuWB/kKTuyCqiPjj0suULq9vU1AipmQ8k0YIA7Brtxiksomn9jl7eGrhZ6MsC2ruNQDL
         BGqFQ85t4cBBFf52SgZISBdxNneyjpArADdtijqWd803BBwat6qSuHD6pZIPC57XW/iv
         o9OlXMsnv/+RmpVBJaoH3puH35t1iP5ZIN1lEMNefAwDTP6KfhtnickE8mWsLIOczHzx
         AxLw==
X-Gm-Message-State: AOAM531EwGLUJFqMvPqwFBuLbrRtMhwLN+o1iEAzhZt3RyepJ3pyFHW/
        MRr5ElYNiFnXRR3yFCJKaj8xcqvfXVydVXmu+9R9zv5QI5UAE03kFyN5mMuYndnBxuqLw1b5K50
        lKn0SXhHx32YuBD7gYXAJnoZq
X-Received: by 2002:a17:902:da91:b0:14d:58de:5667 with SMTP id j17-20020a170902da9100b0014d58de5667mr1392087plx.95.1645078080606;
        Wed, 16 Feb 2022 22:08:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDUnDyEDIU63kvmjH9FX83zNUGtXLAelwg+LX3uRrYzwGaMsuEvfOVDWTrPD9itq0ndmmSlQ==
X-Received: by 2002:a17:902:da91:b0:14d:58de:5667 with SMTP id j17-20020a170902da9100b0014d58de5667mr1392070plx.95.1645078080296;
        Wed, 16 Feb 2022 22:08:00 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id j8sm224230pjc.11.2022.02.16.22.07.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 22:08:00 -0800 (PST)
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
Subject: [PATCH v5 1/4] mm: Don't skip swap entry even if zap_details specified
Date:   Thu, 17 Feb 2022 14:07:43 +0800
Message-Id: <20220217060746.71256-2-peterx@redhat.com>
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

The "details" pointer shouldn't be the token to decide whether we should
skip swap entries.

For example, when the callers specified details->zap_mapping==NULL, it
means the user wants to zap all the pages (including COWed pages), then we
need to look into swap entries because there can be private COWed pages
that was swapped out.

Skipping some swap entries when details is non-NULL may lead to wrongly
leaving some of the swap entries while we should have zapped them.

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

We don't need to touch up the pmd path, because pmd never had a issue with
swap entries.  For example, shmem pmd migration will always be split into
pte level, and same to swapping on anonymous.

Add another helper should_zap_cows() so that we can also check whether we
should zap private mappings when there's no page pointer specified.

This patch drops that trick, so we handle swap ptes coherently.  Meanwhile
we should do the same check upon migration entry, hwpoison entry and
genuine swap entries too.

To be explicit, we should still remember to keep the private entries if
even_cows==false, and always zap them when even_cows==true.

The issue seems to exist starting from the initial commit of git.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..533da5d6c32c 100644
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
+		return false;
+
+	/* E.g. the caller passes NULL for the case of a zero page */
+	if (!page)
 		return false;
 
-	return details->zap_mapping &&
-		(details->zap_mapping != page_rmapping(page));
+	return details->zap_mapping != page_rmapping(page);
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
@@ -1405,17 +1420,24 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
-			continue;
-
-		if (!non_swap_entry(entry))
+		if (!non_swap_entry(entry)) {
+			/* Genuine swap entry, hence a private anon page */
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

