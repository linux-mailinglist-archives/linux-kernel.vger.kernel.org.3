Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3D491FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbiARHCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiARHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:02:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E84FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:02:35 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w188so27040932oiw.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OU1bIi6zrErACRNMAd72qpHOpezdoqwFxeDmsExWnOE=;
        b=kkmxCxwDQaG4RON/cajzvr/uX288DOol0mT/yQjYT0yPGxjc2vMjpyL1wurTUpQJTL
         trMjZSpdOn9rZk4lbc6JouAn6atD+j37B8ue4n15rO2GUDe0nACWNz642bqAHySZAp0o
         LYYYTSHKOsdCoTcQCW7fvAD4MHbWAiGppm3iQ9mjq15C8u1Ws1AM1nCk+YOxtlwj0QuX
         H5Oicds2/tVqmzZOG7IRKDqkJ/2wsXXKsWwiJ9rTlaJ+zU5l6ztXXiuY3uBoAjcmM1iE
         dg1o/Hn+Wq+0s9K9KoIDID+EaiSvnE/uFsgsL3iHl/OOAHjs7WAdQPdqfxhdxY9SZBMT
         M9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OU1bIi6zrErACRNMAd72qpHOpezdoqwFxeDmsExWnOE=;
        b=gt+MqcnTIoe0n2alTRDi1AS/Y4aQnn6N1KcczE9bO+/EbsSWpU8pjqTN7Ue8nfGB5t
         4/aHPaulHP5e0qzsdA6YJPo2bJdIr9OwTukephumu7w5TQMfkaEPd0Rh8PDg0FcMWGmZ
         pJBl4hZoAZ6vuAabCp9mmKBmdMXVUu8alslxOeq3tO0q8lfDNqCYspiDb+rqFZ/9ygB+
         lgJhXoqslQh4S5awyY0jgtvw1lFQ1lTA/2FK+ZazWReg82FaadSfXxeXYjbJyKgO0W7X
         uBtGfbyZ0AfP08g1QP5+CH+oCrMlRfpRrvO0KWQIMC+mhOXsa26AJIy2onsU6Lo/7VOz
         PX2Q==
X-Gm-Message-State: AOAM533o7po4PBoWGzkJzAXu2bNEly4wg3mb9ZqAuEiVyuRsFnybE0ht
        vG6K/bmtbypTcWQycDP5LHZUfFCn0rSpB70uIQrnNGVVqe8=
X-Google-Smtp-Source: ABdhPJwlGKOH2gLSSGFWUpO/rDK7EwTYtu65AMOPkeRWTTzkKdMI6vYgHFmF/+cIPltYEaGCxHcGXo5ZcAQdYQ3a8h8=
X-Received: by 2002:aca:abc1:: with SMTP id u184mr14344282oie.109.1642489354590;
 Mon, 17 Jan 2022 23:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com> <20220117153634.150357-2-nogikh@google.com>
In-Reply-To: <20220117153634.150357-2-nogikh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Jan 2022 08:02:23 +0100
Message-ID: <CACT4Y+btn2qz-Q22LyWeT6hq2NLwToOXyD96K-MKfjyB3ukDFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kcov: split ioctl handling into locked and
 unlocked parts
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 at 16:36, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> Currently all ioctls are de facto processed under a spinlock in order
> to serialise them. This, however, prohibits the use of vmalloc and other
> memory management functions in the implementations of those ioctls,
> unnecessary complicating any further changes to the code.
>
> Let all ioctls first be processed inside the kcov_ioctl() function
> which should execute the ones that are not compatible with spinlock
> and then pass control to kcov_ioctl_locked() for all other ones.
> KCOV_REMOTE_ENABLE is processed both in kcov_ioctl() and
> kcov_ioctl_locked() as the steps are easily separable.
>
> Although it is still compatible with a spinlock, move KCOV_INIT_TRACE
> handling to kcov_ioctl(), so that the changes from the next commit are
> easier to follow.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 68 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 36ca640c4f8e..e1be7301500b 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -564,31 +564,12 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                              unsigned long arg)
>  {
>         struct task_struct *t;
> -       unsigned long size, unused;
> +       unsigned long flags, unused;
>         int mode, i;
>         struct kcov_remote_arg *remote_arg;
>         struct kcov_remote *remote;
> -       unsigned long flags;
>
>         switch (cmd) {
> -       case KCOV_INIT_TRACE:
> -               /*
> -                * Enable kcov in trace mode and setup buffer size.
> -                * Must happen before anything else.
> -                */
> -               if (kcov->mode != KCOV_MODE_DISABLED)
> -                       return -EBUSY;
> -               /*
> -                * Size must be at least 2 to hold current position and one PC.
> -                * Later we allocate size * sizeof(unsigned long) memory,
> -                * that must not overflow.
> -                */
> -               size = arg;
> -               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> -                       return -EINVAL;
> -               kcov->size = size;
> -               kcov->mode = KCOV_MODE_INIT;
> -               return 0;
>         case KCOV_ENABLE:
>                 /*
>                  * Enable coverage for the current task.
> @@ -692,9 +673,32 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>         struct kcov_remote_arg *remote_arg = NULL;
>         unsigned int remote_num_handles;
>         unsigned long remote_arg_size;
> -       unsigned long flags;
> +       unsigned long size, flags;
>
> -       if (cmd == KCOV_REMOTE_ENABLE) {
> +       kcov = filep->private_data;
> +       switch (cmd) {
> +       case KCOV_INIT_TRACE:
> +               /*
> +                * Enable kcov in trace mode and setup buffer size.
> +                * Must happen before anything else.
> +                *
> +                * First check the size argument - it must be at least 2
> +                * to hold the current position and one PC. Later we allocate
> +                * size * sizeof(unsigned long) memory, that must not overflow.
> +                */
> +               size = arg;
> +               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> +                       return -EINVAL;
> +               spin_lock_irqsave(&kcov->lock, flags);
> +               if (kcov->mode != KCOV_MODE_DISABLED) {
> +                       spin_unlock_irqrestore(&kcov->lock, flags);
> +                       return -EBUSY;
> +               }
> +               kcov->size = size;
> +               kcov->mode = KCOV_MODE_INIT;
> +               spin_unlock_irqrestore(&kcov->lock, flags);
> +               return 0;
> +       case KCOV_REMOTE_ENABLE:
>                 if (get_user(remote_num_handles, (unsigned __user *)(arg +
>                                 offsetof(struct kcov_remote_arg, num_handles))))
>                         return -EFAULT;
> @@ -710,16 +714,18 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>                         return -EINVAL;
>                 }
>                 arg = (unsigned long)remote_arg;
> +               fallthrough;
> +       default:
> +               /*
> +                * All other commands can be normally executed under a spin lock, so we
> +                * obtain and release it here in order to simplify kcov_ioctl_locked().
> +                */
> +               spin_lock_irqsave(&kcov->lock, flags);
> +               res = kcov_ioctl_locked(kcov, cmd, arg);
> +               spin_unlock_irqrestore(&kcov->lock, flags);
> +               kfree(remote_arg);
> +               return res;
>         }
> -
> -       kcov = filep->private_data;
> -       spin_lock_irqsave(&kcov->lock, flags);
> -       res = kcov_ioctl_locked(kcov, cmd, arg);
> -       spin_unlock_irqrestore(&kcov->lock, flags);
> -
> -       kfree(remote_arg);
> -
> -       return res;
>  }
>
>  static const struct file_operations kcov_fops = {
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
