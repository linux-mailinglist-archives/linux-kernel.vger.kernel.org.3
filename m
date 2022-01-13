Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C217448DF62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiAMVHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAMVH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:07:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D173C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/0L41nuHVCYCitqm3wG9uWMDKdWeGmtc8DsG8OaX/x8=; b=akSrEgWILuGq7fiIGePjdr3c9F
        bYBxshnHtIlBb3VRBSnAynCxcj48WRbd7kBKUCluAU74Ld9LJ5W159IOT1dXBL0K6A/FCF094U3FT
        RuZ7vN/bUsHzKZLpm2i8q0Pj3uYUADShZYdRnuRODPWQwqUfZ6WdjsOfhAuMYHa2MG6Kr2rCV1JuU
        1Of6ch1emlOkkHTVppgJZPfTnXA71IEbIwvQybJsUC7AvsgRQ6UNCS5oivkWHJCOVatwQymHb29xl
        kBSIFBX/V+6RRRlhatERu7Cz7wYJnRrlHvDTe7dA3n0y7YHs14b4dKkC24L3I3FuLg3aU0HgNuh+c
        jWYPzKTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n87JY-005Ey7-9J; Thu, 13 Jan 2022 21:07:20 +0000
Date:   Thu, 13 Jan 2022 21:07:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <YeCUiO7RBqo/VTMh@casper.infradead.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
 <c3f34084-7315-e0c5-55db-d1cb006979f4@redhat.com>
 <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 09:44:04AM -0800, Linus Torvalds wrote:
> IOW, the COW path would do
> 
>  trylock - copy if fails
>  try to remove from swap cache
>  if page_count() is now 1, we can reuse it
> 
> Note how the "try to remove from swap cache" is entirely independent
> of whether we then reuse it or not.
> 
> And yes, we can have optimistic other tests - like not even bothering
> to trylock if we can see that the page-count is so elevated that it
> makes no difference and trying to remove from swap cache would be just
> pointless extra work (both the removal itself, and then potentially
> later re-additions).
> 
> But those should be seen for what they are - not important for
> semantics, only a "don't bother, this page has so many users that we
> already know that removing the swapcache one doesn't make any
> difference at all".

I think what you mean is something like ...

+++ b/mm/memory.c
@@ -3290,15 +3290,13 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
        if (PageAnon(vmf->page)) {
                struct page *page = vmf->page;
 
-               /* PageKsm() doesn't necessarily raise the page refcount */
-               if (PageKsm(page) || page_count(page) != 1)
+               /* Lots of people are using this page, just copy */
+               if (page_count(page) > 5)
                        goto copy;
                if (!trylock_page(page))
                        goto copy;
-               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
-                       unlock_page(page);
-                       goto copy;
-               }
+               if (!reuse_swap_page(page, NULL))
+                       goto unlock;
                /*
                 * Ok, we've got the only map reference, and the only
                 * page count reference, and the page is locked,
@@ -3311,6 +3309,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
                                        (VM_WRITE|VM_SHARED))) {
                return wp_page_shared(vmf);
        }
+unlock:
+       unlock_page(page);
 copy:
        /*
         * Ok, we need to copy. Oh, well..

... with a suitably sensible reuse_swap_page().
