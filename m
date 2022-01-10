Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6A489A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiAJNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiAJNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:41:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2B1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jEw1SOvY92ZLm66igAJigZ2cImKkRwTS7WJcjKMowwI=; b=ZYsbOjm6qM/0j4QWWVpw2el5vC
        UmUG9ZBMHdMeff+4RtSTOGJMxt7HtXSXEeQsVgTBB0eFEa1RYJMpOZktVVyqJj8A62+kCsU+iuAPb
        Z2iqpUrDfIY9nLTnCTfd5byDb17FT7klWexH6e6e76q/r2xNcZU3fM78JCQL5xRmlw87LVlzUH5J6
        6IpoeWPYqq6xaUpqvIf4gyCuZCJRfQ2WQO/Vyo09Vhq5K8wGD4DhgaChoHAEJzGI1gVH4pMvQ+EyZ
        tmiF0LJoPZgETqAY7ayID1H13spCAZS17GnQt2sM7xF7HcTbGE1/TU9vyjsDN0qXN38qO/6Is4TmK
        8/osPAOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6uvb-002SjP-Jl; Mon, 10 Jan 2022 13:41:39 +0000
Date:   Mon, 10 Jan 2022 13:41:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 26/28] gup: Convert compound_range_next() to
 gup_folio_range_next()
Message-ID: <Ydw3k7xEYocKpWbc@casper.infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-27-willy@infradead.org>
 <YdvxMgDFJBI77iHo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdvxMgDFJBI77iHo@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:41:22AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 10, 2022 at 04:24:04AM +0000, Matthew Wilcox (Oracle) wrote:
> > +static inline struct folio *gup_folio_range_next(unsigned long i,
> >  		unsigned long npages, struct page *start, unsigned int *ntails)
> >  {
> > -	struct page *next, *page;
> > +	struct page *next;
> > +	struct folio *folio;
> >  	unsigned int nr = 1;
> >  
> >  	next = nth_page(start, i);
> > +	folio = page_folio(next);
> 
> Superficial nit:  initialization next and folio at declaration time
> would reada little better.

Done.  Also the previous patch:

-static inline struct page *compound_next(struct page **list,
+static inline struct folio *gup_folio_next(struct page **list,
                unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-       struct page *page;
+       struct folio *folio = page_folio(list[i]);
        unsigned int nr;

-       page = compound_head(list[i]);
        for (nr = i + 1; nr < npages; nr++) {

