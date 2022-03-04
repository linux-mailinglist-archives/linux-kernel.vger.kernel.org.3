Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9C4CCCFA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiCDFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiCDFUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C9118621A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRicOcRvWzoxpLs51SSJ+aFkDsMZLS/bjPquNOlSlQc=;
        b=Yca8+iVM3eE0dnGc4A+nYlYi/0dJC4srfLiwgqVURRSjZNFUyIGTq+TIpedDa5UOGf0TN0
        UjQANFq1ATI+ZAsOAK7UrqG7IYW9DT30nw8O34aR0daTjOKA6h2vezX3cjhQWvtZBMy6ic
        gudt5oLeziktB5AFc80UWwxIRgkV88Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-r29z7rh0N1uL0nfaiV1c2Q-1; Fri, 04 Mar 2022 00:19:56 -0500
X-MC-Unique: r29z7rh0N1uL0nfaiV1c2Q-1
Received: by mail-pg1-f200.google.com with SMTP id g31-20020a63521f000000b003783582a261so3923368pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRicOcRvWzoxpLs51SSJ+aFkDsMZLS/bjPquNOlSlQc=;
        b=swfysf/hzH6y2mgdTPasDfG1YlUJGbnvjIT/apnye9iCg3pvhS/xLw9sTFG3JERKCg
         RV6TFTxWSmVQKDS835PxvGQf7cF9omcsqLXlM1Apw6Vosnrch0B3xVvm+eChGJJS8KdM
         x7TPzcj7rkWTGMDo6BdtoylRR6VnToRHuIpyzHve4fiVYZaP45XRFmhueNQKap3soH4D
         SVzrtMrNkLjnBdxo8EY/OgbmJzUjMYnZMIVjYRm4MufJAzAA2sZTZXp7yuBN2kZ7+m3Q
         wVQZJk1tkV9ws5b7+jHFzDBb2l7qi6vp47P3zXVYEVxyEKHR1/gSJ0ZJuqHEYOODWxfc
         qrhw==
X-Gm-Message-State: AOAM533EGRnsQUV+U++w2M6FmY+SUJfSkaG6rb4VGn616XAIwdm2QIiT
        gWHjYJN/PFrnoI0v6BTHg2pRbdyz2Zj8JmgIQI3+ddNTVVzcmKMk0QuddZuYKKzEr6zFHO8WakI
        bGWSZW1cLy1Hd5pchtzSUZO5T
X-Received: by 2002:a63:8bca:0:b0:37c:9049:103 with SMTP id j193-20020a638bca000000b0037c90490103mr2179463pge.387.1646371195375;
        Thu, 03 Mar 2022 21:19:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMQjw3TZyj+/ynwRaeUsP3tPV3EyAhD/DLSy/Gjrm4jimUydTxbOQNlZECErcoEoI+7O+Amw==
X-Received: by 2002:a63:8bca:0:b0:37c:9049:103 with SMTP id j193-20020a638bca000000b0037c90490103mr2179446pge.387.1646371195056;
        Thu, 03 Mar 2022 21:19:55 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 19/23] mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
Date:   Fri,  4 Mar 2022 13:17:04 +0800
Message-Id: <20220304051708.86193-20-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
index a4e5eaf3eb01..87d88d6725af 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1456,6 +1456,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
 		return;
 
+	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
+	if (userfaultfd_wp(vma))
+		return;
+
 	hpage = find_lock_page(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
 	if (!hpage)
@@ -1591,7 +1595,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
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

