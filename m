Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AA53B2DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiFBFHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiFBFHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:07:25 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE76626AF3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:07:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654146436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69HjEHnWoOWXnEg6MdqERUrKKt+r81ak43WL3MVYDqU=;
        b=ErJcBXqaS4mYysb0lBd2slIeeDZ8PVHR7I2q+OH+OvDRMLQeObJt4/4r0pa3e72Ap9vVnO
        R3S3+dXl1od9asrjUxRYuDT7qu+vW4n+yrL//rV2wX3d19ICdeDQd4hAabQZrK9uPAlqbN
        X0Dm0eqHEs8sq5hDG+6WGsA6OpiyKOQ=
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
Subject: [PATCH v1 4/5] mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
Date:   Thu,  2 Jun 2022 14:06:30 +0900
Message-Id: <20220602050631.771414-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently if memory_failure() (modified to remove blocking code) is called
on a page in some 1GB hugepage, memory error handling returns failure and
the raw error page gets into undesirable state.  The impact is small in
production systems (just leaked single 4kB page), but this limits the test
efficiency because unpoison doesn't work for it.  So we can no longer
create 1GB hugepage on the 1GB physical address range with such hwpoison
pages, that could be an issue in testing on small systems.

When a hwpoison page in a 1GB hugepage is handled, it's caught by the
PageHWPoison check in free_pages_prepare() because the hugepage is broken
down into raw error page and order is 0:

        if (unlikely(PageHWPoison(page)) && !order) {
                ...
                return false;
        }

Then, the page is not sent to buddy and the page refcount is left 0.

Originally this check is supposed to work when the error page is freed from
page_handle_poison() (that is called from soft-offline), but now we are
opening another path to call it, so the callers of __page_handle_poison()
need to handle the case by considering the return value 0 as success. Then
page refcount for hwpoison is properly incremented and now unpoison works.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f149a7864c81..babeb34f7477 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1043,7 +1043,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
 		unlock_page(hpage);
 	} else {
-		res = MF_FAILED;
 		unlock_page(hpage);
 		/*
 		 * migration entry prevents later access on error anonymous
@@ -1051,9 +1050,11 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * save healthy subpages.
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
 
@@ -1601,9 +1602,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		unlock_page(head);
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

