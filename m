Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC25647C4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhLURF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhLURF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:05:57 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C942C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:05:57 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r2so10691761ilb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pf9Q/hl+uiiucU7OfdQapd310FBBGphvRuGQ17j7ZWE=;
        b=XJURkKA6OUJqABlSxxzEGgpGdowH+cKcY+EAwVpkVWmlgTtOlFJcU1qaiZnUWwrezT
         OKsAkj9q+xQZX+RhNuneKRL7xdrQTB7ooS3fnHOHUzQc8Nwm0dygP+oCNh9wRQZR2dmS
         ohOxC4Ud99Et0yPh/cSzf/ObnLR5gQ/7I7EKmLHoWjJa9N0GTFbmGpGu/oS/tCmmXnZY
         XRdLOktIM5s9HstHswhJiCb+RFBe/BFpwrvO4HSS5G4WminAFPwunqK2HBSdHyCsCAcR
         DY72XqpgtKGzn+eRk6blhdX6+ZkRtxyxJfncQ4atrpYRp9Ci69AIA5hYDFbDNMKFnxjt
         7U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf9Q/hl+uiiucU7OfdQapd310FBBGphvRuGQ17j7ZWE=;
        b=DuaMXPPGc2gdd5MVa9ZEBfuxthYVcgW/jmm6sEjD52lQTTF2+A04SSPMQZtXrG86cu
         5DGFLmPECYVuqslfEUWEmzc2dkn5kcrBeRD0oJA+vGVALGNgBueFjI/jRShy04XEu5bZ
         8rvKZOZC1guz2XXOBy67o/yTHvPvk6OOI/mqPHuj8j4Wb4monp9dvCMCIPMz826kY31/
         T2OBcn40GIinm14QFx47VcIHQ53u46t7zeL7xUiNXWaOYaiyBX7ioelSEqYUmYBTR8ne
         bHRrK26cji9YlHwgbKgAstdTiH4x+MktzV5p3sgPJk9bkSP+VaqzGgWSkNhjUNgMDjpM
         taGw==
X-Gm-Message-State: AOAM533RpKHs6b+p5w5XDVP0zhck55Mn6pu/TeMx5E6m7FZ8kkLCwt2H
        23yPiFvrcB1/PEG2LofBi2KVnfTr9cjysCc5KoAEyA==
X-Google-Smtp-Source: ABdhPJziCtfXsv/EZM+mF7gwCFwW4oe26PGcxYNWq5OmQUVM5baDTxuBQ/WWY/yLiCGwRN4E79vfCNMnqO8y2C7mCFE=
X-Received: by 2002:a92:d18e:: with SMTP id z14mr984879ilz.245.1640106356791;
 Tue, 21 Dec 2021 09:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20211220152153.910990-1-nogikh@google.com> <CA+fCnZePxPCpZcXv+Cj04ZFbNfF8DOikX_EN1bDt_psSpNrKSA@mail.gmail.com>
In-Reply-To: <CA+fCnZePxPCpZcXv+Cj04ZFbNfF8DOikX_EN1bDt_psSpNrKSA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 21 Dec 2021 18:05:45 +0100
Message-ID: <CANp29Y4R1o5+9_ATPFZuvX5qyJM46BVSapLEY8sb_r3oWRs95Q@mail.gmail.com>
Subject: Re: [PATCH] kcov: properly handle subsequent mmap calls
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

Hi Andrey,

Thank you very much for commenting!

I've prepared and sent the v2 of the series:
https://lkml.org/lkml/2021/12/21/737

--
Best Regards,
Aleksandr

On Mon, Dec 20, 2021 at 4:59 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Dec 20, 2021 at 4:22 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Subsequent mmaps of the same kcov descriptor currently do not update the
> > virtual memory of the task and yet return 0 (success). This is
> > counter-intuitive and may lead to unexpected memory access errors.
> >
> > Also, this unnecessarily limits the functionality of kcov to only the
> > simplest usage scenarios. Kcov instances are effectively forever attached
> > to their first address spaces and it becomes impossible to e.g. reuse the
> > same kcov handle in forked child processes without mmapping the memory
> > first. This is exactly what we tried to do in syzkaller and
> > inadvertently came upon this problem.
> >
> > Allocate the buffer during KCOV_MODE_INIT in order to untie mmap and
> > coverage collection. Modify kcov_mmap, so that it can be reliably used
> > any number of times once KCOV_MODE_INIT has succeeded.
> >
> > Refactor ioctl processing so that a vmalloc could be executed before the
> > spin lock is obtained.
> >
> > These changes to the user-facing interface of the tool only weaken the
> > preconditions, so all existing user space code should remain compatible
> > with the new version.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
>
> Hi Aleksandr,
>
> > ---
> >  kernel/kcov.c | 94 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 53 insertions(+), 41 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 36ca640c4f8e..49e1fa2b330f 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -459,37 +459,28 @@ void kcov_task_exit(struct task_struct *t)
> >  static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> >  {
> >         int res = 0;
> > -       void *area;
> >         struct kcov *kcov = vma->vm_file->private_data;
> >         unsigned long size, off;
> >         struct page *page;
> >         unsigned long flags;
> >
> > -       area = vmalloc_user(vma->vm_end - vma->vm_start);
> > -       if (!area)
> > -               return -ENOMEM;
> > -
> >         spin_lock_irqsave(&kcov->lock, flags);
> >         size = kcov->size * sizeof(unsigned long);
> > -       if (kcov->mode != KCOV_MODE_INIT || vma->vm_pgoff != 0 ||
> > +       if (kcov->area == NULL || vma->vm_pgoff != 0 ||
> >             vma->vm_end - vma->vm_start != size) {
> >                 res = -EINVAL;
> >                 goto exit;
> >         }
> > -       if (!kcov->area) {
> > -               kcov->area = area;
> > -               vma->vm_flags |= VM_DONTEXPAND;
> > -               spin_unlock_irqrestore(&kcov->lock, flags);
> > -               for (off = 0; off < size; off += PAGE_SIZE) {
> > -                       page = vmalloc_to_page(kcov->area + off);
> > -                       if (vm_insert_page(vma, vma->vm_start + off, page))
> > -                               WARN_ONCE(1, "vm_insert_page() failed");
> > -               }
> > -               return 0;
> > +       spin_unlock_irqrestore(&kcov->lock, flags);
> > +       vma->vm_flags |= VM_DONTEXPAND;
> > +       for (off = 0; off < size; off += PAGE_SIZE) {
> > +               page = vmalloc_to_page(kcov->area + off);
> > +               if (vm_insert_page(vma, vma->vm_start + off, page))
> > +                       WARN_ONCE(1, "vm_insert_page() failed");
> >         }
> > +       return 0;
> >  exit:
> >         spin_unlock_irqrestore(&kcov->lock, flags);
> > -       vfree(area);
> >         return res;
> >  }
> >
> > @@ -564,31 +555,13 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> >                              unsigned long arg)
> >  {
> >         struct task_struct *t;
> > -       unsigned long size, unused;
> > +       unsigned long unused;
> >         int mode, i;
> >         struct kcov_remote_arg *remote_arg;
> >         struct kcov_remote *remote;
> >         unsigned long flags;
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
> > @@ -685,6 +658,49 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> >         }
> >  }
> >
> > +static int kcov_ioctl_unlocked(struct kcov *kcov, unsigned int cmd,
> > +                            unsigned long arg)
> > +{
> > +       unsigned long size, flags;
> > +       void *area;
> > +       int res;
> > +
> > +       switch (cmd) {
> > +       case KCOV_INIT_TRACE:
> > +               /*
> > +                * Enable kcov in trace mode and setup buffer size.
> > +                * Must happen before anything else.
> > +                *
> > +                *
>
> Accidental extra lines?
>
> > +                * Size must be at least 2 to hold current position and one PC.
> > +                */
> > +               size = arg;
> > +               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> > +                       return -EINVAL;
> > +
> > +               area = vmalloc_user(size * sizeof(unsigned long));
> > +               if (area == NULL)
> > +                       return -ENOMEM;
> > +
> > +               spin_lock_irqsave(&kcov->lock, flags);
> > +               if (kcov->mode != KCOV_MODE_DISABLED) {
> > +                       spin_unlock_irqrestore(&kcov->lock, flags);
> > +                       vfree(area);
> > +                       return -EBUSY;
> > +               }
> > +               kcov->area = area;
> > +               kcov->size = size;
> > +               kcov->mode = KCOV_MODE_INIT;
> > +               spin_unlock_irqrestore(&kcov->lock, flags);
> > +               return 0;
> > +       default:
>
> I would add a clarifying comment here saying something like:
>
> /* All other commands are handled by kcov_ioctl_locked(). */
>
> > +               spin_lock_irqsave(&kcov->lock, flags);
> > +               res = kcov_ioctl_locked(kcov, cmd, arg);
> > +               spin_unlock_irqrestore(&kcov->lock, flags);
> > +               return res;
> > +       }
> > +}
>
> Please split this change into two patches:
>
> 1. Add kcov_ioctl_unlocked() that handles KCOV_INIT_TRACE special case
> without any functional changes.
> 2. Functional changes to kcov_ioctl_unlocked() and other parts of code.
>
> Otherwise reviewing is a bit hard.
>
> > +
> >  static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >  {
> >         struct kcov *kcov;
> > @@ -692,7 +708,6 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         struct kcov_remote_arg *remote_arg = NULL;
> >         unsigned int remote_num_handles;
> >         unsigned long remote_arg_size;
> > -       unsigned long flags;
> >
> >         if (cmd == KCOV_REMOTE_ENABLE) {
> >                 if (get_user(remote_num_handles, (unsigned __user *)(arg +
> > @@ -713,10 +728,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         }
> >
> >         kcov = filep->private_data;
> > -       spin_lock_irqsave(&kcov->lock, flags);
> > -       res = kcov_ioctl_locked(kcov, cmd, arg);
> > -       spin_unlock_irqrestore(&kcov->lock, flags);
> > -
> > +       res = kcov_ioctl_unlocked(kcov, cmd, arg);
> >         kfree(remote_arg);
> >
> >         return res;
> > --
> > 2.34.1.173.g76aa8bc2d0-goog
> >
>
> Thanks!
