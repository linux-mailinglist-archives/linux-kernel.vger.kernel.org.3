Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2161E49431B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357565AbiASWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiASWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:38:59 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7843C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RZdMRmyvk76b5yPhRV2i+xX8UdR7XO+5UD90vqV4ELA=; b=dFvz8pXyCLGzxAuQ7QKau+I68U
        HqsQzZKmn0yL/Q/2FyQvN1ZGs8jxyGsd/vXe++hc+4GVVXKGIaeAl4K2c9M6eIxIqgbLOyyReENKu
        MiTNbb+83iz0oBPL99bdZa7zLJBKfhb/3CFOibP81z07+uQknIT3fFnJftf8tHg9sQsipUD2VvbPR
        rvsjdEgZZE+btlgnVhXphSBlOmMNvsN3o4eew2G3YGLtFdB+FIhgBPwtJu4+h1Njj0fjJUXlciUO9
        4HmveomFLZs7gQFgmIKkZ92exDbwUPyzLQtJvsVtV/KYVJGAp3kWtGaS5ghRkCW9KCuMVi7h93g0I
        72ZF+mSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56790)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nAJbM-0005Ax-DK; Wed, 19 Jan 2022 22:38:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nAJbG-0005cr-TZ; Wed, 19 Jan 2022 22:38:42 +0000
Date:   Wed, 19 Jan 2022 22:38:42 +0000
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
Message-ID: <YeiS8vDcQ6/B26fG@shell.armlinux.org.uk>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <YehQR7NWKKzcyEq6@shell.armlinux.org.uk>
 <YehR9BiI92q5DSOu@casper.infradead.org>
 <YehfHsuMzvy//Szi@shell.armlinux.org.uk>
 <YehoBQZvSmwXjqJ3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YehoBQZvSmwXjqJ3@casper.infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 07:35:33PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 19, 2022 at 06:57:34PM +0000, Russell King (Oracle) wrote:
> > On Wed, Jan 19, 2022 at 06:01:24PM +0000, Matthew Wilcox wrote:
> > > On Wed, Jan 19, 2022 at 05:54:15PM +0000, Russell King (Oracle) wrote:
> > > > On Wed, Jan 19, 2022 at 04:27:32PM +0000, Matthew Wilcox wrote:
> > > > > On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
> > > > > > > +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > > > > > 
> > > > > > Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
> > > > > > in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
> > > > > > true...
> > > > > 
> > > > > Even if it does blow up, at least it's blowing up here where someone
> > > > > can start to debug it, rather than blowing up on first access, where
> > > > > we no longer have the invlid struct page pointer.
> > > > > 
> > > > > I don't think we have a 'page_valid' function which will tell us whether
> > > > > a random pointer is actually a struct page or not.
> > > > 
> > > > Isn't it supposed to be:
> > > > 
> > > > 	if (!pfn_valid(pfn)) {
> > > > 		handle invalid pfn;
> > > > 	}
> > > > 
> > > > 	page = pfn_to_page(pfn);
> > > > 
> > > > Anything else - even trying to convert an invalid page back to a pfn,
> > > > could well be unreliable (sparsemem or discontigmem). 
> > > 
> > > This function is passed an array of pages.  We have no way of doing
> > > what you propose.
> > 
> > You can't go from a struct page to "this is valid", it's too late by the
> > time you call vmap() - that's my fundamental point.
> 
> Yes, and we have debugging code in __virt_to_phys() that would have
> caught this, had Yury enabled CONFIG_DEBUG_VIRTUAL.  My point is that
> in this instance, page_to_pfn() doesn't crash, which lets vmap() set
> up a mapping to a completely bogus physical address.  We're better
> off checking pfn_valid() here than not.

I don't disagree that pfn_valid() will catch _some_ but it should, no,
must not be a subsitute for ensuring that the proper checks are done
when creating e.g. an array of struct pages.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
