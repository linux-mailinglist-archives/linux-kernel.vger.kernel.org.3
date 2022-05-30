Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689E853732C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 02:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiE3Azl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiE3Azj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 20:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBADE4D9FD
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 17:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WYOLX8HovA/BSABYfgTLym5uG30L/Fgf5B8DvAQCglM=; b=n5o4AXUoeoibvMO9u8F1b5yvw7
        TTLeNItWqJ56F6zta27N7u0ANmjcGNabXIBDLpQLCWrA3jYk0U68XL0JoSfPsOvHha0gRYNWra33x
        wjyasGcb4ACtDISXoJ1twG6+MwFsGQY2n0bQgPR5vE26VqRZ8bRp3hcXrkztb5LI3ENBDrNTzwRbA
        ZjF+MYSa3mbHiEUl1LPTRiolvqr2n28FTEWACfz/0HmutNHE9Nk+asWElTT0jDgSUyxFTTAxqStXn
        0O7kfc0mW67T3+JFNyTPgeIW0qIKciljthZ5yRKyxHK2mhHPAZLPLfDqTCTsY/rLQICTbLbQ3oicD
        32Av8IkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvTgg-0042qA-Mf; Mon, 30 May 2022 00:55:14 +0000
Date:   Mon, 30 May 2022 01:55:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     bh1scw@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: replace alloc_pages with folio_alloc
Message-ID: <YpQV8pojPMQkKmFi@casper.infradead.org>
References: <20220528161157.3934825-1-bh1scw@gmail.com>
 <YpJNX7PN8hAFgVwj@casper.infradead.org>
 <YpLhSokkrPrXjNXP@FVFYT0MHHV2J.googleapis.com>
 <YpLo+4U8k+OLTmz9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpLo+4U8k+OLTmz9@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 04:31:07AM +0100, Matthew Wilcox wrote:
> On Sun, May 29, 2022 at 10:58:18AM +0800, Muchun Song wrote:
> > On Sat, May 28, 2022 at 05:27:11PM +0100, Matthew Wilcox wrote:
> > > On Sun, May 29, 2022 at 12:11:58AM +0800, bh1scw@gmail.com wrote:
> > > > From: Fanjun Kong <bh1scw@gmail.com>
> > > > 
> > > > This patch will use folio allocation functions for allocating pages.
> > > 
> > > That's not actually a good idea.  folio_alloc() will do the
> > > prep_transhuge_page() step which isn't needed for slab.
> > 
> > You mean folio_alloc() is dedicated for THP allocation?  It is a little
> > surprise to me.  I thought folio_alloc() is just a variant of alloc_page(),
> > which returns a folio struct instead of a page.  Seems like I was wrong.
> > May I ask what made us decide to do this?
> 
> Yeah, the naming isn't great here.  The problem didn't really occur
> to me until I saw this patch, and I don't have a good solution yet.

OK, I have an idea.

None of the sl*b allocators use the page refcount.  So the
atomic operations on it are just a waste of time.  If we add an
alloc_unref_page() to match our free_unref_page(), that'll be enough
difference to stop pepole sending "helpful" patches.  Also, it'll be a
(small?) performance improvement for slab.
