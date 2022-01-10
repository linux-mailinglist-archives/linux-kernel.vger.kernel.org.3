Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD5489336
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiAJIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbiAJIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:25:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105DC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YynQkzcvAks2tBBSZS0aAIuAsmuAABDla0Di0gbOoYo=; b=2RGKLhJqTuO4wHte2T1fnyxYko
        JdIgS93faNbq7P3qA9vP6wqgeMF9o0U2JryPpDMmZu2sqBeokULrOjPFmsE1ou7QEm5i9raUshx1B
        mjemeg8ZHn2Ic0VY6n2b155iOPh+3+pO0zKX7aqS6ZlVFXug3NsmwLiY0AFm290MbE0aZtMP2+qUN
        Zg8LasmfoJ0VGq3B2uPV+6UxHbZ7xiJfpswWETevAqc4SanSTuSVE5SGlIJZqK3Ay8oNOa0ilnxQR
        DKimnYnU+XjhmGXax0JQzrzLCYWDn2o4rRvjvT7YENfDVwepJ7Fcjf9V8+Ud4pKL7r/ao3igqbgrG
        SbRAZciw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6pza-009qBQ-0J; Mon, 10 Jan 2022 08:25:26 +0000
Date:   Mon, 10 Jan 2022 00:25:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 03/28] gup: Change the calling convention for
 compound_range_next()
Message-ID: <YdvtdULHKIeGrX0z@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:41AM +0000, Matthew Wilcox (Oracle) wrote:
> Return the head page instead of storing it to a passed parameter.
> Pass the start page directly instead of passing a pointer to it.

Looks good, but when we're changing the calling conventions anyway:

> -static inline void compound_range_next(unsigned long i, unsigned long npages,
> -				       struct page **list, struct page **head,
> -				       unsigned int *ntails)
> +static inline struct page *compound_range_next(unsigned long i,
> +		unsigned long npages, struct page *start, unsigned int *ntails)

To me the logical argument order would be something like:

static inline struct page *compound_range_next(struct page *start,
		unsigned long npages,, unsigned long i, unsigned int *ntails)

where the two first arguments pass in what is worked on and match the 
calling conventions of the caller.
