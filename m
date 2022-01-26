Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6D49D178
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiAZSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiAZSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:11:35 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D84C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:11:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d3so381081ilr.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm/173MgUik8C/5SMcwN9zwaSmwUKvdrsn1QPcEg1Po=;
        b=n0bOA9FApTcwq4Zq7rh1JpATK3Keccrid1gI77sk/3s7YPw24jlcJUoVXqyfsFN9xh
         pmBqIG7x0kL+K39GSXqLxnA1NcHGKU4l6R771V93SWDYPoa3eZ215cZCMLt0VmCHC7HS
         W3EjeP9luJJodKvJoYROOfWSBrPAUlgzS08evvS6k1nYvV3rpF92KonN7kff9nYdFr3f
         nv4W1swUeHMMXEqv26Qm7k0kTG2I3NsAv4gphnLqyxiZoMN+9uEyzNIxqvTUaEQFyd/Y
         OI44FKofaa3X9mzs2rNvJ/9l6yrKcHPBjUI21GytzRKnVdaW2LjP+CyzsJ/LsDkgsg/1
         otPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm/173MgUik8C/5SMcwN9zwaSmwUKvdrsn1QPcEg1Po=;
        b=KkjjWa+FSEV38kb8PEx5W/MEHSZzH01KeoSRrBma4U2/lHGL/pWlS9Frxtg+NWxPsP
         tE+BFguNaKsly5TmahT/MBmYVNx4JhvAjD7z2un+zTDIU11q2XXV6GmF8M+C2ahrxm8t
         tiBH5yGITR74eSUlpYbG/DRCYvLTiziUPqoFaEc+WuF7H2ElTgu+X1bVDA+04SSKp5yJ
         d6wNTwDqEuG581OYVrKOeCNYRw5fSC5pXPnUAG48ElweAKb8fsFP8pOgyJGB6mS9iDV1
         I7CWBX73pcDW5k30WgQqEO/qB2WLKfImi7ybtUqe8gRCENbS60zg0l2bN4OnBJxp7z1Y
         Ku2Q==
X-Gm-Message-State: AOAM531e85fZp6Nk8y2yk57IXiSBnz1vajPeJK4PSdkFoLVqvVPEgmX0
        MP0PoiLD+7tagW+cN/UrWt4kcuT3be4ZyU13HJ44TgDXuYdKrb0U
X-Google-Smtp-Source: ABdhPJz9obmQoVaz2wr8D17FKNpWnHiZvImabTIGmK3ZAxlK+BpnB5QFxxdwpvU+B7BKtK3/V/jui90u7GdazuP+zaw=
X-Received: by 2002:a92:b50e:: with SMTP id f14mr216291ile.208.1643220694380;
 Wed, 26 Jan 2022 10:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com> <20220117153634.150357-2-nogikh@google.com>
 <CA+fCnZdO+oOLQSfH=+H8wKNv1+hYasyyyNHxumWa5ex1P0xp0g@mail.gmail.com>
In-Reply-To: <CA+fCnZdO+oOLQSfH=+H8wKNv1+hYasyyyNHxumWa5ex1P0xp0g@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 26 Jan 2022 19:11:23 +0100
Message-ID: <CANp29Y6HkhHyM1PZGbMtD=U6GeK2LfOHTDiOqiPVEhEXUHN7_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kcov: split ioctl handling into locked and
 unlocked parts
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:33 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> .On Mon, Jan 17, 2022 at 4:36 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Currently all ioctls are de facto processed under a spinlock in order
> > to serialise them. This, however, prohibits the use of vmalloc and other
> > memory management functions in the implementations of those ioctls,
> > unnecessary complicating any further changes to the code.
> >
> > Let all ioctls first be processed inside the kcov_ioctl() function
> > which should execute the ones that are not compatible with spinlock
> > and then pass control to kcov_ioctl_locked() for all other ones.
> > KCOV_REMOTE_ENABLE is processed both in kcov_ioctl() and
> > kcov_ioctl_locked() as the steps are easily separable.
> >
> > Although it is still compatible with a spinlock, move KCOV_INIT_TRACE
> > handling to kcov_ioctl(), so that the changes from the next commit are
> > easier to follow.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> > ---
> >  kernel/kcov.c | 68 ++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 37 insertions(+), 31 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 36ca640c4f8e..e1be7301500b 100644
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
> > @@ -692,9 +673,32 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         struct kcov_remote_arg *remote_arg = NULL;
> >         unsigned int remote_num_handles;
> >         unsigned long remote_arg_size;
> > -       unsigned long flags;
> > +       unsigned long size, flags;
> >
> > -       if (cmd == KCOV_REMOTE_ENABLE) {
> > +       kcov = filep->private_data;
> > +       switch (cmd) {
> > +       case KCOV_INIT_TRACE:
> > +               /*
> > +                * Enable kcov in trace mode and setup buffer size.
> > +                * Must happen before anything else.
> > +                *
> > +                * First check the size argument - it must be at least 2
> > +                * to hold the current position and one PC. Later we allocate
> > +                * size * sizeof(unsigned long) memory, that must not overflow.
> > +                */
> > +               size = arg;
> > +               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> > +                       return -EINVAL;
> > +               spin_lock_irqsave(&kcov->lock, flags);
>
> Arguably, we could keep the part of the KCOV_INIT_TRACE handler that
> happens under the lock in kcov_ioctl_locked(). In a similar way as
> it's done for KCOV_REMOTE_ENABLE. This would get rid of the asymmetric
> fallthrough usage.
>
> But I'll leave this up to you, either way looks acceptable to me.
>

That would indeed look nice and would work with this particular
commit, but it won't work with the changes that are introduced in the
next one. So it would go against the objective of splitting the change
into a patch series in the first place - the simplification of
reviewing of the commit with functional changes.

With kcov->area allocation in KCOV_INIT_TRACE, we unfortunately cannot
draw a single line between the unlocked and locked parts.

> > +               if (kcov->mode != KCOV_MODE_DISABLED) {
> > +                       spin_unlock_irqrestore(&kcov->lock, flags);
> > +                       return -EBUSY;
> > +               }
> > +               kcov->size = size;
> > +               kcov->mode = KCOV_MODE_INIT;
> > +               spin_unlock_irqrestore(&kcov->lock, flags);
> > +               return 0;
> > +       case KCOV_REMOTE_ENABLE:
> >                 if (get_user(remote_num_handles, (unsigned __user *)(arg +
> >                                 offsetof(struct kcov_remote_arg, num_handles))))
> >                         return -EFAULT;
> > @@ -710,16 +714,18 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >                         return -EINVAL;
> >                 }
> >                 arg = (unsigned long)remote_arg;
> > +               fallthrough;
> > +       default:
> > +               /*
> > +                * All other commands can be normally executed under a spin lock, so we
> > +                * obtain and release it here in order to simplify kcov_ioctl_locked().
> > +                */
> > +               spin_lock_irqsave(&kcov->lock, flags);
> > +               res = kcov_ioctl_locked(kcov, cmd, arg);
> > +               spin_unlock_irqrestore(&kcov->lock, flags);
> > +               kfree(remote_arg);
> > +               return res;
> >         }
> > -
> > -       kcov = filep->private_data;
> > -       spin_lock_irqsave(&kcov->lock, flags);
> > -       res = kcov_ioctl_locked(kcov, cmd, arg);
> > -       spin_unlock_irqrestore(&kcov->lock, flags);
> > -
> > -       kfree(remote_arg);
> > -
> > -       return res;
> >  }
> >
> >  static const struct file_operations kcov_fops = {
> > --
> > 2.34.1.703.g22d0c6ccf7-goog
> >
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CA%2BfCnZdO%2BoOLQSfH%3D%2BH8wKNv1%2BhYasyyyNHxumWa5ex1P0xp0g%40mail.gmail.com.
