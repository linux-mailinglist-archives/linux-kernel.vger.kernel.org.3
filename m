Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6810253BB45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiFBO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiFBO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:56:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0A2ACB75
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:56:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so10476837ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHh+H7BQlsfCtAThje/xIUlqgtGS6GOCshB5FBGaRKo=;
        b=Xh4ANWAuyg1cGJ+Dc3w4iprlH+ngwcPVcnneCJIhSUiAvDORma8aDPn+jO+RerLhrD
         WQOw4rwXU3QNw1K8AKEt4d+PZA7qERjd99V7OhPKdQsNjMdr6fyz4mz88nOKJ4nMWW5r
         PfVMkS7Q2ZIiWJ1TcouljeNAz58TyHZZbg2zarFPk44XO9QCZWGU7wLrn7NhnSgjXDEm
         Ve4QHydnVC83yUg2pkJc6wmb+VdAkwcoyB9dzUGjFHICuB/OwFiFrb3dLd32vT97O6A0
         HTrTO22GsYmirQRf1EPplon/oZqfyKAVGMB3h4DzpjCe8jkTt8L/4w19GbLaM8/ndhPq
         a0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHh+H7BQlsfCtAThje/xIUlqgtGS6GOCshB5FBGaRKo=;
        b=TdPQ+vasd7yZH8NrCRL2Vno6x1LWZ4/hvgS6+RFvBKzcRY0Febfh6wxz1yNEwi6IUe
         OKxZNXCmU4RRzCwGinhioF103mVvmeldZLaN7UMKaH4u/AIznLZNBf9Y+mSPR68PfDmf
         iNQdWB5INx43v0acjRGSKAh9MuR+H3UFdIlSrlW+sCjWJK4IcASuHJTGhW29EEbV37SQ
         ZSgSUGEt6bwYcmTlFr9RrWQ2s/FkP82VQeV2xTZCSlsrqtvbTEILjWssAy7lwus23keE
         qUhJxXFSW3pHyKLX/MLve8n/6tIK0i3lkD42dNO1D7nE8IUHmQLMEivk8coOkZG3WQc7
         wJ+Q==
X-Gm-Message-State: AOAM5330u7hHtnH5SSNH5pJdOLxLSzau/Cg3Lwjt2v+Qs3P4pLswJ5+J
        UWsnEHzQR4ZmeU6MTN5wXk4=
X-Google-Smtp-Source: ABdhPJzFpDSOoca0Grhs4EW9ifXaEdKhAsPuLn92ZsZoqiBqc/ljbC4VpVXsTCJR4BkYygkcveUQcg==
X-Received: by 2002:a17:906:7254:b0:6fe:5637:cbe6 with SMTP id n20-20020a170906725400b006fe5637cbe6mr4645754ejk.612.1654181784247;
        Thu, 02 Jun 2022 07:56:24 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709064a8900b006f3ef214e2csm1873452eju.146.2022.06.02.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:56:23 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 2A742A0886; Thu,  2 Jun 2022 16:56:57 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH 1/2] [PATCH 1/2] mm: refactor of vma_merge()
Date:   Thu,  2 Jun 2022 16:56:41 +0200
Message-Id: <20220602145642.16948-2-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602145642.16948-1-matenajakub@gmail.com>
References: <20220602145642.16948-1-matenajakub@gmail.com>
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

Refactor vma_merge() to make it shorter and more understandable.
Main change is the elimination of code duplicity in the case of
merge next check. This is done by first doing checks and caching
the results before executing the merge itself. The variable 'area' is
divided into 'mid' and 'res' as previously it was used for two purposes,
as the middle VMA between prev and next and also as the result of the
merge itself. Exit paths are also unified.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mmap.c | 87 +++++++++++++++++++++++--------------------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 313b57d55a63..91100fdc400a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1170,8 +1170,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
-	struct vm_area_struct *area, *next;
-	int err;
+	struct vm_area_struct *mid, *next, *res;
+	int err = -1;
+	bool merge_prev = false;
+	bool merge_next = false;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
@@ -1181,75 +1183,60 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		return NULL;
 
 	next = vma_next(mm, prev);
-	area = next;
-	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
+	mid = next;
+	if (next && next->vm_end == end)		/* cases 6, 7, 8 */
 		next = next->vm_next;
 
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(area && end > area->vm_end);
+	VM_WARN_ON(mid && end > mid->vm_end);
 	VM_WARN_ON(addr >= end);
 
-	/*
-	 * Can it merge with the predecessor?
-	 */
+	/* Can we merge the predecessor? */
 	if (prev && prev->vm_end == addr &&
 			mpol_equal(vma_policy(prev), policy) &&
 			can_vma_merge_after(prev, vm_flags,
 					    anon_vma, file, pgoff,
 					    vm_userfaultfd_ctx, anon_name)) {
-		/*
-		 * OK, it can.  Can we now merge in the successor as well?
-		 */
-		if (next && end == next->vm_start &&
-				mpol_equal(policy, vma_policy(next)) &&
-				can_vma_merge_before(next, vm_flags,
-						     anon_vma, file,
-						     pgoff+pglen,
-						     vm_userfaultfd_ctx, anon_name) &&
-				is_mergeable_anon_vma(prev->anon_vma,
-						      next->anon_vma, NULL)) {
-							/* cases 1, 6 */
-			err = __vma_adjust(prev, prev->vm_start,
-					 next->vm_end, prev->vm_pgoff, NULL,
-					 prev);
-		} else					/* cases 2, 5, 7 */
-			err = __vma_adjust(prev, prev->vm_start,
-					 end, prev->vm_pgoff, NULL, prev);
-		if (err)
-			return NULL;
-		khugepaged_enter_vma_merge(prev, vm_flags);
-		return prev;
+		merge_prev = true;
 	}
-
-	/*
-	 * Can this new request be merged in front of next?
-	 */
+	/* Can we merge the successor? */
 	if (next && end == next->vm_start &&
 			mpol_equal(policy, vma_policy(next)) &&
 			can_vma_merge_before(next, vm_flags,
 					     anon_vma, file, pgoff+pglen,
 					     vm_userfaultfd_ctx, anon_name)) {
+		merge_next = true;
+	}
+	/* Can we merge both the predecessor and the successor? */
+	if (merge_prev && merge_next &&
+			is_mergeable_anon_vma(prev->anon_vma,
+				next->anon_vma, NULL)) {	 /* cases 1, 6 */
+		err = __vma_adjust(prev, prev->vm_start,
+					next->vm_end, prev->vm_pgoff, NULL,
+					prev);
+		res = prev;
+	} else if (merge_prev) {			/* cases 2, 5, 7 */
+		err = __vma_adjust(prev, prev->vm_start,
+					end, prev->vm_pgoff, NULL, prev);
+		res = prev;
+	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err = __vma_adjust(prev, prev->vm_start,
-					 addr, prev->vm_pgoff, NULL, next);
-		else {					/* cases 3, 8 */
-			err = __vma_adjust(area, addr, next->vm_end,
-					 next->vm_pgoff - pglen, NULL, next);
-			/*
-			 * In case 3 area is already equal to next and
-			 * this is a noop, but in case 8 "area" has
-			 * been removed and next was expanded over it.
-			 */
-			area = next;
-		}
-		if (err)
-			return NULL;
-		khugepaged_enter_vma_merge(area, vm_flags);
-		return area;
+					addr, prev->vm_pgoff, NULL, next);
+		else					/* cases 3, 8 */
+			err = __vma_adjust(mid, addr, next->vm_end,
+					next->vm_pgoff - pglen, NULL, next);
+		res = next;
 	}
 
-	return NULL;
+	/*
+	 * Cannot merge with predecessor or successor or error in __vma_adjust?
+	 */
+	if (err)
+		return NULL;
+	khugepaged_enter_vma_merge(res, vm_flags);
+	return res;
 }
 
 /*
-- 
2.35.1

