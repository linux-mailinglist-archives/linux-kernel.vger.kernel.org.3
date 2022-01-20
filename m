Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6C495065
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356221AbiATOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbiATOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:39:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A842C061746
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2LwJlstIvGsqeuZylXzQhNRQ08SoRUnluLli12GzN0Y=; b=MLOMkHVV/aQF9+c0reWTugaM9U
        fqssnhX4hLmiOyyktv30+yx1DdcEpO8C56HNtNoAJkfzL7pedwkQvb6/YPZE0SHBFHKNJvKtcWxTs
        qLhm5NgGMg+GVT2CXPVNPdRfmIj+meXAlP8nMsOJvcEr9+xzFbGHAx9MqHsVnhvUsWRRswJk4ERvs
        tWWoPAGK11Mg5UfDAzezIGOoGg6pVTrruoNuK/6xFcD9lCTW4hvPRp4/IxKBqLg/ZG2ckpfBU0w3O
        RysaXNypn6JY3i4596syObCCuYBdQT2J/Dr9sycq7jv9EuQ9eRlVa1E2wPLaXfo7af8mEzp2/WpOQ
        brgwZ1Tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAYab-00EKmj-9H; Thu, 20 Jan 2022 14:39:01 +0000
Date:   Thu, 20 Jan 2022 14:39:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <Yel0BXVyj8uvsWJX@casper.infradead.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:15:37PM +0100, David Hildenbrand wrote:
> On 17.01.22 14:31, zhangliang (AG) wrote:
> > Sure, I will do that :)
> 
> I'm polishing up / testing the patches and might send something out for discussion shortly.
> Just a note that on my branch was a version with a wrong condition that should have been fixed now.
> 
> I am still thinking about PTE mapped THP. For these, we'll always
> have page_count() > 1, essentially corresponding to the number of still-mapped sub-pages.
> 
> So if we end up with a R/O mapped part of a THP, we'll always have to COW and cannot reuse ever,
> although it's really just a single process mapping the THP via PTEs.
> 
> One approach would be to scan the currently locked page table for entries mapping
> this same page. If page_count() corresponds to that value, we know that only we are
> mapping the THP and there are no additional references. That would be a special case
> if we find an anon THP in do_wp_page(). Hm.

You're starting to optimise for some pretty weird cases at that point.
Anon THP is always going to start out aligned (and can be moved by
mremap()).  Arguably it should be broken up if it's moved so it can be
reformed into aligned THPs by khugepaged.

This is completely different from file-backed THPs, where misalignment
might be considered normal (if unfortunate).
