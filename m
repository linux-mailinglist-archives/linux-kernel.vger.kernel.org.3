Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8C560F30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiF3C26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiF3C2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:28:43 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619A27B3C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:28:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656556120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mMm895HUGvB33w+4B1AJ2mtagQIDtCZZ7dWMv/EeV8=;
        b=pxOQzK9c3614wZpIA9bTTIlOONEBtlmPH5jhzWmnJd1T0tQkE3B3zB0yTclKMyK9dLA+v/
        bwLME081ejMd5Xc+Kys/lGZvLXfzPMxebjdTvUXtI+e0XK6dls/CrW3YkoOdG1HtAUEqC5
        yOfSTu9FiikLkQrq1tWumgXTkTDSdP4=
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
Subject: [PATCH v3 8/9] mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
Date:   Thu, 30 Jun 2022 11:27:54 +0900
Message-Id: <20220630022755.3362349-9-naoya.horiguchi@linux.dev>
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

Currently if memory_failure() (modified to remove blocking code with
subsequent patch) is called on a page in some 1GB hugepage, memory error
handling fails and the raw error page gets into leaked state.  The impact
is small in production systems (just leaked single 4kB page), but this
limits the testability because unpoison doesn't work for it.
We can no longer create 1GB hugepage on the 1GB physical address range
with such leaked pages, that's not useful when testing on small systems.

When a hwpoison page in a 1GB hugepage is handled, it's caught by the
PageHWPoison check in free_pages_prepare() because the 1GB hugepage is
broken down into raw error pages before coming to this point:

        if (unlikely(PageHWPoison(page)) && !order) {
                ...
                return false;
        }

Then, the page is not sent to buddy and the page refcount is left 0.

Originally this check is supposed to work when the error page is freed from
page_handle_poison() (that is called from soft-offline), but now we are
opening another path to call it, so the callers of __page_handle_poison()
need to handle the case by considering the return value 0 as success. Then
page refcount for hwpoison is properly incremented so unpoison works.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2 -> v3:
- remove "res = MF_FAILED" in try_memory_failure_hugetlb (by Miaohe)
---
 mm/memory-failure.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6c7b9129eade..6a9b11807ee6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1046,7 +1046,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
 		unlock_page(hpage);
 	} else {
-		res = MF_FAILED;
 		unlock_page(hpage);
 		/*
 		 * migration entry prevents later access on error hugepage,
@@ -1054,9 +1053,11 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * subpages.
 		 */
 		put_page(hpage);
-		if (__page_handle_poison(p) > 0) {
+		if (__page_handle_poison(p) >= 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
+		} else {
+			res = MF_FAILED;
 		}
 	}
 
@@ -1689,10 +1690,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		unlock_page(head);
-		res = MF_FAILED;
-		if (__page_handle_poison(p) > 0) {
+		if (__page_handle_poison(p) >= 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
+		} else {
+			res = MF_FAILED;
 		}
 		action_result(pfn, MF_MSG_FREE_HUGE, res);
 		return res == MF_RECOVERED ? 0 : -EBUSY;
-- 
2.25.1

