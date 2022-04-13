Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E954FF715
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiDMMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDMMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:51:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4B45AC5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RGbYhpXywzqv2Hlc31WFYOQppwWEQngmyLOiz4SPLMc=; b=o/CdrJdGaOo/+UkTwXEgHYmTJ5
        TVDAF0tewzHLjCwR6q5XktVPi6We1u9p2XdJdoEWxcJXOUD6QlalIPEHhsY4pFuo1I4Oqu9+w/0L6
        V/ijAASP/ARnuJDM9SbL3HymUp+TUOx4vwezAmiO810NhKDdC7dJdWBl+d8JmEKxTFyOQ4lOcHRXr
        DUbbSHtl7FuohRtOQiEuaS5GhB+CmKXTKAryFnwf8rK84K5hSe03bQl+XI2BbAPaxUyUFl24kVmow
        vEa4bVOlYg8AoYVAu274c8U5DjhowWcVgGl4DY77ae/2Ez54zo9nfeoXx97v7R9tCAQ/fnVPhQugF
        xuTmCaTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1necQV-00EGJp-Iq; Wed, 13 Apr 2022 12:48:51 +0000
Date:   Wed, 13 Apr 2022 13:48:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3 08/16] mm/rmap: drop "compound" parameter from
 page_add_new_anon_rmap()
Message-ID: <YlbGswXaIRblKN9j@casper.infradead.org>
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-9-david@redhat.com>
 <4cb92b41-95e1-1666-321e-96ff9e6095bb@suse.cz>
 <368902ab-8d3f-5d62-581e-1ff930bcefa0@redhat.com>
 <YlbBXiVezzVw+NZZ@casper.infradead.org>
 <0c9d2c39-5080-a855-8ecd-e2c1bd1179fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9d2c39-5080-a855-8ecd-e2c1bd1179fa@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 02:28:38PM +0200, David Hildenbrand wrote:
> On 13.04.22 14:26, Matthew Wilcox wrote:
> > On Tue, Apr 12, 2022 at 11:37:09AM +0200, David Hildenbrand wrote:
> >> On 12.04.22 10:47, Vlastimil Babka wrote:
> >>> There's a VM_BUG_ON_PAGE(PageTransCompound(page), page); later in a
> >>> !compound branch. Since compound is now determined by the same check, could
> >>> be deleted.
> >>
> >> Yes, eventually we could get rid of both VM_BUG_ON_PAGE() on both
> >> branches and add a single VM_BUG_ON_PAGE(PageTail(page), page) check on
> >> the compound branch. (we could also make sure that we're not given a
> >> hugetlb page)
> > 
> > As a rule of thumb, if you find yourself wanting to add
> > VM_BUG_ON_PAGE(PageTail(page), page), you probably want to change the
> > interface to take a folio.
> 
> Yeah, I had the same in mind. Might be a reasonable addon on top --
> although it would stick out in the rmap code a bit because most
> functions deal with both, folios and subpages.

I have the start of a series which starts looking at the fault path
to see where it makes sense to use folios and where it makes sense to
use pages.

We're (generally) faulting on a PTE, so we need the precise page to
be returned in vmf->page.  However vmf->cow_page can/should be a
folio (because it's definitely not a tail page).  That trickles
down into copy_present_page() (new_page and prealloc both become folios)
and so page_add_new_anon_rmap() then looks like a good target to
take a folio.

The finish_fault() -> do_set_pte() -> page_add_new_anon_rmap() looks
like the only kind of strange place where we don't necessarily have a
folio (all the others we just allocated it).
