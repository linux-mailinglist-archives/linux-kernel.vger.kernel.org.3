Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA752F061
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351506AbiETQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbiETQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:17:41 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91B6D878
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:17:38 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ec42eae76bso92099027b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONhZlVBI4HpQAKHE0J0FctRsQVKq+x2f4PkT65aBxxg=;
        b=dmedB56pvgqE7vaxmJFTfngnHOclw61WJgI459OreAQ/EWhACPq1JJTl+tBexbZd3/
         clCCW9wARLONeh60N3DHvB3Y1BQSNmngLUMTLBYkUFbVhQ6Zz3TAdZGwd7Tln+nw7vlY
         EKu+sLeAsRK/llsvB/Yx1bKeOwOhQEFTd1IoLVIkMHpkjORtv2JjeJV7qfRNvyIkyGHN
         JRCl3PyDvndsxDY2oDtf4qdb8KvcbW1aDVsv71H918s88KQnwhUnG1Jape1XL5qZ/FaG
         q93yLWhQIvyuE5w/PihuBY6NuvMO0Dj6/jwlAWaDYA9KwYqGc88G1WBjRWJcaX1aRoMs
         NGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONhZlVBI4HpQAKHE0J0FctRsQVKq+x2f4PkT65aBxxg=;
        b=hCYOMRftGm8/mFjcyo4wMTqSTUJ8iIzsH/QUHpP1sMKgc06Fy+MSbQjH62xSn6oiGp
         hJ86GeuaWTZcxB68CgrbemFS0z7XL+ABQgR16IP8nVFXYq9KX6k27FxQCb5Z/dmGHzRA
         MvwkjRkV+sOWRpjGhJoY5HitF/c03rEMK7uDYKt8G1nCjFLV8y+ZgADCUEdmO1pQVR6y
         jubEE0V1ZG0rwUg7DJ3I780+HIriooxfo42It5Jo3qmCU1CDci7bhbAMIQs4PYbo2Zsz
         mwHHzrOsFy5IHtjddpMvk3AoibGDQKe5eH2HqLzqnZsLObQLbteZEpbp+vfwc/m+S+Yl
         7AfA==
X-Gm-Message-State: AOAM532MVaA0lc7sh+k5ni4fK2Qd5MpOKDGvLZpNncuJwt0VK23XjkE6
        1uYyDdQUkK2nPRKbVxyFWV6MpzmaG7jA03IEPZGcwQ==
X-Google-Smtp-Source: ABdhPJxejo+Y7HD7oOOqHmw/rRbhZxiq5xDx278bG4dQMkXbrxvg4BAUzigZhBuAL0J1/93WzXPhH+PrBEck7JSuTNI=
X-Received: by 2002:a81:557:0:b0:2ff:a20c:4bfc with SMTP id
 84-20020a810557000000b002ffa20c4bfcmr969269ywf.293.1653063457607; Fri, 20 May
 2022 09:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220516075619.1277152-1-surenb@google.com> <20220519202149.3ywynqhbxlzp6uyn@revolver>
 <CAJuCfpHeAXSLjrXxgRaTXOEPPipcFq5MhP=uU0wkqeBoPUAcsQ@mail.gmail.com>
 <YodBhjkyNtc+Une7@dhcp22.suse.cz> <CAJuCfpE2EB88uNUq=ohphKOecPoYZT9ypX8=fzxMgR6BviUibQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE2EB88uNUq=ohphKOecPoYZT9ypX8=fzxMgR6BviUibQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 May 2022 09:17:26 -0700
Message-ID: <CAJuCfpHf38Z-svRsFaaZs2H7Q=KbSFBdi60wPYTFuSbXV+Mv1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 8:55 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, May 20, 2022 at 12:21 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 19-05-22 14:33:03, Suren Baghdasaryan wrote:
> > > On Thu, May 19, 2022 at 1:22 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > [...]
> > > > arch_exit_mmap() was called under the write lock before, is it safe to
> > > > call it under the read lock?
> > >
> > > Ah, good catch. I missed at least one call chain which I believe would
> > > require arch_exit_mmap() to be called under write lock:
> > >
> > > arch_exit_mmap
> > >     ldt_arch_exit_mmap
> > >         free_ldt_pgtables
> > >             free_pgd_range
> >
> > Why would be this a problem? This is LDT mapped into page tables but as
> > far as I know oom_reaper cannot really ever see that range because it is
> > not really reachable from any VMA.
>
> Ah, thanks! I didn't realize these page tables are not reachable from
> VMAs. The only other call that I'm not sure is ok without mmap write
> lock is xen_hvm_exit_mmap:
>
> arch_exit_mmap
>     paravirt_arch_exit_mmap
>         xen_hvm_exit_mmap
>
> I'll look closer today but if someone can confirm it's safe then my
> current patch should be fine as is.

My conclusion is that it's safe to call arch_exit_mmap without
exclusive mmap lock since the only possible competition is from
OOM-killer/process_mrelease which operate on mm->mmap and none of the
arch_exit_mmap implementations use mm->mmap.

Andrew, sorry for going back and forth. I think the patch is fine as
is and can be integrated. Thanks!


> Thanks,
> Suren.
>
> >
> > > I'll need to check whether arch_exit_mmap() has to be called before
> > > unmap_vmas(). If not, we could move it further down when we hold the
> > > write lock.
> > > Andrew, please remove this patchset from your tree for now until I fix this.
> > >
> > > >
> > > > >
> > > > >       vma = mm->mmap;
> > > > >       if (!vma) {
> > > > >               /* Can happen if dup_mmap() received an OOM */
> > > > > -             mmap_write_unlock(mm);
> > > > > +             mmap_read_unlock(mm);
> > > > >               return;
> > > > >       }
> > > > >
> > > > > @@ -3138,6 +3121,16 @@ void exit_mmap(struct mm_struct *mm)
> > > > >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> > > > >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> > > > >       unmap_vmas(&tlb, vma, 0, -1);
> > > > > +     mmap_read_unlock(mm);
> > > > > +
> > > > > +     /*
> > > > > +      * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
> > > > > +      * because the memory has been already freed. Do not bother checking
> > > > > +      * mm_is_oom_victim because setting a bit unconditionally is cheaper.
> > > > > +      */
> > > > > +     set_bit(MMF_OOM_SKIP, &mm->flags);
> > > > > +
> > > > > +     mmap_write_lock(mm);
> > > >
> > > > Is there a race here?  We had a VMA but after the read lock was dropped,
> > > > could the oom killer cause the VMA to be invalidated?
> >
> > Nope, the oom killer itself doesn't do much beyond sending SIGKILL and
> > scheduling the victim for the oom_reaper. dup_mmap is holding exclusive
> > mmap_lock throughout the whole process.
> >
> > > > I don't think so
> > > > but the comment above about dup_mmap() receiving an OOM makes me
> > > > question it.  The code before kept the write lock from when the VMA was
> > > > found until the end of the mm edits - and it had the check for !vma
> > > > within the block itself.  We are also hiding it from the oom killer
> > > > outside the read lock so it is possible for oom to find it in that
> > > > window, right?
> >
> > The oom killer's victim selection doesn't really depend on the
> > mmap_lock. If there is a race and MMF_OOM_SKIP is not set yet then it
> > will consider the task and very likely bail out anyway because the
> > address space has already been unampped so oom_badness() would consider
> > this task boring.
> >
> > oom_reaper on the other hand would just try to unmap in parallel but
> > that is fine regardless of MMF_OOM_SKIP. Seeing the flag would allow to
> > bail out early rather than just trying to unmap something that is no
> > longer there. The only problem for the oom_reaper is to see page tables
> > of the address space disappearing from udner its feet. That is excluded
> > by the the exlusive lock and as Suren mentions mm->mmap == NULL check
> > if the exit_mmap wins the race.
> > --
> > Michal Hocko
> > SUSE Labs
