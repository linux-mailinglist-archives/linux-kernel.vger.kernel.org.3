Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3204D67F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbiCKRrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiCKRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:47:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB1133955
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qt6so20619848ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09Pa4q2b4vX67JHZNNkgoh3+KCy7fCLjcgKDWwRT+M0=;
        b=DLAOcfyY4RSMcyqKyRAYZJw4xE61oYMJpgI+6BgAA5I8tDn6gOw/xkp0RylEQ+BNG+
         X39US6T7op8ybAYMVIohzhKnlFqbUyGI1nmeDVMJu4r0EFookP8UKAVCn0b9I0S4r9EG
         zRr2tJSNzseIfWg5zifBxJn5RpDYyC6hTMj1hhMmGpTKHVIS5wJ6w834mHZiFJgkcJED
         zLZiHIeQa0DH1RPSwXLHUOxDA+GJzV6U8W0o4sDbKCiRwu/qAd9UKUu8cIULaI1Hjfp9
         o9zV7HGVWbHNVSdUBl4Wu+d+et3xkhKh96P8usb+0UMW6piuQlF2y+YZWK1gs2rGV1Dw
         CVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09Pa4q2b4vX67JHZNNkgoh3+KCy7fCLjcgKDWwRT+M0=;
        b=ZhiyCqQax/lKK1qdCYjb83iJvve79GA9BCUgyAxXFX89qM43Rfw6CJHMgLLaHjW6IL
         cpjJ856mqibazi7lSVz7EmiJE/J8nvywtwveFctnh9ams0OQtXwb42s6NwtXNbOW467Q
         c3t1vg26HolKFgTZ6+CQJkbBzxsRHCl+xVuZoLVMYwPGeUKn6ST9P402unCpLGsBaZ5P
         ZqF3zSjtPDwTZ//hcwWEFAlNzJWE8cMHBUnFPnzudipHpkGaHyq3Se6luSmqfJ3bHsOR
         BWqSQ56EQ9ypzFWJGmb1KJAo595AMr/focNDfwXBc5E6RLs1IKtllw8u84fhAYkJv8PJ
         KFPw==
X-Gm-Message-State: AOAM531alcf+AlEagu1Z1umnJKp3x0mA4zfSBPs7Ilg434rLJUscrOwP
        iot0be3VMypTDaCS+Mu2wkw=
X-Google-Smtp-Source: ABdhPJyHfDu2o5XZ2wRtC0e82YeqMCLO+OmeSyH71sQYMclcdq3RHn7j70Faw1aLHMPlviZ/+d4w2w==
X-Received: by 2002:a17:906:9b95:b0:6db:38fc:5ff4 with SMTP id dd21-20020a1709069b9500b006db38fc5ff4mr9143643ejc.114.1647020762408;
        Fri, 11 Mar 2022 09:46:02 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id i21-20020a1709061cd500b006da62ab503csm3159886ejh.157.2022.03.11.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:46:01 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 814DCA00A8; Fri, 11 Mar 2022 18:46:03 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v2 1/4] [PATCH 1/4] mm: refactor of vma_merge()
Date:   Fri, 11 Mar 2022 18:45:59 +0100
Message-Id: <20220311174602.288010-2-matenajakub@gmail.com>
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

Refactor vma_merge() to make it shorter, more understandable and
suitable for tracing of successful merges that are made possible by
following patches in the series. Main change is the elimination of code
duplicity in the case of merge next check. This is done by first doing
checks and caching the results before executing the merge itself. Exit
paths are also unified.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mmap.c | 81 +++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..8d817b11c656 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1171,7 +1171,9 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
-	int err;
+	int err = -1;
+	bool merge_prev = false;
+	bool merge_next = false;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
@@ -1190,66 +1192,55 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	VM_WARN_ON(area && end > area->vm_end);
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
+		area = prev;
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
+	} else if (merge_prev) {			/* cases 2, 5, 7 */
+		err = __vma_adjust(prev, prev->vm_start,
+					end, prev->vm_pgoff, NULL, prev);
+	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err = __vma_adjust(prev, prev->vm_start,
-					 addr, prev->vm_pgoff, NULL, next);
-		else {					/* cases 3, 8 */
+					addr, prev->vm_pgoff, NULL, next);
+		else					/* cases 3, 8 */
 			err = __vma_adjust(area, addr, next->vm_end,
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
+					next->vm_pgoff - pglen, NULL, next);
+		/*
+		 * In case 3 and 4 area is already equal to next and
+		 * this is a noop, but in case 8 "area" has
+		 * been removed and next was expanded over it.
+		 */
+		area = next;
 	}
 
-	return NULL;
+	/*
+	 * Cannot merge with predecessor or successor or error in __vma_adjust?
+	 */
+	if (err)
+		return NULL;
+	khugepaged_enter_vma_merge(area, vm_flags);
+	return area;
 }
 
 /*
-- 
2.34.1

