Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6F4830E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiACMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:11:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiACMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:11:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E71E21F38B;
        Mon,  3 Jan 2022 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641211900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TTdWlpJiyz+unQlc+Mpojg65so9ozifMkXUPRCYLBWk=;
        b=HN4nwCpsxpykgXN8qLhWazCRr/kac2pKlzvFMQ8MD7Z4sw8fdGlIQUu+PhTtbFBgWlRgXx
        MVWPuiKeWlJvBpEICv31Yny/Hf0KtP0cYtLm05EnEPL/8cwN6spHsAOdKxtnSLU0qNFG87
        qXJ4BFYng8ay3+onsAWV9GAo2OqaM3g=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0D9EA3B81;
        Mon,  3 Jan 2022 12:11:39 +0000 (UTC)
Date:   Mon, 3 Jan 2022 13:11:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
Message-ID: <YdLn+192/0HfNJyl@dhcp22.suse.cz>
References: <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz>
 <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
 <Ybsn2hJZXRofwuv+@cmpxchg.org>
 <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
 <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com>
 <Yc1spBeXal373b4A@dhcp22.suse.cz>
 <CAJuCfpGNCX=Z=Bi0N7DAj=CXdLqJOqQ_8kq_HQNaLhAvA5tjPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGNCX=Z=Bi0N7DAj=CXdLqJOqQ_8kq_HQNaLhAvA5tjPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-12-21 09:29:40, Suren Baghdasaryan wrote:
> On Thu, Dec 30, 2021 at 12:24 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 29-12-21 21:59:55, Suren Baghdasaryan wrote:
> > [...]
> > > After some more digging I think there are two acceptable options:
> > >
> > > 1. Call unlock_range() under mmap_write_lock and then downgrade it to
> > > read lock so that both exit_mmap() and __oom_reap_task_mm() can unmap
> > > vmas in parallel like this:
> > >
> > >     if (mm->locked_vm) {
> > >         mmap_write_lock(mm);
> > >         unlock_range(mm->mmap, ULONG_MAX);
> > >         mmap_write_downgrade(mm);
> > >     } else
> > >         mmap_read_lock(mm);
> > > ...
> > >     unmap_vmas(&tlb, vma, 0, -1);
> > >     mmap_read_unlock(mm);
> > >     mmap_write_lock(mm);
> > >     free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > > ...
> > >     mm->mmap = NULL;
> > >     mmap_write_unlock(mm);
> > >
> > > This way exit_mmap() might block __oom_reap_task_mm() but for a much
> > > shorter time during unlock_range() call.
> >
> > IIRC unlock_range depends on page lock at some stage and that can mean
> > this will block for a long time or for ever when the holder of the lock
> > depends on a memory allocation. This was the primary problem why the oom
> > reaper skips over mlocked vmas.
> 
> Oh, I missed that detail. I thought __oom_reap_task_mm() skips locked
> vmas only to avoid destroying pgds from under follow_page().
> 
> >
> > > 2. Introduce another vm_flag mask similar to VM_LOCKED which is set
> > > before munlock_vma_pages_range() clears VM_LOCKED so that
> > > __oom_reap_task_mm() can identify vmas being unlocked and skip them.
> > >
> > > Option 1 seems cleaner to me because it keeps the locking pattern
> > > around unlock_range() in exit_mmap() consistent with all other places
> > > it is used (in mremap() and munmap()) with mmap_write_lock taken.
> > > WDYT?
> >
> > It would be really great to make unlock_range oom reaper aware IMHO.
> 
> What exactly do you envision? Say unlock_range() knows that it's
> racing with __oom_reap_task_mm() and that calling follow_page() is
> unsafe without locking, what should it do?

My original plan was to make the page lock conditional and use
trylocking from the oom reaper (aka lockless context). It is OK to
simply bail out and leave some mlocked memory behind if there is a
contention on a specific page. The overall objective is to free as much
memory as possible, not all of it.

IIRC Hugh was not a fan of this approach and he has mentioned that the
lock might not be even really needed and that the area would benefit
from a clean up rather than oom reaper specific hacks. I do tend to
agree with that. I just never managed to find any spare time for that
though and heavily mlocked oom victims tend to be really rare.
-- 
Michal Hocko
SUSE Labs
