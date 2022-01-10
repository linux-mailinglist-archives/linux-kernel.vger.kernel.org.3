Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2743489370
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiAJIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiAJIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:33:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF9C06175B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A/43r08mOjVURmRLmz2DPWdTMlAAqU8KbGodPJW3Jjc=; b=42LouDWvMydB5hPBzf+aeK1ucE
        Qd1QyYTLImOx/kIKmNiVgqLZbL7SfxXgak1WTKmUn73kNUetDuD2FqIWPahrPqnjtI9TQQPI+dt0O
        ipxaoFnTIt9Uq7PN/OHFMyOJ12gDbclPbvIAAx8JQYA1+KO7d+0LqL1CXHca5nF6b+ncslwpD2rTf
        sdAH4eKrfpuuPgo5nJMsQqanREka7EGKgV9oDcSR5T7GotnGl/m5AZ7XdQYKOgOFHNObjanwsVtvO
        1hxupNWvwazh3kEwniym3O5gVQDvaCftgZUsWAnzKcyg6dw5jKLoYUsnDITA0ksyxhPlIibG1wXZs
        dWCELxZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q7E-009tjr-Ag; Mon, 10 Jan 2022 08:33:20 +0000
Date:   Mon, 10 Jan 2022 00:33:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 13/28] mm: Add folio_pincount_ptr()
Message-ID: <YdvvUHZTNdfvWh2Y@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:51AM +0000, Matthew Wilcox (Oracle) wrote:
> +static inline atomic_t *folio_pincount_ptr(struct folio *folio)
> +{
> +	struct page *tail = &folio->page + 1;
> +	return &tail->compound_pincount;
> +}

And empty line after the declaration would be nice here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
