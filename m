Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47583489A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiAJNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiAJNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:37:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EDBC061759
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4wR6hrOJgs+X6kKk9+UhCE6lJrlz1SxlJAZof4WK/t0=; b=P7j/zTCAD0FbAREoR6HCZlOov3
        5nLtOzCxOa7TeZ0E4/VTBu9clkGt3hSpYfm0ETOgd1Adt2KU3yfaYre8E6LLUwHrIkrSTYscLDBVN
        0h0N96DW6dwC9svxZZEVt3j4pFhZZABuMYbQ4QdcgrMrPE3XFdViUUIFCeZIcLcuGdVE6MuyOXuLl
        utNXfONFU9EwP8ltAzVkPygTkSwzKioqMocEXABoJxqs4glfgPyFwcTYxHfcYNwygtaaXLOu/Gqv1
        Q8FiID8B4eDmbI70J5k397RQ1JnSPweGlxkQzm7kgOjRsZNuWTweiW8vwGk2NQR28wGzacmyDvN+e
        dexLbQ4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6urJ-002SWS-PY; Mon, 10 Jan 2022 13:37:13 +0000
Date:   Mon, 10 Jan 2022 13:37:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 06/28] gup: Fix some contiguous memmap assumptions
Message-ID: <Ydw2iQR8fT+qGkz6@casper.infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-7-willy@infradead.org>
 <YdvuhjweiC1SjVF4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdvuhjweiC1SjVF4@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:29:58AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 10, 2022 at 04:23:44AM +0000, Matthew Wilcox (Oracle) wrote:
> > Several functions in gup.c assume that a compound page has virtually
> > contiguous page structs.  This isn't true for SPARSEMEM configs unless
> > SPARSEMEM_VMEMMAP is also set.  Fix them by using nth_page() instead of
> > plain pointer arithmetic.
> 
> So is this an actualy bug that need a Fixes tag, or do all architectures
> that support THP and sparsemem use SPARSEMEM_VMEMMAP?

As far as I can tell (and I am by no means an expert in this area),
this problem only affects pages of order MAX_ORDER or higher.  That is,
somebody using regular 2MB hugepages on x86 won't see a problem, whether
they're using VMEMMAP or not.  It only starts to become a problem for
1GB hugepages.

Since THPs are (currently) only allocated from the page allocator, it's
never a problem for THPs, only hugetlbfs.  Correcting the places which
can't see a 1GB page is just defense against copy-and-paste programming.

So I'll defer to Mike -- does this ever affect real systems and thus
warrant a backport?  I know this doesn't affect UEK because we enable
SPARSEMEM_VMEMMAP.

> > +	page = nth_page(head, (addr & (sz-1)) >> PAGE_SHIFT);
> 
> Would be nice to fix the indeation for sz - 1 while you're at it.

Done.
