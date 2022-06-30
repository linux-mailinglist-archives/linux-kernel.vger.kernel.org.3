Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4BF560F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiF3C3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiF3C2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:28:50 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F2120B7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:28:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656556124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQp82hDOk82vRv92dNThK5SQ8yKvxwYYoFoVJwwIfdQ=;
        b=SQSSYIl1u2E0NKLfQjCeFwPw4LflsTKAjwE0RiatjPRLkLJA7dqf2Y+NjoBilHeFrUf7cS
        hGJYAqx3bYUs3bCHvOgg+hIuz5SNUljq5isddMb+JEvFITT+WC7pv7O+udHCCfjGP/mRV0
        +D9G7Jg2/69W1MTxSlscl+537HgFeU0=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] mm, hwpoison: enable memory error handling on 1GB hugepage
Date:   Thu, 30 Jun 2022 11:27:55 +0900
Message-Id: <20220630022755.3362349-10-naoya.horiguchi@linux.dev>
In-Reply-To: <20220630022755.3362349-1-naoya.horiguchi@linux.dev>
References: <20220630022755.3362349-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now error handling code is prepared, so remove the blocking code and
enable memory error handling on 1GB hugepage.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h      |  1 -
 include/ras/ras_event.h |  1 -
 mm/memory-failure.c     | 16 ----------------
 3 files changed, 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 044dc5a2e361..9d7e9b5a4d1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3284,7 +3284,6 @@ enum mf_action_page_type {
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
-	MF_MSG_NON_PMD_HUGE,
 	MF_MSG_UNMAP_FAILED,
 	MF_MSG_DIRTY_SWAPCACHE,
 	MF_MSG_CLEAN_SWAPCACHE,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index d0337a41141c..cbd3ddd7c33d 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -360,7 +360,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
-	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6a9b11807ee6..6ee5cbe0cbab 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -728,7 +728,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
-	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
 	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
 	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
@@ -1702,21 +1701,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	page_flags = head->flags;
 
-	/*
-	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
-	 * simply disable it. In order to make it work properly, we need
-	 * make sure that:
-	 *  - conversion of a pud that maps an error hugetlb into hwpoison
-	 *    entry properly works, and
-	 *  - other mm code walking over page table is aware of pud-aligned
-	 *    hwpoison entries.
-	 */
-	if (huge_page_size(page_hstate(head)) > PMD_SIZE) {
-		action_result(pfn, MF_MSG_NON_PMD_HUGE, MF_IGNORED);
-		res = -EBUSY;
-		goto out;
-	}
-
 	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
-- 
2.25.1

