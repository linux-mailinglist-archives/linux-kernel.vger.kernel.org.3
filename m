Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFE5AA308
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiIAW3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiIAW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:29:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828083BC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:27:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q15so143471pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Lo7nlr4ngh+9J4kFVHJNG61HSBnAKEXajh28lyOmbuQ=;
        b=LKowKo28eGkwfw5+o6KUV/8v86qC+HRML8ipAx9y1Tvp6Yn4pjIpRwG6NPISoNGGpL
         CBuoJzMvq1++2aTlnBrIj5b6mB1NbcBo3kHciadOGPxs42cKkVEypdkq+tyqDgW9zqYn
         qV/+Hku/vHcqYzDiPbIrzowhYjKuWZDUuFoLJAOKFsNHYHWgQ+evMxseMkT0pX8VsV8S
         OVsQHtt0lZa4/k4qe90CXJ3BtuFWOcBezvS4Lfbv2sJr878ozn2sndhtfv3rTVA65yPw
         2G4trdn5dcmzkCF8i06w0B4ZTJ09bCqz7vHJlthhSeIAs493Z8G71dyWhEZhszpaYetl
         ug2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Lo7nlr4ngh+9J4kFVHJNG61HSBnAKEXajh28lyOmbuQ=;
        b=SDIuYxgOEY1Zxd4knZnkJQWz8GFg8m4otAMLaBZ873G3FAabCKRMOQtdIBVexoX78M
         rrtZvnXt1hn1xXZNu5twguHB3DzpLNgNaGWvAACvUR6+ugIDKdkyXFonOOAQKf9M2NAc
         I8FX8S4m7mEcgjp4wVn37TeE/S++Pir4wkHySaYsdGpiaPjcNaLw79nl6sPe7cLP0fTG
         fhHGyuxxgjetJqPDwOyfAEOz2rMXG6zO4xQ2MCLlXZDDGIbDPW36dZzjeuorpGDaBylc
         Gh/zed49ySqJt6pGzYqmMc3nHrwY/8vuy4SXh314Bbfk2kuG/2Lbijsn/uW386uq4GmR
         oiwA==
X-Gm-Message-State: ACgBeo0swQgr8QAQEaldwRS4Qxi53Q+3eQqU4yNJfaeQWf2tqnDhu0tE
        2jezMEoSIkOnUypK64iniQ4=
X-Google-Smtp-Source: AA6agR7+/t+ApeGA/lwoDZbioFjKzHBNd4dPLG/4QJjwOWxP23ckzXzZ6g1CYM+FOF4LbevEGKEK9A==
X-Received: by 2002:a05:6a00:2918:b0:536:3967:5d08 with SMTP id cg24-20020a056a00291800b0053639675d08mr33083798pfb.68.1662071230457;
        Thu, 01 Sep 2022 15:27:10 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b0016b81679c1fsm68494ple.216.2022.09.01.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:27:09 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     david@redhat.com, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Date:   Thu,  1 Sep 2022 15:27:07 -0700
Message-Id: <20220901222707.477402-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
sufficient to handle concurrent GUP-fast in all cases, it only handles
traditional IPI-based GUP-fast correctly.  On architectures that send
an IPI broadcast on TLB flush, it works as expected.  But on the
architectures that do not use IPI to broadcast TLB flush, it may have
the below race:

   CPU A                                          CPU B
THP collapse                                     fast GUP
                                              gup_pmd_range() <-- see valid pmd
                                                  gup_pte_range() <-- work on pte
pmdp_collapse_flush() <-- clear pmd and flush
__collapse_huge_page_isolate()
    check page pinned <-- before GUP bump refcount
                                                      pin the page
                                                      check PTE <-- no change
__collapse_huge_page_copy()
    copy data to huge page
    ptep_clear()
install huge pmd for the huge page
                                                      return the stale page
discard the stale page

The race could be fixed by checking whether PMD is changed or not after
taking the page pin in fast GUP, just like what it does for PTE.  If the
PMD is changed it means there may be parallel THP collapse, so GUP
should back off.

Also update the stale comment about serializing against fast GUP in
khugepaged.

Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/gup.c        | 30 ++++++++++++++++++++++++------
 mm/khugepaged.c | 10 ++++++----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f3fc1f08d90c..4365b2811269 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 }
 
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
-static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+			 unsigned long end, unsigned int flags,
+			 struct page **pages, int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
 	int nr_start = *nr, ret = 0;
@@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 		}
 
-		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+		/*
+		 * THP collapse conceptually does:
+		 *   1. Clear and flush PMD
+		 *   2. Check the base page refcount
+		 *   3. Copy data to huge page
+		 *   4. Clear PTE
+		 *   5. Discard the base page
+		 *
+		 * So fast GUP may race with THP collapse then pin and
+		 * return an old page since TLB flush is no longer sufficient
+		 * to serialize against fast GUP.
+		 *
+		 * Check PMD, if it is changed just back off since it
+		 * means there may be parallel THP collapse.
+		 */
+		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
+		    unlikely(pte_val(pte) != pte_val(*ptep))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
@@ -2470,8 +2487,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
  * get_user_pages_fast_only implementation that can pin pages. Thus it's still
  * useful to have gup_huge_pmd even if we can't operate on ptes.
  */
-static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+			 unsigned long end, unsigned int flags,
+			 struct page **pages, int *nr)
 {
 	return 0;
 }
@@ -2791,7 +2809,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
 					 PMD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
+		} else if (!gup_pte_range(pmd, pmdp, addr, next, flags, pages, nr))
 			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2d74cf01f694..518b49095db3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1049,10 +1049,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 
 	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
 	/*
-	 * After this gup_fast can't run anymore. This also removes
-	 * any huge TLB entry from the CPU so we won't allow
-	 * huge and small TLB entries for the same virtual address
-	 * to avoid the risk of CPU bugs in that area.
+	 * This removes any huge TLB entry from the CPU so we won't allow
+	 * huge and small TLB entries for the same virtual address to
+	 * avoid the risk of CPU bugs in that area.
+	 *
+	 * Parallel fast GUP is fine since fast GUP will back off when
+	 * it detects PMD is changed.
 	 */
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
-- 
2.26.3

