Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93685493F78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349809AbiASSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiASSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:01:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wl35Nv5bzMCc708L4TqlyxLqxeH3mVDxX3k5zPuEGYo=; b=e6nKWnC2p+Tf/OuPB41XZewJTw
        9aR5M2y6V/hfTahSIhFlgmKQoZ3OddEQoQb9TKA0jXQ2gbJRF6D0r6+TfbLm/heQJSprsV/QYpqcY
        qq11o1p/4VBTmIwr4vC84NqqRk0geKSmNkyOUY69cPTWm88tcFDEhTdqyUm7MD1Lbct50fNlKC99a
        BsyYPEPzDplXfd6VxNXD1dTJDfwfytPkKD8GZO/CVy0HjvUTo6ESV0VgcPXaG/+fAuvU5U+FtEZze
        H0KgRLdO8+qm8+U5XG8DSeVKCdBYV9XUUZv9SK820h3R+8x+V0sT9bzgLLNLmFZSPNdd5Lmkzn0+L
        h7HcSL4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAFGu-00BeGf-9X; Wed, 19 Jan 2022 18:01:24 +0000
Date:   Wed, 19 Jan 2022 18:01:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Message-ID: <YehR9BiI92q5DSOu@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <YehQR7NWKKzcyEq6@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YehQR7NWKKzcyEq6@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:54:15PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 19, 2022 at 04:27:32PM +0000, Matthew Wilcox wrote:
> > On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
> > > > +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > > 
> > > Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
> > > in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
> > > true...
> > 
> > Even if it does blow up, at least it's blowing up here where someone
> > can start to debug it, rather than blowing up on first access, where
> > we no longer have the invlid struct page pointer.
> > 
> > I don't think we have a 'page_valid' function which will tell us whether
> > a random pointer is actually a struct page or not.
> 
> Isn't it supposed to be:
> 
> 	if (!pfn_valid(pfn)) {
> 		handle invalid pfn;
> 	}
> 
> 	page = pfn_to_page(pfn);
> 
> Anything else - even trying to convert an invalid page back to a pfn,
> could well be unreliable (sparsemem or discontigmem). 

This function is passed an array of pages.  We have no way of doing
what you propose.
