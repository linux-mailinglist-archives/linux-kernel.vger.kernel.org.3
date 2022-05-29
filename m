Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E15536F37
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiE2Dbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiE2Dba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:31:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83A207
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qyOue3vhI9r64/cB5hJYFTVsL61v9tYIZ/ebY1l6Usk=; b=Ptypr/RmNCnkuOvkKpm4oFUly8
        7rRrFWo0GsMzRV5Z+J7L1JCyAeqB5ATCDQg1+WvGM/JZx7m5IYRwiMNYlQqcoBr5CTJWnlsAI3zPN
        dZ++yUw2Aj3yYCYk5yd7FRuQPYNIkUtxFucRzg1wxbL+GSgxwyDGwDJz+LeBUObZRPwavmW8dXbOM
        oxey5EfzRfR5Md56svvfw12ouZh44fI2tuWwJiem8uF1CUuei3zea43okhgGukFuSrki5m7/IO5gD
        YxNATO2aCmtvHrwAsroAzUP6PxBtYPtQzkVGL1mSbkWkGVBU7sV0KTrlc1DRwnitVfukgT+l31Edv
        EDfCDE2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nv9dz-003M3H-Mw; Sun, 29 May 2022 03:31:07 +0000
Date:   Sun, 29 May 2022 04:31:07 +0100
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
Message-ID: <YpLo+4U8k+OLTmz9@casper.infradead.org>
References: <20220528161157.3934825-1-bh1scw@gmail.com>
 <YpJNX7PN8hAFgVwj@casper.infradead.org>
 <YpLhSokkrPrXjNXP@FVFYT0MHHV2J.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpLhSokkrPrXjNXP@FVFYT0MHHV2J.googleapis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 10:58:18AM +0800, Muchun Song wrote:
> On Sat, May 28, 2022 at 05:27:11PM +0100, Matthew Wilcox wrote:
> > On Sun, May 29, 2022 at 12:11:58AM +0800, bh1scw@gmail.com wrote:
> > > From: Fanjun Kong <bh1scw@gmail.com>
> > > 
> > > This patch will use folio allocation functions for allocating pages.
> > 
> > That's not actually a good idea.  folio_alloc() will do the
> > prep_transhuge_page() step which isn't needed for slab.
> 
> You mean folio_alloc() is dedicated for THP allocation?  It is a little
> surprise to me.  I thought folio_alloc() is just a variant of alloc_page(),
> which returns a folio struct instead of a page.  Seems like I was wrong.
> May I ask what made us decide to do this?

Yeah, the naming isn't great here.  The problem didn't really occur
to me until I saw this patch, and I don't have a good solution yet.
We're in the middle of a transition, but the transition is likely to
take years and I don't think we necessarily have the final form of the
transition fully agreed to or understood, so we should come up with
something better for the transition.

Ignoring the naming here, memory allocated to filesystems can be split,
but the split can fail, so they need the page-deferred-list and the
DTOR.  Memory allocated to slab cannot be split, so initialising the
page-deferred-list is a waste of time.

The end-goal is to split apart allocating the memory from allocating
its memory descriptor (which I like to call memdesc).  So for filesystem
folios, we'd call slab to allocate a struct folio and then tell the
buddy allocator "here is the memdesc of type folio, allocate
me 2^n pages and make pfn_to_memdesc return this memdesc for each of
the 2^n pages in it".

In this end-goal, slab would also allocate a struct slab (... there's
a recursion problem here which has a solution ...), and then allocate
2^n pages.  But until we're ready to shrink struct page down to one
or two words, doing this is just a waste of memory and time.

So I still don't have a good solution to receiving patches like this
other than maybe adding a comment like

	/* Do not change this to allocate a folio */

which will be ignored.
