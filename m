Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB54D67F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbiCKRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348689AbiCKRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:47:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E513A1CC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:03 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so20635243eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16FTiziTuHY7luYyqhUgZZQe9XBDNooPz6CdRNgABNY=;
        b=oxr+bbXplN7JLlsYtHsTMq87tB9qjjwJovy4Qmphj7sIBHnv5iE72yNg7suTzlkG7R
         oINry5tchEi9fK7FZ7LUmaPJ+jCwkyU4D/uYP1hDIDuAHb5l5rVXjHcij7yoXtKuJ2Zp
         enoa7/O0Z/su2Af9pCcQsKXgeplEeEeWn/P99XC2ffJEz02lS85YB1M8YGyi/hpMUmf1
         ChQ9zzI46OgPcsPId44t45Xpz1NWniqZIQo00/15hexDGgVRQkUiwrC0I30gCFe2bue3
         CtMBKIRZHu7FIrQ/cg6ZOxrbEKmIPRnJXzW/DvCQWv2G24+B32J7iO8vAxujZM6w1EVv
         xiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16FTiziTuHY7luYyqhUgZZQe9XBDNooPz6CdRNgABNY=;
        b=t54SVLhMP6VldT7Dul8nPdCjC9sRKbeeDxI9C6ugqoT91eod3R2A9EaYgIm9oPzTUz
         SnIX6mMrmsC0n8Xr21PXzfWIRRPZD//PP3Qhvv5qmUITKpxCBFlEGC5qVNG7LZxlIz2P
         XcTDiR+pNPbTPqhWLR7iU9fxB9Q3LdwP+pJg3h94FXd6Lgwcz+bvIdQi85fqIlkI/Mqt
         IYrScLxv2Mj5qfP6iGQKaartVkOGIe5ddMxtY7NmvtduYQE70y+OPaepcGeU7KIAxfPV
         yHmsJe2JczgFMzRyrwgw/pDifB2qim+iBCgQRDnUYhvjDvKUIdwtIJ1w6LQuYHDU7HPw
         48fw==
X-Gm-Message-State: AOAM530TJa+2o3eTAs0U6JxRV3SS+qVHcUWQdF68ZDveErFS2V2+BSx2
        8Li7MxxfSW5aPL0jwnBs+mY=
X-Google-Smtp-Source: ABdhPJwrEvlJ1jGKDiP915MpwaiTas/VtSW176/53uKYGRh7P+2bKjGc5/e1w+Yl1fYaK6RmZ7HAyQ==
X-Received: by 2002:a17:907:8a0a:b0:6d8:85a6:4d42 with SMTP id sc10-20020a1709078a0a00b006d885a64d42mr9993383ejc.138.1647020761822;
        Fri, 11 Mar 2022 09:46:01 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm3166909eje.180.2022.03.11.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:46:01 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 8C736A0482; Fri, 11 Mar 2022 18:46:03 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v2 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Date:   Fri, 11 Mar 2022 18:46:02 +0100
Message-Id: <20220311174602.288010-5-matenajakub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311174602.288010-1-matenajakub@gmail.com>
References: <20220311174602.288010-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds trace support for vma_merge to measure successful and unsuccessful
merges of two VMAs with distinct anon_vmas and also trace support for
merges made possible by update of page offset made possible by a previous
patch in this series.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 include/trace/events/mmap.h | 83 +++++++++++++++++++++++++++++++++++++
 mm/internal.h               | 12 ++++++
 mm/mmap.c                   | 69 ++++++++++++++++--------------
 3 files changed, 133 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..bad7abe4899c 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -6,6 +6,27 @@
 #define _TRACE_MMAP_H
 
 #include <linux/tracepoint.h>
+#include <../mm/internal.h>
+
+#define AV_MERGE_TYPES		\
+	EM(MERGE_FAILED)	\
+	EM(AV_MERGE_FAILED)	\
+	EM(AV_MERGE_NULL)	\
+	EM(AV_MERGE_SAME)	\
+	EMe(AV_MERGE_DIFFERENT)
+
+#undef EM
+#undef EMe
+#define EM(a)	TRACE_DEFINE_ENUM(a);
+#define EMe(a)	TRACE_DEFINE_ENUM(a);
+
+AV_MERGE_TYPES
+
+#undef EM
+#undef EMe
+
+#define EM(a)   { a, #a },
+#define EMe(a)  { a, #a }
 
 TRACE_EVENT(vm_unmapped_area,
 
@@ -42,6 +63,68 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vm_av_merge,
+
+	TP_PROTO(int merged, enum vma_merge_res merge_prev,
+			enum vma_merge_res merge_next, enum vma_merge_res merge_both),
+
+	TP_ARGS(merged, merge_prev, merge_next, merge_both),
+
+	TP_STRUCT__entry(
+		__field(int,			merged)
+		__field(enum vma_merge_res,	predecessor_different_av)
+		__field(enum vma_merge_res,	successor_different_av)
+		__field(enum vma_merge_res,	predecessor_with_successor_different_av)
+		__field(int,			same_count)
+		__field(int,			diff_count)
+		__field(int,			failed_count)
+	),
+
+	TP_fast_assign(
+		__entry->merged = merged == 0;
+		__entry->predecessor_different_av = merge_prev;
+		__entry->successor_different_av = merge_next;
+		__entry->predecessor_with_successor_different_av = merge_both;
+		__entry->same_count = (merge_prev == AV_MERGE_SAME) +
+			(merge_next == AV_MERGE_SAME) +
+			(merge_both == AV_MERGE_SAME);
+		__entry->diff_count = (merge_prev == AV_MERGE_DIFFERENT) +
+			(merge_next == AV_MERGE_DIFFERENT) +
+			(merge_both == AV_MERGE_DIFFERENT);
+		__entry->failed_count = (merge_prev == AV_MERGE_FAILED) +
+			(merge_next == AV_MERGE_FAILED) +
+			(merge_both == AV_MERGE_FAILED);
+	),
+
+	TP_printk("merged=%d predecessor=%s successor=%s predecessor_with_successor=%s same_count=%d diff_count=%d failed_count=%d",
+		__entry->merged,
+		__print_symbolic(__entry->predecessor_different_av, AV_MERGE_TYPES),
+		__print_symbolic(__entry->successor_different_av, AV_MERGE_TYPES),
+		__print_symbolic(__entry->predecessor_with_successor_different_av, AV_MERGE_TYPES),
+		__entry->same_count, __entry->diff_count, __entry->failed_count)
+
+);
+
+TRACE_EVENT(vm_pgoff_merge,
+
+	TP_PROTO(struct vm_area_struct *vma, bool anon_pgoff_updated),
+
+	TP_ARGS(vma, anon_pgoff_updated),
+
+	TP_STRUCT__entry(
+		__field(bool,	faulted)
+		__field(bool,	updated)
+	),
+
+	TP_fast_assign(
+		__entry->faulted = vma->anon_vma;
+		__entry->updated = anon_pgoff_updated;
+	),
+
+	TP_printk("faulted=%d updated=%d\n",
+		__entry->faulted, __entry->updated)
+);
 #endif
 
 /* This part must be outside protection */
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..860169612192 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,6 +34,18 @@ struct folio_batch;
 /* Do not use these with a slab allocator */
 #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
 
+/*
+ * Following values indicate reason for merge success or failure.
+ */
+enum vma_merge_res {
+	MERGE_FAILED,
+	AV_MERGE_FAILED,
+	AV_MERGE_NULL,
+	MERGE_OK = AV_MERGE_NULL,
+	AV_MERGE_SAME,
+	AV_MERGE_DIFFERENT,
+};
+
 void page_writeback_init(void);
 
 static inline void *folio_raw_mapping(struct folio *folio)
diff --git a/mm/mmap.c b/mm/mmap.c
index ccb24862e670..663f8ec46f2c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1064,21 +1064,21 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
 	 */
 	if ((!anon_vma1 || !anon_vma2) && (!vma ||
 		list_is_singular(&vma->anon_vma_chain)))
-		return 1;
+		return AV_MERGE_NULL;
 	if (anon_vma1 == anon_vma2)
-		return 1;
+		return AV_MERGE_SAME;
 	/*
 	 * Different anon_vma but not shared by several processes
 	 */
 	else if ((anon_vma1 && anon_vma2) &&
 			(anon_vma1 == anon_vma1->root)
 			&& (rbt_no_children(anon_vma1)))
-		return 1;
+		return AV_MERGE_DIFFERENT;
 	/*
 	 * Different anon_vma and shared -> unmergeable
 	 */
 	else
-		return 0;
+		return AV_MERGE_FAILED;
 }
 
 /*
@@ -1099,12 +1099,10 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
 		     struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 		     const char *anon_name)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name))
 		if (vma->vm_pgoff == vm_pgoff)
-			return 1;
-	}
-	return 0;
+			return is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma);
+	return MERGE_FAILED;
 }
 
 /*
@@ -1121,14 +1119,13 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
 		    struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 		    const char *anon_name)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name)) {
 		pgoff_t vm_pglen;
 		vm_pglen = vma_pages(vma);
 		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
-			return 1;
+			return is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma);
 	}
-	return 0;
+	return MERGE_FAILED;
 }
 
 /*
@@ -1185,8 +1182,14 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
 	int err = -1;
-	bool merge_prev = false;
-	bool merge_next = false;
+	/*
+	 * Following three variables are used to store values
+	 * indicating wheather this VMA and its anon_vma can
+	 * be merged and also the type of failure or success.
+	 */
+	enum vma_merge_res merge_prev = MERGE_FAILED;
+	enum vma_merge_res merge_both = MERGE_FAILED;
+	enum vma_merge_res merge_next = MERGE_FAILED;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
@@ -1207,32 +1210,34 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 
 	/* Can we merge the predecessor? */
 	if (prev && prev->vm_end == addr &&
-			mpol_equal(vma_policy(prev), policy) &&
-			can_vma_merge_after(prev, vm_flags,
+			mpol_equal(vma_policy(prev), policy)) {
+		merge_prev = can_vma_merge_after(prev, vm_flags,
 					    anon_vma, file, pgoff,
-					    vm_userfaultfd_ctx, anon_name)) {
-		merge_prev = true;
-		area = prev;
+					    vm_userfaultfd_ctx, anon_name);
 	}
+
 	/* Can we merge the successor? */
 	if (next && end == next->vm_start &&
-			mpol_equal(policy, vma_policy(next)) &&
-			can_vma_merge_before(next, vm_flags,
-					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx, anon_name)) {
-		merge_next = true;
+			mpol_equal(policy, vma_policy(next))) {
+		merge_next = can_vma_merge_before(next, vm_flags,
+					anon_vma, file, pgoff+pglen,
+					vm_userfaultfd_ctx, anon_name);
 	}
+
 	/* Can we merge both the predecessor and the successor? */
-	if (merge_prev && merge_next &&
-			is_mergeable_anon_vma(prev->anon_vma,
-				next->anon_vma, NULL)) {	 /* cases 1, 6 */
+	if (merge_prev >= MERGE_OK && merge_next >= MERGE_OK)
+		merge_both = is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL);
+
+	if (merge_both >= MERGE_OK) {	 /* cases 1, 6 */
 		err = __vma_adjust(prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
-	} else if (merge_prev) {			/* cases 2, 5, 7 */
+		area = prev;
+	} else if (merge_prev >= MERGE_OK) {			/* cases 2, 5, 7 */
 		err = __vma_adjust(prev, prev->vm_start,
 					end, prev->vm_pgoff, NULL, prev);
-	} else if (merge_next) {
+		area = prev;
+	} else if (merge_next >= MERGE_OK) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err = __vma_adjust(prev, prev->vm_start,
 					addr, prev->vm_pgoff, NULL, next);
@@ -1246,7 +1251,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		 */
 		area = next;
 	}
-
+	trace_vm_av_merge(err, merge_prev, merge_next, merge_both);
 	/*
 	 * Cannot merge with predecessor or successor or error in __vma_adjust?
 	 */
@@ -3321,6 +3326,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		/*
 		 * Source vma may have been merged into new_vma
 		 */
+		trace_vm_pgoff_merge(vma, anon_pgoff_updated);
+
 		if (unlikely(vma_start >= new_vma->vm_start &&
 			     vma_start < new_vma->vm_end)) {
 			/*
-- 
2.34.1

