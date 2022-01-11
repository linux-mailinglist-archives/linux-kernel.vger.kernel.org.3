Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5F48AEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiAKNqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240678AbiAKNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:46:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5hmzL0ZLGqEvLhxt4LfKaZzEs7EYYCoq9RGBa9ZBDf0=; b=iSSJbfr12iqcifaqmPvqBXI3iL
        5kAag8cDMh38bxMVKOwhSpmuLFIR/1BnQfvkDh8K9pgBT7qNzgAjchraqn76KTPT2yVs1AZMTyOGL
        AuDhiV8jnIhZdA0DTatdCI387h3kX31CsYwLjNdB2J2bdtsndiBXKB296+PxnZ4B2ROqzs5nNTOH7
        OsTSiVe9znqBqOaQsyGsaGaQEBbs5SWv30H6/dEA17m+89hy+/7Q1hpiPPbnMIKuGydnuNJz8ixXx
        Gt8Q4YNf20p5p437drePynD/txDHkC3WMq5ln46XZnD4fFdhOZpg9R8touZZvNxMlq6g8R326hgsu
        jgl6pc9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7HU2-003IHp-1X; Tue, 11 Jan 2022 13:46:42 +0000
Date:   Tue, 11 Jan 2022 13:46:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 09/28] gup: Turn hpage_pincount_add() into
 page_pincount_add()
Message-ID: <Yd2KQmYXIs2ZTNDU@casper.infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-10-willy@infradead.org>
 <8ad9c4b4-19a6-b22d-91b8-72125bc710cd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad9c4b4-19a6-b22d-91b8-72125bc710cd@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:32:20PM -0800, John Hubbard wrote:
> On 1/9/22 20:23, Matthew Wilcox (Oracle) wrote:
> ...
> > diff --git a/mm/gup.c b/mm/gup.c
> > index dbb1b54d0def..3ed9907f3c8d 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -29,12 +29,23 @@ struct follow_page_context {
> >   	unsigned int page_mask;
> >   };
> > -static void hpage_pincount_add(struct page *page, int refs)
> > +/*
> > + * When pinning a compound page of order > 1 (which is what
> > + * hpage_pincount_available() checks for), use an exact count to track
> > + * it, via page_pincount_add/_sub().
> > + *
> > + * However, be sure to *also* increment the normal page refcount field
> > + * at least once, so that the page really is pinned.  That's why the
> > + * refcount from the earlier try_get_compound_head() is left intact.
> > + */
> 
> I just realized, after looking at this again in a later patch, that the
> last paragraph, above, is now misplaced. It refers to the behavior of the
> caller, not to this routine. So it needs to be airlifted back to the
> caller.

I really do think it fits better here.  The thing is there's just one
caller, so it's a little hard to decide what "all callers" need when
there's only one.  Maybe I can wordsmith this a bit to read better.

> > +static void page_pincount_add(struct page *page, int refs)
> >   {
> > -	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
> >   	VM_BUG_ON_PAGE(page != compound_head(page), page);
> > -	atomic_add(refs, compound_pincount_ptr(page));
> > +	if (hpage_pincount_available(page))
> > +		atomic_add(refs, compound_pincount_ptr(page));
> > +	else
> > +		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
> >   }
> >   static void hpage_pincount_sub(struct page *page, int refs)
> > @@ -150,21 +161,7 @@ struct page *try_grab_compound_head(struct page *page,
> >   		if (!page)
> >   			return NULL;
> > -		/*
> > -		 * When pinning a compound page of order > 1 (which is what
> > -		 * hpage_pincount_available() checks for), use an exact count to
> > -		 * track it, via hpage_pincount_add/_sub().
> > -		 *
> > -		 * However, be sure to *also* increment the normal page refcount
> > -		 * field at least once, so that the page really is pinned.
> > -		 * That's why the refcount from the earlier
> > -		 * try_get_compound_head() is left intact.
> > -		 */
> 
> ...here.
> 
> > -		if (hpage_pincount_available(page))
> > -			hpage_pincount_add(page, refs);
> > -		else
> > -			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
> > -
> > +		page_pincount_add(page, refs);
> >   		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
> >   				    refs);
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
