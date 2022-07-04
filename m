Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C0564B31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiGDBd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiGDBdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:33:51 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F2FF9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:33:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656898429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJVEgY4/4yJl1Y2+SArIxCvna3tlPP28HNqV598KtU4=;
        b=WBxTII6WEoRduxL3kOq3kc4q4wZin7G8GjrVCT1IptMO/2v36sWMM2DpdP6JyTgrfEseum
        7avwkUmKrY/FKt2jfn+EaVzA0KYbN4x549Tyhf5RQvQeeobTMbuthIHrFUSLKeLrk3UJEA
        bpDrbbZYN3TCLHHtHRGZl4L5trY5cVo=
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
Subject: [mm-unstable PATCH v4 6/9] mm, hwpoison: set PG_hwpoison for busy hugetlb pages
Date:   Mon,  4 Jul 2022 10:33:09 +0900
Message-Id: <20220704013312.2415700-7-naoya.horiguchi@linux.dev>
In-Reply-To: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

If memory_failure() fails to grab page refcount on a hugetlb page
because it's busy, it returns without setting PG_hwpoison on it.
This not only loses a chance of error containment, but breaks the rule
that action_result() should be called only when memory_failure() do
any of handling work (even if that's just setting PG_hwpoison).
This inconsistency could harm code maintainability.

So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.

Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h  | 1 +
 mm/memory-failure.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 433bde7dcbf2..22f2dfe41c99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3235,6 +3235,7 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
+	MF_NO_RETRY = 1 << 6,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6af2096d8ea0..4233b21328a5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1782,7 +1782,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 			count_increased = true;
 	} else {
 		ret = -EBUSY;
-		goto out;
+		if (!(flags & MF_NO_RETRY))
+			goto out;
 	}
 
 	if (hugetlb_set_page_hwpoison(head, page)) {
@@ -1810,7 +1811,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	struct page *p = pfn_to_page(pfn);
 	struct page *head;
 	unsigned long page_flags;
-	bool retry = true;
 
 	*hugetlb = 1;
 retry:
@@ -1826,8 +1826,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		}
 		return res;
 	} else if (res == -EBUSY) {
-		if (retry) {
-			retry = false;
+		if (!(flags & MF_NO_RETRY)) {
+			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-- 
2.25.1

