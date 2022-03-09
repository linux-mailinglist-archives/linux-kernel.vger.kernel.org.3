Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25864D36EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiCIRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiCIRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:42:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D323D11B5E7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FO5+xpas7mmJlqtkgMhSDzy2xRfLpL1s/4EmDEVYBBY=; b=gHTxTTLrZO7nry0ThJ8sV3V5kQ
        mMtTHkyomBEYx21BwVagBOIN7/E1HMdnXu2zC4/cZuOE1CEDlgOg1P58JylxeViGrrTq9RS2mRhej
        Gbg5srKzIdp5Q1LBySwUfI71eLkvXEekQ84XYplUEeFQLDTBptYGpGJNTQ1aU/bbKbkT6OaYJi2Ud
        8gvu2N0ZfWoOTtU4flBOBwMo+c6Bv25PkKPgo1AWbn3C6L8nM+WsbkOuWfI8JgQynQW4Mq5BRay8y
        /HRI0SfmN9OQtNBVUuWaiol3LwWnRplwSmpBUyf8dHQrhddTqzCpXwoGfQc/RCt4YAX1ec937BA/l
        +zCxxcWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS0Is-00HLxT-2H; Wed, 09 Mar 2022 17:40:50 +0000
Date:   Wed, 9 Mar 2022 17:40:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
Message-ID: <YijmoncSWx/XWkOW@casper.infradead.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <YijL+qwc/Y1kmlnj@casper.infradead.org>
 <d5b7cd5c-73eb-a1cf-5519-5d13fa6e6b00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b7cd5c-73eb-a1cf-5519-5d13fa6e6b00@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:57:51PM +0100, David Hildenbrand wrote:
> Hi,
> 
> On 09.03.22 16:47, Matthew Wilcox wrote:
> > On Tue, Mar 08, 2022 at 03:14:32PM +0100, David Hildenbrand wrote:
> >> The basic question we would like to have a reliable and efficient answer
> >> to is: is this anonymous page exclusive to a single process or might it
> >> be shared?
> > 
> > Is this supposed to be for PAGE_SIZE pages as well, or is it only used
> > on pages > PAGE_SIZE?
> 
> As documented, simple/ordinary PAGE_SIZE pages as well (unfortunately ,
> otherwise we'd have more space :) ).

OK.  Documentation doesn't always capture exactly what the author was
thinking, so I appreciate the clarification ;-)

> > This feels a little _too_ creative to me.  There's now an implicit
> 
> It's making the semantics of PG_slab depend on another bit in the head
> page. I agree, it's not perfect, but it's not *too* crazy. As raised in
> the cover letter, not proud of this, but I didn't really find an
> alternative for the time being.
> 
> > requirement that SL[AOU]B doesn't use the bottom two bits of
> 
> I think only the last bit (0x1)

Yeah, OK, they can use three of the four possible combinations of the
bottom two bits ;-)  Still, it's yet more constraints on use of struct
page, which aren't obvious (and are even upside down for the casual
observer).

> > I have plans to get rid of PageError and PagePrivate, but those are going
> > to be too late for you.  I don't think mappedtodisk has meaning for anon
> > pages, even if they're in the swapcache.  It would need PG_has_hwpoisoned
> 
> Are you sure it's not used if the page is in the swapcache? I have no
> detailed knowledge how file-back swap targets are handled in that
> regard. So fs experience would be highly appreciated :)

I have two arguments here.  One is based on grep:

$ git grep mappedtodisk
fs/proc/page.c: u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,  PG_mappedtodisk);
include/linux/page-flags.h:     PG_mappedtodisk,        /* Has blocks allocated on-disk */
include/linux/page-flags.h:     PG_has_hwpoisoned = PG_mappedtodisk,
include/linux/page-flags.h:PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
include/trace/events/mmflags.h: {1UL << PG_mappedtodisk,        "mappedtodisk"  },              \
include/trace/events/pagemap.h: (folio_test_mappedtodisk(folio) ? PAGEMAP_MAPPEDDISK : 0) | \
mm/migrate.c:   if (folio_test_mappedtodisk(folio))
mm/migrate.c:           folio_set_mappedtodisk(newfolio);
mm/truncate.c:  folio_clear_mappedtodisk(folio);
tools/vm/page-types.c:  [KPF_MAPPEDTODISK]      = "d:mappedtodisk",

$ git grep MappedToDisk
fs/buffer.c:            SetPageMappedToDisk(page);
fs/buffer.c:    if (PageMappedToDisk(page))
fs/buffer.c:            SetPageMappedToDisk(page);
fs/ext4/readpage.c:                     SetPageMappedToDisk(page);
fs/f2fs/data.c:         SetPageMappedToDisk(page);
fs/f2fs/file.c: if (PageMappedToDisk(page))
fs/fuse/dev.c:  ClearPageMappedToDisk(newpage);
fs/mpage.c:             SetPageMappedToDisk(page);
fs/nilfs2/file.c:       if (PageMappedToDisk(page))
fs/nilfs2/file.c:                       SetPageMappedToDisk(page);
fs/nilfs2/page.c:       ClearPageMappedToDisk(page);
fs/nilfs2/page.c:               SetPageMappedToDisk(dpage);
fs/nilfs2/page.c:               ClearPageMappedToDisk(dpage);
fs/nilfs2/page.c:       if (PageMappedToDisk(src) && !PageMappedToDisk(dst))
fs/nilfs2/page.c:               SetPageMappedToDisk(dst);
fs/nilfs2/page.c:       else if (!PageMappedToDisk(src) && PageMappedToDisk(dst))
fs/nilfs2/page.c:               ClearPageMappedToDisk(dst);
fs/nilfs2/page.c:       ClearPageMappedToDisk(page);
include/linux/page-flags.h:PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)

so you can see it's _rarely_ used, and only by specific filesystems.

The swap code actually bypasses the filesystem (except for network
filesystems) and submits BIOs directly (see __swap_writepage() and
swap_readpage()).  There's no check for MappedToDisk, and nowhere to
set it/clear it.

The second argument is that MappedToDisk is used for delayed allocation
on writes for filesystems.  But swap is required to be allocated at
swapfile setup (so that the swap code can bypass the filesystem ...)
and so this flag is useless.

Of course, I may have missed something.  This is complex.

> > to shift to another bit ... but almost any bit will do for has_hwpoisoned.
> > Or have I overlooked something?
> 
> Good question, I assume we could use another bit that's not already
> defined/check on subpages of a compound page.
> 
> 
> Overloading PG_reserved would be an alternative, however, that flag can
> also indicate that the remainder of the memmap might be mostly garbage,
> so it's not that good of a fit IMHO.

I wouldn't reuse PG_reserved for anything.  Although I do have a modest
proposal that I should finish writing up ... let me start on that.

