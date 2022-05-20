Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4A52E618
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbiETHVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346276AbiETHVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:21:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE0699680
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:21:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 17B021F975;
        Fri, 20 May 2022 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653031303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TBN5hB0/WPFsCGSSaSWI79+b/MCuCRipw2TznjIJXMM=;
        b=UAPf2WrwRzaKaTOqud9B3Zxza6x0ksyxYqr57T0xLu4aZEgB+f2r3BsBe4mb1sofkwwOXh
        MUB1lYGzME/Ar3aV4GRM9p8wJJyAc4PEV19TOAdIX5vzb6l0vGkoqq3PJf+sWb/LQuWH+N
        uxCYlMHLQIyzCDF0TTs+0psO3Ofj5o0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9681D2C141;
        Fri, 20 May 2022 07:21:42 +0000 (UTC)
Date:   Fri, 20 May 2022 09:21:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
Message-ID: <YodBhjkyNtc+Une7@dhcp22.suse.cz>
References: <20220516075619.1277152-1-surenb@google.com>
 <20220519202149.3ywynqhbxlzp6uyn@revolver>
 <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-05-22 14:33:03, Suren Baghdasaryan wrote:
> On Thu, May 19, 2022 at 1:22 PM Liam Howlett <liam.howlett@oracle.com> wrote:
[...]
> > arch_exit_mmap() was called under the write lock before, is it safe to
> > call it under the read lock?
> 
> Ah, good catch. I missed at least one call chain which I believe would
> require arch_exit_mmap() to be called under write lock:
> 
> arch_exit_mmap
>     ldt_arch_exit_mmap
>         free_ldt_pgtables
>             free_pgd_range

Why would be this a problem? This is LDT mapped into page tables but as
far as I know oom_reaper cannot really ever see that range because it is
not really reachable from any VMA.

> I'll need to check whether arch_exit_mmap() has to be called before
> unmap_vmas(). If not, we could move it further down when we hold the
> write lock.
> Andrew, please remove this patchset from your tree for now until I fix this.
> 
> >
> > >
> > >       vma = mm->mmap;
> > >       if (!vma) {
> > >               /* Can happen if dup_mmap() received an OOM */
> > > -             mmap_write_unlock(mm);
> > > +             mmap_read_unlock(mm);
> > >               return;
> > >       }
> > >
> > > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> > >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> > >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > >       unmap_vmas(&tlb, vma, 0, -1);
> > > +     mmap_read_unlock(mm);
> > > +
> > > +     /*
> > > +      * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> > > +      * because the memory has been already freed. Do not bother checking
> > > +      * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> > > +      */
> > > +     set_bit(MMF_OOM_SKIP, &mm->flags);
> > > +
> > > +     mmap_write_lock(mm);
> >
> > Is there a race here?  We had a VMA but after the read lock was dropped,
> > could the oom killer cause the VMA to be invalidated?

Nope, the oom killer itself doesn't do much beyond sending SIGKILL and
scheduling the victim for the oom_reaper. dup_mmap is holding exclusive
mmap_lock throughout the whole process.

> > I don't think so
> > but the comment above about dup_mmap() receiving an OOM makes me
> > question it.  The code before kept the write lock from when the VMA was
> > found until the end of the mm edits - and it had the check for !vma
> > within the block itself.  We are also hiding it from the oom killer
> > outside the read lock so it is possible for oom to find it in that
> > window, right?

The oom killer's victim selection doesn't really depend on the
mmap_lock. If there is a race and MMF_OOM_SKIP is not set yet then it
will consider the task and very likely bail out anyway because the
address space has already been unampped so oom_badness() would consider
this task boring.

oom_reaper on the other hand would just try to unmap in parallel but
that is fine regardless of MMF_OOM_SKIP. Seeing the flag would allow to
bail out early rather than just trying to unmap something that is no
longer there. The only problem for the oom_reaper is to see page tables
of the address space disappearing from udner its feet. That is excluded
by the the exlusive lock and as Suren mentions mm->mmap == NULL check
if the exit_mmap wins the race.
-- 
Michal Hocko
SUSE Labs
