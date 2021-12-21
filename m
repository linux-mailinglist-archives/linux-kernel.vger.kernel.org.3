Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0F647C82E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhLUUTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhLUUTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:19:53 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED45C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:19:53 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t19so555920oij.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9LWWkXvMjCHJdkHQwVy+G2bXdZtAb8HFnc0qRd88BI=;
        b=hFET+5vcMNd615mcfJN7vFVMzrAXrTBawKighOZWDAmZlfxYXZWeszwGNB/yz7FFCe
         IxEGOOYPfZA8OfCbqKt1sI2lPQpTcmVbDcVfD1xYMaemj2VJOJRlQCpHGt/1pqQlOdRA
         um/hYeebSTwgjtCxCbtCJj9oBtP4M2VfbBP/PBphE9xmGkcQh8KOODlG2n7/a9bwfxqM
         M8xAwq52kye29VGU/NNHBuuPjg1u5FzCR4lXFX7weXAWbNP8xGMweWYnCTIVsDUbx7al
         YhajkgSvcUE+PsIbN2qGCwESdkKRyfLQt4ThOdGEiy2ruxZ0Ef+KseU33hmKDgrdAzfL
         PnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9LWWkXvMjCHJdkHQwVy+G2bXdZtAb8HFnc0qRd88BI=;
        b=2CHZPSkvrKrR+uqcyY9spOV7CLJqJ82TTXK+2Zc9UDhgeRI4AcvNzk/9x1mDelSPev
         es9LFPCnKh0UJTDVb9snE+ZIzcvDwTb/tsA7VJsIfJCDy0hB68RrHSel1Sftzvmq0BN/
         2kQcbuLOW+i1b8ImK1qGggqDMCivz3kwjPJP1DdBZjVrD7aIi2zH6DQj662baIZtD9Eb
         V/M1wm2SyeFVtGe984zhrtDZW5vLAM3shJjcw90C2poR8RVZN4jvVxthLMgBMXjP2a7O
         BTUOIy8OBwUJ0i3zbLdNY4+PoKgYAXCHO6aWWrSsEnj06dpHHpFw2ZpxVwWRtMM2+4lG
         tqlQ==
X-Gm-Message-State: AOAM531wueD7BgqrxHrah5hKIvnY8JOXtQoNWFGjE3QNns7qeto9wZOg
        Q5HRFDEVjFytC/7KnOym93YvZWP0xr76qkdT2OwNww==
X-Google-Smtp-Source: ABdhPJz4gEkYkVaiar7dW4USt98pbhc8tXG55zKbfu8xtSrolCnLAw3wWkIaoUD2rKs1OvfWaDtGu59cunZx3ne0h8M=
X-Received: by 2002:aca:6245:: with SMTP id w66mr90879oib.134.1640117992657;
 Tue, 21 Dec 2021 12:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20211221170348.1113266-1-nogikh@google.com> <20211221170348.1113266-2-nogikh@google.com>
In-Reply-To: <20211221170348.1113266-2-nogikh@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Dec 2021 21:19:41 +0100
Message-ID: <CANpmjNMAWuE0Y20ZuBUSRXkvWZd8NC1d=DDYYrEZytJz9ndxeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kcov: split ioctl handling into locked and
 unlocked parts
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, dvyukov@google.com,
        andreyknvl@gmail.com, glider@google.com, tarasmadan@google.com,
        bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 at 18:04, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> Currently all ioctls are de facto processed under a spin lock in order
> to serialise them. This, however, prohibits the use of vmalloc and other
> memory management functions in the implementation of those ioctls,
> unnecessary complicating any further changes.
>
> Let all ioctls first be processed inside the kcov_ioctl_unlocked()
> function which should execute the ones that are not compatible with
> spinlock and pass control to kcov_ioctl_locked() for all other ones.
>
> Although it is still compatible with a spinlock, move KCOV_INIT_TRACE
> handling to kcov_ioctl_unlocked(), so that its planned change is easier
> to follow.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> ---
>  kernel/kcov.c | 64 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 36ca640c4f8e..5d87b4e0126f 100644
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
> @@ -685,6 +666,43 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>         }
>  }
>
> +static int kcov_ioctl_unlocked(struct kcov *kcov, unsigned int cmd,
> +                            unsigned long arg)
> +{
> +       unsigned long size, flags;
> +       int res;
> +
> +       switch (cmd) {
> +       case KCOV_INIT_TRACE:
> +               /*
> +                * Enable kcov in trace mode and setup buffer size.
> +                * Must happen before anything else.
> +                */
> +               if (kcov->mode != KCOV_MODE_DISABLED)
> +                       return -EBUSY;
> +               /*
> +                * Size must be at least 2 to hold current position and one PC.
> +                * Later we allocate size * sizeof(unsigned long) memory,
> +                * that must not overflow.
> +                */
> +               size = arg;
> +               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> +                       return -EINVAL;
> +               kcov->size = size;
> +               kcov->mode = KCOV_MODE_INIT;
> +               return 0;

This patch should be a non-functional change, but it is not.

To do that, you'd have to add the locking around KCOV_INIT_TRACE here,
and then do whatever else you're doing in patch 2/2.

> +       default:
> +               /*
> +                * All other commands can be fully executed under a spin lock, so we
> +                * obtain and release it here to simplify the code of kcov_ioctl_locked().
> +                */
> +               spin_lock_irqsave(&kcov->lock, flags);
> +               res = kcov_ioctl_locked(kcov, cmd, arg);
> +               spin_unlock_irqrestore(&kcov->lock, flags);
> +               return res;
> +       }
> +}
> +
>  static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  {
>         struct kcov *kcov;
> @@ -692,7 +710,6 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>         struct kcov_remote_arg *remote_arg = NULL;
>         unsigned int remote_num_handles;
>         unsigned long remote_arg_size;
> -       unsigned long flags;
>
>         if (cmd == KCOV_REMOTE_ENABLE) {
>                 if (get_user(remote_num_handles, (unsigned __user *)(arg +
> @@ -713,10 +730,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>         }
>
>         kcov = filep->private_data;
> -       spin_lock_irqsave(&kcov->lock, flags);
> -       res = kcov_ioctl_locked(kcov, cmd, arg);
> -       spin_unlock_irqrestore(&kcov->lock, flags);
> -
> +       res = kcov_ioctl_unlocked(kcov, cmd, arg);

Also, I find that kcov_ioctl_unlocked() isn't a very descriptive name,
since now we have both locked and unlocked variants. What is it
actually doing?

Perhaps kcov_ioctl_with_context()? Assuming that 'struct kcov' is some
sort of context.

>         kfree(remote_arg);
>
>         return res;
> --
> 2.34.1.307.g9b7440fafd-goog
>
