Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A124940FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357015AbiASTgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357034AbiASTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:35:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA1C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BTctFDlugghbPb+mT0fgLBcwlvNBpzSgllYA3xjcWrs=; b=jcnZQSl5oKu5z9MZdKcUVh/HDN
        QIRUbKxvEgbiqaoJ8yVLCy8UxESf7Ve2AtfN42EmuXgcCMBS8LQl4VNpa8nZEK/FzdZaXnlOh5neE
        X+ALUAl+ZF8C9z0qIpLd4axHfWML+pcSJ3TYZ75vfXLre1Esd+GX0bdzwElrlbbJWOesI9MG/NYbj
        qi3cmhafL8em48vvoN4EAoL8fbjZCHbkd4hpmArMAbbpDhS84XPpQAYEI1RW6kcdfbTH/E6q+s9ap
        +c2vLEmj+5VKpXS4MZkOKUT6FAQL7RVaGnvQGCox80+T0EwnwL0foIvDx5jef9sazBRLGiW4dZ4Gr
        2wts/3lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAGk1-00BvrJ-F0; Wed, 19 Jan 2022 19:35:33 +0000
Date:   Wed, 19 Jan 2022 19:35:33 +0000
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
Message-ID: <YehoBQZvSmwXjqJ3@casper.infradead.org>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <YehQR7NWKKzcyEq6@shell.armlinux.org.uk>
 <YehR9BiI92q5DSOu@casper.infradead.org>
 <YehfHsuMzvy//Szi@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YehfHsuMzvy//Szi@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:57:34PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 19, 2022 at 06:01:24PM +0000, Matthew Wilcox wrote:
> > On Wed, Jan 19, 2022 at 05:54:15PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Jan 19, 2022 at 04:27:32PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
> > > > > > +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > > > > 
> > > > > Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
> > > > > in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
> > > > > true...
> > > > 
> > > > Even if it does blow up, at least it's blowing up here where someone
> > > > can start to debug it, rather than blowing up on first access, where
> > > > we no longer have the invlid struct page pointer.
> > > > 
> > > > I don't think we have a 'page_valid' function which will tell us whether
> > > > a random pointer is actually a struct page or not.
> > > 
> > > Isn't it supposed to be:
> > > 
> > > 	if (!pfn_valid(pfn)) {
> > > 		handle invalid pfn;
> > > 	}
> > > 
> > > 	page = pfn_to_page(pfn);
> > > 
> > > Anything else - even trying to convert an invalid page back to a pfn,
> > > could well be unreliable (sparsemem or discontigmem). 
> > 
> > This function is passed an array of pages.  We have no way of doing
> > what you propose.
> 
> You can't go from a struct page to "this is valid", it's too late by the
> time you call vmap() - that's my fundamental point.

Yes, and we have debugging code in __virt_to_phys() that would have
caught this, had Yury enabled CONFIG_DEBUG_VIRTUAL.  My point is that
in this instance, page_to_pfn() doesn't crash, which lets vmap() set
up a mapping to a completely bogus physical address.  We're better
off checking pfn_valid() here than not.

> If the translation from a PFN to a struct page can return pointers to
> something that isn't a valid struct page, then it can also (with
> sparsemem) return a pointer to _another_ struct page that could well
> be valid depending on how the struct page arrays are laid out in
> memory.

Sure, it's not going to catch everything.  But I don't think that
letting perfect be the enemy of the good here is the right approach.
