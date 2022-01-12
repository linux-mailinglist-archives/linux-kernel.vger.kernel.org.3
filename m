Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7F48C4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353538AbiALN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbiALN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641993974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/kIenSIhvXfnrDieXT+I5CKU4CH6Te3kYN1HZO8M2o=;
        b=aRFkQ4MMrJCLzBpTEthG+kET/rRZBddQVvimEOUU2jQw+5ntFjrjkcqbnKRbLRwIZ7Bp8C
        j1W6YCdwVzt9bvaCbBMrMQ4mSOyzR0zBO98hPP4zJfFDqoZmYjR5trSq2mmjEAwXokcpgC
        klACR5GF0nJcY/Jqu795q94ITPB5PMI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-v1Tnz1bOP4GY2QGaBAGb2g-1; Wed, 12 Jan 2022 08:26:13 -0500
X-MC-Unique: v1Tnz1bOP4GY2QGaBAGb2g-1
Received: by mail-pj1-f72.google.com with SMTP id y15-20020a17090a600f00b001b3501d9e7eso6703537pji.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/kIenSIhvXfnrDieXT+I5CKU4CH6Te3kYN1HZO8M2o=;
        b=nfQbdisXl45Y3+z70GHI+YvdmSotuGdmYuJDpltG3iVhaBHdq9B25ntbsXIU2Mjjvj
         4IUHszotOIowgOJKlJJrXxt+Fl3J52l5/5QO3vEQo7I0TCK+2FDyFEHcBrIY44bJol44
         XYcixYLeVyCWb9IrXMg1Vx/nUP/pR1JaCjR1jAq9EmW9StNcGLXCRhvBeFFTqI3LZD9j
         6MBIcCLncr7KDUs6xFAN4gzwxi0RTEeCQUoK/RWzmWpgRnCdY7feFc8f1kzZIquDAyWT
         +PM//9dqMM3SqSTx4UvrPdBAX/8JSrZflVmDGEWdLF8R7W/uHzpBg4567tebbA+90DKo
         wt6A==
X-Gm-Message-State: AOAM532o1i6pZGycAxVvWCeC6bsKNoWC3u1OPpSrsjro5BqTTkQZonaU
        vTlO6J+5UqnFUn8KiEmTVKsnk/3MiVQ/vhbRRntil4jQJdtpQGzBsH+DyGkH/SVkn1eR1lWkdBN
        l93rCVSOs5I2MQDMvb4OldgMu
X-Received: by 2002:a17:902:f68a:b0:14a:5f49:fada with SMTP id l10-20020a170902f68a00b0014a5f49fadamr5450607plg.106.1641993971542;
        Wed, 12 Jan 2022 05:26:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPXZrDdVEsOitJKByXjLyBKlgXRBcAxqQESJRxxzKFgazNr+lAFxFG2tzlIa1F6FnAYiGnlg==
X-Received: by 2002:a17:902:f68a:b0:14a:5f49:fada with SMTP id l10-20020a170902f68a00b0014a5f49fadamr5450572plg.106.1641993971021;
        Wed, 12 Jan 2022 05:26:11 -0800 (PST)
Received: from xz-m1.local ([191.101.132.233])
        by smtp.gmail.com with ESMTPSA id b2sm14210667pfl.138.2022.01.12.05.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:26:10 -0800 (PST)
Date:   Wed, 12 Jan 2022 21:26:02 +0800
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
Message-ID: <Yd7W6ndSPkXQjurY@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lt/KuCbYLL0lbsbj"
Content-Disposition: inline
In-Reply-To: <Yd7VEXI+/Lu8MVOo@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lt/KuCbYLL0lbsbj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jan 12, 2022 at 09:18:09PM +0800, Peter Xu wrote:
> On Sat, Jan 08, 2022 at 05:19:04PM -0800, Hugh Dickins wrote:
> > On Mon, 15 Nov 2021, Peter Xu wrote:
> > 
> > > This check existed since the 1st git commit of Linux repository, but at that
> > > time there's no page migration yet so I think it's okay.
> > 
> > //git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> > helps with the history.  Yes, the check was okay back then,
> > but a lot of changes have come in since: I'll tell more of those below.
> 
> Thanks for looking at this.  By the way, the link is greatly helpful. It's
> always good to be able to read into the history.
> 
> > 
> > You are absolutely right to clean this up and fix the bugs that
> > have crept in, but I think the patch itself is not quite right yet.
> 
> Do you mean the pmd path on checking mapping?  If so I agree, and I'll add that
> in v2 (even if as you pointed out that shouldn't be a real bug, iiuc, as you
> analyzed below).
> 
> Let me know if I missed anything else..
> 
> > 
> > > 
> > > With page migration enabled, it should logically be possible that we zap some
> > > shmem pages during migration.
> > 
> > Yes.
> > 
> > > When that happens, IIUC the old code could have
> > > the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> > > without decreasing the counters for the migrating entries.  I have no unit test
> > > to prove it as I don't know an easy way to trigger this condition, though.
> > 
> > In the no-details case, yes, it does look like that. I ought to try
> > and reproduce that, but responding to mails seems more important.
> 
> Please let me know if you know how to reproduce it, since I don't know yet a
> real reproducer.
> 
> What I can do, though, is if with below patch applied to current linux master:
> 
> =============
> diff --git a/mm/memory.c b/mm/memory.c
> index 8f1de811a1dc..51fe02a22ea9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1383,8 +1383,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>                 }
>  
>                 /* If details->check_mapping, we leave swap entries. */
> -               if (unlikely(details))
> +               if (unlikely(details)) {
> +                       WARN_ON_ONCE(is_migration_entry(entry));
>                         continue;
> +               }
>  
>                 if (!non_swap_entry(entry))
>                         rss[MM_SWAPENTS]--;
> =============
> 
> Then I can easily trigger it if with the help of a test program attached
> (zap-migrate.c).

(Attaching for real; also copy Matthew)

> 
> IMHO it won't really reproduce because it seems all relevant shmem operations
> (e.g. hole punch, unmap..) will take the page lock so it won't really race with
> migration (which needs the page lock too), as mentioned in previous cover
> letters when I was still working on the old versions of this.  But it could be
> possible that I missed something.
> 
> While the WARN_ON_ONCE() can trigger only because of the fast path in hole
> punching we have the pre-unmap without lock:
> 
> 		if ((u64)unmap_end > (u64)unmap_start)
> 			unmap_mapping_range(mapping, unmap_start,
> 					    1 + unmap_end - unmap_start, 0);
> 		shmem_truncate_range(inode, offset, offset + len - 1);
> 
> But that will be fixed up right afterwards in shmem_truncate_range(), afaict,
> which is with-lock.  Hence we have a small window to at least trigger the
> warning above, even if it won't really mess up the accounting finally.
> 
> > 
> > > 
> > > Besides, the optimization itself is already confusing IMHO to me in a few points:
> > 
> > It is confusing and unnecessary and wrong, I agree.
> > 
> > > 
> > >   - The wording "skip swap entries" is confusing, because we're not skipping all
> > >     swap entries - we handle device private/exclusive pages before that.
> > 
> > I'm entirely ignorant of device pages, so cannot comment on your 2/2,
> > but of course it's good if you can bring the cases closer together.
> > 
> > > 
> > >   - The skip behavior is enabled as long as zap_details pointer passed over.
> > >     It's very hard to figure that out for a new zap caller because it's unclear
> > >     why we should skip swap entries when we have zap_details specified.
> > 
> > History below will clarify that.
> > 
> > > 
> > >   - With modern systems, especially performance critical use cases, swap
> > >     entries should be rare, so I doubt the usefulness of this optimization
> > >     since it should be on a slow path anyway.
> > > 
> > >   - It is not aligned with what we do with huge pmd swap entries, where in
> > >     zap_huge_pmd() we'll do the accounting unconditionally.
> > 
> > The patch below does not align with what's done in zap_huge_pmd() either;
> > but I think zap_huge_pmd() is okay without "details" because its only swap
> > entries are migration entries, and we do not use huge pages when COWing
> > from file huge pages.
> > 
> > > 
> > > This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> > > should do the same mapping check upon migration entries too.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  mm/memory.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 8f1de811a1dc..e454f3c6aeb9 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  			continue;
> > >  		}
> > >  
> > > -		/* If details->check_mapping, we leave swap entries. */
> > > -		if (unlikely(details))
> > > -			continue;
> > > -
> > 
> > Good.
> > 
> > >  		if (!non_swap_entry(entry))
> > >  			rss[MM_SWAPENTS]--;
> > >  		else if (is_migration_entry(entry)) {
> > >  			struct page *page;
> > >  
> > >  			page = pfn_swap_entry_to_page(entry);
> > > +			if (unlikely(zap_skip_check_mapping(details, page)))
> > > +				continue;
> > 
> > Good; though I don't think it's worth an "unlikely", and I say again,
> 
> Sure, I'll drop this "unlikely".  Meanwhile, shall we drop all the rest of the
> "unlikely" too around this check?
> 
> > more forcefully, that "zap_skip_check_mapping" is a terrible name.
> > 
> > David suggested naming its inversion should_zap_page(), yes, that's
> > much better; I'd toyed with do_not_zap_page() and zap_skip_page(),
> > but should_zap_page() for the inversion sounds good to me.
> 
> Ah sure, I'll rename it to should_zap_page() in a new patch before this.
> 
> > 
> > And I'm pleased to see in one of Matthew's diffs that he intends to
> > bring zap_details and zap_skip_check_mapping() back into mm/memory.c
> > from include/linux/mm.h.
> 
> Yeah it's only used in memory.c.  I put it there initially because I wanted
> zap_details user can reference what's that check mapping is all about, but
> maybe that's not necessary.
> 
> If you or Matthew could provide a link to that patch, I'll be happy to pick
> that up too with this series.  Or I can also do nothing assuming Matthew will
> handle it elsewhere.
> 
> > 
> > >  			rss[mm_counter(page)]--;
> > >  		}
> > >  		if (unlikely(!free_swap_and_cache(entry)))
> > > -- 
> > > 2.32.0
> > 
> > History.  zap_details came in 2.6.6, and it was mostly to manage
> > truncation on the non-linear vmas we had at that time (remap_file_pages
> > syscall packing non-sequential offsets into a single vma, with pte_file
> > entries), where index could not be deduced from position of pte in vma:
> > truncation range had to be passed down in zap_details; and an madvise
> > needed it too, so it could not be private to mm/memory.c then.
> > 
> > But at the same time, I added the even_cows argument to
> > unmap_mapping_range(), to distinguish truncation (which POSIX requires
> > to unmap even COWed pages) from invalidation (for page cache coherence,
> > which shouldn't touch private COWs).  However, there appear to be no
> > users of that in 2.6.6, though I wouldn't have added that complication
> > just for the fun of confusing everyone: best guess would be that there
> > was parallel development, and the use for !even_cows got removed in
> > the very same release that it was being added.
> > 
> > (PageAnon was brand new in 2.6.6: maybe it could have been used instead
> > of comparing details->check_mapping, or maybe there's some other case
> > I've forgotten which actually needs the exact mapping check.)
> > 
> > Eventually a few drivers came to use unmap_shared_mapping_range(),
> > the !even_cows caller; but more to the point, hole-punching came in,
> > and I felt very strongly that hole-punching on a file had no right
> > to delete private user data.  So then !even_cows became useful.
> > 
> > IIRC, I've seen Linus say he *detests* zap_details.  It had much better
> > justification in the days of non-linear, and I was sad to add
> > single_page to it quite recently; but hope that can go away later
> > (when try_to_unmap_one() is properly extended to THPs).
> > 
> > Now, here's what may clear up a lot of the confusion.
> > The 2.6.7 zap_pte_range() got a line at the head of zap_pte_range()
> > 	if (details && !details->check_mapping && !details->nonlinear_vma)
> > 		details = NULL;
> > which paired with the
> > 		/*
> > 		 * If details->check_mapping, we leave swap entries;
> > 		 * if details->nonlinear_vma, we leave file entries.
> > 		 */
> > 		if (unlikely(details))
> > 			continue;
> > lower down.  I haven't followed up the actual commits, but ChangeLog-2.6.7
> > implies that 2.6.6 had a "details = NULL;" placed elsewhere but buggily.
> > In 2.6.12 it moved from zap_pte_range() to unmap_page_range().
> > It was intended, not so much to optimize, as to simplify the flow;
> > but in fact has caused all this confusion.
> > 
> > When Kirill discontinued non-linear mapping support in 4.0 (no tears
> > were shed and) the nonlinear_vma comment above got deleted, leaving
> > just the then more puzzling check_mapping comment.
> > 
> > Then in 4.6 the "details = NULL;" seems to have got deleted as part of
> > aac453635549 ("mm, oom: introduce oom reaper"), which added some new
> > details (ignore_dirty and check_swap_entries); which got reverted in
> > 4.11, but apparently the "details = NULL;" not restored.
> > 
> > My stamina is suddenly exhausted, without actually pinpointing a commit
> > for "Fixes:" in your eventual cleanup.  Sorry, I've had enough!
> 
> Yeah it's in most cases a pain for digging all these trivial details, thanks
> for digging already most of it out of the mist.
> 
> That's really what I hope this patch can help: not only because the uffd work
> will rely on it, but also on resolving this early (we do use some wordings like
> "technical debt" sometimes, I think it's the same here but different form) when
> the above "history.git" is still functional so we can still reference.
> 
> With your help and the history.git I can try a better commit message because
> obviously some of the contents needs amending (it's not a pure optimization at
> all), but I assume the patch content will be mostly the same, with the tweaks
> applied.
> 
> Per stated so far I don't know any real reproducer so maybe it's not a real
> issue in any production system?  Maybe that'll make it a bit easier, because
> then we don't strongly require a Fixes (which could be another hard question to
> answer besides the issue itself).
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

--lt/KuCbYLL0lbsbj
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="zap-migrate.c"

#define _GNU_SOURCE             /* See feature_test_macros(7) */
#include <fcntl.h>
#include <stdio.h>
#include <numaif.h>
#include <unistd.h>
#include <sys/mman.h>
#include <assert.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

#define BSIZE (1UL << 28)       /* 64MB */
#define DELAY 30                /* Something bigger than 10 */

int page_size, npages, *status, *nodes;
pthread_t thread;
char *buffer;
void **pages;
sem_t sem;
char str[4096];
int shmem_fd;

void *evictor_thread(void *data)
{
    int i, ret;

    printf("evictor created\n");

    for (i = 0; i < npages; i++) {
        sem_wait(&sem);
        usleep(random() % DELAY);
        ret = fallocate(shmem_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                        i * page_size, page_size);
        assert(ret == 0);
    }

    printf("evictor quitted\n");

    return NULL;
}

void do_init(void)
{
    int i, ret;

    srand(time(NULL));

    sem_init(&sem, 0, 0);
    page_size = getpagesize();
    npages = BSIZE / page_size;

    shmem_fd = memfd_create("zap-migrate", 0);
    assert(shmem_fd >= 0);

    ret = ftruncate(shmem_fd, BSIZE);
    assert(ret == 0);

    buffer = mmap(NULL, BSIZE, PROT_READ | PROT_WRITE,
                  MAP_SHARED, shmem_fd, 0);
    assert(buffer != MAP_FAILED);

    pages = calloc(npages, sizeof(void *));
    status = calloc(npages, sizeof(int));
    nodes = calloc(npages, sizeof(int));
    assert(pages && status && nodes);

    for (i = 0; i < npages; i++) {
        *(buffer + page_size * i) = i;
    }

    ret = pthread_create(&thread, NULL, evictor_thread, NULL);
    assert(ret == 0);
}

void do_quit(void)
{
    free(pages);
    free(status);
    free(nodes);
    munmap(buffer, BSIZE);
    close(shmem_fd);
}

void move_all_to_node(int node)
{
    long ret;
    int i;

    for (i = 0; i < npages; i++) {
        pages[i] = buffer + page_size * i;
        nodes[i] = node;
        status[i] = 0;
    }

    ret = move_pages(0, npages, pages, nodes, status, MPOL_MF_MOVE);
    assert(ret == 0);

    printf("%s node=%d\n", __func__, node);
}

void move_each_to_node(int node)
{
    long ret;
    int i;

    for (i = 0; i < npages; i++) {
        pages[0] = buffer + page_size * i;
        nodes[0] = node;
        status[0] = -1;

        /* Kick the evictor */
        sem_post(&sem);
        usleep(10);
        ret = move_pages(0, 1, pages, nodes, status, MPOL_MF_MOVE);
        assert(ret == 0);
    }

    printf("%s node=%d\n", __func__, node);
}

void check(void)
{
    pid_t pid = getpid();
    int fd, ret;
    char *p, *end;

    sprintf(str, "/proc/%d/smaps_rollup", pid);
    printf("Dump file: %s\n==========\n", str);
    fd = open(str, O_RDONLY);
    assert(fd >= 0);

    while (1) {
        ret = read(fd, str, sizeof(str)-1);
        assert(ret >= 0);
        if (ret == 0)
            break;
    }

    p = strstr(str, "Pss_Shmem:");
    end = strchr(p, '\n');
    *end = 0;
    printf("%s\n", p);

    close(fd);
}

void main(void)
{
    do_init();
    move_all_to_node(0);
    move_each_to_node(1);
    /* Make sure madvise() all ran */
    pthread_join(thread, NULL);
    /* Should be "0KB" */
    check();
    do_quit();
}

--lt/KuCbYLL0lbsbj--

