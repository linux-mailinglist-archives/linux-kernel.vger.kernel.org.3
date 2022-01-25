Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED14049B5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386156AbiAYOM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386212AbiAYOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:10:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F45C061757
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NDtxC4AV4/gW2KDw8MdrhdATAgU1HE8zgSQEUrvWdfA=; b=lVeE5N5gZ+s+tz3PNV9JEqvxsa
        EhDK73wXij4kY8XOew/ZcY/NaO1P06iTeSjOyS1JpZJMNJ3rBNpZ+s0v02RlldkEpU1nmYb6GDbTq
        I6HEaInAa3VmYijtrAd0ZUTAvrRlYrZHhFryAZ091cCRys/L5Ix8OMyo8PQzD362ye6JINFkZsbd1
        Bn2pH841+i6OHOSrZzoCtQ3rnCt5dX9isNcYf1qATlO7K3Kg5Y0Qpox8mEox31cE09u8eCkKOwlS1
        zcxfVR17ybd2Xbbk/jR3mSNPFs5+fJyUE5iNVggih+ndpTXHou7/oF6YOovBhJZkISGxTwYNZNFdJ
        f61cwj6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCMW3-002urD-5S; Tue, 25 Jan 2022 14:09:47 +0000
Date:   Tue, 25 Jan 2022 14:09:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YfAEqzTeBJSIOKcA@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:59:17PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 25, 2022 at 01:23:21PM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 25, 2022 at 02:42:12PM +0300, Kirill A. Shutemov wrote:
> > > I wounder if we can get away with zero-API here: we can transparently
> > > create/use shared page tables for any inode on mmap(MAP_SHARED) as long as
> > > size and alignment is sutiable. Page tables will be linked to the inode
> > > and will be freed when the last of such mapping will go away. I don't see
> > > a need in new syscalls of flags to existing one.
> > 
> > That's how HugeTLBfs works today, right?  Would you want that mechanism
> > hoisted into the real MM?  Because my plan was the opposite -- remove it
> > from the shadow MM once mshare() is established.
> 
> I hate HugeTLBfs because it is a special place with own rules. mshare() as
> it proposed creates a new special place. I don't like this.

No new special place.  I suppose the only thing it creates that's "new"
is an MM without any threads of its own.  And from the MM point of view,
that's not a new thing at all because the MM simply doesn't care how
many threads share an MM.

> It's better to find a way to integrate the feature natively into core-mm
> and make as much users as possible to benefit from it.

That's what mshare is trying to do!

> I think zero-API approach (plus madvise() hints to tweak it) is worth
> considering.

I think the zero-API approach actually misses out on a lot of
possibilities that the mshare() approach offers.  For example, mshare()
allows you to mmap() many small files in the shared region -- you
can't do that with zeroAPI.
