Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBE4BAA50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbiBQTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:51:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbiBQTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:51:40 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC2B36
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:51:25 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id c6so15271852ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jryiGjlume1avE0nsXsIbeMADBBTK4iBFr1fN/zx7xI=;
        b=LFHKSYbQ9j0BjbMyECpe/4RG1CjldG5NAOliAwmo3RNkBPKYZYRDdAGFmmA6wdc/W5
         tJZIQ1tmRqq8g5hYkbHjr5lYGWY4GUkP6J3xRaZIWsERyOcXejpwykgcoytap+t6bqdW
         bNh8vEDbkOkesymqFCZ/O/vFmBPBVepfWwEA0ZNe5qNfMonm2T+B3sSFiT2sLsBMrzIZ
         LRE9iBINIXSIb0Pf6TEL5CDBGLYB1mHukbxfL/tZkCoSBbXVUqCd/yVtfDbANAcp9Fg7
         cEFxjT/ZQLxnqwwvKuSgAbrXxUKIlH8ljzNM9vXTPgWD6FNfGKcvR54Ba6wEezji+4Aa
         ze1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jryiGjlume1avE0nsXsIbeMADBBTK4iBFr1fN/zx7xI=;
        b=oWGoFeAm0+qZdHd7IOIh5wm/VSFBJ16BFR1ZnAfxGdfWIw5hXh9X3gvGBFXDVLTtZ7
         5782SLwRdNZ7FB1PrDf8POoPHQ7pJPs/1s57I6KL+mNDVp5SEqU1gf0SW3kGxnQafB+M
         AR5JUa6nh0cp1KiUU+mBz4IyRDeyfkiySWAXG1Gro1+/4LazPXB8zfUeXK+z1L4y9jo5
         SRWnUWKeXZ3WnZbx06Zk3Jmnfs0Uwmc8Tt+lKMF66UGiRBkCbKXQig6icFKuK+qjcg0I
         mwGi8DY6HW1gz+aFxrGz5xMKBpSjqg2ihrddBi4eB3gmaT3dJr5SElKt+9p7NBGuOYkK
         uyxA==
X-Gm-Message-State: AOAM530x2P96eToQnvKFA+/sPwWu5OS7EKsj4GVi6Q8iUDZ8AnnpKlqj
        VCKRq5GRc+oiyuDzlqP4AovKzFDvcLK3O2msvmT5HA==
X-Google-Smtp-Source: ABdhPJzxqPn7mNSisAbwdIqP5U+zn0Q5PNQ+IylCM2XJgBzLg5RLl3By0J7TMxLu1CTI2t95zvvvpYUiIg+Wa64ZwBc=
X-Received: by 2002:a25:d986:0:b0:624:ddc:ff9 with SMTP id q128-20020a25d986000000b006240ddc0ff9mr3896252ybg.509.1645127484367;
 Thu, 17 Feb 2022 11:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com> <YgytzntIfx6Toom2@dhcp22.suse.cz>
In-Reply-To: <YgytzntIfx6Toom2@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 17 Feb 2022 11:51:13 -0800
Message-ID: <CAJuCfpFL9AQxNsjKxDHhu7UgMGETs+h9Avi6o1mQkvZ4N7CTRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
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

On Tue, Feb 15, 2022 at 11:54 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 15-02-22 12:19:22, Suren Baghdasaryan wrote:
> > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > otherwise it points to a vma that was freed and when reused leads to
> > a use-after-free bug.
>
> OK, so I have dived into this again. exit_mmap doesn't reset mmap
> indeed.  That doesn't really matter for _oom victims_. Both the oom reaper and
> mrelease do check for MMF_OOM_SKIP before calling __oom_reap_task_mm.
> exit_mmap still sets MMF_OOM_SKIP before taking the mmap_lock for oom
> victims so those paths should be still properly synchronized.  I have
> proposed to get rid of this
> http://lkml.kernel.org/r/YbHIaq9a0CtqRulE@dhcp22.suse.cz but we haven't
> agreed on that.
>
> mrelease path is broken because it doesn't mark the process oom_victim
> and so the MMF_OOM_SKIP synchronization doesn't work. So we really need
> this.
>
> I would propose to rephrase the changelog to be more specific because I
> do not want to remember all those details later on.
> What about
> "
> oom reaping (__oom_reap_task_mm) relies on a 2 way synchronization with
> exit_mmap. First it relies on the mmap_lock to exclude from unlock
> path[1], page tables tear down (free_pgtables) and vma destruction.
> This alone is not sufficient because mm->mmap is never reset. For
> historical reasons[2] the lock is taken there is also MMF_OOM_SKIP set
> for oom victims before.
>
> The oom reaper only ever looks at oom victims so the whole scheme works
> properly but process_mrelease can opearate on any task (with fatal
> signals pending) which doesn't really imply oom victims. That means that
> the MMF_OOM_SKIP part of the synchronization doesn't work and it can
> see a task after the whole address space has been demolished and
> traverse an already released mm->mmap list. This leads to use after free
> as properly caught up by KASAN report.
>
> Fix the issue by reseting mm->mmap so that MMF_OOM_SKIP synchronization
> is not needed anymore. The MMF_OOM_SKIP is not removed from exit_mmap
> yet but it acts mostly as an optimization now.
>
> [1] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap,
> v3")
> [2] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run
> concurrently")
> "

This changelog is very detailed and I support switching to it. Andrew,
please let me know if I should re-post the patch with this description
or you will just amend the one in your tree.

>
> I really have to say that I hate how complex this has grown in the name
> of optimizations. This has backfired several times already resulting in
> 2 security issues. I really hope to get read any note of the oom reaper
> from exit_mmap.

Agree. I want to take another stab at removing __oom_reap_task_mm from
exit_mmap. Now that Hugh made changes to mlock mechanisms and
__oom_reap_task_mm does not skip locked vmas I think that should be
possible. Planning to look into that sometimes next week.

>
> > Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> Thanks!
> > ---
> >  mm/mmap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 1e8fdb0b51ed..d445c1b9d606 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> >               vma = remove_vma(vma);
> >               cond_resched();
> >       }
> > +     mm->mmap = NULL;
> >       mmap_write_unlock(mm);
> >       vm_unacct_memory(nr_accounted);
> >  }
> > --
> > 2.35.1.265.g69c8d7142f-goog
>
> --
> Michal Hocko
> SUSE Labs
