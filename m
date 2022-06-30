Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69015560F31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiF3C2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiF3C2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:28:16 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED0D5B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:28:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656556092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lD2AZO8ox5TTpHPepM0dCwWaQ9BZ891lb7mETr4gnI=;
        b=ghGF/odGZnpA1wVO6LTYB67lU0fj83SJj0Hcgvg9hCzjqf1jt5b4QzvW50nhEzNNnX8x0N
        w6PWytI7Zrs8obu0Js7WqF2Cpt7WQ5Y6boEsDpFbYgSLPUGa5gb58DUTtpLLZ2o2bv9wQw
        PBpXkK2HvoYlLCWUCnYuX+F4aP8Yv+Q=
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
Subject: [PATCH v3 1/9] mm/hugetlb: check gigantic_page_runtime_supported() in return_unused_surplus_pages()
Date:   Thu, 30 Jun 2022 11:27:47 +0900
Message-Id: <20220630022755.3362349-2-naoya.horiguchi@linux.dev>
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

I found a weird state of 1GB hugepage pool, caused by the following
procedure:

  - run a process reserving all free 1GB hugepages,
  - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
    /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
  - kill the reserving process.

, then all the hugepages are free *and* surplus at the same time.

  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  3
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
  3
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
  0
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
  3

This state is resolved by reserving and allocating the pages then
freeing them again, so this seems not to result in serious problem.
But it's a little surprising (shrinking pool suddenly fails).

This behavior is caused by hstate_is_gigantic() check in
return_unused_surplus_pages(). This was introduced so long ago in 2008
by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
at that time the gigantic pages were not supposed to be allocated/freed
at run-time.  Now kernel can support runtime allocation/free, so let's
check gigantic_page_runtime_supported() together.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
v2 -> v3:
- Fixed typo in patch description,
- add !gigantic_page_runtime_supported() check instead of removing
  hstate_is_gigantic() check (suggested by Miaohe and Muchun)
- add a few more !gigantic_page_runtime_supported() check in
  set_max_huge_pages() (by Mike).
---
 mm/hugetlb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a57e1be41401..e67540dbbf88 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2432,8 +2432,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	/* Cannot return gigantic pages currently */
-	if (hstate_is_gigantic(h))
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		goto out;
 
 	/*
@@ -3318,7 +3317,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * the user tries to allocate gigantic pages but let the user free the
 	 * boottime allocated gigantic pages.
 	 */
-	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
+	if (hstate_is_gigantic(h) && (!IS_ENABLED(CONFIG_CONTIG_ALLOC) ||
+				      !gigantic_page_runtime_supported())) {
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
@@ -3366,6 +3366,19 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			goto out;
 	}
 
+	/*
+	 * We can not decrease gigantic pool size if runtime modification
+	 * is not supported.
+	 */
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported()) {
+		if (count < persistent_huge_pages(h)) {
+			spin_unlock_irq(&hugetlb_lock);
+			mutex_unlock(&h->resize_lock);
+			NODEMASK_FREE(node_alloc_noretry);
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Decrease the pool size
 	 * First return free pages to the buddy allocator (being careful
-- 
2.25.1

