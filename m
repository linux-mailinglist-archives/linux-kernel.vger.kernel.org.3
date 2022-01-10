Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9474893DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbiAJInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiAJIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:41:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED8C03400A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zAtKu7P8fv2P49P7cdzZ6hqSkFnk9bs2455/DWJXuSU=; b=C7heQV030RjaYXIiVwtSD86ZS+
        MOdpkFywTN9bK6P5NN9MLM8zWIFUDj4+FrKNIgt9gtczE9/UmZBM16OL3/XifxYWuF731VmwI38QJ
        4KwvyNXHDmNp8N+zckQ/NSrFCQ/BPx3xsagSxmn76OiprU5cpi0ey4yXs/M01YLEbE1qtlPjfxJgJ
        D7bH208RDMMvhuvMq3oczkpB6zFfr1MuD5tBZ+Tiv+X7hsWeEPO3E3p05M5GvOG26tH6UqZ8O9vyz
        Zv30x3tPCKuMPMEBivWIaSuAZAtf0xWlarrdxYWJpusDfIAAsh+mFgxX6xgrFQDn12wV7ouOccyE8
        Rr1qMslg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qF0-009y6A-Ev; Mon, 10 Jan 2022 08:41:22 +0000
Date:   Mon, 10 Jan 2022 00:41:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 26/28] gup: Convert compound_range_next() to
 gup_folio_range_next()
Message-ID: <YdvxMgDFJBI77iHo@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-27-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:24:04AM +0000, Matthew Wilcox (Oracle) wrote:
> +static inline struct folio *gup_folio_range_next(unsigned long i,
>  		unsigned long npages, struct page *start, unsigned int *ntails)
>  {
> -	struct page *next, *page;
> +	struct page *next;
> +	struct folio *folio;
>  	unsigned int nr = 1;
>  
>  	next = nth_page(start, i);
> +	folio = page_folio(next);

Superficial nit:  initialization next and folio at declaration time
would reada little better.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
