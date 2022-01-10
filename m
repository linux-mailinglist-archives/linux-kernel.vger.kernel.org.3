Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE93B489367
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbiAJId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiAJIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:31:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8EC03400C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e79RBh3RTVWPj6rYkP4UHRg/Ov+OQkUWfvKe2DbQ7YY=; b=CHAML+e1cyUBVcOWaNpXlSAVu6
        m4CWrK994Ga2b7HmYQGIuOCsX/gMCU4BQ0MX/keA4/DlLTAIs0zWWuh4IIiKS8k0bORvkCWuk9Cpk
        r3Lgo0KcN6dE/iTCYL/FWatH2wyTZSR6zhKNThUZykrh8Yeb3WRPgrE+hbKl2zUDt4Hr9+3laJm54
        M7TALUBT2B7k3HvXoDbE+ovLejixjK3P6lVZM/bJ9ZO6/YKjsbUXjQJNAAZ7HJN9G6gf3Af/5mh/o
        Mt1CqlEVZqQRxDbFN9ZxigMVpjTXCcayPuv+/yoh2MjRt+mju6jIknmhHniYtFPMhDBWMqOYj9O63
        9+iZhHbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q58-009sr0-VD; Mon, 10 Jan 2022 08:31:10 +0000
Date:   Mon, 10 Jan 2022 00:31:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 08/28] gup: Handle page split race more efficiently
Message-ID: <YdvuzvdoYz1KzFWo@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:46AM +0000, Matthew Wilcox (Oracle) wrote:
> If we hit the page split race, the current code returns NULL which will
> presumably trigger a retry under the mmap_lock.  This isn't necessary;
> we can just retry the compound_head() lookup.  This is a very minor
> optimisation of an unlikely path, but conceptually it matches (eg)
> the page cache RCU-protected lookup.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
