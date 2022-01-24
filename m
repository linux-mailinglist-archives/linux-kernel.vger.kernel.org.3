Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356DD4978EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbiAXG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiAXG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:29:44 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8077C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:29:43 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so3462667otv.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=B2uFyMejB1yOP4/0GRXYCGRAH5qDTQQFmDA8xH3ykfE=;
        b=Av7yO+gSGKNn5wHpvowmC6CZi8MbKnGdWJTQ3PMjg8GYcdZnay+G8+A8rNeZX3f9+/
         VkZv6ZNdcSgoHXOZPN6l0+FynMXepSpnT2tV6/9lhWsh2CUlrSi0EevRBD+25g7QBtQE
         qNZtbVSv7IxuScWXrsoHE4zUZpY2vbsRmiIdv3QtcK2TI8hpQ3ktJl+YKooQvs7Kp7AQ
         Z7+n/MvXU0CivAuljbuJvYnp79zGR0XwWwfGwyTm1YddQ5NPryDHqEm3BqhMOl/EsD55
         PvKcfRlWNuuEwyKOziXYKLzYt2f/Jx/B4hrV38kbrDDk6AKR7kVazjyxRqEFHh33j3pe
         QzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=B2uFyMejB1yOP4/0GRXYCGRAH5qDTQQFmDA8xH3ykfE=;
        b=yAn1qGDO9V4cuH58og7U4wtAEoXJ2MrmzQ3hoOiEDnCIXwZ/4U8jBsFzR8+EHGRo1R
         oFa9XwT6l2hPWT7pz9o/NxvKZ4HFnPhL+iwQ71PGqVHuAuiDC82rR6FkgGYNBID02Tb9
         NwO8OHk9nLQj3724GwsIBhJHNxftrddvv7y1Ur3wOWIcrqCsUlVHMyOCdao9p6mGJgYa
         8Jb1wgeVBho5826/8/BpytokWP5FBxzbjwgJpB5Sd5+H0U66qu/1gk6iJs0YweHXGzai
         NKhn4WPwBLtE6HZp5gZYG+/lVAVTVHd2g5hKKdAgZ7COS9jmnBZ/dmQ1+D5/yO+EAfsY
         5+0g==
X-Gm-Message-State: AOAM531QeQGzbbef8ABWZ81OhP/dToJ05vRiO/3S9ytaaYak3cVmtcDE
        QsA2NXwmefS4Z7tdg9CwN+eBDg==
X-Google-Smtp-Source: ABdhPJwjV1j45PAORG9asAhfjB2Q/bKK4Ebq9CgtwQvsx7rIshP6hxv4kfa/gG9w7ePyJFbZCYKNQA==
X-Received: by 2002:a05:6830:2681:: with SMTP id l1mr10620618otu.380.1643005782449;
        Sun, 23 Jan 2022 22:29:42 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y64sm4894639oig.54.2022.01.23.22.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 22:29:41 -0800 (PST)
Date:   Sun, 23 Jan 2022 22:29:40 -0800 (PST)
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
In-Reply-To: <Yek6PaW8fAXY4Bft@xz-m1.local>
Message-ID: <93dd745c-5e8b-a50-4ec5-b3f3728ad8b@google.com>
References: <20211115134951.85286-1-peterx@redhat.com> <20211115134951.85286-2-peterx@redhat.com> <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com> <Yd7VEXI+/Lu8MVOo@xz-m1.local> <Yd7W6ndSPkXQjurY@xz-m1.local> <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022, Peter Xu wrote:

> Hi, Hugh,
> 
> On Wed, Jan 12, 2022 at 07:47:40PM -0800, Hugh Dickins wrote:
> > > > IMHO it won't really reproduce because it seems all relevant shmem operations
> > > > (e.g. hole punch, unmap..) will take the page lock so it won't really race with
> > > > migration (which needs the page lock too), as mentioned in previous cover
> > > > letters when I was still working on the old versions of this.  But it could be
> > > > possible that I missed something.
> > 
> > The latter.
> > 
> > There may still be some cases in which unmap_mapping_range() is called
> > on a single page with that page held locked, I have not checked; but in
> > general it is called on a range of pages, and would not have them locked.
> > 
> > The usual pattern when truncating/hole-punching/invalidating is to call
> > unmap_mapping_range() first, to do the bulk of the work efficiently,
> > scanning down the page tables without holding any page lock; but then
> > unmap racily faulted stragglers one by one while holding page lock
> > using unmap_mapping_page() just before deleting each from page cache.
> > 
> > So some relevant operations are done without page lock and some relevant
> > operations are done with page lock: both need to be considered, but you
> > are right that the page-locked ones will not encounter a migration entry
> > of that page (I haven't tried to see if that fact is useful here or not).
> > 
> > You may need to substitute "pages" or "page" or "folio" in the above.
> > 
> > > > 
> > > > While the WARN_ON_ONCE() can trigger only because of the fast path in hole
> > > > punching we have the pre-unmap without lock:
> > > > 
> > > > 		if ((u64)unmap_end > (u64)unmap_start)
> > > > 			unmap_mapping_range(mapping, unmap_start,
> > > > 					    1 + unmap_end - unmap_start, 0);
> > > > 		shmem_truncate_range(inode, offset, offset + len - 1);
> > 
> > Oh, I should have read on, I've been wasting my time explaining above:
> > there you said the page must be locked, here you find that is not so.
> > 
> > > > 
> > > > But that will be fixed up right afterwards in shmem_truncate_range(), afaict,
> > > > which is with-lock.  Hence we have a small window to at least trigger the
> > > > warning above, even if it won't really mess up the accounting finally.
> > 
> > Well, there is still an opportunity to do the wrong thing.
> 
> So what I wanted to express is we can't trigger any real issue, so no way to
> write a valid reproducer even if we know it did it wrong..  And that's why I
> provided a "fake" one..
> 
> Let me explain a little bit further.  Sorry I know you know most of below, so
> it could be that you spend 5 minutes reading nonsense..  but I want to 100%
> sure we're on the same page.
> 
> Firstly, current code will have a problem if we:
> 
>   (1) Passed over a valid "zap_details" pointer to zap_pte_range, and,
>   (2) At the meantime if there can be a swap entry of any kind of below:
>         (2.1) real swap entry
>         (2.2) migration swap entry
> 
> Then we got doomed because we could have errornously skipped some swap entry
> that was also under the mapping while we shouldn't.
> 
> I didn't mention device exclusive/private entries are fine because they're
> checked before the "details continue" check.
> 
> I didn't mention hwpoison entry too; but I'll discuss it later..
> 
> Then, when do we have cases above (1) or (2)?
> 
> (1) is impossible because when there's zap_details in current code it means the
> page is backing a fs mapping, hence not PageAnon.  We can only hit (2).

No: a MAP_PRIVATE fs mapping has a PageAnon page wherever CopyOnWrite
has been done.

> 
> What can hit (2)?  I only know shmem...

No: I cannot see any special case for shmem versus file versus anon in
try_to_migrate_one().

> 
> Next, as a conclusion, what we want to reproduce is: some caller calls
> zap_pte_range() with zap_details, but accidentally there's a migration entry.
> 
> It's fairly easy to find this, as what my "fake" reproducer was doing.
> 
> However, as I stated before, all these use cases always have another step to
> take the lock and redo the range.  Then even if some migration entry got
> wrongly skipped it'll always be fixed.  What we need to find is some caller
> that calls zap_pte_range() without later taking the page lock and redo that.
> That's the only possibility to trigger a real issue on the shmem accounting.

I agree that the fallback "if (folio_mapped() unmap_mapping_folio()",
while holding folio lock, ensures that there cannot be a migration entry
substituted for present pte at that time, so no problem if migration entry
was wrongly skipped on the earlier unlocked pass.

But you're forgetting the complementary mistake: that the earlier unlocked
pass might have zapped a migration entry (corresponding to an anon COWed
page) when it should have skipped it (while punching a hole).

> 
> To prove this, let's see all the possible call stacks...
> 
> zap_pte_range() will only be called with zap_details pointer with below two
> functions: 
> 
>         unmap_mapping_folio
>         unmap_mapping_pages
> 
> unmap_mapping_folio is already having the page lock so it's not going to work.
> Then the callers of unmap_mapping_pages are:
> 
>     unmap_mapping_pages
>         [1] collapse_file
>         [?] unmap_mapping_range
>                 [?] unmap_shared_mapping_range
>                         [?] vmw_bo_dirty_unmap (gpu/drm)
>                         [?] inode_go_sync (gfs2)
>                 [1] shmem_setattr
>                 [1] shmem_fallocate
>                 [1] truncate_pagecache
>                 [1] truncate_pagecache_range
>         [1] invalidate_inode_pages2_range
> 
> It's a reversed tree of call stacks, when I marked [1] means this call site
> does the "unmap then take page lock and redo" thing, so it can't reproduce.
> 
> The only outliers are:
> 
>         [?] vmw_bo_dirty_unmap (gpu/drm)
>         [?] inode_go_sync (gfs2)
> 
> Which I marked with [?].
> 
> However I don't think they'll have migration entries at all, or am I wrong?

To be honest, I have not made the effort to understand your point there,
since I already suggested above that three of your assumptions are wrong.
But I think we should presume that the upper levels have chosen the right
setting for even_cows, and zap_pte_range() just needs to respect it.

> 
> I hope I explained why I think we can't write a reproducer.. but I still think
> we should fix the problem, because we can't tell whether it'll go wrong in the
> future with a new caller who will not take the page lock to redo the zap.
> 
> > 
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > >  			continue;
> > > > > >  		}
> > > > > >  
> > > > > > -		/* If details->check_mapping, we leave swap entries. */
> > > > > > -		if (unlikely(details))
> > > > > > -			continue;
> > > > > > -
> > > > > 
> > > > > Good.
> > > > > 
> > > > > >  		if (!non_swap_entry(entry))
> > > > > >  			rss[MM_SWAPENTS]--;
> > 
> > Right, I did not say at all what is wrong here, I suppose I intended
> > to come back but then got tired - sorry.  Here we are dealing with a
> > genuine swap entry.  No problem for exit or munmap or MADV_DONTNEED.
> > No problem for truncation (but apparently there has been an unnoticed
> > problem, that swapped-out COWed pages beyond the truncation point were
> > not being deleted, while that "details continue" was still there).  But
> > a problem for hole-punching: without the "details continue", this will
> > go on to delete COWed pages which ought to be preserved - needs a
> > should_zap_page() check, as you do with the migration entry.
> 
> I see, thanks for pointing out.
> 
> > 
> > Except that here we have no page to check, so it looks like you'll
> > have to change should_zap_page() to deal with this case too, or just
> > check details->check_mapping directly.
> 
> Yeah I prefer this, as we don't have the page* pointer anyway.
> 
> > Which raises the question again
> > of why I did not just use a boolean flag there originally: aah, I think
> > I've found why.  In those days there was a horrible "optimization", for
> > better performance on some benchmark I guess, which when you read from
> > /dev/zero into a private mapping, would map the zero page there (look
> > up read_zero_pagealigned() and zeromap_page_range() if you dare).  So
> > there was another category of page to be skipped along with the anon
> > COWs, and I didn't want multiple tests in the zap loop, so checking
> > check_mapping against page->mapping did both.  I think nowadays you
> > could do it by checking for PageAnon page (or genuine swap entry)
> > instead.
> 
> It must be PageAnon already, isn't it?

I did not understand what you were asking there; but in your followup
mail, I think you came to understand what I meant better.  Yes, I
believe you could safely replace struct address_space *zap_mapping
by a more understandable boolean (skip_cows? its inverse would be
easier to understand, but we don't want almost everyone to have to
pass a zap_details initialized to true there).

> 
> > 
> > > > > >  		else if (is_migration_entry(entry)) {
> > > > > >  			struct page *page;
> > > > > >  
> > > > > >  			page = pfn_swap_entry_to_page(entry);
> > > > > > +			if (unlikely(zap_skip_check_mapping(details, page)))
> > > > > > +				continue;
> > > > > 
> > > > > Good; though I don't think it's worth an "unlikely", and I say again,
> > > > 
> > > > Sure, I'll drop this "unlikely".  Meanwhile, shall we drop all the rest of the
> > > > "unlikely" too around this check?
> > > > 
> > > > > more forcefully, that "zap_skip_check_mapping" is a terrible name.
> > > > > 
> > > > > David suggested naming its inversion should_zap_page(), yes, that's
> > > > > much better; I'd toyed with do_not_zap_page() and zap_skip_page(),
> > > > > but should_zap_page() for the inversion sounds good to me.
> > > > 
> > > > Ah sure, I'll rename it to should_zap_page() in a new patch before this.
> > 
> > Thanks; though now even that name is looking dubious - should_zap_entry()?
> 
> I guess my plan is simply keep should_zap_page() and check explicitly for real
> swap entries.

I won't know whether that's right or not until seeing the actual patch.
The important thing to keep in mind is that the treatment of a
migration entry needs to match the nature of the page it is migrating:
if skip_cows, then the migration entry of a PageAnon should be skipped
not zapped, just as a PageAnon or a real swap entry would be.

The fact that a migration entry is encoded much like a swap entry,
and a real swap entry corresponds to a PageAnon, is misleading here.

> 
> > 
> > > > 
> > > > > 
> > > > > And I'm pleased to see in one of Matthew's diffs that he intends to
> > > > > bring zap_details and zap_skip_check_mapping() back into mm/memory.c
> > > > > from include/linux/mm.h.
> > > > 
> > > > Yeah it's only used in memory.c.  I put it there initially because I wanted
> > > > zap_details user can reference what's that check mapping is all about, but
> > > > maybe that's not necessary.
> > > > 
> > > > If you or Matthew could provide a link to that patch, I'll be happy to pick
> > > > that up too with this series.  Or I can also do nothing assuming Matthew will
> > > > handle it elsewhere.
> > 
> > In Linus's tree today: 3506659e18a6 ("mm: Add unmap_mapping_folio()").
> 
> Rebased.
> 
> > 
> > > > 
> > > > > 
> > > > > >  			rss[mm_counter(page)]--;
> > > > > >  		}
> > 
> > I have given no thought as to whether more "else"s are needed there.
> 
> It's hwpoison that's in the else.  Nothing else should.
> 
> I didn't mention it probably because I forgot.  I did think about it when
> drafting, and IMHO we should simply zap that hwpoison entry because:
> 
>   (1) Zap means the user knows this data is meaningless, so at least we
>       shouldn't SIGBUS for that anymore.
> 
>   (2) If we keep it there, it could errornously trigger SIGBUS later if the
>       guest accessed that pte again somehow.
> 
> I plan to mention that in the commit message, but I can also add some comments
> directly into the code.  Let me know your thoughts.

It's comes down, again, to what punching a hole in a file should do
to the private data that has been COWed from it.  Strictly, it should
not interfere with it, even when the COWed page has become poisonous:
the entry should be left in to generate SIGBUS.  Whereas ordinary
unmapping or truncating or MADV_DONTNEEDing would zap it.

> 
> > 
> > > > > >  		if (unlikely(!free_swap_and_cache(entry)))
> > 
> > (I think you moved that to a more relevant place in a later patch: good.)
> > 
> > I know you're also asking for test suggestions, but I'll leave it to you:
> > hole-punching, truncation, swapping, compaction (to force migration).
> 
> Please read above - again I don't think we can write a reproducer, and that's
> why I provided the "fake" reproducer only.

I haven't studied your "fake" reproducer at all, I guess I'm not all that
interested in fakes.  An actual reproducer would be able to show that the
current code (5.17-rc1 and recent) is zapping COWed pages in MAP_PRIVATE
areas when a hole is punched in the corresponding file.  Or, would it
show that I've been wrong all along in what I've said on this?

(Yes, our repeated back and forth on this does make me wonder whether
it would have been easier to define hole-punch as deleting COWs too:
but it's years too late to change our minds on that; and I think a
closer examination might show that it's difficult to guarantee the
deletion of COWs when punching a hole - traditionally, truncation
has leant on i_size for consistent implementation, and hole-punching
has been much trickier, because it does not change i_size at all.)

Hugh

> 
> I could always be missing something, though. I'd be glad to be corrected,
> again.
> 
> Thanks,
> 
> -- 
> Peter Xu
