Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5791847519E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhLOETJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhLOETI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:19:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 20:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0b1q8LH8HNfIeoCv8LnUjTKY84gOKuNMMSC+sT9rUTg=; b=cQk2DYMJXuu0MBuDrPtlgE1CRX
        xY+UUh6YCq8HVHXh+hxpzd73ce9aIW/O0olGP28ELG13T1psHPUDwZHA+2IUe5C7AGKE7BFpQgWVn
        fXRMYCslEiYjDEI+DOJNtlwG4mQ03kJ9U/tS/PvYvlGfPnST5MPZ9sQiApZFQPcEVT6Uut5PW/rmk
        pXDS/x0wFbuEtFm8PXj3gg7rDlHnUCg4Yrdx0/N1BEQSSz7y55cNfFSOUV8mmPUaOnvrP9fRI2jvh
        zImaYdysxdVWvxQDEWkcOxovm+1AIsHCll4vvFjEPV837ptJtA+62u0Nho2jJDQ8xT4ZJZWqRY7RU
        9RSM9YFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxLkt-00EKiH-EC; Wed, 15 Dec 2021 04:19:03 +0000
Date:   Wed, 15 Dec 2021 04:19:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+c915885f05d8e432e7b4@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in split_huge_page_to_list
Message-ID: <Yblst9nyDSH2RQWQ@casper.infradead.org>
References: <00000000000091a18b05d324df40@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000091a18b05d324df40@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 05:03:26PM -0800, syzbot wrote:
> commit 3ebffc96befbaf9de9297b00d67091bb702fad8e
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Sun Jun 28 02:19:08 2020 +0000
> 
>     mm: Use multi-index entries in the page cache
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1276e4bab00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1176e4bab00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1676e4bab00000

Well, this is all entirely plausible:

+               xas_split_alloc(&xas, head, compound_order(head),
+                               mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK);

It looks like I can fix this by moving the memory allocation before
the acquisition of the i_mmap_lock.  Any objections to this:

+++ b/mm/huge_memory.c
@@ -2653,6 +2653,13 @@ int split_huge_page_to_list(struct page *page, struct lis
t_head *list)
                        goto out;
                }

+               xas_split_alloc(&xas, head, compound_order(head),
+                               mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK);
+               if (xas_error(&xas)) {
+                       ret = xas_error(&xas);
+                       goto out;
+               }
+
                anon_vma = NULL;
                i_mmap_lock_read(mapping);

@@ -2679,15 +2686,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)

        unmap_page(head);

-       if (mapping) {
-               xas_split_alloc(&xas, head, compound_order(head),
-                               mapping_gfp_mask(mapping) & GFP_RECLAIM_MASK);
-               if (xas_error(&xas)) {
-                       ret = xas_error(&xas);
-                       goto out_unlock;
-               }
-       }
-
        /* block interrupt reentry in xa_lock and spinlock */
        local_irq_disable();
        if (mapping) {

(relative to the above patch)

