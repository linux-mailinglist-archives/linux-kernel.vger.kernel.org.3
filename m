Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41293535EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351042AbiE0KsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbiE0Krx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:47:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12F2AE5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:47:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi33so8014455ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ru3bkI46cGQXTo5hSsyPFl2jKgUjs/czASVw2IToYVQ=;
        b=RMTaAYIppb0iNIn8vopS7Cr2YesNwAFvN/zYLCGwwZnvleh4l/JCv/+kYqZdwKcee7
         Lg8Y0lEiEHp3O09jIAvbsiGMCAk2PZLifDV+rHZwg6OjCTYBay55PolLGo88EDQKUQzp
         jHq+2oUZSI1bUZ9KYQWpjHoUG20T4W5PoDpyuhrIENGOFMEnWt2f1XGgYwRPVuXE9HRw
         VwED6xqVVAjjq118lr/sHCgSJY/yf7BWOQ6oUFwAsWilhCkmpdXWa5oj5o/UHkBlMxJx
         eWECxyCBfNP6rjELVFh8yNPx8Qzp04sdzNjrCKbIKzs4icqcY93H62xhW7qn7pXWOHQ/
         lZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ru3bkI46cGQXTo5hSsyPFl2jKgUjs/czASVw2IToYVQ=;
        b=adwfcJUKzBaiq2ZsuxCbNYnw0GuqE3jEBrqbvt2k+yW2F9K1+xXLAA8WSDJU0FRuuK
         fiN4KtALLH6CqBIxL+JO998e3bxwQJ+pNP5fNTIv6v3yM7/0Rvkc7NZi7f85IX8hoU2g
         mV91bplq6TVv6FwcCA81wU5vkFJppu5C91PgX0Omr3hAYZsiX+l0ewbWyHfd9LooErBg
         kVI3PorIdSkSGmFDcWSa1ptawQXdW4ZoBGZqXejEM1HoqqIchYJIvDgKmCYejqg3LXIN
         HIC9j2txp194cpHhZPiNYcsmR6WOrztbEQyD0Ii/snvdcv3OD91ekNwj08pDPYpEtCfe
         xJWQ==
X-Gm-Message-State: AOAM530fbGW8AmkPAM5o0Wr54eXSWXxhqtuQ0Vvxu0d/dtezJPcWkvyG
        zC9sMzHynFJcwCpe2/ybuto=
X-Google-Smtp-Source: ABdhPJwAjCaIQcHY9NNC4R29tI2fkFnzMUb9DOAXPD6YcxngDNqPknClEYm3JJz3kuq3hLflhiqVCg==
X-Received: by 2002:a17:907:868e:b0:6ff:39e0:2653 with SMTP id qa14-20020a170907868e00b006ff39e02653mr1898679ejc.734.1653648471075;
        Fri, 27 May 2022 03:47:51 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id pg5-20020a170907204500b006f3ef214e6asm1321234ejb.208.2022.05.27.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:47:49 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 4DC43A028E; Fri, 27 May 2022 12:48:18 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH 1/2] [PATCH 1/2] mm: refactor of vma_merge()
Date:   Fri, 27 May 2022 12:48:09 +0200
Message-Id: <20220527104810.24736-2-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527104810.24736-1-matenajakub@gmail.com>
References: <20220527104810.24736-1-matenajakub@gmail.com>
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
index 3aa839f81e63..bd0dde2ad3e2 100644
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

