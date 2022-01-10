Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE42489D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiAJQJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:09:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2DCC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fFL6D2+bbDAotHksx495ldG8WoFs1p5F5jvOQSuWync=; b=q/E8nH8n3z3FfAND8IHjjxt6zA
        1HRUcEKuhCVUr1u43/h0IF0Df9rd1c/RzuWqn4G9cnkOdhGSaRVYKWgootqldZ1+XIEpfd/2xMNun
        pIV5s5/6OAuBJ82njTYtazpI/J6justp8wiRIwLHRdKRb23un13yn87DwuhVSxPfAnUV72Eiv70Jm
        D/+iBVyElfJgYZlOUgYH5OVu/gIIz/lFBssEPigri99WRHkid7bFXXkZXGdUqpuPIzRUvgRGd/1Te
        ot+hKtk6dve/ph0otzY9Tw0nRysThJFPiKrhdegqBluJXPtre9oWcTcMAv7tj3AvYZQrJ6WLnREjy
        gReTaM+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6xEh-002YSJ-6L; Mon, 10 Jan 2022 16:09:31 +0000
Date:   Mon, 10 Jan 2022 16:09:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/28] Convert GUP to folios
Message-ID: <YdxaO7nAj0oGXtm9@casper.infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110153103.GH6467@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110153103.GH6467@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:31:03AM -0400, Jason Gunthorpe wrote:
> 
> On Mon, Jan 10, 2022 at 04:23:38AM +0000, Matthew Wilcox (Oracle) wrote:
> > This patch series is against my current folio for-next branch.  I know
> > it won't apply to sfr's next tree, and it's not for-next material yet.
> > I intend to submit it for 5.18 after I've rebased it to one of the
> > 5.17-rc releases.
> > 
> > The overall effect of this (ignoring the primary "preparing for folios
> > that are not PAGE or PMD sized" purpose) is to reduce the size of gup.o
> > by ~700 bytes in the config I normally test with.
> > 
> > This patchset just converts existing implementations to use folios.
> > There's no new API for consumers here to provide information in a more
> > efficient (address, length) format.  That will be a separate patchset.
> > 
> > In v2, I've tried to address all the comments from the reviews I got
> > on v1.  Apologies if I missed anything; I got a lot of good feedback.
> > Primarily I separated out the folio changes (later) from the "While
> > I'm looking at this ..." changes (earlier).  I'm not sure the story
> > of the patchset is necessarily coherent this way, but it should be
> > easier to review.
> > 
> > Another big change is that compound_pincount is now available to all
> > compound pages, not just those that are order-2-or-higher.  Patch 11.
> > 
> > I did notice one bug in my original patchset which I'm disappointed GCC
> > didn't diagnose:
> > 
> > 		pages[nr++] = nth_page(page, nr);
> > 
> > Given the massive reorg of the patchset, I didn't feel right using
> > anyone's SoB from v1 on any of the patches.  But, despite the increased
> > number of patches, I hope it's easier to review than v1.
> > 
> > And I'd dearly love a better name than 'folio_nth'.  page_nth() is
> > a temporary construct, so doesn't need a better name.  If you need
> > context, it's in the gup_folio_range_next() patch and its job
> > is to tell you, given a page and a folio, what # page it is within
> > a folio (so a number between [0 and folio_nr_pages())).
> 
> folio_tail_index() ?

I'm a little wary of "index" because folios are used to cache file data,
and folio->index means offset of the folio within the file.  We could
make the argument for folio_page_index() (since it might be the head
page, not a tail page), and argue this is the index into the folio,
not the index into the file.

It's better than folio_nth ;-)

> Series still looks good to me, though I checked each patch
> carefully than the prior series:
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!
