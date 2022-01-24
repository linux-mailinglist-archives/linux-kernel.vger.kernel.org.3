Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C986049A820
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316448AbiAYC5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3414736AbiAYAtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:49:18 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17C2C019B2F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:33:24 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id a12so21446164iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5eAllqBOa11gWFD3bXB1J+EOSlOaRJV9IqmWOlMTeg=;
        b=mZ8GIjqKlbyGbHcWuckMtiS7gKOlMpKxC7hZWh/iO2P8cynLvAoygZ4nVcYXtWBqEK
         yXnvs78VRi2AVpaPxic3Da8Rdvbfk0Gx1Sl+D5bCKNzPYX+78J4PEekCs+WpCXRT1bIs
         h+IODWW4o5GikCt1BfBBe2rIQlJTQKGrc8VMUJDpNJAv7n6CV8h1MyxDmQi/ASPJNMle
         1p2uVxiI7o7pKJjwqSmOnpWhNlhLUTpkZB5gL/smlOMXFSknQVrOrJ10YgsUuVvGuUM/
         VNi0lSVQK7vwKLBjxoYszlTwCOg/2j4eYPunGo+J4/hejVB9jTybk4ygfXngVS11Br9C
         Cotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5eAllqBOa11gWFD3bXB1J+EOSlOaRJV9IqmWOlMTeg=;
        b=vfDC2A5SCJp084ONDUwHUddcC3NP3rBIawo5ZYiGyOUEYUpPj4Zf5lZj9F9bw2REBR
         fYT9dAgowH10/AqYSKXJhLNZtWgD4AvO1OjhPiNgau+RMxk2jPBWnQwkEbU19Yr8Io+2
         5aTz02JQKCPa58ifY1g/MyPhdQxUJQQe7rAYy1Jr4Mfw4I0HUyB+ZdSazjSDRIMaH2sV
         Ez9bgxNm4z2OGhD7v9qvouhQOecZGyLI5x5y3BNkD/HJg1wLQGpWAXP3Tpd7OnDFLqfo
         haH9Hns4DtzH/ffEqez8jctobHTyGLfzSdn5XJjUPbJv1jCS6ljSPm9Id3u2Y1da1dKx
         X/9A==
X-Gm-Message-State: AOAM530fF0kSUDJz4WTPm+zY+oUzPv4oXwMKIi4G/A81/mkTBl/BUDd+
        weg7eszGczGSfq2ZUQLJl/22MCVYSlZAZP4Bbbc=
X-Google-Smtp-Source: ABdhPJxFbA6Zq1Z8vTr0k3ZuhPjH509Th+YwDuK9pA2VuP/4E7BwpA+rY/FzE1UmjoTYxecGQGo6baHiZ/LXBf5dHxo=
X-Received: by 2002:a02:bb98:: with SMTP id g24mr8335227jan.22.1643063604155;
 Mon, 24 Jan 2022 14:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com> <20220117153634.150357-2-nogikh@google.com>
In-Reply-To: <20220117153634.150357-2-nogikh@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 24 Jan 2022 23:33:13 +0100
Message-ID: <CA+fCnZdO+oOLQSfH=+H8wKNv1+hYasyyyNHxumWa5ex1P0xp0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kcov: split ioctl handling into locked and
 unlocked parts
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

.On Mon, Jan 17, 2022 at 4:36 PM Aleksandr Nogikh <nogikh@google.com> wrote:
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

Arguably, we could keep the part of the KCOV_INIT_TRACE handler that
happens under the lock in kcov_ioctl_locked(). In a similar way as
it's done for KCOV_REMOTE_ENABLE. This would get rid of the asymmetric
fallthrough usage.

But I'll leave this up to you, either way looks acceptable to me.

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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
