Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABD49D129
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbiAZRxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiAZRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:53:23 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13870C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:53:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i62so549739ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtNWMQ6fpndr+gNiN9rmzbRxHIN+CmzsS5NgAG+zOwA=;
        b=i9L6HTFH0RzfL1MnEtWCmlZgz8GFemI7ANzKOhYuyL0PplBZMoW2+uaNffMIMLlltn
         y74aRoiBZRwVCVMYe+ImOOD5aQ71vPznZDqYH+fzXvJvrtRESpGW/5sws2Uj3ne+x3vo
         UuHhdgSh4xipWa89YtS4my+NYZfD9K2PUBnXMEi8Ye99cUeLN8jcuowgZo/clJ7jy265
         n1FblY13Mne/s+Xzw4wgKOL1KJiREIiOAZFAuo3qGqN6sL0aoEkys5t2z2JQBin47oBq
         +/radoLZwH43RjnllUnzsNoLruruy8e1lHWcAGFLW/N3MxjFx9oz5LbRAiug6rfvALh8
         K3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtNWMQ6fpndr+gNiN9rmzbRxHIN+CmzsS5NgAG+zOwA=;
        b=woR6KzobkxbfemJYLO3mFk8HEVnXjisLSuAytJgabGWohqCE/VWyEnXROFaDVFZs69
         qreaVlHdUoL8oZ+gH/fZiGQpOgbvpB/rbZdd6jlbQ+ewDq1mZsw82cD5RwqK5kNX/i4k
         kdUlbialbFBcZj783iZMU0x9OVkTdHiet04CM0JUaXPEch3y7zmlsnGUnDxr1N1k1Ct1
         eOWEZEkfsL3kBh8JivC8/iFz4zfHp9RX5cSHGDFYqXz/SKeZnkFXeAuqZ+bKCCH1CfP2
         HELOxyce8dNRRxldUPE2ZX9s/sa0hvaFnySGU2Mpq2rqaBVO34YOG6frhf1Siyxn7ZZ+
         B2Uw==
X-Gm-Message-State: AOAM533/ZP1MZJAvWE5JxEhI1MylL8ojyjUS5X/D3bH9fCMi9AaC6uyY
        2RSnYadGAKryPZg60GL4kOZF3hAcboO829NnjmV+nZluXfPJBw==
X-Google-Smtp-Source: ABdhPJy6VWZhSvfgTuDchM38QgtUK0Sc6Gk/b8+Nk/fi7Y989zS5zwkairWLyjBOayWnvCAn0iKvg9KXuP7ro1Nyts0=
X-Received: by 2002:a02:9427:: with SMTP id a36mr11213152jai.259.1643219602187;
 Wed, 26 Jan 2022 09:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com> <20220117153634.150357-3-nogikh@google.com>
 <CA+fCnZdUJS=qcTKews9XEgZi8=u5=iHPkDh1MaZryKL45vOKDQ@mail.gmail.com>
In-Reply-To: <CA+fCnZdUJS=qcTKews9XEgZi8=u5=iHPkDh1MaZryKL45vOKDQ@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 26 Jan 2022 18:53:11 +0100
Message-ID: <CANp29Y63K326mhX8AVQ+w2PeccUsy9V8uvKO5iR-N6PqaaDUJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kcov: properly handle subsequent mmap calls
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

Thanks for reviewing the code!

Yes, it is safe to access kcov->area without a lock.
1) kcov->area is set only once since KCOV_INIT_TRACE will succeed only
once. Reason
for that is that kcov->mode is only set to KCOV_MODE_DISABLED during
kcov_open().
2) kcov->area won't be freed because an ongoing mmap operation for the
kcov fd won't let
the kernel invoke release() on that same fd, while that release() is
necessary to finally
decrement kcov->refcount.


On Mon, Jan 24, 2022 at 11:33 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Jan 17, 2022 at 4:37 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Allocate the kcov buffer during KCOV_MODE_INIT in order to untie mmapping
> > of a kcov instance and the actual coverage collection process. Modify
> > kcov_mmap, so that it can be reliably used any number of times once
> > KCOV_MODE_INIT has succeeded.
> >
> > These changes to the user-facing interface of the tool only weaken the
> > preconditions, so all existing user space code should remain compatible
> > with the new version.
> >
> > Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> > ---
> >  kernel/kcov.c | 34 +++++++++++++++-------------------
> >  1 file changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index e1be7301500b..475524bd900a 100644
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
>
> Hm, you're accessing kcov->area without the lock here. Although, the
> old code does this as well. This is probably OK, as kcov->area can't
> be changed nor freed while this handler is executing.
>
>
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
> > @@ -674,6 +665,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >         unsigned int remote_num_handles;
> >         unsigned long remote_arg_size;
> >         unsigned long size, flags;
> > +       void *area;
> >
> >         kcov = filep->private_data;
> >         switch (cmd) {
> > @@ -683,17 +675,21 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> >                  * Must happen before anything else.
> >                  *
> >                  * First check the size argument - it must be at least 2
> > -                * to hold the current position and one PC. Later we allocate
> > -                * size * sizeof(unsigned long) memory, that must not overflow.
> > +                * to hold the current position and one PC.
> >                  */
> >                 size = arg;
> >                 if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> >                         return -EINVAL;
> > +               area = vmalloc_user(size * sizeof(unsigned long));
> > +               if (area == NULL)
> > +                       return -ENOMEM;
> >                 spin_lock_irqsave(&kcov->lock, flags);
> >                 if (kcov->mode != KCOV_MODE_DISABLED) {
> >                         spin_unlock_irqrestore(&kcov->lock, flags);
> > +                       vfree(area);
> >                         return -EBUSY;
> >                 }
> > +               kcov->area = area;
> >                 kcov->size = size;
> >                 kcov->mode = KCOV_MODE_INIT;
> >                 spin_unlock_irqrestore(&kcov->lock, flags);
> > --
> > 2.34.1.703.g22d0c6ccf7-goog
> >
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
