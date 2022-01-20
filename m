Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BDD494BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376308AbiATKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359841AbiATKcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642674760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYl1F2tZLcWmZuLNLNullV9dPUEggzRSYb4ujD0vivQ=;
        b=Ia7sFB5PoCzDnVtGqW32EEU22k1Ti7xSJuklW+CPuLri5pMR9i+3Pc0Yj511AqwuPYFIW2
        xml5jT7yRBN5FsDo+H4x7igkviYDYJv5L34cr05uWIqrgzHWDkRItC4z3aBdbk8hvDYX47
        /X5FGfiUIgksGgG/z0ZQN+GBO6zuN2Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-GbudBZihPw-v5dULILI81w-1; Thu, 20 Jan 2022 05:32:39 -0500
X-MC-Unique: GbudBZihPw-v5dULILI81w-1
Received: by mail-pj1-f69.google.com with SMTP id q1-20020a17090a064100b001b4d85cbaf7so5460163pje.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYl1F2tZLcWmZuLNLNullV9dPUEggzRSYb4ujD0vivQ=;
        b=PHrnsd3/6XVkgoEiSzC13zwgdIxLNBMPAbw2tCbji/Snis04WY1dyQpycZrdMr3VIr
         KEqD91zgsD6BuzDCmDhqfq9n7EoZnEUgOyhxTnIgG2hjOmYEnmDF4JtfCu9EKq8EZ8aY
         UmnEFKYTr2Ptna09jB88///p/mxVLUpJdTou+GlqzeOnpy/6zBSkNsdwTdhGnC8Sz+H4
         iCqavTV5g9spHG/W0vIia6xtvvNYpUYbC5kfqaHkunUVJZvlUdfL6TLa1vO7OlNU09rG
         pXXhNP1waSMWys0oghZ/gHfRujjPwBi+69qEnBPgXEkcADVUm9x5a9IQhhCdLoMWMZO0
         9zxA==
X-Gm-Message-State: AOAM53035FbC04qMDh2Xrnj/AVmPGyJ94EdJ64k0eoJZfKiVA+rHBZZ6
        gGE7YHzdMWuzSUYhbnVKuu+Wsf8KKrIiMygVmqexi+4gYcYKUqTr49M1L9lka3sNnC5E5HD4wF7
        UMRLNMuemsW6QSyNyEArIRM9X
X-Received: by 2002:a63:b812:: with SMTP id p18mr31979113pge.22.1642674758032;
        Thu, 20 Jan 2022 02:32:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygddJ8UiyNMYcFxkrWavEt7/p4IOU7t3jY//CN6tll0QTxqF+pWSt0Ppo7DR4SxXPkI4uz4Q==
X-Received: by 2002:a63:b812:: with SMTP id p18mr31979087pge.22.1642674757601;
        Thu, 20 Jan 2022 02:32:37 -0800 (PST)
Received: from xz-m1.local ([94.177.118.145])
        by smtp.gmail.com with ESMTPSA id m21sm2853666pfk.185.2022.01.20.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:32:36 -0800 (PST)
Date:   Thu, 20 Jan 2022 18:32:29 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Yek6PaW8fAXY4Bft@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
 <Yd7W6ndSPkXQjurY@xz-m1.local>
 <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

On Wed, Jan 12, 2022 at 07:47:40PM -0800, Hugh Dickins wrote:
> > > IMHO it won't really reproduce because it seems all relevant shmem operations
> > > (e.g. hole punch, unmap..) will take the page lock so it won't really race with
> > > migration (which needs the page lock too), as mentioned in previous cover
> > > letters when I was still working on the old versions of this.  But it could be
> > > possible that I missed something.
> 
> The latter.
> 
> There may still be some cases in which unmap_mapping_range() is called
> on a single page with that page held locked, I have not checked; but in
> general it is called on a range of pages, and would not have them locked.
> 
> The usual pattern when truncating/hole-punching/invalidating is to call
> unmap_mapping_range() first, to do the bulk of the work efficiently,
> scanning down the page tables without holding any page lock; but then
> unmap racily faulted stragglers one by one while holding page lock
> using unmap_mapping_page() just before deleting each from page cache.
> 
> So some relevant operations are done without page lock and some relevant
> operations are done with page lock: both need to be considered, but you
> are right that the page-locked ones will not encounter a migration entry
> of that page (I haven't tried to see if that fact is useful here or not).
> 
> You may need to substitute "pages" or "page" or "folio" in the above.
> 
> > > 
> > > While the WARN_ON_ONCE() can trigger only because of the fast path in hole
> > > punching we have the pre-unmap without lock:
> > > 
> > > 		if ((u64)unmap_end > (u64)unmap_start)
> > > 			unmap_mapping_range(mapping, unmap_start,
> > > 					    1 + unmap_end - unmap_start, 0);
> > > 		shmem_truncate_range(inode, offset, offset + len - 1);
> 
> Oh, I should have read on, I've been wasting my time explaining above:
> there you said the page must be locked, here you find that is not so.
> 
> > > 
> > > But that will be fixed up right afterwards in shmem_truncate_range(), afaict,
> > > which is with-lock.  Hence we have a small window to at least trigger the
> > > warning above, even if it won't really mess up the accounting finally.
> 
> Well, there is still an opportunity to do the wrong thing.

So what I wanted to express is we can't trigger any real issue, so no way to
write a valid reproducer even if we know it did it wrong..  And that's why I
provided a "fake" one..

Let me explain a little bit further.  Sorry I know you know most of below, so
it could be that you spend 5 minutes reading nonsense..  but I want to 100%
sure we're on the same page.

Firstly, current code will have a problem if we:

  (1) Passed over a valid "zap_details" pointer to zap_pte_range, and,
  (2) At the meantime if there can be a swap entry of any kind of below:
        (2.1) real swap entry
        (2.2) migration swap entry

Then we got doomed because we could have errornously skipped some swap entry
that was also under the mapping while we shouldn't.

I didn't mention device exclusive/private entries are fine because they're
checked before the "details continue" check.

I didn't mention hwpoison entry too; but I'll discuss it later..

Then, when do we have cases above (1) or (2)?

(1) is impossible because when there's zap_details in current code it means the
page is backing a fs mapping, hence not PageAnon.  We can only hit (2).

What can hit (2)?  I only know shmem...

Next, as a conclusion, what we want to reproduce is: some caller calls
zap_pte_range() with zap_details, but accidentally there's a migration entry.

It's fairly easy to find this, as what my "fake" reproducer was doing.

However, as I stated before, all these use cases always have another step to
take the lock and redo the range.  Then even if some migration entry got
wrongly skipped it'll always be fixed.  What we need to find is some caller
that calls zap_pte_range() without later taking the page lock and redo that.
That's the only possibility to trigger a real issue on the shmem accounting.

To prove this, let's see all the possible call stacks...

zap_pte_range() will only be called with zap_details pointer with below two
functions: 

        unmap_mapping_folio
        unmap_mapping_pages

unmap_mapping_folio is already having the page lock so it's not going to work.
Then the callers of unmap_mapping_pages are:

    unmap_mapping_pages
        [1] collapse_file
        [?] unmap_mapping_range
                [?] unmap_shared_mapping_range
                        [?] vmw_bo_dirty_unmap (gpu/drm)
                        [?] inode_go_sync (gfs2)
                [1] shmem_setattr
                [1] shmem_fallocate
                [1] truncate_pagecache
                [1] truncate_pagecache_range
        [1] invalidate_inode_pages2_range

It's a reversed tree of call stacks, when I marked [1] means this call site
does the "unmap then take page lock and redo" thing, so it can't reproduce.

The only outliers are:

        [?] vmw_bo_dirty_unmap (gpu/drm)
        [?] inode_go_sync (gfs2)

Which I marked with [?].

However I don't think they'll have migration entries at all, or am I wrong?

I hope I explained why I think we can't write a reproducer.. but I still think
we should fix the problem, because we can't tell whether it'll go wrong in the
future with a new caller who will not take the page lock to redo the zap.

> 
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > >  			continue;
> > > > >  		}
> > > > >  
> > > > > -		/* If details->check_mapping, we leave swap entries. */
> > > > > -		if (unlikely(details))
> > > > > -			continue;
> > > > > -
> > > > 
> > > > Good.
> > > > 
> > > > >  		if (!non_swap_entry(entry))
> > > > >  			rss[MM_SWAPENTS]--;
> 
> Right, I did not say at all what is wrong here, I suppose I intended
> to come back but then got tired - sorry.  Here we are dealing with a
> genuine swap entry.  No problem for exit or munmap or MADV_DONTNEED.
> No problem for truncation (but apparently there has been an unnoticed
> problem, that swapped-out COWed pages beyond the truncation point were
> not being deleted, while that "details continue" was still there).  But
> a problem for hole-punching: without the "details continue", this will
> go on to delete COWed pages which ought to be preserved - needs a
> should_zap_page() check, as you do with the migration entry.

I see, thanks for pointing out.

> 
> Except that here we have no page to check, so it looks like you'll
> have to change should_zap_page() to deal with this case too, or just
> check details->check_mapping directly.

Yeah I prefer this, as we don't have the page* pointer anyway.

> Which raises the question again
> of why I did not just use a boolean flag there originally: aah, I think
> I've found why.  In those days there was a horrible "optimization", for
> better performance on some benchmark I guess, which when you read from
> /dev/zero into a private mapping, would map the zero page there (look
> up read_zero_pagealigned() and zeromap_page_range() if you dare).  So
> there was another category of page to be skipped along with the anon
> COWs, and I didn't want multiple tests in the zap loop, so checking
> check_mapping against page->mapping did both.  I think nowadays you
> could do it by checking for PageAnon page (or genuine swap entry)
> instead.

It must be PageAnon already, isn't it?

> 
> > > > >  		else if (is_migration_entry(entry)) {
> > > > >  			struct page *page;
> > > > >  
> > > > >  			page = pfn_swap_entry_to_page(entry);
> > > > > +			if (unlikely(zap_skip_check_mapping(details, page)))
> > > > > +				continue;
> > > > 
> > > > Good; though I don't think it's worth an "unlikely", and I say again,
> > > 
> > > Sure, I'll drop this "unlikely".  Meanwhile, shall we drop all the rest of the
> > > "unlikely" too around this check?
> > > 
> > > > more forcefully, that "zap_skip_check_mapping" is a terrible name.
> > > > 
> > > > David suggested naming its inversion should_zap_page(), yes, that's
> > > > much better; I'd toyed with do_not_zap_page() and zap_skip_page(),
> > > > but should_zap_page() for the inversion sounds good to me.
> > > 
> > > Ah sure, I'll rename it to should_zap_page() in a new patch before this.
> 
> Thanks; though now even that name is looking dubious - should_zap_entry()?

I guess my plan is simply keep should_zap_page() and check explicitly for real
swap entries.

> 
> > > 
> > > > 
> > > > And I'm pleased to see in one of Matthew's diffs that he intends to
> > > > bring zap_details and zap_skip_check_mapping() back into mm/memory.c
> > > > from include/linux/mm.h.
> > > 
> > > Yeah it's only used in memory.c.  I put it there initially because I wanted
> > > zap_details user can reference what's that check mapping is all about, but
> > > maybe that's not necessary.
> > > 
> > > If you or Matthew could provide a link to that patch, I'll be happy to pick
> > > that up too with this series.  Or I can also do nothing assuming Matthew will
> > > handle it elsewhere.
> 
> In Linus's tree today: 3506659e18a6 ("mm: Add unmap_mapping_folio()").

Rebased.

> 
> > > 
> > > > 
> > > > >  			rss[mm_counter(page)]--;
> > > > >  		}
> 
> I have given no thought as to whether more "else"s are needed there.

It's hwpoison that's in the else.  Nothing else should.

I didn't mention it probably because I forgot.  I did think about it when
drafting, and IMHO we should simply zap that hwpoison entry because:

  (1) Zap means the user knows this data is meaningless, so at least we
      shouldn't SIGBUS for that anymore.

  (2) If we keep it there, it could errornously trigger SIGBUS later if the
      guest accessed that pte again somehow.

I plan to mention that in the commit message, but I can also add some comments
directly into the code.  Let me know your thoughts.

> 
> > > > >  		if (unlikely(!free_swap_and_cache(entry)))
> 
> (I think you moved that to a more relevant place in a later patch: good.)
> 
> I know you're also asking for test suggestions, but I'll leave it to you:
> hole-punching, truncation, swapping, compaction (to force migration).

Please read above - again I don't think we can write a reproducer, and that's
why I provided the "fake" reproducer only.

I could always be missing something, though. I'd be glad to be corrected,
again.

Thanks,

-- 
Peter Xu

