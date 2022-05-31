Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2ED53985A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbiEaU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiEaU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:57:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF29B17E2F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jxv6pa/GQSvNspZCbrfqVAPKMjO/mPFnzXscylfgbAw=; b=ql3efslw7Ia1xKIacf3yZct019
        tWQSyiDcbYExYtkrvkvc9aYYRg5v0VA3S8Y6TekuIzYrdaezcfVYyEJb8x9W6pNfJHkVZfl0VnjWk
        9v6xHV/KR70ot7xsv1H5ux0522tqTkf1CUeC78AC6gCeve5UCOJPK45R20TbKRzPuUY7kXKwhm5OZ
        AJF54GbokyCadkn51eHtPNU9/6AUG0DGthYpJWjce0bd36JujLU/KBRfbVptrC+L69zXZYPFrsYhG
        m4pJ9Dz0s+FVW8TokGQlsxLdsi2GFKaYAifNleEQnBAevnt7IE0ygpuOmdGVh7kJGyjn2Jw1csmfz
        +QRTApbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw8ur-005h3L-7m; Tue, 31 May 2022 20:56:37 +0000
Date:   Tue, 31 May 2022 21:56:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] squashfs: implement readahead
Message-ID: <YpaBBXEEtv4ZjFMA@casper.infradead.org>
References: <20220523065909.883444-1-hsinyi@chromium.org>
 <20220523065909.883444-4-hsinyi@chromium.org>
 <20220531134740.91ae4dcea1e06640ba1bfc12@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531134740.91ae4dcea1e06640ba1bfc12@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 01:47:40PM -0700, Andrew Morton wrote:
> > +	for (;;) {
> > +		nr_pages = __readahead_batch(ractl, pages, max_pages);
> > +		if (!nr_pages)
> > +			break;
> > +
> > +		if (readahead_pos(ractl) >= i_size_read(inode) ||
> > +		    nr_pages < max_pages)
> > +			goto skip_pages;
> > +
> > +		index = pages[0]->index >> shift;
> > +		if ((pages[nr_pages - 1]->index >> shift) != index)
> > +			goto skip_pages;
> > +
> > +		expected = index == file_end ?
> > +			   (i_size_read(inode) & (msblk->block_size - 1)) :
> > +			    msblk->block_size;
> > +
> > +		bsize = read_blocklist(inode, index, &block);
> > +		if (bsize == 0)
> > +			goto skip_pages;
> > +
> > +		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> > +					 actor);
> > +
> > +		if (res == expected) {
> > +			/* Last page may have trailing bytes not filled */
> > +			bytes = res % PAGE_SIZE;
> > +			if (bytes) {
> > +				pageaddr = kmap_atomic(pages[nr_pages - 1]);
> > +				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> > +				kunmap_atomic(pageaddr);
> > +			}
> > +
> > +			for (i = 0; i < nr_pages; i++)
> > +				SetPageUptodate(pages[i]);
> > +		}
> 
> res == -EIO is unhandled?

No it isn't ... this is readahead, which means there's nobody to care
about the error.  The pages are left !Uptodate, which means that they'll
be retried with a call to ->read_folio later.  At that point, somebody
actually wants the data in those pages, and they'll see the error.

