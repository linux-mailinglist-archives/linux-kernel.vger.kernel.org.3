Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF949403A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356943AbiASS56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiASS55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:57:57 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63925C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cnpaAt1fKMl1zfeZ6oYSZ0wXrQMMc1n5lVigEXv+DUU=; b=R7DbELeFhBokcuMuG0IWS/h4e3
        mVeVGr0jpJTj8M15zPOlAAmhKKqqRHsJfyvVRO8D9NdmzNDoN+CGiRgvIpZqhCZg0g8MdmLWZf69w
        QJ7aftts5mS1hksdw1nT2aXrZelA30IbNESeChq2H1cVerCJftjLduosZ10MeDMs0VwyTdz6h3Blh
        KqC1cpuBkDEtTroZfxD9XGiSoYgHYBe+aVqz8qleaxgT5jEdC2fCQC5oDO278Jy0FYcCmJB5ZZakF
        QwRrzAQoSaYRjXXyh8VUsZ9n+gwZ73qvIirmlq2W8B3abTRXJfCKkZCuvcR5LGVWWOJ8d5ht9k6L+
        N7ehajQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56782)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nAG9N-00052m-QF; Wed, 19 Jan 2022 18:57:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nAG9G-0005U9-Mi; Wed, 19 Jan 2022 18:57:34 +0000
Date:   Wed, 19 Jan 2022 18:57:34 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <YehfHsuMzvy//Szi@shell.armlinux.org.uk>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <YehQR7NWKKzcyEq6@shell.armlinux.org.uk>
 <YehR9BiI92q5DSOu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YehR9BiI92q5DSOu@casper.infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:01:24PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 19, 2022 at 05:54:15PM +0000, Russell King (Oracle) wrote:
> > On Wed, Jan 19, 2022 at 04:27:32PM +0000, Matthew Wilcox wrote:
> > > On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
> > > > > +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > > > 
> > > > Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
> > > > in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
> > > > true...
> > > 
> > > Even if it does blow up, at least it's blowing up here where someone
> > > can start to debug it, rather than blowing up on first access, where
> > > we no longer have the invlid struct page pointer.
> > > 
> > > I don't think we have a 'page_valid' function which will tell us whether
> > > a random pointer is actually a struct page or not.
> > 
> > Isn't it supposed to be:
> > 
> > 	if (!pfn_valid(pfn)) {
> > 		handle invalid pfn;
> > 	}
> > 
> > 	page = pfn_to_page(pfn);
> > 
> > Anything else - even trying to convert an invalid page back to a pfn,
> > could well be unreliable (sparsemem or discontigmem). 
> 
> This function is passed an array of pages.  We have no way of doing
> what you propose.

You can't go from a struct page to "this is valid", it's too late by the
time you call vmap() - that's my fundamental point.

If the translation from a PFN to a struct page can return pointers to
something that isn't a valid struct page, then it can also (with
sparsemem) return a pointer to _another_ struct page that could well
be valid depending on how the struct page arrays are laid out in
memory.

To repeat: once you have a struct page, it's too late to determine if
the struct page is valid.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
