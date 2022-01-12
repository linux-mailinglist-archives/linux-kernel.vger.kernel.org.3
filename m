Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC1948C4A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353511AbiALNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353510AbiALNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641993503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9I565VO2bQe9r2odseRdQa6hpt9V1+zfKNi6ExqF2Uw=;
        b=gQUwc6xvpyfXXwBJjvDAMlIS5bcGigP4S32noCwYb+spdy4VTF1lB0Y+OiI2gVssl4tm9r
        k87CCP9kd4kVu1jaEskB0HBg1jYJJaGjMGwF4CuoSti6qssGNYoGuKU6LzDMpk4FBUc4Re
        eFocO8eWjBD7RBKRF219lY39ndNSwA0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-8dCfufoiOt2x0Og97B7wgw-1; Wed, 12 Jan 2022 08:18:22 -0500
X-MC-Unique: 8dCfufoiOt2x0Og97B7wgw-1
Received: by mail-pl1-f198.google.com with SMTP id s19-20020a170902b19300b00149a463ad43so2714561plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9I565VO2bQe9r2odseRdQa6hpt9V1+zfKNi6ExqF2Uw=;
        b=T67jv9HTkexk2wflTK94xe+10aoK8mHd1AF2GodruuyGQ1TYdBVc35CfVZ4wiSiBZA
         858hVcwUAaO1zWZp5ir7iJWImP+qJszx4qntwWBfbCMWLxe/X+Sh8ZPcbwejVKFHAIoB
         NJlQyoEhNV6r4ewgpKRIwPBtwV3G5NfZve5oz5nDu/UWoHlCqghcvV3lYdVynzgrpA61
         6Nd6PHYoVwtQvCO6ITC5O1fKtT4yaHKOUwS/6p8JxDSswMzK9fS5n5CT19QqyrO8eCdY
         Hh82tc7RqqCwJtJvDObaYU99bVIA7nUk50VCGuByns0D+MtZ2X5TG3+RYWSXoR0oifeT
         x6iQ==
X-Gm-Message-State: AOAM533h5I1EXe9LFrH8I2QR+8oVbv7njDT+EbIA6GneLdH9Sb5uZsq3
        AJPrnTiPVV22qKIfZJlKvj3+dLXK1hWHImfx1KiHXvTdsz7r7oKYSu1dw5UkrwJDBcyUGZMPB+C
        TLORu1Gmqu0byl/5ry+PsrsHX
X-Received: by 2002:a63:9809:: with SMTP id q9mr8371590pgd.509.1641993501015;
        Wed, 12 Jan 2022 05:18:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycDrL7SCOLH4la78UMhHh5QANWwr4JN9u7rHgQy2IWxCGBKketRbee2s3EMvjL/BiKbHBvMA==
X-Received: by 2002:a63:9809:: with SMTP id q9mr8371564pgd.509.1641993500579;
        Wed, 12 Jan 2022 05:18:20 -0800 (PST)
Received: from xz-m1.local ([191.101.132.233])
        by smtp.gmail.com with ESMTPSA id o186sm13350905pfb.187.2022.01.12.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:18:19 -0800 (PST)
Date:   Wed, 12 Jan 2022 21:18:09 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Yd7VEXI+/Lu8MVOo@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 05:19:04PM -0800, Hugh Dickins wrote:
> On Mon, 15 Nov 2021, Peter Xu wrote:
> 
> > This check existed since the 1st git commit of Linux repository, but at that
> > time there's no page migration yet so I think it's okay.
> 
> //git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> helps with the history.  Yes, the check was okay back then,
> but a lot of changes have come in since: I'll tell more of those below.

Thanks for looking at this.  By the way, the link is greatly helpful. It's
always good to be able to read into the history.

> 
> You are absolutely right to clean this up and fix the bugs that
> have crept in, but I think the patch itself is not quite right yet.

Do you mean the pmd path on checking mapping?  If so I agree, and I'll add that
in v2 (even if as you pointed out that shouldn't be a real bug, iiuc, as you
analyzed below).

Let me know if I missed anything else..

> 
> > 
> > With page migration enabled, it should logically be possible that we zap some
> > shmem pages during migration.
> 
> Yes.
> 
> > When that happens, IIUC the old code could have
> > the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> > without decreasing the counters for the migrating entries.  I have no unit test
> > to prove it as I don't know an easy way to trigger this condition, though.
> 
> In the no-details case, yes, it does look like that. I ought to try
> and reproduce that, but responding to mails seems more important.

Please let me know if you know how to reproduce it, since I don't know yet a
real reproducer.

What I can do, though, is if with below patch applied to current linux master:

=============
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..51fe02a22ea9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1383,8 +1383,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
                }
 
                /* If details->check_mapping, we leave swap entries. */
-               if (unlikely(details))
+               if (unlikely(details)) {
+                       WARN_ON_ONCE(is_migration_entry(entry));
                        continue;
+               }
 
                if (!non_swap_entry(entry))
                        rss[MM_SWAPENTS]--;
=============

Then I can easily trigger it if with the help of a test program attached
(zap-migrate.c).

IMHO it won't really reproduce because it seems all relevant shmem operations
(e.g. hole punch, unmap..) will take the page lock so it won't really race with
migration (which needs the page lock too), as mentioned in previous cover
letters when I was still working on the old versions of this.  But it could be
possible that I missed something.

While the WARN_ON_ONCE() can trigger only because of the fast path in hole
punching we have the pre-unmap without lock:

		if ((u64)unmap_end > (u64)unmap_start)
			unmap_mapping_range(mapping, unmap_start,
					    1 + unmap_end - unmap_start, 0);
		shmem_truncate_range(inode, offset, offset + len - 1);

But that will be fixed up right afterwards in shmem_truncate_range(), afaict,
which is with-lock.  Hence we have a small window to at least trigger the
warning above, even if it won't really mess up the accounting finally.

> 
> > 
> > Besides, the optimization itself is already confusing IMHO to me in a few points:
> 
> It is confusing and unnecessary and wrong, I agree.
> 
> > 
> >   - The wording "skip swap entries" is confusing, because we're not skipping all
> >     swap entries - we handle device private/exclusive pages before that.
> 
> I'm entirely ignorant of device pages, so cannot comment on your 2/2,
> but of course it's good if you can bring the cases closer together.
> 
> > 
> >   - The skip behavior is enabled as long as zap_details pointer passed over.
> >     It's very hard to figure that out for a new zap caller because it's unclear
> >     why we should skip swap entries when we have zap_details specified.
> 
> History below will clarify that.
> 
> > 
> >   - With modern systems, especially performance critical use cases, swap
> >     entries should be rare, so I doubt the usefulness of this optimization
> >     since it should be on a slow path anyway.
> > 
> >   - It is not aligned with what we do with huge pmd swap entries, where in
> >     zap_huge_pmd() we'll do the accounting unconditionally.
> 
> The patch below does not align with what's done in zap_huge_pmd() either;
> but I think zap_huge_pmd() is okay without "details" because its only swap
> entries are migration entries, and we do not use huge pages when COWing
> from file huge pages.
> 
> > 
> > This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> > should do the same mapping check upon migration entries too.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/memory.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 8f1de811a1dc..e454f3c6aeb9 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			continue;
> >  		}
> >  
> > -		/* If details->check_mapping, we leave swap entries. */
> > -		if (unlikely(details))
> > -			continue;
> > -
> 
> Good.
> 
> >  		if (!non_swap_entry(entry))
> >  			rss[MM_SWAPENTS]--;
> >  		else if (is_migration_entry(entry)) {
> >  			struct page *page;
> >  
> >  			page = pfn_swap_entry_to_page(entry);
> > +			if (unlikely(zap_skip_check_mapping(details, page)))
> > +				continue;
> 
> Good; though I don't think it's worth an "unlikely", and I say again,

Sure, I'll drop this "unlikely".  Meanwhile, shall we drop all the rest of the
"unlikely" too around this check?

> more forcefully, that "zap_skip_check_mapping" is a terrible name.
> 
> David suggested naming its inversion should_zap_page(), yes, that's
> much better; I'd toyed with do_not_zap_page() and zap_skip_page(),
> but should_zap_page() for the inversion sounds good to me.

Ah sure, I'll rename it to should_zap_page() in a new patch before this.

> 
> And I'm pleased to see in one of Matthew's diffs that he intends to
> bring zap_details and zap_skip_check_mapping() back into mm/memory.c
> from include/linux/mm.h.

Yeah it's only used in memory.c.  I put it there initially because I wanted
zap_details user can reference what's that check mapping is all about, but
maybe that's not necessary.

If you or Matthew could provide a link to that patch, I'll be happy to pick
that up too with this series.  Or I can also do nothing assuming Matthew will
handle it elsewhere.

> 
> >  			rss[mm_counter(page)]--;
> >  		}
> >  		if (unlikely(!free_swap_and_cache(entry)))
> > -- 
> > 2.32.0
> 
> History.  zap_details came in 2.6.6, and it was mostly to manage
> truncation on the non-linear vmas we had at that time (remap_file_pages
> syscall packing non-sequential offsets into a single vma, with pte_file
> entries), where index could not be deduced from position of pte in vma:
> truncation range had to be passed down in zap_details; and an madvise
> needed it too, so it could not be private to mm/memory.c then.
> 
> But at the same time, I added the even_cows argument to
> unmap_mapping_range(), to distinguish truncation (which POSIX requires
> to unmap even COWed pages) from invalidation (for page cache coherence,
> which shouldn't touch private COWs).  However, there appear to be no
> users of that in 2.6.6, though I wouldn't have added that complication
> just for the fun of confusing everyone: best guess would be that there
> was parallel development, and the use for !even_cows got removed in
> the very same release that it was being added.
> 
> (PageAnon was brand new in 2.6.6: maybe it could have been used instead
> of comparing details->check_mapping, or maybe there's some other case
> I've forgotten which actually needs the exact mapping check.)
> 
> Eventually a few drivers came to use unmap_shared_mapping_range(),
> the !even_cows caller; but more to the point, hole-punching came in,
> and I felt very strongly that hole-punching on a file had no right
> to delete private user data.  So then !even_cows became useful.
> 
> IIRC, I've seen Linus say he *detests* zap_details.  It had much better
> justification in the days of non-linear, and I was sad to add
> single_page to it quite recently; but hope that can go away later
> (when try_to_unmap_one() is properly extended to THPs).
> 
> Now, here's what may clear up a lot of the confusion.
> The 2.6.7 zap_pte_range() got a line at the head of zap_pte_range()
> 	if (details && !details->check_mapping && !details->nonlinear_vma)
> 		details = NULL;
> which paired with the
> 		/*
> 		 * If details->check_mapping, we leave swap entries;
> 		 * if details->nonlinear_vma, we leave file entries.
> 		 */
> 		if (unlikely(details))
> 			continue;
> lower down.  I haven't followed up the actual commits, but ChangeLog-2.6.7
> implies that 2.6.6 had a "details = NULL;" placed elsewhere but buggily.
> In 2.6.12 it moved from zap_pte_range() to unmap_page_range().
> It was intended, not so much to optimize, as to simplify the flow;
> but in fact has caused all this confusion.
> 
> When Kirill discontinued non-linear mapping support in 4.0 (no tears
> were shed and) the nonlinear_vma comment above got deleted, leaving
> just the then more puzzling check_mapping comment.
> 
> Then in 4.6 the "details = NULL;" seems to have got deleted as part of
> aac453635549 ("mm, oom: introduce oom reaper"), which added some new
> details (ignore_dirty and check_swap_entries); which got reverted in
> 4.11, but apparently the "details = NULL;" not restored.
> 
> My stamina is suddenly exhausted, without actually pinpointing a commit
> for "Fixes:" in your eventual cleanup.  Sorry, I've had enough!

Yeah it's in most cases a pain for digging all these trivial details, thanks
for digging already most of it out of the mist.

That's really what I hope this patch can help: not only because the uffd work
will rely on it, but also on resolving this early (we do use some wordings like
"technical debt" sometimes, I think it's the same here but different form) when
the above "history.git" is still functional so we can still reference.

With your help and the history.git I can try a better commit message because
obviously some of the contents needs amending (it's not a pure optimization at
all), but I assume the patch content will be mostly the same, with the tweaks
applied.

Per stated so far I don't know any real reproducer so maybe it's not a real
issue in any production system?  Maybe that'll make it a bit easier, because
then we don't strongly require a Fixes (which could be another hard question to
answer besides the issue itself).

Thanks,

-- 
Peter Xu

