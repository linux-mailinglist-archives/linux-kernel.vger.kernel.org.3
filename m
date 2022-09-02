Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A95AB8B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIBTJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIBTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:09:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4608F5487
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rt1IDSAN9BZj4OEF4fsbjLaelycXAqdJZzz/2U/Ag+w=; b=ESSENRcRRT17uYUWzdUXATM1ct
        L9Y6WhP9Yro8ie1M8YOVqJBE59nZSquxxxGMIvTCAy3zq8OWTZAiBOOY3ZYR5zoi6y1SXRD3aFk3e
        tlpdeQgK1xWwkXVogHH863mExAoCL12QWyb89/ytRuHPUBQdcG/qw2izLl73Kx7e0kmNMA/DpmXtm
        2il6oiVaXffbeF8WEWfIvOBhSX7QAPD64dUsXlbwCM54e0mSpw9/rBmpEtiHX+nW0l3fRViUwR0iH
        /NYD5IxuDOno0d33/Cz7xlBS8v6qVLIkYWvDCJROj7RvmTNjGAkOm1/21XASJ88hN8gDCPot5a/Vq
        crbazAvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUC28-007HGB-Ak; Fri, 02 Sep 2022 19:08:52 +0000
Date:   Fri, 2 Sep 2022 20:08:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [Resend RFC PATCH] mm: introduce __GFP_TRACKLEAK to track
 in-kernel allocation
Message-ID: <YxJUxDn5v2MqmjKM@casper.infradead.org>
References: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20220902115839.1e3fafd159e42d4e7dae90af@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902115839.1e3fafd159e42d4e7dae90af@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:58:39AM -0700, Andrew Morton wrote:
> Cc willy for page-flags changes.

Thanks.  This is probably OK.  The biggest problem is that it won't
work for drivers which allocate memory and then map it to userspace.
If they try, they'll get a nice splat, but it may limit the usefulness
of this option.  We should probably document that limitation in this
patch.

> On Fri, 2 Sep 2022 18:59:07 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
> > +++ b/mm/page_alloc.c
> > @@ -1361,6 +1361,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >  		page->mapping = NULL;
> >  	if (memcg_kmem_enabled() && PageMemcgKmem(page))
> >  		__memcg_kmem_uncharge_page(page, order);
> > +	if (PageTrackleak(page))
> > +		kmemleak_free(page);

Don't we also need to __ClearPageTrackleak()?

> > +	if (gfp & __GFP_TRACKLEAK) {
> 
> And we'd want __GFP_TRACKLEAK to evaluate to zero at compile time if
> CONFIG_HAVE_DEBUG_KMEMLEAK=n.
> 
> > +		kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, gfp & ~__GFP_TRACKLEAK);
> > +		__SetPageTrackleak(page);
> > +	}

We only set this on the first page we allocate.  I think there's a
problem for multi-page, non-compound allocations, no?  Particularly
when you consider the problem fixed in e320d3012d25.

I'm not opposed to this tracking, it just needs a bit more thought and
awareness of some of the corner cases of the VM.  A few test cases would
be nice; they could demonstrate that this works for both compound and
non-compound high-order allocations.
