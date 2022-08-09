Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA16558E249
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiHIWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiHIWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FE32E16
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJCqPuuo957wqhSKd7LcKTP/opuSiey74Ok7HcmJ/F0=;
        b=NoLT7q6oCXqtVwFy7b8KU5j5J5Bf1jrwczrbWLOy0pO6ke3GjCeith3sxsgjjvtLzo0Aj0
        NFlWsYyhkOxZ4zVchYaJk51A5V2TRRAd1YuWgjOqA7/gxAeQrDw84VWxzAaKH+UB2qZcly
        Gip6xEla+YxzhJIa5IVG0MvLOikhU44=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-g4aZRk8SONqVMZ5TJRz_og-1; Tue, 09 Aug 2022 18:01:06 -0400
X-MC-Unique: g4aZRk8SONqVMZ5TJRz_og-1
Received: by mail-qv1-f72.google.com with SMTP id p14-20020a0cfd8e000000b004747f93486bso6958236qvr.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KJCqPuuo957wqhSKd7LcKTP/opuSiey74Ok7HcmJ/F0=;
        b=nyr5zICaIqGIQn3uhLA85m0BIdKTIxZoLrYr9DEBDeiVokEkNgxl73D8lkOReLHbOS
         DbFX0s9aCjLoeKPNTY9+vEw0LpZdv6GO1KVT5E4k3fVvkGDhzk4sEJhJr9mBNt9L3xm2
         e4Qg4aMac6o3/jYJimKv38wLojkEiWJvcWkwx/xBlNruMCfjVhOQIU6AcDHQ2E8peeCd
         Wsa1Cr2GkS738neCF9ckgi0UCtGVLrsCZVRJ7nuMIRwBlgLl/19qy7tTELU1aHVTcw1B
         9RzuiDX4ltiyVJORe0Tr8WJbiH7hlIl9pJuQt3Ad8JJPvAPiQnKt2zP7wZ92qtGH36zS
         OfaA==
X-Gm-Message-State: ACgBeo0/HZ3itruqon3VYu9EqDFofd85gwpxuHioNVgh17NdI5LYuRiQ
        7k6Ki0KVZmfZKi+O3PMRidFs+OaBVDIZ86I+KXEuqnGNFaq7YV4h7MonQYKIGtuvfoDibVpFLDB
        oBrIhHvzE+ntCOqHEcYT8evyy
X-Received: by 2002:a05:622a:100d:b0:31f:25e3:7a45 with SMTP id d13-20020a05622a100d00b0031f25e37a45mr21707219qte.365.1660082465949;
        Tue, 09 Aug 2022 15:01:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6NiOVfmdP51FutgyMM1ys4/L82L2FgMCUHx+9da7UIEtdC/XWDWNPnpXmCoiTlsJ6ASHYdnw==
X-Received: by 2002:a05:622a:100d:b0:31f:25e3:7a45 with SMTP id d13-20020a05622a100d00b0031f25e37a45mr21707192qte.365.1660082465744;
        Tue, 09 Aug 2022 15:01:05 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 2/7] mm/swap: Comment all the ifdef in swapops.h
Date:   Tue,  9 Aug 2022 18:00:55 -0400
Message-Id: <20220809220100.20033-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220809220100.20033-1-peterx@redhat.com>
References: <20220809220100.20033-1-peterx@redhat.com>
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

