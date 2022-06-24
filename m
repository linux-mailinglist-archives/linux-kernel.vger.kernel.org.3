Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA6559FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiFXRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFXRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DD609CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317b6ecba61so27045837b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/rA4FWSpYAR9L2sjJS2B0eCc4aGZeNFQ2hS7zEPXx88=;
        b=mjmAAKf/rdfFJdvjC9OXk41WB0xb48wdXBGxSuL0EQl9SkDoXcqxrY9GXlvPWLaEkg
         8Hx1fw01wcTtT9K/GLcq3rroLEsW0zKCq/TUIz18NlMwdRcR1pA7Iaz2vn8ZlKAXcim1
         wOaCTh2gfUTYSHpFrxRcxF2GTYKnhiAIuJO4LJxX4Vd8vg8DEaO1anDPe1vI6jmOnZyo
         xym6RDo4VAwtwvCcWa490l4s9zNK4x/xstjaksrlIYlIG61i/GAqmjnAH04jRi+sdL4m
         P8snVFmVGcbUsQWry1OYKwwBVkaqJWg10bFh2y6ecVXque/dyOxRMd1yJMz25o75f8Kd
         6OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/rA4FWSpYAR9L2sjJS2B0eCc4aGZeNFQ2hS7zEPXx88=;
        b=RhUggUbMqs+mZLjQov3DhLCIXFTFIjkWOveiCweLm3evIDuUT3Ys9ynPQ5uBmmz2JU
         Un9hzbfTFeQyGnM8jpw3s6SN1wBeH8WvW3dEdmXBxSwumDBa4OIUEANfGH3c/DZuFVh+
         JSQG+DMFUPtdTVk7Zva/vwm67J8vXMCnLGPyyeNU4LME2zhw+PhhB6NsvmkuZKFuwOfr
         n38yA7rA1SrisO5bvAu+NufDKy855ZOWcb2ELNX7DzdPUS5m+lGfnSAZJWcoc8uiCCcR
         U/b4YnxP0FP/24nHMktT+d9fpkeuiJnIAKKBt8p7L1aOtvJ4bRgF2Fnd0KecFiRFteDR
         oaGA==
X-Gm-Message-State: AJIora8SLplLfU+JwHxd9bU92cZiPsZ5+16v7Mx0pAk4KTmOfD5sMDkb
        tcEvdB+heOC5nP4wnr31pSVIGttlaAgR93z0
X-Google-Smtp-Source: AGRyM1t9tv0yjearXIr71+3GNqpFRDSr2edCHZwVgwQ6f0v6TT0Pfet2HMTd37UlieYMZq6c6zvogGIBBnnftS40
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:b806:0:b0:663:d35d:8b8a with SMTP
 id v6-20020a25b806000000b00663d35d8b8amr282022ybj.69.1656092237926; Fri, 24
 Jun 2022 10:37:17 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:36 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-7-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 06/26] mm: make free_p?d_range functions public
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes them usable for HugeTLB page table freeing operations.
After HugeTLB high-granularity mapping, the page table for a HugeTLB VMA
can get more complex, and these functions handle freeing page tables
generally.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/mm.h | 7 +++++++
 mm/memory.c        | 8 ++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..07f5da512147 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1847,6 +1847,13 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 
 struct mmu_notifier_range;
 
+void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long addr);
+void free_pmd_range(struct mmu_gather *tlb, pud_t *pud, unsigned long addr,
+		unsigned long end, unsigned long floor, unsigned long ceiling);
+void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d, unsigned long addr,
+		unsigned long end, unsigned long floor, unsigned long ceiling);
+void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd, unsigned long addr,
+		unsigned long end, unsigned long floor, unsigned long ceiling);
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
diff --git a/mm/memory.c b/mm/memory.c
index 7a089145cad4..bb3b9b5b94fb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -227,7 +227,7 @@ static void check_sync_rss_stat(struct task_struct *task)
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
 			   unsigned long addr)
 {
 	pgtable_t token = pmd_pgtable(*pmd);
@@ -236,7 +236,7 @@ static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
 	mm_dec_nr_ptes(tlb->mm);
 }
 
-static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
 				unsigned long floor, unsigned long ceiling)
 {
@@ -270,7 +270,7 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	mm_dec_nr_pmds(tlb->mm);
 }
 
-static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
+inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 				unsigned long addr, unsigned long end,
 				unsigned long floor, unsigned long ceiling)
 {
@@ -304,7 +304,7 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 	mm_dec_nr_puds(tlb->mm);
 }
 
-static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
+inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
 				unsigned long floor, unsigned long ceiling)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

