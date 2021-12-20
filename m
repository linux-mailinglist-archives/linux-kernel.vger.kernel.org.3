Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEE47A639
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhLTItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbhLTItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:49:01 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 00:49:01 -0800 (PST)
Date:   Mon, 20 Dec 2021 17:48:51 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639990139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7ymSe3JNfGnfp68YJJDL+vOmYRtr+smRMVOZWaLcTE=;
        b=c9uD0xpYsmmXMR1fvEILCUGXsbc00cyAskBGoAfziYV4uuq12OqqNpheCyNK3/mlODYtu2
        06vAcNneyR6VG1D9kq1jkzrFehbebz3B9tWGjsvIPCRTdj64LXuMCwPSewA7NziOCv5S37
        n67BUOMORZtiv5mprc0ILSzCwzTovPM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, luofei@unicloud.com,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hwpoison: fix condition in free hugetlb page path
Message-ID: <20211220084851.GA1460264@u2004>
References: <20211210110208.879740-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210110208.879740-1-naoya.horiguchi@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 08:02:08PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When a memory error hits a tail page of a free hugepage,
> __page_handle_poison() is expected to be called to isolate the error in
> 4kB unit, but it's not called due to the outdated if-condition in
> memory_failure_hugetlb().  This loses the chance to isolate the error in
> the finer unit, so it's not optimal.  Drop the condition.
> 
> This "(p != head && TestSetPageHWPoison(head)" condition is based on the
> old semantics of PageHWPoison on hugepage (where PG_hwpoison flag was
> set on the subpage), so it's not necessray any more.  By getting to set
> PG_hwpoison on head page for hugepages, concurrent error events on
> different subpages in a single hugepage can be prevented by
> TestSetPageHWPoison(head) at the beginning of memory_failure_hugetlb().
> So dropping the condition should not reopen the race window originally
> mentioned in commit b985194c8c0a ("hwpoison, hugetlb:
> lock_page/unlock_page does not match for handling a free hugepage")
> 
> Reported-by: Fei Luo <luofei@unicloud.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: <stable@vger.kernel.org> # v5.14+
> ---
> I set v5.14+ for stable trees because the base code was greatly changed
> by commit 0ed950d1f281 ("mm,hwpoison: make get_hwpoison_page() call
> get_any_page()"), and this patch is not cleanly applicable, although the
> original issue was introduced more previously.
> ---
>  mm/memory-failure.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 8f0ee5b08696..68d9a35f8908 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1521,24 +1521,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	if (!(flags & MF_COUNT_INCREASED)) {
>  		res = get_hwpoison_page(p, flags);
>  		if (!res) {
> -			/*
> -			 * Check "filter hit" and "race with other subpage."
> -			 */
>  			lock_page(head);
> -			if (PageHWPoison(head)) {
> -				if ((hwpoison_filter(p) && TestClearPageHWPoison(p))
> -				    || (p != head && TestSetPageHWPoison(head))) {
> +			if (hwpoison_filter(p)) {
> +				if (TestClearPageHWPoison(head))
>  					num_poisoned_pages_dec();
> -					unlock_page(head);
> -					return 0;
> -				}
> +				unlock_page(head);
> +				return 0;
>  			}
>  			unlock_page(head);
> -			res = MF_FAILED;
> -			if (__page_handle_poison(p)) {
> -				page_ref_inc(p);
> -				res = MF_RECOVERED;
> -			}
> +			res = MF_RECOVERED;
> +			if (!page_handle_poison(p, true, false))
> +				res = MF_FAILED;

Sorry, I just found that this change broke "HardwareCorrupted" counter
because page_handle_poison() calls num_poisoned_pages_inc() so the counter
was incremented twice in total by a single error event.  page_handle_poison()
is supposed to be called only in soft-offline context, and __page_handle_poison()
should be called in hard-offline context.

Andrew, could you fold the following diff on
mm-hwpoison-fix-condition-in-free-hugetlb-page-path.patch in your tree?
(Or if desirable, I'll send a updated full patch.)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 68d9a35f8908..ee51d6410f9a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1529,9 +1529,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 				return 0;
 			}
 			unlock_page(head);
-			res = MF_RECOVERED;
-			if (!page_handle_poison(p, true, false))
-				res = MF_FAILED;
+			res = MF_FAILED;
+			if (__page_handle_poison(p)) {
+				page_ref_inc(p);
+				res = MF_RECOVERED;
+			}
 			action_result(pfn, MF_MSG_FREE_HUGE, res);
 			return res == MF_RECOVERED ? 0 : -EBUSY;
 		} else if (res < 0) {


Thanks,
Naoya Horiguchi
