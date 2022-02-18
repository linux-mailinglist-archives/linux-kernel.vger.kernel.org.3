Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F334BB907
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiBRMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:22:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiBRMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:21:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192519C1B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:21:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c6so12429728edk.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmEc5DoCLSD2DUJvNGydFX4svqDfjOrJL7x2lrpSPLk=;
        b=CcKCLBaPT80Z0Ha52pupsWCnMFYXy7bgQULIdXfwDMH9jGcQoTvbLhQ9wMsEkGrUgP
         y5KLlTAyZVa/I6W8kzmGg5ctllfTE795LOkwk/yBXxnqUVyaEbEwS0TyMmmmF/bApkW3
         JqfgOlbiYOuaouOsfd7tW1W4NndVQAwtd4xCYdp86nQ5J2uaX7Jh1226vYXxGmdRXCno
         SD/1NEm9WtU8Ex1H1w902lw0xa8IGuYrYaMM1hVIqutF7UM17ahpcD6BNJFHMqHf1x0z
         egOQh3b2d/znJRXCmaxrTdCwxJRY/z8W8f3FSvwpPrQuoQf57cpnENtcKT5nIkvJ6F21
         1xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmEc5DoCLSD2DUJvNGydFX4svqDfjOrJL7x2lrpSPLk=;
        b=jy7CY58gIJyFxtZbqh7nDPTBBLX50NN2+jn7XCKNz8/nhRypKRrbK9MaI4WHXyL8Tz
         u3VigwiXp/9rsCBCZbdSgNjxhM3ZGXYfMmybMeBVv/UOjNn4U5WvA9RsB50wEp5+kO+4
         4rZDJzx+noeiqeuiu9jr0Fi7n02hCeG6HITWM99QSo+H0in1WODTBSd1tmr5Fq4EUntv
         SDnvd5ME656diIhMOZNbnDBSKl/8eFtO+fAAJ6Ym/NTiEffTtM5I6E0At/hP+Tb3UKyC
         guzbBrzR2JvUGBbyasj6egvunfJ04TAdOjyD+F7SN82iekaaNjOUgpYskP6cQrNj6Mr+
         u66A==
X-Gm-Message-State: AOAM532hqcEpliLUrTYla8nvH5tRx7ljrzTr2WIegyqlmylnOgufVhDc
        JeTcYbx9Ij/BaGLwDkPn5Rs=
X-Google-Smtp-Source: ABdhPJwVNqS56OqHGXAdnjOIi2ZizE0j3EbD6E/PqQm5nKLAxCraATH7mQWAOpRduhttWtSq1TRS0g==
X-Received: by 2002:a50:9b12:0:b0:410:b926:d2d3 with SMTP id o18-20020a509b12000000b00410b926d2d3mr7850271edi.331.1645186897584;
        Fri, 18 Feb 2022 04:21:37 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id 1sm2270586ejm.173.2022.02.18.04.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:21:35 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 435F3A7FF0; Fri, 18 Feb 2022 13:20:44 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH 1/4] [PATCH 1/4] mm: refactor of vma_merge()
Date:   Fri, 18 Feb 2022 13:20:16 +0100
Message-Id: <20220218122019.130274-2-matenajakub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218122019.130274-1-matenajakub@gmail.com>
References: <20220218122019.130274-1-matenajakub@gmail.com>
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
suitable for tracing of successful merges made possible by following
patches in the series.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mmap.c | 81 +++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..b55e11f20571 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1172,6 +1172,9 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	struct vm_area_struct *area, *next;
 	int err;
+	int merge_prev = 0;
+	int merge_both = 0;
+	int merge_next = 0;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
@@ -1191,65 +1194,59 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	VM_WARN_ON(addr >= end);
 
 	/*
-	 * Can it merge with the predecessor?
+	 * Can we merge predecessor?
 	 */
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
 	/*
-	 * Can this new request be merged in front of next?
+	 * Can we merge successor?
 	 */
 	if (next && end == next->vm_start &&
 			mpol_equal(policy, vma_policy(next)) &&
 			can_vma_merge_before(next, vm_flags,
-					     anon_vma, file, pgoff+pglen,
-					     vm_userfaultfd_ctx, anon_name)) {
+					anon_vma, file, pgoff+pglen,
+					vm_userfaultfd_ctx, anon_name)) {
+		merge_next = true;
+	}
+	/*
+	 * Can we merge both predecessor and successor?
+	 */
+	if (merge_prev && merge_next)
+		merge_both = is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL);
+
+	if (merge_both) {	 /* cases 1, 6 */
+		err = __vma_adjust(prev, prev->vm_start,
+					next->vm_end, prev->vm_pgoff, NULL,
+					prev);
+		area = prev;
+	} else if (merge_prev) {			/* cases 2, 5, 7 */
+		err = __vma_adjust(prev, prev->vm_start,
+					end, prev->vm_pgoff, NULL, prev);
+		area = prev;
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
+		area = next;
+	} else {
+		err = -1;
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

