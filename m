Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0249A821
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316474AbiAYC5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3414758AbiAYAtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:49:25 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7821C019B3F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:33:34 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e79so21417881iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgcWWoipX9AEgl7WxsfTrdOoQ6j1cPPjeKFCSVhOPgs=;
        b=Vj6YY87HCxZDs5pBmz1/Dft9TANUalCCRkfdUr2BxlhQSqmTG17dMpcl/r7f7CJ6+K
         Wi3OIBr0nhW81qjVm1kNqyS26/IHk1uNa6s2+lqERHdviNWx822R8LxGpCI0C7bv84Zj
         W7eK66lLZqzQqGocTrjUXfXDHJ8eDLkXlq2z5AHdHMGdHOcu9SlZ9xb4/gUWqOTnvUA3
         BaleY0jlD2v/SoXysCK7zY9j972RNGWM4dq+Mq4ftDWl1b+1qae31tcRl9h0QDEsTapK
         uFkYCSa9ca378ruYnd6h3v+C7lnRRjvPrcHROKnel3BwL8reMkavy/FKTKG3//c7iCg9
         gIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgcWWoipX9AEgl7WxsfTrdOoQ6j1cPPjeKFCSVhOPgs=;
        b=syE5BQ3d3swX72PIGAEBY0XOOIpXthQ+1og3wXYn9oLZnvny7ytnwbZ3ao+rhGZopM
         Cb+qxqTq7stUDYq2j9yyo2JQ9SjYypzOI0C/8AD+C2a+PbNzu/lNzAeGa4ptlB2Z3wqq
         ClXWOmGn9adBBFYOCRBg4l1FMiXLPQugVozBsxuTQ1TF6c9mwLYJfdSXtap7wIAjgVhQ
         T96th0AMqh3UVNKgdTAe7I19GlnIPIeDTq+kOwOlGbnmek8DtIY1keFRwjk+gEq88o3R
         mkL1Ivm1zzLjYYfyrJ+yCkWZuXbPCOhaKb2H+n0GcGhAaCoQcoQwT6mahotIwyOWKClF
         3rQg==
X-Gm-Message-State: AOAM530XUP8kh9gbzRcjf2IClhKd3frHciEMB+9OTs2idgjX8Ny5uIlG
        mYsEg0uNsjoadBk0OEu7/hUmfK7DaM3f7fyw28E=
X-Google-Smtp-Source: ABdhPJzrMzDeTEX/8ExPj5G5q+swZsIgUK6dW7wJbr/SA/Q3Be3RqOaILZTv+Re/VGjMuhg5lewyKVCj1zw4hCuR/yo=
X-Received: by 2002:a02:c80a:: with SMTP id p10mr2768417jao.218.1643063614305;
 Mon, 24 Jan 2022 14:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com> <20220117153634.150357-3-nogikh@google.com>
In-Reply-To: <20220117153634.150357-3-nogikh@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 24 Jan 2022 23:33:23 +0100
Message-ID: <CA+fCnZdUJS=qcTKews9XEgZi8=u5=iHPkDh1MaZryKL45vOKDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kcov: properly handle subsequent mmap calls
To:     Aleksandr Nogikh <nogikh@google.com>
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

On Mon, Jan 17, 2022 at 4:37 PM Aleksandr Nogikh <nogikh@google.com> wrote:
>
> Allocate the kcov buffer during KCOV_MODE_INIT in order to untie mmapping
> of a kcov instance and the actual coverage collection process. Modify
> kcov_mmap, so that it can be reliably used any number of times once
> KCOV_MODE_INIT has succeeded.
>
> These changes to the user-facing interface of the tool only weaken the
> preconditions, so all existing user space code should remain compatible
> with the new version.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> ---
>  kernel/kcov.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index e1be7301500b..475524bd900a 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -459,37 +459,28 @@ void kcov_task_exit(struct task_struct *t)
>  static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>  {
>         int res = 0;
> -       void *area;
>         struct kcov *kcov = vma->vm_file->private_data;
>         unsigned long size, off;
>         struct page *page;
>         unsigned long flags;
>
> -       area = vmalloc_user(vma->vm_end - vma->vm_start);
> -       if (!area)
> -               return -ENOMEM;
> -
>         spin_lock_irqsave(&kcov->lock, flags);
>         size = kcov->size * sizeof(unsigned long);
> -       if (kcov->mode != KCOV_MODE_INIT || vma->vm_pgoff != 0 ||
> +       if (kcov->area == NULL || vma->vm_pgoff != 0 ||
>             vma->vm_end - vma->vm_start != size) {
>                 res = -EINVAL;
>                 goto exit;
>         }
> -       if (!kcov->area) {
> -               kcov->area = area;
> -               vma->vm_flags |= VM_DONTEXPAND;
> -               spin_unlock_irqrestore(&kcov->lock, flags);
> -               for (off = 0; off < size; off += PAGE_SIZE) {
> -                       page = vmalloc_to_page(kcov->area + off);
> -                       if (vm_insert_page(vma, vma->vm_start + off, page))
> -                               WARN_ONCE(1, "vm_insert_page() failed");
> -               }
> -               return 0;
> +       spin_unlock_irqrestore(&kcov->lock, flags);
> +       vma->vm_flags |= VM_DONTEXPAND;
> +       for (off = 0; off < size; off += PAGE_SIZE) {
> +               page = vmalloc_to_page(kcov->area + off);

Hm, you're accessing kcov->area without the lock here. Although, the
old code does this as well. This is probably OK, as kcov->area can't
be changed nor freed while this handler is executing.


> +               if (vm_insert_page(vma, vma->vm_start + off, page))
> +                       WARN_ONCE(1, "vm_insert_page() failed");
>         }
> +       return 0;
>  exit:
>         spin_unlock_irqrestore(&kcov->lock, flags);
> -       vfree(area);
>         return res;
>  }
>
> @@ -674,6 +665,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>         unsigned int remote_num_handles;
>         unsigned long remote_arg_size;
>         unsigned long size, flags;
> +       void *area;
>
>         kcov = filep->private_data;
>         switch (cmd) {
> @@ -683,17 +675,21 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>                  * Must happen before anything else.
>                  *
>                  * First check the size argument - it must be at least 2
> -                * to hold the current position and one PC. Later we allocate
> -                * size * sizeof(unsigned long) memory, that must not overflow.
> +                * to hold the current position and one PC.
>                  */
>                 size = arg;
>                 if (size < 2 || size > INT_MAX / sizeof(unsigned long))
>                         return -EINVAL;
> +               area = vmalloc_user(size * sizeof(unsigned long));
> +               if (area == NULL)
> +                       return -ENOMEM;
>                 spin_lock_irqsave(&kcov->lock, flags);
>                 if (kcov->mode != KCOV_MODE_DISABLED) {
>                         spin_unlock_irqrestore(&kcov->lock, flags);
> +                       vfree(area);
>                         return -EBUSY;
>                 }
> +               kcov->area = area;
>                 kcov->size = size;
>                 kcov->mode = KCOV_MODE_INIT;
>                 spin_unlock_irqrestore(&kcov->lock, flags);
> --
> 2.34.1.703.g22d0c6ccf7-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
