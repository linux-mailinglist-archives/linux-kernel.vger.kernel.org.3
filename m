Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5271B49518F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376718AbiATPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbiATPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:37:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17135C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SU7pSbDiQ/H6zVLiOL36DNrrKEIKg1kB7apuo0AXxvE=; b=jawJn9LY5JlIVJ9d092vGriYv1
        yOO0ukaUjEiKupPaLTChb45dzdhS1u8sBeDaz4xjuuUu67w1k34w8/q7OMT7BPiv301o/elB0pi0B
        LHnSGOHBonBm/tSZS6AN8Zaeo5JJK47awfBd/BE63dOF1f6fY7aROwIahbftXOMewSetA+UVN9Brv
        XR40Q/pAcUpOBklqOjFBQjPjqmlmTp1qWfTXQNRYZKTnWDYadzo+DTKU3390gNhmS8+2Rb0dicoiD
        WcgZJulDFVCB/jio9ET/rMe061WlCzzv/nHngjWNCJDnkErbv5/8MnJiH7K6hBUZCRVISoU9SRUU1
        bJcgDvng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZUd-00ENXg-EK; Thu, 20 Jan 2022 15:36:55 +0000
Date:   Thu, 20 Jan 2022 15:36:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <YemBl4ZVtJqtAVwV@casper.infradead.org>
References: <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:26:22PM +0100, David Hildenbrand wrote:
> On 20.01.22 15:39, Matthew Wilcox wrote:
> > On Thu, Jan 20, 2022 at 03:15:37PM +0100, David Hildenbrand wrote:
> >> On 17.01.22 14:31, zhangliang (AG) wrote:
> >>> Sure, I will do that :)
> >>
> >> I'm polishing up / testing the patches and might send something out for discussion shortly.
> >> Just a note that on my branch was a version with a wrong condition that should have been fixed now.
> >>
> >> I am still thinking about PTE mapped THP. For these, we'll always
> >> have page_count() > 1, essentially corresponding to the number of still-mapped sub-pages.
> >>
> >> So if we end up with a R/O mapped part of a THP, we'll always have to COW and cannot reuse ever,
> >> although it's really just a single process mapping the THP via PTEs.
> >>
> >> One approach would be to scan the currently locked page table for entries mapping
> >> this same page. If page_count() corresponds to that value, we know that only we are
> >> mapping the THP and there are no additional references. That would be a special case
> >> if we find an anon THP in do_wp_page(). Hm.
> > 
> > You're starting to optimise for some pretty weird cases at that point.
> 
> So your claim is that read-only, PTE mapped pages are weird? How do you
> come to that conclusion?

Because normally anon THP pages are PMD mapped.  That's rather
the point of anon THPs.

> If we adjust the THP reuse logic to split on additional references
> (page_count() == 1) -- similarly as suggested by Linus to fix the CVE --
> we're going to end up with exactly that more frequently.

I don't understand.  Are we talking past each other?  As I understand
the situation we're talking about here, a process has created a THP,
done something to cause it to be partially mapped (or mapped in a
misaligned way) in its own address space, then forked, and we're
trying to figure out if it's safe to reuse it?  I say that situation is
rare enough that it's OK to always allocate an order-0 page and
copy into it.

> > Anon THP is always going to start out aligned (and can be moved by
> > mremap()).  Arguably it should be broken up if it's moved so it can be
> > reformed into aligned THPs by khugepaged.
> 
> Can you elaborate, I'm missing the point where something gets moved. I
> don't care about mremap() at all here.
> 
> 
> 1. You have a read-only, PTE mapped THP
> 2. Write fault on the THP
> 3. We PTE-map the THP because we run into a false positive in our COW
>    logic to handle COW on PTE
> 4. Write fault on the PTE
> 5. We always have to COW each and every sub-page and can never reuse,
>    because page_count() > 1
> 
> That's essentially what reuse_swap_page() tried to handle before.
> Eventually optimizing for this is certainly the next step, but I'd like
> to document which effect the removal of reuse_swap_page() will have to THP.

I'm talking about step 0.  How do we get a read-only, PTE-mapped THP?
Through mremap() or perhaps through an mprotect()/mmap()/munmap() that
failed to split the THP.
