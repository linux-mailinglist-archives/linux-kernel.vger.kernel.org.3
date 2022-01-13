Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92E348D110
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiAMDsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiAMDr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:47:58 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDEC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:47:57 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id g2so5864500qkp.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rc1Ly7Pd8061A8nyWPTpaP5j7vWx/PTFMzfDrwzJ5nM=;
        b=LJo9IRat2r6gVPTDNHI+RfsNshBpwjyutSW9EbDC5tIg+PRrEvbqS09lRV28AcsNsx
         5N6fbnv5MdnX3CdtkMT9+R5g7k1rrLGlYMsgbFmBPk12ykgMfkF3rqVHw9moZKsFw0EL
         xqdbnOzetaHjsk2Wgcxa1cN0AzfkxYUcd2So2vDWs5F1RnLpxG3rHDFrbs5jRz62iYqx
         r3Pb4CqYUfAWJwzESaX7IeWXNYVs1hdYJXHHSlrclnTIjOPnhdCfGTqQHcyGhLJMDlsY
         PhGFAroru5oHvK2v31r9B8u2RJbAZVAtPk8qkFZCUf/25TyjFXGG/cT6FpLEp1HmTo/r
         8cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rc1Ly7Pd8061A8nyWPTpaP5j7vWx/PTFMzfDrwzJ5nM=;
        b=5H0u1ZxZA5q7yfupoVWSqkjqz3cAcSgNc9LBR8JuADkKp5yhFHHM04dURSMgNAKcte
         qIR9gbItLobctQZqA3VeKTypnEmtIGkB653WrZNVQffBfDJ3bxkDGiqunypcOrfsYyuO
         M79jKd3HgBih+i4gqptkoUNHFQy+nh83533Kd2TO/qZX7K6ezXIYjCZ1dg4N5xDSLJRe
         r1DvluKXsptjllF5b7vmTuwh0CJiLh8UicvNJ2qA41MK6RAyS52FjLrUPAGXrztGcSr9
         5Y+pY7o+Ze3RD+xrx2Z14XdkAe4HNi8QVBOLNthlCW53sJ+c4Weqc+63djuMqtT9bcEG
         eziA==
X-Gm-Message-State: AOAM532PLJZDdGplz/egeKqonSTtkd4scaaz9kXMd8LFhAHavEFK01xb
        e48sNtPCft9wwkBIi8gWW7t+6dhku0KunA==
X-Google-Smtp-Source: ABdhPJyeFZIflD9rELkDbSsYH9BBvtGU6DHBrpQAltIfLBueFXQPjq2ImC9V4gG+x0q8dqkp8Sj8lQ==
X-Received: by 2002:a05:620a:2955:: with SMTP id n21mr1939048qkp.285.1642045676710;
        Wed, 12 Jan 2022 19:47:56 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d77sm1093898qkg.55.2022.01.12.19.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 19:47:56 -0800 (PST)
Date:   Wed, 12 Jan 2022 19:47:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
In-Reply-To: <Yd7W6ndSPkXQjurY@xz-m1.local>
Message-ID: <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
References: <20211115134951.85286-1-peterx@redhat.com> <20211115134951.85286-2-peterx@redhat.com> <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com> <Yd7VEXI+/Lu8MVOo@xz-m1.local> <Yd7W6ndSPkXQjurY@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022, Peter Xu wrote:
> On Wed, Jan 12, 2022 at 09:18:09PM +0800, Peter Xu wrote:
> > On Sat, Jan 08, 2022 at 05:19:04PM -0800, Hugh Dickins wrote:
> > > On Mon, 15 Nov 2021, Peter Xu wrote:
> > > 
> > > You are absolutely right to clean this up and fix the bugs that
> > > have crept in, but I think the patch itself is not quite right yet.
> > 
> > Do you mean the pmd path on checking mapping?

Sorry, no, I don't mean that at all. We agree that we cannot see an actual
bug there, so nothing to fix; and re-exporting all the zap_details stuff
to make it available to mm/huge_memory.c would be rather sad.  You might
wish to do some future-proofing, but let's just leave that to the future.

I mean that the handling of swap-like entries in zap_pte_range(), after
you've removed the "if (unlikely(details)) continue;", is not right yet.

> > If so I agree, and I'll add that
> > in v2 (even if as you pointed out that shouldn't be a real bug, iiuc, as you
> > analyzed below).
> > 
> > Let me know if I missed anything else..

> > What I can do, though, is if with below patch applied to current linux master:
> > 
> > =============
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 8f1de811a1dc..51fe02a22ea9 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1383,8 +1383,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                 }
> >  
> >                 /* If details->check_mapping, we leave swap entries. */
> > -               if (unlikely(details))
> > +               if (unlikely(details)) {
> > +                       WARN_ON_ONCE(is_migration_entry(entry));
> >                         continue;
> > +               }
> >  
> >                 if (!non_swap_entry(entry))
> >                         rss[MM_SWAPENTS]--;
> > =============
> > 
> > Then I can easily trigger it if with the help of a test program attached
> > (zap-migrate.c).
> 
> (Attaching for real; also copy Matthew)

Yes, I'm not at all surprised that you can see migration entries there.

> 
> > 
> > IMHO it won't really reproduce because it seems all relevant shmem operations
> > (e.g. hole punch, unmap..) will take the page lock so it won't really race with
> > migration (which needs the page lock too), as mentioned in previous cover
> > letters when I was still working on the old versions of this.  But it could be
> > possible that I missed something.

The latter.

There may still be some cases in which unmap_mapping_range() is called
on a single page with that page held locked, I have not checked; but in
general it is called on a range of pages, and would not have them locked.

The usual pattern when truncating/hole-punching/invalidating is to call
unmap_mapping_range() first, to do the bulk of the work efficiently,
scanning down the page tables without holding any page lock; but then
unmap racily faulted stragglers one by one while holding page lock
using unmap_mapping_page() just before deleting each from page cache.

So some relevant operations are done without page lock and some relevant
operations are done with page lock: both need to be considered, but you
are right that the page-locked ones will not encounter a migration entry
of that page (I haven't tried to see if that fact is useful here or not).

You may need to substitute "pages" or "page" or "folio" in the above.

> > 
> > While the WARN_ON_ONCE() can trigger only because of the fast path in hole
> > punching we have the pre-unmap without lock:
> > 
> > 		if ((u64)unmap_end > (u64)unmap_start)
> > 			unmap_mapping_range(mapping, unmap_start,
> > 					    1 + unmap_end - unmap_start, 0);
> > 		shmem_truncate_range(inode, offset, offset + len - 1);

Oh, I should have read on, I've been wasting my time explaining above:
there you said the page must be locked, here you find that is not so.

> > 
> > But that will be fixed up right afterwards in shmem_truncate_range(), afaict,
> > which is with-lock.  Hence we have a small window to at least trigger the
> > warning above, even if it won't really mess up the accounting finally.

Well, there is still an opportunity to do the wrong thing.

> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  			continue;
> > > >  		}
> > > >  
> > > > -		/* If details->check_mapping, we leave swap entries. */
> > > > -		if (unlikely(details))
> > > > -			continue;
> > > > -
> > > 
> > > Good.
> > > 
> > > >  		if (!non_swap_entry(entry))
> > > >  			rss[MM_SWAPENTS]--;

Right, I did not say at all what is wrong here, I suppose I intended
to come back but then got tired - sorry.  Here we are dealing with a
genuine swap entry.  No problem for exit or munmap or MADV_DONTNEED.
No problem for truncation (but apparently there has been an unnoticed
problem, that swapped-out COWed pages beyond the truncation point were
not being deleted, while that "details continue" was still there).  But
a problem for hole-punching: without the "details continue", this will
go on to delete COWed pages which ought to be preserved - needs a
should_zap_page() check, as you do with the migration entry.

Except that here we have no page to check, so it looks like you'll
have to change should_zap_page() to deal with this case too, or just
check details->check_mapping directly.  Which raises the question again
of why I did not just use a boolean flag there originally: aah, I think
I've found why.  In those days there was a horrible "optimization", for
better performance on some benchmark I guess, which when you read from
/dev/zero into a private mapping, would map the zero page there (look
up read_zero_pagealigned() and zeromap_page_range() if you dare).  So
there was another category of page to be skipped along with the anon
COWs, and I didn't want multiple tests in the zap loop, so checking
check_mapping against page->mapping did both.  I think nowadays you
could do it by checking for PageAnon page (or genuine swap entry)
instead.

> > > >  		else if (is_migration_entry(entry)) {
> > > >  			struct page *page;
> > > >  
> > > >  			page = pfn_swap_entry_to_page(entry);
> > > > +			if (unlikely(zap_skip_check_mapping(details, page)))
> > > > +				continue;
> > > 
> > > Good; though I don't think it's worth an "unlikely", and I say again,
> > 
> > Sure, I'll drop this "unlikely".  Meanwhile, shall we drop all the rest of the
> > "unlikely" too around this check?
> > 
> > > more forcefully, that "zap_skip_check_mapping" is a terrible name.
> > > 
> > > David suggested naming its inversion should_zap_page(), yes, that's
> > > much better; I'd toyed with do_not_zap_page() and zap_skip_page(),
> > > but should_zap_page() for the inversion sounds good to me.
> > 
> > Ah sure, I'll rename it to should_zap_page() in a new patch before this.

Thanks; though now even that name is looking dubious - should_zap_entry()?

> > 
> > > 
> > > And I'm pleased to see in one of Matthew's diffs that he intends to
> > > bring zap_details and zap_skip_check_mapping() back into mm/memory.c
> > > from include/linux/mm.h.
> > 
> > Yeah it's only used in memory.c.  I put it there initially because I wanted
> > zap_details user can reference what's that check mapping is all about, but
> > maybe that's not necessary.
> > 
> > If you or Matthew could provide a link to that patch, I'll be happy to pick
> > that up too with this series.  Or I can also do nothing assuming Matthew will
> > handle it elsewhere.

In Linus's tree today: 3506659e18a6 ("mm: Add unmap_mapping_folio()").

> > 
> > > 
> > > >  			rss[mm_counter(page)]--;
> > > >  		}

I have given no thought as to whether more "else"s are needed there.

> > > >  		if (unlikely(!free_swap_and_cache(entry)))

(I think you moved that to a more relevant place in a later patch: good.)

I know you're also asking for test suggestions, but I'll leave it to you:
hole-punching, truncation, swapping, compaction (to force migration).

Hugh
