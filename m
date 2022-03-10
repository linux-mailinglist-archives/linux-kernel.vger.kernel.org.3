Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7084D4F43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiCJQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbiCJQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:29:46 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203F4CD49
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:28:45 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g1so11953309ybe.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCmTmDIULOozSrwQB+RZx6LIMi9PHUhNmxXBcwVEqBI=;
        b=NIrtWgeox+THnUtkq2c9KwIV7pR3KuQcyV1lIZ4k/4tK266hqCj0gxk5mcN7Zlo5RK
         kv+PTtNoRw14gWpZ4DfxWr1ToZYyMxMeG1dMp48HC7/cWFOapZVdBqa2i55qj1D7Dr96
         Xzs4U2vXQ+ylEbXHPMresqa2vI2DuFaJwB7m40ef3LqoAuejH0Jd1oBCj0+1x9v3/MdB
         xQOF0KtlzO75qGRXIY/6AjMpKI783AUYvmN7PlgrvdXzUIwQuvv5zjRelJfZRiuTSl1U
         Yjqe0I8OseDSvpi7yxIF9tWfOMcjTGClVyB+pJDqoNInbeSf8485lHvRFsA+C/+NMyv5
         A2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCmTmDIULOozSrwQB+RZx6LIMi9PHUhNmxXBcwVEqBI=;
        b=d1M+BFE1CzvqQID74bjr0HqGnV9li9MpVlHCd49hFDZmJXkZ+9vMQBfmEKfksLKmji
         yuTTq6sBzy/ZuvrxsZ8TCZJthPhuaDdccAk2W/mNAbavQQKcQInMv6UCh1lagUZzuOgu
         gGo6OapJpglto9jyfcKKpHhLcz1AQmyTBaaShQsx1HdziofZ1WWQD8XCwGL6QxlEN+ap
         HHcm4ze2el7ZhZr+lRDlfI0vok9bcxe5UjZIYeMEg1lT1QS1ainxWDKe0twV6ZFZ788m
         1zvhuE2fhnBBgoj4AuzaBsvwx2xqyLqbtCBS7ntyK33fOFmvOTYZyFHqFZTqeo6vvM8S
         Wttw==
X-Gm-Message-State: AOAM5301JvAHz+aS9j9m9uTKit+80nKs+Z1lwziQn0NxrUQukmDu2WWf
        a/B6tuCa8ymQf1iD1x/ZJRrN3crvs5Gy7D5Zges+dw==
X-Google-Smtp-Source: ABdhPJxYOldag4Zl+3/XgyPjYH24IVzC25AgQCcRlkznI9lMRHpIjirNsoWgGfK/aipoEHd2eDaaUxuH68qS65mUOuo=
X-Received: by 2002:a25:718b:0:b0:62c:16d8:d17f with SMTP id
 m133-20020a25718b000000b0062c16d8d17fmr4465877ybc.553.1646929724353; Thu, 10
 Mar 2022 08:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com> <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
 <YhhZsv+czqQPKvvN@casper.infradead.org> <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
 <20220310155454.g6lt54yxel3ixnp3@revolver>
In-Reply-To: <20220310155454.g6lt54yxel3ixnp3@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Mar 2022 08:28:33 -0800
Message-ID: <CAJuCfpHk+1snrPx-_qvj=kjSOS+o=L90evAQ1gD5hj6XxB=a3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>, "riel@surriel.com" <riel@surriel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jengelh@inai.de" <jengelh@inai.de>,
        "timmurray@google.com" <timmurray@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com" 
        <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
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

On Thu, Mar 10, 2022 at 7:55 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [220225 00:51]:
> > On Thu, Feb 24, 2022 at 8:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> > > > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > > > > otherwise it points to a vma that was freed and when reused leads to
> > > > > a use-after-free bug.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > >             vma = remove_vma(vma);
> > > > >             cond_resched();
> > > > >     }
> > > > > +   mm->mmap = NULL;
> > > > >     mmap_write_unlock(mm);
> > > > >     vm_unacct_memory(nr_accounted);
> > > > >  }
> > > >
> > > > After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
> > > > revert this fix as part of merging the maple-tree parts of linux-next.
> > > > I'll be sending this fix to Linus this week.
> > > >
> > > > All of which means that the thusly-resolved Maple tree patches might
> > > > reintroduce this use-after-free bug.
> > >
> > > I don't think so?  The problem is that VMAs are (currently) part of
> > > two data structures -- the rbtree and the linked list.  remove_vma()
> > > only removes VMAs from the rbtree; it doesn't set mm->mmap to NULL.
> > >
> > > With maple tree, the linked list goes away.  remove_vma() removes VMAs
> > > from the maple tree.  So anyone looking to iterate over all VMAs has to
> > > go and look in the maple tree for them ... and there's nothing there.
> >
> > Yes, I think you are right. With maple trees we don't need this fix.
>
>
> Yes, this is correct.  The maple tree removes the entire linked list...
> but since the mm is unstable in the exit_mmap(), I had added the
> destruction of the maple tree there.  Maybe this is the wrong place to
> be destroying the tree tracking the VMAs (althought this patch partially
> destroys the VMA tracking linked list), but it brought my attention to
> the race that this patch solves and the process_mrelease() function.
> Couldn't this be avoided by using mmget_not_zero() instead of mmgrab()
> in process_mrelease()?

That's what we were doing before [1]. That unfortunately has a problem
of process_mrelease possibly calling the last mmput and being blocked
on IO completion in exit_aio. The race between exit_mmap and
process_mrelease is solved by using mmap_lock.
I think by destroying the maple tree in exit_mmap before the
mmap_write_unlock call, you keep things working and functionality
intact. Is there any reason this can't be done?

[1] ba535c1caf3ee78a ("mm/oom_kill: allow process_mrelease to run
under mmap_lock protection")

> That would ensure we aren't stepping on an
> exit_mmap() and potentially the locking change in exit_mmap() wouldn't
> be needed either?  Logically, I view this as process_mrelease() having
> issue with the fact that the mmaps are no longer stable in tear down
> regardless of the data structure that is used.
>
> Thanks,
> Liam
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
