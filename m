Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954655885F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiHCDSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiHCDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:17:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67932D8E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5RRVQl4J+7WXKkaGNwelJxyZ6SmgqBWySND67zzTwmQ=; b=WbnMhlm0UwFM0Dewke3HjZ/48z
        Uyw4PHUlinyN876MkcaaNskBIdOLY5gBEWAgtMEZX4bw08pW2pwYF3N4Gkb/wqWdZWdyU6XxTcN1v
        5Jm0I8ugS09D623Lyt6uQGql+5w2Tb9zcYuI8CxpCH0SVHv0Ov8HlEQZlJpg0wXkQG3hs6vJpn+Dn
        pVli00qM/OOk4O3RE2yjPduiQol2d4DTz7scKAlkcc3bLwICr7I3gx4iI3uuci0l3Pg040ZlqyZiq
        1EDgTHuEJOwSiYiMwntBqRRZDcn76Ib8sU34kA5Pa/7jwTadOeXWsvBxMO4D2hLluXDBCdKYGhias
        JUcoBCGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJ4tK-008vai-QL; Wed, 03 Aug 2022 03:17:50 +0000
Date:   Wed, 3 Aug 2022 04:17:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: Update folio if shmem_replace_page() updates the
 page
Message-ID: <Yuno3hVxk+rOheVs@casper.infradead.org>
References: <20220730042518.1264767-1-willy@infradead.org>
 <20220802174637.3bd3478d137b52ef3b67c3b3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802174637.3bd3478d137b52ef3b67c3b3@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:46:37PM -0700, Andrew Morton wrote:
> On Sat, 30 Jul 2022 05:25:18 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > If we allocate a new page, we need to make sure that our folio matches
> > that new page.  This will be solved by changing shmem_replace_page()
> > to shmem_replace_folio(), but this is the minimal fix.
> > 
> > ...
> >
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1771,6 +1771,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >  
> >  	if (shmem_should_replace_folio(folio, gfp)) {
> >  		error = shmem_replace_page(&page, gfp, info, index);
> > +		folio = page_folio(page);
> >  		if (error)
> >  			goto failed;
> >  	}
> 
> What are the user-visible runtime effects of the bug?
> 
> Should we backport this into 5.19.X?

Definitely should be backported.  The next line not visible in this
patch context says:

        error = shmem_add_to_page_cache(folio, mapping, index,
                                        swp_to_radix_entry(swap), gfp,
                                        charge_mm);

so if we do end up in this path, we store the wrong page in the
shmem inode's page cache, and I would rather imagine that data
corruption ensues.
