Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEF48933F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiAJI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiAJI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:26:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449E3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kj/0GWOlRnOB2zpQoSY1L9VJzIVf6PWotYpNkxVVSF0=; b=ycnVGAWGVoOzSSqRP91lqi27dr
        xfOJnaAiSbOfSDpH2YRksSnDfLkPBYn0geBbQUwSsbzqvsTKbSmXxa6RYxp2i+vM6kYcxQWo9d11F
        vIWiGdqExoSdXzbETv/Qs2+WhZuXnQZ9s8p0GOUb1uuEzIFcmU6+5IznJlf68sAoKZLR5vL7wq0xV
        4V0DJbp5h1NRquBoSEYPBCns7jJcSU/auaMlLYVz82zHtW7u8Bpe8SCPF7dKjcFQG9BpoiiaeopHF
        GYyaAs79fhf7JW0lgHW6qBdn+Spr2/hxs2YNxrWGO1JPOblCGGNcxli/4jtD9upm7zO+84Izl6s9z
        1LqjdQDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6q0q-009qQn-ND; Mon, 10 Jan 2022 08:26:44 +0000
Date:   Mon, 10 Jan 2022 00:26:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 04/28] gup: Optimise compound_range_next()
Message-ID: <YdvtxDWN7Dc11ZB5@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:23:42AM +0000, Matthew Wilcox (Oracle) wrote:
> By definition, a compound page has an order >= 1, so the second half
> of the test was redundant.  Also, this cannot be a tail page since
> it's the result of calling compound_head(), so use PageHead() instead
> of PageCompound().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
