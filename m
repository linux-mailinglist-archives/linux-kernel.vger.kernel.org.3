Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD04CD9FA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiCDRUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiCDRUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:04 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31527141473
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:15 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t28so7935171qtc.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gC8xukYRNS8d0cnjgjbmsbbS5jxefCyF6174YZWgnjY=;
        b=EN3R7adYfpnEOWaaYZXQKyz8kaKfr+Bd7zDtYsZ8ibpGqS9LczOy+G+udlplQP2aBG
         LkwI4eLYAVEl0JQPW+nHzg1CE9/iNKsDUDxhLDCwb60avkEMlniZADfF3ckIRer5vrL8
         3LKvuk7tdZEk9VoRodQzciPB+WdLReJ64EhExsIu9iX6XbqRMgd5rmCg/fCFRTw0W6ZD
         D1o8O0uy3cDhrP+DLRG4uf8++dpyRC0cyqUEupVD0XeJcqqKXhG/KQ7T7+blVWAkDpvJ
         T10GcMNkGBWR4W7YX/Jccc/toKSAFTso8TUINpvPl2qmLf25L0/lOeK1P4XcnvmlF2PV
         bxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gC8xukYRNS8d0cnjgjbmsbbS5jxefCyF6174YZWgnjY=;
        b=Qdtk9o86LjoxD2HL52MZQaOe1s/Af9AlyVQrnbOrdw6Kh/PamkGaBMWnKrLP4NgUe+
         tM7MSYZ2OLhH9Kb8Aqc1ffAmEzVPOihFofRvtZSEneKnlXHg7dF+ejonajrCTdxbUVrK
         +hcsGs1i+41OqCGx7GPHjLXcsbIO1PhL94MxCeSp/j57w0oWGjbt2Nj2I2wGSsrYU6us
         G8Z2IPkEVfQBV3wmRm19MTMTY6csagEwRAtNwYahKPDUNAE6Xt0lOTD1Kr7zCt+Qes+m
         d91DmaWRrdvxHhy+pgJw3YHxQlopLwSi2WEhCVxrFnuVFVspBjqrgAcn+NlK44eDKTTn
         h1xg==
X-Gm-Message-State: AOAM530cwyeqYHU1CyMgEnx0esAwlsyvNOm3GBsOq2YqoZnLo98dnzWV
        AuR/YzzFHKq1YcfeCDPKNYpfQQ==
X-Google-Smtp-Source: ABdhPJxPQ9l0ykDqVILGa4/U3r2RMyng9xdOipGnusx7p6vU8aXPKjqwclYZgDWhQeUi+ZvZ89KH7w==
X-Received: by 2002:ac8:7d8f:0:b0:2de:2da6:945f with SMTP id c15-20020ac87d8f000000b002de2da6945fmr32279889qtd.351.1646414354358;
        Fri, 04 Mar 2022 09:19:14 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm2550853qkb.86.2022.03.04.09.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 09:19:13 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>, dgilbert@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Date:   Fri,  4 Mar 2022 12:19:12 -0500
Message-Id: <20220304171912.305060-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED historically rejects mlocked ranges, but with
MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
there are valid use cases for depopulating locked ranges as well.

Users mlock memory to protect secrets. There are allocators for secure
buffers that want in-use memory generally mlocked, but cleared and
invalidated memory to give up the physical pages. This could be done
with explicit munlock -> mlock calls on free -> alloc of course, but
that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
splits and re-merges - only to get rid of the backing pages.

Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
okay with on-demand initial population. It seems valid to selectively
free some memory during the lifetime of such a process, without having
to mess with its overall policy.

Why add a separate flag? Isn't this a pretty niche usecase?

- MADV_DONTNEED has been bailing on locked vmas forever. It's at least
  conceivable that someone, somewhere is relying on mlock to protect
  data from perhaps broader invalidation calls. Changing this behavior
  now could lead to quiet data corruption.

- It also clarifies expectations around MADV_FREE and maybe
  MADV_REMOVE. It avoids the situation where one quietly behaves
  different than the others. MADV_FREE_LOCKED can be added later.

- The combination of mlock() and madvise() in the first place is
  probably niche. But where it happens, I'd say that dropping pages
  from a locked region once they don't contain secrets or won't page
  anymore is much saner than relying on mlock to protect memory from
  speculative or errant invalidation calls. It's just that we can't
  change the default behavior because of the two previous points.

Given that, an explicit new flag seems to make the most sense.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/uapi/asm-generic/mman-common.h |  2 ++
 mm/madvise.c                           | 24 ++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

v2:
- mmap_sem for read is enough for DONTNEED_LOCKED, thanks Nadav
- rebased on top of Mike's hugetlb DONTNEED patch in -mm

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 1567a3294c3d..6c1aa92a92e4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -75,6 +75,8 @@
 #define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
 #define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
 
+#define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e4ddd00878b5..5b6d796e55de 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -52,6 +52,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_REMOVE:
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
 	case MADV_FREE:
@@ -502,14 +503,9 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static inline bool can_madv_lru_non_huge_vma(struct vm_area_struct *vma)
-{
-	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP));
-}
-
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
-	return can_madv_lru_non_huge_vma(vma) && !is_vm_hugetlb_page(vma);
+	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP|VM_HUGETLB));
 }
 
 static long madvise_cold(struct vm_area_struct *vma,
@@ -787,10 +783,16 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
 					    unsigned long *end,
 					    int behavior)
 {
-	if (!is_vm_hugetlb_page(vma))
-		return can_madv_lru_non_huge_vma(vma);
+	if (!is_vm_hugetlb_page(vma)) {
+		unsigned int forbidden = VM_PFNMAP;
+
+		if (behavior != MADV_DONTNEED_LOCKED)
+			forbidden |= VM_LOCKED;
+
+		return !(vma->vm_flags & forbidden);
+	}
 
-	if (behavior != MADV_DONTNEED)
+	if (behavior != MADV_DONTNEED && behavior != MADV_DONTNEED_LOCKED)
 		return false;
 	if (start & ~huge_page_mask(hstate_vma(vma)))
 		return false;
@@ -854,7 +856,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		VM_WARN_ON(start >= end);
 	}
 
-	if (behavior == MADV_DONTNEED)
+	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
 		return madvise_dontneed_single_vma(vma, start, end);
 	else if (behavior == MADV_FREE)
 		return madvise_free_single_vma(vma, start, end);
@@ -993,6 +995,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		return madvise_pageout(vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
@@ -1123,6 +1126,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_REMOVE:
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
 	case MADV_FREE:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
-- 
2.35.1

