Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A249C578B01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiGRThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGRThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9F2A42A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id o12so11561506pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqN6lUA6CKPQ6pXduKwXrnAjAVaaU8p/HZgGKWiS1UU=;
        b=anEaeCdDUpWprBhzF25fJpAdtW+LgFlwZ2ebfZ8wM0kpnCfn2B96Ny11a5FiZPFqb+
         8d217vnOhZgu2PfDrycJhxqOQiXud4xvWn2c80DYc99oVi3Ir9FehDJAGUmSeOUhksfr
         QR+ahMTY316YC8qzqWOkrwI9aF+uUCzKo6Q+X7SXWicVhjcsJrIFPjQgPYBlrrFSkyza
         nrpLpAgplwp8N1Y7IPDrjQick91Rj9cFFO7tm3RrwD9n6LXQmJHs9J6KNpKvgDrlFFhE
         LWoW2wCSjvgnI+efvRVSp0tdhvWKQfmNMDQryOAu3HMUlJExJUMY0OFO8aRltUkZiSpA
         eLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqN6lUA6CKPQ6pXduKwXrnAjAVaaU8p/HZgGKWiS1UU=;
        b=0DO4pzxrliP/dqSm6i1TMjEcuUmJTOsiktjtipKQbU6qESLpd/fajXu8V0GbCccJvY
         DoXADkPg2x/EfAaYCcVOLpJgxEv3Y3BYQhfUZTukrmxhQexzyNE0DU8ZNISKBx9SY4S8
         xTKISLCKK3V88V5h6jCXG6naAck/g3JZSZ3fMU/cDy3Tlw8ljVNMRWovo5GWjWSkWkmN
         kn0n5osuEYkwqU3v0gDhTNCb3hPxcq/qL5MQl72crBKi51UP2/9MtSuk/ziK+9GKf/vb
         yhPHdKd0301uiCbsRH67y/HQVE0Y1kMJbnHoD3IfA5cyG9aAlpjVDpM+FSXcjinHIo50
         HQmA==
X-Gm-Message-State: AJIora/Sd2YxhNXWsLIJSAWKQ6SHyMpuDmaK4RnCH1g8kQ7A33ATm3CZ
        8E/OGD7xhw05rJQEN6oVurQ=
X-Google-Smtp-Source: AGRyM1t4cIpL6IVhzKiQES1MTghU8BQMTlI5pi0eeK/ksqsiBBWEFmy9twLEG4Iqd+Ne+Q/gUcyJmQ==
X-Received: by 2002:a05:6a00:b92:b0:52a:e60d:dfbb with SMTP id g18-20020a056a000b9200b0052ae60ddfbbmr29561053pfj.72.1658173024046;
        Mon, 18 Jul 2022 12:37:04 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:03 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 01/14] userfaultfd: set dirty and young on writeprotect
Date:   Mon, 18 Jul 2022 05:01:59 -0700
Message-Id: <20220718120212.3180-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120212.3180-1-namit@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

When userfaultfd makes a PTE writable, it can now change the PTE
directly, in some cases, without going triggering a page-fault first.
Yet, doing so might leave the PTE that was write-unprotected as old and
clean. At least on x86, this would cause a >500 cycles overhead when the
PTE is first accessed.

Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
gets a hint that the page is likely to be used. Avoid changing the PTE
to young and dirty in other cases to avoid excessive writeback and
messing with the page reclamation logic.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
---
 include/linux/mm.h | 2 ++
 mm/mprotect.c      | 9 ++++++++-
 mm/userfaultfd.c   | 8 ++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9cc02a7e503b..4afd75ce5875 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 /* Whether this change is for write protecting */
 #define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
 #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
+/* Whether to try to mark entries as dirty as they are to be written */
+#define  MM_CP_WILL_NEED		   (1UL << 4)
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 996a97e213ad..34c2dfb68c42 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
+	bool will_need = cp_flags & MM_CP_WILL_NEED;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 
@@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 				ptent = pte_clear_uffd_wp(ptent);
 			}
 
+			if (will_need)
+				ptent = pte_mkyoung(ptent);
+
 			/*
 			 * In some writable, shared mappings, we might want
 			 * to catch actual write access -- see
@@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			 */
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
 			    !pte_write(ptent) &&
-			    can_change_pte_writable(vma, addr, ptent))
+			    can_change_pte_writable(vma, addr, ptent)) {
 				ptent = pte_mkwrite(ptent);
+				if (will_need)
+					ptent = pte_mkdirty(ptent);
+			}
 
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			if (pte_needs_flush(oldpte, ptent))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 954c6980b29f..e0492f5f06a0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -749,6 +749,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	bool enable_wp = uffd_flags & UFFD_FLAGS_WP;
 	struct vm_area_struct *dst_vma;
 	unsigned long page_mask;
+	unsigned long cp_flags;
 	struct mmu_gather tlb;
 	pgprot_t newprot;
 	int err;
@@ -795,9 +796,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	else
 		newprot = vm_get_page_prot(dst_vma->vm_flags);
 
+	cp_flags = enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE;
+	if (uffd_flags & (UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY))
+		cp_flags |= MM_CP_WILL_NEED;
+
 	tlb_gather_mmu(&tlb, dst_mm);
-	change_protection(&tlb, dst_vma, start, start + len, newprot,
-			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
+	change_protection(&tlb, dst_vma, start, start + len, newprot, cp_flags);
 	tlb_finish_mmu(&tlb);
 
 	err = 0;
-- 
2.25.1

