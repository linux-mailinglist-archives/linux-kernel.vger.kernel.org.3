Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A6049407F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiASTMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiASTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:12:34 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BA2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kfq6BtDbp9OpFo3P4pVC1BirR13ne2CthW+xXJdID+M=; b=GvHU3PaKQOlo0Hv93WyifT/5Kl
        zS75z1K4qcrri5b+Jhl3HcS808J0atfkJlEi/6xfaFQOCUvy1hALu+SnQn1Z6Ex1Ha0kdAvi69rSA
        4jT0j7ioTEza909AvkMWjk64fQQVUJf85mn2cC5DispMk7H9RRCa+Gmyc+vTgPNmmcQmf8bcCBe7E
        G1H6y/JlOf7lwx7XjwdTUV5bRVUhWz6mdC55FFYzCm6OKXzvUrkkyCkRLEcyIJQo+oNKkHzwDyTwQ
        Oins7PgQ0dDjLnr2o709Se/iEg/ZLEHKYp4Z0mQ2RhvMM08WXbe+xplRPA1VSb7BimqiNyQ4x1xoa
        dvcnXonA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56788)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nAGNc-00053a-Ko; Wed, 19 Jan 2022 19:12:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nAGNa-0005VR-9Z; Wed, 19 Jan 2022 19:12:22 +0000
Date:   Wed, 19 Jan 2022 19:12:22 +0000
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
Message-ID: <YehilqRvYLhryUk4@shell.armlinux.org.uk>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:43:10PM +0000, Robin Murphy wrote:
> Indeed, my impression is that the only legitimate way to get hold of a page
> pointer without assumed provenance is via pfn_to_page(), which is where
> pfn_valid() comes in. Thus pfn_valid(page_to_pfn()) really *should* be a
> tautology.

That can only be true if pfn == page_to_pfn(pfn_to_page(pfn)) for all
values of pfn.

Given how pfn_to_page() is defined in the sparsemem case:

#define __pfn_to_page(pfn)                              \
({	unsigned long __pfn = (pfn);                    \
	struct mem_section *__sec = __pfn_to_section(__pfn);    \
	__section_mem_map_addr(__sec) + __pfn;          \
})
#define page_to_pfn __page_to_pfn

that isn't the case, especially when looking at page_to_pfn():

#define __page_to_pfn(pg)                                       \
({      const struct page *__pg = (pg);                         \
        int __sec = page_to_section(__pg);                      \
	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec))); \
})

Where:

static inline unsigned long page_to_section(const struct page *page)
{
	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
}

So if page_to_section() returns something that is, e.g. zero for an
invalid page in a non-zero section, you're not going to end up with
the right pfn from page_to_pfn().

As I've said now a couple of times, trying to determine of a struct
page pointer is valid is the wrong question to be asking.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
