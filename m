Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7136F494E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiATNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiATNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:03:31 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sAMxEzPFNeLU4Z3zBK3VqMdaurVg22n/PAfNifA/IeM=; b=i/0yfFZdwPBfRpyJyxqG7OTf4G
        UOKt59GEwHciB3ZRrhCDdX828WaQxG43yeFXjiJbVbUOlu3BlKOKr6yAUYr6LFDLQJ0zWjg11ShZF
        Tce+9sg7ShWFGFg8PJ3S30n2oPdiFGmYV7yGQ0+YUSrvJSxjNDHtlBhcIclj6B5XDEhA1Ke0dJCJj
        ttzlo+fHyeOtxtrtsi6D2zN++LVwQuUYy0/Sd/2+3Nf3do6yrhRX6uvtQbjuTW/dzK5xKeX/nDnKw
        e8gRsi0DJqSIUVY7wVD+ngor0hQ/h1TlurgKP06zLbRqMe/G6zY8n/6I88PIoqvmO1I1WwnbKKDVY
        t9FSqCyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56798)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nAX5z-0005eo-Pk; Thu, 20 Jan 2022 13:03:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nAX5m-0006Eq-Mh; Thu, 20 Jan 2022 13:03:06 +0000
Date:   Thu, 20 Jan 2022 13:03:06 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <Yeldih0PHotN4/bn@shell.armlinux.org.uk>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
 <YehilqRvYLhryUk4@shell.armlinux.org.uk>
 <319b09bc-56a2-207f-6180-3cc7d8cd43d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319b09bc-56a2-207f-6180-3cc7d8cd43d1@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:22:35PM +0000, Robin Murphy wrote:
> On 2022-01-19 19:12, Russell King (Oracle) wrote:
> > On Wed, Jan 19, 2022 at 06:43:10PM +0000, Robin Murphy wrote:
> > > Indeed, my impression is that the only legitimate way to get hold of a page
> > > pointer without assumed provenance is via pfn_to_page(), which is where
> > > pfn_valid() comes in. Thus pfn_valid(page_to_pfn()) really *should* be a
> > > tautology.
> > 
> > That can only be true if pfn == page_to_pfn(pfn_to_page(pfn)) for all
> > values of pfn.
> > 
> > Given how pfn_to_page() is defined in the sparsemem case:
> > 
> > #define __pfn_to_page(pfn)                              \
> > ({	unsigned long __pfn = (pfn);                    \
> > 	struct mem_section *__sec = __pfn_to_section(__pfn);    \
> > 	__section_mem_map_addr(__sec) + __pfn;          \
> > })
> > #define page_to_pfn __page_to_pfn
> > 
> > that isn't the case, especially when looking at page_to_pfn():
> > 
> > #define __page_to_pfn(pg)                                       \
> > ({      const struct page *__pg = (pg);                         \
> >          int __sec = page_to_section(__pg);                      \
> > 	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec))); \
> > })
> > 
> > Where:
> > 
> > static inline unsigned long page_to_section(const struct page *page)
> > {
> > 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
> > }
> > 
> > So if page_to_section() returns something that is, e.g. zero for an
> > invalid page in a non-zero section, you're not going to end up with
> > the right pfn from page_to_pfn().
> 
> Right, I emphasised "should" in an attempt to imply "in the absence of
> serious bugs that have further-reaching consequences anyway".
> 
> > As I've said now a couple of times, trying to determine of a struct
> > page pointer is valid is the wrong question to be asking.
> 
> And doing so in one single place, on the justification of avoiding an
> incredibly niche symptom, is even more so. Not to mention that an address
> size fault is one of the best possible outcomes anyway, vs. the untold
> damage that may stem from accesses actually going through to random parts of
> the physical memory map.

I don't see it as a "niche" symptom.

If we start off with the struct page being invalid, then the result of
page_to_pfn() can not be relied upon to produce something that is
meaningful - which is exactly why the vmap() issue arises.

With a pfn_valid() check, we at least know that the PFN points at
memory. However, that memory could be _anything_ in the system - it
could be the kernel image, and it could give userspace access to
change kernel code.

So, while it is useful to do a pfn_valid() check in vmap(), as I said
to willy, this must _not_ be the primary check. It should IMHO use
WARN_ON() to make it blatently obvious that it should be something we
expect _not_ to trigger under normal circumstances, but is there to
catch programming errors elsewhere.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
