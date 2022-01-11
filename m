Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF47448A6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbiAKEjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiAKEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:38:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A450BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M3Qjf/WLm4+ja7B2psDBJO0nkAUuZjPYlJC4t81KgB8=; b=nC0OO2CRfA6Aw5yvhBU9t3n9q2
        taR9jEkT+AvH3wVhQYw4AFl0zTG9+Wx2b9TKovCxbfTY2O+mRQyjSKa1y8BPuQHMUdo1X5L5Ieql2
        QC0SKNl3EBvthNo7D73HmvXwdamBDTWzWC793iMad40GiBMgFyTCOJjCNcoBE9w8vlel+jQafE2ds
        wdngzMAvmASo7YklEcJHRYLPxWuwJcv0GbL4v9HnFmZOLh5+LmBMz6thUg/D+7uI9kedjf5HNj2GQ
        4oHw6QimulpcmlhG+GhMnwa3o82nxtfZKajhsojUuKNRCc3DubNEW7RhwYueroFSe7c8QxqTF5jjk
        868DazvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n78vt-002yEu-3b; Tue, 11 Jan 2022 04:38:53 +0000
Date:   Tue, 11 Jan 2022 04:38:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 11/28] mm: Make compound_pincount always available
Message-ID: <Yd0J3QgwgRadAZyp@casper.infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-12-willy@infradead.org>
 <279070af-4ac8-942f-5096-f7f61db9aeb6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279070af-4ac8-942f-5096-f7f61db9aeb6@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:06:54PM -0800, John Hubbard wrote:
> > +#ifdef CONFIG_64BIT
> >   	return page[1].compound_nr;
> > +#else
> > +	return 1UL << compound_order(page);
> > +#endif
> 
> Now that you are highlighting this, I have this persistent feeling (not
> yet confirmed by any testing) that compound_nr is a micro-optimization
> that is actually invisible at runtime--but is now slicing up our code
> with ifdefs, and using space in a fairly valuable location.
> 
> Not for this patch or series, but maybe a separate patch or series
> should just remove the compound_nr field entirely, yes? It is
> surprising to carry around both compound_order and (1 <<
> compound_order), right next to each other. It would be different if this
> were an expensive calculation, but it's just a shift.
> 
> Maybe testing would prove that that's a bad idea, and maybe someone has
> already looked into it, but I wanted to point it out.

It' probably worth looking at the patch which added it ... 1378a5ee451a
in August 2020.  I didn't provide any performance numbers, but code size
definitely went down.

> > @@ -52,7 +51,7 @@ static int page_pincount_sub(struct page *page, int refs)
> >   {
> >   	VM_BUG_ON_PAGE(page != compound_head(page), page);
> > -	if (hpage_pincount_available(page))
> > +	if (PageHead(page))
> 
> OK, so we just verified (via VM_BUG_ON_PAGE(), which is not always active)
> that this is not a tail page. And so PageHead() effectively means PageCompound().
> 
> I wonder if it would be better to just use PageCompound() here and in similar
> cases. Because that's what is logically being checked, after all. It seems
> slightly more accurate.

Well PageCompound() is defined as PageHead() || PageTail().  I don't
think the intent was for people to always ask "Is this a compound page",
more "This is a good shorthand to replace PageHead() || PageTail()".
It's kind of moot anyway because this gets replaced with
folio_test_large() further down the patch series.

