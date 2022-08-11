Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B46590498
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiHKQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiHKQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F781A5C5D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9J0o2gxjPkVRafIB7R87NmoXI0VU2ltkrT9Ru6AEjI=;
        b=foQFPNwdWgpeCALFHqPbqDZ/O3iGjk/aO71b7h5s6k0Iu79g86AZ7+mpwIDzl2v4tphOZD
        CYtEKltjrVQ1MC/AEBzSnDHBO1rMxBL9kXFeiWvV/kyenBmX7nreVs9yYdgMUGNmwLlz+q
        YBGJ6JU8J4BrTbA8HS0OXEnNDZOSAj4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-qfaHNue-NFGA8MWcKMBfAw-1; Thu, 11 Aug 2022 12:13:38 -0400
X-MC-Unique: qfaHNue-NFGA8MWcKMBfAw-1
Received: by mail-il1-f197.google.com with SMTP id w6-20020a056e021a6600b002dea6904708so12726372ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=m9J0o2gxjPkVRafIB7R87NmoXI0VU2ltkrT9Ru6AEjI=;
        b=ZMeRT0VhOmeDVNMPqpGCfqU1FGcC28Dazd1dWF5r7JyE7+MiFp4LuYsY1uj3VJpcQD
         gDnA5hqf5kmca/V8XRUYpMn5Vitkv6s8ehyKOby291o6TSv5TCNRSbMW0/ccCN3RelFz
         zWUq0g3/iKqh1K6lYzzguNWnWyecL0BV34jg9enXlmpshKapQ9RMGNDl9bFWADws7cy6
         ZJh4FCTvPvZ/H8xA5a1Oytc+Ua9+jej9EY5WenfJmG7yOYowFdMD8LDT5cyTQKqfV6Sl
         Cy6G1ACq1hK4hsBzV0KJzh05fHaDjPN8NzqVYreSt/uqDT/IFvBeVpXHzv0NGfzIKm86
         ANGg==
X-Gm-Message-State: ACgBeo3aKl5CFxwAtUhGnIVIVan0FBFIiCnqaOv6tsTR4CfbFl4Vjrjm
        BxUS7kwuK2RNgrsC+rqOWN7hbUBBlAX6cLVHVmt0G6R4IdGe3p678I1gCvpQr1mN2igc0n3hgbY
        Ve5jLcmJeZqxL5ThX+4WMEtgi
X-Received: by 2002:a6b:c505:0:b0:67c:dcd:a5b2 with SMTP id v5-20020a6bc505000000b0067c0dcda5b2mr17914iof.37.1660234417482;
        Thu, 11 Aug 2022 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/bnpktdH+KIUEDaTM72sZY/jQsDJec0sJqNd+QvV0NBcU4DHXpzsUzSl7BCeITxJOQpuLrg==
X-Received: by 2002:a6b:c505:0:b0:67c:dcd:a5b2 with SMTP id v5-20020a6bc505000000b0067c0dcda5b2mr17905iof.37.1660234417290;
        Thu, 11 Aug 2022 09:13:37 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 2/7] mm/swap: Comment all the ifdef in swapops.h
Date:   Thu, 11 Aug 2022 12:13:26 -0400
Message-Id: <20220811161331.37055-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220811161331.37055-1-peterx@redhat.com>
References: <20220811161331.37055-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swapops.h contains quite a few layers of ifdef, some of the "else" and
"endif" doesn't get proper comment on the macro so it's hard to follow on
what are they referring to.  Add the comments.

Suggested-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a3d435bf9f97..3a2901ff4f1e 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -247,8 +247,8 @@ extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 #ifdef CONFIG_HUGETLB_PAGE
 extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
-#endif
-#else
+#endif	/* CONFIG_HUGETLB_PAGE */
+#else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
 	return swp_entry(0, 0);
@@ -276,7 +276,7 @@ static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 #ifdef CONFIG_HUGETLB_PAGE
 static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
-#endif
+#endif	/* CONFIG_HUGETLB_PAGE */
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
 	return 0;
@@ -286,7 +286,7 @@ static inline int is_readable_migration_entry(swp_entry_t entry)
 	return 0;
 }
 
-#endif
+#endif	/* CONFIG_MIGRATION */
 
 typedef unsigned long pte_marker;
 
@@ -426,7 +426,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 {
 	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
 }
-#else
+#else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
@@ -455,7 +455,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 {
 	return 0;
 }
-#endif
+#endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
 #ifdef CONFIG_MEMORY_FAILURE
 
@@ -495,7 +495,7 @@ static inline void num_poisoned_pages_sub(long i)
 	atomic_long_sub(i, &num_poisoned_pages);
 }
 
-#else
+#else  /* CONFIG_MEMORY_FAILURE */
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
 {
@@ -514,7 +514,7 @@ static inline void num_poisoned_pages_inc(void)
 static inline void num_poisoned_pages_sub(long i)
 {
 }
-#endif
+#endif  /* CONFIG_MEMORY_FAILURE */
 
 static inline int non_swap_entry(swp_entry_t entry)
 {
-- 
2.32.0

