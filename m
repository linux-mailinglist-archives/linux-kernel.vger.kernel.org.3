Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884C348D9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiAMOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiAMOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:39:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2833DC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0SdL7L2aAS0NahjbAspySorF63SX/dfOiFW0ONSeOV8=; b=pWz9PYP3Z6ZR8z8GSM3iX2LNuI
        PEOkkCU5mJnCNptQuWhIkBumyhg5NvkAo+FROnfbHc5hlxghXPVZ/k/MtisI/W1/4qQBs+tv13FB5
        tlXCNQ8MbXC5XxkK5R249n9uMXKPx62EPpJq+hxc6QSyLZc09lNnZ7w2tImmQfL5xL9wpWwLX1Whw
        ZSkA3BUwesAhgxf0H2AAOizB2RUgs4d8l2BgJzxvzTlAFB4AKPSVl1KXnYtQYy4AWcB3w91fYLI5b
        s5XEsOZtyFA1Q1ehiTXJxLwMP5BY1mLWwiqr0NAKtyFwxbjvIKQ0yya2VhrGxDvO0IMyx/pWuGtdO
        TuZ03l6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n81GC-004zsl-Va; Thu, 13 Jan 2022 14:39:29 +0000
Date:   Thu, 13 Jan 2022 14:39:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Liang Zhang <zhangliang5@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <YeA5oP/iaxtVPHb3@casper.infradead.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113140318.11117-1-zhangliang5@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:03:18PM +0800, Liang Zhang wrote:
> In current implementation, process's read requestions will fault in pages
> with WP flags in PTEs. Next, if process emit a write requestion will go
> into do_wp_page() and copy data to a new allocated page from the old one
> due to refcount > 1 (page table mapped and swapcache), which could be
> result in performance degradation. In fact, this page is exclusively owned
> by this process and the duplication from old to a new allocated page is
> really unnecessary.
> 
> So In this situation, these unshared pages can be reused by its process.

Let's bring Linus in on this, but I think this reintroduces all of the
mapcount problems that we've been discussing recently.

How about this as an alternative?

+++ b/mm/memory.c
@@ -3291,11 +3291,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
                struct page *page = vmf->page;

                /* PageKsm() doesn't necessarily raise the page refcount */
-               if (PageKsm(page) || page_count(page) != 1)
+               if (PageKsm(page) || page_count(page) != 1 + PageSwapCache(page))
                        goto copy;
                if (!trylock_page(page))
                        goto copy;
-               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1 + PageSwapCache(page)) {
                        unlock_page(page);
                        goto copy;
                }


> Signed-off-by: Liang Zhang <zhangliang5@huawei.com>
> ---
> This patch has been tested with redis benchmark. Here is the test
> result.
> 
> Hardware
> ========
> Memory (GB): 512G
> CPU (total #): 88
> NVMe SSD (GB): 1024
> 
> OS
> ==
> kernel 5.10.0
> 
> Testcase
> ========
> step 1:
>   Run 16 VMs (4U8G), each running with redis-server, in a cgroup 
>   limiting memory.limit_in_bytes to 100G. 
> step 2:
>   Run memtier_bemchmark in host with params "--threads=1 --clients=1 \
> --pipeline=256 --data-size=2048 --requests=allkeys --key-minimum=1 \
> --key-maximum=30000000 --key-prefix=memtier-benchmark-prefix-redistests"
>   to test every VM concurrently.
> 
> Workset size
> ============
> cat memory.memsw.usage_in_bytes
> 125403303936
> 
> Result
> ======
> Comparing with Baseline, this patch can achieved 41% more Ops/sec, 
> 41% more Hits/sec, 41% more Misses/sec, 30% less Latency and 
> 41% more KB/sec. 
> 
>   Index(average)        Baseline kernel        Patched kernel
>   Ops/sec               109497                 155428
>   Hits/sec              8653                   12283
>   Misses/sec            90889                  129014
>   Latency               2.297                  1.603
>   KB/sec                44569                  63186
> 
> 
>  mm/memory.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 23f2f1300d42..fd4d868b1c2d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3291,10 +3291,16 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		struct page *page = vmf->page;
>  
>  		/* PageKsm() doesn't necessarily raise the page refcount */
> -		if (PageKsm(page) || page_count(page) != 1)
> +		if (PageKsm(page))
>  			goto copy;
>  		if (!trylock_page(page))
>  			goto copy;
> +
> +		/* reuse the unshared swapcache page */
> +		if (PageSwapCache(page) && reuse_swap_page(page, NULL)) {
> +			goto reuse;
> +		}
> +
>  		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
>  			unlock_page(page);
>  			goto copy;
> @@ -3304,6 +3310,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 * page count reference, and the page is locked,
>  		 * it's dark out, and we're wearing sunglasses. Hit it.
>  		 */
> +reuse:
>  		unlock_page(page);
>  		wp_page_reuse(vmf);
>  		return VM_FAULT_WRITE;
> -- 
> 2.30.0
> 
> 
