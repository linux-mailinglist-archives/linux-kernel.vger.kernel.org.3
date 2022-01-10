Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E85489361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiAJIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbiAJIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:30:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE56C061751
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NyEGaIYhwQZ0SG9l+yYLvyNiaRvR0QxLhqApt8jZaKE=; b=JrJKSdtRxHrQN7s9iBLyOoykSx
        JQgRIG1E8NRFWcqaELsPNkiTVCRX2/wUbBDRVPWvCEajPXq6zCjhHP5NGO99omk/Zv95pacaHGDOJ
        hhkZt6Sv+AigS/UZQCcsI6w7wrvNMFbvn9sI3ryC4vNkjic+3WZJc90x0wsLRN2my5OL8MqdCCeyV
        M7KEDcVjiG3xVwLM9Seo5FPxw10ojtFlyaonjrV++hKEIR54aOE/4IYI9ZgvjIwh6xPUIFk+517Lg
        DTZx0anNWCCJjpJfSwxCdEtvkGw/PXMa+DNijgapdP/kcaR5kppYrJ0NuhjMSyfROk28/nmvD7edy
        7dMuLguw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q3y-009sLI-VK; Mon, 10 Jan 2022 08:29:58 +0000
Date:   Mon, 10 Jan 2022 00:29:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 06/28] gup: Fix some contiguous memmap assumptions
Message-ID: <YdvuhjweiC1SjVF4@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:44AM +0000, Matthew Wilcox (Oracle) wrote:
> Several functions in gup.c assume that a compound page has virtually
> contiguous page structs.  This isn't true for SPARSEMEM configs unless
> SPARSEMEM_VMEMMAP is also set.  Fix them by using nth_page() instead of
> plain pointer arithmetic.

So is this an actualy bug that need a Fixes tag, or do all architectures
that support THP and sparsemem use SPARSEMEM_VMEMMAP?

> +	page = nth_page(head, (addr & (sz-1)) >> PAGE_SHIFT);

Would be nice to fix the indeation for sz - 1 while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
