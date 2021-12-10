Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9398F46FF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhLJLGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:06:20 -0500
Received: from out0.migadu.com ([94.23.1.103]:59313 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234606AbhLJLGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:06:19 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639134163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=crOYlgjr6TJQi4fWo9njLpi/uZBGieqA7+/rnQHOBK8=;
        b=TlsQaoW0afvqpwqbG9OMB38r8CsUgGwszyRJfd2I0pZk+9qAaNVT/oiWmS0IoI3regwT1L
        gdSVcoPFOT1ldGVqlcettgUBRjqMQaTNq5Tp7OMsZgosc03owNZ4tsc6j1D1Bha9kZKHtP
        aGEns7ikvMpyTpUqlcWLMxH/Umwi1l0=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, luofei@unicloud.com,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, hwpoison: fix condition in free hugetlb page path
Date:   Fri, 10 Dec 2021 20:02:08 +0900
Message-Id: <20211210110208.879740-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

When a memory error hits a tail page of a free hugepage,
__page_handle_poison() is expected to be called to isolate the error in
4kB unit, but it's not called due to the outdated if-condition in
memory_failure_hugetlb().  This loses the chance to isolate the error in
the finer unit, so it's not optimal.  Drop the condition.

This "(p != head && TestSetPageHWPoison(head)" condition is based on the
old semantics of PageHWPoison on hugepage (where PG_hwpoison flag was
set on the subpage), so it's not necessray any more.  By getting to set
PG_hwpoison on head page for hugepages, concurrent error events on
different subpages in a single hugepage can be prevented by
TestSetPageHWPoison(head) at the beginning of memory_failure_hugetlb().
So dropping the condition should not reopen the race window originally
mentioned in commit b985194c8c0a ("hwpoison, hugetlb:
lock_page/unlock_page does not match for handling a free hugepage")

Reported-by: Fei Luo <luofei@unicloud.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org> # v5.14+
---
I set v5.14+ for stable trees because the base code was greatly changed
by commit 0ed950d1f281 ("mm,hwpoison: make get_hwpoison_page() call
get_any_page()"), and this patch is not cleanly applicable, although the
original issue was introduced more previously.
---
 mm/memory-failure.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8f0ee5b08696..68d9a35f8908 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1521,24 +1521,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (!(flags & MF_COUNT_INCREASED)) {
 		res = get_hwpoison_page(p, flags);
 		if (!res) {
-			/*
-			 * Check "filter hit" and "race with other subpage."
-			 */
 			lock_page(head);
-			if (PageHWPoison(head)) {
-				if ((hwpoison_filter(p) && TestClearPageHWPoison(p))
-				    || (p != head && TestSetPageHWPoison(head))) {
+			if (hwpoison_filter(p)) {
+				if (TestClearPageHWPoison(head))
 					num_poisoned_pages_dec();
-					unlock_page(head);
-					return 0;
-				}
+				unlock_page(head);
+				return 0;
 			}
 			unlock_page(head);
-			res = MF_FAILED;
-			if (__page_handle_poison(p)) {
-				page_ref_inc(p);
-				res = MF_RECOVERED;
-			}
+			res = MF_RECOVERED;
+			if (!page_handle_poison(p, true, false))
+				res = MF_FAILED;
 			action_result(pfn, MF_MSG_FREE_HUGE, res);
 			return res == MF_RECOVERED ? 0 : -EBUSY;
 		} else if (res < 0) {
-- 
2.25.1

