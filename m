Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2843448872D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 02:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiAIBTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 20:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiAIBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 20:19:18 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB58C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 17:19:18 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so2646205ooe.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 17:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=qRNYi662Eoqw6pGuDo7lY8R/RyBNPDAdgnvvPdhdOy8=;
        b=Gb+wtkn02OwlpPDEj99ctWnIXXVKqgnBI1WKRozbrKPFOksM6q7u+DCe151RSerPID
         u1k7TXPy43pN3YOiJEOFFhPvph4TGCoGIhaauw+PurnsKRBKxO1CNzYvDe2eCXyBDY2I
         V2ifap/M3TFxHHI7b0K3VR7nBQ886YV4tqpZvlxgvP0r79d4WnDdqOAeCuF3GcTNxBVQ
         kPrsCw7TkrxG3+JkOx96D7UVs8MNS9i11NL4H4qDebBtRG/lNWQkPaAfekkFN3yhxNlh
         P0Th1QXKr+3HHNk5IO1Aq6V7MTXole6LxhLBRQeqptM7tupHrqxAZzkxXPckM9CSGIbM
         qIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=qRNYi662Eoqw6pGuDo7lY8R/RyBNPDAdgnvvPdhdOy8=;
        b=1HSsRPMRdhg3HpDAx7n75wkrvBA+z93/IqhXLBS7ecUHRMRfk7QpD10ptWYpaIRf4y
         tTfi+FkjiEfDOvqlkiuCy5rJWLad+wCbJW+JNrtdMzdgkkwpkIzwtgwlNarHK/LVZECX
         dzhWH2se1oTdqUWPjsOaJd9ij1Nn819i1yEfcwrfU/ZUJ4C5N89J4Yh9yBhqRPgC2CyI
         fCT1tROfhDIJ9ynYHGpyrG6j6RkSGoGARthvsMdOKDhoKs2dJRHl0GLxcLmuEXhYMQPD
         fTEsGET93oCtISjVqTkxpmLodD0Lhnpb4ka9mAFaKG89/x0UIL/kP3VP6X5yfW9pcMb3
         M/Qw==
X-Gm-Message-State: AOAM531YSsKu9/qwwLKPnVZ2x4byVgbAUECqtgg2l/9WVSXj10ZN0+5J
        Ea6XkGniz5vbJbv4ixpQsdqSxQ==
X-Google-Smtp-Source: ABdhPJw0qJPklXCmnMYFAUVcYRF4YwSOHSdzs3j87F4GqBFwBLPOv3tLu9eGCz7x4atzBbNZ7qDjlA==
X-Received: by 2002:a4a:c18e:: with SMTP id w14mr10329468oop.41.1641691156503;
        Sat, 08 Jan 2022 17:19:16 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i25sm655905otl.8.2022.01.08.17.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 17:19:15 -0800 (PST)
Date:   Sat, 8 Jan 2022 17:19:04 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
In-Reply-To: <20211115134951.85286-2-peterx@redhat.com>
Message-ID: <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
References: <20211115134951.85286-1-peterx@redhat.com> <20211115134951.85286-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021, Peter Xu wrote:

> This check existed since the 1st git commit of Linux repository, but at that
> time there's no page migration yet so I think it's okay.

//git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
helps with the history.  Yes, the check was okay back then,
but a lot of changes have come in since: I'll tell more of those below.

You are absolutely right to clean this up and fix the bugs that
have crept in, but I think the patch itself is not quite right yet.

> 
> With page migration enabled, it should logically be possible that we zap some
> shmem pages during migration.

Yes.

> When that happens, IIUC the old code could have
> the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> without decreasing the counters for the migrating entries.  I have no unit test
> to prove it as I don't know an easy way to trigger this condition, though.

In the no-details case, yes, it does look like that. I ought to try
and reproduce that, but responding to mails seems more important.

> 
> Besides, the optimization itself is already confusing IMHO to me in a few points:

It is confusing and unnecessary and wrong, I agree.

> 
>   - The wording "skip swap entries" is confusing, because we're not skipping all
>     swap entries - we handle device private/exclusive pages before that.

I'm entirely ignorant of device pages, so cannot comment on your 2/2,
but of course it's good if you can bring the cases closer together.

> 
>   - The skip behavior is enabled as long as zap_details pointer passed over.
>     It's very hard to figure that out for a new zap caller because it's unclear
>     why we should skip swap entries when we have zap_details specified.

History below will clarify that.

> 
>   - With modern systems, especially performance critical use cases, swap
>     entries should be rare, so I doubt the usefulness of this optimization
>     since it should be on a slow path anyway.
> 
>   - It is not aligned with what we do with huge pmd swap entries, where in
>     zap_huge_pmd() we'll do the accounting unconditionally.

The patch below does not align with what's done in zap_huge_pmd() either;
but I think zap_huge_pmd() is okay without "details" because its only swap
entries are migration entries, and we do not use huge pages when COWing
from file huge pages.

> 
> This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> should do the same mapping check upon migration entries too.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 8f1de811a1dc..e454f3c6aeb9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			continue;
>  		}
>  
> -		/* If details->check_mapping, we leave swap entries. */
> -		if (unlikely(details))
> -			continue;
> -

Good.

>  		if (!non_swap_entry(entry))
>  			rss[MM_SWAPENTS]--;
>  		else if (is_migration_entry(entry)) {
>  			struct page *page;
>  
>  			page = pfn_swap_entry_to_page(entry);
> +			if (unlikely(zap_skip_check_mapping(details, page)))
> +				continue;

Good; though I don't think it's worth an "unlikely", and I say again,
more forcefully, that "zap_skip_check_mapping" is a terrible name.

David suggested naming its inversion should_zap_page(), yes, that's
much better; I'd toyed with do_not_zap_page() and zap_skip_page(),
but should_zap_page() for the inversion sounds good to me.

And I'm pleased to see in one of Matthew's diffs that he intends to
bring zap_details and zap_skip_check_mapping() back into mm/memory.c
from include/linux/mm.h.

>  			rss[mm_counter(page)]--;
>  		}
>  		if (unlikely(!free_swap_and_cache(entry)))
> -- 
> 2.32.0

History.  zap_details came in 2.6.6, and it was mostly to manage
truncation on the non-linear vmas we had at that time (remap_file_pages
syscall packing non-sequential offsets into a single vma, with pte_file
entries), where index could not be deduced from position of pte in vma:
truncation range had to be passed down in zap_details; and an madvise
needed it too, so it could not be private to mm/memory.c then.

But at the same time, I added the even_cows argument to
unmap_mapping_range(), to distinguish truncation (which POSIX requires
to unmap even COWed pages) from invalidation (for page cache coherence,
which shouldn't touch private COWs).  However, there appear to be no
users of that in 2.6.6, though I wouldn't have added that complication
just for the fun of confusing everyone: best guess would be that there
was parallel development, and the use for !even_cows got removed in
the very same release that it was being added.

(PageAnon was brand new in 2.6.6: maybe it could have been used instead
of comparing details->check_mapping, or maybe there's some other case
I've forgotten which actually needs the exact mapping check.)

Eventually a few drivers came to use unmap_shared_mapping_range(),
the !even_cows caller; but more to the point, hole-punching came in,
and I felt very strongly that hole-punching on a file had no right
to delete private user data.  So then !even_cows became useful.

IIRC, I've seen Linus say he *detests* zap_details.  It had much better
justification in the days of non-linear, and I was sad to add
single_page to it quite recently; but hope that can go away later
(when try_to_unmap_one() is properly extended to THPs).

Now, here's what may clear up a lot of the confusion.
The 2.6.7 zap_pte_range() got a line at the head of zap_pte_range()
	if (details && !details->check_mapping && !details->nonlinear_vma)
		details = NULL;
which paired with the
		/*
		 * If details->check_mapping, we leave swap entries;
		 * if details->nonlinear_vma, we leave file entries.
		 */
		if (unlikely(details))
			continue;
lower down.  I haven't followed up the actual commits, but ChangeLog-2.6.7
implies that 2.6.6 had a "details = NULL;" placed elsewhere but buggily.
In 2.6.12 it moved from zap_pte_range() to unmap_page_range().
It was intended, not so much to optimize, as to simplify the flow;
but in fact has caused all this confusion.

When Kirill discontinued non-linear mapping support in 4.0 (no tears
were shed and) the nonlinear_vma comment above got deleted, leaving
just the then more puzzling check_mapping comment.

Then in 4.6 the "details = NULL;" seems to have got deleted as part of
aac453635549 ("mm, oom: introduce oom reaper"), which added some new
details (ignore_dirty and check_swap_entries); which got reverted in
4.11, but apparently the "details = NULL;" not restored.

My stamina is suddenly exhausted, without actually pinpointing a commit
for "Fixes:" in your eventual cleanup.  Sorry, I've had enough!

Hugh
