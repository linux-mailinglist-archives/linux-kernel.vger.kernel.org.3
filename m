Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC347D1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbhLVM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbhLVM2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:28:16 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304DCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:28:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e8so1617783ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4l29Q6VoPrVDbqTDrgQxK8AEFTdPzsV04sjKB67kbI=;
        b=UfOW6bZROZBh8jBIS37Wyd4iiiqghB/jJFCpFdOvdcj0HVKKut7DCrXpCwGMYozN5d
         Rm7MFtcVBEKb/KY7mPFsGy3ZuGWX920HuPsBPjGE8jNDe3rWUN5nm602PM5ti4t7v1Qc
         wDHpvhD+zwAw83MBBp++0uwIxgPs/HPEjeRG5plHKNThNlVoSlMmSsO1MYTYpHSmErBE
         w3kQL23Cx+XUPdVphQqAweWqJEVat4ZeU2cdpuMJpfDe59KNP0PTP16h9KCKXOa3Gnzz
         sFOe9GIHfawHs7alESYAwqVezqmBnJRY5j79wKrRVZ62E2H1Mbie2fTuIGtZ/CEFTmvb
         2IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4l29Q6VoPrVDbqTDrgQxK8AEFTdPzsV04sjKB67kbI=;
        b=n/ocJI2xjWBKkmgOGz9NwqMd2ai0S4dXbkRVeV1oTWJoGDIsvtaziZL0ScJtiDQ/11
         +mJYvA6AKn1o8BMwFYT+BP0AHga2l2JlncAxLwlyf8rq4l+xf+BFmOT8dIa+XpxP35eT
         y7oJDIKsThvDGZiApx8UWBWudcsJK2b8u91AWEO6FjBu0mm/pJR3EOBbsbEo3X+DBAr4
         iUZ2dwKHz+4bdFXsgnpM07O9XHztY9JN73IkCEifI1aEuJwBXf+vX6o8VFk2ufRjlDSt
         1lkAeitZyWa5twsF71VQqugxu9svTsS+tYNLjSSeeYFE+tvxQ/JJC+PL2bhUuukpR3v0
         ZxQQ==
X-Gm-Message-State: AOAM530ADRFuhIWil+VZlPn48Fln+HDe5ED7MWgsGz/+wjZ798jZQApC
        pI9HRQtljlqdO4KDdXomBh6guIKXb+4UjtG5My9MIUCJ5Jhumw==
X-Google-Smtp-Source: ABdhPJx4/aiIHsO45e5hcxwnfFmSy4ZwcallxSaxHS07Wr48pd3Y8QNGwgy+nBuOglmLdDxxAA8t5lLX+FsHnRw7LHQ=
X-Received: by 2002:a05:6e02:20ee:: with SMTP id q14mr1201784ilv.44.1640176095373;
 Wed, 22 Dec 2021 04:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20211221170348.1113266-1-nogikh@google.com> <20211221170348.1113266-2-nogikh@google.com>
 <CANpmjNMAWuE0Y20ZuBUSRXkvWZd8NC1d=DDYYrEZytJz9ndxeA@mail.gmail.com>
In-Reply-To: <CANpmjNMAWuE0Y20ZuBUSRXkvWZd8NC1d=DDYYrEZytJz9ndxeA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 22 Dec 2021 13:28:04 +0100
Message-ID: <CANp29Y64kQ01XTi422jowTh+PFYKxXcLY1NP=is-3cP1n6YpgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kcov: split ioctl handling into locked and
 unlocked parts
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> To do that, you'd have to add the locking around KCOV_INIT_TRACE here,

Argh, indeed! Thanks, I'll fix it in v3.

> Also, I find that kcov_ioctl_unlocked() isn't a very descriptive name,
since now we have both locked and unlocked variants. What is it
actually doing?

The main motivation behind introducing that function was to get the
ability to do some processing outside of a spin lock without major
code refactoring. So it kind of wraps the existing ioctl processing
and, if it's KCOV_INIT_TRACE, performs the action itself.

I'm now thinking that we could probably do without introducing an
extra function at all - by moving `spin_lock_irqsave (&kcov->lock,
flags);` and `spin_unlock_irqrestore(&kcov->lock, flags);` into the
`kcov_ioctl_locked` function (and rename it into sth like
`kcov_do_ioctl`). So it could look like this:

switch (cmd) {
case KCOV_INIT_TRACE:
//...
}
spin_lock_irqsave (&kcov->lock, kcov_flags);
switch (cmd) {
case KCOV_ENABLE:
//...
default:
//...
}
spin_unlock_irqrestore(&kcov->lock, kcov_flags);


On Tue, Dec 21, 2021 at 9:19 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 21 Dec 2021 at 18:04, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Currently all ioctls are de facto processed under a spin lock in order
> > to serialise them. This, however, prohibits the use of vmalloc and other
> > memory management functions in the implementation of those ioctls,
> > unnecessary complicating any further changes.
> >
> > Let all ioctls first be processed inside the kcov_ioctl_unlocked()
> > function which should execute the ones that are not compatible with
> > spinlock and pass control to kcov_ioctl_locked() for all other ones.
> >
> > Although it is still compatible with a spinlock, move KCOV_INIT_TRACE
> > handling to kcov_ioctl_unlocked(), so that its planned change is easier
> > to follow.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> > ---
> >  kernel/kcov.c | 64 +++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 39 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 36ca640c4f8e..5d87b4e0126f 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -564,31 +564,12 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> >                              unsigned long arg)
> >  {
> >         struct task_struct *t;
> > -       unsigned long size, unused;
> > +       unsigned long flags, unused;
> >         int mode, i;
> >         struct kcov_remote_arg *remote_arg;
> >         struct kcov_remote *remote;
> > -       unsigned long flags;
> >
> >         switch (cmd) {
> > -       case KCOV_INIT_TRACE:
> > -               /*
> > -                * Enable kcov in trace mode and setup buffer size.
> > -                * Must happen before anything else.
> > -                */
> > -               if (kcov->mode != KCOV_MODE_DISABLED)
> > -                       return -EBUSY;
> > -               /*
> > -                * Size must be at least 2 to hold current position and one PC.
> > -                * Later we allocate size * sizeof(unsigned long) memory,
> > -                * that must not overflow.
> > -                */
> > -               size = arg;
> > -               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> > -                       return -EINVAL;
> > -               kcov->size = size;
> > -               kcov->mode = KCOV_MODE_INIT;
> > -               return 0;
> >         case KCOV_ENABLE:
> >                 /*
> >                  * Enable coverage for the current task.
> > @@ -685,6 +666,43 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> >         }
> >  }
> >
> > +static int kcov_ioctl_unlocked(struct kcov *kcov, unsigned int cmd,
> > +                            unsigned long arg)
> > +{
> > +       unsigned long size, flags;
> > +       int res;
> > +
> > +       switch (cmd) {
> > +       case KCOV_INIT_TRACE:
> > +               /*
> > +                * Enable kcov in trace mode and setup buffer size.
> > +                * Must happen before anything else.
> > +                */
> > +               if (kcov->mode != KCOV_MODE_DISABLED)
> > +                       return -EBUSY;
> > +               /*
> > +                * Size must be at least 2 to hold current position and one PC.
> > +                * Later we allocate size * sizeof(unsigned long) memory,
> > +                * that must not overflow.
> > +                */
> > +               size = arg;
> > +               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> > +                       return -EINVAL;
> > +               kcov->size = size;
> > +               kcov->mode = KCOV_MODE_INIT;
> > +               return 0;
>
> This patch should be a non-functional change, but it is not.
>
> To do that, you'd have to add the locking around KCOV_INIT_TRACE here,
> and then do whatever else you're doing in patch 2/2.
>
> > +       default:
> > +               /*
> > +                * All other commands can be fully executed under a spin lock, so we
> > +                * obtain and release it here to simplify the code of kcov_ioctl_locked().
> > +                */
> > +               spin_lock_irqsave(&kcov->lock, flags);
> > +               res = kcov_ioctl_locked(kcov, cmd, arg);
> > +               spin_unlock_irqrestore(&kcov->lock, flags);
> > +               return res;
> > +       }
> > +}
> > +
> >  static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >  {
> >         struct kcov *kcov;
> > @@ -692,7 +710,6 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         struct kcov_remote_arg *remote_arg = NULL;
> >         unsigned int remote_num_handles;
> >         unsigned long remote_arg_size;
> > -       unsigned long flags;
> >
> >         if (cmd == KCOV_REMOTE_ENABLE) {
> >                 if (get_user(remote_num_handles, (unsigned __user *)(arg +
> > @@ -713,10 +730,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         }
> >
> >         kcov = filep->private_data;
> > -       spin_lock_irqsave(&kcov->lock, flags);
> > -       res = kcov_ioctl_locked(kcov, cmd, arg);
> > -       spin_unlock_irqrestore(&kcov->lock, flags);
> > -
> > +       res = kcov_ioctl_unlocked(kcov, cmd, arg);
>
> Also, I find that kcov_ioctl_unlocked() isn't a very descriptive name,
> since now we have both locked and unlocked variants. What is it
> actually doing?
>
> Perhaps kcov_ioctl_with_context()? Assuming that 'struct kcov' is some
> sort of context.
>
> >         kfree(remote_arg);
> >
> >         return res;
> > --
> > 2.34.1.307.g9b7440fafd-goog
> >
