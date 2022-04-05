Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727614F21B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiDECox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiDECnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D8793A52FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWfhkJFq1BCdKqisyymaNspfijHKW5rO8LQgLYY4Yk0=;
        b=W2dP0PEOeXHbAG72TsAXZKmEm1YsqSNstkbmfUYGZ7Eskh8zuKKJWkiRue5+Ghk4VKNl+x
        ZqGmACvE/4vpKIrn8LusZatDMb7daItKWPumTolgX8xkk2z/KmSfClk3LSalAC9r6V6/Es
        mKLpJOn2F2Z2PzuXhoxy61DqIZlxE+c=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505--UYCS4FZPnale-CgzcWn_A-1; Mon, 04 Apr 2022 21:49:24 -0400
X-MC-Unique: -UYCS4FZPnale-CgzcWn_A-1
Received: by mail-il1-f200.google.com with SMTP id l8-20020a056e020dc800b002ca4c433357so1956705ilj.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWfhkJFq1BCdKqisyymaNspfijHKW5rO8LQgLYY4Yk0=;
        b=63J5yNcoIpDPaiB39F3XcHIydutVnAnp8wybnfZQFWomz0xuqqQwS2/APGvuSHG9wh
         57VM1Wud3Gf492R/8CaY322otS5wVtBjOZnvYDZf+Ls0bIqedYN2QrB1/O1/gESGWXUw
         FGIRpfBMbAGP13RsGQWdb+YRjKKOlIKjrZVS65AuTeQMyD/fCkSU2FzWosvudGQwHJsh
         f9LJjamo9unvT+hRPXvJ0Nz+xSejXyIAcxRInRbYxaSeMCCqPLnBYGiX8qDGrPr1Nfpf
         UwiGsUl/WhGlZNP9+PEQdOTbCioqrJbBnRoi2o53kPxdDn8jcUS9u+koqMs/9g3Hj2LV
         x0bQ==
X-Gm-Message-State: AOAM53220A+WUsCUY7mmW6Un4v3UPrVo83IDgz7PRgiJiE1JeCk6UjqQ
        u1RHi3e41xC91gLp8OQxoSAovHtzK/G61/z0l1QxPIeW6rVg3TJqOecGw60E99QznMABIYaPmhd
        808UBUp2I0ArvjRgZcc228UiUUg/BN6YmSoko3OzzBpHh9Xu2GNpQ4BXMGu/K4bWqP/akHN06oA
        ==
X-Received: by 2002:a02:cd12:0:b0:321:29bd:b5ae with SMTP id g18-20020a02cd12000000b0032129bdb5aemr659611jaq.83.1649123363651;
        Mon, 04 Apr 2022 18:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFo84QPKUst3NxwRFnpoGwYsq1cNnk6B7cOmPSPQoeut9h5XdJGOgIWmVZYMgQ4peNHpQKkw==
X-Received: by 2002:a02:cd12:0:b0:321:29bd:b5ae with SMTP id g18-20020a02cd12000000b0032129bdb5aemr659588jaq.83.1649123363425;
        Mon, 04 Apr 2022 18:49:23 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id z12-20020a92d18c000000b002ca3ac378e2sm2852863ilz.76.2022.04.04.18.49.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 19/23] mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
Date:   Mon,  4 Apr 2022 21:49:21 -0400
Message-Id: <20220405014921.14994-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we're trying to collapse a 2M huge shmem page, don't retract pgtable pmd
page if it's registered with uffd-wp, because that pgtable could have pte
markers installed.  Recycling of that pgtable means we'll lose the pte markers.
That could cause data loss for an uffd-wp enabled application on shmem.

Instead of disabling khugepaged on these files, simply skip retracting these
special VMAs, then the page cache can still be merged into a huge thp, and
other mm/vma can still map the range of file with a huge thp when proper.

Note that checking VM_UFFD_WP needs to be done with mmap_sem held for write,
that avoids race like:

         khugepaged                             user thread
         ==========                             ===========
     check VM_UFFD_WP, not set
                                       UFFDIO_REGISTER with uffd-wp on shmem
                                       wr-protect some pages (install markers)
     take mmap_sem write lock
     erase pmd and free pmd page
      --> pte markers are dropped unnoticed!

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/khugepaged.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 04a972259136..d7c5bb9fd1fb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1464,6 +1464,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
 		return;
 
+	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
+	if (userfaultfd_wp(vma))
+		return;
+
 	hpage = find_lock_page(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
 	if (!hpage)
@@ -1599,7 +1603,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * reverse order. Trylock is a way to avoid deadlock.
 		 */
 		if (mmap_write_trylock(mm)) {
-			if (!khugepaged_test_exit(mm))
+			/*
+			 * When a vma is registered with uffd-wp, we can't
+			 * recycle the pmd pgtable because there can be pte
+			 * markers installed.  Skip it only, so the rest mm/vma
+			 * can still have the same file mapped hugely, however
+			 * it'll always mapped in small page size for uffd-wp
+			 * registered ranges.
+			 */
+			if (!khugepaged_test_exit(mm) && !userfaultfd_wp(vma))
 				collapse_and_free_pmd(mm, vma, addr, pmd);
 			mmap_write_unlock(mm);
 		} else {
-- 
2.32.0

