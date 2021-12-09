Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6597746F398
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhLITHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhLITHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:07:34 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC898C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:03:59 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e136so15991625ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=two5tWS0eGFOwgvR2SUAW/v768W9Njq3kAUeHb+0A4Q=;
        b=Lwiup1KxwBFyc07FAmO5nKhY05sgszhLXDqINwnOoO1lFEc8Y/u1J2GTVuy7p2BUzj
         fT7ftz1+EmywUzrlqjNoQ4YaC+RxQccsjCtTUku1d1TRQBu7eFY2grZ1yx8vcnvkL/cy
         WeTQX/cJPLqK15ZZ+nJpwJhqBZmqQVTKeukO52X1SRIOBJvhuMvx7Opwk5c/YDnX6r/K
         EdsTJpzMYmheZLwlHenEVAhnZWW9B3Hbd3PB6Q/vCSuUnoPp8JJHTP8jswnti+t7me7d
         KtA3DZRrG86Ne4ieRt9tWFoM9/NH3IP4yFxA4BLt9M9A9PE17J9vMLRkJ3ZR+0RbIXfz
         /yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=two5tWS0eGFOwgvR2SUAW/v768W9Njq3kAUeHb+0A4Q=;
        b=cT911RXUO4SnwTGIzAC93FBVs36WIw+4nKsc12BweuZB4tgSGFjOLSq8Nc6xnKPl90
         4Lxchk0dOgpH6pdnu76zF/o9zln+fJiy0MoMX5/5GvYLXf/q/UO0KQIrPyyQsH6FzziT
         RxqnVYZLYCQ4iyTWiHltdmhD9kDB3FyB4/YrqXZ4a0JaEkLKfRQqnQvSkbG/dCnNfDq8
         Aj3HAfgcjaQkNGHcdfzoJQCVTWwEmUfcKk+IayuW854OT1tbJGzrMe53m8NzbnS5jP+T
         coHaAbOQskOrA4G16U0m/EYPbZFmLyP6yP/q6bEo9lVi/5Qlm1gYXV6iGM5vzyH+J70v
         r7Pw==
X-Gm-Message-State: AOAM532IOxTExrcAY+Xhsu9dTCdjB0ydjaJ/GAj6qhV5hzWyF3R2gSwr
        d0QC5N/6UygLi3J4Tm+ujk9mImY6pnYf+CXKchY4Pg==
X-Google-Smtp-Source: ABdhPJyecQYcqcyB3VigbPT/iwpHLSqnyETAoJb0G5MHHeKta4v9w6O15VNzF6yzZaUdu3RkQuz6hcW7XgA+lP52SNI=
X-Received: by 2002:a25:a448:: with SMTP id f66mr8383450ybi.225.1639076637791;
 Thu, 09 Dec 2021 11:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <20211208212211.2860249-3-surenb@google.com>
 <YbHFVxd34P0CvfpG@dhcp22.suse.cz>
In-Reply-To: <YbHFVxd34P0CvfpG@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 9 Dec 2021 11:03:46 -0800
Message-ID: <CAJuCfpHQ0H+Uqb2J2iW4UtgEn+OogvByMzoKrthBaS9gR4OYug@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 12:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 08-12-21 13:22:11, Suren Baghdasaryan wrote:
> > With exit_mmap holding mmap_write_lock during free_pgtables call,
> > process_mrelease does not need to elevate mm->mm_users in order to
> > prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
> > is walking the VMA tree. The change prevents process_mrelease from
> > calling the last mmput, which can lead to waiting for IO completion
> > in exit_aio.
> >
> > Fixes: 337546e83fc7 ("mm/oom_kill.c: prevent a race between process_mrelease and exit_mmap")
>
> I am not sure I have brought this up already but I do not think Fixes
> tag is a good fit. 337546e83fc7 is a correct way to handle the race. It
> is just slightly less optimal than this fix.

Will post v5 without it. Thanks!

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
> > ---
> >  mm/oom_kill.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 1ddabefcfb5a..67780386f478 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1169,15 +1169,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >               goto put_task;
> >       }
> >
> > -     if (mmget_not_zero(p->mm)) {
> > -             mm = p->mm;
> > -             if (task_will_free_mem(p))
> > -                     reap = true;
> > -             else {
> > -                     /* Error only if the work has not been done already */
> > -                     if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> > -                             ret = -EINVAL;
> > -             }
> > +     mm = p->mm;
> > +     mmgrab(mm);
> > +
> > +     if (task_will_free_mem(p))
> > +             reap = true;
> > +     else {
> > +             /* Error only if the work has not been done already */
> > +             if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> > +                     ret = -EINVAL;
> >       }
> >       task_unlock(p);
> >
> > @@ -1188,13 +1188,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >               ret = -EINTR;
> >               goto drop_mm;
> >       }
> > -     if (!__oom_reap_task_mm(mm))
> > +     /*
> > +      * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
> > +      * possible change in exit_mmap is seen
> > +      */
> > +     if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> >               ret = -EAGAIN;
> >       mmap_read_unlock(mm);
> >
> >  drop_mm:
> > -     if (mm)
> > -             mmput(mm);
> > +     mmdrop(mm);
> >  put_task:
> >       put_task_struct(task);
> >       return ret;
> > --
> > 2.34.1.400.ga245620fadb-goog
>
> --
> Michal Hocko
> SUSE Labs
