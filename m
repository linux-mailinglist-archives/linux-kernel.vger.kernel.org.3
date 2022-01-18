Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF936491FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbiARHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiARHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:02:47 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:02:47 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s127so27153808oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPb1J18pp2+JcNd7ly09xmW41XnMO+ZDAZ+Gr42WbPA=;
        b=BEvv2LoId0q1psMrnaBPEbi69YCVrafnMWIQkgEo36JbfOmZdeDAIjI4Wsk0ICPs3I
         6Xiuq1CU8K6+cdOeoanI9QdyaldD6XTu01vf156r7neCmifmMOfBP2rCyq6eSVk8dlFY
         hiqZaZpeA8v5K4gT38Y3FtP7ekz3G2cJos3YxvLG/0uNd7nSOIn0SHLXmLm8x+vvQpYB
         gXixEC9W/eoycAoEYGodw0rsHyzmoX/PSonlqKgJ+eJtrGflUfDhKX72lFiraAiZlVpY
         PJBaFwzFRJqScSVrp2DItVagBp5HYtTU1+Ue/SSCn/BYBIXoI+qNda2qFzuohVUvnBqS
         DeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPb1J18pp2+JcNd7ly09xmW41XnMO+ZDAZ+Gr42WbPA=;
        b=dX/tHOxWVOP6mep0m7UcXdq/uNCvJkzsH6C/sOtUbujIShztKJq7j3dV65NNcMF/9K
         BRABiVSsZUBDb+EyMzcq3zOny7dQBPqpgzvkmBxs71FD08Hn2ZyWnuE0rq1DgNxl+4uY
         Swl2wtT4CxpRRBe6/2nd9Qe/1VBvN/6Fj4RRM2VrKqkuwyOx6DuXYmALP20//trdRTa/
         6AmDgYYTKaMaEMwAMqsC7fmZIVuzdoo/weQjWuKuSd9feasby2dvDQaW1LQ0VuKpr6LN
         pU+GOHsKKEwmQZmuf4PmYRky5SrqwIDvKGYxAEHULUs+oUKw0FQtrq5cDh4Tc1jLgdic
         iE/w==
X-Gm-Message-State: AOAM53192PiNs5cxhEtc8ZMUG7HSa+S6IW2vqDzDexe7SZIXbpcAZVyT
        cvtn2sZ7KeXz6hS8zhLcGu7+OKf4/baY+uMU7rtALQ==
X-Google-Smtp-Source: ABdhPJzHV22p1KQ1SP0d1RnmVBfEkEve53cWJC+3hiIJweaX3P+zvTpN351z5i74zgWbLAGcTs3FLrVHdkt1arbi150=
X-Received: by 2002:a05:6808:290:: with SMTP id z16mr11273405oic.128.1642489366843;
 Mon, 17 Jan 2022 23:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com> <20220117153634.150357-3-nogikh@google.com>
In-Reply-To: <20220117153634.150357-3-nogikh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Jan 2022 08:02:35 +0100
Message-ID: <CACT4Y+bVMp26=aL3a1e_wccXwwNHwwy8-fmCienQ7hSmdmmw8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kcov: properly handle subsequent mmap calls
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 at 16:37, Aleksandr Nogikh <nogikh@google.com> wrote:
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

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

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
